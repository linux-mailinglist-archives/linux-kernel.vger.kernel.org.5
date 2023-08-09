Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8637750BB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjHICM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjHICM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:12:27 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113BCF3;
        Tue,  8 Aug 2023 19:12:25 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 512ABC0003;
        Wed,  9 Aug 2023 02:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691547144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9rFEnNQwjkEYrsNofQX5zgngbo+/k9VPRl09iaDkgfw=;
        b=fM1JUYttGO4l1yPqT972IWNuJVhnctqVpdBXINuBxD+8nApZhrNa8mcnHMV4WKIHk8ap9B
        RqJ5YhliqSkKlnIcVDiysBN9l4D5u1V4IF2F+Y/CYYRRZ6OH1Voaj66uA99yBwWY2zDTHP
        eABokGOWzkeePett3NFaEAIJj+QFkFqEIATr+CoH8n9FcnIcEUBjlw8UZC28p3aiH0MeL3
        /uss7CiOLllKYPt3QvzbgHE/9qZnyqW5OSQJcCL6SaBxk+EFqCGtgLNItpnaKOy2xbxKlb
        KTWsJ3/Amn7Kb1ttZbbpt/+CgSO4TudC/m+A074ZxLdZP1f85mHyUuU9uZo30g==
Date:   Wed, 9 Aug 2023 04:12:24 +0200
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
Message-ID: <20230809021224ab4f229f@mail.local>
References: <20230809011542.429945-1-ychuang570808@gmail.com>
 <20230809011542.429945-4-ychuang570808@gmail.com>
 <20230809021025a7c0daec@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809021025a7c0daec@mail.local>
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

On 09/08/2023 04:10:27+0200, Alexandre Belloni wrote:
> > +static int ma35d1_rtc_probe(struct platform_device *pdev)
> > +{
> > +	struct ma35_rtc *rtc;
> > +	struct clk *clk;
> > +	u32 regval;
> > +	int err;
> > +
> > +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> > +	if (!rtc)
> > +		return -ENOMEM;
> > +
> > +	rtc->rtc_reg = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(rtc->rtc_reg))
> > +		return PTR_ERR(rtc->rtc_reg);
> > +
> > +	clk = of_clk_get(pdev->dev.of_node, 0);
> > +	if (IS_ERR(clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "failed to find rtc clock\n");
> > +
> > +	err = clk_prepare_enable(clk);
> > +	if (err)
> > +		return -ENOENT;
> > +
> > +	platform_set_drvdata(pdev, rtc);
> > +
> > +	rtc->rtcdev = devm_rtc_device_register(&pdev->dev, pdev->name,
> > +					       &ma35d1_rtc_ops, THIS_MODULE);
> > +	if (IS_ERR(rtc->rtcdev))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtcdev),
> > +				     "failed to register rtc device\n");
> 
> This MUST be done last in probe, else you open a race with userspace.
> 
> 
> > +
> > +	err = ma35d1_rtc_init(rtc, RTC_INIT_TIMEOUT);
> > +	if (err)
> > +		return err;
> > +
> 
> I don't believe you should do this on every probe but only when this
> hasn't been done yet.
> 

Also, if you can know that the time has never been set, don't discard
this information, this is crucial information and it needs to be
reported to userspace.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
