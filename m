Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F96783C62
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbjHVJBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjHVJBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:01:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC851B2;
        Tue, 22 Aug 2023 02:01:30 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.45.215.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 61634660723E;
        Tue, 22 Aug 2023 10:01:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692694889;
        bh=G+PYlsLKKNrAJfjnLhUkS/SXCH0SH1cJtUJtNZ50U6Q=;
        h=From:To:Cc:Subject:Date:From;
        b=kGi7C/fwaHu5a8ZX9E0xrhwivYmQ9nFQV2i0aRhf5Ag1tBQKCdVCQ8QWyuBfMLDGJ
         vellhOLG+C48tk8dXJIaNGg72aRZIMQEkcAtPe/aadZFvs5Z8EcyI37HGIfgu0fmq2
         z4c+q2LjoTk0VX4ATRzVZ7YFGvyXwTMSvN3MRiHE2RKw1688gsYj2xOL7dibahaPJS
         F+Thb9u6OnMLND1UZWr0mbOB7+DEUu/j7mF4C4r8HOMDhwxj+Ps5STxKK4zM+0UYyX
         guQUetONQwfdps0WvR0oIwMC4nu2k99uWU1kVjqXknY0odpUoSgp4HUOUAcNfI/kWS
         VQhWpiTqpYAnQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Ingo Molnar <mingo@elte.hu>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 RESEND] tty/sysrq: replace smp_processor_id() with get_cpu()
Date:   Tue, 22 Aug 2023 14:01:11 +0500
Message-Id: <20230822090112.2601273-1-usama.anjum@collabora.com>
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

Cc: stable@vger.kernel.org
Fixes: 47cab6a722d4 ("debug lockups: Improve lockup detection, fix generic arch fallback")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Add "Cc: stable@vger.kernel.org" tag
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

