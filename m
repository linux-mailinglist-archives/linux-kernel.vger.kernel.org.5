Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D9E77E038
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbjHPLYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244405AbjHPLXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:23:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F5822123
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:23:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 123341063;
        Wed, 16 Aug 2023 04:24:24 -0700 (PDT)
Received: from [10.57.90.114] (unknown [10.57.90.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62AD13F762;
        Wed, 16 Aug 2023 04:23:41 -0700 (PDT)
Message-ID: <2e076cb5-1e31-10b2-9f33-79a825ac9c11@arm.com>
Date:   Wed, 16 Aug 2023 12:23:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] perf: ARM_SMMU_V3_PMU should depend on ARM_SMMU_V3
Content-Language: en-GB
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <0f8ac07472f4161c71247742acb2303f9cf91396.1692113438.git.geert+renesas@glider.be>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0f8ac07472f4161c71247742acb2303f9cf91396.1692113438.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-15 16:36, Geert Uytterhoeven wrote:
> There is no point in monitoring transactions passing through the SMMU
> when ARM Ltd. System MMU Version 3 (SMMUv3) Support is disabled.
> Hence replace the dependency on ARM64 by a dependency on ARM_SMMU_V3
> (which implies the former).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This caught my eye after commit 7c3f204e544dfa37 ("perf/smmuv3: Remove
> build dependency on ACPI") in arm64/for-next/core.
> 
> Perhaps my understanding is wrong? Is there anything to monitor when
> ARM_SMMU_V3=n?

Yes, at least TBU event 1 still counts bypass transactions even when the 
SMMU is disabled, so PMCGs can be useful as basic traffic monitors in 
their own right. Plus the original design intent was that PMCGs may also 
be implemented by other things that interact with the SMMU, like 
ATS-capable PCIe root complexes, or devices with their own internal 
TLBs, thus they could potentially count any manner of 
implementation-defined events that aren't necessarily related to SMMU 
translation.

Thanks,
Robin.

>   drivers/perf/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 273d67ecf6d2530f..c33324692fbf0141 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -92,7 +92,7 @@ config ARM_PMU_ACPI
>   
>   config ARM_SMMU_V3_PMU
>   	 tristate "ARM SMMUv3 Performance Monitors Extension"
> -	 depends on ARM64 || (COMPILE_TEST && 64BIT)
> +	 depends on ARM_SMMU_V3 || (COMPILE_TEST && 64BIT)
>   	 depends on GENERIC_MSI_IRQ
>   	   help
>   	   Provides support for the ARM SMMUv3 Performance Monitor Counter
