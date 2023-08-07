Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE0A771B92
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjHGHfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjHGHfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:35:43 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A2010EC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 00:35:40 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-4871e54ee84so658650e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 00:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691393739; x=1691998539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVDqCkVf2XQJK4O1h6mLmsszxeVizs+vrchmcAeH1mM=;
        b=GgZc4HVbVwBDtKoa8hzpHopMi8083b3Mz9ORzFnG0n+Pm7hf19v0EsjuiZnteADzK9
         WVWsARUSgVcKqWXhJOGFSMBSgu3FFxGgoi8u9arCf2twrbwyJYuSgeuR4dyTSMjajF0v
         I8n7QluuJu6VAySsM5yLOwBZ9Gf6kyjHCK/fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691393739; x=1691998539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVDqCkVf2XQJK4O1h6mLmsszxeVizs+vrchmcAeH1mM=;
        b=X++m1TupLx3Zn/iVKfzQWtrSAjDFR1rKmLYmFI1ppN3f5eikWDLW/y9Tvje9PtzTRa
         oszUnDXu7euHOJacvVVV3CHHpd2VATWdacbwIHdRoJlU5thh6yOAr8LI4FNKyLjjPOW5
         c2KBWxrKCjSFriAnOtUano11mRuSOx3RvdqiE985VYbqMWLMb16mdDrktAE9bX5VVxig
         TifAYseaoNB8Ou4wVAxQZ6c7jzeo3SB7gLQdHvFafqQ8SQi5Ohkgxq4iWzCui2rqi84F
         MuJzVKguybUmFDK536rWLr5DXULr8m4UhchtP8Njmtx0ySsuGaXls4XYbTXjWXdC5i/x
         deGg==
X-Gm-Message-State: AOJu0YzB3NNTC+CC2x8F/Zs9jhDKuTessWZwXqfEtKN4A3K5JGt0kb9T
        sTtsxx2nsWA55wjWW4TKUMp6YA5PgNUgxJYiM7r1pw==
X-Google-Smtp-Source: AGHT+IH6RRAXW8L9icGAFpz10EPAQT37UfLDWhYNXFPOSg/fZtT1eceWby7rBEWIJ0DFUgS7mF/xa7sdfTT+OUG3tjs=
X-Received: by 2002:a1f:c8c2:0:b0:486:42c1:5f57 with SMTP id
 y185-20020a1fc8c2000000b0048642c15f57mr2773409vkf.5.1691393739460; Mon, 07
 Aug 2023 00:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230804065935.v4.1.Ia35521b91fc781368945161d7b28538f9996c182@changeid>
In-Reply-To: <20230804065935.v4.1.Ia35521b91fc781368945161d7b28538f9996c182@changeid>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 7 Aug 2023 15:35:28 +0800
Message-ID: <CAGXv+5HtYi_9mWr+m-oufYiRTzXaGRFBtqSeqbwgE2a=bYNPug@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] nmi_backtrace: Allow excluding an arbitrary CPU
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Michal Hocko <mhocko@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 10:01=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> The APIs that allow backtracing across CPUs have always had a way to
> exclude the current CPU. This convenience means callers didn't need to
> find a place to allocate a CPU mask just to handle the common case.
>
> Let's extend the API to take a CPU ID to exclude instead of just a
> boolean. This isn't any more complex for the API to handle and allows
> the hardlockup detector to exclude a different CPU (the one it already
> did a trace for) without needing to find space for a CPU mask.
>
> Arguably, this new API also encourages safer behavior. Specifically if
> the caller wants to avoid tracing the current CPU (maybe because they
> already traced the current CPU) this makes it more obvious to the
> caller that they need to make sure that the current CPU ID can't
> change.
>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v4:
> - Renamed trigger_allbutself_cpu_backtrace() for when trigger is unsuppor=
ted.
>
> Changes in v3:
> - ("nmi_backtrace: Allow excluding an arbitrary CPU") new for v3.
>
>  arch/arm/include/asm/irq.h       |  2 +-
>  arch/arm/kernel/smp.c            |  4 ++--
>  arch/loongarch/include/asm/irq.h |  2 +-
>  arch/loongarch/kernel/process.c  |  4 ++--
>  arch/mips/include/asm/irq.h      |  2 +-
>  arch/mips/kernel/process.c       |  4 ++--
>  arch/powerpc/include/asm/irq.h   |  2 +-
>  arch/powerpc/kernel/stacktrace.c |  4 ++--
>  arch/powerpc/kernel/watchdog.c   |  4 ++--
>  arch/sparc/include/asm/irq_64.h  |  2 +-
>  arch/sparc/kernel/process_64.c   |  6 +++---
>  arch/x86/include/asm/irq.h       |  2 +-
>  arch/x86/kernel/apic/hw_nmi.c    |  4 ++--
>  include/linux/nmi.h              | 14 +++++++-------
>  kernel/watchdog.c                |  2 +-
>  lib/nmi_backtrace.c              |  6 +++---
>  16 files changed, 32 insertions(+), 32 deletions(-)
>

[...]

> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index e3e6a64b98e0..7cf7801856a1 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -157,31 +157,31 @@ static inline void touch_nmi_watchdog(void)
>  #ifdef arch_trigger_cpumask_backtrace
>  static inline bool trigger_all_cpu_backtrace(void)
>  {
> -       arch_trigger_cpumask_backtrace(cpu_online_mask, false);
> +       arch_trigger_cpumask_backtrace(cpu_online_mask, -1);
>         return true;
>  }
>
> -static inline bool trigger_allbutself_cpu_backtrace(void)
> +static inline bool trigger_allbutcpu_cpu_backtrace(int exclude_cpu)
>  {
> -       arch_trigger_cpumask_backtrace(cpu_online_mask, true);
> +       arch_trigger_cpumask_backtrace(cpu_online_mask, exclude_cpu);
>         return true;
>  }
>
>  static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
>  {
> -       arch_trigger_cpumask_backtrace(mask, false);
> +       arch_trigger_cpumask_backtrace(mask, -1);
>         return true;
>  }
>
>  static inline bool trigger_single_cpu_backtrace(int cpu)
>  {
> -       arch_trigger_cpumask_backtrace(cpumask_of(cpu), false);
> +       arch_trigger_cpumask_backtrace(cpumask_of(cpu), -1);
>         return true;
>  }
>
>  /* generic implementation */
>  void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
> -                                  bool exclude_self,
> +                                  int exclude_cpu,
>                                    void (*raise)(cpumask_t *mask));
>  bool nmi_cpu_backtrace(struct pt_regs *regs);
>
> @@ -190,7 +190,7 @@ static inline bool trigger_all_cpu_backtrace(void)
>  {
>         return false;
>  }
> -static inline bool trigger_allbutself_cpu_backtrace(void)
> +static inline bool trigger_allbutcpu_cpu_backtrace(void)
                                                      ^
The parameter here is still wrong. It should be "int exclude_cpu".

This patch in Andrew's queue is causing build errors on next-20230807 on ar=
m64:

kernel/watchdog.c: In function =E2=80=98watchdog_timer_fn=E2=80=99:
kernel/watchdog.c:521:25: error: too many arguments to function
=E2=80=98trigger_allbutcpu_cpu_backtrace=E2=80=99
  521 |
trigger_allbutcpu_cpu_backtrace(smp_processor_id());
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from kernel/watchdog.c:17:
./include/linux/nmi.h:193:20: note: declared here
  193 | static inline bool trigger_allbutcpu_cpu_backtrace(void)
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:243: kernel/watchdog.o] Error 1


ChenYu
