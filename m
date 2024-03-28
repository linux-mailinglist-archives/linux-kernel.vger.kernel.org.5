Return-Path: <linux-kernel+bounces-122563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB5F88F9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 003B6B24DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89B65380E;
	Thu, 28 Mar 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aqp0vuZ7"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EAF53E32
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613085; cv=none; b=nimHt4ZkAeCDyEdHg0gs3kG45CXvdlPFIoFE+FFQ7oPQYwvP0f7VGiYGDkgqfWOnCKW6qt1877Dpunn4na4PPekt6OSXo8YGr0JItSba4DJuAUge6jA9FxERS2PfUbAVwicRPgD10uhC90eKS/Y6mfbppg+pncoHsitUnplEWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613085; c=relaxed/simple;
	bh=1IfIMUJPCrJcEvU/HJpQ33mETANwKz47NGChuO8L73s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wl1la5dK57/LA0UKq045a7coWB7Zk3pf097JI33Ycp8wTX6QsNh7ojHrMaJe9rEhz/wHSLRXpTi3ZtJm9de/wdOIz7Vut9bkBlhCfC1+2h9z7ZpLoZs6EuoAta+XfzyBSHs/iLzYrPAAeyydj8T5Zh5TnDqupbZK9IA3g6fCBiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aqp0vuZ7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-415446af364so1663755e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711613081; x=1712217881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IE60YY9x8stsstF6FxjGmnEcsnadNCBBJb7jmiQhH0k=;
        b=aqp0vuZ7b0kM3Dyk6LJYFABTJ4WAfJztZFdN8JC9QuMY3fBMYY6MAcKhgEW1KZFrYs
         dquepKF7GR/OfN/RoJ6xTU2euJO+2a9KnnHoXrF0lxL4G3t/zCN3ch6HQGKuU2cPHcIp
         oGJUC+Fv12OYUNl+lK/WpyQRq3OXnR56Wb6ZKy6Sn4XM4/k2q99AZkJXZOPaV/PbEizk
         e6K8x+eHWutVCtk8xZhR2Nuf+UhmyD9tfQg/55DE+5lglsrPIMlId0/B8QytNbb1Roni
         CtxzSUVERQOJO3BLt7mKmOA+AIfvtAqRXG6O2EsiXIUjScPUOjFt+r9Ci04gAHnS0Qj3
         6BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613081; x=1712217881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IE60YY9x8stsstF6FxjGmnEcsnadNCBBJb7jmiQhH0k=;
        b=PdC9ilwzIXozbpEQtSDzE9mBZ2IEKRN57Z+xsLYjpssUp8U+jTBBV3jpQG3XcDxKaX
         /kpoWoZYKMk3jGAGnxi0lUjLYODixDyS0+ILzMpqFhgNRW6bBHEkbPXcd8CBuy6GuYxv
         sVH1rGmFzXBFDMpmMR9Eld0VNQE64ANgsJWhdd4v+tJ12h5EYJP2Mx0jYBgRLWU+trHp
         LotO9V6y9qc2ts8UUZlneZ2MXO7wNdZ6+aptJuwMDVE7DHA7KW/7y5Sw065j8D63Cxx9
         bnjnxFoVfE3+2N2+51lpcVT7ZMkyu9j3bPhZcPEjmUUx6s6wW+cAoP7sCRlhIVEm9ul8
         9KUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+xwnGPepzsTdrREY+2s+UsHJ0wgfvC5ka6AwsrsCu2plPFKgpMTjEUPGJtEGAVGSmClmWTQ7iNV6ZBaE9KL1jjgGjoU1iIbfAB9M0
X-Gm-Message-State: AOJu0YwG14kS3itkslL3ONyg1JoejgDzvVze2TKhOCpm2BRx/U2MhINE
	4QCRGP97XCUChx8RqiCw39v+3d17ciLixcR4CBYfpLmSD1PuKPN4Q9aLHY24Tdg=
X-Google-Smtp-Source: AGHT+IEA7qoUpuY62S7NdrqDJtJPhLzqNQtS5yzbBMI2/sPBZOCORmsDIlHNpSOVko3UPfrXF7zzjw==
X-Received: by 2002:a05:600c:4986:b0:415:43f1:cacd with SMTP id h6-20020a05600c498600b0041543f1cacdmr908263wmp.2.1711613080802;
        Thu, 28 Mar 2024 01:04:40 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c1d0e00b0041477f95cf6sm1453553wms.13.2024.03.28.01.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 01:04:40 -0700 (PDT)
Message-ID: <25bc9ceb-c5cb-40a2-8c3d-d9666b88546c@tuxon.dev>
Date: Thu, 28 Mar 2024 10:04:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/13] pinctrl: renesas: pinctrl-rzg2l: Add support
 for RZ/V2H SoC
Content-Language: en-US
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240326222844.1422948-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240326222844.1422948-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Prabhakar,

On 27.03.2024 00:28, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add pinctrl driver support for RZ/V2H(P) SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 483 +++++++++++++++++++++++-
>  1 file changed, 481 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index 6f0c85bb97a8..716c11ca5a8f 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -59,6 +59,13 @@
>  #define PIN_CFG_OEN			BIT(15)
>  #define PIN_CFG_VARIABLE		BIT(16)
>  #define PIN_CFG_NOGPIO_INT		BIT(17)
> +#define PIN_CFG_OPEN_DRAIN		BIT(18)
> +#define PIN_CFG_SCHMIT_CTRL		BIT(19)
> +#define PIN_CFG_ELC			BIT(20)
> +#define PIN_CFG_IOLH_1			BIT(21)
> +#define PIN_CFG_IOLH_2			BIT(22)
> +#define PIN_CFG_IOLH_3			BIT(23)
> +#define PIN_CFG_IOLH_4			BIT(24)
>  
>  #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
>  					(PIN_CFG_IOLH_##group | \
> @@ -70,6 +77,10 @@
>  #define RZG2L_MPXED_PIN_FUNCS		(RZG2L_MPXED_COMMON_PIN_FUNCS(A) | \
>  					 PIN_CFG_SR)
>  
> +#define RZV2H_MPXED_PIN_FUNCS(group)	(RZG2L_MPXED_COMMON_PIN_FUNCS(group) | \
> +					 PIN_CFG_OPEN_DRAIN | \
> +					 PIN_CFG_SR)
> +
>  #define RZG3S_MPXED_PIN_FUNCS(group)	(RZG2L_MPXED_COMMON_PIN_FUNCS(group) | \
>  					 PIN_CFG_SOFT_PS)
>  
> @@ -133,6 +144,8 @@
>  
>  #define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
>  #define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
> +#define PWPR_REGWE_A		BIT(6)	/* PFC and PMC Register Write Enable */
> +#define PWPR_REGWE_B		BIT(5)	/* OEN Register Write Enable */
>  
>  #define PM_MASK			0x03
>  #define PFC_MASK		0x07
> @@ -149,6 +162,19 @@
>  #define RZG2L_TINT_IRQ_START_INDEX	9
>  #define RZG2L_PACK_HWIRQ(t, i)		(((t) << 16) | (i))
>  
> +/* Custom pinconf parameters */
> +#define RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE	(PIN_CONFIG_END + 1)
> +
> +static const struct pinconf_generic_params renesas_rzv2h_custom_bindings[] = {
> +	{ "renesas-rzv2h,output-impedance", RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE, 1 },
> +};
> +
> +#ifdef CONFIG_DEBUG_FS
> +static const struct pin_config_item renesas_rzv2h_conf_items[] = {
> +	PCONFDUMP(RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE, "output-impedance", "x", true),
> +};
> +#endif
> +
>  /* Read/write 8 bits register */
>  #define RZG2L_PCTRL_REG_ACCESS8(_read, _addr, _val)	\
>  	do {						\
> @@ -324,6 +350,8 @@ struct rzg2l_pinctrl {
>  	spinlock_t			lock; /* lock read/write registers */
>  	struct mutex			mutex; /* serialize adding groups and functions */
>  
> +	raw_spinlock_t			pwpr_lock; /* serialize PWPR register access */
> +
>  	struct rzg2l_pinctrl_pin_settings *settings;
>  	struct rzg2l_pinctrl_reg_cache	*cache;
>  	struct rzg2l_pinctrl_reg_cache	*dedicated_cache;
> @@ -348,6 +376,79 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctrl,
>  	return 0;
>  }
>  
> +static const struct rzg2l_variable_pin_cfg r9a09g057_variable_pin_cfg[] = {
> +	{
> +		.port = 9,
> +		.pin = 0,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL,
> +	},
> +	{
> +		.port = 9,
> +		.pin = 1,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL,
> +	},
> +	{
> +		.port = 9,
> +		.pin = 2,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL,
> +	},
> +	{
> +		.port = 9,
> +		.pin = 3,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
> +	},
> +	{
> +		.port = 9,
> +		.pin = 4,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
> +	},
> +	{
> +		.port = 9,
> +		.pin = 5,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
> +	},
> +	{
> +		.port = 9,
> +		.pin = 6,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
> +	},
> +	{
> +		.port = 9,
> +		.pin = 7,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
> +	},
> +	{
> +		.port = 11,
> +		.pin = 0,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL,
> +	},
> +	{
> +		.port = 11,
> +		.pin = 1,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
> +	},
> +	{
> +		.port = 11,
> +		.pin = 2,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
> +	},
> +	{
> +		.port = 11,
> +		.pin = 3,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
> +	},
> +	{
> +		.port = 11,
> +		.pin = 4,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
> +	},
> +	{
> +		.port = 11,
> +		.pin = 5,
> +		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
> +	},
> +};
> +
>  #ifdef CONFIG_RISCV
>  static const struct rzg2l_variable_pin_cfg r9a07g043f_variable_pin_cfg[] = {
>  	{
> @@ -474,6 +575,19 @@ static void rzg2l_pmc_writeb(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *
>  	writeb(val, addr);
>  }
>  
> +static void rzv2h_pmc_writeb(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *addr)
> +{
> +	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
> +	u8 pwpr;
> +
> +	raw_spin_lock(&pctrl->pwpr_lock);
> +	pwpr = readb(pctrl->base + regs->pwpr);
> +	writeb(pwpr | PWPR_REGWE_A, pctrl->base + regs->pwpr);

What about having a device specific function that locks/unlocks the PWPR,
this part ^ being the lock.



> +	writeb(val, addr);

And this starting here:

> +	writeb(pwpr & ~PWPR_REGWE_A, pctrl->base + regs->pwpr);
> +	raw_spin_unlock(&pctrl->pwpr_lock);

ending here: the unlock function. It should generate les diffs at least in
this patch.

And you can add, were needed:

if (pctrl->pwpr_lock_function)
	pctrl->pwpr_lock_function();

write(val, addr);

if (pctrl->pwpr_unlock_function)
	pctrl->pwpr_unlock_function();


With this you can avoid adding rzv2h_pinctrl_set_pfc_mode() which is alomst
identical w/ rzg2l_pinctrl_set_pfc_mode(), or adding
rzv2h_pinctrl_pm_setup_pfc() almost identical with
rzg2l_pinctrl_pm_setup_pfc().

> +}
> +
>  static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
>  				       u8 pin, u8 off, u8 func)
>  {
> @@ -512,6 +626,47 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
>  	spin_unlock_irqrestore(&pctrl->lock, flags);
>  };
>  
> +static void rzv2h_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
> +				       u8 pin, u8 off, u8 func)
> +{
> +	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
> +	unsigned long flags;
> +	u32 reg;
> +	u8 pwpr;
> +
> +	spin_lock_irqsave(&pctrl->lock, flags);
> +
> +	/* Set pin to 'Non-use (Hi-Z input protection)'  */
> +	reg = readw(pctrl->base + PM(off));
> +	reg &= ~(PM_MASK << (pin * 2));
> +	writew(reg, pctrl->base + PM(off));
> +
> +	/* Set the PWPR register to allow PFC and PMC register to write */
> +	raw_spin_lock(&pctrl->pwpr_lock);
> +	pwpr = readb(pctrl->base + regs->pwpr);
> +	writeb(PWPR_PFCWE | pwpr, pctrl->base + regs->pwpr);
> +
> +	/* Temporarily switch to GPIO mode with PMC register */
> +	reg = readb(pctrl->base + PMC(off));
> +	writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
> +
> +	/* Select Pin function mode with PFC register */
> +	reg = readl(pctrl->base + PFC(off));
> +	reg &= ~(PFC_MASK << (pin * 4));
> +	writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
> +
> +	/* Switch to Peripheral pin function with PMC register */
> +	reg = readb(pctrl->base + PMC(off));
> +	writeb(reg | BIT(pin), pctrl->base + PMC(off));
> +
> +	/* Set the PWPR register to be write-protected */
> +	pwpr = readb(pctrl->base + regs->pwpr);
> +	writeb(pwpr & ~PWPR_PFCWE, pctrl->base + regs->pwpr);
> +	raw_spin_unlock(&pctrl->pwpr_lock);
> +
> +	spin_unlock_irqrestore(&pctrl->lock, flags);
> +};
> +
>  static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>  				 unsigned int func_selector,
>  				 unsigned int group_selector)
> @@ -1087,14 +1242,26 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8
>  	return 0;
>  }
>  
> +static u32 rzv2h_read_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin)
> +{
> +	/* stub */
> +	return 0;
> +}
> +
> +static int rzv2h_write_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin, u8 oen)
> +{
> +	/* stub */
> +	return -EINVAL;
> +}
> +

What about chekcing:
if (pctrl->data->read_oen)
	ret = pctrl->data->read_oen()

if (pctrl->data->write_oen)
	ret = pctrl->data->write_oen()

Accross the driver. This will avoid adding stubs each time suppor for a new
IP is added.

>  static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
>  				     unsigned int _pin,
>  				     unsigned long *config)
>  {
>  	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> -	enum pin_config_param param = pinconf_to_config_param(*config);
>  	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
>  	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
> +	u32 param = pinconf_to_config_param(*config);
>  	u64 *pin_data = pin->drv_data;
>  	unsigned int arg = 0;
>  	u32 off, cfg;
> @@ -1180,6 +1347,30 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
>  		break;
>  	}
>  
> +	case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE: {
> +		u8 val;
> +
> +		if (!(cfg & (PIN_CFG_IOLH_1 | PIN_CFG_IOLH_2 | PIN_CFG_IOLH_3 | PIN_CFG_IOLH_4)))
> +			return -EINVAL;
> +
> +		val = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
> +		switch (val) {
> +		case 0:
> +			arg = 1;
> +			break;
> +		case 1:
> +			arg = 2;
> +			break;
> +		case 2:
> +			arg = 4;
> +			break;
> +		default:
> +			arg = 6;
> +			break;
> +		}
> +		break;
> +	}
> +
>  	default:
>  		return -ENOTSUPP;
>  	}
> @@ -1199,9 +1390,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
>  	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
>  	struct rzg2l_pinctrl_pin_settings settings = pctrl->settings[_pin];
>  	u64 *pin_data = pin->drv_data;
> -	enum pin_config_param param;
>  	unsigned int i, arg, index;
>  	u32 cfg, off;
> +	u32 param;
>  	int ret;
>  	u8 bit;
>  
> @@ -1283,6 +1474,32 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
>  			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
>  			break;
>  
> +		case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
> +			arg = pinconf_to_config_argument(_configs[i]);
> +
> +			if (!(cfg & (PIN_CFG_IOLH_1 | PIN_CFG_IOLH_2 |
> +				     PIN_CFG_IOLH_3 | PIN_CFG_IOLH_4)))
> +				return -EINVAL;
> +
> +			switch (arg) {
> +			case 1:
> +				index = 0;
> +				break;
> +			case 2:
> +				index = 1;
> +				break;
> +			case 4:
> +				index = 2;
> +				break;
> +			case 6:
> +				index = 3;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
> +			break;
> +
>  		default:
>  			return -EOPNOTSUPP;
>  		}
> @@ -1730,6 +1947,38 @@ static const u64 r9a08g045_gpio_configs[] = {
>  	RZG2L_GPIO_PORT_PACK(6, 0x2a, RZG3S_MPXED_PIN_FUNCS(A)),			/* P18 */
>  };
>  
> +static const char * const rzv2h_gpio_names[] = {
> +	"P00", "P01", "P02", "P03", "P04", "P05", "P06", "P07",
> +	"P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17",
> +	"P20", "P21", "P22", "P23", "P24", "P25", "P26", "P27",
> +	"P30", "P31", "P32", "P33", "P34", "P35", "P36", "P37",
> +	"P40", "P41", "P42", "P43", "P44", "P45", "P46", "P47",
> +	"P50", "P51", "P52", "P53", "P54", "P55", "P56", "P57",
> +	"P60", "P61", "P62", "P63", "P64", "P65", "P66", "P67",
> +	"P70", "P71", "P72", "P73", "P74", "P75", "P76", "P77",
> +	"P80", "P81", "P82", "P83", "P84", "P85", "P86", "P87",
> +	"P90", "P91", "P92", "P93", "P94", "P95", "P96", "P97",
> +	"PA0", "PA1", "PA2", "PA3", "PA4", "PA5", "PA6", "PA7",
> +	"PB0", "PB1", "PB2", "PB3", "PB4", "PB5", "PB6", "PB7",
> +};
> +
> +static const u64 r9a09g057_gpio_configs[] = {
> +	RZG2L_GPIO_PORT_PACK(8, 0x20, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* P0 */
> +	RZG2L_GPIO_PORT_PACK(6, 0x21, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* P1 */
> +	RZG2L_GPIO_PORT_PACK(2, 0x22, RZV2H_MPXED_PIN_FUNCS(4)),			/* P2 */
> +	RZG2L_GPIO_PORT_PACK(8, 0x23, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* P3 */
> +	RZG2L_GPIO_PORT_PACK(8, 0x24, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* P4 */
> +	RZG2L_GPIO_PORT_PACK(8, 0x25, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* P5 */
> +	RZG2L_GPIO_PORT_PACK(8, 0x26, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL |
> +			     PIN_CFG_ELC),						/* P6 */
> +	RZG2L_GPIO_PORT_PACK(8, 0x27, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* P7 */
> +	RZG2L_GPIO_PORT_PACK(8, 0x28, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL |
> +			    PIN_CFG_ELC),						/* P8 */
> +	RZG2L_GPIO_PORT_PACK(8, 0x29, PIN_CFG_VARIABLE),				/* P9 */
> +	RZG2L_GPIO_PORT_PACK(8, 0x2a, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* PA */
> +	RZG2L_GPIO_PORT_PACK(6, 0x2b, PIN_CFG_VARIABLE),				/* PB */
> +};
> +
>  static const struct {
>  	struct rzg2l_dedicated_configs common[35];
>  	struct rzg2l_dedicated_configs rzg2l_pins[7];
> @@ -1856,6 +2105,139 @@ static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] = {
>  						       PIN_CFG_IO_VMC_SD1)) },
>  };
>  
> +static struct rzg2l_dedicated_configs rzv2h_dedicated_pins[] = {
> +	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_FILONOFF | PIN_CFG_FILNUM |
> +						PIN_CFG_FILCLKSEL)) },
> +	{ "TMS_SWDIO", RZG2L_SINGLE_PIN_PACK(0x3, 0, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
> +						      PIN_CFG_IEN)) },
> +	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 2, (PIN_CFG_IOLH_1 | PIN_CFG_SR)) },
> +	{ "WDTUDFCA", RZG2L_SINGLE_PIN_PACK(0x5, 0, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
> +						     PIN_CFG_PUPD)) },
> +	{ "WDTUDFCM", RZG2L_SINGLE_PIN_PACK(0x5, 1, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
> +						     PIN_CFG_PUPD)) },
> +	{ "SCIF_RXD", RZG2L_SINGLE_PIN_PACK(0x6, 0, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
> +						     PIN_CFG_PUPD)) },
> +	{ "SCIF_TXD", RZG2L_SINGLE_PIN_PACK(0x6, 1, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
> +						     PIN_CFG_PUPD)) },
> +	{ "XSPI0_CKP", RZG2L_SINGLE_PIN_PACK(0x7, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD | PIN_CFG_OEN)) },
> +	{ "XSPI0_CKN", RZG2L_SINGLE_PIN_PACK(0x7, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD | PIN_CFG_OEN)) },
> +	{ "XSPI0_CS0N", RZG2L_SINGLE_PIN_PACK(0x7, 2, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
> +						       PIN_CFG_PUPD | PIN_CFG_OEN)) },
> +	{ "XSPI0_DS", RZG2L_SINGLE_PIN_PACK(0x7, 3, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						     PIN_CFG_PUPD)) },
> +	{ "XSPI0_RESET0N", RZG2L_SINGLE_PIN_PACK(0x7, 4, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
> +							  PIN_CFG_PUPD | PIN_CFG_OEN)) },
> +	{ "XSPI0_RSTO0N", RZG2L_SINGLE_PIN_PACK(0x7, 5, (PIN_CFG_PUPD)) },
> +	{ "XSPI0_INT0N", RZG2L_SINGLE_PIN_PACK(0x7, 6, (PIN_CFG_PUPD)) },
> +	{ "XSPI0_ECS0N", RZG2L_SINGLE_PIN_PACK(0x7, 7, (PIN_CFG_PUPD)) },
> +	{ "XSPI0_IO0", RZG2L_SINGLE_PIN_PACK(0x8, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "XSPI0_IO1", RZG2L_SINGLE_PIN_PACK(0x8, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "XSPI0_IO2", RZG2L_SINGLE_PIN_PACK(0x8, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "XSPI0_IO3", RZG2L_SINGLE_PIN_PACK(0x8, 3, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "XSPI0_IO4", RZG2L_SINGLE_PIN_PACK(0x8, 4, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "XSPI0_IO5", RZG2L_SINGLE_PIN_PACK(0x8, 5, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "XSPI0_IO6", RZG2L_SINGLE_PIN_PACK(0x8, 6, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "XSPI0_IO7", RZG2L_SINGLE_PIN_PACK(0x8, 7, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "SD0CLK", RZG2L_SINGLE_PIN_PACK(0x9, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR)) },
> +	{ "SD0CMD", RZG2L_SINGLE_PIN_PACK(0x9, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR)) },
> +	{ "SD0RSTN", RZG2L_SINGLE_PIN_PACK(0x9, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "SD0DAT0", RZG2L_SINGLE_PIN_PACK(0xa, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "SD0DAT1", RZG2L_SINGLE_PIN_PACK(0xa, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "SD0DAT2", RZG2L_SINGLE_PIN_PACK(0xa, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "SD0DAT3", RZG2L_SINGLE_PIN_PACK(0xa, 3, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "SD0DAT4", RZG2L_SINGLE_PIN_PACK(0xa, 4, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "SD0DAT5", RZG2L_SINGLE_PIN_PACK(0xa, 5, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "SD0DAT6", RZG2L_SINGLE_PIN_PACK(0xa, 6, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						    PIN_CFG_IOLH_2 | PIN_CFG_PUPD)) },
> +	{ "SD0DAT7", RZG2L_SINGLE_PIN_PACK(0xa, 7, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "SD1_CLK", RZG2L_SINGLE_PIN_PACK(0xb, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR)) },
> +	{ "SD1_CMD", RZG2L_SINGLE_PIN_PACK(0xb, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "SD1_DAT0", RZG2L_SINGLE_PIN_PACK(0xc, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						     PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "SD1_DAT1", RZG2L_SINGLE_PIN_PACK(0xc, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						     PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "SD1_DAT2", RZG2L_SINGLE_PIN_PACK(0xc, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						     PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "SD1_DAT3", RZG2L_SINGLE_PIN_PACK(0xc, 3, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						     PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "PCIE0_RSTOUTB", RZG2L_SINGLE_PIN_PACK(0xe, 0, (PIN_CFG_IOLH_1 | PIN_CFG_SR)) },
> +	{ "PCIE1_RSTOUTB", RZG2L_SINGLE_PIN_PACK(0xe, 1, (PIN_CFG_IOLH_1 | PIN_CFG_SR)) },
> +	{ "ET0_MDIO", RZG2L_SINGLE_PIN_PACK(0xf, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						     PIN_CFG_IEN | PIN_CFG_PUPD)) },
> +	{ "ET0_MDC", RZG2L_SINGLE_PIN_PACK(0xf, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						    PIN_CFG_PUPD)) },
> +	{ "ET0_RXCTL_RXDV", RZG2L_SINGLE_PIN_PACK(0x10, 0, (PIN_CFG_PUPD)) },
> +	{ "ET0_TXCTL_TXEN", RZG2L_SINGLE_PIN_PACK(0x10, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +							    PIN_CFG_PUPD)) },
> +	{ "ET0_TXER", RZG2L_SINGLE_PIN_PACK(0x10, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "ET0_RXER", RZG2L_SINGLE_PIN_PACK(0x10, 3, (PIN_CFG_PUPD)) },
> +	{ "ET0_RXC_RXCLK", RZG2L_SINGLE_PIN_PACK(0x10, 4, (PIN_CFG_PUPD)) },
> +	{ "ET0_TXC_TXCLK", RZG2L_SINGLE_PIN_PACK(0x10, 5, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +							   PIN_CFG_PUPD | PIN_CFG_OEN)) },
> +	{ "ET0_CRS", RZG2L_SINGLE_PIN_PACK(0x10, 6, (PIN_CFG_PUPD)) },
> +	{ "ET0_COL", RZG2L_SINGLE_PIN_PACK(0x10, 7, (PIN_CFG_PUPD)) },
> +	{ "ET0_TXD0", RZG2L_SINGLE_PIN_PACK(0x11, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "ET0_TXD1", RZG2L_SINGLE_PIN_PACK(0x11, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "ET0_TXD2", RZG2L_SINGLE_PIN_PACK(0x11, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "ET0_TXD3", RZG2L_SINGLE_PIN_PACK(0x11, 3, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "ET0_RXD0", RZG2L_SINGLE_PIN_PACK(0x11, 4, (PIN_CFG_PUPD)) },
> +	{ "ET0_RXD1", RZG2L_SINGLE_PIN_PACK(0x11, 5, (PIN_CFG_PUPD)) },
> +	{ "ET0_RXD2", RZG2L_SINGLE_PIN_PACK(0x11, 6, (PIN_CFG_PUPD)) },
> +	{ "ET0_RXD3", RZG2L_SINGLE_PIN_PACK(0x11, 7, (PIN_CFG_PUPD)) },
> +	{ "ET1_MDIO", RZG2L_SINGLE_PIN_PACK(0x12, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_SR | PIN_CFG_IEN |
> +						      PIN_CFG_PUPD)) },
> +	{ "ET1_MDC", RZG2L_SINGLE_PIN_PACK(0x12, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						     PIN_CFG_PUPD)) },
> +	{ "ET1_RXCTL_RXDV", RZG2L_SINGLE_PIN_PACK(0x13, 0, (PIN_CFG_PUPD)) },
> +	{ "ET1_TXCTL_TXEN", RZG2L_SINGLE_PIN_PACK(0x13, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +							    PIN_CFG_PUPD)) },
> +	{ "ET1_TXER", RZG2L_SINGLE_PIN_PACK(0x13, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						       PIN_CFG_PUPD)) },
> +	{ "ET1_RXER", RZG2L_SINGLE_PIN_PACK(0x13, 3, (PIN_CFG_PUPD)) },
> +	{ "ET1_RXC_RXCLK", RZG2L_SINGLE_PIN_PACK(0x13, 4, (PIN_CFG_PUPD)) },
> +	{ "ET1_TXC_TXCLK", RZG2L_SINGLE_PIN_PACK(0x13, 5, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +							   PIN_CFG_PUPD | PIN_CFG_OEN)) },
> +	{ "ET1_CRS", RZG2L_SINGLE_PIN_PACK(0x13, 6, (PIN_CFG_PUPD)) },
> +	{ "ET1_COL", RZG2L_SINGLE_PIN_PACK(0x13, 7, (PIN_CFG_PUPD)) },
> +	{ "ET1_TXD0", RZG2L_SINGLE_PIN_PACK(0x14, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "ET1_TXD1", RZG2L_SINGLE_PIN_PACK(0x14, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "ET1_TXD2", RZG2L_SINGLE_PIN_PACK(0x14, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "ET1_TXD3", RZG2L_SINGLE_PIN_PACK(0x14, 3, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
> +						      PIN_CFG_PUPD)) },
> +	{ "ET1_RXD0", RZG2L_SINGLE_PIN_PACK(0x14, 4, (PIN_CFG_PUPD)) },
> +	{ "ET1_RXD1", RZG2L_SINGLE_PIN_PACK(0x14, 5, (PIN_CFG_PUPD)) },
> +	{ "ET1_RXD2", RZG2L_SINGLE_PIN_PACK(0x14, 6, (PIN_CFG_PUPD)) },
> +	{ "ET1_RXD3", RZG2L_SINGLE_PIN_PACK(0x14, 7, (PIN_CFG_PUPD)) },
> +};
> +
>  static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl *pctrl)
>  {
>  	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[virq];
> @@ -2380,6 +2762,9 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
>  	BUILD_BUG_ON(ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT >
>  		     ARRAY_SIZE(rzg2l_gpio_names));
>  
> +	BUILD_BUG_ON(ARRAY_SIZE(r9a09g057_gpio_configs) * RZG2L_PINS_PER_PORT >
> +		     ARRAY_SIZE(rzv2h_gpio_names));
> +
>  	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
>  	if (!pctrl)
>  		return -ENOMEM;
> @@ -2402,6 +2787,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&pctrl->lock);
>  	spin_lock_init(&pctrl->bitmap_lock);
> +	raw_spin_lock_init(&pctrl->pwpr_lock);
>  	mutex_init(&pctrl->mutex);
>  	atomic_set(&pctrl->wakeup_path, 0);
>  
> @@ -2578,6 +2964,65 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
>  	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=1, PFCWE=0 */
>  }
>  
> +static void rzv2h_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)

Have you managed to test this?

> +{
> +	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
> +	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
> +	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
> +	u8 pwpr;
> +
> +	/* Set the PWPR register to allow PFC + PMC register to write. */
> +	raw_spin_lock(&pctrl->pwpr_lock);
> +	pwpr = readb(pctrl->base + regs->pwpr);
> +	writeb(pwpr | PWPR_REGWE_A, pctrl->base + regs->pwpr);	/* REGWE_A=1 */
> +
> +	/* Restore port registers. */
> +	for (u32 port = 0; port < nports; port++) {
> +		unsigned long pinmap;
> +		u8 pmc = 0, max_pin;
> +		u32 off, pfc = 0;
> +		u64 cfg;
> +		u16 pm;
> +		u8 pin;
> +
> +		cfg = pctrl->data->port_pin_configs[port];
> +		off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
> +		pinmap = FIELD_GET(PIN_CFG_PIN_MAP_MASK, cfg);
> +		max_pin = fls(pinmap);
> +
> +		pm = readw(pctrl->base + PM(off));
> +		for_each_set_bit(pin, &pinmap, max_pin) {
> +			struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
> +
> +			/* Nothing to do if PFC was not configured before. */
> +			if (!(cache->pmc[port] & BIT(pin)))
> +				continue;
> +
> +			/* Set pin to 'Non-use (Hi-Z input protection)' */
> +			pm &= ~(PM_MASK << (pin * 2));
> +			writew(pm, pctrl->base + PM(off));
> +
> +			/* Temporarily switch to GPIO mode with PMC register */
> +			pmc &= ~BIT(pin);
> +			writeb(pmc, pctrl->base + PMC(off));
> +
> +			/* Select Pin function mode. */
> +			pfc &= ~(PFC_MASK << (pin * 4));
> +			pfc |= (cache->pfc[port] & (PFC_MASK << (pin * 4)));
> +			writel(pfc, pctrl->base + PFC(off));
> +
> +			/* Switch to Peripheral pin function. */
> +			pmc |= BIT(pin);
> +			writeb(pmc, pctrl->base + PMC(off));
> +		}
> +	}
> +
> +	/* Set the PWPR register to be write-protected. */
> +	pwpr = readb(pctrl->base + regs->pwpr);
> +	writeb(pwpr & ~PWPR_REGWE_A, pctrl->base + regs->pwpr);	/* REGWE_A=0 */
> +	raw_spin_unlock(&pctrl->pwpr_lock);
> +}
> +
>  static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
>  {
>  	struct rzg2l_pinctrl *pctrl = dev_get_drvdata(dev);
> @@ -2682,6 +3127,14 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg = {
>  	.oen_max_port = 7, /* P7_1 is the maximum OEN port. */
>  };
>  
> +static const struct rzg2l_hwcfg rzv2h_hwcfg = {
> +	.regs = {
> +		.pwpr = 0x3c04,
> +		.sd_ch = 0x0,
> +		.eth_poc = 0x0,
> +	},
> +};
> +
>  static struct rzg2l_pinctrl_data r9a07g043_data = {
>  	.port_pins = rzg2l_gpio_names,
>  	.port_pin_configs = r9a07g043_gpio_configs,
> @@ -2732,6 +3185,28 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
>  	.write_oen = &rzg2l_write_oen,
>  };
>  
> +static struct rzg2l_pinctrl_data r9a09g057_data = {
> +	.port_pins = rzv2h_gpio_names,
> +	.port_pin_configs = r9a09g057_gpio_configs,
> +	.n_ports = ARRAY_SIZE(r9a09g057_gpio_configs),
> +	.dedicated_pins = rzv2h_dedicated_pins,
> +	.n_port_pins = ARRAY_SIZE(r9a09g057_gpio_configs) * RZG2L_PINS_PER_PORT,
> +	.n_dedicated_pins = ARRAY_SIZE(rzv2h_dedicated_pins),
> +	.hwcfg = &rzv2h_hwcfg,
> +	.variable_pin_cfg = r9a09g057_variable_pin_cfg,
> +	.n_variable_pin_cfg = ARRAY_SIZE(r9a09g057_variable_pin_cfg),
> +	.num_custom_params = ARRAY_SIZE(renesas_rzv2h_custom_bindings),
> +	.custom_params = renesas_rzv2h_custom_bindings,
> +#ifdef CONFIG_DEBUG_FS
> +	.custom_conf_items = renesas_rzv2h_conf_items,
> +#endif
> +	.set_pfc_mode = &rzv2h_pinctrl_set_pfc_mode,
> +	.pm_set_pfc = &rzv2h_pinctrl_pm_setup_pfc,
> +	.pmc_writeb = &rzv2h_pmc_writeb,
> +	.read_oen = &rzv2h_read_oen,
> +	.write_oen = &rzv2h_write_oen,
> +};
> +
>  static const struct of_device_id rzg2l_pinctrl_of_table[] = {
>  	{
>  		.compatible = "renesas,r9a07g043-pinctrl",
> @@ -2745,6 +3220,10 @@ static const struct of_device_id rzg2l_pinctrl_of_table[] = {
>  		.compatible = "renesas,r9a08g045-pinctrl",
>  		.data = &r9a08g045_data,
>  	},
> +	{
> +		.compatible = "renesas,r9a09g057-pinctrl",
> +		.data = &r9a09g057_data,
> +	},
>  	{ /* sentinel */ }
>  };
>  

