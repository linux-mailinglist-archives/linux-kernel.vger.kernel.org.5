Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ACD77FC31
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352942AbjHQQfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353147AbjHQQfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:35:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27743E2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:35:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C016AD75;
        Thu, 17 Aug 2023 09:36:21 -0700 (PDT)
Received: from [10.57.90.41] (unknown [10.57.90.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6A793F64C;
        Thu, 17 Aug 2023 09:35:38 -0700 (PDT)
Message-ID: <928822fd-642a-5ca7-7b42-dc7885f3cf51@arm.com>
Date:   Thu, 17 Aug 2023 17:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] iommu/arm-smmu-v3: Simplify stage selection logic
Content-Language: en-GB
To:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Will Deacon <will@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230818000321.1.Ibca43cc8d1bcad3ac3deef5726b9745128aea634@changeid>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230818000321.1.Ibca43cc8d1bcad3ac3deef5726b9745128aea634@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-17 17:03, Michael Shavit wrote:
> It is invalid for an arm-smmu-v3 to have neither FEAT_TRANS_S1 nor
> FEAT_TRANS_S2 bits set, and this is even checked in the probe.
> 
> Only set ARM_SMMU_DOMAIN_S2 if FEAT_TRANS_S1 isn't supported, otherwise set
> ARM_SMMU_DOMAIN_S1. This is clearer as the existing code implies that
> something more sophisticated is going on with the stage selection logic.

The reason it's like this is because of arm_smmu_enable_nesting(), which 
*is* the additional thing that's going on with the stage selection logic.

Thanks,
Robin.

> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9b0dc35056019..e74c8c630adfa 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2206,7 +2206,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>   	/* Restrict the stage to what we can actually support */
>   	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
>   		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
> -	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
> +	else
>   		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>   
>   	switch (smmu_domain->stage) {
> 
> base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
