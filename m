Return-Path: <linux-kernel+bounces-137815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A94B89E801
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BD11C2125D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B87524C;
	Wed, 10 Apr 2024 02:08:19 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB0522E;
	Wed, 10 Apr 2024 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714898; cv=none; b=hmy+2TTqHqw0NdUd0tVQ5weMtQbickgCbjx2oiePOfn/2ttMaP7AJz4Fu+JI/5YvmwceD56Y8btz0Lgkz4iQEQhpMg+WlDIIONpkZsXZ3UCEyij82RV3yDCSoAP3WoyTsVMe9+B+aVw78W0nz8OxNVyNTMRTIVRhFAJ7Mi6z9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714898; c=relaxed/simple;
	bh=0W3UsbIojVwFSlMNwZGkkrTxQotLO1cK8fUvwsiqQF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNMAVPHgVYRHMOM/Z84Oo3Gw6g2WrGZELD2CDRtiAKVR+ahmFFLuB2rBgJPyraF0w+lvTUs1HmkwFUIVT8/UT8EVITKEY+VUIwuPvgq4Yot/JJw+SDDrHVoS1sDoHkAuosNEDhv/BUoRCqIcXTDewbPY1XtJQixUrEZVN2jThs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 43A26IAO060864;
	Wed, 10 Apr 2024 10:06:22 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id 0B8C922DED61;
	Wed, 10 Apr 2024 10:08:31 +0800 (CST)
Received: from localhost.localdomain (10.114.186.34) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Wed, 10 Apr 2024 10:06:22 +0800
From: <liu.yec@h3c.com>
To: <andy.shevchenko@gmail.com>, <daniel.thompson@linaro.org>,
        <gregkh@linuxfoundation.org>
CC: <dianders@chromium.org>, <jason.wessel@windriver.com>,
        <jirislaby@kernel.org>, <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <liu.yeC@h3c.com>
Subject: [PATCH V10] kdb: Fix the deadlock issue in KDB debugging.
Date: Wed, 10 Apr 2024 10:06:15 +0800
Message-ID: <20240410020615.2885000-1-liu.yec@h3c.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240409020326.2125332-1-liu.yec@h3c.com>
References: <20240409020326.2125332-1-liu.yec@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 43A26IAO060864

From: LiuYe <liu.yeC@h3c.com>

Currently, if CONFIG_KDB_KEYBOARD is enabled, then kgdboc will
attempt to use schedule_work() to provoke a keyboard reset when
transitioning out of the debugger and back to normal operation.
This can cause deadlock because schedule_work() is not NMI-safe.

The stack trace below shows an example of the problem. In this
case the master cpu is not running from NMI but it has parked
the slave CPUs using an NMI and the parked CPUs is holding
spinlocks needed by schedule_work().

Example:
BUG: spinlock lockup suspected on CPU#0. owner_cpu: 1
CPU1: Call Trace:
__schedule
schedule
schedule_hrtimeout_range_clock
mutex_unlock
ep_scan_ready_list
schedule_hrtimeout_range
ep_poll
wake_up_q
SyS_epoll_wait
entry_SYSCALL_64_fastpath

CPU0: Call Trace:
dump_stack
spin_dump
do_raw_spin_lock
_raw_spin_lock
try_to_wake_up
wake_up_process
insert_work
__queue_work
queue_work_on
kgdboc_post_exp_handler
kgdb_cpu_enter
kgdb_handle_exception
__kgdb_notify
kgdb_notify
notifier_call_chain
notify_die
do_int3
int3

We fix the problem by using irq_work to call schedule_work()
instead of calling it directly. This is because we cannot
resynchronize the keyboard state from the hardirq context
provided by irq_work. This must be done from the task context
in order to call the input subsystem.

Therefore, we have to defer the work twice. First, safely
switch from the debug trap context (similar to NMI) to the
hardirq, and then switch from the hardirq to the system work queue.

Signed-off-by: LiuYe <liu.yeC@h3c.com>
Co-developed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Greg KH <gregkh@linuxfoundation.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---
V9 -> V10 : Add Signed-off-by of Greg KH and Andy Shevchenko, Acked-by of Daniel Thompson
V8 -> V9: Modify call trace format and move irq_work.h before module.h
V7 -> V8: Update the description information and comments in the code.
	: Submit this patch based on version linux-6.9-rc2.
V6 -> V7: Add comments in the code.
V5 -> V6: Replace with a more professional and accurate answer.
V4 -> V5: Answer why schedule another work in the irq_work and not do the job directly.
V3 -> V4: Add changelogs
V2 -> V3: Add description information
V1 -> V2: using irq_work to solve this properly.
---
---
 drivers/tty/serial/kgdboc.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 7ce7bb164..32410fec7 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -19,6 +19,7 @@
 #include <linux/console.h>
 #include <linux/vt_kern.h>
 #include <linux/input.h>
+#include <linux/irq_work.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
@@ -82,6 +83,19 @@ static struct input_handler kgdboc_reset_handler = {
 
 static DEFINE_MUTEX(kgdboc_reset_mutex);
 
+/*
+ * This code ensures that the keyboard state, which is changed during kdb
+ * execution, is resynchronized when we leave the debug trap. The resync
+ * logic calls into the input subsystem to force a reset. The calls into
+ * the input subsystem must be executed from normal task context.
+ *
+ * We need to trigger the resync from the debug trap, which executes in an
+ * NMI (or similar) context. To make it safe to call into the input
+ * subsystem we end up having use two deferred execution techniques.
+ * Firstly, we use irq_work, which is NMI-safe, to provoke a callback from
+ * hardirq context. Then, from the hardirq callback we use the system
+ * workqueue to provoke the callback that actually performs the resync.
+ */
 static void kgdboc_restore_input_helper(struct work_struct *dummy)
 {
 	/*
@@ -99,10 +113,17 @@ static void kgdboc_restore_input_helper(struct work_struct *dummy)
 
 static DECLARE_WORK(kgdboc_restore_input_work, kgdboc_restore_input_helper);
 
+static void kgdboc_queue_restore_input_helper(struct irq_work *unused)
+{
+	schedule_work(&kgdboc_restore_input_work);
+}
+
+static DEFINE_IRQ_WORK(kgdboc_restore_input_irq_work, kgdboc_queue_restore_input_helper);
+
 static void kgdboc_restore_input(void)
 {
 	if (likely(system_state == SYSTEM_RUNNING))
-		schedule_work(&kgdboc_restore_input_work);
+		irq_work_queue(&kgdboc_restore_input_irq_work);
 }
 
 static int kgdboc_register_kbd(char **cptr)
@@ -133,6 +154,7 @@ static void kgdboc_unregister_kbd(void)
 			i--;
 		}
 	}
+	irq_work_sync(&kgdboc_restore_input_irq_work);
 	flush_work(&kgdboc_restore_input_work);
 }
 #else /* ! CONFIG_KDB_KEYBOARD */
-- 
2.25.1


