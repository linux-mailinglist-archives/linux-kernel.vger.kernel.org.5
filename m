Return-Path: <linux-kernel+bounces-122770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C2C88FD03
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204001F27902
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3C77D086;
	Thu, 28 Mar 2024 10:28:14 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222BC7CF06;
	Thu, 28 Mar 2024 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621694; cv=none; b=JN/0eT0khcZT2/04oWSnFaiNywjcKKs418zrhC6AMTmD1+C7lXMVMysrXY/cdg4X1Cfp77WbLo0itZqdJQsxlnHSNlfR3Tlz5JWdaMHFuyUlRicsQJJ1EJMf5KCTVMRxMZ72MZ3nG6cnJ6Hb84LbmlC+HboY46PAflj9uNzHODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621694; c=relaxed/simple;
	bh=qtc1MXLZn7FEn8KgHG6xPeg0xgRrPQ4xvqv3ZhHDgA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPFv00NAd6zkhnf5w1hTlvLqSSu366+7uDbmYakuNBH1h/knfK0BHhQFiy/UuhbsY1/FTnhaCSNQEOL7zeR3qegMPDEpMHQY4K5CfFsvE3xqV0MTY9R5ShKw/8I60UcmFR/1mZq2TqHoDoRK1LYD3infNyfgd3xOWgcJE/90JIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: KUz5rQSlcfr/Mw9N6fjq2piC1tQJnPh6sv/S9KPw/N/UHS9LT8WuxxS4pjgEQAROVxczDc34p5
 Xmy7mddYt11A==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 28 Mar 2024 15:58:06 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: eblanc@baylibre.com
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jpanis@baylibre.com,
	kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.nirmaladevi@ltts.com,
	nm@ti.com,
	robh+dt@kernel.org,
	vigneshr@ti.com
Subject: Re: [PATCH v4 10/11] pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO
Date: Thu, 28 Mar 2024 15:57:55 +0530
Message-Id: <20240328102755.147142-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <D00EM8TTYGXL.3MMIBWJT03M5R@baylibre.com>
References: <D00EM8TTYGXL.3MMIBWJT03M5R@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Fri, 22 Mar 2024 17:03:08 +0100, Esteban Blanc wrote:
> On Wed Mar 20, 2024 at 11:25 AM CET, Bhargav Raviprakash wrote:
> > From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> >
> > Add support for TPS65224 pinctrl and GPIOs to TPS6594 driver as they have
> > significant functional overlap.
> > TPS65224 PMIC has 6 GPIOS which can be configured as GPIO or other
> > dedicated device functions.
> >
> > Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> > Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/pinctrl/pinctrl-tps6594.c | 258 +++++++++++++++++++++++++-----
> >  1 file changed, 215 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/pinctrl/pinctrl-tps6594.c b/drivers/pinctrl/pinctrl-tps6594.c
> > index 66985e54b..db0f5d2a8 100644
> > --- a/drivers/pinctrl/pinctrl-tps6594.c
> > +++ b/drivers/pinctrl/pinctrl-tps6594.c
> > @@ -320,8 +451,18 @@ static int tps6594_pinctrl_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	pctrl_desc->name = dev_name(dev);
> >  	pctrl_desc->owner = THIS_MODULE;
> > -	pctrl_desc->pins = tps6594_pins;
> > -	pctrl_desc->npins = ARRAY_SIZE(tps6594_pins);
> > +	switch (tps->chip_id) {
> > +	case TPS65224:
> > +		pctrl_desc->pins = tps65224_pins;
> > +		pctrl_desc->npins = ARRAY_SIZE(tps65224_pins);
> > +		break;
> > +	case TPS6594:
> > +		pctrl_desc->pins = tps6594_pins;
> > +		pctrl_desc->npins = ARRAY_SIZE(tps6594_pins);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> >  	pctrl_desc->pctlops = &tps6594_pctrl_ops;
> >  	pctrl_desc->pmxops = &tps6594_pmx_ops;
> 
> See below.
> 
> > @@ -329,8 +470,28 @@ static int tps6594_pinctrl_probe(struct platform_device *pdev)
> >  	if (!pinctrl)
> >  		return -ENOMEM;
> >  	pinctrl->tps = dev_get_drvdata(dev->parent);
> > -	pinctrl->funcs = pinctrl_functions;
> > -	pinctrl->pins = tps6594_pins;
> > +	switch (pinctrl->tps->chip_id) {
> 
> You could use tps->chip_id like in the previous switch.
> 
> > +	case TPS65224:
> > +		pinctrl->funcs = tps65224_pinctrl_functions;
> > +		pinctrl->func_cnt = ARRAY_SIZE(tps65224_pinctrl_functions);
> > +		pinctrl->pins = tps65224_pins;
> > +		pinctrl->num_pins = ARRAY_SIZE(tps65224_pins);
> > +		pinctrl->mux_sel_mask = TPS65224_MASK_GPIO_SEL;
> > +		pinctrl->remap = tps65224_muxval_remap;
> > +		pinctrl->remap_cnt = ARRAY_SIZE(tps65224_muxval_remap);
> > +		break;
> > +	case TPS6594:
> > +		pinctrl->funcs = pinctrl_functions;
> 
> This should be tps6594_pinctrl_functions
> 
> > +		pinctrl->func_cnt = ARRAY_SIZE(pinctrl_functions);
> > +		pinctrl->pins = tps6594_pins;
> > +		pinctrl->num_pins = ARRAY_SIZE(tps6594_pins);
> > +		pinctrl->mux_sel_mask = TPS6594_MASK_GPIO_SEL;
> > +		pinctrl->remap = tps6594_muxval_remap;
> > +		pinctrl->remap_cnt = ARRAY_SIZE(tps6594_muxval_remap);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> 
> See blow.
> 
> >  	pinctrl->pctl_dev = devm_pinctrl_register(dev, pctrl_desc, pinctrl);
> >  	if (IS_ERR(pinctrl->pctl_dev))
> >  		return dev_err_probe(dev, PTR_ERR(pinctrl->pctl_dev),
> > @@ -338,8 +499,18 @@ static int tps6594_pinctrl_probe(struct platform_device *pdev)
> >  
> >  	config.parent = tps->dev;
> >  	config.regmap = tps->regmap;
> > -	config.ngpio = TPS6594_PINCTRL_PINS_NB;
> > -	config.ngpio_per_reg = 8;
> > +	switch (pinctrl->tps->chip_id) {
> 
> Same here, use tps->chip_id
> 
Sure, will do!
> > +	case TPS65224:
> > +		config.ngpio = ARRAY_SIZE(tps65224_gpio_func_group_names);
> > +		config.ngpio_per_reg = TPS65224_NGPIO_PER_REG;
> > +		break;
> > +	case TPS6594:
> > +		config.ngpio = ARRAY_SIZE(tps6594_gpio_func_group_names);
> > +		config.ngpio_per_reg = TPS6594_NGPIO_PER_REG;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> >  	config.reg_dat_base = TPS6594_REG_GPIO_IN_1;
> >  	config.reg_set_base = TPS6594_REG_GPIO_OUT_1;
> >  	config.reg_dir_out_base = TPS6594_REG_GPIOX_CONF(0);
> 
> Regarding all the switch case, they should be use to set all the struct
> fields that are known at runtime only. For example, pinctrl->funcs, and
> pinctrl->func_cnt are known at compile time. You should create template
> structs, one for TPS6594 the other TPS65224, initialise the allocated
> struct with the template and then fill the remaining fields with the
> runtime values. Something like this:
> 
> ```c
> struct test {
>     int a;
>     int *b;
> };
> 
> static struct test template = {
>     .a = 42,
> };
> 
> int main(void) {
>     struct test *test = malloc(sizeof(*test));
>     *test = sample;
>     test->b = NULL;
> 
>     return 0;
> }
> ```
> 
> You could also try to reduce the number of switch case, there is no good
> reason to have 2 switch instead of one for pctrl_desc and pinctrl
> structs.
> 
> Best regards,
> 
> -- 
> Esteban "Skallwar" Blanc
> BayLibre

Thank you for bringing these issues to our attention.
We will follow the template struct way as suggested and also try to reduce the number of switch
cases. These changes will be available in the next version.

Regards,
Bhargav

