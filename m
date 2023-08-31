Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C08F78ED89
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243801AbjHaMpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjHaMpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:45:43 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDC9CDB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:45:41 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7a52a1e2a59so362333241.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693485940; x=1694090740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SUPdAvyK7mqoAuNRYXvbr2OqxVUWD+npGsy0fsNnIgw=;
        b=TM2NgME/28cKDAjlG967whN9esMV0CpUfZPFUnxhYz/ulDg90AgLiknt2PEnIJJuC7
         iU6pc4RIZ5FK3ezPK2rn8xrPgGcC3iMeaWB8E/NlxJEfT3KgLIFeOiw4Sa7GwbppJukn
         0qDfNdgcUbWIwnCah1RBQFe/D2UaNS/mAMRS5vw8JVoMZzqtuFijBShH97Iptd1u/reu
         MMoTSk3wdSkREGp+e1aWj5GxtXpPBEWgvkS3INA3OYLTMCFl5qLPvgSTX8rUyCqIZ+Et
         MOwrl44qgzoYtL8USOUiCz7mXOLgGFLw/lN9iCgWyk+w0yCEPbMRQn3Q/c594WM/UHj/
         kP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693485940; x=1694090740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUPdAvyK7mqoAuNRYXvbr2OqxVUWD+npGsy0fsNnIgw=;
        b=agev2BUATk3IBBqBILLD7B2mIxWe+0sedsUITHBbQYrlcP4dc7Lktjs213vC4kwNtc
         Jiu6Vk5bkaNV0dWBDEIOWZh5Ic6YFZwMTm+SOEOqFiSHXG8oUFvXaaWhOn13T7mrniF8
         inpuN0ollylLZ968cNPhn/grX/NkllLyYJv2LCu5Si4iRpFpdtCr9/1VN+35gi6rp5to
         aHYbQwLr2lLcJQJWH/Miqb1qzoFR6F6YuWk2o7wNbtR2KEIsdFyfn1xcEKSKO2j+OzeA
         flRLoMgNgJCdONfYJSFF8dM5iwAWDLhvxWY/tRkAl6w/jRPI3QW+qzvgNG1amiTk4bHX
         roqA==
X-Gm-Message-State: AOJu0Yx3MovnMyOlHysJ0Nwps3q5jJPoM5D06VsDU6MuAiKRM7K+1qHa
        eKOT/g6rvycINxpgVp1BmfMcSArJsRGUetSYuAHAQg==
X-Google-Smtp-Source: AGHT+IF7WYBaWa0uR0F9qAG1X0xhaJtUDRl/VDmF2AmvBJUivffkkcBgcjUNNrNtWBEk1xgXWShcGmI5G6u/6xbhFDY=
X-Received: by 2002:a67:ef94:0:b0:44e:dece:6b38 with SMTP id
 r20-20020a67ef94000000b0044edece6b38mr5082561vsp.23.1693485940123; Thu, 31
 Aug 2023 05:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230831101026.3122590-1-mark.rutland@arm.com>
In-Reply-To: <20230831101026.3122590-1-mark.rutland@arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 31 Aug 2023 18:15:29 +0530
Message-ID: <CAFA6WYPSbzi5ZKaEdsigtJgdxaK0NXSa_Qyc+_qAvUjqonw10g@mail.gmail.com>
Subject: Re: [PATCH] lkdtm/bugs: add test for panic() with stuck secondary CPUs
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, dianders@chromium.org,
        keescook@chromium.org, swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for putting up a test case for this.

On Thu, 31 Aug 2023 at 15:40, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Upon a panic() the kernel will use either smp_send_stop() or
> crash_smp_send_stop() to attempt to stop secondary CPUs via an IPI,
> which may or may not be an NMI. Generally it's preferable that this is an
> NMI so that CPUs can be stopped in as many situations as possible, but
> it's not always possible to provide an NMI, and there are cases where
> CPUs may be unable to handle the NMI regardless.
>
> This patch adds a test for panic() where all other CPUs are stuck with
> interrupts disabled, which can be used to check whether the kernel
> gracefully handles CPUs failing to respond to a stop, and whe NMIs stops

s/whe/when/

> work.
>
> For example, on arm64 *without* an NMI, this results in:
>
> | # echo PANIC_STOP_IRQOFF > /sys/kernel/debug/provoke-crash/DIRECT
> | lkdtm: Performing direct entry PANIC_STOP_IRQOFF
> | Kernel panic - not syncing: panic stop irqoff test
> | CPU: 2 PID: 24 Comm: migration/2 Not tainted 6.5.0-rc3-00077-ge6c782389895-dirty #4
> | Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> | Stopper: multi_cpu_stop+0x0/0x1a0 <- stop_machine_cpuslocked+0x158/0x1a4
> | Call trace:
> |  dump_backtrace+0x94/0xec
> |  show_stack+0x18/0x24
> |  dump_stack_lvl+0x74/0xc0
> |  dump_stack+0x18/0x24
> |  panic+0x358/0x3e8
> |  lkdtm_PANIC+0x0/0x18
> |  multi_cpu_stop+0x9c/0x1a0
> |  cpu_stopper_thread+0x84/0x118
> |  smpboot_thread_fn+0x224/0x248
> |  kthread+0x114/0x118
> |  ret_from_fork+0x10/0x20
> | SMP: stopping secondary CPUs
> | SMP: failed to stop secondary CPUs 0-3
> | Kernel Offset: 0x401cf3490000 from 0xffff800080000000
> | PHYS_OFFSET: 0x40000000
> | CPU features: 0x00000000,68c167a1,cce6773f
> | Memory Limit: none
> | ---[ end Kernel panic - not syncing: panic stop irqoff test ]---
>
> On arm64 *with* an NMI, this results in:

I suppose a more interesting test scenario to show difference among
NMI stop IPI and regular stop IPI would be:

- First put any CPU into hard lockup state via:
   $ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT

- And then provoke following from other CPU:
   $ echo PANIC_STOP_IRQOFF > /sys/kernel/debug/provoke-crash/DIRECT

>
> | # echo PANIC_STOP_IRQOFF > /sys/kernel/debug/provoke-crash/DIRECT
> | lkdtm: Performing direct entry PANIC_STOP_IRQOFF
> | Kernel panic - not syncing: panic stop irqoff test
> | CPU: 1 PID: 19 Comm: migration/1 Not tainted 6.5.0-rc3-00077-ge6c782389895-dirty #4
> | Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> | Stopper: multi_cpu_stop+0x0/0x1a0 <- stop_machine_cpuslocked+0x158/0x1a4
> | Call trace:
> |  dump_backtrace+0x94/0xec
> |  show_stack+0x18/0x24
> |  dump_stack_lvl+0x74/0xc0
> |  dump_stack+0x18/0x24
> |  panic+0x358/0x3e8
> |  lkdtm_PANIC+0x0/0x18
> |  multi_cpu_stop+0x9c/0x1a0
> |  cpu_stopper_thread+0x84/0x118
> |  smpboot_thread_fn+0x224/0x248
> |  kthread+0x114/0x118
> |  ret_from_fork+0x10/0x20
> | SMP: stopping secondary CPUs
> | Kernel Offset: 0x55a9c0bc0000 from 0xffff800080000000
> | PHYS_OFFSET: 0x40000000
> | CPU features: 0x00000000,68c167a1,fce6773f
> | Memory Limit: none
> | ---[ end Kernel panic - not syncing: panic stop irqoff test ]---
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org
> Cc: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/misc/lkdtm/bugs.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> I've tested this with the arm64 NMI IPI patches:
>
>   https://lore.kernel.org/linux-arm-kernel/20230830191314.1618136-1-dianders@chromium.org/
>
> Specifically, with the patch that uses an NMI for IPI_CPU_STOP and
> IPI_CPU_CRASH_STOP:
>
>   https://lore.kernel.org/linux-arm-kernel/20230830121115.v12.5.Ifadbfd45b22c52edcb499034dd4783d096343260@changeid/
>
> Mark.
>
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 3c95600ab2f71..368da8b83cd1c 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -6,12 +6,14 @@
>   * test source files.
>   */
>  #include "lkdtm.h"
> +#include <linux/cpu.h>
>  #include <linux/list.h>
>  #include <linux/sched.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/task_stack.h>
> -#include <linux/uaccess.h>
>  #include <linux/slab.h>
> +#include <linux/stop_machine.h>
> +#include <linux/uaccess.h>
>
>  #if IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_UML)
>  #include <asm/desc.h>
> @@ -73,6 +75,30 @@ static void lkdtm_PANIC(void)
>         panic("dumptest");
>  }
>
> +static int panic_stop_irqoff_fn(void *arg)
> +{
> +       atomic_t *v = arg;
> +
> +       /*
> +        * Trigger the panic after all other CPUs have entered this function,
> +        * so that they are guaranteed to have IRQs disabled.
> +        */
> +       if (atomic_inc_return(v) == num_online_cpus())
> +               panic("panic stop irqoff test");
> +
> +       for (;;)
> +               cpu_relax();
> +}
> +
> +static void lkdtm_PANIC_STOP_IRQOFF(void)
> +{
> +       atomic_t v = ATOMIC_INIT(0);
> +
> +       cpus_read_lock();
> +       stop_machine(panic_stop_irqoff_fn, &v, cpu_online_mask);
> +       cpus_read_unlock();

stop_machine() does internally use cpus_read_{lock/unlock}(), is there
any need to have them here as well?

-Sumit

> +}
> +
>  static void lkdtm_BUG(void)
>  {
>         BUG();
> @@ -598,6 +624,7 @@ static noinline void lkdtm_CORRUPT_PAC(void)
>
>  static struct crashtype crashtypes[] = {
>         CRASHTYPE(PANIC),
> +       CRASHTYPE(PANIC_STOP_IRQOFF),
>         CRASHTYPE(BUG),
>         CRASHTYPE(WARNING),
>         CRASHTYPE(WARNING_MESSAGE),
> --
> 2.30.2
>
