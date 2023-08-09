Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37159776C78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjHIWwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjHIWv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:51:59 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00904E40;
        Wed,  9 Aug 2023 15:51:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AD3B1BF203;
        Wed,  9 Aug 2023 22:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691621515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEZMIjoThHvWDZsE2t+JOKqFu6GJgeCpp6/meCiTKh0=;
        b=lWkaGs+8EJwvimk1mkbgDCw4Ba5PKhoyBJwdO+81/HIHIZfUsvBh2T016eclaaWqK4ReIf
        u3YdEvX9VzXu9j2ysJtbSLvFc0MkLuutFuWDMZ4l0EPfPOTdrKBfT1GjHrxvDzWJcZyJp9
        y84yNlFmXMkcpNQT/K0jI0dJbNtgYx+jMAzINDzPsnU4ZCQ+xwNcjWd0TP6d1fpTRx/Y/l
        o5t2S4J58WsiudZd0n3aGR8GrrZHOmITEKF3oHvteJMeLsj4cbh7BRRi81Z4K5Wiv4aObt
        gd/Iq0Jyc+WVxlsJpGPu7dEuFEvvfK2I7hwjvCrht9gyCLQ0UekV3A/M5d43XA==
Date:   Thu, 10 Aug 2023 00:51:53 +0200
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
Message-ID: <2023080922515326db190e@mail.local>
References: <20230809011542.429945-1-ychuang570808@gmail.com>
 <20230809011542.429945-4-ychuang570808@gmail.com>
 <20230809021025a7c0daec@mail.local>
 <426130f6-7b8a-91f9-559b-afc5afdc656e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <426130f6-7b8a-91f9-559b-afc5afdc656e@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 16:12:54+0800, Jacky Huang wrote:
> 
> 
> On 2023/8/9 上午 10:10, Alexandre Belloni wrote:
> > Hello,
> > 
> > On 09/08/2023 01:15:42+0000, Jacky Huang wrote:
> > > +
> > > +struct ma35_bcd_time {
> > > +	int bcd_sec;
> > > +	int bcd_min;
> > > +	int bcd_hour;
> > > +	int bcd_mday;
> > > +	int bcd_mon;
> > > +	int bcd_year;
> > > +};
> > I don't get why this struct is useful.
> 
> I will remove this and modify code.
> 
> 
> > > +
> > > +static irqreturn_t ma35d1_rtc_interrupt(int irq, void *data)
> > > +{
> > > +	struct ma35_rtc *rtc = (struct ma35_rtc *)data;
> > > +	unsigned long events = 0, rtc_irq;
> > > +
> > > +	rtc_irq = rtc_reg_read(rtc, MA35_REG_RTC_INTSTS);
> > > +
> > > +	if (rtc_irq & RTC_INTSTS_ALMIF) {
> > > +		rtc_reg_write(rtc, MA35_REG_RTC_INTSTS, RTC_INTSTS_ALMIF);
> > > +		events |= RTC_AF | RTC_IRQF;
> > > +	}
> > > +
> > > +	if (rtc_irq & RTC_INTSTS_TICKIF) {
> > > +		rtc_reg_write(rtc, MA35_REG_RTC_INTSTS, RTC_INTSTS_TICKIF);
> > > +		events |= RTC_UF | RTC_IRQF;
> > How did you test this path?
> 
> We use BusyBox 'date' command to observe the time changed.
> In addition, we wrote a simple code to test it.
> (https://github.com/OpenNuvoton/MA35D1_Linux_Applications/tree/master/examples/rtc)
> 

You should probably run rtctest:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/rtc/rtctest.c


> > > +	if (settm->tm_year < 100) {
> > > +		dev_warn(dev, "The year will be between 1970-1999, right?\n");
> > No, don't do that, properly set the rtc hardware range and let the user
> > choose their time offset/window.
> 
> We will modify the code as:
> 
> #define MA35_BASE_YEAR 2000 /* assume 20YY not 19YY */
> 
> int year;
> 
> year = tm->tm_year + 1900 – MA35_BASE_YEAR;
> if (year < 0) {
>     dev_err(dev, "invalid year: %d\n", year);
>     return -EINVAL;
> }

This is not needed as the rtc core is going to check the value is in the
range once you set it.

> > > +	time = rtc_reg_read(rtc, MA35_REG_RTC_TIME);
> > > +	cal  = rtc_reg_read(rtc, MA35_REG_RTC_CAL);
> > > +	wday = rtc_reg_read(rtc, MA35_REG_RTC_WEEKDAY);
> > Are the registers properly latched when reading? How do you ensure that
> > MA35_REG_RTC_TIME didn't change before reading MA35_REG_RTC_CAL ?
> 
> We will update the code as
> 
> do {
>     time = rtc_reg_read(rtc, MA35_REG_RTC_TIME);
>     cal  = rtc_reg_read(rtc, MA35_REG_RTC_CAL);
>     wday = rtc_reg_read(rtc, MA35_REG_RTC_WEEKDAY);
> } while ((time != rtc_reg_read(rtc, MA35_REG_RTC_TIME)) ||
>          (cal != rtc_reg_read(rtc, MA35_REG_RTC_CAL)) ||
>          (wday != = rtc_reg_read(rtc, MA35_REG_RTC_WEEKDAY)) );

Ok, so this mean your hardware doesn't do latching. I don't think it is
necessary to check MA35_REG_RTC_WEEKDAY.

> 
> 
> > > +
> > > +	return ma35d1_rtc_bcd2bin(time, cal, wday, tm);
> > > +}
> > > +
> > > +static int ma35d1_rtc_set_time(struct device *dev, struct rtc_time *tm)
> > > +{
> > > +	struct ma35_rtc *rtc = dev_get_drvdata(dev);
> > > +	struct ma35_bcd_time gettm;
> > > +	u32 val;
> > > +
> > > +	ma35d1_rtc_bin2bcd(dev, tm, &gettm);
> > > +
> > > +	val = gettm.bcd_mday | gettm.bcd_mon | gettm.bcd_year;
> > > +	rtc_reg_write(rtc, MA35_REG_RTC_CAL, val);
> > > +
> > > +	val = gettm.bcd_sec | gettm.bcd_min | gettm.bcd_hour;
> > > +	rtc_reg_write(rtc, MA35_REG_RTC_TIME, val);
> > > +
> > Same question about latching, shouldn't you stop the rtc while doing
> > this?
> 
> In fact, once enabled, the RTC hardware of MA35D1 cannot be stopped; this is
> how the hardware is designed.
> Inside the MA35D1 RTC, there's an internal counter that advances by 128
> counts per second.
> When the time or date register is updated, the internal counter of the RTC
> hardware will automatically reset to 0,
> so there is no need to worry about memory latch issues.

Ok, great

> 
> 
> > > +	val = tm->tm_wday;
> > > +	rtc_reg_write(rtc, MA35_REG_RTC_WEEKDAY, val);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int ma35d1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> > > +{
> > > +	struct ma35_rtc *rtc = dev_get_drvdata(dev);
> > > +	struct ma35_bcd_time tm;
> > > +	unsigned long val;
> > > +
> > > +	ma35d1_rtc_bin2bcd(dev, &alrm->time, &tm);
> > > +
> > > +	val = tm.bcd_mday | tm.bcd_mon | tm.bcd_year;
> > > +	rtc_reg_write(rtc, MA35_REG_RTC_CALM, val);
> > > +
> > > +	val = tm.bcd_sec | tm.bcd_min | tm.bcd_hour;
> > > +	rtc_reg_write(rtc, MA35_REG_RTC_TALM, val);
> > > +
> > What about handling alrm.enabled here?
> 
> The MA35D1 RTC hardware design does not have an alarm enable/disable bit.
> The decision to utilize the alarm can only be made through enabling or
> disabling the alarm interrupt.

Exactly, you should use alrm.enabled to enable or disable the alarm
interrupt. You can simply call ma35d1_alarm_irq_enable, many drivers are
doing this.

> 
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct rtc_class_ops ma35d1_rtc_ops = {
> > > +	.read_time = ma35d1_rtc_read_time,
> > > +	.set_time = ma35d1_rtc_set_time,
> > > +	.read_alarm = ma35d1_rtc_read_alarm,
> > > +	.set_alarm = ma35d1_rtc_set_alarm,
> > > +	.alarm_irq_enable = ma35d1_alarm_irq_enable,
> > > +};
> > > +
> > > +static int ma35d1_rtc_probe(struct platform_device *pdev)
> > > +{
> > > +	struct ma35_rtc *rtc;
> > > +	struct clk *clk;
> > > +	u32 regval;
> > > +	int err;
> > > +
> > > +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> > > +	if (!rtc)
> > > +		return -ENOMEM;
> > > +
> > > +	rtc->rtc_reg = devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(rtc->rtc_reg))
> > > +		return PTR_ERR(rtc->rtc_reg);
> > > +
> > > +	clk = of_clk_get(pdev->dev.of_node, 0);
> > > +	if (IS_ERR(clk))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "failed to find rtc clock\n");
> > > +
> > > +	err = clk_prepare_enable(clk);
> > > +	if (err)
> > > +		return -ENOENT;
> > > +
> > > +	platform_set_drvdata(pdev, rtc);
> > > +
> > > +	rtc->rtcdev = devm_rtc_device_register(&pdev->dev, pdev->name,
> > > +					       &ma35d1_rtc_ops, THIS_MODULE);
> > > +	if (IS_ERR(rtc->rtcdev))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtcdev),
> > > +				     "failed to register rtc device\n");
> > This MUST be done last in probe, else you open a race with userspace.
> > 
> 
> Yes, I will moved it to last in probe.
> 
> 
> > > +
> > > +	err = ma35d1_rtc_init(rtc, RTC_INIT_TIMEOUT);
> > > +	if (err)
> > > +		return err;
> > > +
> > I don't believe you should do this on every probe but only when this
> > hasn't been done yet.
> > 
> > > +	regval = rtc_reg_read(rtc, MA35_REG_RTC_CLKFMT);
> > > +	regval |= RTC_CLKFMT_24HEN;
> > > +	rtc_reg_write(rtc, MA35_REG_RTC_CLKFMT, regval);
> > > +
> > ditto
> 
> I will modify them as:
> 
> If (!(rtc_reg_read(rtc, MA35_REG_RTC_INIT) & RTC_INIT_ACK)) {
>     err = ma35d1_rtc_init(rtc, RTC_INIT_TIMEOUT);
>     if (err)
>         return err;
>     regval = rtc_reg_read(rtc, MA35_REG_RTC_CLKFMT);
>     regval |= RTC_CLKFMT_24HEN;
>     rtc_reg_write(rtc, MA35_REG_RTC_CLKFMT, regval);}
> }
> 
> 
> > > +	rtc->irq_num = platform_get_irq(pdev, 0);
> > > +
> > > +	err = devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
> > > +			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
> > > +	if (err)
> > > +		return dev_err_probe(&pdev->dev, err, "Failed to request rtc irq\n");
> > > +
> > > +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
> > > +	regval |= RTC_INTEN_TICKIEN;
> > > +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
> > > +
> > > +	device_init_wakeup(&pdev->dev, true);
> > > +
> > You must set the rtc range here.
> 
> I will add:
> ma35d1_rtc->rtcdev->range_min = RTC_TIMESTAMP_BEGIN_2000;
> ma35d1_rtc->rtcdev->range_max = RTC_TIMESTAMP_END_2099;
> 

Perfect. Maybe you should run rtc-range to check for proper operation in
the range:
https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/tree/rtc-range.c

> 
> > > +	return 0;
> > > +}
> > > +
> > > +static int ma35d1_rtc_suspend(struct platform_device *pdev, pm_message_t state)
> > > +{
> > > +	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
> > > +	u32 regval;
> > > +
> > > +	if (device_may_wakeup(&pdev->dev))
> > > +		enable_irq_wake(rtc->irq_num);
> > > +
> > > +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
> > > +	regval &= ~RTC_INTEN_TICKIEN;
> > > +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
> > This is not what the user is asking, don't do this. Also, how was this
> > tested?
> 
> Sure, I will remove these three lines of code.
> 
> We test it with "echo mem > /sys/power/state".
> 

Yes, my point is that if UIE is enabled, then the user wants to be woken
up every second. If this is not what is wanted, then UIE has to be
disabled before going to suspend.

My question is why are you enabling RTC_INTEN_TICKIEN in probe? I don't
expect anyone to use an actual hardware tick interrupt, unless the alarm
is broken and can't be set every second. This is why I questioned the
RTC_UF path because I don't expect it to be taken at all.

> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int ma35d1_rtc_resume(struct platform_device *pdev)
> > > +{
> > > +	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
> > > +	u32 regval;
> > > +
> > > +	if (device_may_wakeup(&pdev->dev))
> > > +		disable_irq_wake(rtc->irq_num);
> > > +
> > > +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
> > > +	regval |= RTC_INTEN_TICKIEN;
> > > +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct of_device_id ma35d1_rtc_of_match[] = {
> > > +	{ .compatible = "nuvoton,ma35d1-rtc", },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, ma35d1_rtc_of_match);
> > > +
> > > +static struct platform_driver ma35d1_rtc_driver = {
> > > +	.suspend    = ma35d1_rtc_suspend,
> > > +	.resume     = ma35d1_rtc_resume,
> > > +	.probe      = ma35d1_rtc_probe,
> > > +	.driver		= {
> > > +		.name	= "rtc-ma35d1",
> > > +		.of_match_table = ma35d1_rtc_of_match,
> > > +	},
> > > +};
> > > +
> > > +module_platform_driver(ma35d1_rtc_driver);
> > > +
> > > +MODULE_AUTHOR("Min-Jen Chen <mjchen@nuvoton.com>");
> > > +MODULE_DESCRIPTION("MA35D1 RTC driver");
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.34.1
> > > 
> 
> 
> Best Regards,
> Jacky Huang
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
