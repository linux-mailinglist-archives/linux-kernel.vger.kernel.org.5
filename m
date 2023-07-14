Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2148752F68
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjGNCbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjGNCbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:31:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C502D51;
        Thu, 13 Jul 2023 19:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689301895; x=1720837895;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LTlIrAiXfWEDV4oSn2gI8/laRP8AGaQoE0T52JoYWNI=;
  b=Y8KphvsHChNDiOuqtrrtcl8ILMkdbymkX+4WWC6ypFtGWmT3NrZ3d9Ym
   y2EPmLhFBKINjgzv0Lq0kWrtfKJ+2YxGGWc/kE/jusbsuL2KCaDZhwNd5
   mteQ3jAoJ4gkZEt46AacKND64ZAWli+rbonzivgd+SG8wCdk68X+GlsrS
   UQriPhg8Lu0fvg/7B6nGCHMghfgv//xsqkqJQOd/FpbJRYqFJIBqw8UG1
   KILHq1B4wrjy9DSv1xLiGYbaut1cq/p5fsYZZDmMMkpByjMgwRT0EKBW7
   KZMqSDjYOw+F9GcYeh/Tn0C84W6Ybyj0cLgAmZji/HDa3iNkstOytbYdX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="451732564"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="451732564"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 19:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812262745"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="812262745"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.49]) ([10.252.191.49])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 19:31:29 -0700
Message-ID: <61f31b3e-b618-88db-a07c-f6761c1c7d06@linux.intel.com>
Date:   Fri, 14 Jul 2023 10:31:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, opensource.kernel@vivo.com,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v4] iommu: remove redundant parameter check in
 tegra_smmu_debugfs_init()
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>,
        "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
References: <20230713072825.10348-1-duminjie@vivo.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230713072825.10348-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/13 15:28, Minjie Du wrote:
> debugfs_create_file() will return early if smmu->debugfs is an error
> pointer, so an extra error check is not needed.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/iommu/tegra-smmu.c | 2 --
>   1 file changed, 2 deletions(-)

Next time when you send a new version of a patch, please don't forget to
add the change log after the tear line. This way, people can know how
the patch evolved into this way.

Best regards,
baolu

> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 1cbf063cc..2137040b7 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -1056,8 +1056,6 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
>   static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
>   {
>   	smmu->debugfs = debugfs_create_dir("smmu", NULL);
> -	if (!smmu->debugfs)
> -		return;
>   
>   	debugfs_create_file("swgroups", S_IRUGO, smmu->debugfs, smmu,
>   			    &tegra_smmu_swgroups_fops);

