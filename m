Return-Path: <linux-kernel+bounces-84522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7754C86A7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EF528743F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624D420DCE;
	Wed, 28 Feb 2024 05:11:42 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF911D685;
	Wed, 28 Feb 2024 05:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709097101; cv=none; b=PFtkOMsbPgteyz+s2FpJYzKs1bA+djeALYvYsFm9TDFQKNbEuUSXf65NHcCAlFjKj8O3HfH/3QMLvlQpHyqiZZn7qcuaZ5b16+5309/Oqh8CQHEd927U7n5PsW845/VnlYwB+Eo+9XB9ayX/21+gNgLW9mMNZS1GbB1w4sskqr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709097101; c=relaxed/simple;
	bh=6zpMQGqstL9uPpFOv76N6PFMaID669Pd5/NbhzWUD/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qBnv3BOcLFeP3JG7mf5PNUqxgdyU8+GQ3hugcSEjVSoH0Ijiet9NlgopLENY0JKQ6P2l9rQ5Cj60Wy/s+BWINYPacN7652Gy40qpb+PsINS9KB8tpsy2K3+I6JcUejSLh2YIaS0pMNOR8JD7F8BW48FwjlGDXOQkIMHaP++tgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
	by h3cspam02-ex.h3c.com with ESMTP id 41S2vifp091258;
	Wed, 28 Feb 2024 10:57:44 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 41S2uMv7083766;
	Wed, 28 Feb 2024 10:56:22 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id F15DC2004BB7;
	Wed, 28 Feb 2024 10:57:30 +0800 (CST)
Received: from localhost.localdomain (10.114.186.34) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Wed, 28 Feb 2024 10:56:22 +0800
From: LiuYe <liu.yeC@h3c.com>
To: <jason.wessel@windriver.com>, <daniel.thompson@linaro.org>
CC: <dianders@chromium.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <liu.yeC@h3c.com>
Subject: [PATCH] kdb: Fix the deadlock issue in KDB debugging.
Date: Wed, 28 Feb 2024 10:56:02 +0800
Message-ID: <20240228025602.3087748-1-liu.yeC@h3c.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 41S2vifp091258

master cpu : After executing the go command, a deadlock occurs.
slave cpu: may be performing thread migration,
        acquiring the running queue lock of master CPU.
        Then it was interrupted by kdb NMI and entered the nmi_handler proc=
ess.
        (nmi_handle-> kgdb_nmicallback-> kgdb_cpu_enter
        while(1){ touch wathcdog}.)

example:
 BUG: spinlock lockup suspected on CPU#0, namex/10450
 lock: 0xffff881ffe823980, .magic: dead4ead, .owner: namexx/21888, .owner_c=
pu: 1
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
 Hardware name: Insyde Purley/Type2 - Board Product Name1, BIOS 05.21.51.00=
36 07/19/2019
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
---
 drivers/tty/serial/kgdboc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 7ce7bb164..945318ef1 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -22,6 +22,9 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
+#include <linux/smp.h>
+
+#include "../kernel/sched/sched.h"

 #define MAX_CONFIG_LEN         40

@@ -399,7 +402,8 @@ static void kgdboc_post_exp_handler(void)
                dbg_restore_graphics =3D 0;
                con_debug_leave();
        }
-       kgdboc_restore_input();
+       if (!raw_spin_is_locked(&(cpu_rq(smp_processor_id())->lock)))
+               kgdboc_restore_input();
 }

 static struct kgdb_io kgdboc_io_ops =3D {
--
2.25.1

---------------------------------------------------------------------------=
----------------------------------------------------------
=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=D0=C2=BB=AA=C8=FD=BC=
=AF=CD=C5=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=CD=
=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6
=B5=C4=B8=F6=C8=CB=BB=F2=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=
=FB=C8=CB=D2=D4=C8=CE=BA=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=
=B2=BB=CF=DE=D3=DA=C8=AB=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=
=B4=D6=C6=A1=A2
=BB=F2=C9=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=A3=C8=
=E7=B9=FB=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=C1=A2=
=BC=B4=B5=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=A2=C9=
=BE=B3=FD=B1=BE
=D3=CA=BC=FE=A3=A1
This e-mail and its attachments contain confidential information from New H=
3C, which is
intended only for the person or entity whose address is listed above. Any u=
se of the
information contained herein in any way (including, but not limited to, tot=
al or partial
disclosure, reproduction, or dissemination) by persons other than the inten=
ded
recipient(s) is prohibited. If you receive this e-mail in error, please not=
ify the sender
by phone or email immediately and delete it!

