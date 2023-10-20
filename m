Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D304F7D1044
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377360AbjJTNHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377002AbjJTNHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:07:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4909F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:06:52 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40806e40fccso6007185e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697807211; x=1698412011; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WCm+EqBMn/4mUTNVySVuHeEM7hbwegHPI112FGAJ2Rg=;
        b=Gc0P72uST6FQzcRtuyo9qIsJtVYMz6wdTd7ItiKftm59iGZqS3un5KmhIeqDdHjuS4
         6rteySTehjK17rmPTampSUtuUvMDZHmRXAwZkuQgI1UdRbJUftw/IVag23gs0tiUpHa9
         h7iQ+uuR6Tsz8+WVFwrfGXKYXz5HDNV4nDwXmSZcjixS4MgKqsQh04isaW84Fi1cQ2f8
         zDPmGg2QIv9/q4lMnLIpG7TABrARHZwEORwEeFrznU///ea3GgecJB9fGV0Qv0+M/Fn8
         OaHkYMsKrz0l5M4f4J9Ep1BeDlEZQyNyGYxU4GOyRsgjDBIbBvXBhdieMFY61gWgbAOY
         JjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697807211; x=1698412011;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCm+EqBMn/4mUTNVySVuHeEM7hbwegHPI112FGAJ2Rg=;
        b=YeekQTJGkCByqQOE9l/adZ1764xGU7ao5hWQLf/+H8L1TQ/JO6VZ4szTacTSvY0ZVN
         dwVx6r6nTCaoVRglrW5NVpxlNwH4M7RgtNGQWHEizYfupMPyv2Q9oo7ptNdW7gWY8x/t
         Ijh3m8KZHVj/KagLxfWXLrhwvfGeTULYjcXyBXcty+UA8NuPJcZiD3mtMgJHbnEVdNwe
         Y0YDmnaLIURYJZStMwYHrBZa/pBev71Gq5Yz/iyObS+IU7IiyK2rVKaA30QUaOGLiASV
         hmXu8nUNmB8KpDCdT2Kpdd3KkUrfKSVr2dp5QEZejnA1zbCz/R1D5lAKtIkG5AOlGu+c
         Vgvw==
X-Gm-Message-State: AOJu0YyIAX0TcDXwGYzR2K28Sf/qwpIw3+Wa9SOw0yr6O/OBBAvLnE7H
        yErN5lhV5CoSmZ1yKFw06ZSnIQ==
X-Google-Smtp-Source: AGHT+IFIvV5TUpm/s3Z1DUytrd1IeI/v7LKPHLGYxHYYOsW2nyBVcgsbo9bseFvy7Lte64hmpJsR0w==
X-Received: by 2002:a05:600c:3096:b0:405:95c3:e79d with SMTP id g22-20020a05600c309600b0040595c3e79dmr1396174wmn.40.1697807210658;
        Fri, 20 Oct 2023 06:06:50 -0700 (PDT)
Received: from localhost ([95.148.15.118])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b00403b63e87f2sm2155727wmq.32.2023.10.20.06.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 06:06:50 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, krisman@suse.de, broonie@kernel.org,
        james.morse@arm.com, ionela.voinescu@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: cpufeature: Display the set of cores with
 a feature
In-Reply-To: <20231017052322.1211099-2-jeremy.linton@arm.com> (Jeremy Linton's
        message of "Tue, 17 Oct 2023 00:23:20 -0500")
References: <20231017052322.1211099-1-jeremy.linton@arm.com>
        <20231017052322.1211099-2-jeremy.linton@arm.com>
Date:   Fri, 20 Oct 2023 14:06:49 +0100
Message-ID: <87ttqlo32u.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  2 ++
>  arch/arm64/kernel/cpufeature.c      | 22 +++++++++++++---------
>  2 files changed, 15 insertions(+), 9 deletions(-)
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
> index 444a73c2e638..2dd695fc3472 100644
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
> @@ -2405,16 +2403,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  #endif /* CONFIG_ARM64_RAS_EXTN */
>  #ifdef CONFIG_ARM64_AMU_EXTN
>  	{
> -		/*
> -		 * The feature is enabled by default if CONFIG_ARM64_AMU_EXTN=y.
> -		 * Therefore, don't provide .desc as we don't want the detection
> -		 * message to be shown until at least one CPU is detected to
> -		 * support the feature.
> -		 */
> +		.desc = "Activity Monitors Unit (AMU)",
>  		.capability = ARM64_HAS_AMU_EXTN,
>  		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
>  		.matches = has_amu,
>  		.cpu_enable = cpu_amu_enable,
> +		.cpus = &amu_cpus,
>  		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, AMU, IMP)
>  	},
>  #endif /* CONFIG_ARM64_AMU_EXTN */
> @@ -2981,7 +2975,7 @@ static void update_cpu_capabilities(u16 scope_mask)
>  		    !caps->matches(caps, cpucap_default_scope(caps)))
>  			continue;
>  
> -		if (caps->desc)
> +		if (caps->desc && !caps->cpus)
>  			pr_info("detected: %s\n", caps->desc);
>  
>  		__set_bit(caps->capability, system_cpucaps);
> @@ -3330,6 +3324,7 @@ unsigned long cpu_get_elf_hwcap2(void)
>  
>  static void __init setup_system_capabilities(void)
>  {
> +	int i;
>  	/*
>  	 * We have finalised the system-wide safe feature
>  	 * registers, finalise the capabilities that depend
> @@ -3338,6 +3333,15 @@ static void __init setup_system_capabilities(void)
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

Ah I replied to the previous version without realising there's a new
one. This patch looks unchanged, so, fwiw, feel free to add

Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>
Tested-by: Punit Agrawal <punit.agrawal@bytedance.com>

Thanks,
Punit
