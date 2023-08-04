Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A4D770659
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjHDQwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHDQwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:52:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41E24C10
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0723862096
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAC4C433C7;
        Fri,  4 Aug 2023 16:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691167951;
        bh=buMAlpQhDwKnRxmVi9Eejmudb/fRIJ7cOINBfet7OBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o1xWFrqk5qmn3Nzc4P26s8n6svP0A4OStmcEsxPCguXYSNNb9HR7w0bIJ4IR6ed1/
         vKhcg4lD0ik0tFxu7dBNyIOitabSek3LdA2x4zlKGbQMY0jX3/QvaoRE09byYit4Q2
         7Ogpyzkf9N1y/XVbEr4cEyBfY1mwZkzUNZ3+r/HM2SlpdOXw/9HsmYQdmKqFoyvHUu
         uKmuTORldBvlWPvecdNG+ZNXacZkBNbPpXM7GTNb25KW0ky+gpgClTesNHqgkw2ADQ
         bGl06V1+xy9Xcn9xxyNMQHJjcnTngFC6C7slin/1ZgmprMuXbbj2BpWFUSSMBJAEP1
         nN7nhV0lJOVCg==
Date:   Fri, 4 Aug 2023 17:52:25 +0100
From:   Will Deacon <will@kernel.org>
To:     zhurui <zhurui3@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: Fix error case of range command
Message-ID: <20230804165225.GF30679@willie-the-truck>
References: <1690784482-30028-1-git-send-email-wangwudi@hisilicon.com>
 <20230801085504.GA26130@willie-the-truck>
 <27c895b8-1fb0-be88-8bc3-878d754684c8@huawei.com>
 <d5fc1f72-7428-4fef-d868-d06b85add635@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5fc1f72-7428-4fef-d868-d06b85add635@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:31:20PM +0800, zhurui wrote:
> When tg != 0 but ttl, scale, num all 0 in a range tlbi command, it
> is reserved and will cause the CERROR_ILL error. This case means
> that the size to be invalidated is only one page size, and the
> range invalidation is meaningless here. So we set tg to 0 in this
> case to do an non-range invalidation instead.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Yicong Yang <yangyicong@hisilicon.com>
> Cc: Tomas Krcka <krckatom@amazon.de>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Nicolin Chen <nicolinc@nvidia.com>
> Cc: Rui Zhu <zhurui3@huawei.com>
> 
> Signed-off-by: Rui Zhu <zhurui3@huawei.com>
> ---
> ChangeLog:
> v1-->v2:
> 	1. Change from "Revert" to modify the problematic case
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9b0dc3505601..5e56c7e85819 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1895,9 +1895,6 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>                 /* Get the leaf page size */
>                 tg = __ffs(smmu_domain->domain.pgsize_bitmap);
> 
> -               /* Convert page size of 12,14,16 (log2) to 1,2,3 */
> -               cmd->tlbi.tg = (tg - 10) / 2;
> -
>                 /*
>                  * Determine what level the granule is at. For non-leaf, io-pgtable
>                  * assumes .tlb_flush_walk can invalidate multiple levels at once,
> @@ -1930,6 +1927,12 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>                         num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
>                         cmd->tlbi.num = num - 1;
> 
> +                       /* Prevent error caused by one page tlbi with leaf 0 */
> +                       if (scale == 0 && num == 1 && cmd->tlbi.leaf == 0)
> +                               cmd->tlbi.tg = 0;

This should only be true for the last iteration, right (i.e. when num_pages
== 1)? In which case, I'd prefer to leave the old code as-is and just add:

	/* Single-page leaf invalidation requires a TG field of 0 */
	if (num_pages == 1 && !cmd->tlbi.leaf)
		cmd->tlbi.tg = 0;

here.

Will
