Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ECC7D6A04
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjJYLZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYLZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:25:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEED111;
        Wed, 25 Oct 2023 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698233156; x=1729769156;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lzdzfxS+vEFXNr8keP9AwboDyqsE3quDvmbHJ7Prm3g=;
  b=eN2ZdWV7U4plyR4VjbgF+EImoS8LfDEdmr2S+gSzzhQTdeJPKRpb43td
   KI2LVoBuPH42nyXUzdLMvdr+R55A6gDItsrtX7t1gjgXDBCNqd4TYBx8g
   ZiRyvebeqi+dQRw29oj6UcvGZl8LLsHUdaP0HlThzOg7d0/06gla/gABx
   MSeEw1mgxAcCJJ1LRFHVSpQeBhmBjHc5ejaqqMgftCZTXK/Q0y18vr+/e
   OE2hi2lXwqP50g9WYFR49zT/ehQgv5HptjD0SjqYrwXH7XSGtpV6svgYy
   48o9bvbkjjCkLj/nboHcQ/kQc++1hWpT5arWrj4kHZcbwiOjiDQw1aSS2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451512871"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="451512871"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:25:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="758843818"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="758843818"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.178]) ([10.254.211.178])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:25:52 -0700
Message-ID: <1acd75d0-67a7-4a17-99c7-707cca305f37@linux.intel.com>
Date:   Wed, 25 Oct 2023 19:25:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] iommu/tegra-smmu: fix error checking for
 debugfs_create_dir()
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
References: <20231025110140.2034650-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231025110140.2034650-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/25 19:01, Dario Binacchi wrote:
> The return value of debugfs_create_dir() should be checked using the
> IS_ERR() function.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>   drivers/iommu/tegra-smmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index e445f80d0226..cd1d80c4c673 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -1056,7 +1056,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
>   static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
>   {
>   	smmu->debugfs = debugfs_create_dir("smmu", NULL);
> -	if (!smmu->debugfs)
> +	if (IS_ERR(smmu->debugfs))
>   		return;

This check can be removed, as debugfs_create_file() can handle the case
where @parent is an error pointer.

>   
>   	debugfs_create_file("swgroups", S_IRUGO, smmu->debugfs, smmu,

Best regards,
baolu
