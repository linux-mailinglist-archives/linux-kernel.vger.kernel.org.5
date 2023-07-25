Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE267760B37
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjGYHLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGYHLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:11:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D64BD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:11:22 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4C28F6606FD7;
        Tue, 25 Jul 2023 08:11:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690269080;
        bh=TBERhvLdPc8uWltVuzDZjIEgfcEavQOsWwBq+KgJp7Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mD+Uz3nOsR3b9E5rsLGabusAUlnF9IiuDNmpgN2XPa4e1jWPIOQmOmPqxWiJ8g7RN
         ZEpZ2C90f3O/URkirjOXjZmVkso2JhW0j/qEOMKpVZgB6Mn3mxYpsD8F/jwLJEo1Z6
         yVHF5sYSfPtAWV0miOFY7wcBAUfPe+lyXAxD74O7LP+XSaLMlykcHKB9ngSooBzQC4
         vuxhdiGLP/1QqDVcZDvMprPVPiRWj4PfOISc4i9OqubrH1XeNiIdeHPC7VkarBWXfy
         4xuZQ3WAX9MAhioH2e5YUSLyIxUPYRxazeOXTs7kHKhiBcsUAmXSof5hmO4uOrPOvA
         BmoNUCfSB9JPw==
Message-ID: <229d6df5-9abb-64be-a095-dd6f5fbc3c77@collabora.com>
Date:   Tue, 25 Jul 2023 09:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] ASoC: mediatek: mt8188-mt6359: add SOF support
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230725035304.2864-1-trevor.wu@mediatek.com>
 <20230725035304.2864-4-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230725035304.2864-4-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/07/23 05:53, Trevor Wu ha scritto:
> SOF is enabled when adsp phandle is assigned to "mediatek,adsp".
> The required callback will be assigned when SOF is enabled.
> 
> Additionally, "mediatek,dai-link" is introduced to decide the supported
> dai links for a project, so user can reuse the machine driver regardless
> of dai link combination.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>   sound/soc/mediatek/mt8188/mt8188-mt6359.c | 217 ++++++++++++++++++++--
>   1 file changed, 205 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> index 667d79f33bf2..e205de2899a9 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c

..snip..

> @@ -1074,21 +1215,64 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
>   	if (!card->name)
>   		card->name = card_data->name;
>   
> -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return  -ENOMEM;
> -
>   	if (of_property_read_bool(pdev->dev.of_node, "audio-routing")) {
>   		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
>   		if (ret)
>   			return ret;
>   	}
>   
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	soc_card_data = devm_kzalloc(&pdev->dev, sizeof(*card_data), GFP_KERNEL);
> +	if (!soc_card_data)
> +		return -ENOMEM;
> +
> +	soc_card_data->mach_priv = priv;
> +
> +	adsp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,adsp", 0);
> +	if (adsp_node) {
> +		struct mtk_sof_priv *sof_priv;
> +
> +		sof_priv = devm_kzalloc(&pdev->dev, sizeof(*sof_priv), GFP_KERNEL);
> +		if (!sof_priv) {
> +			ret = -ENOMEM;
> +			goto err_adsp_node;
> +		}
> +		sof_priv->conn_streams = g_sof_conn_streams;
> +		sof_priv->num_streams = ARRAY_SIZE(g_sof_conn_streams);
> +		soc_card_data->sof_priv = sof_priv;
> +		card->probe = mtk_sof_card_probe;
> +		card->late_probe = mtk_sof_card_late_probe;
> +		if (!card->topology_shortname_created) {
> +			snprintf(card->topology_shortname, 32, "sof-%s", card->name);
> +			card->topology_shortname_created = true;
> +		}
> +		card->name = card->topology_shortname;
> +	}
> +
> +	if (of_property_read_bool(pdev->dev.of_node, "mediatek,dai-link")) {
> +		ret = mtk_sof_dailink_parse_of(card, pdev->dev.of_node,
> +					       "mediatek,dai-link",
> +					       mt8188_mt6359_dai_links,
> +					       ARRAY_SIZE(mt8188_mt6359_dai_links));
> +		if (ret) {
> +			dev_err_probe(&pdev->dev, ret, "Parse dai-link fail\n");
> +			goto err_adsp_node;
> +		}
> +	} else {
> +		if (!adsp_node)
> +			card->num_links = DAI_LINK_REGULAR_NUM;
> +	}
> +
>   	platform_node = of_parse_phandle(pdev->dev.of_node,
>   					 "mediatek,platform", 0);
>   	if (!platform_node) {
>   		ret = -EINVAL;
> -		return dev_err_probe(&pdev->dev, ret, "Property 'platform' missing or invalid\n");
> +		dev_err_probe(&pdev->dev, ret, "Property 'platform' missing or invalid\n");

We could shorten this with

ret = dev_err_probe(&pdev->dev, -EINVAL, "Property ....");
goto err_adsp_node;

...but I don't have strong opinions about that, it's your choice.

> +		goto err_platform_node;
> +
>   	}
>   
>   	ret = parse_dai_link_info(card);
> @@ -1096,8 +1280,12 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
>   		goto err;
>   
>   	for_each_card_prelinks(card, i, dai_link) {
> -		if (!dai_link->platforms->name)
> -			dai_link->platforms->of_node = platform_node;
> +		if (!dai_link->platforms->name) {
> +			if (!strncmp(dai_link->name, "AFE_SOF", strlen("AFE_SOF")) && adsp_node)
> +				dai_link->platforms->of_node = adsp_node;
> +			else
> +				dai_link->platforms->of_node = platform_node;
> +		}
>   
>   		if (strcmp(dai_link->name, "DPTX_BE") == 0) {
>   			if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
> @@ -1140,7 +1328,7 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
>   	}
>   
>   	priv->private_data = card_data;
> -	snd_soc_card_set_drvdata(card, priv);
> +	snd_soc_card_set_drvdata(card, soc_card_data);
>   
>   	ret = devm_snd_soc_register_card(&pdev->dev, card);
>   	if (ret)
> @@ -1149,6 +1337,11 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
>   err:
>   	of_node_put(platform_node);
>   	clean_card_reference(card);
> +
> +err_adsp_node:
> +err_platform_node:

Just one label is enough. Keep err_adsp_node, remove err_platform_node.

Regards,
Angelo


