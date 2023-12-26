Return-Path: <linux-kernel+bounces-11509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1131D81E76F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76ADEB21BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6044EB24;
	Tue, 26 Dec 2023 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V+7xerW5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067BC4E62C;
	Tue, 26 Dec 2023 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A43B21C0005;
	Tue, 26 Dec 2023 12:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703594265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wF40YqXw48OKejPkTOBoQmkZPCFhybyKGBS4gnGyVV0=;
	b=V+7xerW5APsdG5bEbhY8sddwrPfRJrpgaa4gGLqdVNxt9k2ElI4k8iXwA4ucgK2nYpMQBC
	aL40MU5HpXbZNmRHRTcK/VCzbgeaqGHJrYJWs/oExQG0VCSczdrGDhj3F1Fxb7QWZza6BJ
	6QXF+z3CIEJhwe8YEvTS5IF2efKW0giXzjLTCN33xOR1kj3VnGigcMcYhBchzAN403omqn
	X2kTEY0SpetChZlIGL/Np6yy40uDfYeE+YMzFNamvDjzD+LtjWq+qrkw6+BtkBIDaPwOaB
	wQ7OBSY+tIsNAdlKg4zFjddtAqRn2010sbUo2BIKAR5G4TTu2NMiEPaeMo2uRQ==
Date: Tue, 26 Dec 2023 13:37:43 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: a.zummo@towertech.it, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
	conor+dt@kernel.org, chao.wei@sophgo.com, unicorn_wang@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlan@gentoo.org,
	inochiama@outlook.com
Subject: Re: [PATCH v3 3/4] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Message-ID: <20231226123743bd2d3f0d@mail.local>
References: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
 <20231226100431.331616-4-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226100431.331616-4-qiujingbao.dlmu@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello,

please run checkpatch.pl --strict, there are a few issues.

On 26/12/2023 18:04:30+0800, Jingbao Qiu wrote:
> +struct cv1800_rtc_priv {
> +	struct rtc_device *rtc_dev;
> +	struct device *dev;
> +	struct regmap *rtc_map;
> +	struct clk *clk;
> +	spinlock_t rtc_lock;

This lock seems unnecessary, please check

> +	int irq;
> +};
> +
> +static int cv1800_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
> +{
> +	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> +
> +	if (enabled)
> +		regmap_write(info->rtc_map, ALARM_ENABLE, REG_ENABLE_FUN);
> +	else
> +		regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);
> +

This could be:
	regmap_write(info->rtc_map, ALARM_ENABLE, enabled);

> +	return 0;
> +}
> +
> +static int cv1800_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> +	unsigned long alarm_time;
> +
> +	alarm_time = rtc_tm_to_time64(&alrm->time);
> +
> +	if (alarm_time > SEC_MAX_VAL)
> +		return -EINVAL;

The core is already checking fr this.

> +
> +	regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);
> +
> +	udelay(DEALY_TIME_PREPARE);

Why is this needed?

> +
> +	regmap_write(info->rtc_map, ALARM_TIME, alarm_time);
> +	regmap_write(info->rtc_map, ALARM_ENABLE, REG_ENABLE_FUN);

You must follow alrm->enabled instead of unconditionally enabling the
alarm.

> +
> +	return 0;
> +}
> +


> +static int cv1800_rtc_32k_coarse_val_calib(struct cv1800_rtc_priv *info)

Please explain those two calibration functions. I don't think you can
achieve what you want to do.

> +{
> +	uint32_t calib_val = 0;
> +	uint32_t coarse_val = 0;
> +	uint32_t time_now = 0;
> +	uint32_t time_next = 0;
> +	uint32_t offset = CALIB_OFFSET_INIT;
> +	uint32_t coarse_timeout = REG_INIT_TIMEOUT;
> +	uint32_t get_val_timeout = 0;
> +
> +	regmap_write(info->rtc_map, ANA_CALIB, CALIB_INIT_VAL);
> +
> +	udelay(DEALY_TIME_PREPARE);
> +
> +	/* Select 32K OSC tuning val source from rtc_sys */
> +	regmap_update_bits(info->rtc_map, SEC_PULSE_GEN,
> +			   (unsigned int)(~SEC_PULSE_GEN_SEL_MASK),
> +			   (unsigned int)(~SEC_PULSE_SEL_INNER));
> +
> +	regmap_read(info->rtc_map, ANA_CALIB, &calib_val);
> +
> +	regmap_write(info->rtc_map, FC_COARSE_EN, REG_ENABLE_FUN);
> +
> +	while (--coarse_timeout) {
> +		regmap_read(info->rtc_map, FC_COARSE_CAL, &time_now);
> +		time_now >>= FC_COARSE_CAL_TIME_SHIFT;
> +
> +		get_val_timeout = REG_INIT_TIMEOUT;
> +
> +		while (time_next <= time_now &&
> +		       --get_val_timeout) {
> +			regmap_read(info->rtc_map, FC_COARSE_CAL,
> +				    &time_next);
> +			time_next >>= FC_COARSE_CAL_TIME_SHIFT;
> +			udelay(DEALY_TIME_LOOP);
> +		}
> +
> +		if (!get_val_timeout)
> +			return -1;
> +
> +		udelay(DEALY_TIME_PREPARE);
> +
> +		regmap_read(info->rtc_map, FC_COARSE_CAL, &coarse_val);
> +		coarse_val &= FC_COARSE_CAL_VAL_MASK;
> +
> +		if (coarse_val > CALIB_FC_COARSE_PLUS_OFFSET) {
> +			calib_val += offset;
> +			offset >>= CALIB_OFFSET_SHIFT;
> +			regmap_write(info->rtc_map, ANA_CALIB,
> +				     calib_val);
> +		} else if (coarse_val < CALIB_FC_COARSE_SUB_OFFSET) {
> +			calib_val -= offset;
> +			offset >>= CALIB_OFFSET_SHIFT;
> +			regmap_write(info->rtc_map, ANA_CALIB,
> +				     calib_val);
> +		} else {
> +			regmap_write(info->rtc_map, FC_COARSE_EN,
> +				     REG_DISABLE_FUN);
> +			break;
> +		}
> +
> +		if (offset == 0)
> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cv1800_rtc_32k_fine_val_calib(struct cv1800_rtc_priv *info)
> +{
> +	uint32_t val;
> +	uint64_t freq = CALIB_FREQ;
> +	uint32_t sec_cnt;
> +	uint32_t timeout = REG_INIT_TIMEOUT;
> +	uint32_t time_now = 0;
> +	uint32_t time_next = 0;
> +
> +	regmap_write(info->rtc_map, FC_FINE_EN, REG_ENABLE_FUN);
> +
> +	regmap_read(info->rtc_map, FC_FINE_CAL, &time_now);
> +	time_now >>= FC_FINE_CAL_TIME_SHIFT;
> +
> +	while (time_next <= time_now && --timeout) {
> +		regmap_read(info->rtc_map, FC_FINE_CAL, &time_next);
> +		time_next >>= FC_FINE_CAL_TIME_SHIFT;
> +		udelay(DEALY_TIME_LOOP);
> +	}
> +
> +	if (!timeout)
> +		return -1;
> +
> +	regmap_read(info->rtc_map, FC_FINE_CAL, &val);
> +	val &= FC_FINE_CAL_VAL_MASK;
> +
> +	do_div(freq, CALIB_FREQ_NS);
> +	freq = freq * CALIB_FRAC_EXT;
> +	do_div(freq, val);
> +
> +	sec_cnt = ((do_div(freq, CALIB_FRAC_EXT) * CALIB_FREQ_MULT) /
> +			   CALIB_FRAC_EXT &
> +		   SEC_PULSE_GEN_INT_MASK) +
> +		  (freq << SEC_PULSE_GEN_FRAC_SHIFT);
> +
> +	regmap_write(info->rtc_map, SEC_PULSE_GEN, sec_cnt);
> +	regmap_write(info->rtc_map, FC_FINE_EN, REG_DISABLE_FUN);
> +
> +	return 0;
> +}
> +
> +static void rtc_enable_sec_counter(struct cv1800_rtc_priv *info)
> +{
> +	/* select inner sec pulse and select reg set calibration val */
> +	regmap_update_bits(info->rtc_map, SEC_PULSE_GEN,
> +			   (unsigned int)(~SEC_PULSE_GEN_SEL_MASK),
> +			   (unsigned int)(~SEC_PULSE_SEL_INNER));
> +
> +	regmap_update_bits(info->rtc_map, ANA_CALIB,
> +			   (unsigned int)(~CALIB_SEL_FTUNE_MASK),
> +			   CALIB_SEL_FTUNE_INNER);
> +
> +	regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);

Don't disable alarms on probe.

> +}
> +
> +static int cv1800_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> +	unsigned int sec;
> +	unsigned int sec_ro_t;
> +	unsigned long flag;
> +
> +	spin_lock_irqsave(&info->rtc_lock, flag);
> +
> +	regmap_read(info->rtc_map, SEC_CNTR_VAL, &sec);
> +	regmap_read(info->rtc_map, MACRO_RO_T, &sec_ro_t);
> +
> +	if (sec_ro_t > (SET_SEC_CNTR_VAL_UPDATE)) {
> +		sec = sec_ro_t;
> +		regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
> +		regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);

What does this do?

> +	}
> +
> +	spin_unlock_irqrestore(&info->rtc_lock, flag);
> +
> +	rtc_time64_to_tm(sec, tm);
> +
> +	return 0;
> +}
> +
> +static int cv1800_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> +	unsigned long sec;
> +	int ret;
> +	unsigned long flag;
> +
> +	ret = rtc_valid_tm(tm);

This is useless, tm will always be valid

> +	if (ret)
> +		return ret;
> +
> +	sec = rtc_tm_to_time64(tm);
> +
> +	spin_lock_irqsave(&info->rtc_lock, flag);
> +
> +	regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
> +	regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);
> +
> +	regmap_write(info->rtc_map, MACRO_RG_SET_T, sec);
> +
> +	spin_unlock_irqrestore(&info->rtc_lock, flag);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t cv1800_rtc_irq_handler(int irq, void *dev_id)
> +{
> +	struct device *dev = dev_id;
> +	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> +	struct rtc_wkalrm alrm;
> +
> +	regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);
> +
> +	rtc_read_alarm(info->rtc_dev, &alrm);
> +	alrm.enabled = 0;
> +	rtc_set_alarm(info->rtc_dev, &alrm);

I don't get what you are doing here, you should call rtc_update_irq, not
mess with alarms that have been set.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct rtc_class_ops cv800b_rtc_ops = {
> +	.read_time = cv1800_rtc_read_time,
> +	.set_time = cv1800_rtc_set_time,
> +	.read_alarm = cv1800_rtc_read_alarm,
> +	.set_alarm = cv1800_rtc_set_alarm,
> +	.alarm_irq_enable = cv1800_rtc_alarm_irq_enable,
> +};
> +
> +static int cv1800_rtc_probe(struct platform_device *pdev)
> +{
> +	struct cv1800_rtc_priv *rtc;
> +	uint32_t ctrl_val;
> +	int ret;
> +
> +	rtc = devm_kzalloc(&pdev->dev, sizeof(struct cv1800_rtc_priv),
> +			   GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	rtc->dev = &pdev->dev;
> +
> +	rtc->rtc_map = syscon_node_to_regmap(rtc->dev->of_node->parent);
> +	if (IS_ERR(rtc->rtc_map))
> +		return PTR_ERR(rtc->rtc_map);
> +
> +	rtc->irq = platform_get_irq(pdev, 0);
> +	if (rtc->irq < 0)
> +		return rtc->irq;
> +
> +	ret = devm_request_irq(&pdev->dev, rtc->irq, cv1800_rtc_irq_handler,
> +			       IRQF_TRIGGER_HIGH, "alarm", &pdev->dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot register interrupt handler\n");
> +
> +	rtc->clk = devm_clk_get(rtc->dev, NULL);
> +	if (IS_ERR(rtc->clk))
> +		return PTR_ERR(rtc->clk);
> +

You are going to leak rtc->clk after the next call.

> +	rtc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(rtc->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->clk),
> +				     "clk not found\n");
> +
> +	platform_set_drvdata(pdev, rtc);
> +
> +	spin_lock_init(&rtc->rtc_lock);
> +
> +	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev,
> +								dev_name(&pdev->dev),
> +								&cv800b_rtc_ops,
> +								THIS_MODULE);
> +	if (IS_ERR(rtc->rtc_dev))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtc_dev),
> +				     "can't register rtc device\n");

Please use devm_rtc_allocate_device and devm_rtc_register_device

> +
> +	/* if use internal clk,so coarse calibrate rtc */
> +	regmap_read(rtc->rtc_map, CTRL, &ctrl_val);
> +	ctrl_val &= CTRL_MODE_MASK;
> +
> +	if (ctrl_val == CTRL_MODE_OSC32K) {
> +		ret = cv1800_rtc_32k_coarse_val_calib(rtc);
> +		if (ret)
> +			dev_err(&pdev->dev, "failed to coarse RTC val !\n");
> +
> +		ret = cv1800_rtc_32k_fine_val_calib(rtc);
> +		if (ret)
> +			dev_err(&pdev->dev, "failed to fine RTC val !\n");
> +	}
> +
> +	rtc_enable_sec_counter(rtc);

I'm pretty sure you don't want to do that on every probe.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id cv1800_dt_ids[] = {
> +	{ .compatible = "sophgo,cv1800b-rtc" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, cv1800_dt_ids);
> +
> +static struct platform_driver cv1800_rtc_driver = {
> +	.driver = {
> +			.name = "sophgo-cv800b-rtc",
> +			.of_match_table = cv1800_dt_ids,
> +		},
> +	.probe = cv1800_rtc_probe,
> +};
> +
> +module_platform_driver(cv1800_rtc_driver);
> +MODULE_AUTHOR("Jingbao Qiu");
> +MODULE_DESCRIPTION("Sophgo cv1800 RTC Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

