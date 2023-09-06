Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB84793CAD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjIFMeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjIFMeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:34:09 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F471717
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:34:00 -0700 (PDT)
X-QQ-mid: bizesmtp69t1694003607tudcir6g
Received: from wangjiexun-virtual-machine.loca ( [120.225.34.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 06 Sep 2023 20:33:25 +0800 (CST)
X-QQ-SSF: 01200000000000101000000A0000000
X-QQ-FEAT: rZJGTgY0+YN9fNMQKTSU9Qgqmi6m+PTsmzRVbNPtaV/A5xhJrUGcYwefmJlX2
        11PftMTdzH2cqBPrK2tlbOMGpQPvsx8ROqEMCA/K2OPtv6nPQVRePJtHMTGpp3PJhhqFPGb
        mikZCnSfIQyPN6JjodtSzMSxYb71LKA68AgC47JS3pH+QggfbwA/kb5qXHsFsv3qKloNs2s
        lHsWWZbIrfD9dIvnlNY3g4tkJqXGvREKwMEdd9pq0AyX4lZ/M2iIPo55/InKgZyQouQDwCQ
        AJikqyw/4mNUxwHlmQWJv0RwcRymPazYlLgJ2rjxgwaOtqaK+HeVtR1IL5uxTti4kk64G7L
        oWIQ8BC8T3eFKHZxH5DVYT7eO6zYALNU8SbEBu1VkT3wY3sgcrHXFzVYBlPGA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16057446587632364950
From:   Jiexun Wang <wangjiexun@tinylab.org>
To:     conor@kernel.org
Cc:     guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, falcon@tinylab.org,
        jszhang@kernel.org, tglx@linutronix.de,
        Jiexun Wang <wangjiexun@tinylab.org>
Subject: [PATCH v2] RISC-V: Fix use of non existent CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
Date:   Wed,  6 Sep 2023 20:32:16 +0800
Message-Id: <20230906123216.255932-1-wangjiexun@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: dd69d07a5a6c ("riscv: stack: Support HAVE_SOFTIRQ_ON_OWN_STACK")
Signed-off-by: Jiexun Wang <wangjiexun@tinylab.org>
---
Changes in v2:
- changed to a more suitable subject line
- add a Fixes tag

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

