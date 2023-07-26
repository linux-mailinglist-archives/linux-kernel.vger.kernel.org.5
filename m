Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B929A762C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjGZHDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjGZHC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:02:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E99B423B;
        Wed, 26 Jul 2023 00:01:32 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D32EA6606FCD;
        Wed, 26 Jul 2023 08:01:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690354890;
        bh=b3275iZpeVMp7nlokph744oUHdv+Z9l5geLiebs0KXw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AGGIjrK1AuhE4G3/2REeqPS4TJ2FRl25j8vVbcMqiVq2MlrPCIAd55MPFSwbMpPD8
         n8InzWlzbUkEAItf9kNquzNKvx1c796WVHHlA/WGUNCBaje9GqkcfiT90/gWDP+C5K
         yxxfXeQVYk0CgcH7WEKRbnJJvxCWtBkB6ERJe1VJUOZqmSC13hQFNiEQnrayjJpnec
         JYX7BwUEUM9BOg/9byTpO+hoLfnmVyfnpPfHBe7v4QzHYgnPtgQmrr+4HfmxZ490eC
         B5a/ANfAO28MTYS7rSsygVd4A4qn11nZL18pYrhEZlL10tlWTJ+/NdInrxhqP3HnxY
         FgXWhaSfnxyDg==
Message-ID: <5a7c6b24-03f1-dd33-5911-ce046ee140f1@collabora.com>
Date:   Wed, 26 Jul 2023 09:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: mediatek: vcodec: Consider vdecsys presence in reg
 range check
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230725204043.569799-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230725204043.569799-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/07/23 22:40, Nícolas F. R. A. Prado ha scritto:
> Commit fe8a33978383 ("media: mediatek: vcodec: Read HW active status
> from syscon") allowed the driver to read the VDEC_SYS io space from a
> syscon instead of from the reg property when reg-names are supplied.
> However as part of that change, a smatch warning was introduced:
> 
> drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c:142 mtk_vcodec_get_reg_bases() error: buffer overflow 'mtk_dec_reg_names' 11 <= 11
> 
> With a correct Devicetree, that is, one that follows the dt-binding, it
> wouldn't be possible to trigger such a buffer overflow. Even so, update
> the range validation of the reg property, so that the smatch warning is
> fixed and if an incorrect Devicetree is ever supplied the code errors
> out instead of causing memory corruption.
> 
> Reported-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Closes: https://lore.kernel.org/all/b5fd2dff-14a5-3ad8-9698-d1a50f4516fa@xs4all.nl
> Fixes: fe8a33978383 ("media: mediatek: vcodec: Read HW active status from syscon")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>   drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> index 742b6903d030..cd62b3f68072 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> @@ -124,7 +124,8 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
>   	/* Sizeof(u32) * 4 bytes for each register base. */
>   	reg_num = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
>   						  sizeof(u32) * 4);
> -	if (reg_num <= 0 || reg_num > NUM_MAX_VDEC_REG_BASE) {
> +	if (reg_num <= 0 || reg_num > NUM_MAX_VDEC_REG_BASE ||

You could also simplify this like

int num_max_vdec_regs;

....

num_max_vdec_regs = no_vdecsys_reg ?
		    ARRAY_SIZE(mtk_dec_reg_names) : NUM_MAX_VDEC_REG_BASE;

if (reg_num <= 0 || reg_num > num_max_vdec_regs) ....

I'd go for the proposed solution, as it looks better in my eyes, but it's
ultimately your choice and probably just a personal preference.

That said, if you want to keep this commit as it is, you still get my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +	    (!has_vdecsys_reg && reg_num > NUM_MAX_VDEC_REG_BASE - 1)) {
>   		dev_err(&pdev->dev, "Invalid register property size: %d\n", reg_num);
>   		return -EINVAL;
>   	}

