Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E2A78F329
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbjHaTP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjHaTP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:15:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA76AE65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:15:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68bed8de5b9so970615b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693509353; x=1694114153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1x5/SqaXiXZ3Mg7nI4pf+vs5JyKacgMjQR8po9yiRXE=;
        b=oYco/B03bSO4+Li4WRgcP7OgC0LgrlKf7O4Pns9tL9TsGLkeukBXv/1rVUwmR6Yb++
         AjLW8IFpB1MtSYk/iCHpjzBu+v9XnP3HUsItx+fgaGhNESALtRBrLZfOWlszVODWiG1x
         N9skvdM/vOXcA8JTqrPBapjPx/MNqT1Wq12wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693509353; x=1694114153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x5/SqaXiXZ3Mg7nI4pf+vs5JyKacgMjQR8po9yiRXE=;
        b=JxPmtS4Zz1F3hrgDphk7BDO0SlleAoeLhEsW/z9U3tjQ9MnDmO/YzYgGiYnjPRDGSz
         HMdcRWQWngKumodgIzrZzoCApJmp2dCAFGAUOlWqvMZpdXH0AZP2FOiVRUCdGdNkxB5l
         uzhhxcaZmg12NG8Dv8uK297KDVnoa1r4dj4AUW2WKuINL4HyaAm/peJ22LVAeN9G9iw/
         uhT9SkL6R6uJRgzWeyyfURKOtcd4bQaok4L26Z18EeNYfVZwaT3YzxwKk34ko19dUpYq
         P4QuBiitAvbGihG9ZIR2GvclBJK78b5n+lUNHFmxMfoI+jAVyV91wIq/A9gHMtjas335
         ea7Q==
X-Gm-Message-State: AOJu0Yx483zoghwU2LmB5wlOPEO/awT8qh4mN0Hoe19QSK67LZfb2+5n
        HVgLvz4oYNyVemdm3mBsqzTO47oGCgJ4AI+t76c=
X-Google-Smtp-Source: AGHT+IFyi/N98RE5Aute8sb9pjHKGlmxMIqzjq/zmtUqBtm1fVdKa91iY8P9XutUgrsGy/HqMrRMIQ==
X-Received: by 2002:a05:6a00:2484:b0:68b:e7d4:2564 with SMTP id c4-20020a056a00248400b0068be7d42564mr711944pfv.24.1693509353237;
        Thu, 31 Aug 2023 12:15:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cg11-20020a056a00290b00b0068c9fc82bfbsm542906pfb.197.2023.08.31.12.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 12:15:52 -0700 (PDT)
Date:   Thu, 31 Aug 2023 12:15:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, dianders@chromium.org,
        sumit.garg@linaro.org, swboyd@chromium.org
Subject: Re: [PATCH] lkdtm/bugs: add test for panic() with stuck secondary
 CPUs
Message-ID: <202308311215.BA352518C@keescook>
References: <20230831101026.3122590-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831101026.3122590-1-mark.rutland@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 11:10:26AM +0100, Mark Rutland wrote:
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
>  	panic("dumptest");
>  }
>  
> +static int panic_stop_irqoff_fn(void *arg)
> +{
> +	atomic_t *v = arg;
> +
> +	/*
> +	 * Trigger the panic after all other CPUs have entered this function,
> +	 * so that they are guaranteed to have IRQs disabled.
> +	 */
> +	if (atomic_inc_return(v) == num_online_cpus())
> +		panic("panic stop irqoff test");
> +
> +	for (;;)
> +		cpu_relax();
> +}
> +
> +static void lkdtm_PANIC_STOP_IRQOFF(void)
> +{
> +	atomic_t v = ATOMIC_INIT(0);
> +
> +	cpus_read_lock();
> +	stop_machine(panic_stop_irqoff_fn, &v, cpu_online_mask);
> +	cpus_read_unlock();
> +}
> +
>  static void lkdtm_BUG(void)
>  {
>  	BUG();
> @@ -598,6 +624,7 @@ static noinline void lkdtm_CORRUPT_PAC(void)
>  
>  static struct crashtype crashtypes[] = {
>  	CRASHTYPE(PANIC),
> +	CRASHTYPE(PANIC_STOP_IRQOFF),
>  	CRASHTYPE(BUG),
>  	CRASHTYPE(WARNING),
>  	CRASHTYPE(WARNING_MESSAGE),

Modulo the other comments in the thread, this looks good to me. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
