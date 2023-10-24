Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D6A7D53A7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343585AbjJXOIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjJXOIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:08:46 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1193A3;
        Tue, 24 Oct 2023 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=eDhesMhiwtf5oRFEe0tcbmQl0LJ8NdA55Y6empsfy2E=; b=2wTaoheinvFFan+20dLH3nGj5o
        mtfWlWEKM8LyBNDOp+/JH7uDIycqEZtgXmeSlPZk3qP5zsH7TMOjFNf4ytimoM16XLKvRbaSVybhL
        3ojnbBDMDu0/yiXSz7A5Xgu/xZi7OwNLheXWaf/4b7wdxXlzWMd9ZrOUMM17ZI35SsPY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qvI59-0004xO-Ki; Tue, 24 Oct 2023 16:08:31 +0200
Date:   Tue, 24 Oct 2023 16:08:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Romain Gantois <romain.gantois@bootlin.com>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
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
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 3/5] net: ipqess: introduce the Qualcomm IPQESS
 driver
Message-ID: <932bef01-b498-4c1a-a7f4-3357fe94e883@lunn.ch>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-4-romain.gantois@bootlin.com>
 <b8ac3558-b6f0-4658-b406-8ceba062a52c@lunn.ch>
 <f4e6dcee-23cf-bf29-deef-cf876e63bb8a@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4e6dcee-23cf-bf29-deef-cf876e63bb8a@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +	for (c = 0; c < priv->info->mib_count; c++) {
> > > +		mib = &ar8327_mib[c];
> > > +		reg = QCA8K_PORT_MIB_COUNTER(port->index) + mib->offset;
> > > +
> > > +		ret = qca8k_read(priv, reg, &val);
> > > +		if (ret < 0)
> > > +			continue;
> > 
> > Given the switch is built in, is this fast? The 8k driver avoids doing
> > register reads for this.
> 
> Sorry, I don't quite understand what you mean. Are you referring to the existing 
> QCA8k DSA driver? From what I've seen, it calls qca8k_get_ethtool_stats defined 
> in qca8k-common.c and this uses the same register read.

It should actually build an Ethernet frame containing a command to get
most of the statistics in one operation. That frame is sent to the
switch over the SoCs ethernet interface. The switch replies with a
frame containing the statistics. This should be faster than doing lots
of register reads over a slow MDIO bus.

Now, given that this switch is built into the SoC, i assume the MDIO
bus is gone, so register access is fast. So you don't need to use
Ethernet frames.

	 Andrew
