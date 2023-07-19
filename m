Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254BD758FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGSIEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGSIEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:04:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241B1BE;
        Wed, 19 Jul 2023 01:04:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F07C660704A;
        Wed, 19 Jul 2023 09:04:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689753889;
        bh=aZu+C5G4JEGvi7dPWTG44N9+8Wjlujn8uw36Fei66zU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=POEUz8uBYjf3YACralX/nB2e6e7cz5yv9E3Sm1ZYDEgJos/gMyCURG1IgnqH70HyU
         8v1JWfG2Csn7Jp0G93YcTjy7zFPFZpQ/YebVeOiH82BG5Ezh/god+Ou4gzZ0nVHBmV
         jOpL3jRIx5D9NkYULetpe985QdBQUIzY/tu31Gr5vkjhJVfh6JbQY0tbV+C3uG1f6w
         0hw2Dcly8pYECIZISUAglgWYfD8vYllxmc0bwtkyYqPKec8VeCpNI37eLTMIV2RWXL
         jTkfKralTium77AeTzsvYe5pyptK0JWB8fAc5sqSu7B+qCkH6eYejQFZ1bTs8qqG+o
         eZAGrjuIIXzrA==
Message-ID: <76c60f35-aa4a-c6c7-f390-1a2982739314@collabora.com>
Date:   Wed, 19 Jul 2023 10:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] clk: mediatek: mt8183: Add back SSPM related clocks
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230719074251.1219089-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230719074251.1219089-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/07/23 09:42, Chen-Yu Tsai ha scritto:
> This reverts commit 860690a93ef23b567f781c1b631623e27190f101.
> 
> On the MT8183, the SSPM related clocks were removed claiming a lack of
> usage. This however causes some issues when the driver was converted to
> the new simple-probe mechanism. This mechanism allocates enough space
> for all the clocks defined in the clock driver, not the highest index
> in the DT binding. This leads to out-of-bound writes if their are holes
> in the DT binding or the driver (due to deprecated or unimplemented
> clocks). These errors can go unnoticed and cause memory corruption,
> leading to crashes in unrelated areas, or nothing at all. KASAN will
> detect them.
> 
> Add the SSPM related clocks back to the MT8183 clock driver to fully
> implement the DT binding. The SSPM clocks are for the power management
> co-processor, and should never be turned off. They are marked as such.
> 
> Fixes: 3f37ba7cc385 ("clk: mediatek: mt8183: Convert all remaining clocks to common probe")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

This is urgent.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Please merge for fixes.
> 
>   drivers/clk/mediatek/clk-mt8183.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> index 1ba421b38ec5..e31f94387d87 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -328,6 +328,14 @@ static const char * const atb_parents[] = {
>   	"syspll_d5"
>   };
>   
> +static const char * const sspm_parents[] = {
> +	"clk26m",
> +	"univpll_d2_d4",
> +	"syspll_d2_d2",
> +	"univpll_d2_d2",
> +	"syspll_d3"
> +};
> +
>   static const char * const dpi0_parents[] = {
>   	"clk26m",
>   	"tvdpll_d2",
> @@ -507,6 +515,9 @@ static const struct mtk_mux top_muxes[] = {
>   	/* CLK_CFG_6 */
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_ATB, "atb_sel",
>   		atb_parents, 0xa0, 0xa4, 0xa8, 0, 2, 7, 0x004, 24),
> +	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_SSPM, "sspm_sel",
> +				   sspm_parents, 0xa0, 0xa4, 0xa8, 8, 3, 15, 0x004, 25,
> +				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_DPI0, "dpi0_sel",
>   		dpi0_parents, 0xa0, 0xa4, 0xa8, 16, 4, 23, 0x004, 26),
>   	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_SCAM, "scam_sel",
> @@ -673,10 +684,18 @@ static const struct mtk_gate_regs infra3_cg_regs = {
>   	GATE_MTK(_id, _name, _parent, &infra2_cg_regs, _shift,	\
>   		&mtk_clk_gate_ops_setclr)
>   
> +#define GATE_INFRA2_FLAGS(_id, _name, _parent, _shift, _flag)	\
> +	GATE_MTK_FLAGS(_id, _name, _parent, &infra2_cg_regs, 	\
> +		       _shift, &mtk_clk_gate_ops_setclr, _flag)
> +
>   #define GATE_INFRA3(_id, _name, _parent, _shift)		\
>   	GATE_MTK(_id, _name, _parent, &infra3_cg_regs, _shift,	\
>   		&mtk_clk_gate_ops_setclr)
>   
> +#define GATE_INFRA3_FLAGS(_id, _name, _parent, _shift, _flag)	\
> +	GATE_MTK_FLAGS(_id, _name, _parent, &infra3_cg_regs, 	\
> +		       _shift, &mtk_clk_gate_ops_setclr, _flag)
> +
>   static const struct mtk_gate infra_clks[] = {
>   	/* INFRA0 */
>   	GATE_INFRA0(CLK_INFRA_PMIC_TMR, "infra_pmic_tmr", "axi_sel", 0),
> @@ -748,7 +767,11 @@ static const struct mtk_gate infra_clks[] = {
>   	GATE_INFRA2(CLK_INFRA_UNIPRO_TICK, "infra_unipro_tick", "fufs_sel", 12),
>   	GATE_INFRA2(CLK_INFRA_UFS_MP_SAP_BCLK, "infra_ufs_mp_sap_bck", "fufs_sel", 13),
>   	GATE_INFRA2(CLK_INFRA_MD32_BCLK, "infra_md32_bclk", "axi_sel", 14),
> +	/* infra_sspm is main clock in co-processor, should not be closed in Linux. */
> +	GATE_INFRA2_FLAGS(CLK_INFRA_SSPM, "infra_sspm", "sspm_sel", 15, CLK_IS_CRITICAL),
>   	GATE_INFRA2(CLK_INFRA_UNIPRO_MBIST, "infra_unipro_mbist", "axi_sel", 16),
> +	/* infra_sspm_bus_hclk is main clock in co-processor, should not be closed in Linux. */
> +	GATE_INFRA2_FLAGS(CLK_INFRA_SSPM_BUS_HCLK, "infra_sspm_bus_hclk", "axi_sel", 17, CLK_IS_CRITICAL),
>   	GATE_INFRA2(CLK_INFRA_I2C5, "infra_i2c5", "i2c_sel", 18),
>   	GATE_INFRA2(CLK_INFRA_I2C5_ARBITER, "infra_i2c5_arbiter", "i2c_sel", 19),
>   	GATE_INFRA2(CLK_INFRA_I2C5_IMM, "infra_i2c5_imm", "i2c_sel", 20),
> @@ -766,6 +789,10 @@ static const struct mtk_gate infra_clks[] = {
>   	GATE_INFRA3(CLK_INFRA_MSDC0_SELF, "infra_msdc0_self", "msdc50_0_sel", 0),
>   	GATE_INFRA3(CLK_INFRA_MSDC1_SELF, "infra_msdc1_self", "msdc50_0_sel", 1),
>   	GATE_INFRA3(CLK_INFRA_MSDC2_SELF, "infra_msdc2_self", "msdc50_0_sel", 2),
> +	/* infra_sspm_26m_self is main clock in co-processor, should not be closed in Linux. */
> +	GATE_INFRA3_FLAGS(CLK_INFRA_SSPM_26M_SELF, "infra_sspm_26m_self", "f_f26m_ck", 3, CLK_IS_CRITICAL),
> +	/* infra_sspm_32k_self is main clock in co-processor, should not be closed in Linux. */
> +	GATE_INFRA3_FLAGS(CLK_INFRA_SSPM_32K_SELF, "infra_sspm_32k_self", "f_f26m_ck", 4, CLK_IS_CRITICAL),
>   	GATE_INFRA3(CLK_INFRA_UFS_AXI, "infra_ufs_axi", "axi_sel", 5),
>   	GATE_INFRA3(CLK_INFRA_I2C6, "infra_i2c6", "i2c_sel", 6),
>   	GATE_INFRA3(CLK_INFRA_AP_MSDC0, "infra_ap_msdc0", "msdc50_hclk_sel", 7),

