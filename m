Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E71806C43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377448AbjLFKi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377494AbjLFKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:38:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87E41730;
        Wed,  6 Dec 2023 02:38:42 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CB93B660732A;
        Wed,  6 Dec 2023 10:38:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701859121;
        bh=j6FSYq/wllVqa38fLBlpKeDl1PwQcbOvVLOoOX0UBbM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=R/jsCb+crLicefguBjhSXx1mhP2GI7hlj0zO2u/FMxuvkISVnxmBdvV1vanKSwmhm
         59aoYyl27HkFPeGTNKgXHf7LrPDGcLh6Y8KacgOAylkVSoqc2GqLGpeIQKl539mum2
         GZZ1RxkZAiCZmKJne1SwuC26ccLZur4h1PkA+4uLCCaeq6TmfEj8bBD3ht77kvm/Px
         RlPKBrKQX0eQLbulorYkQXgRter30Y4vHZ7qVJzP9852TVcal0cIP2Q3kPsmoQ/J3I
         tizI9NHjpxn5J4TW3+4ccUfYPZBTMiCJYGAmh/Raj9bAqD071KohK8GHAh+wCNIlHY
         JxSbyd157tTyQ==
Message-ID: <0ebce75d-0074-4128-b35e-e86ee3ee546b@collabora.com>
Date:   Wed, 6 Dec 2023 11:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] clk: mediatek: Add pcw_chg_shift control
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Jianhui Zhao <zhaojh329@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
References: <23bc89d407e7797e97b703fa939b43bfe79296ce.1701823757.git.daniel@makrotopia.org>
 <40981d0bb722eb509628bcf82c31f632e4cf747a.1701823757.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <40981d0bb722eb509628bcf82c31f632e4cf747a.1701823757.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/12/23 01:57, Daniel Golle ha scritto:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> Introduce pcw_chg_shfit control to optionally use that instead of the
> hardcoded PCW_CHG_MASK macro.
> This will needed for clocks on the MT7988 SoC.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: use git --from ...
> v2: no changes
> 
>   drivers/clk/mediatek/clk-pll.c | 5 ++++-
>   drivers/clk/mediatek/clk-pll.h | 1 +
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index 513ab6b1b3229..9f08bc5d2a8a2 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -114,7 +114,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>   			pll->data->pcw_shift);
>   	val |= pcw << pll->data->pcw_shift;
>   	writel(val, pll->pcw_addr);
> -	chg = readl(pll->pcw_chg_addr) | PCW_CHG_MASK;
> +	if (pll->data->pcw_chg_shift)
> +		chg = readl(pll->pcw_chg_addr) | BIT(pll->data->pcw_chg_shift);
> +	else
> +		chg = readl(pll->pcw_chg_addr) | PCW_CHG_MASK;
>   	writel(chg, pll->pcw_chg_addr);
>   	if (pll->tuner_addr)
>   		writel(val + 1, pll->tuner_addr);
> diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
> index f17278ff15d78..d28d317e84377 100644
> --- a/drivers/clk/mediatek/clk-pll.h
> +++ b/drivers/clk/mediatek/clk-pll.h
> @@ -44,6 +44,7 @@ struct mtk_pll_data {
>   	u32 pcw_reg;
>   	int pcw_shift;
>   	u32 pcw_chg_reg;
> +	int pcw_chg_shift;
>   	const struct mtk_pll_div_table *div_table;
>   	const char *parent_name;
>   	u32 en_reg;

Hmm... no, this is not the best at all and can be improved.

Okay, so, the situation here is that one or some PLL(s) on MT7988 have a different
PCW_CHG_MASK as far as I understand.

Situation here is:
  - Each PLL must be registered to clk-pll
  - Each driver declaring a PLL does exactly so
    - There's a function to register the PLL

You definitely don't want to add a conditional in pll_set_rate(): even though
this is technically not a performance path on the current SoCs (and will probably
never be), it's simply useless to have this (very small) overhead there.

The solution is to:
  - Change that pcw_chg_shift to an unsigned short int type (or u8, your call):
    you don't need 32 bits for this number, as the expected range of this member
    is [0-31], and this can be expressed in just 4 bits (u8 is the smallest though)
  - Add that to function mtk_clk_register_pll_ops()
  - Change mtk_pll_set_rate_regs() to always do
    chg = readl(pll->pcw_chg_addr) | BIT(pll->data->pcw_chg_shift);

Cheers,
Angelo
