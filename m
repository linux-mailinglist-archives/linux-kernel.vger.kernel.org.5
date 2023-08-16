Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B777DDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbjHPJua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243619AbjHPJuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:50:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC41AD1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:50:10 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cxh+jRm9xkxhQZAA--.15873S3;
        Wed, 16 Aug 2023 17:50:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPCPQm9xkOeZbAA--.10301S2;
        Wed, 16 Aug 2023 17:50:08 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH] LoongArch: Put the body of play_dead() into arch_cpu_idle_dead()
Date:   Wed, 16 Aug 2023 17:50:08 +0800
Message-Id: <1692179408-32740-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxPCPQm9xkOeZbAA--.10301S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw1xCw4xGF43tFy7CFy3trc_yoW5Gr15pF
        yUAryDJr4Fgrn7Z34DJ3yrWr98Jr9rGw1a9a17AFWrAa17XF1DXrZYyas0qFnYqayF9a40
        qayrW3yFvF4UuabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
        Ja73UjIFyTuYvjxUc0eHDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial aim is to silence the following objtool warning:

arch/loongarch/kernel/process.o: warning: objtool: arch_cpu_idle_dead() falls through to next function start_thread()

According to tools/objtool/Documentation/objtool.txt, this is because
the last instruction of arch_cpu_idle_dead() is a call to a noreturn
function play_dead(). In order to silence the warning, one simple way
is to add the noreturn function play_dead() to objtool's hard-coded
global_noreturns array, that is to say, just put "NORETURN(play_dead)"
into tools/objtool/noreturns.h, it works well.

But I noticed that play_dead() is only defined once and only called by
arch_cpu_idle_dead(), so put the body of play_dead() into the caller
arch_cpu_idle_dead(), then remove the noreturn function play_dead() is
an alternative way which can reduce the overhead of the function call
at the same time.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/smp.h | 2 --
 arch/loongarch/kernel/process.c  | 7 -------
 arch/loongarch/kernel/smp.c      | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 416b653..66ecb48 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -98,8 +98,6 @@ static inline void __cpu_die(unsigned int cpu)
 {
 	loongson_cpu_die(cpu);
 }
-
-extern void __noreturn play_dead(void);
 #endif
 
 #endif /* __ASM_SMP_H */
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 2e04eb0..4ee1e9d 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -61,13 +61,6 @@ EXPORT_SYMBOL(__stack_chk_guard);
 unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
 EXPORT_SYMBOL(boot_option_idle_override);
 
-#ifdef CONFIG_HOTPLUG_CPU
-void __noreturn arch_cpu_idle_dead(void)
-{
-	play_dead();
-}
-#endif
-
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 8ea1bbc..6667b0a 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -317,7 +317,7 @@ void loongson_cpu_die(unsigned int cpu)
 	mb();
 }
 
-void play_dead(void)
+void __noreturn arch_cpu_idle_dead(void)
 {
 	register uint64_t addr;
 	register void (*init_fn)(void);
-- 
2.1.0

