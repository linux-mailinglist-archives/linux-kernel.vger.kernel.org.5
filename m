Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4A07ABB30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjIVVhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjIVVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:37:13 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ABAC1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 14:37:07 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c108e106f0so48266161fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 14:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695418625; x=1696023425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Aj65HqLVsJc6wr0Ei1R71U4rjFdiu/xCjSOuKtCaao=;
        b=CJ8yte6b26LQu4zqa93wujjDdKSomyXRjKL7TAQnyoY9XbaX7UhLBOK7n2XTzVAK1V
         /nWJge/v5RQQQx7abcwGCnEV/sSiG9pPHqwGsVqwLbDOBDFbB0mf6D5vkgHXfm/rfYrY
         XCBqs0BH9wWneGd0ELj6shgRD7o17NZdqGMc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695418625; x=1696023425;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Aj65HqLVsJc6wr0Ei1R71U4rjFdiu/xCjSOuKtCaao=;
        b=GxNhuKc4VFJoUb1m+RDzo0ILMva0zi3+k69zpDib8dguHffLOYJzdZKIUPho3y15IT
         VPmvE0VhybozdBZdsGeYNhsQ30rey9rMuEj8scPeYBZ6BOP0ildaYX2kxhzWpQKnzLfQ
         fV9jvs8CR0ERVfe/M8ipwsKxwxByXa3hrUt32TbgmtKgtcjRIiPnWJ7D2kc1ohytpWHj
         diL+LP/8VpsCCbrNf9NdOXb6igrQFTdGUVlf+4qxjPSA90mCk2s2eTW+QWPQ25hg980z
         QxLACBIEOP9EgjB/xSCGQObtO+C2ViQRubji7dtkn6CFxjxKxcpgRgpPgaLt3Y4g2IbF
         tMwA==
X-Gm-Message-State: AOJu0YxN3n1PAO52H1ttGUSry12GWvZmoll6pPY21seIHIQPsSxeJ/u5
        8gQuHGDkruz26ByGTwcJAB9VbLBHykJvY+V76SRe3hRrjfyJYQlS
X-Google-Smtp-Source: AGHT+IGC3A5HBY6nJSO0RkzdieUz+dH2srpmU8jtvZ2P8J7Qq9BCow+cQZd+9IWIkEEbSF5iARfXuqrYwTi1UMIKymk=
X-Received: by 2002:a2e:7305:0:b0:2c0:7e0:2a1 with SMTP id o5-20020a2e7305000000b002c007e002a1mr372196ljc.41.1695418625229;
 Fri, 22 Sep 2023 14:37:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Sep 2023 14:37:04 -0700
MIME-Version: 1.0
In-Reply-To: <20230921161634.4063233-1-mark.rutland@arm.com>
References: <20230921161634.4063233-1-mark.rutland@arm.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 22 Sep 2023 14:37:04 -0700
Message-ID: <CAE-0n52HFOA1k3EJhMTvagneLmxFJg5qu6vTyhVWx1o8s+gR3Q@mail.gmail.com>
Subject: Re: [PATCH v2] lkdtm/bugs: add test for panic() with stuck secondary CPUs
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     dianders@chromium.org, keescook@chromium.org, sumit.garg@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Rutland (2023-09-21 09:16:34)
> Upon a panic() the kernel will use either smp_send_stop() or
> crash_smp_send_stop() to attempt to stop secondary CPUs via an IPI,
> which may or may not be an NMI. Generally it's preferable that this is an
> NMI so that CPUs can be stopped in as many situations as possible, but
> it's not always possible to provide an NMI, and there are cases where
> CPUs may be unable to handle the NMI regardless.
>
> This patch adds a test for panic() where all other CPUs are stuck with
> interrupts disabled, which can be used to check whether the kernel
> gracefully handles CPUs failing to respond to a stop, and whether NMIs
> actually work to stop CPUs.
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
> | Kernel Offset: 0x401cf3490000 from 0xffff80008000000c0
> | PHYS_OFFSET: 0x40000000
> | CPU features: 0x00000000,68c167a1,cce6773f
> | Memory Limit: none
> | ---[ end Kernel panic - not syncing: panic stop irqoff test ]---
>
> Note the "failed to stop secondary CPUs 0-3" message.
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
> Note the absence of a "failed to stop secondary CPUs" message, since we
> don't log anything when secondary CPUs are successfully stopped.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
