Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A9479E169
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbjIMID7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238736AbjIMID5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:03:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53971995;
        Wed, 13 Sep 2023 01:03:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AB7F86607319;
        Wed, 13 Sep 2023 09:03:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694592232;
        bh=t9KoOwcPeScao1MYesE9b6L7TzTy764UcXMcMpPCPJU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FCDD979BiGVdfX/z2uopgN86c3vSzNQ4M6YyY6qryuAJ0Sl/5d20edOrvwXd1V791
         RioBld6ip9bTvkWuDHsrLhKKyyrX/GvyeqK6KecOlZyoOMUQLLzribqoFECCQFyfkM
         XtErTAr+groQ/WoYh/zubWRzwMj1510DSXXVvYcyOZ5eQlYGD1XNwlxdw28VF3NqR3
         BTC7Um07JZ/MCqsJkz2DiWKFYSgp3zKapWJFAWrzdUUrBqLgkO5FeCWuYUfPJWOZxs
         dgsZrDVkDMhHSP97aWUxjRi5cXNdmIESLpHLz8Dj0Ar3Y+kgGej1zWIafBgmfKQRhP
         8BcPeUesWHBkg==
Message-ID: <99ef1b62-0676-a912-20fb-c04c427c4d01@collabora.com>
Date:   Wed, 13 Sep 2023 10:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC v1 2/3] thermal/drivers/mediatek/lvts_thermal: make coeff
 configurable
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
References: <20230911183354.11487-1-linux@fw-web.de>
 <20230911183354.11487-3-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230911183354.11487-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/09/23 20:33, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> The upcoming mt7988 has different temperature coefficients so we
> cannot use constants in the functions lvts_golden_temp_init,
> lvts_golden_temp_init and lvts_raw_to_temp anymore.
> 
> Add a field in the lvts_ctrl pointing to the lvts_data which now
> contains the soc-specific temperature coefficents.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 56 ++++++++++++++++++-------
>   1 file changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index effd9b00a424..c1004b4da3b6 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -80,8 +80,8 @@
>   #define LVTS_SENSOR_MAX				4
>   #define LVTS_GOLDEN_TEMP_MAX		62
>   #define LVTS_GOLDEN_TEMP_DEFAULT	50
> -#define LVTS_COEFF_A				-250460
> -#define LVTS_COEFF_B				250460
> +#define LVTS_COEFF_A_MT8195			-250460
> +#define LVTS_COEFF_B_MT8195			250460
>   
>   #define LVTS_MSR_IMMEDIATE_MODE		0
>   #define LVTS_MSR_FILTERED_MODE		1
> @@ -94,7 +94,7 @@
>   #define LVTS_MINIMUM_THRESHOLD		20000
>   
>   static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
> -static int coeff_b = LVTS_COEFF_B;
> +static int coeff_b;

This could be renamed to `golden_temp_offset`

>   
>   struct lvts_sensor_data {
>   	int dt_id;
> @@ -109,9 +109,15 @@ struct lvts_ctrl_data {
>   	int mode;
>   };
>   
> +struct formula_coeff {
> +	int a;
> +	int b;
> +};
> +
>   struct lvts_data {
>   	const struct lvts_ctrl_data *lvts_ctrl;
>   	int num_lvts_ctrl;
> +	struct formula_coeff coeff;

You can just add the coefficients here directly... and while at it you can
also make it self explanatory, because the "A" coefficient is a factor while
the "B" coefficient is just an offset.

	int temp_factor; <--- coeff_a
	int temp_offset; <--- coeff_b

>   };
>   
>   struct lvts_sensor {
> @@ -126,6 +132,7 @@ struct lvts_sensor {
>   
>   struct lvts_ctrl {
>   	struct lvts_sensor sensors[LVTS_SENSOR_MAX];
> +	const struct lvts_data *lvts_data;
>   	u32 calibration[LVTS_SENSOR_MAX];
>   	u32 hw_tshut_raw_temp;
>   	int num_lvts_sensor;
> @@ -247,21 +254,21 @@ static void lvts_debugfs_exit(struct lvts_domain *lvts_td) { }
>   
>   #endif
>   
> -static int lvts_raw_to_temp(u32 raw_temp)
> +static int lvts_raw_to_temp(u32 raw_temp, struct formula_coeff coeff)
>   {
>   	int temperature;
>   
> -	temperature = ((s64)(raw_temp & 0xFFFF) * LVTS_COEFF_A) >> 14;
> +	temperature = ((s64)(raw_temp & 0xFFFF) * coeff.a) >> 14;

so that this also becomes more readable:

static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
{
	int temperature;

	temperature = ((s64)(raw_temp & 0xFFFF) * temp_factor) >> 14;
	temperature += golden_temp_offset;

	return temperature;
}

where temp_factor is lvts_data.temp_factor, and golden_temp_offset is a
rename of `static int coeff_b`.

Cheers,
Angelo

