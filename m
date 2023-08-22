Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9337C784D66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjHVXj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjHVXj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:39:56 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0ABCD7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:39:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ffae5bdc9aso5611330e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692747593; x=1693352393;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBnThSAKzhzR9rSGGQ+uW8RCv4yp0DSEOJ+0TVL56nk=;
        b=QsWKy1jTDTWB52uTxFOi3zfsOweTLAKE3PIHrsWhMpiDKzBr4toJGch4TKmtMUvYqG
         3GzQ1U9eZDhrRAtWdnMSLfjPzssVgU4ZTTvsHDjNjP5dg8GL+S8oOqqlNglvm4NnylKc
         6+zHhcCs50LUOHQJb0msu4XGtH1LwbJGc0ftU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692747593; x=1693352393;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBnThSAKzhzR9rSGGQ+uW8RCv4yp0DSEOJ+0TVL56nk=;
        b=i7vQHfyZTfJmcgaLRapOcFU1n93Gf4zEEfqlIl4nTHlT9TbpXn8OilwBkOk54ZcUGl
         pINNWX6bHXAOaRjMTgkitd+Rc+rkYpbT32mLAxmRNInzSR/9Iz63PraroPiwrzYwY8aq
         /b4YTE40QgZrH6ZLD7X04n5qgqalxL3RWJOeA+MPvu6D5xDGwHMgVAJ0jkoTSrNM78Rs
         mDzs7shsNl4bC4McJzM2JoQiCoS61tLqfZbNV+Xk7AXHxOJiuBQ9zFlDIvET5YwJAgaY
         /LoZwr2tSFMaFqmxkQXumgU+s7edVG7f6PWWtRdy01AetIHAeMFtigfgIgR/yCi600OF
         Oueg==
X-Gm-Message-State: AOJu0YyyNO0nCdFKO4JCSynyb0PMEObk7k6D2zlbqHpaBvB6zTlDioy7
        zRoNzSbDe/dt8BL+7IMsfkdxXblbO5EGu4Fwo90F5w==
X-Google-Smtp-Source: AGHT+IGU9ghgpnimdTBYx+LsvN3eXoAUQ0e5d7XJpOiOkBBJbb3/8kf+cIH2Muh6sY0AYdzIn/S1uuiuvJTrDHYspL8=
X-Received: by 2002:a05:6512:3045:b0:4fb:89b3:3374 with SMTP id
 b5-20020a056512304500b004fb89b33374mr9771049lfb.54.1692747592254; Tue, 22 Aug
 2023 16:39:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Aug 2023 16:39:51 -0700
MIME-Version: 1.0
In-Reply-To: <20230822142644.v10.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
References: <20230822212927.249645-1-dianders@chromium.org> <20230822142644.v10.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Aug 2023 16:39:51 -0700
Message-ID: <CAE-0n52ZLr0qZ=9zN0kcXK2G5=sGKizGg5F9z4pLPjY_Xv6OJw@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] arm64: smp: Add arch support for backtrace using pseudo-NMI
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
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

Quoting Douglas Anderson (2023-08-22 14:26:59)
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index bfe60adbc453..15b66dc1391b 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -845,6 +852,22 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
>  #endif
>  }
>
> +void arm64_backtrace_ipi(cpumask_t *mask)
> +{
> +       __ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
> +}
> +
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
> +{
> +       /*
> +        * NOTE: though nmi_trigger_cpumask_backtrace has "nmi_" in the name,
> +        * nothing about it truly needs to be backed by an NMI, it's just that
> +        * it's _allowed_ to work with NMIs. If ipi_should_be_nmi() returned
> +        * false our backtrace attempt will just be backed by a regular IPI.

I think "backed by" is an idiom and may be confusing. Simplify by
replacing "backed by" with "implemented using"?

> +        */
> +       nmi_trigger_cpumask_backtrace(mask, exclude_cpu, arm64_backtrace_ipi);
> +}
> +
>  /*
>   * Main handler for inter-processor interrupts
>   */
