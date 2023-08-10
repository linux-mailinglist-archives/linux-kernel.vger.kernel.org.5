Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91BE777163
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjHJHaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHJHaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:30:19 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB15A3;
        Thu, 10 Aug 2023 00:30:17 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E8A3C000C;
        Thu, 10 Aug 2023 07:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691652616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iuypy1p6ook3tCaKkFtNgD/qaSVZXlKQHOWGSdH8/vs=;
        b=O8+LzBWAp0Cie7swpzb3xVJSTCbbwdVDbCDyoIuO62ahqPrcNZfg9CD2+MRXGXF1u5ku3x
        sC+GxVNAkSZex6QwVABp0u6reTfOB+OKgUfqEAC7JXfvrKgeSw/sRyXT4AioYJG0Yn9WId
        vKZPoKQELeD68eQJpAaKfpY0iq3pXjesTqgJrlXRxlKnZVKLqBBwYT4p6zNjQ9hzmxuquU
        Ye3LE3ozc1xr8xZrrgTJkyEPSbPL2V4POcKLD5cfFBgME2wyIKtPZIMbqsT7UeGnld0TTS
        1D8X/fQ6W28aO615atqWv2kgdELriff5TnE852M/5gnfBfEZn0R4GKP4eTgBug==
Date:   Thu, 10 Aug 2023 09:30:15 +0200
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
Message-ID: <20230810073015d5545903@mail.local>
References: <20230809011542.429945-1-ychuang570808@gmail.com>
 <20230809011542.429945-4-ychuang570808@gmail.com>
 <20230809021025a7c0daec@mail.local>
 <426130f6-7b8a-91f9-559b-afc5afdc656e@gmail.com>
 <2023080922515326db190e@mail.local>
 <347cf148-bda8-852b-768c-fa2b57ce5bcb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <347cf148-bda8-852b-768c-fa2b57ce5bcb@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 15:21:47+0800, Jacky Huang wrote:
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int ma35d1_rtc_suspend(struct platform_device *pdev, pm_message_t state)
> > > > > +{
> > > > > +	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
> > > > > +	u32 regval;
> > > > > +
> > > > > +	if (device_may_wakeup(&pdev->dev))
> > > > > +		enable_irq_wake(rtc->irq_num);
> > > > > +
> > > > > +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
> > > > > +	regval &= ~RTC_INTEN_TICKIEN;
> > > > > +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
> > > > This is not what the user is asking, don't do this. Also, how was this
> > > > tested?
> > > Sure, I will remove these three lines of code.
> > > 
> > > We test it with "echo mem > /sys/power/state".
> > > 
> > Yes, my point is that if UIE is enabled, then the user wants to be woken
> > up every second. If this is not what is wanted, then UIE has to be
> > disabled before going to suspend.
> > 
> > My question is why are you enabling RTC_INTEN_TICKIEN in probe? I don't
> > expect anyone to use an actual hardware tick interrupt, unless the alarm
> > is broken and can't be set every second. This is why I questioned the
> > RTC_UF path because I don't expect it to be taken at all.
> 
> Yes, we will remove TICKIEN from probe and modify ma35d1_alarm_irq_enable().
> TICKIEN will be enabled only if UIE is enabled.
> 
> static int ma35d1_alarm_irq_enable(struct device *dev, unsigned int enabled)
> {
>     struct ma35d1_rtc *rtc = dev_get_drvdata(dev);
> 
>     if (enabled) {
>         if (rtc->rtc->uie_rtctimer.enabled)
>             rtc_reg_write(rtc, NVT_RTC_INTEN,
>                       (rtc_reg_read(rtc,
> NVT_RTC_INTEN)|(RTC_INTEN_TICKIEN)));


Don't do that unless the regular alarm can't be set every second. Simply
always use ALMIEN, then check rtctest is passing properly.

>         if (rtc->rtc->aie_timer.enabled)
>             rtc_reg_write(rtc, NVT_RTC_INTEN,
>                       (rtc_reg_read(rtc,
> NVT_RTC_INTEN)|(RTC_INTEN_ALMIEN)));
>     } else {
>         if (rtc->rtc->uie_rtctimer.enabled)
>             rtc_reg_write(rtc, NVT_RTC_INTEN,
>                       (rtc_reg_read(rtc, NVT_RTC_INTEN) &
> (~RTC_INTEN_TICKIEN)));
>         if (rtc->rtc->aie_timer.enabled)
>             rtc_reg_write(rtc, NVT_RTC_INTEN,
>                       (rtc_reg_read(rtc, NVT_RTC_INTEN) &
> (~RTC_INTEN_ALMIEN)));
>     }
>     return 0;
> }
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
