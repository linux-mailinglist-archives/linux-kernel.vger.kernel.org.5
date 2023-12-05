Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6384D8055EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442178AbjLENaM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 08:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345403AbjLENaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:30:10 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6F3B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:30:16 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1fb6cbacf9aso63968fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 05:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701783016; x=1702387816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQ46Zu5o/jlw4aoBQJBdzf1PrFCmVa4Ine74hNCNpr8=;
        b=hmbPYYoJJoyI/1uybUb1dlZ/Ea7ufx24LvSDsm1tV9yU5YvRHgSMhF/LUucgYeAUxU
         861srUCWCUCcvmTdlEhOYRYcl5nk7AwqPC+e8g7uupXUD9pjIjbXEVWSNxCn6hi7UfH5
         G4eZCg0tSE0m5k294QGQbKFAwvcCLX7gFtOW8wN4EkAF1FWuXZgRM44xSg+g9/EP+xQ0
         4ciRmL/9Pukd4SByEqY9wp5qt3BhSAwLAnig7Fo4XLVOFyWJlA/anWHq3s8zimzjAWvH
         +s2LboXGd+MXDToqxB3R9WqflYhT86cKVq5dcvC2hpb1RUf0KmAusnMhpkFXT7yyiwi2
         jNtA==
X-Gm-Message-State: AOJu0YyWp3L0PM+Hmu55mn9EyRdW/pBTY+vDBqOJ9wRfNPUDl9vTtX5m
        Usv4ImoKVMczR5urEE/TJ0odRFSAv7AwzUX3q60=
X-Google-Smtp-Source: AGHT+IF5uZ+zLNbD7K9wBNBx1P+xrBk3kZElb7yLR3O2UlHFWipYFPMJWE0gHPqGPBHgpt2PZqjsMCD3NfT66T9/Ezo=
X-Received: by 2002:a05:6870:971f:b0:1fa:f195:e3b4 with SMTP id
 n31-20020a056870971f00b001faf195e3b4mr12903829oaq.2.1701783016043; Tue, 05
 Dec 2023 05:30:16 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0izUiGa2rU_8Oiygj40434Bvr2tooUqOpyUBRrM4BekeA@mail.gmail.com>
 <20231205131359.66338-1-jalliste@amazon.com>
In-Reply-To: <20231205131359.66338-1-jalliste@amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Dec 2023 14:30:04 +0100
Message-ID: <CAJZ5v0jYqQc4UztGzMDP5m5xKejrEQkMyyt12nsHdQ=qiULpTQ@mail.gmail.com>
Subject: Re: [PATCH] x86: intel_epb: Add earlyparam option to keep bias at performance
To:     Jack Allister <jalliste@amazon.com>
Cc:     rafael@kernel.org, Paul Durrant <pdurrant@amazon.com>,
        Jue Wang <juew@amazon.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 2:14 PM Jack Allister <jalliste@amazon.com> wrote:
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
>  arch/x86/kernel/cpu/intel_epb.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
> index e4c3ba91321c..cbe0e224b8d9 100644
> --- a/arch/x86/kernel/cpu/intel_epb.c
> +++ b/arch/x86/kernel/cpu/intel_epb.c
> @@ -50,7 +50,8 @@
>   * the OS will do that anyway.  That sometimes is problematic, as it may cause
>   * the system battery to drain too fast, for example, so it is better to adjust
>   * it on CPU bring-up and if the initial EPB value for a given CPU is 0, the
> - * kernel changes it to 6 ('normal').
> + * kernel changes it to 6 ('normal'). This however is overridable via
> + * intel_epb_no_override if required.
>   */

In the comment above I would say

"However, if it is desirable to retain the original initial EPB value,
intel_epb_no_override can be set to enforce it."

Otherwise

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

>
>  static DEFINE_PER_CPU(u8, saved_epb);
> @@ -75,6 +76,8 @@ static u8 energ_perf_values[] = {
>         [EPB_INDEX_POWERSAVE] = ENERGY_PERF_BIAS_POWERSAVE,
>  };
>
> +static bool intel_epb_no_override __read_mostly;
> +
>  static int intel_epb_save(void)
>  {
>         u64 epb;
> @@ -106,7 +109,7 @@ static void intel_epb_restore(void)
>                  * ('normal').
>                  */
>                 val = epb & EPB_MASK;
> -               if (val == ENERGY_PERF_BIAS_PERFORMANCE) {
> +               if (!intel_epb_no_override && val == ENERGY_PERF_BIAS_PERFORMANCE) {
>                         val = energ_perf_values[EPB_INDEX_NORMAL];
>                         pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
>                 }
> @@ -213,6 +216,12 @@ static const struct x86_cpu_id intel_epb_normal[] = {
>         {}
>  };
>
> +static __init int intel_epb_no_override_setup(char *str)
> +{
> +       return kstrtobool(str, &intel_epb_no_override);
> +}
> +early_param("intel_epb_no_override", intel_epb_no_override_setup);
> +
>  static __init int intel_epb_init(void)
>  {
>         const struct x86_cpu_id *id = x86_match_cpu(intel_epb_normal);
> --
> 2.40.1
>
