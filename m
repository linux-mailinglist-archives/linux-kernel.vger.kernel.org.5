Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FD17973E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243434AbjIGPb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343668AbjIGPaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F26F19A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:30:19 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 95C2566072BE;
        Thu,  7 Sep 2023 09:22:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694074934;
        bh=0QQVv6jlMc3BXhzBHqUu8xLqyScvz33I/+GvzdQguMU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g4NZCvLeUZCbl/IEdNcZBmNQtxVQUqWVm3hFjqIfmd1kifIQvSsgonlPl8Mu8TQyX
         3J2qi/yywlOtky+59zLO+SDWIWtxSrgC1TdHZxoGkz0F0v7ApBYtE+p6tmp9V/TAte
         nt3AmylDPwnKOh3YGg+yy+8wBLdMgTFvPxFb45EuV1zF+Ody5zNbBCCEFs2dePBbO/
         0fsInLcpoybezFl/JlTlaaO7PQCfXNvj/P34sXSLIajcRJoPTmMo/jm88fGsDhxmM2
         +d5HQ7CbZQV8b/vKC6W8L4HQcqWv85IJKEYp4LkWcR52h89R0uDVgfNW/w4w3JxqE7
         LA18ulLzj6Fyw==
Message-ID: <21e6631e-a99c-0b09-feb4-23407465ea55@collabora.com>
Date:   Thu, 7 Sep 2023 10:22:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] iommu/mediatek: Fix share pgtable for iova over 4GB
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Laura Nao <laura.nao@collabora.com>
References: <20230819081443.8333-1-yong.wu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230819081443.8333-1-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/08/23 10:14, Yong Wu ha scritto:
> In mt8192/mt8186, there is only one MM IOMMU that supports 16GB iova
> space, which is shared by display, vcodec and camera. These two SoC use
> one pgtable and have not the flag SHARE_PGTABLE, we should also keep
> share pgtable for this case.
> 
> In mtk_iommu_domain_finalise, MM IOMMU always share pgtable, thus remove
> the flag SHARE_PGTABLE checking. Infra IOMMU always uses independent
> pgtable.
> 
> Fixes: cf69ef46dbd9 ("iommu/mediatek: Fix two IOMMU share pagetable issue")
> Reported-by: Laura Nao <laura.nao@collabora.com>
> Closes: https://lore.kernel.org/linux-iommu/20230818154156.314742-1-laura.nao@collabora.com/
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

This is urgent. Fixes multiple machines.

> ---
> Base on next-20230818.
> ---
>   drivers/iommu/mtk_iommu.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index b17d3e7288a7..b5fcba305d2a 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -262,7 +262,7 @@ struct mtk_iommu_data {
>   	struct device			*smicomm_dev;
>   
>   	struct mtk_iommu_bank_data	*bank;
> -	struct mtk_iommu_domain		*share_dom; /* For 2 HWs share pgtable */
> +	struct mtk_iommu_domain		*share_dom;
>   
>   	struct regmap			*pericfg;
>   	struct mutex			mutex; /* Protect m4u_group/m4u_dom above */
> @@ -643,8 +643,8 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
>   	struct mtk_iommu_domain	*share_dom = data->share_dom;
>   	const struct mtk_iommu_iova_region *region;
>   
> -	/* Always use share domain in sharing pgtable case */
> -	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE) && share_dom) {
> +	/* Share pgtable when 2 MM IOMMU share the pgtable or one IOMMU use multiple iova ranges */
> +	if (share_dom) {
>   		dom->iop = share_dom->iop;
>   		dom->cfg = share_dom->cfg;
>   		dom->domain.pgsize_bitmap = share_dom->cfg.pgsize_bitmap;
> @@ -677,8 +677,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
>   	/* Update our support page sizes bitmap */
>   	dom->domain.pgsize_bitmap = dom->cfg.pgsize_bitmap;
>   
> -	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE))
> -		data->share_dom = dom;
> +	data->share_dom = dom;
>   
>   update_iova_region:
>   	/* Update the iova region for this domain */


