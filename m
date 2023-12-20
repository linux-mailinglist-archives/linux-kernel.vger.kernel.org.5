Return-Path: <linux-kernel+bounces-6784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF174819D80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7821F21FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0420DE9;
	Wed, 20 Dec 2023 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2hTYVkq2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4DA20DCD;
	Wed, 20 Dec 2023 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703070144;
	bh=SislEKrbcBCyeF1cvA7sktZWbgCq5DooZegn8jxygCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2hTYVkq2uP3CruHjaY/H/vSbxgKxgARWX/amioDU5W2RFfbRDpG9XU9BswCMc1PBc
	 tM1Uz7hL0ZkjoKD540e4fh/aEdpdF4jvskIOAfMN11BDUKzApZFLXAuV7QYFvKvEqL
	 Y8vDEfIdriVZiiCqCwWTnd2OKcC5FcNDCSnC3YQHvjPoejeSLRbSbLc9pgk8naiUB5
	 ifehch5ldnba6WoqCVjVCMBgSHQmtGmdmG7AqwsjqkpjNqx3Cr/hs16i8Oz5KJNyw5
	 7P6ASVqW1PdSogJuIGUF1v6R1fGqAkOvnKs8oKxS7G7+5ZnLrSc/0EdaifW8KoQ0mm
	 jPtUyVV1bTfig==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B76663781FC9;
	Wed, 20 Dec 2023 11:02:23 +0000 (UTC)
Message-ID: <80b61d00-ac87-4880-a535-0a5fdd3bed83@collabora.com>
Date: Wed, 20 Dec 2023 12:02:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvmem: mtk-efuse: Modify driver for getting chip
 information
Content-Language: en-US
To: William-tw Lin <william-tw.lin@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231220103901.22180-1-william-tw.lin@mediatek.com>
 <20231220103901.22180-4-william-tw.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231220103901.22180-4-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/12/23 11:39, William-tw Lin ha scritto:
> Retrieval of soc info is needed. This patch includes the following:
> 1. Register socinfo device in mtk-efuse.c
> 

nvmem: mtk-efuse: Register MediaTek socinfo driver from efuse

The socinfo driver reads chip information from eFuses and does not need
any devicetree node. Register it from mtk-efuse.

While at it, also add the name for this driver's nvmem_config.


^^^ that's a proper commit title and description :-)

> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
> ---
>   drivers/nvmem/mtk-efuse.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> index 84f05b40a411..3914e039e288 100644
> --- a/drivers/nvmem/mtk-efuse.c
> +++ b/drivers/nvmem/mtk-efuse.c
> @@ -68,6 +68,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
>   	struct nvmem_config econfig = {};
>   	struct mtk_efuse_priv *priv;
>   	const struct mtk_efuse_pdata *pdata;
> +	struct platform_device *socinfo;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
> @@ -85,11 +86,19 @@ static int mtk_efuse_probe(struct platform_device *pdev)
>   	econfig.size = resource_size(res);
>   	econfig.priv = priv;
>   	econfig.dev = dev;
> +	econfig.name = "mtk-efuse";
>   	if (pdata->uses_post_processing)
>   		econfig.fixup_dt_cell_info = &mtk_efuse_fixup_dt_cell_info;
>   	nvmem = devm_nvmem_register(dev, &econfig);
> +	if (IS_ERR(nvmem))
> +		return PTR_ERR(nvmem);
>   
> -	return PTR_ERR_OR_ZERO(nvmem);
> +	socinfo = platform_device_register_data(&pdev->dev, "mtk-socinfo",
> +						PLATFORM_DEVID_AUTO, NULL, 0);
> +	if (IS_ERR(socinfo))
> +		dev_info(dev, "MediaTek SoC Information will be unavailable\n");
> +

	if (IS_ERR(socinfo))
		dev_info(dev, "MediaTek SoC Information will be unavailable\n");

	platform_set_drvdata(pdev, socinfo);
	return 0;

> +	return 0;
>   }
>   
>   static const struct mtk_efuse_pdata mtk_mt8186_efuse_pdata = {


static void mtk_efuse_remove(struct platform_device *pdev)
{
	struct platform_device *socinfo = platform_get_drvdata(pdev);

	if (!IS_ERR_OR_NULL(socinfo))
		platform_device_unregister(socinfo);
}

static struct platform_driver mtk_efuse_driver = {
	.probe = mtk_efuse_probe,
	.remove_new = mtk_efuse_remove, <---- add this
	.driver = {
		.name = "mediatek,efuse",
		.of_match_table = mtk_efuse_of_match,
	}
};

After those additions, it's good for me.

Thanks,
Angelo

