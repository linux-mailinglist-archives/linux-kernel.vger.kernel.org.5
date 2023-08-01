Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274C976AB7A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjHAI4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjHAIz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:55:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788D3268E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC3E4614C4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69C3C433C9;
        Tue,  1 Aug 2023 08:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690880111;
        bh=9eJCKTqNMuD9Qzd4V6zbjbKNH9Wn22vwxY5UdngJOsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2RNsx5poE4gfIohzHxNzgBThoQMTuMRj8TR1ONzG43Qx4zubbobawBjUKKwieY63
         PYMuSGRF3htn76wjGsBiv+uirXuvL2iF5o1nlsyFnLTu8PLEVU6WgtomvfmyxI2jhg
         yMUOk4ovrZSItmxBkaWnPPqqcWFaAh0qxIbPlhrAxwfGAJeQ0KByKAJT4+HIr6Rzw7
         tPlvYvD7be3Yk/+tJNuj64IFAFu5NVCjPvDVv6W/VQCwKFh8Z1MPIbi72FjuD3iaBE
         6AWIG1ArxsPGsJb7nvUNPsRvKnA5Y7qf7zQiXKUPNE8WKmxbKiN8L9DNF/5G18uBd2
         t7Nf7WXHCFwoQ==
Date:   Tue, 1 Aug 2023 09:55:05 +0100
From:   Will Deacon <will@kernel.org>
To:     wangwudi <wangwudi@hisilicon.com>
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Rui Zhu <zhurui3@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 1/1] Revert "iommu/arm-smmu-v3: Set TTL invalidation hint
 better"
Message-ID: <20230801085504.GA26130@willie-the-truck>
References: <1690784482-30028-1-git-send-email-wangwudi@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690784482-30028-1-git-send-email-wangwudi@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 02:21:22PM +0800, wangwudi wrote:
> From: Rui Zhu <zhurui3@huawei.com>
> 
> This reverts commit 6833b8f2e19945a41e4d5efd8c6d9f4cae9a5b7d.
> 
> This constraint violates the protocol. When tg is not 0 but ttl, scale,
> and num are 0, the hardware reports the CERROR_IL gerror. In the
> protocol, leaf is not a prerequisite for TTL.
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
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9b0dc3505601..098e84cfa82f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1898,13 +1898,8 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>  		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
>  		cmd->tlbi.tg = (tg - 10) / 2;
>  
> -		/*
> -		 * Determine what level the granule is at. For non-leaf, io-pgtable
> -		 * assumes .tlb_flush_walk can invalidate multiple levels at once,
> -		 * so ignore the nominal last-level granule and leave TTL=0.
> -		 */
> -		if (cmd->tlbi.leaf)
> -			cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
> +		/* Determine what level the granule is at */
> +		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));

Doesn't this reintroduce the bug that 6833b8f2e199 tried to fix?

afaict, we should only hit the problematic case of tg != 0 but ttl, scale
and num all 0 if we're invalidating a single page, so shouldn't we just
zap tg in that case, since it's not doing anything useful?

I hesitate to say we should avoid range invalidation altogether for
single-page invalidations because I think some errata workarounds might
need that to work.

Will
