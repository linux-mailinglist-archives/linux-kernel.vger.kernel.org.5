Return-Path: <linux-kernel+bounces-14001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5188216AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29267281D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABDCED4;
	Tue,  2 Jan 2024 03:43:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E62AEBF;
	Tue,  2 Jan 2024 03:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T3zDl56V5z29jK8;
	Tue,  2 Jan 2024 11:41:59 +0800 (CST)
Received: from dggpemd100005.china.huawei.com (unknown [7.185.36.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 6737E140135;
	Tue,  2 Jan 2024 11:43:24 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.104) by
 dggpemd100005.china.huawei.com (7.185.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 2 Jan 2024 11:43:24 +0800
From: Chen Zhongjin <chenzhongjin@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
	<davem@davemloft.net>, <paulmck@kernel.org>, <mhiramat@kernel.org>,
	<akpm@linux-foundation.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<pmladek@suse.com>, <dianders@chromium.org>, <npiggin@gmail.com>,
	<mpe@ellerman.id.au>, <jkl820.git@gmail.com>,
	<juerg.haefliger@canonical.com>, <rick.p.edgecombe@intel.com>,
	<eric.devolder@oracle.com>, <mic@digikod.net>
Subject: [RFC PATCH] kprobes: Use synchronize_rcu_tasks_rude in kprobe_optimizer
Date: Tue, 2 Jan 2024 03:40:24 +0000
Message-ID: <20240102034024.256326-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100005.china.huawei.com (7.185.36.102)

There is a deadlock scenario in kprobe_optimizer():

pid A				pid B			pid C
kprobe_optimizer()		do_exit()		perf_kprobe_init()
mutex_lock(&kprobe_mutex)	exit_tasks_rcu_start()	mutex_lock(&kprobe_mutex)
synchronize_rcu_tasks()		zap_pid_ns_processes()	// waiting kprobe_mutex
// waiting tasks_rcu_exit_srcu	kernel_wait4()
				// waiting pid C exit

To avoid this deadlock loop, use synchronize_rcu_tasks_rude() in kprobe_optimizer()
rather than synchronize_rcu_tasks(). synchronize_rcu_tasks_rude() can also promise
that all preempted tasks have scheduled, but it will not wait tasks_rcu_exit_srcu.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/Kconfig     | 2 +-
 kernel/kprobes.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index f4b210ab0612..dc6a18854017 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
 config OPTPROBES
 	def_bool y
 	depends on KPROBES && HAVE_OPTPROBES
-	select TASKS_RCU if PREEMPTION
+	select TASKS_RUDE_RCU
 
 config KPROBES_ON_FTRACE
 	def_bool y
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d5a0ee40bf66..09056ae50c58 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -623,7 +623,7 @@ static void kprobe_optimizer(struct work_struct *work)
 	 * Note that on non-preemptive kernel, this is transparently converted
 	 * to synchronoze_sched() to wait for all interrupts to have completed.
 	 */
-	synchronize_rcu_tasks();
+	synchronize_rcu_tasks_rude();
 
 	/* Step 3: Optimize kprobes after quiesence period */
 	do_optimize_kprobes();
-- 
2.25.1


