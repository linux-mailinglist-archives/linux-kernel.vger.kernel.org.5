Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61B77D0FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377239AbjJTMw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377017AbjJTMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:52:26 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA5A18F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:52:02 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso11420681fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697806320; x=1698411120; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJ2rNxHtt+O1xvO+buVTB/lXtqb4AV5UuwwFt4RaJHM=;
        b=e7nRj/Jpzb8/VUnmWaRkpGbx/5l2MUaM4NRHIUcRV1B7QJCE2k8Yv5JY+5GAxLDrwi
         YTD7xkfC8HqKYkvweb2UHqNEX/F+QcWuRxT0b1psceVLVBOuaSyVu9BMy1eamQXbK4q3
         e25L5z0GZdZRdnzp7a15cYNOB0R7iXtgXGazTjXaeUQC88FH6JHu80Sss3kMVARHOjDp
         fpaTLLI/xMTVbg+j6/dKka3mQ4Q5YtP6Sr3X2spuEFCjAR07Sf6Q9fuwZa9HLuJk8p3p
         aKrANk7XWQjwHQIVzeurCT0Z0Zs6TlpeorO2D0WURDQM30Ge9jnnnATCbYEjAwTFVyxd
         fZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806320; x=1698411120;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ2rNxHtt+O1xvO+buVTB/lXtqb4AV5UuwwFt4RaJHM=;
        b=PF25jtRkgSRx14yiI3d9EB0nsjMCGytpnuupKmaTaC8BwA4TrCJCmzCotb3nCcc6ek
         N6aKpCBxZeHU1V8c16h9SlU3TvUBrXPtAF6B+yP2xw3R5K7+R/nuCWZCjNFjR3kLY00B
         QPCh+XjyVQNAmT6Imm/pmhSNEgEtyEHUPkWgw13MjMRLZ1h+kdNoewyfzTT7tqpuPpGS
         5REeFegoFnYNQ2mfVVL8vNJgOfoGDGSDHOJbpAMQTG2UCyj6XKjo7b6Odn0Dq53xPvlE
         f1c/vxP/s3KtUINFzIxpIrTrqyOg3Bb1ek2ZUhfgiCPbSy+vzNZqKfN3HnrgUzu3u0vA
         56Qg==
X-Gm-Message-State: AOJu0Yzxta1NNIggSG1IpaQusrlFYrmR052X7DhXebYZB9cI3F5jaFWc
        EyMuImAWxvvhUzHSPdPsnMmpvg==
X-Google-Smtp-Source: AGHT+IHugvfk5cxGPj8ACys9s5ycx97jrr/zvGkg3y0J+yohoSEOehKHa7JfZykIrg0KeT4sBZN9rg==
X-Received: by 2002:a2e:9952:0:b0:2bf:f989:b8e5 with SMTP id r18-20020a2e9952000000b002bff989b8e5mr1156153ljj.33.1697806320558;
        Fri, 20 Oct 2023 05:52:00 -0700 (PDT)
Received: from localhost ([95.148.15.118])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c1c1400b004065daba6casm7038686wms.46.2023.10.20.05.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:52:00 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, krisman@suse.de, broonie@kernel.org,
        james.morse@arm.com, ionela.voinescu@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: cpufeature: Display the set of cores with a feature
In-Reply-To: <20231013013016.197102-1-jeremy.linton@arm.com> (Jeremy Linton's
        message of "Thu, 12 Oct 2023 20:30:16 -0500")
References: <20231013013016.197102-1-jeremy.linton@arm.com>
Date:   Fri, 20 Oct 2023 13:51:59 +0100
Message-ID: <874jilpic0.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Linton <jeremy.linton@arm.com> writes:

> The AMU feature can be enabled on a subset of the cores in a system.
> Because of that, it prints a message for each core as it is detected.
> This becomes tedious when there are hundreds of cores. Instead, for
> CPU features which can be enabled on a subset of the present cores,
> lets wait until update_cpu_capabilities() and print the subset of cores
> the feature was enabled on.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  2 ++
>  arch/arm64/kernel/cpufeature.c      | 16 +++++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 5bba39376055..19b4d001d845 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -23,6 +23,7 @@
>  #include <linux/bug.h>
>  #include <linux/jump_label.h>
>  #include <linux/kernel.h>
> +#include <linux/cpumask.h>
>  
>  /*
>   * CPU feature register tracking
> @@ -380,6 +381,7 @@ struct arm64_cpu_capabilities {
>  	 * method is robust against being called multiple times.
>  	 */
>  	const struct arm64_cpu_capabilities *match_list;
> +	const struct cpumask *cpus;
>  };
>  
>  static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 444a73c2e638..18711e35924c 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1944,8 +1944,6 @@ int get_cpu_with_amu_feat(void)
>  static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
>  {
>  	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
> -		pr_info("detected CPU%d: Activity Monitors Unit (AMU)\n",
> -			smp_processor_id());
>  		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
>  
>  		/* 0 reference values signal broken/disabled counters */
> @@ -2411,10 +2409,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		 * message to be shown until at least one CPU is detected to
>  		 * support the feature.
>  		 */
> +		.desc = "Activity Monitors Unit (AMU)",
>  		.capability = ARM64_HAS_AMU_EXTN,
>  		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
>  		.matches = has_amu,
>  		.cpu_enable = cpu_amu_enable,
> +		.cpus = &amu_cpus,
>  		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, AMU, IMP)
>  	},
>  #endif /* CONFIG_ARM64_AMU_EXTN */
> @@ -2981,7 +2981,7 @@ static void update_cpu_capabilities(u16 scope_mask)
>  		    !caps->matches(caps, cpucap_default_scope(caps)))
>  			continue;
>  
> -		if (caps->desc)
> +		if (caps->desc && !caps->cpus)
>  			pr_info("detected: %s\n", caps->desc);
>  
>  		__set_bit(caps->capability, system_cpucaps);
> @@ -3330,6 +3330,7 @@ unsigned long cpu_get_elf_hwcap2(void)
>  
>  static void __init setup_system_capabilities(void)
>  {
> +	int i;
>  	/*
>  	 * We have finalised the system-wide safe feature
>  	 * registers, finalise the capabilities that depend
> @@ -3338,6 +3339,15 @@ static void __init setup_system_capabilities(void)
>  	 */
>  	update_cpu_capabilities(SCOPE_SYSTEM);
>  	enable_cpu_capabilities(SCOPE_ALL & ~SCOPE_BOOT_CPU);
> +
> +	for (i = 0; i < ARM64_NCAPS; i++) {
> +		const struct arm64_cpu_capabilities *caps = cpucap_ptrs[i];
> +
> +		if (caps && caps->cpus && caps->desc &&
> +			cpumask_any(caps->cpus) < nr_cpu_ids)
> +			pr_info("detected: %s on CPU%*pbl\n",
> +				caps->desc, cpumask_pr_args(caps->cpus));
> +	}
>  }
>  
>  void __init setup_cpu_features(void)

Thanks, Jeremy for putting this patch together. The duplicated prints
bothered me too every time I stared at the boot logs.

Fwiw,,

Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>
Tested-by: Punit Agrawal <punit.agrawal@bytedance.com>

The patch was verified on an N2 based platform.
