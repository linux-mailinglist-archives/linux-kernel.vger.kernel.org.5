Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5067D53B3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343601AbjJXONi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343519AbjJXONg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:13:36 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C628BC4;
        Tue, 24 Oct 2023 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=LujRB2KkoptvHOhbGnAbkakhiZEXdCUqv3MjVD+tulI=; b=rWlyXo8GlvY1ir1QYjbv5qDoI6
        KSCEVXw+uUUcokg0iCHGjSY9Clf9WajxbGl7qkrSbglTiEAbMdvK4VJcnzvFEYmDEqqStPFqcJ0mB
        M2zjpVs6/8QZSVY96GCTzEG8ywExi3XbbHofwRMPWy5VdwY1xYypKx5mO5x1CgG0jVCU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qvI9y-0004zL-Em; Tue, 24 Oct 2023 16:13:30 +0200
Date:   Tue, 24 Oct 2023 16:13:30 +0200
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
Subject: Re: [PATCH net-next 4/5] net: ipqess: add a PSGMII calibration
 procedure to the IPQESS driver
Message-ID: <4bde9110-c88d-4a22-8e67-e788db4673f3@lunn.ch>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-5-romain.gantois@bootlin.com>
 <df71bbe5-fec0-45cc-adb4-acfbcc356ba3@lunn.ch>
 <9d447cb5-c8f9-06d2-0909-2870d57f0f7a@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d447cb5-c8f9-06d2-0909-2870d57f0f7a@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, I'll add more detailed comments to the code in the v2. The calibration 
> procedure itself targets the PSGMII device, which is internal to the SoC and can 
> be logically accessed as a PHY device on the MDIO bus. This component is a 
> little opaque and has some nonstandard MII register definitions.
> 
> The "testing" phase that follows the calibration accesses both the internal 
> QCA8K switch ports and the external QCA8075 PHY. For example, it puts both the 
> switch ports and the PHY ports in loopback before starting packet generation on 
> the external PHYs. This is done to verify that the PSGMII link works correctly 
> after being calibrated.
> 
> So this code interacts with both internal ESS devices and external PHYs, but 
> mostly the former, which is why I kept everything in the MAC/switch driver.

Accessing the external PHYs i would suggest go over the normal phylib
API. Somebody might build a board using a different PHY, with
different registers. If all you need is loopback, there is a phylib
call for that.

Directly accessing the internal ESS is fine, it cannot be changed, but
if there are phylib helpers which do the same thing, consider using
them.

     Andrew
