Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F327598DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGSOyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjGSOyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:54:19 -0400
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F70CC7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:54:18 -0700 (PDT)
Message-ID: <77417a3a-597f-b503-acc0-9c6afcaac511@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689778454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qB35vgPnpDa8L5WeWPGMzlEuhzzMC0xS7q+crMBgfF8=;
        b=d9SnxG3TtlqruVRMYaa9eD7lgF0vFKmI18W/HAuJmJYzMw3MoYiwm/jvlNVwQ55UYRMagL
        QPKpi4lklLfhy/htPUm1DD1sJYdd/Kw1p4z7HFrXPiSJjT/m8pGJLEbj6T8Q74hYQWGsYE
        elYNl2aJ0nl8xZRQcjbeh5TdIVvjdmA=
Date:   Wed, 19 Jul 2023 22:53:40 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] arm64/cpufeature: Use ARM64_CPUID_FIELD() to match EVT
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230718-arm64-evt-cpuid-helper-v1-1-68375d1e6b92@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20230718-arm64-evt-cpuid-helper-v1-1-68375d1e6b92@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/19 03:45, Mark Brown wrote:
> The recently added Enhanced Virtualization Traps cpufeature does not use
> the ARM64_CPUID_FIELDS() helper, convert it to do so. No functional
> change.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f9d456fe132d..bcb006390e55 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2708,12 +2708,8 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.desc = "Enhanced Virtualization Traps",
>  		.capability = ARM64_HAS_EVT,
>  		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> -		.sys_reg = SYS_ID_AA64MMFR2_EL1,
> -		.sign = FTR_UNSIGNED,
> -		.field_pos = ID_AA64MMFR2_EL1_EVT_SHIFT,
> -		.field_width = 4,
> -		.min_field_value = ID_AA64MMFR2_EL1_EVT_IMP,
>  		.matches = has_cpuid_feature,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
>  	},
>  	{},
>  };

Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
