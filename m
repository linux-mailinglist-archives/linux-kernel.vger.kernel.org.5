Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A13805525
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345247AbjLEMsP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 07:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345119AbjLEMsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:48:13 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B2BA1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:48:20 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1fae54afb66so508719fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701780499; x=1702385299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO2l4IJjU9icOifnYG2PsMFmdqAsQXokH8ukawb7hHk=;
        b=hw7foyWf+Be0pHOxyI7lfH6ZRsP3jH3O3l+CDCR4C2ZcxwOCvcZFEjxIcYspky2hqr
         00xu+nJJ+qjiIMH5DdARpYqOZu4L4TTeVnsqNzRAu/isYmdU6p2VvDv5F7JUzaoEjouY
         iazv5Jgi5/mHXDY9/Hd5Difo/RF+vBh4cHeZ0d9/7z+LQC3oRSGPl89EmSSO9710/IkO
         cAlU5M8bROsxWkkmsL/+BuIX228HccV1S1SDzjr+bXNjtZ/IK41LerzgdKyUcdNw8xys
         uS74pBw806anKgZLhb8+PzXzcVVmpDf9czOPPapUmBHAHEu0+WNqC/VaKZOH6D/0wNSX
         i4Cw==
X-Gm-Message-State: AOJu0YxOPE5C8CnK51UWgeLtf/u4SP8KgeMi0Ty4CDYCafDhwqqNX6E9
        2edNN+uH1vN9ihL/Ewru70FUiINss9DupjgiPtw=
X-Google-Smtp-Source: AGHT+IFdgiQ48wbfJUm+JMZxtfktBc8aYgDjxCE3DzP2lTj6+vTevIRUC21aeVVlrCizlZVsR6Af/Shv9jXw+ej1zTo=
X-Received: by 2002:a05:6870:4d09:b0:1fb:19d6:8715 with SMTP id
 pn9-20020a0568704d0900b001fb19d68715mr10579229oab.4.1701780499551; Tue, 05
 Dec 2023 04:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20231204172849.18753-1-jalliste@amazon.com>
In-Reply-To: <20231204172849.18753-1-jalliste@amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Dec 2023 13:48:07 +0100
Message-ID: <CAJZ5v0izUiGa2rU_8Oiygj40434Bvr2tooUqOpyUBRrM4BekeA@mail.gmail.com>
Subject: Re: [PATCH] x86: intel_epb: Add earlyparam option to keep bias at performance
To:     Jack Allister <jalliste@amazon.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, rafael@kernel.org,
        len.brown@intel.com, Paul Durrant <pdurrant@amazon.com>,
        Jue Wang <juew@amazon.com>,
        Usama Arif <usama.arif@bytedance.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 6:30 PM Jack Allister <jalliste@amazon.com> wrote:
>
> There are certain scenarios where it may be intentional that the EPB was
> set at to 0/ENERGY_PERF_BIAS_PERFORMANCE on kernel boot. For example, in
> data centers a kexec/live-update of the kernel may be performed regularly.
>
> Usually this live-update is time critical and defaulting of the bias back
> to ENERGY_PERF_BIAS_NORMAL may actually be detrimental to the overall
> update time if processors' time to ramp up/boost are affected.
>
> This patch introduces a kernel command line "intel_epb_keep_performance"
> which will leave the EPB at performance if during the restoration code path
> it is detected as such.
>
> Signed-off-by: Jack Allister <jalliste@amazon.com>
> Cc: Paul Durrant <pdurrant@amazon.com>
> Cc: Jue Wang <juew@amazon.com>
> Cc: Usama Arif <usama.arif@bytedance.com>
> ---
>  arch/x86/kernel/cpu/intel_epb.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
> index e4c3ba91321c..0c7dd092f723 100644
> --- a/arch/x86/kernel/cpu/intel_epb.c
> +++ b/arch/x86/kernel/cpu/intel_epb.c
> @@ -50,7 +50,8 @@
>   * the OS will do that anyway.  That sometimes is problematic, as it may cause
>   * the system battery to drain too fast, for example, so it is better to adjust
>   * it on CPU bring-up and if the initial EPB value for a given CPU is 0, the
> - * kernel changes it to 6 ('normal').
> + * kernel changes it to 6 ('normal'). This however is overridable via
> + * intel_epb_keep_performance if required.
>   */
>
>  static DEFINE_PER_CPU(u8, saved_epb);
> @@ -75,6 +76,8 @@ static u8 energ_perf_values[] = {
>         [EPB_INDEX_POWERSAVE] = ENERGY_PERF_BIAS_POWERSAVE,
>  };
>
> +static bool intel_epb_keep_performance __read_mostly;
> +
>  static int intel_epb_save(void)
>  {
>         u64 epb;
> @@ -107,8 +110,12 @@ static void intel_epb_restore(void)
>                  */
>                 val = epb & EPB_MASK;
>                 if (val == ENERGY_PERF_BIAS_PERFORMANCE) {
> -                       val = energ_perf_values[EPB_INDEX_NORMAL];
> -                       pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
> +                       if (!intel_epb_keep_performance) {

if (!intel_epb_keep_performance && val == ENERGY_PERF_BIAS_PERFORMANCE) {

and you need not notify the sysadmin that the original value has
returned - they have set the command line switch for this purpose
after all.

> +                               val = energ_perf_values[EPB_INDEX_NORMAL];
> +                               pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
> +                       } else {
> +                               pr_warn_once("ENERGY_PERF_BIAS: Kept at 'performance', no change\n");
> +                       }
>                 }
>         }
>         wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, (epb & ~EPB_MASK) | val);
> @@ -213,6 +220,12 @@ static const struct x86_cpu_id intel_epb_normal[] = {
>         {}
>  };
>
> +static __init int intel_epb_keep_performance_setup(char *str)
> +{
> +       return kstrtobool(str, &intel_epb_keep_performance);
> +}
> +early_param("intel_epb_keep_performance", intel_epb_keep_performance_setup);
> +
>  static __init int intel_epb_init(void)
>  {
>         const struct x86_cpu_id *id = x86_match_cpu(intel_epb_normal);
> --
> 2.40.1
>
