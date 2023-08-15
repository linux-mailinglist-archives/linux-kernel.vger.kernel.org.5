Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7E77C865
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjHOHOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbjHOHNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:13:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FFFCE;
        Tue, 15 Aug 2023 00:13:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.34.184.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 141E866071C1;
        Tue, 15 Aug 2023 08:13:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692083603;
        bh=5OmlFjj5KV/EzXKNt4SeqnKQwRJht9eXvfXu7crYI1g=;
        h=From:To:Cc:Subject:Date:From;
        b=Cl3oKnIfrCH4nuKS3XACtSIt+EyfrY3T/osZgwmbUOdYABkVinsD+7NXSVxmG+3Qr
         Uo+KcUVhbszMSJxN0LhNK4nPOZobYGh10tD1xG2Rbybwm01zb8suWqkwYT/5I4U+p9
         Xmm00/B2izj2FQH2ALHsA/oJ7qUVrR0voswjaaO2Tti2X5dzldxoJJi+d8lHOc7n4i
         gHXeBf06aSDyVXhpytkcaUTKpK36qY7QYCbfPWMpey7D81UziEetiZG/kbIHz7B+vQ
         RQrGItX4CQg3PhniTCop3VG8DQqcknb87jLFr2wmXuyIyaiOqv2Nu2JuVM5rcLfw0Z
         UByvDbLjgbEhg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Ingo Molnar <mingo@elte.hu>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] tty/sysrq: replace smp_processor_id() with get_cpu()
Date:   Tue, 15 Aug 2023 12:13:15 +0500
Message-Id: <20230815071316.3433114-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smp_processor_id() shouldn't be called from preemptible code.
Instead use get_cpu() and put_cpu() which disables preemption in
addition to getting the processor id. This fixes the following bug:

[  119.143590] sysrq: Show backtrace of all active CPUs
[  119.143902] BUG: using smp_processor_id() in preemptible [00000000] code: bash/873
[  119.144586] caller is debug_smp_processor_id+0x20/0x30
[  119.144827] CPU: 6 PID: 873 Comm: bash Not tainted 5.10.124-dirty #3
[  119.144861] Hardware name: QEMU QEMU Virtual Machine, BIOS 2023.05-1 07/22/2023
[  119.145053] Call trace:
[  119.145093]  dump_backtrace+0x0/0x1a0
[  119.145122]  show_stack+0x18/0x70
[  119.145141]  dump_stack+0xc4/0x11c
[  119.145159]  check_preemption_disabled+0x100/0x110
[  119.145175]  debug_smp_processor_id+0x20/0x30
[  119.145195]  sysrq_handle_showallcpus+0x20/0xc0
[  119.145211]  __handle_sysrq+0x8c/0x1a0
[  119.145227]  write_sysrq_trigger+0x94/0x12c
[  119.145247]  proc_reg_write+0xa8/0xe4
[  119.145266]  vfs_write+0xec/0x280
[  119.145282]  ksys_write+0x6c/0x100
[  119.145298]  __arm64_sys_write+0x20/0x30
[  119.145315]  el0_svc_common.constprop.0+0x78/0x1e4
[  119.145332]  do_el0_svc+0x24/0x8c
[  119.145348]  el0_svc+0x10/0x20
[  119.145364]  el0_sync_handler+0x134/0x140
[  119.145381]  el0_sync+0x180/0x1c0

Fixes: 47cab6a722d4 ("debug lockups: Improve lockup detection, fix generic arch fallback")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
I've reproduced the bug on arm64. This patch fixes the bug.
---
 drivers/tty/sysrq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 23198e3f1461a..6b4a28bcf2f5f 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -262,13 +262,14 @@ static void sysrq_handle_showallcpus(u8 key)
 		if (in_hardirq())
 			regs = get_irq_regs();
 
-		pr_info("CPU%d:\n", smp_processor_id());
+		pr_info("CPU%d:\n", get_cpu());
 		if (regs)
 			show_regs(regs);
 		else
 			show_stack(NULL, NULL, KERN_INFO);
 
 		schedule_work(&sysrq_showallcpus);
+		put_cpu();
 	}
 }
 
-- 
2.40.1

