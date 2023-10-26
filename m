Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E13F7D7AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjJZCFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjJZCFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:05:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB6B194;
        Wed, 25 Oct 2023 19:05:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77420C433C7;
        Thu, 26 Oct 2023 02:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698285947;
        bh=wdYiEIeuPkKdvgg6KAstrOuZq1wQmLMrxjIDacgycTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2HzjdfIB2JR79TKCvENv+dnDPOLofWHhaYzzZqKI1gg/f+gPD+YZHQv7l3KuqM8i
         dRO5XB4RwIC5rbIcT8TfcnRQ7AFywresCW+ZkL1duWxzhIPl0fjcq1HKpCm1SYH+t/
         Ln+YXk8DCKziltY+V8/GOq1Am8e3RzZL9QmtsPssRZ4UYcvATsYXO2MqVYafZmMcgf
         bD7YtT2SMURo4oJIKrbaoJy9PTUDyY3XUwz0RnwNGybXdTWpvwxmL2cTgGGg6zWFV1
         cYlPI2tUYnh7z2bxyy675Zy0R71zn1b4VTKqcvUmUNbIaWSUlQyNo3OVaS4ZAzkjwB
         NRjABYoOT5lFA==
Date:   Wed, 25 Oct 2023 19:10:03 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pinctrl: qcom: handle intr_target_reg
 wakeup_present/enable bits
Message-ID: <vtr3s7fyrionospnmzvm2xl2plsue2jlrc3tjifqua3ihucxao@6hxi3i22bwxs>
References: <20231025-topic-sm8650-upstream-tlmm-v1-0-4e3d84a3a46b@linaro.org>
 <20231025-topic-sm8650-upstream-tlmm-v1-2-4e3d84a3a46b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-topic-sm8650-upstream-tlmm-v1-2-4e3d84a3a46b@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 09:33:52AM +0200, Neil Armstrong wrote:
> New platforms uses a new set of bits to control the wakeirq
> delivery to the PDC block.
> 
> The intr_wakeup_present_bit indicates if the GPIO supports
> wakeirq and intr_wakeup_enable_bit enables wakeirq delivery
> to the PDC block.
> 
> While the name seems to imply this only enables wakeup events,
> it is required to allow interrupts events to the PDC block.
> 
> Enable this bit in the irq resource request/free if:
> - gpio is in wakeirq map
> - has the intr_wakeup_present_bit
> - the intr_wakeup_enable_bit is set
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 32 ++++++++++++++++++++++++++++++++
>  drivers/pinctrl/qcom/pinctrl-msm.h |  5 +++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 395040346d0f..2489a9ac8455 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1196,6 +1196,7 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
>  {
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>  	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
> +	const struct msm_pingroup *g = &pctrl->soc->groups[d->hwirq];
>  	int ret;
>  
>  	if (!try_module_get(gc->owner))
> @@ -1221,6 +1222,24 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
>  	 */
>  	irq_set_status_flags(d->irq, IRQ_DISABLE_UNLAZY);
>  
> +	/*
> +	 * If the wakeup_enable bit is present and marked as available for the
> +	 * requested GPIO, it should be enabled when the GPIO is marked as
> +	 * wake irq in order to allow the interrupt event to be transfered to
> +	 * the PDC HW.
> +	 * While the name implies only the wakeup event, it's also required for
> +	 * the interrupt event.
> +	 */
> +	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
> +		u32 intr_cfg;
> +
> +		intr_cfg = msm_readl_intr_cfg(pctrl, g);
> +		if (intr_cfg & BIT(g->intr_wakeup_present_bit)) {
> +			intr_cfg |= BIT(g->intr_wakeup_enable_bit);
> +			msm_writel_intr_cfg(intr_cfg, pctrl, g);

If I understand correctly, the two modified functions are hooked
straight into the irq_chip, which would imply that nothing prevent
concurrent execution of this and the other accessors of intr_cfg.

If I'm reading this correctly, I think we should perform this
read-modify-write under the spinlock.

Regards,
Bjorn

> +		}
> +	}
> +
>  	return 0;
>  out:
>  	module_put(gc->owner);
> @@ -1230,6 +1249,19 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
>  static void msm_gpio_irq_relres(struct irq_data *d)
>  {
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
> +	const struct msm_pingroup *g = &pctrl->soc->groups[d->hwirq];
> +
> +	/* Disable the wakeup_enable bit if it has been set in msm_gpio_irq_reqres() */
> +	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
> +		u32 intr_cfg;
> +
> +		intr_cfg = msm_readl_intr_cfg(pctrl, g);
> +		if (intr_cfg & BIT(g->intr_wakeup_present_bit)) {
> +			intr_cfg &= ~BIT(g->intr_wakeup_enable_bit);
> +			msm_writel_intr_cfg(intr_cfg, pctrl, g);
> +		}
> +	}
>  
>  	gpiochip_unlock_as_irq(gc, d->hwirq);
>  	module_put(gc->owner);
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> index 4968d08a384d..63852ed70295 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> @@ -58,6 +58,9 @@ struct pinctrl_pin_desc;
>   * @intr_enable_bit:      Offset in @intr_cfg_reg for enabling the interrupt for this group.
>   * @intr_status_bit:      Offset in @intr_status_reg for reading and acking the interrupt
>   *                        status.
> + * @intr_wakeup_present_bit: Offset in @intr_target_reg specifying the GPIO can generate
> + *			  wakeup events.
> + * @intr_wakeup_enable_bit: Offset in @intr_target_reg to enable wakeup events for the GPIO.
>   * @intr_target_bit:      Offset in @intr_target_reg for configuring the interrupt routing.
>   * @intr_target_width:    Number of bits used for specifying interrupt routing target.
>   * @intr_target_kpss_val: Value in @intr_target_bit for specifying that the interrupt from
> @@ -100,6 +103,8 @@ struct msm_pingroup {
>  	unsigned intr_status_bit:5;
>  	unsigned intr_ack_high:1;
>  
> +	unsigned intr_wakeup_present_bit:5;
> +	unsigned intr_wakeup_enable_bit:5;
>  	unsigned intr_target_bit:5;
>  	unsigned intr_target_width:5;
>  	unsigned intr_target_kpss_val:5;
> 
> -- 
> 2.34.1
> 
