Return-Path: <linux-kernel+bounces-4888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93D81835A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE33B2376D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15EF125BA;
	Tue, 19 Dec 2023 08:29:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AD125A8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SvVGY3VX9z1wp0D;
	Tue, 19 Dec 2023 16:29:09 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id EA9301A0192;
	Tue, 19 Dec 2023 16:29:22 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Dec
 2023 16:29:22 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>, <wangxiongfeng2@huawei.com>,
	<frederic@kernel.org>, <mingo@kernel.org>
Subject: [PATCH] tick/broadcast-hrtimer: Prevent the timer device on broadcast duty CPU from being disabled
Date: Mon, 18 Dec 2023 10:58:44 +0800
Message-ID: <20231218025844.55675-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)

It was found that running the LTP hotplug stress test on a aarch64
system could produce rcu_sched stall warnings.

The issue is the following:

CPU1 (owns the broadcast hrtimer)	CPU2

				tick_broadcast_enter()
				//shut down local timer device
				...
				tick_broadcast_exit()
				//exits with tick_broadcast_force_mask set,
				timer device remains disabled

				initiates offlining of CPU1
take_cpu_down()
//CPU1 shuts down and does
not send broadcast IPI anymore
				takedown_cpu()
				  hotplug_cpu__broadcast_tick_pull()
				  //move broadcast hrtimer to this CPU
				    clockevents_program_event()
				      bc_set_next()
					hrtimer_start()
					//does not call hrtimer_reprogram()
					to program timer device if expires
					equals dev->next_event, so the timer
					device remains disabled.

CPU2 takes over the broadcast duty but local timer device is disabled,
causing many CPUs to become stuck.

Fix this by calling tick_program_event() to reprogram the local timer
device in this scenario.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 kernel/time/tick-broadcast-hrtimer.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index e28f9210f8a1..6a4a612581fb 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -42,10 +42,22 @@ static int bc_shutdown(struct clock_event_device *evt)
  */
 static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 {
+	ktime_t next_event = this_cpu_ptr(&tick_cpu_device)->evtdev->next_event;
+
 	/*
-	 * This is called either from enter/exit idle code or from the
-	 * broadcast handler. In all cases tick_broadcast_lock is held.
-	 *
+	 * This can be called from CPU offline operation to move broadcast
+	 * assignment. If tick_broadcast_force_mask is set, the CPU local
+	 * timer device may be disabled. And hrtimer_reprogram() will not
+	 * called if the timer is not the first expiring timer. Reprogram
+	 * the cpu local timer device to ensure we can take over the
+	 * broadcast duty.
+	 */
+	if (tick_check_broadcast_expired() && expires >= next_event)
+		tick_program_event(next_event, 1);
+
+	/*
+	 * This is called from enter/exit idle code, broadcast handler or
+	 * CPU offline operation. In all cases tick_broadcast_lock is held.
 	 * hrtimer_cancel() cannot be called here neither from the
 	 * broadcast handler nor from the enter/exit idle code. The idle
 	 * code can run into the problem described in bc_shutdown() and the
-- 
2.33.0


