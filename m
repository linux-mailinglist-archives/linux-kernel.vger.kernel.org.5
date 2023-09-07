Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3676F797648
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbjIGQFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbjIGQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:05:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9751D685
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:55:42 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7CC6B660730B;
        Thu,  7 Sep 2023 13:15:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694088941;
        bh=Eqb5pNlHdN85VbMQrGQeQIo/DXWZRBobczKrVqHb3/Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JtObJKO3s+O0/WucsrR/DqY6YxlESM3EcxUaqBp8cBN9FgVYjtYutDVWp43Vw3GHy
         varInFrwfMfBPWUBDmFz6hCCvPdenkh1gILr0uQ2WCNssEQ+zX/nlRjDA447GV5YPk
         g5GxTEMxx8wkNsvnZifOsxFeh6b0XuZ/kTqRcXUklqlwVXc4mBeZnN+v4boeuAVa4j
         /6S+MtQ6xbgSZ96r/yA4jDNFmv+yc4lqor8d+QHIWAcffbuhR9Q/ggPmIeG2Yfpv6X
         VVXiRqJPlWq0IeqKOco9RHo0g0EeyGqw5fYyVGeAADVgexpqJGafloYqb8Pd+70O24
         m2gGeyZbLNavg==
Message-ID: <addaf43f-1970-0566-cf5d-8e34a61a1952@collabora.com>
Date:   Thu, 7 Sep 2023 14:15:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 07/15] drm/mediatek: Support alpha blending in VDOSYS1
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
 <20230823151332.28811-8-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230823151332.28811-8-shawn.sung@mediatek.com>
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

Il 23/08/23 17:13, Hsiao Chien Sung ha scritto:
> Support premultiply and coverage alpha blending modes.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_ethdr.c | 50 +++++++++++++++++++++-------
>   1 file changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> index 73dc4da3ba3b..3058c122a4c3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> @@ -5,6 +5,7 @@
>   
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_framebuffer.h>
> +#include <drm/drm_blend.h>
>   #include <linux/clk.h>
>   #include <linux/component.h>
>   #include <linux/of_device.h>
> @@ -35,6 +36,7 @@
>   #define MIX_SRC_L0_EN				BIT(0)
>   #define MIX_L_SRC_CON(n)		(0x28 + 0x18 * (n))
>   #define NON_PREMULTI_SOURCE			(2 << 12)
> +#define PREMULTI_SOURCE				(3 << 12)
>   #define MIX_L_SRC_SIZE(n)		(0x30 + 0x18 * (n))
>   #define MIX_L_SRC_OFFSET(n)		(0x34 + 0x18 * (n))
>   #define MIX_FUNC_DCM0			0x120
> @@ -50,9 +52,7 @@
>   
>   #define MIXER_INX_MODE_BYPASS			0
>   #define MIXER_INX_MODE_EVEN_EXTEND		1
> -#define DEFAULT_9BIT_ALPHA			0x100
>   #define	MIXER_ALPHA_AEN				BIT(8)
> -#define	MIXER_ALPHA				0xff
>   #define ETHDR_CLK_NUM				13
>   
>   enum mtk_ethdr_comp_id {
> @@ -153,33 +153,59 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
>   	struct mtk_plane_pending_state *pending = &state->pending;
>   	unsigned int offset = (pending->x & 1) << 31 | pending->y << 16 | pending->x;
>   	unsigned int align_width = ALIGN_DOWN(pending->width, 2);
> -	unsigned int alpha_con = 0;
> +	unsigned int mix_con = NON_PREMULTI_SOURCE;
> +	bool replace_src_a = false;
> +
> +	union format {
> +		unsigned int raw;
> +		char str[5];

Can we please use fixed size variables?

		u32 raw;
		u8 str[5];

> +	} format;
>   

Regards,
Angelo

