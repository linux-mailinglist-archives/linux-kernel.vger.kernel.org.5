Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6637891B9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjHYW2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjHYW1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:27:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B73211C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:27:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500913779f5so2165516e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693002448; x=1693607248;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozIL3ztcMY/CjRnACD5tsgtlWnLwTY4DlCvApQ3YGH8=;
        b=Ov9w9fm79WxSQCPhsJOvhtQl9wezVlm7usWwtpySiNQyWRnOHMCtrRKP9iDDQR5wiz
         uEpyEOsQCfAUrxRj+Fg1pOoOZoau8Ac9zH+X6lspQB/f3kBk6JhesTbnZ0eI8Wyqz+pM
         i9X06ciV6i1kAwgpoqX6YVyLxG8jQ2oS3Eua4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693002448; x=1693607248;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozIL3ztcMY/CjRnACD5tsgtlWnLwTY4DlCvApQ3YGH8=;
        b=NWpu6ygayLeR93ORrYGZ/taEij6Ef/1UDJEAPWD+26+JvIexbfmx4Jg0n+hhyAPlPL
         MlmYnlST1K5cdvWLdXqfag+S7Q0Z5YgP/lLNfXqv2EJyq4GR+joEu7pYdG3tgOhmq89k
         ZfPvoX5z8hYi7gIJtCYoJiQY17emeIMzfwORqbMsqTdBUWDcV3cD5EClQFKBchQN0fxl
         qMWtBchJuf6qtZgk286MmS68Ehg/Ny4xyPgQLKKftM9I5uiH5I4Cdbka28eRT3yF8Wwf
         vKWEXjAt38XhAGTT/rkzIEEZ4XmXyonP1uBgRviO6OhZg9Vs+qOz3ubxQGga2u5x8xig
         raxw==
X-Gm-Message-State: AOJu0YyIpOA6p3DljmqxNM2NexOCH4oY/DmT/BIbUAh5s+zOCZbOCUX8
        9kTJ8mRXhQ7cgrJ3Bmk+wsUAt2G6APtJg3OzZ0dlNg==
X-Google-Smtp-Source: AGHT+IFQRv+LRhmJpKCQ1JJuh/OxEc+CDv/RRDR6yVXx8WifztG0VJqHHXmhp+GvZCUxdtO/gLoTkhk63iMCDLx4NVQ=
X-Received: by 2002:a05:6512:b94:b0:4ff:8c0f:a745 with SMTP id
 b20-20020a0565120b9400b004ff8c0fa745mr17432931lfv.54.1693002448042; Fri, 25
 Aug 2023 15:27:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Aug 2023 17:27:27 -0500
MIME-Version: 1.0
In-Reply-To: <20230824083012.v11.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
References: <20230824153233.1006420-1-dianders@chromium.org> <20230824083012.v11.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Aug 2023 17:27:27 -0500
Message-ID: <CAE-0n52iVDgZa8XT8KTMj12c_ESSJt7f7A0fuZ_oAMMqpGcSzA@mail.gmail.com>
Subject: Re: [PATCH v11 4/6] arm64: smp: Add arch support for backtrace using pseudo-NMI
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Peter Zijlstra <peterz@infradead.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-08-24 08:30:30)
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index fac08e18bcd5..50ce8b697ff3 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -6,6 +6,9 @@
>
>  #include <asm-generic/irq.h>
>
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);

Some nits, but otherwise

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> +
>  struct pt_regs;
>
>  int set_handle_irq(void (*handle_irq)(struct pt_regs *));
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index a5848f1ef817..c8896cbc5327 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -72,12 +73,18 @@ enum ipi_msg_type {
>         IPI_CPU_CRASH_STOP,
>         IPI_TIMER,
>         IPI_IRQ_WORK,
> -       NR_IPI
> +       NR_IPI,
> +       /*
> +        * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
> +        * with trace_ipi_*
> +        */
> +       IPI_CPU_BACKTRACE = NR_IPI,
> +       MAX_IPI
>  };
>
>  static int ipi_irq_base __read_mostly;
>  static int nr_ipi __read_mostly = NR_IPI;
> -static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
> +static struct irq_desc *ipi_desc[MAX_IPI] __read_mostly;

Side note: it would be nice to mark ipi_desc as __ro_after_init. Same
for nr_ipi and ipi_irq_base.

>
>  static void ipi_setup(int cpu);
>
> @@ -845,6 +852,22 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
>  #endif
>  }
>
> +static void arm64_backtrace_ipi(cpumask_t *mask)
> +{
> +       __ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
> +}
> +
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)

Can this be 'bool exclude_self' instead of int? That matches all other
implementations from what I can tell.

> +{
> +       /*
> +        * NOTE: though nmi_trigger_cpumask_backtrace has "nmi_" in the name,

USe nmi_trigger_cpumask_backtrace() to indicate function.

> +        * nothing about it truly needs to be implemented using an NMI, it's
> +        * just that it's _allowed_ to work with NMIs. If ipi_should_be_nmi()
> +        * returned false our backtrace attempt will just use a regular IPI.
> +        */
> +       nmi_trigger_cpumask_backtrace(mask, exclude_cpu, arm64_backtrace_ipi);
