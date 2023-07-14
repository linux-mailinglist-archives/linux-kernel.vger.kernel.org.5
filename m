Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E94C752FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjGNDaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjGNDaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:30:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CE41727;
        Thu, 13 Jul 2023 20:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C3D961A0D;
        Fri, 14 Jul 2023 03:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AF8C433C8;
        Fri, 14 Jul 2023 03:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689305404;
        bh=r5BgOqjclAtqUQp1hraka226NEScyIQcgZdeBe+qihE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBxz5gezLDgg1xKxxuIzbXI+K52o+kD1+XMMT1n5kokPz8c5UYmVauHoBCupNHfOT
         s7kuZrwAqpRIDibGyhPEoSRo3Mm0drw20/YQQPKtr9WqGwEMjASlOjIvL4b8lgvDWi
         nGDjI4l09okAFobR2rY23vJV6vzSPah65yd66Vd+3QppmxGmNsAUkrB7Toyw8KIZcK
         +zziLJxloG/IFz1Vz3b1QMBOewi3pZtmi+pB1APQYtE74H+0eKYTY0vFYt1t1tqJn6
         dARRS4jm7GOHvBraotYGR1otAzKX6ONPynr+wvryOSuSZe94gsu5QDRQsiZFp6Y6kV
         HB4ujjUNh7dnw==
Date:   Thu, 13 Jul 2023 20:33:34 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Minghao Zhang <quic_minghao@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_satyap@quicinc.com, quic_tsoni@quicinc.com
Subject: Re: [PATCH V3] pinctrl: qcom: Add support to log pin status before
 suspend for TLMM
Message-ID: <ztp67pftiuwirfkfqqx76j4mgm4t7mxdgahsiip6lxiszf6lxg@zfkyqtsx2zoo>
References: <20230712105200.26012-1-quic_minghao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712105200.26012-1-quic_minghao@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 06:52:00PM +0800, Minghao Zhang wrote:
> This change supports to print pin status before device suspend
> to debug for TLMM. And expose 2 APIs to enable/disable this
> functionality.
> 

This sounds like a quite useful feature, can it be implemented in the
framework instead, to ensure it's applicable to other gpio drivers?

> Signed-off-by: Minghao Zhang <quic_minghao@quicinc.com>
> ---

Please include a list of changes made since previous versions of your
patches.

>  drivers/pinctrl/qcom/pinctrl-msm.c | 133 ++++++++++++++++++++++-------
>  drivers/pinctrl/qcom/pinctrl-msm.h |   4 +
>  2 files changed, 108 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 2585ef2b2793..ed1c5b2817aa 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -82,6 +82,21 @@ struct msm_pinctrl {
>  	u32 phys_base[MAX_NR_TILES];
>  };
>  
> +static bool pinctrl_msm_log_mask;

Other symbols are prefixed with "msm_gpio_", so perhaps
msm_gpio_suspend_log?

> +
> +static const char * const pulls_keeper[] = {
> +	"no pull",
> +	"pull down",
> +	"keeper",
> +	"pull up"
> +};
> +
> +static const char * const pulls_no_keeper[] = {
> +	"no pull",
> +	"pull down",
> +	"pull up",
> +};
> +
>  #define MSM_ACCESSOR(name) \
>  static u32 msm_readl_##name(struct msm_pinctrl *pctrl, \
>  			    const struct msm_pingroup *g) \
> @@ -653,6 +668,29 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>  	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  }
>  
> +static void msm_gpio_pin_status_get(struct msm_pinctrl *pctrl, const struct msm_pingroup *g,
> +				    unsigned int offset, int *is_out, unsigned int *func,
> +				    int *drive, int *pull, int *egpio_enable, int *val)
> +{
> +	u32 ctl_reg, io_reg;
> +
> +	ctl_reg = msm_readl_ctl(pctrl, g);
> +	io_reg = msm_readl_io(pctrl, g);
> +
> +	*is_out = !!(ctl_reg & BIT(g->oe_bit));
> +	*func = (ctl_reg >> g->mux_bit) & 7;
> +	*drive = (ctl_reg >> g->drv_bit) & 7;
> +	*pull = (ctl_reg >> g->pull_bit) & 3;
> +	*egpio_enable = 0;
> +	if (pctrl->soc->egpio_func && ctl_reg & BIT(g->egpio_present))
> +		*egpio_enable = !(ctl_reg & BIT(g->egpio_enable));
> +
> +	if (*is_out)
> +		*val = !!(io_reg & BIT(g->out_bit));
> +	else
> +		*val = !!(io_reg & BIT(g->in_bit));
> +}
> +
>  #ifdef CONFIG_DEBUG_FS
>  
>  static void msm_gpio_dbg_show_one(struct seq_file *s,
> @@ -669,40 +707,13 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
>  	int pull;
>  	int val;
>  	int egpio_enable;
> -	u32 ctl_reg, io_reg;
> -
> -	static const char * const pulls_keeper[] = {
> -		"no pull",
> -		"pull down",
> -		"keeper",
> -		"pull up"
> -	};
> -
> -	static const char * const pulls_no_keeper[] = {
> -		"no pull",
> -		"pull down",
> -		"pull up",
> -	};
>  
>  	if (!gpiochip_line_is_valid(chip, offset))
>  		return;
>  
>  	g = &pctrl->soc->groups[offset];
> -	ctl_reg = msm_readl_ctl(pctrl, g);
> -	io_reg = msm_readl_io(pctrl, g);
> -
> -	is_out = !!(ctl_reg & BIT(g->oe_bit));
> -	func = (ctl_reg >> g->mux_bit) & 7;
> -	drive = (ctl_reg >> g->drv_bit) & 7;
> -	pull = (ctl_reg >> g->pull_bit) & 3;
> -	egpio_enable = 0;
> -	if (pctrl->soc->egpio_func && ctl_reg & BIT(g->egpio_present))
> -		egpio_enable = !(ctl_reg & BIT(g->egpio_enable));
> -
> -	if (is_out)
> -		val = !!(io_reg & BIT(g->out_bit));
> -	else
> -		val = !!(io_reg & BIT(g->in_bit));
> +	msm_gpio_pin_status_get(pctrl, g, offset, &is_out, &func,
> +					&drive, &pull, &egpio_enable, &val);
>  
>  	if (egpio_enable) {
>  		seq_printf(s, " %-8s: egpio\n", g->grp.name);
> @@ -732,6 +743,39 @@ static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
>  #define msm_gpio_dbg_show NULL
>  #endif
>  
> +static void msm_gpio_log_pin_status(struct gpio_chip *chip, unsigned int offset)
> +{
> +	const struct msm_pingroup *g;
> +	struct msm_pinctrl *pctrl = gpiochip_get_data(chip);
> +	unsigned int func;
> +	int is_out;
> +	int drive;
> +	int pull;
> +	int val;
> +	int egpio_enable;
> +
> +	if (!gpiochip_line_is_valid(chip, offset))
> +		return;
> +
> +	g = &pctrl->soc->groups[offset];
> +	msm_gpio_pin_status_get(pctrl, g, offset, &is_out, &func,
> +					&drive, &pull, &egpio_enable, &val);
> +
> +	pr_debug("%s: %s, %s, func%d, %dmA, %s\n",
> +		g->grp.name, is_out ? "out" : "in",
> +		val ? "high" : "low", func,
> +		msm_regval_to_drive(drive),
> +		pctrl->soc->pull_no_keeper ? pulls_no_keeper[pull] : pulls_keeper[pull]);
> +}
> +
> +static void msm_gpios_status(struct gpio_chip *chip)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < chip->ngpio; i++)
> +		msm_gpio_log_pin_status(chip, i);
> +}
> +
>  static int msm_gpio_init_valid_mask(struct gpio_chip *gc,
>  				    unsigned long *valid_mask,
>  				    unsigned int ngpios)
> @@ -1475,6 +1519,35 @@ SIMPLE_DEV_PM_OPS(msm_pinctrl_dev_pm_ops, msm_pinctrl_suspend,
>  
>  EXPORT_SYMBOL(msm_pinctrl_dev_pm_ops);
>  
> +void debug_pintctrl_msm_enable(void)

Inconsistent naming here as well.

> +{
> +	pinctrl_msm_log_mask = true;
> +}
> +EXPORT_SYMBOL(debug_pintctrl_msm_enable);
> +
> +void debug_pintctrl_msm_disable(void)
> +{
> +	pinctrl_msm_log_mask = false;
> +}
> +EXPORT_SYMBOL(debug_pintctrl_msm_disable);
> +
> +static __maybe_unused int noirq_msm_pinctrl_suspend(struct device *dev)
> +{
> +	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
> +
> +	if (pinctrl_msm_log_mask) {
> +		pr_debug("%s\n", pctrl->chip.label);
> +		msm_gpios_status(&pctrl->chip);
> +	}
> +
> +	return 0;
> +}
> +
> +const struct dev_pm_ops noirq_msm_pinctrl_dev_pm_ops = {
> +	.suspend_noirq = noirq_msm_pinctrl_suspend,
> +};
> +EXPORT_SYMBOL(noirq_msm_pinctrl_dev_pm_ops);

Same here.

> +
>  int msm_pinctrl_probe(struct platform_device *pdev,
>  		      const struct msm_pinctrl_soc_data *soc_data)
>  {
> @@ -1536,6 +1609,8 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>  	if (ret)
>  		return ret;
>  
> +	pinctrl_msm_log_mask = false;

This is already false.

> +
>  	platform_set_drvdata(pdev, pctrl);
>  
>  	dev_dbg(&pdev->dev, "Probed Qualcomm pinctrl driver\n");
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> index 5e4410bed823..60e0257dafbf 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> @@ -161,6 +161,10 @@ struct msm_pinctrl_soc_data {
>  };
>  
>  extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
> +extern const struct dev_pm_ops noirq_msm_pinctrl_dev_pm_ops;
> +
> +void debug_pintctrl_msm_enable(void);
> +void debug_pintctrl_msm_disable(void);

Without someone calling either of these functions this patch is just
dead code. Please include the entire solution.

Regards,
Bjorn

>  
>  int msm_pinctrl_probe(struct platform_device *pdev,
>  		      const struct msm_pinctrl_soc_data *soc_data);
> -- 
> 2.17.1
> 
