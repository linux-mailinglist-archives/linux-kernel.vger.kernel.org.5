Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F897AA485
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjIUWL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjIUWLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:11:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D43D8463E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D42C32795;
        Thu, 21 Sep 2023 10:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695292255;
        bh=NcplQke/2kimQVgoG+ISd0cFiPzeZcW9x/liJMpj0E4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dI7yQh1h1G7/YujiefnLr3jF41n5s9CYMXqMYlterERnUSNccvCtWd+yg8hYvt34g
         6J+jI7KyEwAYyJRrl5qBT/t4nV8QOeM29n/yyl2dsx75dMyg2NVgWTtu25qfzAG6FS
         cFB3vt9krEMiCT2VRyg2dEj5fWWBXggTjdOjp0MRsj5zO2OciECzouKK2EeHy6ohqQ
         nSRkJHDEIvrtKop00HO/GvdgBaEUhALGB+a5NL5JUHTXT/Y8hv9ALM+H8UkbjABojj
         nodMqz+MOFOWibcX60gR9RBiUrFrGkE55d3PcJ4SvdfveGdsUDxJmzLZTQPBcRFi7B
         vw5aUBuZjQNKA==
Date:   Thu, 21 Sep 2023 11:30:50 +0100
From:   Lee Jones <lee@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 2/3] regulator: mt6358: Add output voltage fine tuning
 to fixed regulators
Message-ID: <20230921103050.GA3449785@google.com>
References: <20230913082919.1631287-1-wenst@chromium.org>
 <20230913082919.1631287-3-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230913082919.1631287-3-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023, Chen-Yu Tsai wrote:

> The "fixed" LDO regulators found on the MT6358 and MT6366 PMICs have
> either no voltage selection register, or only one valid setting.
> However these do have a fine voltage calibration setting that can
> slightly boost the output voltage from 0 mV to 100 mV, in 10 mV
> increments.
> 
> Add support for this by changing these into linear range regulators.
> Some register definitions that are missing are also added.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> This patch needs an ack from Lee.
> 
>  drivers/regulator/mt6358-regulator.c | 15 +++++++++++++--

>  include/linux/mfd/mt6358/registers.h |  6 ++++++

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
> index 935c7ad56c7e..ecb2cd1eb34f 100644
> --- a/drivers/regulator/mt6358-regulator.c
> +++ b/drivers/regulator/mt6358-regulator.c
> @@ -123,10 +123,13 @@ struct mt6358_regulator_info {
>  		.type = REGULATOR_VOLTAGE,	\
>  		.id = MT6358_ID_##vreg,	\
>  		.owner = THIS_MODULE,	\
> -		.n_voltages = 1,	\
> +		.n_voltages = 11,	\
> +		.vsel_reg = MT6358_##vreg##_ANA_CON0,	\
> +		.vsel_mask = GENMASK(3, 0),	\
>  		.enable_reg = enreg,	\
>  		.enable_mask = BIT(enbit),	\
>  		.min_uV = volt,	\
> +		.uV_step = 10000, \
>  	},	\
>  	.status_reg = MT6358_LDO_##vreg##_CON1,	\
>  	.qi = BIT(15),							\
> @@ -219,10 +222,13 @@ struct mt6358_regulator_info {
>  		.type = REGULATOR_VOLTAGE,	\
>  		.id = MT6366_ID_##vreg,	\
>  		.owner = THIS_MODULE,	\
> -		.n_voltages = 1,	\
> +		.n_voltages = 11,	\
> +		.vsel_reg = MT6358_##vreg##_ANA_CON0,	\
> +		.vsel_mask = GENMASK(3, 0),	\
>  		.enable_reg = enreg,	\
>  		.enable_mask = BIT(enbit),	\
>  		.min_uV = volt,	\
> +		.uV_step = 10000, \
>  	},	\
>  	.status_reg = MT6358_LDO_##vreg##_CON1,	\
>  	.qi = BIT(15),							\
> @@ -482,8 +488,13 @@ static const struct regulator_ops mt6358_volt_table_ops = {
>  	.get_status = mt6358_get_status,
>  };
>  
> +/* "Fixed" LDOs with output voltage calibration +0 ~ +10 mV */
>  static const struct regulator_ops mt6358_volt_fixed_ops = {
>  	.list_voltage = regulator_list_voltage_linear,
> +	.map_voltage = regulator_map_voltage_linear,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = mt6358_get_buck_voltage_sel,
> +	.set_voltage_time_sel = regulator_set_voltage_time_sel,
>  	.enable = regulator_enable_regmap,
>  	.disable = regulator_disable_regmap,
>  	.is_enabled = regulator_is_enabled_regmap,
> diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/mt6358/registers.h
> index 3d33517f178c..5ea2590be710 100644
> --- a/include/linux/mfd/mt6358/registers.h
> +++ b/include/linux/mfd/mt6358/registers.h
> @@ -262,6 +262,12 @@
>  #define MT6358_LDO_VBIF28_CON3                0x1db0
>  #define MT6358_VCAMA1_ANA_CON0                0x1e08
>  #define MT6358_VCAMA2_ANA_CON0                0x1e0c
> +#define MT6358_VFE28_ANA_CON0                 0x1e10
> +#define MT6358_VCN28_ANA_CON0                 0x1e14
> +#define MT6358_VBIF28_ANA_CON0                0x1e18
> +#define MT6358_VAUD28_ANA_CON0                0x1e1c
> +#define MT6358_VAUX18_ANA_CON0                0x1e20
> +#define MT6358_VXO22_ANA_CON0                 0x1e24
>  #define MT6358_VCN33_ANA_CON0                 0x1e28
>  #define MT6358_VSIM1_ANA_CON0                 0x1e2c
>  #define MT6358_VSIM2_ANA_CON0                 0x1e30
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 

-- 
Lee Jones [李琼斯]
