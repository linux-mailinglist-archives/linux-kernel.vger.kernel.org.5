Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193DC7F4D79
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343602AbjKVQzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjKVQzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:55:11 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0A9E7;
        Wed, 22 Nov 2023 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=llPqWm50yG2G6d8aUjmsaKhLgZNwnadcU3ZGNPGP+lo=; b=T30IeF+h3xKqGorWcA2viEmJQI
        cicKm1yi2ucxaziRj0Ucg4xy9HDqA2Keas9XgNJYNDZfYzbsBLGE04r2BSLEIY38Xsr3EbWMbAzZi
        Y4OyAwvkCrakYn9aASb8tH1ZnqO54/zroCc4004ZgMLtj029Y24Tw/rTlsQfZEuHUils=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r5qV3-000tR4-Uf; Wed, 22 Nov 2023 17:54:53 +0100
Date:   Wed, 22 Nov 2023 17:54:53 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <04f59e77-134b-45b2-8759-84b8e22c30d5@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
 <2ff8bea5-5972-4d1a-a692-34ad27b05446@lunn.ch>
 <20231122171112.59370d21@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122171112.59370d21@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +static int pd692x0_sendrecv_msg(struct pd692x0_priv *priv,
> > > +				struct pd692x0_msg *msg,
> > > +				struct pd692x0_msg_content *buf)
> > > +{
> > > +	struct device *dev = &priv->client->dev;
> > > +	int ret;
> > > +
> > > +	ret = pd692x0_send_msg(priv, msg);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = pd692x0_recv_msg(priv, msg, buf);  
> > 
> > So this function takes at least 10 seconds?
> 
> No, on normal communication it takes a bit more than 30ms.

So i think the first step is to refactor this code to make it clear
what the normal path is, and what the exception path is, and the
timing of each.

> > > +	msg.content.sub[2] = id;
> > > +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);  
> > 
> > So this is also 10 seconds? 
> > 
> > Given its name, it looks like this is called via ethtool? Is the
> > ethtool core holding RTNL? It is generally considered bad to hold RTNL for
> > that long.
> 
> Yes it is holding RTNL lock. Should I consider another behavior in case of
> communication loss to not holding RTNL lock so long?

How often does it happen? On the scale of its a theoretical
possibility, through to it happens every N calls? Also, does it happen
on cold boot and reboot?

If its never supposed to happen, i would keep holding RTNL, and add a
pr_warn() that the PSE has crashed and burned, waiting for it to
reboot. If this is likely to happen on the first communication with
the device, we might want to do a dummy transfer during probe to get
is synchronized before we start using it with the RTNL held.

   Andrew
