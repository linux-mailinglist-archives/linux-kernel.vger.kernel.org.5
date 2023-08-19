Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F97781A34
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjHSOlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjHSOlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB56AF5B5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 438EA62378
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 14:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5515C433C9;
        Sat, 19 Aug 2023 14:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692456074;
        bh=s/6tz1ntVu9WHcizXMkOFm+PqgGopb/sQCUQJgN/UCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RspyVU2C22Gq4717Y75wZ72mw3oilJhDHzF06iNK7vIzIfhkYMC9p3Dl2ictYYcGa
         Pj8PGuyGFy+ibtb5heSsWapbk8AbmxSkJ/Fb25XVQm55KTGpkxvLPHyOwNeie2tePw
         rNelyoxgP6jWnHQTvbhRRuyGSALKNez1mGv3j1bmC6xO0dfxZe3YOmraEBSqzLGaoe
         UVJga9KYMG5ebcm3/1WhLNmrUBt4GplifCR1HcJrkbK8VnZ84veRbtuyXqi1rESuDx
         Dxu/jLbp8ezbIPP154mbSd6uPmD60Mnbv9OQeXKGBSL4dQqbN592FuHAdql9b58/9g
         3FaXaeINNMAsQ==
Date:   Sat, 19 Aug 2023 16:41:09 +0200
From:   Simon Horman <horms@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: add reset bits for MT7988
Message-ID: <ZODUhbw9SDOifv49@vergenet.net>
References: <b983a3adf5184a30e4ce620fbbf028c9c76648ae.1692382239.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b983a3adf5184a30e4ce620fbbf028c9c76648ae.1692382239.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 07:15:24PM +0100, Daniel Golle wrote:
> Add bits needed to reset the frame engine on MT7988.
> 
> Fixes: 445eb6448ed3 ("net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 76 +++++++++++++++------
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h | 11 ++-
>  2 files changed, 64 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index fe05c90202699..2482f47313085 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -3613,19 +3613,34 @@ static void mtk_hw_reset(struct mtk_eth *eth)
>  {
>  	u32 val;
>  
> -	if (mtk_is_netsys_v2_or_greater(eth)) {
> +	if (mtk_is_netsys_v2_or_greater(eth))
>  		regmap_write(eth->ethsys, ETHSYS_FE_RST_CHK_IDLE_EN, 0);
> +
> +	if (mtk_is_netsys_v3_or_greater(eth)) {
> +		val = RSTCTRL_PPE0_V3;
> +
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
> +			val |= RSTCTRL_PPE1_V3;
> +
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE2))
> +			val |= RSTCTRL_PPE2;
> +
> +		val |= RSTCTRL_WDMA0 | RSTCTRL_WDMA1 | RSTCTRL_WDMA2;
> +	} else if (mtk_is_netsys_v2_or_greater(eth)) {
>  		val = RSTCTRL_PPE0_V2;
> +
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
> +			val |= RSTCTRL_PPE1;
>  	} else {
>  		val = RSTCTRL_PPE0;
>  	}
>  
> -	if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
> -		val |= RSTCTRL_PPE1;
> -
>  	ethsys_reset(eth, RSTCTRL_ETH | RSTCTRL_FE | val);
>  
> -	if (mtk_is_netsys_v2_or_greater(eth))
> +	if (mtk_is_netsys_v3_or_greater(eth))
> +		regmap_write(eth->ethsys, ETHSYS_FE_RST_CHK_IDLE_EN,
> +			     0x6f8ff);
> +	else if (mtk_is_netsys_v2_or_greater(eth))
>  		regmap_write(eth->ethsys, ETHSYS_FE_RST_CHK_IDLE_EN,
>  			     0x3ffffff);
>  }
> @@ -3651,13 +3666,21 @@ static void mtk_hw_warm_reset(struct mtk_eth *eth)
>  		return;
>  	}
>  
> -	if (mtk_is_netsys_v2_or_greater(eth))
> +	if (mtk_is_netsys_v3_or_greater(eth)) {
> +		rst_mask = RSTCTRL_ETH | RSTCTRL_PPE0_V3;
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
> +			rst_mask |= RSTCTRL_PPE1_V3;
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE2))
> +			rst_mask |= RSTCTRL_PPE2;
> +
> +		rst_mask |= RSTCTRL_WDMA0 | RSTCTRL_WDMA1 | RSTCTRL_WDMA2;
> +	} else if (mtk_is_netsys_v2_or_greater(eth)) {
>  		rst_mask = RSTCTRL_ETH | RSTCTRL_PPE0_V2;
> -	else
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
> +			rst_mask |= RSTCTRL_PPE1;
> +	} else {
>  		rst_mask = RSTCTRL_ETH | RSTCTRL_PPE0;
> -
> -	if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
> -		rst_mask |= RSTCTRL_PPE1;
> +	}
>  
>  	regmap_update_bits(eth->ethsys, ETHSYS_RSTCTRL, rst_mask, rst_mask);
>  

Hi Daniel,

The bits set by the code in the above two hunks seem both complex
and similar. At the risk of suggesting excessive complexity,
I do wonder if they can be consolidated somehow.

Maybe the approach you have taken is best as a fix for net.
But a follow-up could be considered for net-next.
Just an idea.

...

