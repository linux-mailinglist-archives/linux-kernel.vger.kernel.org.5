Return-Path: <linux-kernel+bounces-22340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EAA829C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74891C227A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1AE4E1B3;
	Wed, 10 Jan 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JWIGZWuj"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABE54D5A9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EFA5O
	Sg/9wM/36Kx2+oDQpahutVpueF/4LM7t5Wshbw=; b=JWIGZWujmLzprQB0qN3hl
	rupIBYxB9vKVBXXqNY0E9UxcWvMlxCaJa1YjLGHZn/3FpnSfXdMMgpVvoNaayjCB
	j7tnHafuTBL0K25YDYmEaXrWrRBiOBBZXMGrstIw7DXfA10mPx5hNfKWT/7ph8iP
	xh52wVmZaHMASfeszpARMs=
Received: from localhost.localdomain (unknown [114.105.142.232])
	by zwqz-smtp-mta-g2-4 (Coremail) with SMTP id _____wDnlzkfpp5l01UpAw--.31262S4;
	Wed, 10 Jan 2024 22:14:31 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: tglx@linutronix.de,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH] hrtimer.c : Remove redundant thread state settings
Date: Wed, 10 Jan 2024 06:13:49 -0800
Message-Id: <20240110141349.52718-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnlzkfpp5l01UpAw--.31262S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrWrWUuryDKrW3Ww13WF45ZFb_yoWxArc_uw
	sFgFy8Jr15JFnFkrs5Cw43Zry8KFW5JFWkZa9FgrZrJa1vyrWj9rn5AFZxCF98ZF9rGF1D
	AFZ8GrykK3y5JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_Yii3UUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiWAthq2VOA70nUwAAs4

After a thread is awakened, its state is already task_running

Signed-off-by: Lizhe <sensor1010@163.com>
---
 kernel/time/hrtimer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 760793998cdd..b123e9f4401a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2310,8 +2310,6 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 	hrtimer_cancel(&t.timer);
 	destroy_hrtimer_on_stack(&t.timer);
 
-	__set_current_state(TASK_RUNNING);
-
 	return !t.task ? 0 : -EINTR;
 }
 EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
-- 
2.25.1


