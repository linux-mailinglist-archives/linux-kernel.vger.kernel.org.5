Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378E077E0D8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244822AbjHPLwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244863AbjHPLv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:51:56 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9882123;
        Wed, 16 Aug 2023 04:51:53 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 8DD34FF;
        Wed, 16 Aug 2023 13:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1692186711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voA621rn/w6ng91/WNUkg3Fq3sBx04GR1UpiWeO6YOE=;
        b=xdW4qarkIR6s8uneKejcpImybQnhai0Hxo78vhi8SpoX2C0XsJhS+0XWwTuGfDtk1LKH7c
        RYlfWnw9pR3NBb5kTgKFaLgYdtZC3BHEDD9ktCRhte1jyLSdXpL0bCl3cvggFaeMLspymG
        doLPJE+UrqA7k8BzAWspVOvM4y7+/Nb6W58kXRXThMZlI4aNxIsr4qshQD9ssDBjLPOCra
        j7zWBk1g6uKrI6iioG6eemY6Ho1bnk5vg3otGQz90K5P6STNrAIjS3ktDFymG8jEEn78fc
        vksmZAiTpSKTBaY4meGr7ZRBZux5Ox9Ru4xCmLyZvQ59XVE3bt25L4Zif0VvHw==
MIME-Version: 1.0
Date:   Wed, 16 Aug 2023 13:51:51 +0200
From:   Michael Walle <michael@walle.cc>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Miquel Raynal )" <miquel.raynal@bootlin.com>,
        "Richard Weinberger )" <richard@nod.at>,
        "Vignesh Raghavendra )" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2,1/2] mtd: spi-nor: giga: gd25lq64c: Disable quad mode
 according to bus width
In-Reply-To: <20230816104245.2676965-1-hsinyi@chromium.org>
References: <20230816104245.2676965-1-hsinyi@chromium.org>
Message-ID: <6702bac712daab13698b9bb9ad81d49e@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-08-16 12:38, schrieb Hsin-Yi Wang:
> gd25lq64c has Quad Enable Requirement flag parsed as
> BFPT_DWORD15_QER_SR2_BIT1_BUGGY in BFPT, even if spi-{rx/tx}-bus-width
> set as non QUAD, eg. 0, 1, 2... Thus quad_enable will not be NULL and
> quad enable (QE) bit will be set to 1 by default. According to
> datasheet[1], if QE bit is enabled, WP pin will become IO pin and the
> system can't use write protection feature, and it's also not 
> recommended
> to set QE bit to 1[1].
> 
> Add a post_bfpt fixup that reads spi-rx-bus-width to remove quad_enable
> if the width is set to below QUAD mode.
> 
> [1]
> https://www.gigadevice.com.cn/Public/Uploads/uploadfile/files/20220714/DS-00012-GD25LQ64C-Rev3.4.pdf
> page 13
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/mtd/spi-nor/gigadevice.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/gigadevice.c 
> b/drivers/mtd/spi-nor/gigadevice.c
> index d57ddaf1525b3..8ea89e1858f9b 100644
> --- a/drivers/mtd/spi-nor/gigadevice.c
> +++ b/drivers/mtd/spi-nor/gigadevice.c
> @@ -33,6 +33,31 @@ static const struct spi_nor_fixups gd25q256_fixups = 
> {
>  	.post_bfpt = gd25q256_post_bfpt,
>  };
> 
> +static int
> +gd25lq64c_post_bfpt(struct spi_nor *nor,
> +		    const struct sfdp_parameter_header *bfpt_header,
> +		    const struct sfdp_bfpt *bfpt)
> +{
> +	struct device_node *np = spi_nor_get_flash_node(nor);
> +	u32 value;
> +
> +	/*
> +	 * Even if spi-{tx,rx}-bus-width is set to DUAL mode, due to the QER
> +	 * flag parsed from BFPT is BFPT_DWORD15_QER_SR2_BIT1_BUGGY, so the
> +	 * quad_enable will be set and QE bit set to 1.
> +	 */
> +	if (!of_property_read_u32(np, "spi-rx-bus-width", &value)) {
> +		if (value <= 2)
> +			nor->params->quad_enable = NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct spi_nor_fixups gd25lq64c_fixups = {
> +	.post_bfpt = gd25lq64c_post_bfpt,

No. Please fix it in the core and not just for this part. To me it seems
like a fundamental problem and that commit 39d1e3340c73 ("mtd: spi-nor:
Fix clearing of QE bit on lock()/unlock()") is broken in that regard.
Tudor?

-michael
