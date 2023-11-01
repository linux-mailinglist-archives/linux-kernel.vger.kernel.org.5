Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166DC7DE80C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345813AbjKAWXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjKAWXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:23:51 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00A411D;
        Wed,  1 Nov 2023 15:23:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB176E0003;
        Wed,  1 Nov 2023 22:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698877423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jggGNcvAtv9LxN7R6LMr0R964jtilEqQaxj50I5uJCg=;
        b=pDlo0FOJY3L9dpP1BPmOMKhLX7DRNq7i/rYZcSimLwRXA11gf1G5FoHgBBrHWblhYwaQKU
        t4i+DXCgpT02VcLii1qnacj9BPhztK6xsY1DxdqFExFVkxay88Zt9z/iyyLm9XJaoQFyAc
        uzEAo1Dx4rimQRoi2v+SnOTGsbsur2+xwcj++drgxHUTFSbQMCu8ksjKJwfEqUMjO3jxRE
        HmGk2+32EJ+QKxsZwYX4qgHuD0Msw3e7C24HbaBPyKpA8dLRuYyGAR9afFamRa4N7AEU+Z
        qOgshuLXpppzLanr0PcUbLmlPtzbXUfD2gk7qIR9sf21aH8jcDTII1pDeZbrNg==
Date:   Wed, 1 Nov 2023 23:23:42 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 2/2] rtc: max31335: add driver support
Message-ID: <202311012223422e3387b3@mail.local>
References: <20231101094835.51031-1-antoniu.miclaus@analog.com>
 <20231101094835.51031-2-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101094835.51031-2-antoniu.miclaus@analog.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2023 11:48:14+0200, Antoniu Miclaus wrote:
> +static int max31335_get_hour(u8 hour_reg)
> +{
> +	int hour;
> +
> +	/* 24Hr mode */
> +	if (!FIELD_GET(MAX31335_HOURS_F_24_12, hour_reg))
> +		return bcd2bin(hour_reg & 0x3f);
> +
> +	/* 12Hr mode */
> +	hour = bcd2bin(hour_reg & 0x1f);
> +	if (hour == 12)
> +		hour = 0;
> +

Do you really need to support 12h mode?

> +	if (FIELD_GET(MAX31335_HOURS_HR_20_AM_PM, hour_reg))
> +		hour += 12;
> +
> +	return hour;
> +}
> +
> +static int max31335_read_offset(struct device *dev, long *offset)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +	u32 value;
> +	int ret;
> +
> +	ret = regmap_read(max31335->regmap, MAX31335_AGING_OFFSET, &value);
> +	if (ret)
> +		return ret;
> +
> +	*offset = value;

This is super dubious, what is the unit of MAX31335_AGING_OFFSET ?

> +
> +	return 0;
> +}
> +
> +static int max31335_set_offset(struct device *dev, long offset)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +
> +	return regmap_write(max31335->regmap, MAX31335_AGING_OFFSET, offset);
> +}
> +
> +static int max31335_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +	struct mutex *lock = &max31335->rtc->ops_lock;
> +	int ret, ctrl, status;
> +	struct rtc_time time;
> +	u8 regs[6];
> +
> +	mutex_lock(lock);

Use rtc_lock(), I'm not quite sure why you would need locking here
though.

> +
> +	ret = regmap_bulk_read(max31335->regmap, MAX31335_ALM1_SEC, regs,
> +			       sizeof(regs));
> +	if (ret)
> +		goto exit;
> +
> +	alrm->time.tm_sec  = bcd2bin(regs[0] & 0x7f);
> +	alrm->time.tm_min  = bcd2bin(regs[1] & 0x7f);
> +	alrm->time.tm_hour = bcd2bin(regs[2] & 0x3f);
> +	alrm->time.tm_mday = bcd2bin(regs[3] & 0x3f);
> +	alrm->time.tm_mon  = bcd2bin(regs[4] & 0x1f) - 1;
> +	alrm->time.tm_year = bcd2bin(regs[5]) + 100;
> +
> +	ret = max31335_read_time(dev, &time);
> +	if (ret)
> +		goto exit;
> +
> +	if (time.tm_year >= 200)
> +		alrm->time.tm_year += 100;
> +
> +	ret = regmap_read(max31335->regmap, MAX31335_INT_EN1, &ctrl);
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_read(max31335->regmap, MAX31335_STATUS1, &status);
> +	if (ret)
> +		goto exit;
> +
> +	alrm->enabled = FIELD_GET(MAX31335_INT_EN1_A1IE, ctrl);
> +	alrm->pending = FIELD_GET(MAX31335_STATUS1_A1F, status);
> +
> +exit:
> +	mutex_unlock(lock);
> +
> +	return ret;
> +}
> +
> +static int max31335_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +	struct mutex *lock = &max31335->rtc->ops_lock;
> +	unsigned int reg;
> +	u8 regs[6];
> +	int ret;
> +
> +	regs[0] = bin2bcd(alrm->time.tm_sec);
> +	regs[1] = bin2bcd(alrm->time.tm_min);
> +	regs[2] = bin2bcd(alrm->time.tm_hour);
> +	regs[3] = bin2bcd(alrm->time.tm_mday);
> +	regs[4] = bin2bcd(alrm->time.tm_mon + 1);
> +	regs[5] = bin2bcd(alrm->time.tm_year % 100);
> +
> +	mutex_lock(lock);

I'm not sure why you need locking here either, maybe you should simply
disable the alarm first?

> +
> +	ret = regmap_bulk_write(max31335->regmap, MAX31335_ALM1_SEC,
> +				regs, sizeof(regs));
> +	if (ret)
> +		goto exit;
> +
> +	reg = FIELD_PREP(MAX31335_INT_EN1_A1IE, alrm->enabled);
> +	ret = regmap_update_bits(max31335->regmap, MAX31335_INT_EN1,
> +				 MAX31335_INT_EN1_A1IE, reg);
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_update_bits(max31335->regmap, MAX31335_STATUS1,
> +				 MAX31335_STATUS1_A1F, 0);
> +
> +exit:
> +	mutex_unlock(lock);
> +
> +	return ret;
> +}
> +
> +static int max31335_alarm_irq_enable(struct device *dev, unsigned int enabled)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +
> +	return regmap_update_bits(max31335->regmap, MAX31335_INT_EN1,
> +				  MAX31335_INT_EN1_A1IE, enabled);
> +}
> +


> +static int max31335_trickle_charger_setup(struct device *dev,
> +					  struct max31335_data *max31335)
> +{
> +	u32 ohms, chargeable;
> +	bool diode = false;
> +	int i;
> +
> +	if (device_property_read_u32(dev, "trickle-resistor-ohms", &ohms))
> +		return 0;
> +
> +	if (!device_property_read_u32(dev, "aux-voltage-chargeable",
> +				      &chargeable)) {
> +		switch (chargeable) {
> +		case 0:
> +			diode = false;
> +			break;
> +		case 1:
> +			diode = true;
> +			break;
> +		default:
> +			dev_warn(dev,
> +				 "unsupported aux-voltage-chargeable value\n");

I don't think the string is necessary, checking the DT should be done at
compile time.

> +			break;
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(max31335_trickle_resistors); i++)
> +		if (ohms == max31335_trickle_resistors[i])
> +			break;
> +
> +	if (i >= ARRAY_SIZE(max31335_trickle_resistors)) {
> +		dev_warn(dev, "invalid trickle resistor value\n");

Ditto.

> +
> +		return 0;
> +	}
> +
> +	if (diode)
> +		i = i + 4;
> +	else
> +		i = i + 1;

Do you actually need to configure the trickle charger when there is
nothing to charge?

> +
> +	return regmap_write(max31335->regmap, MAX31335_TRICKLE_REG,
> +			    FIELD_PREP(MAX31335_TRICKLE_REG_TRICKLE, i) |
> +				       MAX31335_TRICKLE_REG_EN_TRICKLE);
> +}
> +
> +static int max31335_clkout_register(struct device *dev)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!device_property_present(dev, "#clock-cells"))
> +		return 0;

Is the clock output disabled by default?

> +
> +static int max31335_probe(struct i2c_client *client)
> +{
> +	struct max31335_data *max31335;
> +	struct device *hwmon;
> +	int ret;
> +
> +	max31335 = devm_kzalloc(&client->dev, sizeof(*max31335), GFP_KERNEL);
> +	if (!max31335)
> +		return -ENOMEM;
> +
> +	max31335->regmap = devm_regmap_init_i2c(client, &regmap_config);
> +	if (IS_ERR(max31335->regmap))
> +		return PTR_ERR(max31335->regmap);
> +
> +	i2c_set_clientdata(client, max31335);
> +
> +	ret = regmap_write(max31335->regmap, MAX31335_RTC_RESET, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(max31335->regmap, MAX31335_RTC_RESET, 0);
> +	if (ret)
> +		return ret;

What does this register do?

> +
> +	max31335->rtc = devm_rtc_allocate_device(&client->dev);
> +	if (IS_ERR(max31335->rtc))
> +		return PTR_ERR(max31335->rtc);
> +
> +	max31335->rtc->ops = &max31335_rtc_ops;
> +	max31335->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	max31335->rtc->range_max = RTC_TIMESTAMP_END_2199;

Please set alarm_offset_max too.

> +
> +	ret = devm_rtc_register_device(max31335->rtc);
> +	if (ret)
> +		return ret;
> +
> +	ret = max31335_clkout_register(&client->dev);
> +	if (ret)
> +		return ret;
> +
> +	if (client->irq > 0) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, max31335_handle_irq,
> +						IRQF_ONESHOT,
> +						"max31335", max31335);
> +		if (ret) {
> +			dev_warn(&client->dev,
> +				 "unable to request IRQ, alarm max31335 disabled\n");
> +			client->irq = 0;
> +		}
> +	}
> +
> +	if (!client->irq)
> +		clear_bit(RTC_FEATURE_ALARM, max31335->rtc->features);
> +
> +	max31335_nvmem_cfg.priv = max31335;
> +	ret = devm_rtc_nvmem_register(max31335->rtc, &max31335_nvmem_cfg);
> +	if (ret)
> +		dev_err_probe(&client->dev, ret, "cannot register rtc nvmem\n");
> +
> +	hwmon = devm_hwmon_device_register_with_info(&client->dev, client->name,
> +						     max31335,
> +						     &max31335_chip_info,
> +						     NULL);
> +	if (IS_ERR(hwmon))
> +		dev_err_probe(&client->dev, PTR_ERR(hwmon),
> +			      "cannot register hwmon device\n");
> +
> +	return max31335_trickle_charger_setup(&client->dev, max31335);

You must never fail probe after calling devm_rtc_register_device, else
you are open to a race condition with userspace.

> +}
> +
> +static const struct i2c_device_id max31335_id[] = {
> +	{ "max31335", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, max31335_id);
> +
> +static const struct of_device_id max31335_of_match[] = {
> +	{ .compatible = "adi,max31335" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, max31335_of_match);
> +
> +static struct i2c_driver max31335_driver = {
> +	.driver = {
> +		.name = "rtc-max31335",
> +		.of_match_table = max31335_of_match,
> +	},
> +	.probe = max31335_probe,
> +	.id_table = max31335_id,
> +};
> +module_i2c_driver(max31335_driver);
> +
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("MAX31335 RTC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.42.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
