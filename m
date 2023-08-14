Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8114277AFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjHNC6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjHNC6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:58:25 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C20E9109
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 19:58:23 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8DxBfFKmNlkmdoXAA--.49463S3;
        Mon, 14 Aug 2023 10:58:18 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfSNImNlkHEJZAA--.41237S3;
        Mon, 14 Aug 2023 10:58:17 +0800 (CST)
Message-ID: <06cf8750-901d-2f65-fb9e-81980688e017@loongson.cn>
Date:   Mon, 14 Aug 2023 10:58:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/10] loongson: Fix idle VS timer enqueue
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        WANG Xuerui <kernel@xen0n.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <20230811170049.308866-1-frederic@kernel.org>
 <20230811170049.308866-5-frederic@kernel.org>
Content-Language: en-US
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <20230811170049.308866-5-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfSNImNlkHEJZAA--.41237S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WF1rXF4DXF17uFyDZw4fWFX_yoW7XFWfpF
        WUCwn8Krs5Wrn3Xa47Jw18ur98u34DG3ya9an0yrW8AF4UZr1UXw1vv3s2ga4Yg3y8Gw1S
        vFn5Xa4293WUA3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
        6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Add huacai

asm instruction move should be replaced with li.w, the other looks good to me.

diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 359d693f112e..8a98023ecafd 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -19,7 +19,7 @@
        .align  5
 SYM_FUNC_START(__arch_cpu_idle)
        /* start of idle interrupt region */
-       move    t0, CSR_CRMD_IE
+       li.w    t0, CSR_CRMD_IE
        csrxchg t0, t0, LOONGARCH_CSR_CRMD
        /*
         * If an interrupt lands here; between enabling interrupts above and

By the way __arch_cpu_idle is called by machine_halt/machine_power_off etc,
irq will be enabled with new patch. Need we add something like this?

diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
index 1ef8c6383535..9ecd42c0c804 100644
--- a/arch/loongarch/kernel/reset.c
+++ b/arch/loongarch/kernel/reset.c
@@ -20,6 +20,11 @@
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
+static __always_inline void native_halt(void)
+{
+       asm volatile("idle 0": : :"memory");
+}
+
 void machine_halt(void)
 {
 #ifdef CONFIG_SMP
@@ -32,9 +37,9 @@ void machine_halt(void)
        pr_notice("\n\n** You can safely turn off the power now **\n\n");
        console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
-       while (true) {
-               __arch_cpu_idle();
-       }
+       while (1) {
+               native_halt();
+       };
 }
 
 void machine_power_off(void)
@@ -52,9 +57,9 @@ void machine_power_off(void)
        efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
 #endif
 
-       while (true) {
-               __arch_cpu_idle();
-       }
+       while (1) {
+               native_halt();
+       };
 }
 
 void machine_restart(char *command)
@@ -73,7 +78,7 @@ void machine_restart(char *command)
        if (!acpi_disabled)
                acpi_reboot();
 
-       while (true) {
-               __arch_cpu_idle();
-       }
+       while (1) {
+               native_halt();
+       };
 }

Regards
Bibo Mao

在 2023/8/12 01:00, Frederic Weisbecker 写道:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Loongson re-enables interrupts on its idle routine and performs a
> TIF_NEED_RESCHED check afterwards before putting the CPU to sleep.
> 
> The IRQs firing between the check and the idling instruction may set the
> TIF_NEED_RESCHED flag. In order to deal with the such a race, IRQs
> interrupting __arch_cpu_idle() rollback their return address to the
> beginning of __arch_cpu_idle() so that TIF_NEED_RESCHED is checked
> again before going back to sleep.
> 
> However idle IRQs can also queue timers that may require a tick
> reprogramming through a new generic idle loop iteration but those timers
> would go unnoticed here because __arch_cpu_idle() only checks
> TIF_NEED_RESCHED. It doesn't check for pending timers.
> 
> Fix this with fast-forwarding idle IRQs return value to the end of the
> idle routine instead of the beginning, so that the generic idle loop
> handles both TIF_NEED_RESCHED and pending timers.
> 
> Fixes: 0603839b18f4 (LoongArch: Add exception/interrupt handling)
> Tested-by: Bibo, Mao <maobibo@loongson.cn>
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  arch/loongarch/kernel/genex.S | 32 ++++++++++++++++++--------------
>  arch/loongarch/kernel/idle.c  |  1 -
>  2 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
> index 78f066384657..359d693f112e 100644
> --- a/arch/loongarch/kernel/genex.S
> +++ b/arch/loongarch/kernel/genex.S
> @@ -18,27 +18,31 @@
>  
>  	.align	5
>  SYM_FUNC_START(__arch_cpu_idle)
> -	/* start of rollback region */
> -	LONG_L	t0, tp, TI_FLAGS
> -	nop
> -	andi	t0, t0, _TIF_NEED_RESCHED
> -	bnez	t0, 1f
> -	nop
> -	nop
> -	nop
> +	/* start of idle interrupt region */
> +	move	t0, CSR_CRMD_IE
> +	csrxchg	t0, t0, LOONGARCH_CSR_CRMD
> +	/*
> +	 * If an interrupt lands here; between enabling interrupts above and
> +	 * going idle on the next instruction, we must *NOT* go idle since the
> +	 * interrupt could have set TIF_NEED_RESCHED or caused an timer to need
> +	 * reprogramming. Fall through -- see handle_vint() below -- and have
> +	 * the idle loop take care of things.
> +	 */
>  	idle	0
> -	/* end of rollback region */
> -1:	jr	ra
> +	nop
> +	/* end of idle interrupt region */
> +SYM_INNER_LABEL(__arch_cpu_idle_exit, SYM_L_LOCAL)
> +	jr	ra
>  SYM_FUNC_END(__arch_cpu_idle)
>  
>  SYM_FUNC_START(handle_vint)
>  	BACKUP_T0T1
>  	SAVE_ALL
> -	la_abs	t1, __arch_cpu_idle
> +	la_abs	t1, __arch_cpu_idle_exit
>  	LONG_L	t0, sp, PT_ERA
> -	/* 32 byte rollback region */
> -	ori	t0, t0, 0x1f
> -	xori	t0, t0, 0x1f
> +	/* 16 byte idle interrupt region */
> +	ori	t0, t0, 0x0f
> +	addi.d	t0, t0, 1
>  	bne	t0, t1, 1f
>  	LONG_S	t0, sp, PT_ERA
>  1:	move	a0, sp
> diff --git a/arch/loongarch/kernel/idle.c b/arch/loongarch/kernel/idle.c
> index 0b5dd2faeb90..5ba72d229920 100644
> --- a/arch/loongarch/kernel/idle.c
> +++ b/arch/loongarch/kernel/idle.c
> @@ -11,7 +11,6 @@
>  
>  void __cpuidle arch_cpu_idle(void)
>  {
> -	raw_local_irq_enable();
>  	__arch_cpu_idle(); /* idle instruction needs irq enabled */
>  	raw_local_irq_disable();
>  }

