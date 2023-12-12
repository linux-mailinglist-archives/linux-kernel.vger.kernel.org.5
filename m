Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BFC80ECEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbjLLNM5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 08:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjLLNMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:12:55 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65ACEA;
        Tue, 12 Dec 2023 05:13:00 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5907e590360so221505eaf.0;
        Tue, 12 Dec 2023 05:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386780; x=1702991580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZiekd6TMTN79zhiJzCBM900PNBrHuNin9FsPCmBi6Y=;
        b=OYvHNtAFcwTxsQ9UOPW6icwmudqdCMr8ypGHO70YW030oZGry2YMvCIhcDLoM+B3Ki
         arYd1opb5rKl5zk1HYeFZVU81+o3MIITQe2DGdZYfUyy7yTsJ9iGmGm9m63Hm3817xlw
         MWpXM+bLgWGP/rHxd4pBwHQqcu2xAK/nmqU9v15E3ilbcXUI7JaOEf2VJH0YSBdxcPyN
         WAlgkk+4+K9br+tLSnOZO9YL0ENVBrBUscHiJIhAmveXZpaQmrpZ4Qbvxqdt+Cj+9NSA
         0iwwTEcBoTlvcVr0nG4G45SdqiHs/HungRColgYC5BMklsuRPmCo0qYujIHHCaH2c4Dp
         frtg==
X-Gm-Message-State: AOJu0Yxy92dza6PeJ2duOGpoZkWkHfPn+abKtDb0poyYxvs2kFOKx5Ny
        nWAyV1DuVKL63INtDb51pNby38IKwT9qsAJacLQ=
X-Google-Smtp-Source: AGHT+IHZergMGKsB1qeUEJDcJagnEQWDtjTNIq11xdW+3VbhA4u4/HHi/R4XXZasL5cePjagCjLdBqgbth48BStDFzo=
X-Received: by 2002:a4a:c487:0:b0:58d:ddcb:db1a with SMTP id
 f7-20020a4ac487000000b0058dddcbdb1amr10094641ooq.1.1702386779713; Tue, 12 Dec
 2023 05:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20231124223226.24249-1-frederic@kernel.org> <20231124223226.24249-6-frederic@kernel.org>
In-Reply-To: <20231124223226.24249-6-frederic@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 14:12:48 +0100
Message-ID: <CAJZ5v0jVtGYM8ETn2V2Ovct4SkpFaU-xZMyZJAOysu42OiuRiw@mail.gmail.com>
Subject: Re: [PATCH 5/7] cpuidle: Introduce CPUIDLE_FLAG_POLLING_HARD
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:32 PM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> Provide a way to tell the cpuidle core about states polling/monitoring
> TIF_NEED_RESCHED on the hardware level, monitor/mwait users being the
> only examples in use.
>
> This will allow cpuidle core to manage TIF_NR_POLLING on behalf of all
> kinds of TIF_NEED_RESCHED polling states while keeping a necessary
> distinction for the governors between software loops polling on
> TIF_NEED_RESCHED and hardware monitored writes to thread flags.
>
> [fweisbec: _ Initialize flag from acpi_processor_setup_cstates() instead
>              of acpi_processor_setup_lpi_states(), as the latter seem to
>              be about arm64...
>            _ Rename CPUIDLE_FLAG_NO_IPI to CPUIDLE_FLAG_POLLING_HARD]
>
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  drivers/acpi/processor_idle.c | 3 +++
>  drivers/idle/intel_idle.c     | 5 ++++-
>  include/linux/cpuidle.h       | 3 ++-
>  3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 3a34a8c425fe..a77a4d4b0dad 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -814,6 +814,9 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>                         if (cx->type != ACPI_STATE_C3)
>                                 drv->safe_state_index = count;
>                 }
> +
> +               if (cx->entry_method == ACPI_CSTATE_FFH)
> +                       state->flags |= CPUIDLE_FLAG_POLLING_HARD;
>                 /*
>                  * Halt-induced C1 is not good for ->enter_s2idle, because it
>                  * re-enables interrupts on exit.  Moreover, C1 is generally not
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 3e01a6b23e75..bc56624fe0b5 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1563,7 +1563,8 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
>                 if (cx->type > ACPI_STATE_C1)
>                         state->target_residency *= 3;
>
> -               state->flags = MWAIT2flg(cx->address);
> +               state->flags = MWAIT2flg(cx->address) | CPUIDLE_FLAG_POLLING_HARD;
> +
>                 if (cx->type > ACPI_STATE_C2)
>                         state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
>
> @@ -1836,6 +1837,8 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
>
>  static void state_update_enter_method(struct cpuidle_state *state, int cstate)
>  {
> +       state->flags |= CPUIDLE_FLAG_POLLING_HARD;
> +
>         if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
>                 /*
>                  * Combining with XSTATE with IBRS or IRQ_ENABLE flags
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 66b59868622c..873fdf200dc3 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -78,13 +78,14 @@ struct cpuidle_state {
>
>  /* Idle State Flags */
>  #define CPUIDLE_FLAG_NONE              (0x00)
> -#define CPUIDLE_FLAG_POLLING_SOFT              BIT(0) /* polling state */
> +#define CPUIDLE_FLAG_POLLING_SOFT      BIT(0) /* software need_resched() polling state */
>  #define CPUIDLE_FLAG_COUPLED           BIT(1) /* state applies to multiple cpus */
>  #define CPUIDLE_FLAG_TIMER_STOP        BIT(2) /* timer is stopped on this state */
>  #define CPUIDLE_FLAG_UNUSABLE          BIT(3) /* avoid using this state */
>  #define CPUIDLE_FLAG_OFF               BIT(4) /* disable this state by default */
>  #define CPUIDLE_FLAG_TLB_FLUSHED       BIT(5) /* idle-state flushes TLBs */
>  #define CPUIDLE_FLAG_RCU_IDLE          BIT(6) /* idle-state takes care of RCU */
> +#define CPUIDLE_FLAG_POLLING_HARD      BIT(7) /* hardware need_resched() polling state */

Hardware need_resched() monitoring rather?  This doesn't do what
"polling" usually means AFAICS.

>
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> --
