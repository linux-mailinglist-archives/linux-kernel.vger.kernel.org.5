Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0FF7FCA66
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345786AbjK1XB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjK1XB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:01:27 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1757E1A5;
        Tue, 28 Nov 2023 15:01:32 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 350AA60004;
        Tue, 28 Nov 2023 23:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701212491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gy5+wWjXgmLyDYNQ/I3zqQTEWmaeVqhCkQPBCljqylA=;
        b=bRCYPx8Mi+oYupXYeBmI4FBZvfn8XP6SsqWl77lfy8Bro9xS35o7Qn+66vtTzfr+U5bjUJ
        2gLpnONC/Pn15PtdledA/m6VsZ6rX3A+NC9064+1499LgI9ICIs2L+iQ/SxQGuvFo3GePI
        XgCSH/EyCzrHrqrGSrg7ANhw9vzwbq1UgGkywJTK0M9VbpDpkuR6O7MFupHp8Q+3nWX+mo
        /v25DaY9tQ+hbn3i1Qgt+4Zndi7oiz961R3bcSrHnRG/Jw9eDH5IGlJII7x0ucXBNZX4Eo
        P9gHuDeWO+r9x3U3/uJwwRGpX2UT1uN+oeNlOoF2CpUPQr4ZGiUoJMYVCmzyjA==
Date:   Wed, 29 Nov 2023 00:01:28 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     jingbao qiu <qiujingbao.dlmu@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        a.zummo@towertech.it, krzysztof.kozlowski+dt@linaro.org,
        chao.wei@sophgo.com, unicorn_wang@outlook.com, conor+dt@kernel.org,
        robh+dt@kernel.org, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rtc: add rtc controller support for Sophgo CV1800B
 SoC
Message-ID: <202311282301288a92d806@mail.local>
References: <20231121094642.2973795-1-qiujingbao.dlmu@gmail.com>
 <20231121094642.2973795-3-qiujingbao.dlmu@gmail.com>
 <09b29f1f-a42b-49f7-afca-f82357acd4c8@linaro.org>
 <CAJRtX8TU9Z3OXL1zw9+mGNhxugp_C2jo40k-s9V2byNCQeBoLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJRtX8TU9Z3OXL1zw9+mGNhxugp_C2jo40k-s9V2byNCQeBoLQ@mail.gmail.com>
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

On 28/11/2023 21:22:52+0800, jingbao qiu wrote:
> >
> > > +     ret = cv1800b_rtc_softinit(rtc);
> > > +     if (ret)
> > > +             goto err;
> > > +     cv1800b_rtc_alarm_irq_enable(&pdev->dev, 1);
> > > +     rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
> > > +     if (IS_ERR(rtc->rtc_dev)) {
> > > +             ret = PTR_ERR(rtc->rtc_dev);
> > > +             goto err;
> > > +     }
> > > +     rtc->rtc_dev->range_max = U32_MAX;
> > > +     rtc->rtc_dev->ops = &cv800b_rtc_ops;
> > > +
> > > +     return rtc_register_device(rtc->rtc_dev);
> 
> I find the commet of devm_rtc_device_register wirte
> “This function is deprecated, use devm_rtc_allocate_device and
> rtc_register_device instead”
> but all of code about this, they all use devm_rtc_device_register

They don't, they use devm_rtc_register_device

> function. So which one do you suggest I use?
> 
> > > +err:
> > > +     return dev_err_probe(&pdev->dev, ret, "Failed to init cv1800b rtc\n");
> >
> > Drop, just return.
> 
> ok
> 
> >
> > Best regards,
> > Krzysztof
> >
> 
> Best regards,
> Jingbao Qiu

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
