Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE167750B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjHICKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHICKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:10:31 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAF6F3;
        Tue,  8 Aug 2023 19:10:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF770C0003;
        Wed,  9 Aug 2023 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691547027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8vVo7zn3MZSh5a87fGh8ut7jxQkEvXrzgB1bEJiFLQ=;
        b=fKoDkMbEfUw6jzI6773/0Ik3PxD20GaySU5b2i2dZRAHdLDboyq1MXHTaZBDokI8BzRhz0
        9QVK3/GlC72fhybxKh1Ngut5pC9jlqcNSnPDJuJi8RsUOLAvcXZDLbGPpbHhpb8/kh9bnV
        5U6YiTFXtPOKvMJCgWK52Ql6t1v6YOmevhsSGTLpuOp7CaaCexQEFCeAFQ4EXc31+PhN8p
        pdpPz/PfoVqztZ2VG9qkXp7ExAjHYu3hUSUbzJHdxYQoFxJeFY4UmoWA7FZNQFUKhSjCb1
        WzsGAp+rrlcgtyEBKOeyaPflaX6Q5BLRM7F5FaKA0fDI9BSf+4tzJhvp8TpZ6A==
Date:   Wed, 9 Aug 2023 04:10:25 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [RESEND PATCH v2 3/3] rtc: Add driver for Nuvoton ma35d1 rtc
 controller
Message-ID: <20230809021025a7c0daec@mail.local>
References: <20230809011542.429945-1-ychuang570808@gmail.com>
 <20230809011542.429945-4-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809011542.429945-4-ychuang570808@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 09/08/2023 01:15:42+0000, Jacky Huang wrote:
> +
> +struct ma35_bcd_time {
> +	int bcd_sec;
> +	int bcd_min;
> +	int bcd_hour;
> +	int bcd_mday;
> +	int bcd_mon;
> +	int bcd_year;
> +};

I don't get why this struct is useful.

> +
> +static irqreturn_t ma35d1_rtc_interrupt(int irq, void *data)
> +{
> +	struct ma35_rtc *rtc = (struct ma35_rtc *)data;
> +	unsigned long events = 0, rtc_irq;
> +
> +	rtc_irq = rtc_reg_read(rtc, MA35_REG_RTC_INTSTS);
> +
> +	if (rtc_irq & RTC_INTSTS_ALMIF) {
> +		rtc_reg_write(rtc, MA35_REG_RTC_INTSTS, RTC_INTSTS_ALMIF);
> +		events |= RTC_AF | RTC_IRQF;
> +	}
> +
> +	if (rtc_irq & RTC_INTSTS_TICKIF) {
> +		rtc_reg_write(rtc, MA35_REG_RTC_INTSTS, RTC_INTSTS_TICKIF);
> +		events |= RTC_UF | RTC_IRQF;

How did you test this path?

> +	}
> +
> +	rtc_update_irq(rtc->rtcdev, 1, events);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ma35d1_rtc_init(struct ma35_rtc *rtc, u32 ms_timeout)
> +{
> +	const unsigned long timeout = jiffies + msecs_to_jiffies(ms_timeout);
> +
> +	do {
> +		if (rtc_reg_read(rtc, MA35_REG_RTC_INIT) & RTC_INIT_ACTIVE)
> +			return 0;
> +
> +		rtc_reg_write(rtc, MA35_REG_RTC_INIT, RTC_INIT_MAGIC_CODE);
> +
> +		mdelay(1);
> +
> +	} while (time_before(jiffies, timeout));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int ma35d1_rtc_bcd2bin(u32 time, u32 cal, u32 wday, struct rtc_time *tm)
> +{
> +	tm->tm_mday	= bcd2bin(cal >> 0);
> +	tm->tm_mon	= bcd2bin(cal >> 8);
> +	tm->tm_mon	= tm->tm_mon - 1;
> +	tm->tm_year	= bcd2bin(cal >> 16) + 100;
> +
> +	tm->tm_sec	= bcd2bin(time >> 0);
> +	tm->tm_min	= bcd2bin(time >> 8);
> +	tm->tm_hour	= bcd2bin(time >> 16);
> +
> +	tm->tm_wday = wday;
> +
> +	return rtc_valid_tm(tm);
> +}
> +
> +static int ma35d1_rtc_alarm_bcd2bin(u32 talm, u32 calm, struct rtc_time *tm)
> +{
> +	tm->tm_mday	= bcd2bin(calm >> 0);
> +	tm->tm_mon	= bcd2bin(calm >> 8);
> +	tm->tm_mon	= tm->tm_mon - 1;
> +	tm->tm_year	= bcd2bin(calm >> 16) + 100;
> +
> +	tm->tm_sec	= bcd2bin(talm >> 0);
> +	tm->tm_min	= bcd2bin(talm >> 8);
> +	tm->tm_hour	= bcd2bin(talm >> 16);
> +
> +	return rtc_valid_tm(tm);
> +}
> +
> +static void ma35d1_rtc_bin2bcd(struct device *dev, struct rtc_time *settm,
> +			       struct ma35_bcd_time *gettm)
> +{
> +	gettm->bcd_mday = bin2bcd(settm->tm_mday) << 0;
> +	gettm->bcd_mon  = bin2bcd((settm->tm_mon + 1)) << 8;
> +
> +	if (settm->tm_year < 100) {
> +		dev_warn(dev, "The year will be between 1970-1999, right?\n");

No, don't do that, properly set the rtc hardware range and let the user
choose their time offset/window.

> +		gettm->bcd_year = bin2bcd(settm->tm_year) << 16;
> +	} else {
> +		gettm->bcd_year = bin2bcd(settm->tm_year - 100) << 16;
> +	}
> +
> +	gettm->bcd_sec  = bin2bcd(settm->tm_sec) << 0;
> +	gettm->bcd_min  = bin2bcd(settm->tm_min) << 8;
> +	gettm->bcd_hour = bin2bcd(settm->tm_hour) << 16;
> +}

Those functions are only used once, simply put them in their call site.

> +
> +static int ma35d1_alarm_irq_enable(struct device *dev, u32 enabled)
> +{
> +	struct ma35_rtc *rtc = dev_get_drvdata(dev);
> +	u32 reg_ien;
> +
> +	reg_ien = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
> +
> +	if (enabled)
> +		rtc_reg_write(rtc, MA35_REG_RTC_INTEN, reg_ien | RTC_INTEN_ALMIEN);
> +	else
> +		rtc_reg_write(rtc, MA35_REG_RTC_INTEN, reg_ien & ~RTC_INTEN_ALMIEN);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct ma35_rtc *rtc = dev_get_drvdata(dev);
> +	u32 time, cal, wday;
> +
> +	time = rtc_reg_read(rtc, MA35_REG_RTC_TIME);
> +	cal  = rtc_reg_read(rtc, MA35_REG_RTC_CAL);
> +	wday = rtc_reg_read(rtc, MA35_REG_RTC_WEEKDAY);

Are the registers properly latched when reading? How do you ensure that
MA35_REG_RTC_TIME didn't change before reading MA35_REG_RTC_CAL ?

> +
> +	return ma35d1_rtc_bcd2bin(time, cal, wday, tm);
> +}
> +
> +static int ma35d1_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct ma35_rtc *rtc = dev_get_drvdata(dev);
> +	struct ma35_bcd_time gettm;
> +	u32 val;
> +
> +	ma35d1_rtc_bin2bcd(dev, tm, &gettm);
> +
> +	val = gettm.bcd_mday | gettm.bcd_mon | gettm.bcd_year;
> +	rtc_reg_write(rtc, MA35_REG_RTC_CAL, val);
> +
> +	val = gettm.bcd_sec | gettm.bcd_min | gettm.bcd_hour;
> +	rtc_reg_write(rtc, MA35_REG_RTC_TIME, val);
> +

Same question about latching, shouldn't you stop the rtc while doing
this?

> +	val = tm->tm_wday;
> +	rtc_reg_write(rtc, MA35_REG_RTC_WEEKDAY, val);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct ma35_rtc *rtc = dev_get_drvdata(dev);
> +	struct ma35_bcd_time tm;
> +	unsigned long val;
> +
> +	ma35d1_rtc_bin2bcd(dev, &alrm->time, &tm);
> +
> +	val = tm.bcd_mday | tm.bcd_mon | tm.bcd_year;
> +	rtc_reg_write(rtc, MA35_REG_RTC_CALM, val);
> +
> +	val = tm.bcd_sec | tm.bcd_min | tm.bcd_hour;
> +	rtc_reg_write(rtc, MA35_REG_RTC_TALM, val);
> +

What about handling alrm.enabled here?

> +	return 0;
> +}
> +
> +static const struct rtc_class_ops ma35d1_rtc_ops = {
> +	.read_time = ma35d1_rtc_read_time,
> +	.set_time = ma35d1_rtc_set_time,
> +	.read_alarm = ma35d1_rtc_read_alarm,
> +	.set_alarm = ma35d1_rtc_set_alarm,
> +	.alarm_irq_enable = ma35d1_alarm_irq_enable,
> +};
> +
> +static int ma35d1_rtc_probe(struct platform_device *pdev)
> +{
> +	struct ma35_rtc *rtc;
> +	struct clk *clk;
> +	u32 regval;
> +	int err;
> +
> +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	rtc->rtc_reg = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rtc->rtc_reg))
> +		return PTR_ERR(rtc->rtc_reg);
> +
> +	clk = of_clk_get(pdev->dev.of_node, 0);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "failed to find rtc clock\n");
> +
> +	err = clk_prepare_enable(clk);
> +	if (err)
> +		return -ENOENT;
> +
> +	platform_set_drvdata(pdev, rtc);
> +
> +	rtc->rtcdev = devm_rtc_device_register(&pdev->dev, pdev->name,
> +					       &ma35d1_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(rtc->rtcdev))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtcdev),
> +				     "failed to register rtc device\n");

This MUST be done last in probe, else you open a race with userspace.


> +
> +	err = ma35d1_rtc_init(rtc, RTC_INIT_TIMEOUT);
> +	if (err)
> +		return err;
> +

I don't believe you should do this on every probe but only when this
hasn't been done yet.

> +	regval = rtc_reg_read(rtc, MA35_REG_RTC_CLKFMT);
> +	regval |= RTC_CLKFMT_24HEN;
> +	rtc_reg_write(rtc, MA35_REG_RTC_CLKFMT, regval);
> +

ditto

> +	rtc->irq_num = platform_get_irq(pdev, 0);
> +
> +	err = devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
> +			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
> +	if (err)
> +		return dev_err_probe(&pdev->dev, err, "Failed to request rtc irq\n");
> +
> +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
> +	regval |= RTC_INTEN_TICKIEN;
> +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
> +
> +	device_init_wakeup(&pdev->dev, true);
> +

You must set the rtc range here.

> +	return 0;
> +}
> +
> +static int ma35d1_rtc_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
> +	u32 regval;
> +
> +	if (device_may_wakeup(&pdev->dev))
> +		enable_irq_wake(rtc->irq_num);
> +
> +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
> +	regval &= ~RTC_INTEN_TICKIEN;
> +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);

This is not what the user is asking, don't do this. Also, how was this
tested?

> +
> +	return 0;
> +}
> +
> +static int ma35d1_rtc_resume(struct platform_device *pdev)
> +{
> +	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
> +	u32 regval;
> +
> +	if (device_may_wakeup(&pdev->dev))
> +		disable_irq_wake(rtc->irq_num);
> +
> +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
> +	regval |= RTC_INTEN_TICKIEN;
> +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ma35d1_rtc_of_match[] = {
> +	{ .compatible = "nuvoton,ma35d1-rtc", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ma35d1_rtc_of_match);
> +
> +static struct platform_driver ma35d1_rtc_driver = {
> +	.suspend    = ma35d1_rtc_suspend,
> +	.resume     = ma35d1_rtc_resume,
> +	.probe      = ma35d1_rtc_probe,
> +	.driver		= {
> +		.name	= "rtc-ma35d1",
> +		.of_match_table = ma35d1_rtc_of_match,
> +	},
> +};
> +
> +module_platform_driver(ma35d1_rtc_driver);
> +
> +MODULE_AUTHOR("Min-Jen Chen <mjchen@nuvoton.com>");
> +MODULE_DESCRIPTION("MA35D1 RTC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
