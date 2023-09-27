Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB027B0FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 01:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjI0X6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 19:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI0X6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 19:58:33 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A2BF5;
        Wed, 27 Sep 2023 16:58:32 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qleQB-0004AP-2S;
        Wed, 27 Sep 2023 23:58:23 +0000
Date:   Thu, 28 Sep 2023 00:56:04 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] thermal/drivers/mediatek/lvts_thermal: add mt7988
 support
Message-ID: <ZRTBFJPL3NwWpMSP@pidgin.makrotopia.org>
References: <20230922055020.6436-1-linux@fw-web.de>
 <20230922055020.6436-5-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922055020.6436-5-linux@fw-web.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 07:50:20AM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add Support for Mediatek Filogic 880/MT7988 LVTS.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Tested-by: Daniel Golle <daniel@makrotopia.org>

> ---
> v3:
> - drop comments
> 
> v2:
> - use 105°C for hw shutdown
> - move constants to binding file
> - change coeff.a to temp_factor and coeff.b to temp_offset
> - change to lvts to lvts-ap (Application Processor)
> - drop comments about efuse offsets
> - change comment of mt8195 to be similar to mt7988
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 38 +++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index c2669f405a94..23b4e0b3195c 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -82,6 +82,8 @@
>  #define LVTS_GOLDEN_TEMP_DEFAULT	50
>  #define LVTS_COEFF_A_MT8195			-250460
>  #define LVTS_COEFF_B_MT8195			250460
> +#define LVTS_COEFF_A_MT7988			-204650
> +#define LVTS_COEFF_B_MT7988			204650
>  
>  #define LVTS_MSR_IMMEDIATE_MODE		0
>  #define LVTS_MSR_FILTERED_MODE		1
> @@ -89,6 +91,7 @@
>  #define LVTS_MSR_READ_TIMEOUT_US	400
>  #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
>  
> +#define LVTS_HW_SHUTDOWN_MT7988		105000
>  #define LVTS_HW_SHUTDOWN_MT8195		105000
>  
>  #define LVTS_MINIMUM_THRESHOLD		20000
> @@ -1269,6 +1272,33 @@ static int lvts_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] = {
> +	{
> +		.cal_offset = { 0x00, 0x04, 0x08, 0x0c },
> +		.lvts_sensor = {
> +			{ .dt_id = MT7988_CPU_0 },
> +			{ .dt_id = MT7988_CPU_1 },
> +			{ .dt_id = MT7988_ETH2P5G_0 },
> +			{ .dt_id = MT7988_ETH2P5G_1 }
> +		},
> +		.num_lvts_sensor = 4,
> +		.offset = 0x0,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT7988,
> +	},
> +	{
> +		.cal_offset = { 0x14, 0x18, 0x1c, 0x20 },
> +		.lvts_sensor = {
> +			{ .dt_id = MT7988_TOPS_0},
> +			{ .dt_id = MT7988_TOPS_1},
> +			{ .dt_id = MT7988_ETHWARP_0},
> +			{ .dt_id = MT7988_ETHWARP_1}
> +		},
> +		.num_lvts_sensor = 4,
> +		.offset = 0x100,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT7988,
> +	}
> +};
> +
>  static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
>  	{
>  		.cal_offset = { 0x04, 0x07 },
> @@ -1348,6 +1378,13 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
>  	}
>  };
>  
> +static const struct lvts_data mt7988_lvts_ap_data = {
> +	.lvts_ctrl	= mt7988_lvts_ap_data_ctrl,
> +	.num_lvts_ctrl	= ARRAY_SIZE(mt7988_lvts_ap_data_ctrl),
> +	.temp_factor	= LVTS_COEFF_A_MT7988,
> +	.temp_offset	= LVTS_COEFF_B_MT7988,
> +};
> +
>  static const struct lvts_data mt8195_lvts_mcu_data = {
>  	.lvts_ctrl	= mt8195_lvts_mcu_data_ctrl,
>  	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
> @@ -1363,6 +1400,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
>  };
>  
>  static const struct of_device_id lvts_of_match[] = {
> +	{ .compatible = "mediatek,mt7988-lvts-ap", .data = &mt7988_lvts_ap_data },
>  	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },
>  	{ .compatible = "mediatek,mt8195-lvts-ap", .data = &mt8195_lvts_ap_data },
>  	{},
> -- 
> 2.34.1
> 
