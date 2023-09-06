Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A461E79353C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjIFGZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjIFGZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:25:41 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C55198
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:25:36 -0700 (PDT)
X-QQ-mid: bizesmtp82t1693981505tg4mjarq
Received: from wangjiexun-virtual-machine.loca ( [120.225.34.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 06 Sep 2023 14:25:03 +0800 (CST)
X-QQ-SSF: 01200000000000101000000A0000000
X-QQ-FEAT: kwdSLf7XDNJgOHQ8eIbPYpAVe0AqMNXAXlKVgnNZPHXigolcePZXT1Nul/Nc+
        uAeqdDXhyU3cJR2TL2OG0opUUM1Y6nPo7S7e5SjlEeja7qvQZCKcdFF5yvU0TVpQuVfXWWv
        /aqAeqBrb9szvl1YBtTkng9OOXcx9XW7a7gAco/xpx08Q6iC7erqH3vnMhMYyZkoBiCE1Ai
        j3kFN7LdggMHn6rwciBkJjy1zjXNCAT+T6Z4gUN03nG/EJjFuEqzRfw9Uziwtqh4rlpWl9a
        b1BaG00KBr/zzCjETcvrTGlMopYiK0qae+lD4vrDMoZss02b7U51+2c0+wNZt23NF36X5ME
        EioLoYITInR8ZbH63Khe1ed+qFE/+Z56vN78rFsDJsVLKS7iP7WBQ0g36NV+lTF1cEKW0ra
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 862016668279199492
From:   Jiexun Wang <wangjiexun@tinylab.org>
To:     guoren@kernel.org
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, falcon@tinylab.org,
        jszhang@kernel.org, tglx@linutronix.de,
        Jiexun Wang <wangjiexun@tinylab.org>
Subject: [PATCH] modify CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK in riscv irq.c file
Date:   Wed,  6 Sep 2023 14:24:14 +0800
Message-Id: <20230906062414.254602-1-wangjiexun@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If configuration options SOFTIRQ_ON_OWN_STACK and PREEMPT_RT 
are enabled simultaneously under RISC-V architecture,
it will result in a compilation failure:

arch/riscv/kernel/irq.c:64:6: error: redefinition of 'do_softirq_own_stack'
   64 | void do_softirq_own_stack(void)
      |      ^~~~~~~~~~~~~~~~~~~~
In file included from ./arch/riscv/include/generated/asm/softirq_stack.h:1,
                 from arch/riscv/kernel/irq.c:15:
./include/asm-generic/softirq_stack.h:8:20: note: previous definition of 'do_softirq_own_stack' was here
    8 | static inline void do_softirq_own_stack(void)
      |                    ^~~~~~~~~~~~~~~~~~~~
      
After changing CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK to CONFIG_SOFTIRQ_ON_OWN_STACK,
compilation can be successful.

Signed-off-by: Jiexun Wang <wangjiexun@tinylab.org>
---
 arch/riscv/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index a8efa053c4a5..a86f272ae2c3 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -60,7 +60,7 @@ static void init_irq_stacks(void)
 }
 #endif /* CONFIG_VMAP_STACK */
 
-#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 #ifdef CONFIG_IRQ_STACKS
-- 
2.34.1

