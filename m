Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97337CB6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjJPWiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPWiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:38:14 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BC2A1;
        Mon, 16 Oct 2023 15:38:12 -0700 (PDT)
Date:   Mon, 16 Oct 2023 22:37:49 +0000
From:   Yixun Lan <dlan@gentoo.org>
To:     JunYi Zhao <junyi.zhao@amlogic.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 RESEND] pwm: meson: add pwm support for S4
Message-ID: <20231016223749.GA7647@ofsar>
References: <20231016052457.1191838-1-junyi.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016052457.1191838-1-junyi.zhao@amlogic.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi JunYi

On 13:24 Mon 16 Oct     , JunYi Zhao wrote:
> From: "junyi.zhao" <junyi.zhao@amlogic.com>
> 
> Support PWM for S4 soc.
> Now the PWM clock input is done in independent CLKCTRL registers.
> And no more in the PWM registers.
> PWM needs to obtain an external clock source.
> 
> Signed-off-by: junyi.zhao <junyi.zhao@amlogic.com>
> ---
> V2 -> V3: 
> Rebase and Review the latest upstream code again.
> After reconstruction, stick to the previous code as much as possible.
>  drivers/pwm/pwm-meson.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 25519cddc2a9..fe9fd75747c4 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -99,6 +99,7 @@ struct meson_pwm_channel {
>  struct meson_pwm_data {
>  	const char * const *parent_names;
>  	unsigned int num_parents;
> +	unsigned int extern_clk;
>  };
>  
>  struct meson_pwm {
> @@ -396,6 +397,10 @@ static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
>  	.num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_names),
>  };
>  
> +static const struct meson_pwm_data pwm_s4_data = {
> +	.extern_clk = true,
> +};
> +
>  static const struct of_device_id meson_pwm_matches[] = {
>  	{
>  		.compatible = "amlogic,meson8b-pwm",
> @@ -429,6 +434,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>  		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
>  		.data = &pwm_g12a_ao_cd_data
>  	},
> +	{
> +		.compatible = "amlogic,s4-pwm",
> +		.data = &pwm_s4_data,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, meson_pwm_matches);
> @@ -451,6 +460,16 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>  		struct clk_parent_data div_parent = {}, gate_parent = {};
>  		struct clk_init_data init = {};
>  
> +		if (meson->data->extern_clk) {
> +			snprintf(name, sizeof(name), "clkin%u", i);
> +			channel->clk = devm_clk_get(dev, name);
use devm_clk_get_optional() which would save you from introducing
the 'extern_clk' variable

> +			if (IS_ERR(channel->clk)) {
> +				dev_err(meson->chip.dev, "can't get device clock\n");
> +				return PTR_ERR(channel->clk);
> +			}
> +			continue;
> +		}
> +
>  		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>  
>  		init.name = name;
> 
> base-commit: 4d2c646ac07cf4a35ef1c4a935a1a4fd6c6b1a36
> -- 
> 2.41.0
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
