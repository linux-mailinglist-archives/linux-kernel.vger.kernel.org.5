Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8C879B884
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348124AbjIKVZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbjIKJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:23:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3620CD3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:23:00 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CAE3A66072EE;
        Mon, 11 Sep 2023 10:22:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694424179;
        bh=UHwwIvbCnmPwOAeZhnAr+duGQyfIPj8XHFbA0W2DbjY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Dy8Xh682R8ONHbLMnOEyDrRRl2ao2HsreyUMg/608Ul5q/MridECqmK26rIieoNh8
         LPJPsPpETrx1yRIbr/Nud7ykkMsqh4rGO/9Ebf4/tfsfBicS70c6c6azvSTSYFaZKD
         50K1aH+YoNKwx7sNneNdG9tKPVuurXkYs+DYtzf8g+lXJ4hgY5Tq8fpMUOCakbw6/e
         BchwfP6XrTe9ABy9NS+SjzwMGGzdt7WtjCbjX+/MSNyFnDGe6RL/S8PnZEMX0FtFLB
         8V+dFpen1h5pxeE30BminheJHbnxyb2tPpC6HzP2uWfiV6qX7cBcfKmvOx42qZmxx2
         FKFed9MyRBMUQ==
Message-ID: <28b81a20-5cfa-b474-41c3-c01b7b846e21@collabora.com>
Date:   Mon, 11 Sep 2023 11:22:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/4] iommu/mediatek: Initialise the secure bank
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        anan.sun@mediatek.com, yf.wang@mediatek.com,
        mingyuan.ma@mediatek.com, "T . J . Mercier" <tjmercier@google.com>
References: <20230911011751.29906-1-yong.wu@mediatek.com>
 <20230911011751.29906-2-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230911011751.29906-2-yong.wu@mediatek.com>
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

Il 11/09/23 03:17, Yong Wu ha scritto:
> The lastest IOMMU always have 5 banks, and we always use the last bank
> (id:4) for the secure memory address translation. This patch add a new
> flag (SECURE_BANK_ENABLE) for this feature.
> 
> For the secure bank, its kernel va "base" is not helpful since the
> secure bank registers has already been protected and can only be accessed
> in the secure world. But we still record its register base, because we need
> use it to determine which IOMMU HW the translation fault happen in the
> secure world.
> 
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 640275873a27..4a2cffb28c61 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -146,6 +146,7 @@
>   #define TF_PORT_TO_ADDR_MT8173		BIT(18)
>   #define INT_ID_PORT_WIDTH_6		BIT(19)
>   #define CFG_IFA_MASTER_IN_ATF		BIT(20)
> +#define SECURE_BANK_ENABLE		BIT(21)
>   
>   #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>   				((((pdata)->flags) & (mask)) == (_x))
> @@ -162,6 +163,8 @@
>   #define MTK_IOMMU_GROUP_MAX	8
>   #define MTK_IOMMU_BANK_MAX	5
>   
> +#define MTK_IOMMU_SEC_BANKID	4
> +

Is there any SoC (previous, current or future) that may have more than one
secure context bank?

I'm thinking about implementing this differently...

static const struct mtk_iommu_plat_data mt8188_data_vdo = {
	....
	.flags = ..flags.. | ATF_SECURE_BANKS_ENABLE
	.banks_num = 5,
	.banks_enable = {true, false, false, false, true},
	.banks_secure = {false, false, false, false, true},
	....
}

...this would means that you won't need to specify a static SEC_BANKID, as
you'd get that from banks_secure... so that....

>   enum mtk_iommu_plat {
>   	M4U_MT2712,
>   	M4U_MT6779,
> @@ -240,9 +243,13 @@ struct mtk_iommu_plat_data {
>   };
>   
>   struct mtk_iommu_bank_data {
> -	void __iomem			*base;
> +	union {
> +		void __iomem		*base;
> +		phys_addr_t		sec_bank_base;
> +	};
>   	int				irq;
>   	u8				id;
> +	bool				is_secure;
>   	struct device			*parent_dev;
>   	struct mtk_iommu_data		*parent_data;
>   	spinlock_t			tlb_lock; /* lock for tlb range flush */
> @@ -1309,7 +1316,15 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   			continue;
>   		bank = &data->bank[i];
>   		bank->id = i;
> -		bank->base = base + i * MTK_IOMMU_BANK_SZ;

....this would become:

bank->is_secure = MTK_IOMMU_HAS_FLAG(data->plat_data, ATF_SECURE_BANKS_ENABLE) &&
		  data->plat_data->banks_secure[i];

if (bank->is_secure)
	bank->sec_bank_base = res->start + i * MTK_IOMMU_BANK_SZ;
else
	bank->base = base + i * MTK_IOMMU_BANK_SZ;

> +		if (MTK_IOMMU_HAS_FLAG(data->plat_data, SECURE_BANK_ENABLE) &&
> +		    bank->id == MTK_IOMMU_SEC_BANKID) {
> +			/* Record the secure bank base to indicate which iommu TF in sec world */
> +			bank->sec_bank_base = res->start + i * MTK_IOMMU_BANK_SZ;
> +			bank->is_secure = true;
> +		} else {
> +			bank->base = base + i * MTK_IOMMU_BANK_SZ;
> +			bank->is_secure = false;
> +		}
>   		bank->m4u_dom = NULL;
>   
>   		bank->irq = platform_get_irq(pdev, i);

What do you think?

Cheers,
Angelo
