Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BF476BDD9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjHATeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjHATeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:34:13 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A60C19A4;
        Tue,  1 Aug 2023 12:34:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE02EE0004;
        Tue,  1 Aug 2023 19:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690918449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BsYpmsk5UXxFoIUW2ui+3iBsF8PIHOr5des5QvHo2w4=;
        b=kTGR30K5YlIqYQjlZVe28aIOphjUiaPR05EgNKnNa0WmHNs83me4W5MpLVyYSjiFNo/O4I
        q28U+6wAwYYBeDFEwEG7YIv8JqTRaundDKZM3Qz/+9qCwYXftrBhgDkg/V6xD8jendZ/7N
        caplCwauTjIX44It3QZEja95qpYOKcxxey3QEKkb5rZw59n26vOf6I11Ctw+yUgkB2d7jw
        vkw2hAqeECUmuC48MDLWzDd4iOwm9px2Q4zHkgORa6XUA9b1gyomrchiz6J9lCzGE5J6ux
        wWBvZd2nAycnkslyYActplp/OxrXf1o/VKxAOHmkl/IJL9QMmHAx3SBHHN0Qig==
Date:   Tue, 1 Aug 2023 21:34:08 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anvesh Jain P <quic_ajainp@quicinc.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>
Subject: Re: [PATCH] rtc: rtc-pm8xxx: control default alarm wake up capability
Message-ID: <202308011934080c7083b9@mail.local>
References: <20230801114549.26956-1-quic_ajainp@quicinc.com>
 <20230801124056fc665814@mail.local>
 <93722831-dc83-8ea3-4af9-33eaefcf81be@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93722831-dc83-8ea3-4af9-33eaefcf81be@quicinc.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 18:18:46+0530, Anvesh Jain P wrote:
> In automotive systems, RTC should not wake up the device when it is parked
> or when it is garage to avoid leakage current. providing a control from
> device tree to avoid RTC wake up based on the use case is reason for this
> patch.
> 

Then simply avoid providing an IRQ or setting an alarm.

> On 8/1/2023 6:10 PM, Alexandre Belloni wrote:
> > On 01/08/2023 17:15:49+0530, Anvesh Jain P wrote:
> > > Enable & disable rtc alarm wake up capability based on
> > > default parameter passed from device tree.
> > > 
> > 
> > I see what you are doing but not why this is necessary, NAK.
> > 
> > > Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
> > > Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
> > > ---
> > >   drivers/rtc/rtc-pm8xxx.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> > > index f6b779c12ca7..bed57be602b6 100644
> > > --- a/drivers/rtc/rtc-pm8xxx.c
> > > +++ b/drivers/rtc/rtc-pm8xxx.c
> > > @@ -523,6 +523,9 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
> > >   	if (rc)
> > >   		return rc;
> > > +	if (of_property_read_bool(pdev->dev.of_node, "disable-alarm-wakeup"))
> > > +		device_set_wakeup_capable(&pdev->dev, false);
> > > +
> > >   	rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
> > >   	if (rc)
> > >   		return rc;
> > > 
> > > base-commit: 0a8db05b571ad5b8d5c8774a004c0424260a90bd
> > > -- 
> > > 2.17.1
> > > 
> > 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
