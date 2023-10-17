Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA397CBFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjJQJsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjJQJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:48:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC4098;
        Tue, 17 Oct 2023 02:48:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 01DCD66072C1;
        Tue, 17 Oct 2023 10:48:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697536082;
        bh=zm94jx7YZtaVKlcERgXxBphdF5yGXsd/A0Fvmcj8+3Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JnbVjhfam8ag2lMmYL9z5UQJY6ILzE5PDc8fGi+zbhQlJmYKOL3oWmpa0cRix16Pj
         G1jsUUpafvlh+nWy/3FvpT3tyJ+vCRuuu2hNysRB5HR4NoGG/CNTkV5UP+GHEM1zoO
         tm4iTQvYNkjIi3TxmDtnlbwmNA9YZd96mJJ85ELBvfxntsf55F7N/Nz6zovDi7MhAe
         ixSt8gY8eMmtDe83XS2o9l/dmW3aUmdf1PTKOdXvHlXz92h7aU9wt/o0MhfxMYdKFy
         U7O6r3FoF0njaPNvx99l3bexMcYAEKtjqSbF9OrMzgARru7gS4YfSt+9TSEcT7MU7q
         YdC13KKrQGmkg==
Message-ID: <91932706-c42c-4c10-96bd-c8a91b7d82f0@collabora.com>
Date:   Tue, 17 Oct 2023 11:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/23] drm/mediatek: Manage component's clock with
 function pointers
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Fei Shao <fshao@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Johnson Wang <johnson.wang@mediatek.corp-partner.google.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20231016104010.3270-1-shawn.sung@mediatek.com>
 <20231016104010.3270-16-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231016104010.3270-16-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/10/23 12:40, Hsiao Chien Sung ha scritto:
> By registering component related functions to the pointers,
> we can easily manage them within a for-loop and simplify the
> logic of clock control significantly.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 111 +++++++-----------
>   1 file changed, 44 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> index 60e5dfe9ef0d..fffef2a4f919 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> @@ -53,6 +53,7 @@ struct ovl_adaptor_comp_match {
>   	enum mtk_ovl_adaptor_comp_type type;
>   	enum mtk_ddp_comp_id comp_id;
>   	int alias_id;
> +	const struct mtk_ddp_comp_funcs *funcs;
>   };
>   
>   struct mtk_disp_ovl_adaptor {
> @@ -67,20 +68,35 @@ static const char * const private_comp_stem[OVL_ADAPTOR_TYPE_NUM] = {
>   	[OVL_ADAPTOR_TYPE_MERGE]	= "merge",
>   };
>   
> +static const struct mtk_ddp_comp_funcs _ethdr = {

Sorry I just noticed that; can you please remove the leading "_" from all
of those?

_ethdr -> ethdr or mtk_ethdr
_merge -> merge or mtk_merge
_rdma  -> rdma  or mtk_rdma

Thanks,
Angelo

