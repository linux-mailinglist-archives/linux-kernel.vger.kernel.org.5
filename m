Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE7980A1DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjLHLKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjLHLKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:10:38 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673FBF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:10:43 -0800 (PST)
X-QQ-mid: bizesmtp69t1702033819tx63b91w
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 08 Dec 2023 19:10:17 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: HIVLo4mOhq54yA4OLFoMe1EM5ffJGUYpbwtVwR0aVb2Wr/FKPBIXiLzDRcTWG
        OIph7+eMji4nK3Bm9+9R2C56dYXezaz0dIipH1Gcf/bRcDAGtVQheFhchN7bubTU4OhuI5Z
        F9DyUzj+gU2wtpheFi8tSfxkzKHyEyzQpyRktOVkIwzlftynytYwscEnrCaNM0IS7pCA4WQ
        I4ct+DAQZOgxysVdVDF8TCrGF9UW6Z4brCHDydwtKfDdeNcqxbFBpRvZU9vwpo/NzqgPCV6
        u029vpL1XAKL1FUKjLY5W28Oo/7BZ1QEUayacnzx48XU3bQfGIv87wBWFNZX2sd7n3/n7om
        wLEiSEYqo9vobF70ORgvS+0j7mOUg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3233006858392869652
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org,
        xianting.tian@linux.alibaba.com, takahiro.akashi@linaro.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH -fixes] riscv: kexec: Avoid deadlock in kexec crash path
Date:   Fri,  8 Dec 2023 19:10:15 +0800
Message-Id: <20231208111015.173237-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kexec crash code is called in the interrupt context, the
machine_kexec_mask_interrupts() function will trigger a deadlock while
trying to acquire the irqdesc spinlock and then deacitive irqchip.

To avoid the deadlock, this patch directly EOI the irq regardless of
the active status of irqchip.

Fixes: b17d19a5314a ("riscv: kexec: Fixup irq controller broken in kexec crash path")
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
Note that:
   
1. this deadlock can reproduced via echo EXCEPTION to lkdtm INT_HW_IRQ_EN point
   
2. RISC-V HLIC and PLIC irqchips don't have the irq_set_irqchip_state handler
and I don't know is it ok to deactive irqchip without the spinlock in this
code context, so I simply removed that snippet as arm and powerpc do.

I would like to listen to your advice.
---
 arch/riscv/kernel/machine_kexec.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index f6c7135b00d7..d7ddf4d2b243 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -149,20 +149,12 @@ static void machine_kexec_mask_interrupts(void)
 
 	for_each_irq_desc(i, desc) {
 		struct irq_chip *chip;
-		int ret;
 
 		chip = irq_desc_get_chip(desc);
 		if (!chip)
 			continue;
 
-		/*
-		 * First try to remove the active state. If this
-		 * fails, try to EOI the interrupt.
-		 */
-		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
-
-		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
-		    chip->irq_eoi)
+		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
 			chip->irq_eoi(&desc->irq_data);
 
 		if (chip->irq_mask)
-- 
2.20.1

