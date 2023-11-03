Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768FB7E04AA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377778AbjKCO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjKCO2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:28:31 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0743CD47;
        Fri,  3 Nov 2023 07:28:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E76D740005;
        Fri,  3 Nov 2023 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699021703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZzG3BUlf/liG07fvvmldSRD8z7LULgsollErwUz4HCc=;
        b=Zzgi+XE2Oy+Pf9Rjd0xlAXZT+9RNUOns6u/+9qU1H4/3q69F4gL0+1WKlT1XnmV5+8kDrY
        kWtYEedJeAuohNcKCVzEwjE7FB0IuUcowClFJkuODmIn7VVml3zggUdW6thF5XV3YdK+UJ
        ohiwLX4Wl+WjiaXC+PPZGL3i5wqhdAQUGfH+0utlAu+kdganZLHEH0bVutMo83irZK6Sog
        Os6/nEupyNpp/EQl+7W/vsWmz0lGfAdHUHKD6qh7O8zFhrDYE4NypY7nGg8Oy4+9YLjcJF
        VzjuPB0iJHroCjssRjibHvCwx1frc5SV4YAcGKA+2LBiSwc2CAWnx1iGVXI24w==
Date:   Fri, 3 Nov 2023 15:28:22 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Carlos Menin <menin@carlosaurelio.net>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sergio Prado <sergio.prado@e-labworks.com>
Subject: Re: [PATCH v2 1/2] rtc: add pcf85053a
Message-ID: <20231103142822abbca0ed@mail.local>
References: <20231103125106.78220-1-menin@carlosaurelio.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103125106.78220-1-menin@carlosaurelio.net>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Carlos,

On 03/11/2023 09:51:05-0300, Carlos Menin wrote:
> +struct pcf85053a {
> +	struct rtc_device	*rtc;
> +	struct regmap		*regmap;
> +	struct regmap		*regmap_nvmem;
> +};
> +
> +struct pcf85053a_config {
> +	struct regmap_config regmap;
> +	struct regmap_config regmap_nvmem;
> +};
> +
> +static int pcf85053a_read_offset(struct device *dev, long *offset)
> +{
> +	struct pcf85053a *pcf85053a = dev_get_drvdata(dev);
> +	long val;
> +	u32 reg_offset, reg_oscillator;
> +	int ret;
> +
> +	ret = regmap_read(pcf85053a->regmap, REG_OFFSET, &reg_offset);
> +	if (ret)
> +		return -EIO;

Why do you change the error returned by regmap?

> +
> +	ret = regmap_read(pcf85053a->regmap, REG_OSCILLATOR, &reg_oscillator);
> +	if (ret)
> +		return -EIO;
> +
> +	val = sign_extend32(reg_offset, 7);
> +
> +	if (reg_oscillator & REG_OSC_OFFM)
> +		*offset = val * OFFSET_STEP1;
> +	else
> +		*offset = val * OFFSET_STEP0;
> +
> +	return 0;
> +}
> +
> +static int pcf85053a_set_offset(struct device *dev, long offset)
> +{
> +	struct pcf85053a *pcf85053a = dev_get_drvdata(dev);
> +	s8 mode0, mode1, reg_offset;
> +	unsigned int ret, error0, error1;
> +
> +	if (offset > OFFSET_STEP0 * 127)
> +		return -ERANGE;
> +	if (offset < OFFSET_STEP0 * -128)
> +		return -ERANGE;
> +
> +	ret = regmap_set_bits(pcf85053a->regmap, REG_ACCESS, REG_ACCESS_XCLK);
> +	if (ret)
> +		return -EIO;
> +
> +	mode0 = DIV_ROUND_CLOSEST(offset, OFFSET_STEP0);
> +	mode1 = DIV_ROUND_CLOSEST(offset, OFFSET_STEP1);
> +
> +	error0 = abs(offset - (mode0 * OFFSET_STEP0));
> +	error1 = abs(offset - (mode1 * OFFSET_STEP1));
> +	if (error0 < error1) {
> +		reg_offset = mode0;
> +		ret = regmap_clear_bits(pcf85053a->regmap, REG_OSCILLATOR,
> +					REG_OSC_OFFM);
> +	} else {
> +		reg_offset = mode1;
> +		ret = regmap_set_bits(pcf85053a->regmap, REG_OSCILLATOR,
> +				      REG_OSC_OFFM);
> +	}
> +	if (ret)
> +		return -EIO;
> +
> +	ret = regmap_write(pcf85053a->regmap, REG_OFFSET, reg_offset);
> +
> +	return ret;
> +}
> +
> +static int pcf85053a_rtc_check_reliability(struct device *dev, u8 status_reg)
> +{
> +	int ret = 0;
> +
> +	if (status_reg & REG_STATUS_CIF) {
> +		dev_warn(dev, "tamper detected,"
> +			 " date/time is not reliable\n");
You should not split strings. Also, I don't think most of the messages
are actually useful as the end user doesn't have any specific action
after seeing it. You should probably drop them.

I don't think CIF means the time is not correct anymore.

> +		ret = -EINVAL;
> +	}
> +
> +	if (status_reg & REG_STATUS_OF) {
> +		dev_warn(dev, "oscillator fail detected,"
> +			 " date/time is not reliable.\n");
> +		ret = -EINVAL;
> +	}
> +
> +	if (status_reg & REG_STATUS_RTCF) {
> +		dev_warn(dev, "power loss detected,"
> +			 " date/time is not reliable.\n");
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int pcf85053a_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct pcf85053a *pcf85053a = dev_get_drvdata(dev);
> +	u8 buf[REG_STATUS + 1];
> +	int ret, len = sizeof(buf);
> +
> +	ret = regmap_bulk_read(pcf85053a->regmap, REG_SECS, buf, len);
> +	if (ret) {
> +		dev_err(dev, "%s: error %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = pcf85053a_rtc_check_reliability(dev, buf[REG_STATUS]);
> +	if (ret)
> +		return ret;
> +
> +	tm->tm_year = buf[REG_YEARS];
> +	/* adjust for 1900 base of rtc_time */
> +	tm->tm_year += 100;
> +
> +	tm->tm_wday = (buf[REG_WEEKDAYS] - 1) & 7; /* 1 - 7 */
> +	tm->tm_sec = buf[REG_SECS];
> +	tm->tm_min = buf[REG_MINUTES];
> +	tm->tm_hour = buf[REG_HOURS];
> +	tm->tm_mday = buf[REG_DAYS];
> +	tm->tm_mon = buf[REG_MONTHS] - 1; /* 1 - 12 */

Those comments are not useful.

> +
> +	return 0;
> +}
> +

> +static ssize_t attr_flag_clear(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count,
> +			       u8 reg, u8 flag)
> +{
> +	struct pcf85053a *pcf85053a = dev_get_drvdata(dev->parent);
> +	int ret;
> +
> +	(void)attr;
> +	(void)buf;
> +	(void)count;
> +
> +	ret = regmap_clear_bits(pcf85053a->regmap, reg, flag);
> +	if (ret)
> +		return -EIO;
> +
> +	return count;
> +}
> +
> +static ssize_t attr_flag_read(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf,
> +			      u8 reg, u8 flag)
> +{
> +	struct pcf85053a *pcf85053a = dev_get_drvdata(dev->parent);
> +	unsigned int status, val;
> +	int ret;
> +
> +	(void)attr;
> +	ret = regmap_read(pcf85053a->regmap, reg, &status);
> +	if (ret)
> +		return -EIO;
> +
> +	val = (status & flag) != 0;
> +
> +	return sprintf(buf, "%u\n", val);
> +}



> +
> +/* flags that can be read or written to be cleared */
> +#define PCF85053A_ATTR_FLAG_RWC(name, reg, flag)                                \
> +	static ssize_t name ## _store(                                         \
> +			struct device *dev,                                    \
> +			struct device_attribute *attr,                         \
> +			const char *buf,                                       \
> +			size_t count)                                          \
> +	{                                                                      \
> +		return attr_flag_clear(dev, attr, buf, count,                  \
> +				REG_ ## reg, REG_ ## reg ## _ ## flag);        \
> +	}                                                                      \
> +	static ssize_t name ## _show(                                          \
> +			struct device *dev,                                    \
> +			struct device_attribute *attr,                         \
> +			char *buf)                                             \
> +	{                                                                      \
> +		return attr_flag_read(dev, attr, buf,                          \
> +				REG_ ## reg, REG_ ## reg ## _ ## flag);        \
> +	}                                                                      \
> +	static DEVICE_ATTR_RW(name)
> +
> +PCF85053A_ATTR_FLAG_RWC(rtc_fail, STATUS, RTCF);
> +PCF85053A_ATTR_FLAG_RWC(oscillator_fail, STATUS, OF);
> +PCF85053A_ATTR_FLAG_RWC(rtc_clear, STATUS, CIF);
> +
> +static struct attribute *pcf85053a_attrs_flags[] = {
> +	&dev_attr_rtc_fail.attr,
> +	&dev_attr_oscillator_fail.attr,
> +	&dev_attr_rtc_clear.attr,
> +	0,
> +};

Don't add undocumented sysfs files. Also, You must not allow userspace
to clear those flags without setting the time properly.

> +static void pcf85053a_set_drive_control(struct device *dev, u8 *reg_ctrl)
> +{
> +	int ret;
> +	const char *val;
> +	u8 regval;
> +
> +	ret = of_property_read_string(dev->of_node, "nxp,quartz-drive-control",
> +				      &val);

This property should rather be "nxp,quartz-drive".

> +	if (ret) {
> +		dev_warn(dev, "failed to read nxp,quartz-drive-control property,"
> +			 " assuming 'normal' drive");
> +		val = "normal";
> +	}
> +
> +	if (!strcmp(val, "normal")) {
> +		regval = 0;
> +	} else if (!strcmp(val, "low")) {
> +		regval = 1;
> +	} else if (!strcmp(val, "high")) {
> +		regval = 2;
> +	} else {
> +		dev_warn(dev, "invalid nxp,quartz-drive-control value: %s,"
> +			 " assuming 'normal' drive", val);
> +		regval = 0;
> +	}
> +
> +	*reg_ctrl |= (regval << 2);

2 needs a define, what about using FIELD_PREP?

> +}
> +
> +static void pcf85053a_set_low_jitter(struct device *dev, u8 *reg_ctrl)
> +{
> +	bool val;
> +	u8 regval;
> +
> +	val = of_property_read_bool(dev->of_node, "nxp,low-jitter-mode");

Bool properties don't work well with RTC because with this, there is now
way to enable the normal mode.

> +
> +	regval = val ? 1 : 0;
> +	*reg_ctrl |= (regval << 4);
4 also needs a define

> +}
> +
> +static void pcf85053a_set_clk_inverted(struct device *dev, u8 *reg_ctrl)
> +{
> +	bool val;
> +	u8 regval;
> +
> +	val = of_property_read_bool(dev->of_node, "nxp,clk-inverted");
> +
> +	regval = val ? 1 : 0;
> +	*reg_ctrl |= (regval << 7);

Ditto
> +}
> +
> +static int pcf85053a_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	struct pcf85053a *pcf85053a;
> +	const struct pcf85053a_config *config = &pcf85053a_config;
> +	u8 reg_ctrl;
> +
> +	pcf85053a = devm_kzalloc(&client->dev, sizeof(*pcf85053a), GFP_KERNEL);
> +	if (!pcf85053a) {
> +		dev_err(&client->dev, "failed to allocate device: no memory");
> +		return -ENOMEM;
> +	}
> +
> +	pcf85053a->regmap = devm_regmap_init_i2c(client, &config->regmap);
> +	if (IS_ERR(pcf85053a->regmap)) {
> +		dev_err(&client->dev, "failed to allocate regmap: %ld\n",
> +			PTR_ERR(pcf85053a->regmap));
> +		return PTR_ERR(pcf85053a->regmap);
> +	}
> +
> +	i2c_set_clientdata(client, pcf85053a);
> +
> +	pcf85053a->rtc = devm_rtc_allocate_device(&client->dev);
> +	if (IS_ERR(pcf85053a->rtc)) {
> +		dev_err(&client->dev, "failed to allocate rtc: %ld\n",
> +			PTR_ERR(pcf85053a->rtc));
> +		return PTR_ERR(pcf85053a->rtc);
> +	}
> +
> +	pcf85053a->rtc->ops = &pcf85053a_rtc_ops;
> +	pcf85053a->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	pcf85053a->rtc->range_max = RTC_TIMESTAMP_END_2099;
> +
> +	reg_ctrl = REG_CTRL_DM | REG_CTRL_HF | REG_CTRL_CIE;

CIE enables an interrupt but you never use interrupts.

> +	pcf85053a_set_load_capacitance(&client->dev, &reg_ctrl);
> +	pcf85053a_set_drive_control(&client->dev, &reg_ctrl);
> +	pcf85053a_set_low_jitter(&client->dev, &reg_ctrl);
> +	pcf85053a_set_clk_inverted(&client->dev, &reg_ctrl);
> +
> +	ret = regmap_write(pcf85053a->regmap, REG_CTRL, reg_ctrl);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to configure rtc: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = rtc_add_group(pcf85053a->rtc, &pcf85053a_attr_group);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to add sysfs entry: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_rtc_register_device(pcf85053a->rtc);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to register rtc: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pcf85053a_add_nvmem(client, pcf85053a);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to register nvmem: %d\n", ret);
> +		return ret;

probe must not fail after devm_rtc_register_device

> +	}
> +
> +	ret = pcf85053a_hwmon_register(&client->dev, client->name);
> +	if (ret)
> +		dev_err(&client->dev, "failed to register hwmon: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static const __maybe_unused struct of_device_id dev_ids[] = {
> +	{ .compatible = "nxp,pcf85053a", .data = &pcf85053a_config },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, dev_ids);
> +
> +static struct i2c_driver pcf85053a_driver = {
> +	.driver = {
> +		.name = "pcf85053a",
> +		.of_match_table = of_match_ptr(dev_ids),
> +	},
> +	.probe_new = &pcf85053a_probe,
> +};
> +
> +module_i2c_driver(pcf85053a_driver);
> +
> +MODULE_AUTHOR("Carlos Menin <menin@carlosaurelio.net>");
> +MODULE_DESCRIPTION("PCF85053A I2C RTC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
