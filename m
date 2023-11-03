Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B97E0B5D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjKCWxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjKCWxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:53:39 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD31A8;
        Fri,  3 Nov 2023 15:53:34 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BD3D240005;
        Fri,  3 Nov 2023 22:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699052012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3A19yBNhWvDVog5YRP5PI3s4O5IQVxdjGWVhDoOmjjg=;
        b=OxndNLBKn3DvQcbrS7mPO2gAdKwpjVcbR/cxzk0Y8aTo0kmWhelkWpErwjbKXB58VChCRK
        5lMohUJ8m+oNnX739JqjTIHMaubhaKD+3Rd3vJKVzU88NW9SqksPG9pXGtr6Bw75++HZ06
        I0XkOe5IOh1oOjdoGwxo+lunehJDzhlvGK6JDL18BGcyyuYr2t1SkmZavEf9Qgx/OBN39l
        oVZxW52DRjca09stkrSgRhiUYlSiAEJqQFIb5/8xS55BwTEZuHNxb5L+h5G7mzR2f3sPtE
        sFWF/459EHb+SMTU5YVJfDE+fAuB4xsenktUL15BE+yADdHCRXd8pdWxARo+YA==
Date:   Fri, 3 Nov 2023 23:53:31 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, kernel@axis.com,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rtc: Add driver for Epson RX8111
Message-ID: <20231103225331f0fee24a@mail.local>
References: <cover.1692699931.git.waqar.hameed@axis.com>
 <7b856b74c4c0f8c6c539d7c692051c9203b103c0.1692699931.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b856b74c4c0f8c6c539d7c692051c9203b103c0.1692699931.git.waqar.hameed@axis.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm sorry for the very late review...

On 22/08/2023 12:25:31+0200, Waqar Hameed wrote:
> +#include <linux/bcd.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/rtc.h>
> +
> +#define RX8111_DRV_NAME "rtc-rx8111"

This define is not necessary

> +
> +#define RX8111_REG_SEC			0x10	/* Second counter. */
> +#define RX8111_REG_MIN			0x11	/* Minute counter */
> +#define RX8111_REG_HOUR			0x12	/* Hour counter. */
> +#define RX8111_REG_WEEK			0x13	/* Week day counter. */
> +#define RX8111_REG_DAY			0x14	/* Month day counter. */
> +#define RX8111_REG_MONTH		0x15	/* Month counter. */
> +#define RX8111_REG_YEAR			0x16	/* Year counter. */
> +
> +#define RX8111_REG_ALARM_MIN		0x17	/* Alarm minute. */
> +#define RX8111_REG_ALARM_HOUR		0x18	/* Alarm hour. */
> +#define RX8111_REG_ALARM_WEEK_DAY	0x19	/* Alarm week or month day. */
> +
> +#define RX8111_REG_TIMER_COUNTER0	0x1a	/* Timer counter LSB. */
> +#define RX8111_REG_TIMER_COUNTER1	0x1b	/* Timer counter. */
> +#define RX8111_REG_TIMER_COUNTER2	0x1c	/* Timer counter MSB. */
> +
> +#define RX8111_REG_EXT			0x1d	/* Extension register. */
> +#define RX8111_REG_FLAG			0x1e	/* Flag register. */
> +#define RX8111_REG_CTRL			0x1f	/* Control register. */
> +
> +#define RX8111_REG_TS_1_1000_SEC	0x20	/* Timestamp 256 or 512 Hz . */
> +#define RX8111_REG_TS_1_100_SEC		0x21	/* Timestamp 1 - 128 Hz. */
> +#define RX8111_REG_TS_SEC		0x22	/* Timestamp second. */
> +#define RX8111_REG_TS_MIN		0x23	/* Timestamp minute. */
> +#define RX8111_REG_TS_HOUR		0x24	/* Timestamp hour. */
> +#define RX8111_REG_TS_WEEK		0x25	/* Timestamp week day. */
> +#define RX8111_REG_TS_DAY		0x26	/* Timestamp month day. */
> +#define RX8111_REG_TS_MONTH		0x27	/* Timestamp month. */
> +#define RX8111_REG_TS_YEAR		0x28	/* Timestamp year. */
> +#define RX8111_REG_TS_STATUS		0x29	/* Timestamp status. */
> +
> +#define RX8111_REG_EVIN_SETTING		0x2b	/* Timestamp trigger setting. */
> +#define RX8111_REG_ALARM_SEC		0x2c	/* Alarm second. */
> +#define RX8111_REG_TIMER_CTRL		0x2d	/* Timer control. */
> +#define RX8111_REG_TS_CTRL0		0x2e	/* Timestamp control 0. */
> +#define RX8111_REG_CMD_TRIGGER		0x2f	/* Timestamp trigger. */
> +#define RX8111_REG_PWR_SWITCH_CTRL	0x32	/* Power switch control. */
> +#define RX8111_REG_STATUS_MON		0x33	/* Status monitor. */
> +#define RX8111_REG_TS_CTRL1		0x34	/* Timestamp control 1. */
> +#define RX8111_REG_TS_CTRL2		0x35	/* Timestamp control 2. */
> +#define RX8111_REG_TS_CTRL3		0x36	/* Timestamp control 3. */
> +
> +#define RX8111_TIME_BUF_SZ (RX8111_REG_YEAR - RX8111_REG_SEC + 1)
> +#define RX8111_TIME_BUF_IDX(reg)                                               \
> +	({                                                                     \
> +		BUILD_BUG_ON_MSG(reg < RX8111_REG_SEC || reg > RX8111_REG_YEAR,\
> +				 "Invalid reg value");                         \
> +		(reg - RX8111_REG_SEC);                                        \
> +	})

I don't feel like this is improving the legibility of the code. Also,
the BUILD_BUG_ON_MSG is never going to happen and doesn't protect
against a frequent issue.

> +
> +enum rx8111_regfield {
> +	/* RX8111_REG_EXT. */
> +	RX8111_REGF_TSEL0,
> +	RX8111_REGF_TSEL1,
> +	RX8111_REGF_ETS,
> +	RX8111_REGF_WADA,
> +	RX8111_REGF_TE,
> +	RX8111_REGF_USEL,
> +	RX8111_REGF_FSEL0,
> +	RX8111_REGF_FSEL1,
> +
> +	/* RX8111_REG_FLAG. */
> +	RX8111_REGF_XST,
> +	RX8111_REGF_VLF,
> +	RX8111_REGF_EVF,
> +	RX8111_REGF_AF,
> +	RX8111_REGF_TF,
> +	RX8111_REGF_UF,
> +	RX8111_REGF_POR,
> +
> +	/* RX8111_REG_CTRL. */
> +	RX8111_REGF_STOP,
> +	RX8111_REGF_EIE,
> +	RX8111_REGF_AIE,
> +	RX8111_REGF_TIE,
> +	RX8111_REGF_UIE,
> +
> +	/* RX8111_REG_PWR_SWITCH_CTRL. */
> +	RX8111_REGF_SMPT0,
> +	RX8111_REGF_SMPT1,
> +	RX8111_REGF_SWSEL0,
> +	RX8111_REGF_SWSEL1,
> +	RX8111_REGF_INIEN,
> +	RX8111_REGF_CHGEN,
> +
> +	/* Sentinel value. */
> +	RX8111_REGF_MAX
> +};
> +
> +static const struct reg_field rx8111_regfields[] = {
> +	[RX8111_REGF_TSEL0] = REG_FIELD(RX8111_REG_EXT, 0, 0),
> +	[RX8111_REGF_TSEL1] = REG_FIELD(RX8111_REG_EXT, 1, 1),
> +	[RX8111_REGF_ETS]   = REG_FIELD(RX8111_REG_EXT, 2, 2),
> +	[RX8111_REGF_WADA]  = REG_FIELD(RX8111_REG_EXT, 3, 3),
> +	[RX8111_REGF_TE]    = REG_FIELD(RX8111_REG_EXT, 4, 4),
> +	[RX8111_REGF_USEL]  = REG_FIELD(RX8111_REG_EXT, 5, 5),
> +	[RX8111_REGF_FSEL0] = REG_FIELD(RX8111_REG_EXT, 6, 6),
> +	[RX8111_REGF_FSEL1] = REG_FIELD(RX8111_REG_EXT, 7, 7),
> +
> +	[RX8111_REGF_XST] = REG_FIELD(RX8111_REG_FLAG, 0, 0),
> +	[RX8111_REGF_VLF] = REG_FIELD(RX8111_REG_FLAG, 1, 1),
> +	[RX8111_REGF_EVF] = REG_FIELD(RX8111_REG_FLAG, 2, 2),
> +	[RX8111_REGF_AF]  = REG_FIELD(RX8111_REG_FLAG, 3, 3),
> +	[RX8111_REGF_TF]  = REG_FIELD(RX8111_REG_FLAG, 4, 4),
> +	[RX8111_REGF_UF]  = REG_FIELD(RX8111_REG_FLAG, 5, 5),
> +	[RX8111_REGF_POR] = REG_FIELD(RX8111_REG_FLAG, 7, 7),
> +
> +	[RX8111_REGF_STOP] = REG_FIELD(RX8111_REG_CTRL, 0, 0),
> +	[RX8111_REGF_EIE]  = REG_FIELD(RX8111_REG_CTRL, 2, 2),
> +	[RX8111_REGF_AIE]  = REG_FIELD(RX8111_REG_CTRL, 3, 3),
> +	[RX8111_REGF_TIE]  = REG_FIELD(RX8111_REG_CTRL, 4, 4),
> +	[RX8111_REGF_UIE]  = REG_FIELD(RX8111_REG_CTRL, 5, 5),
> +
> +	[RX8111_REGF_SMPT0]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 0, 0),
> +	[RX8111_REGF_SMPT1]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 1, 1),
> +	[RX8111_REGF_SWSEL0] = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 2, 2),
> +	[RX8111_REGF_SWSEL1] = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 3, 3),
> +	[RX8111_REGF_INIEN]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 6, 6),
> +	[RX8111_REGF_CHGEN]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 7, 7),
> +};

I'm not quite sure using reg_field is actually an improvement. I don't
have anything against it either, unless it adds bus reads/writes when
reading or setting the time.

> +
> +static const struct regmap_config rx8111_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = RX8111_REG_TS_CTRL3,
> +};
> +
> +struct rx8111_data {
> +	struct regmap *regmap;
> +	struct regmap_field *regfields[RX8111_REGF_MAX];
> +	struct device *dev;
> +	struct rtc_device *rtc;
> +};
> +
> +static int rx8111_setup(struct rx8111_data *data)
> +{
> +	int ret;
> +
> +	/* Disable extended functionality (timer, events, timestamps etc.). */
> +	ret = regmap_write(data->regmap, RX8111_REG_EXT, 0);

This will lead to issues later on, you should leave the default values.

> +	if (ret) {
> +		dev_err(data->dev,
> +			"Could not disable extended functionality (%d)\n", ret);

You should cut down on the number of message, this would be a bus error
and the user has no actual action after seeing the message.

> +		return ret;
> +	}
> +
> +	/* Disable all interrupts. */
> +	ret = regmap_write(data->regmap, RX8111_REG_CTRL, 0);

This will also lead to issues later on when adding alarm support.

> +	if (ret) {
> +		dev_err(data->dev, "Could not disable interrupts (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rx8111_read_vl_flag(struct rx8111_data *data, unsigned int *vlval)
> +{
> +	int ret;
> +
> +	ret = regmap_field_read(data->regfields[RX8111_REGF_VLF], vlval);
> +	if (ret)
> +		dev_err(data->dev, "Could not read VL flag (%d)", ret);
> +
> +	return ret;
> +}
> +
> +static int rx8111_clear_vl_flag(struct rx8111_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_field_write(data->regfields[RX8111_REGF_VLF], 0);
> +	if (ret)
> +		dev_err(data->dev, "Could not write VL flag (%d)", ret);
> +
> +	return ret;
> +}
> +
> +static int rx8111_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rx8111_data *data = dev_get_drvdata(dev);
> +	u8 buf[RX8111_TIME_BUF_SZ];
> +	unsigned int regval;
> +	int ret;
> +
> +	/* Check status. */
> +	ret = rx8111_read_vl_flag(data, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (regval) {
> +		dev_warn(data->dev,
> +			 "Low voltage detected, time is not reliable\n");
> +		return -EINVAL;
> +	}
> +

Should you check XST too? And with this, using reg_field is worse.

> +	ret = regmap_field_read(data->regfields[RX8111_REGF_STOP], &regval);
> +	if (ret) {
> +		dev_err(data->dev, "Could not read clock status (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	if (regval) {
> +		dev_warn(data->dev, "Clock stopped, time is not reliable\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Read time. */
> +	ret = regmap_bulk_read(data->regmap, RX8111_REG_SEC, buf,
> +			       ARRAY_SIZE(buf));
> +	if (ret) {
> +		dev_err(data->dev, "Could not bulk read time (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	tm->tm_sec = bcd2bin(buf[RX8111_TIME_BUF_IDX(RX8111_REG_SEC)]);
> +	tm->tm_min = bcd2bin(buf[RX8111_TIME_BUF_IDX(RX8111_REG_MIN)]);
> +	tm->tm_hour = bcd2bin(buf[RX8111_TIME_BUF_IDX(RX8111_REG_HOUR)]);
> +	tm->tm_mday = bcd2bin(buf[RX8111_TIME_BUF_IDX(RX8111_REG_DAY)]);
> +
> +	/* Our month range is [1, 12] and tm_mon has [0, 11]. */
> +	tm->tm_mon = bcd2bin(buf[RX8111_TIME_BUF_IDX(RX8111_REG_MONTH)]) - 1;
> +
> +	/*
> +	 * We begin at year 2000 (c.f. rtc->range_min) and tm_year starts at
> +	 * year 1900.
> +	 */

Theses comments are not super useful because most of the RTC drivers are
behaving this way and it is quite obvious why this is the case.

> +	tm->tm_year = bcd2bin(buf[RX8111_TIME_BUF_IDX(RX8111_REG_YEAR)]) + 100;
> +
> +	/* A single bit specifies the week day [0, 6]. Note that ffs(1) = 1. */
> +	tm->tm_wday = ffs(buf[RX8111_TIME_BUF_IDX(RX8111_REG_WEEK)]) - 1;
> +
> +	return 0;
> +}
> +
> +static int rx8111_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rx8111_data *data = dev_get_drvdata(dev);
> +	u8 buf[RX8111_TIME_BUF_SZ];
> +	int ret;
> +
> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_SEC)] = bin2bcd(tm->tm_sec);
> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_MIN)] = bin2bcd(tm->tm_min);
> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_HOUR)] = bin2bcd(tm->tm_hour);
> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_DAY)] = bin2bcd(tm->tm_mday);
> +
> +	/* Our month range is [1, 12] and tm_mon has [0, 11]. */
> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_MONTH)] = bin2bcd(tm->tm_mon + 1);
> +
> +	/*
> +	 * We begin at year 2000 (c.f. rtc->range_min) and tm_year starts at
> +	 * year 1900.
> +	 */
> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_YEAR)] = bin2bcd(tm->tm_year - 100);
> +
> +	/* A single bit specifies the week day [0, 6].*/
> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_WEEK)] = BIT(tm->tm_wday);
> +
> +	ret = rx8111_clear_vl_flag(data);
> +	if (ret)
> +		return ret;A
> +
> +	/* Stop the clock. */
> +	ret = regmap_field_write(data->regfields[RX8111_REGF_STOP], 1);
> +	if (ret) {
> +		dev_err(data->dev, "Could not stop the clock (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	/* Set the time. */
> +	ret = regmap_bulk_write(data->regmap, RX8111_REG_SEC, buf,
> +				ARRAY_SIZE(buf));
> +	if (ret) {
> +		dev_err(data->dev, "Could not bulk write time (%d)\n", ret);
> +
> +		/*
> +		 * We don't bother with trying to start the clock again. We
> +		 * check for this in rx8111_read_time() (and thus force user to
> +		 * call rx8111_set_time() to try again).
> +		 */
> +		return ret;
> +	}
> +
> +	/* Start the clock. */
> +	ret = regmap_field_write(data->regfields[RX8111_REGF_STOP], 0);
> +	if (ret) {
> +		dev_err(data->dev, "Could not start the clock (%d)\n", ret);
> +		return ret;
> +	}
> +

You definitively need to handle XST here too.

> +	return 0;
> +}
> +
> +static int rx8111_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
> +{
> +	struct rx8111_data *data = dev_get_drvdata(dev);
> +	unsigned int regval;
> +	unsigned long vlval;
> +	int ret;
> +
> +	switch (cmd) {
> +	case RTC_VL_READ:
> +		ret = rx8111_read_vl_flag(data, &regval);
> +		if (ret)
> +			return ret;
> +
> +		vlval = regval ? RTC_VL_DATA_INVALID : 0;
> +
> +		return put_user(vlval, (unsigned long __user *)arg);
> +	case RTC_VL_CLR:
> +		return rx8111_clear_vl_flag(data);

Do not allow userspace to clear VLF without setting the time.

> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
> +
> +static const struct rtc_class_ops rx8111_rtc_ops = {
> +	.read_time = rx8111_read_time,
> +	.set_time = rx8111_set_time,
> +	.ioctl = rx8111_ioctl,
> +};
> +
> +static int rx8111_probe(struct i2c_client *client)
> +{
> +	struct rx8111_data *data;
> +	struct rtc_device *rtc;
> +	size_t i;
> +	int ret;
> +
> +	data = devm_kmalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return dev_err_probe(&client->dev, -ENOMEM,
> +				     "Could not allocate device data\n");

Please, less strings in probe or at least, use dev_dbg.

> +
> +	data->dev = &client->dev;
> +	dev_set_drvdata(data->dev, data);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &rx8111_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(data->dev, PTR_ERR(data->regmap),
> +				     "Could not initialize regmap\n");
> +
> +	for (i = 0; i < RX8111_REGF_MAX; ++i) {
> +		data->regfields[i] = devm_regmap_field_alloc(
> +			data->dev, data->regmap, rx8111_regfields[i]);
> +		if (IS_ERR(data->regfields[i]))
> +			return dev_err_probe(
> +				data->dev, PTR_ERR(data->regfields[i]),
> +				"Could not allocate register field %zu\n", i);
> +	}
> +
> +	ret = rx8111_setup(data);
> +	if (ret)
> +		return ret;
> +
> +	rtc = devm_rtc_allocate_device(data->dev);
> +	if (IS_ERR(rtc))
> +		return dev_err_probe(data->dev, PTR_ERR(rtc),
> +				     "Could not allocate rtc device\n");
> +
> +	rtc->ops = &rx8111_rtc_ops;
> +	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	rtc->range_max = RTC_TIMESTAMP_END_2099;
> +
> +	clear_bit(RTC_FEATURE_ALARM, rtc->features);
> +
> +	ret = devm_rtc_register_device(rtc);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Could not register rtc device (%d)\n",
> +				     ret);

devm_rtc_register_device already has messages in all the error path,
simply return here.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rx8111_of_match[] = {
> +	{
> +		.compatible = "epson,rx8111",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rx8111_of_match);
> +
> +static struct i2c_driver rx8111_driver = {
> +	.driver = {
> +		.name = RX8111_DRV_NAME,
> +		.of_match_table = rx8111_of_match,
> +	},
> +	.probe = rx8111_probe,
> +};
> +module_i2c_driver(rx8111_driver);
> +
> +MODULE_AUTHOR("Waqar Hameed <waqar.hameed@axis.com>");
> +MODULE_DESCRIPTION("Epson RX8111 RTC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.30.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
