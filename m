Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307C079F196
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjIMTBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjIMTBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:01:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FE0170F;
        Wed, 13 Sep 2023 12:01:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1093AC433C9;
        Wed, 13 Sep 2023 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694631697;
        bh=3toOGgkkDZ9WvilW/3M+1Ng0BLERDJ4aV1HGhaAbhus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4FCumqrQb/aKzssL2Onwpx0UuMy0gFzJB1TI+bff9eHTEn0MW52Z0Dllp+1K33qE
         RLnwHqijXH9+rw45W+Gkoo/a+NV7BMHdug5FBHT+OSUPQ4BdUOzrjDyQdvGwMWK4Nc
         CF8dkVMQxZGG8MBnJcDYMcS/siLjKJkMMaj9OkP6w8uZUZg1YU19txvJJU7myowabd
         KXqztyiydkTW3ore+AKj2J0zJ7lhWmzoqCXL1HC8GYgUoV4/wO1ZSe7WZ6p0OgNX3Z
         Q/LwLYyE/ho6FrMph3FgS2YdJlqcCNCvJgiFGDbNsugVWvJChBCzUVZNuhCjxgxM3N
         +i8ksbwP6v/3Q==
Date:   Wed, 13 Sep 2023 12:05:42 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 1/7] drivers: genpd: qcom: rpmpd: Fix MSM8976 power
 domains setup
Message-ID: <kci26pgiwgtconpmvuyw5ugi33algwvd75smvo34non73onvqm@z7mxzpdkp2po>
References: <20230812112534.8610-1-a39.skl@gmail.com>
 <20230812112534.8610-2-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812112534.8610-2-a39.skl@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 01:24:44PM +0200, Adam Skladowski wrote:

Please drop the "drivers:" prefix in $subject, and resubmit this with
patch (alone should be fine) with the new maintainer, and appropriate
mailing list, included.

Thanks,
Bjorn

> Downstream kernel parses resource names based on pm8950-rpm-regulator.dtsi
> in such file qcom,resource-name takes three values: smpa,ldoa and clk0.
> First appearance of RWSC/RWSM point to msm-4.4 kernel
> which is way newer than what this platform was shipped with (msm-3.10).
> For the max_state downstream code limit value to TURBO inside dts
> with only one turbo_high being placed in msm-thermal bindings.
> One of effects of requesting TURBO_HIGH vote is rebooting of device
> which happens during voting inside WCNSS/IRIS,
> this behavior was observed on LeEco S2 smartphone.
> Fix regulator setup and drop unused resources.
> 
> Fixes: b1d522443b4b ("soc: qcom: rpmpd: Add rpm power domains for msm8976")
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/genpd/qcom/rpmpd.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/genpd/qcom/rpmpd.c b/drivers/genpd/qcom/rpmpd.c
> index 3135dd1dafe0..59caa4e7b99a 100644
> --- a/drivers/genpd/qcom/rpmpd.c
> +++ b/drivers/genpd/qcom/rpmpd.c
> @@ -166,13 +166,6 @@ static struct rpmpd cx_rwcx0_vfl = {
>  	.key = KEY_FLOOR_LEVEL,
>  };
>  
> -static struct rpmpd cx_rwsc2_vfl = {
> -	.pd = { .name = "cx_vfl", },
> -	.res_type = RPMPD_RWSC,
> -	.res_id = 2,
> -	.key = KEY_FLOOR_LEVEL,
> -};
> -
>  static struct rpmpd cx_s1a_vfc = {
>  	.pd = { .name = "cx_vfc", },
>  	.res_type = RPMPD_SMPA,
> @@ -329,6 +322,13 @@ static struct rpmpd mx_s6a_lvl_ao = {
>  	.key = KEY_LEVEL,
>  };
>  
> +static struct rpmpd mx_s6a_vfl = {
> +	.pd = { .name = "mx_vfl", },
> +	.res_type = RPMPD_SMPA,
> +	.res_id = 6,
> +	.key = KEY_FLOOR_LEVEL,
> +};
> +
>  static struct rpmpd mx_s7a_lvl_ao;
>  static struct rpmpd mx_s7a_lvl = {
>  	.pd = { .name = "mx", },
> @@ -361,13 +361,6 @@ static struct rpmpd mx_rwmx0_vfl = {
>  	.key = KEY_FLOOR_LEVEL,
>  };
>  
> -static struct rpmpd mx_rwsm6_vfl = {
> -	.pd = { .name = "mx_vfl", },
> -	.res_type = RPMPD_RWSM,
> -	.res_id = 6,
> -	.key = KEY_FLOOR_LEVEL,
> -};
> -
>  /* MD */
>  static struct rpmpd md_s1a_corner_ao;
>  static struct rpmpd md_s1a_corner = {
> @@ -591,16 +584,16 @@ static const struct rpmpd_desc msm8953_desc = {
>  static struct rpmpd *msm8976_rpmpds[] = {
>  	[MSM8976_VDDCX] =	&cx_s2a_lvl,
>  	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
> -	[MSM8976_VDDCX_VFL] =	&cx_rwsc2_vfl,
> +	[MSM8976_VDDCX_VFL] =	&cx_s2a_vfl,
>  	[MSM8976_VDDMX] =	&mx_s6a_lvl,
>  	[MSM8976_VDDMX_AO] =	&mx_s6a_lvl_ao,
> -	[MSM8976_VDDMX_VFL] =	&mx_rwsm6_vfl,
> +	[MSM8976_VDDMX_VFL] =	&mx_s6a_vfl,
>  };
>  
>  static const struct rpmpd_desc msm8976_desc = {
>  	.rpmpds = msm8976_rpmpds,
>  	.num_pds = ARRAY_SIZE(msm8976_rpmpds),
> -	.max_state = RPM_SMD_LEVEL_TURBO_HIGH,
> +	.max_state = RPM_SMD_LEVEL_TURBO,
>  };
>  
>  static struct rpmpd *msm8994_rpmpds[] = {
> -- 
> 2.41.0
> 
