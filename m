Return-Path: <linux-kernel+bounces-109985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C485A885896
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FA41F22E19
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64C45A0E5;
	Thu, 21 Mar 2024 11:51:34 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D44D3C17;
	Thu, 21 Mar 2024 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021894; cv=none; b=pS79KqRo+XKI2+xa9RSIC1HKrzZZez8OyfYA/SJuHRbIaJUTg+QqtXBMqW1xB00I34YhuA1Pz4162G1fhFxy3iwpA2tx4txPDvnp9FuWCNm11oNWuzvITWWCi57TgkiQCne1Aat6BbVCVUD9lbb3uEQlUR52pH/fZNA5wM0EGCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021894; c=relaxed/simple;
	bh=ZWaGrDtjpK+9JiJxCRC8Xa2hVkOfI5aZMwq9BnFdYVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlQDGtiCz0ADE504ZuM0IVZJ1MKXQ0OcIyGVa7ozCrQuI6v37Ni/T8MbnlImrgSi283wZGl/SaIxrx4HwB8p6T7CheTAo+Y5AybccV3jciXoujixzvDzhbV1sheuZBNzvTilWONQYV4cCfXj4zlcOldPRs67gcNewYnA8+L47OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 42LBoOWw098955;
	Thu, 21 Mar 2024 19:50:24 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id E02D02004BA8;
	Thu, 21 Mar 2024 19:52:07 +0800 (CST)
Received: from localhost.localdomain (10.114.186.34) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Thu, 21 Mar 2024 19:50:27 +0800
From: <liu.yec@h3c.com>
To: <daniel.thompson@linaro.org>
CC: <dianders@chromium.org>, <gregkh@linuxfoundation.org>,
        <jason.wessel@windriver.com>, <jirislaby@kernel.org>,
        <kgdb-bugreport@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <liu.yec@h3c.com>,
        LiuYe <liu.yeC@h3c.com>
Subject: [PATCH V4] kdb: Fix the deadlock issue in KDB debugging.
Date: Thu, 21 Mar 2024 19:50:17 +0800
Message-ID: <20240321115017.2879691-1-liu.yec@h3c.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240321110407.GB7342@aspen.lan>
References: <20240321110407.GB7342@aspen.lan>
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
X-MAIL:h3cspam02-ex.h3c.com 42LBoOWw098955

From: LiuYe <liu.yeC@h3c.com>

Currently, if CONFIG_KDB_KEYBOARD is enabled, then kgdboc will
attempt to use schedule_work() to provoke a keyboard reset when
transitioning out of the debugger and back to normal operation.
This can cause deadlock because schedule_work() is not NMI-safe.

The stack trace below shows an example of the problem. In this
case the master cpu is not running from NMI but it has parked
the slave CPUs using an NMI and the parked CPUs is holding
spinlocks needed by schedule_work().

example:
 BUG: spinlock lockup suspected on CPU#0, namex/10450
 lock: 0xffff881ffe823980, .magic: dead4ead, .owner: namexx/21888, .owner_cpu: 1
 ffff881741d00000 ffff881741c01000 0000000000000000 0000000000000000
 ffff881740f58e78 ffff881741cffdd0 ffffffff8147a7fc ffff881740f58f20
Call Trace:
 [<ffffffff81479e6d>] ? __schedule+0x16d/0xac0
 [<ffffffff8147a7fc>] ? schedule+0x3c/0x90
 [<ffffffff8147e71a>] ? schedule_hrtimeout_range_clock+0x10a/0x120
 [<ffffffff8147d22e>] ? mutex_unlock+0xe/0x10
 [<ffffffff811c839b>] ? ep_scan_ready_list+0x1db/0x1e0
 [<ffffffff8147e743>] ? schedule_hrtimeout_range+0x13/0x20
 [<ffffffff811c864a>] ? ep_poll+0x27a/0x3b0
 [<ffffffff8108c540>] ? wake_up_q+0x70/0x70
 [<ffffffff811c99a8>] ? SyS_epoll_wait+0xb8/0xd0
 [<ffffffff8147f296>] ? entry_SYSCALL_64_fastpath+0x12/0x75
 CPU: 0 PID: 10450 Comm: namex Tainted: G           O    4.4.65 #1
 Hardware name: Insyde Purley/Type2 - Board Product Name1, BIOS 05.21.51.0036 07/19/2019
  0000000000000000 ffff881ffe813c10 ffffffff8124e883 ffff881741c01000
  ffff881ffe823980 ffff881ffe813c38 ffffffff810a7f7f ffff881ffe823980
  000000007d2b7cd0 0000000000000001 ffff881ffe813c68 ffffffff810a80e0
  Call Trace:
  <#DB>  [<ffffffff8124e883>] dump_stack+0x85/0xc2
  [<ffffffff810a7f7f>] spin_dump+0x7f/0x100
  [<ffffffff810a80e0>] do_raw_spin_lock+0xa0/0x150
  [<ffffffff8147eb55>] _raw_spin_lock+0x15/0x20
  [<ffffffff8108c256>] try_to_wake_up+0x176/0x3d0
  [<ffffffff8108c4c5>] wake_up_process+0x15/0x20
  [<ffffffff8107b371>] insert_work+0x81/0xc0
  [<ffffffff8107b4e5>] __queue_work+0x135/0x390
  [<ffffffff8107b786>] queue_work_on+0x46/0x90
  [<ffffffff81313d28>] kgdboc_post_exp_handler+0x48/0x70
  [<ffffffff810ed488>] kgdb_cpu_enter+0x598/0x610
  [<ffffffff810ed6e2>] kgdb_handle_exception+0xf2/0x1f0
  [<ffffffff81054e21>] __kgdb_notify+0x71/0xd0
  [<ffffffff81054eb5>] kgdb_notify+0x35/0x70
  [<ffffffff81082e6a>] notifier_call_chain+0x4a/0x70
  [<ffffffff8108304d>] notify_die+0x3d/0x50
  [<ffffffff81017219>] do_int3+0x89/0x120
  [<ffffffff81480fb4>] int3+0x44/0x80

Signed-off-by: LiuYe <liu.yeC@h3c.com>
Co-authored-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

---
V3 -> V4: Add changelogs
V2 -> V3: Add description information
V1 -> V2: using irq_work to solve this properly.
---
---
 drivers/tty/serial/kgdboc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 7ce7bb164..161b25ecc 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
+#include <linux/irq_work.h>
 
 #define MAX_CONFIG_LEN		40
 
@@ -99,10 +100,17 @@ static void kgdboc_restore_input_helper(struct work_struct *dummy)
 
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
@@ -133,6 +141,7 @@ static void kgdboc_unregister_kbd(void)
 			i--;
 		}
 	}
+	irq_work_sync(&kgdboc_restore_input_irq_work);
 	flush_work(&kgdboc_restore_input_work);
 }
 #else /* ! CONFIG_KDB_KEYBOARD */
-- 
2.25.1


