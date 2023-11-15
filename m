Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CBA7EC747
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKOPa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKOPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:30:58 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E65A1A1;
        Wed, 15 Nov 2023 07:30:54 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF8501BF20A;
        Wed, 15 Nov 2023 15:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700062253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yGGXh/tPnXL+P4n+7AuLV8zTk3Fq7KZAHBE5VIThsu4=;
        b=iPaW/d66IhN5NdRncx4yPDUzHnm6FBhB21+9vMHQSjywf2E1BZPiadZ6h+3dmxYLEhEdrQ
        lNQSFomaZnyg5YQfiRSskdqpQfsDzBjI0G1e23n26s0rANrPDWKF/b0yLRo7psbtaiXb8a
        5rQmpiR6bMKlmnr0oAI4n11sI9ApabAVJjh9lqRE7b8Gh0NEFAPt4Tx3ofMPwJN33rsbYm
        bEoJ6LHX3WNotP0dpOGQHqgCez8ZAsYllAIjSveVRY1e2yhjWjqHV9ujHVp/YcLJYyH7QN
        ANSZnl6zlT7adNC2QhVry7sHf42+Jk4H//CV8pFhFYORkJcZhMgjgMWdQ6mCRg==
Date:   Wed, 15 Nov 2023 16:31:07 +0100 (CET)
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
cc:     Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 6/8] net: phy: add calibration callbacks to
 phy_driver
In-Reply-To: <a4dd8cb4-f662-4dc7-8311-712c64de6f21@lunn.ch>
Message-ID: <2d4c7054-1aa8-1531-ffa3-7be342ed9a07@bootlin.com>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com> <20231114105600.1012056-7-romain.gantois@bootlin.com> <a4dd8cb4-f662-4dc7-8311-712c64de6f21@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023, Andrew Lunn wrote:

> > +static inline
> > +int phy_start_calibration(struct phy_device *phydev)
> > +{
> > +	if (!(phydev->drv &&
> > +	      phydev->drv->calibration_start &&
> > +	      phydev->drv->calibration_stop))
> > +		return -EOPNOTSUPP;
> > +
> > +	return phydev->drv->calibration_start(phydev);
> > +}
> > +
> > +static inline
> > +int phy_stop_calibration(struct phy_device *phydev)
> > +{
> > +	if (!(phydev->drv &&
> > +	      phydev->drv->calibration_stop))
> > +		return -EOPNOTSUPP;
> > +
> > +	return phydev->drv->calibration_stop(phydev);
> > +}
> > +
> 
> What is the locking model?
> 
>      Andrew
> 
This driver currently uses an atomic flag to make sure that the calibration 
doesn't run twice. It doesn't acquire any locks before calling 
phy_start_calibration(), which is a mistake.

I think a good locking model for this would be similar to the one used for 
phy_cable_test. The phy_start_calibration() and phy_stop_calibration() wrappers 
would acquire a lock on the PHY device and then test phydev->state, to check for 
an ongoing calibration. A new enum member such as PHY_CALIB could be defined for 
this purpose. The lock would be released by the phylib wrapper once the 
phy_driver callback returns.

The problem with this is that one calibration run can access multiple 
phy_device instances at the same time, e.g. if a switch is linked to a multiport 
PHY via a PSGMII link.

So acquiring a lock on a single phy device isn't enough. Ideally, these 
calls could somehow acquire one lock on all the hardware resources of a 
multiport PHY simultaneously. From what I've seen, there is no standard kernel 
interface that allows MAC drivers to know about link-sharing between phy 
devices. I'll have to do more research on this but if you know of an existing 
interface that I can use for this, please tell me.

Best,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
