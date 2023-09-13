Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CAB79DF68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 07:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbjIMFa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 01:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIMFa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 01:30:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C409172E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 22:30:22 -0700 (PDT)
X-QQ-mid: bizesmtp89t1694582995tg1po50m
Received: from wangjiexun-virtual-machine.loca ( [183.230.12.200])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 13 Sep 2023 13:29:53 +0800 (CST)
X-QQ-SSF: 01200000000000102000000A0000000
X-QQ-FEAT: ILHsT53NKPjfD7b8Zb6jchmbIcw0qlMMQyN/QLoYTr77IR2msFhRMvJYrb4ot
        9WPBXDgryN09kt/n3PrdGPV55+xlfk5oD+LMpFQJOHDXCjKJHvxq/wtLCTun5iMYkiRtMdH
        urMDa/pLTLzA81GK+Ja8MkTs22OlbcRN0eMJYDOo6iVSEI+3yj1T7CJFyfUOsrWYvkAn74k
        tWRU9rqSF+66wmn6pmwA6Y1sMx1klkuMRkgRAo+dQMSSZiR82uf/CLQwQcCOfhAOVFT1rAp
        q6+W5Os5CxkuM08q46YQqcrbWtHmAdMQt6fngc/h7EWAlLTbUlAcuX0oKsx+R3/pFaJthKc
        fAi71Qb3Qsmf8rsgtOMk3TpB9dDedBf4wjY5+aprjaiqUkjuHGwYmkM2720zQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10456565237369855809
From:   Jiexun Wang <wangjiexun@tinylab.org>
To:     samuel@sholland.org
Cc:     conor@kernel.org, guoren@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        falcon@tinylab.org, jszhang@kernel.org, tglx@linutronix.de,
        Jiexun Wang <wangjiexun@tinylab.org>
Subject: [PATCH v3] RISC-V: Fix wrong use of CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
Date:   Wed, 13 Sep 2023 13:29:40 +0800
Message-Id: <20230913052940.374686-1-wangjiexun@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-0
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

Fixes: dd69d07a5a6c ("riscv: stack: Support HAVE_SOFTIRQ_ON_OWN_STACK")
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Jiexun Wang <wangjiexun@tinylab.org>
---
Changes in v3:
- changed to a more suitable subject line
- fix the #endif comment at the bottom of the function

Changes in v2:
- changed to a more suitable subject line
- add a Fixes tag

---
 arch/riscv/kernel/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index a8efa053c4a5..9cc0a7669271 100644
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
@@ -92,7 +92,7 @@ void do_softirq_own_stack(void)
 #endif
 		__do_softirq();
 }
-#endif /* CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK */
+#endif /* CONFIG_SOFTIRQ_ON_OWN_STACK */
 
 #else
 static void init_irq_stacks(void) {}
-- 
2.34.1
