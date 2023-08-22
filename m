Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A3783C23
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjHVIyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjHVIyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:54:04 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5BFCCE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:54:01 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxDOuod+RkPtwaAA--.49519S3;
        Tue, 22 Aug 2023 16:54:00 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxvM6ld+RkwS5gAA--.37979S3;
        Tue, 22 Aug 2023 16:53:58 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v4 1/3] LoongArch: Do not kill the task in die() if notify_die() returns NOTIFY_STOP
Date:   Tue, 22 Aug 2023 16:53:55 +0800
Message-Id: <1692694437-27077-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1692694437-27077-1-git-send-email-yangtiezhu@loongson.cn>
References: <1692694437-27077-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxvM6ld+RkwS5gAA--.37979S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFy8Zr4kGFWxXw4DJry3Jrc_yoW5JFWxpF
        ZFka4DKFZ5CFs5XFyDtF4DuFyUJrZ5G34a9w12k3yS9FnIqw1rXr4kGrWqqa1rt3yrWrWj
        qFZ0gw1SqFZxAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
        Ja73UjIFyTuYvjxUc0eHDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If notify_die() returns NOTIFY_STOP, honor the return value from the
handler chain invocation in die() and return without killing the task
as, through a debugger, the fault may have been fixed. It makes sense
even if ignoring the event will make the system unstable: by allowing
access through a debugger it has been compromised already anyway. It
makes our port consistent with x86, arm64, riscv and csky.

Commit 20c0d2d44029 ("[PATCH] i386: pass proper trap numbers to die
chain handlers") may be the earliest of similar changes.

Link: https://lore.kernel.org/r/43DDF02E.76F0.0078.0@novell.com/
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/ptrace.h |  2 +-
 arch/loongarch/kernel/traps.c       | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index 35f0958..164bc90 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -162,7 +162,7 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long val
 #define instruction_pointer(regs) ((regs)->csr_era)
 #define profile_pc(regs) instruction_pointer(regs)
 
-extern void die(const char *, struct pt_regs *) __noreturn;
+extern void die(const char *, struct pt_regs *);
 
 static inline void die_if_kernel(const char *str, struct pt_regs *regs)
 {
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 8fb5e7a..bbdfc5b 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -383,16 +383,15 @@ void show_registers(struct pt_regs *regs)
 
 static DEFINE_RAW_SPINLOCK(die_lock);
 
-void __noreturn die(const char *str, struct pt_regs *regs)
+void die(const char *str, struct pt_regs *regs)
 {
 	static int die_counter;
-	int sig = SIGSEGV;
+	int ret;
 
 	oops_enter();
 
-	if (notify_die(DIE_OOPS, str, regs, 0, current->thread.trap_nr,
-		       SIGSEGV) == NOTIFY_STOP)
-		sig = 0;
+	ret = notify_die(DIE_OOPS, str, regs, 0,
+			 current->thread.trap_nr, SIGSEGV);
 
 	console_verbose();
 	raw_spin_lock_irq(&die_lock);
@@ -414,7 +413,8 @@ void __noreturn die(const char *str, struct pt_regs *regs)
 	if (panic_on_oops)
 		panic("Fatal exception");
 
-	make_task_dead(sig);
+	if (ret != NOTIFY_STOP)
+		make_task_dead(SIGSEGV);
 }
 
 static inline void setup_vint_size(unsigned int size)
-- 
2.1.0

