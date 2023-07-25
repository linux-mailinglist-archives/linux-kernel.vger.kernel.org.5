Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E898762095
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGYRvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGYRvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:51:37 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80005E2;
        Tue, 25 Jul 2023 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=yNyoNVRI5+OCod59EicTdcPDoMu4zFqhfsWIGBVcAYg=; b=vkRAHPvlC1MAJG2qnz3G/UvB5y
        O9rFGsc7O5vUdb46RoWwHvf7PtGdD7zY2dN1k+nI8Q+HRfdZI9IAuDDLl6TK+R+m8uu4HY8ZRRtkc
        SZ//OGAADklx9x6UmAHweHZzAOulObMwM+Zw4WaHCIcHFzaznp0HplOG8a9kOQzrvSFI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qOMBp-002IJZ-4m; Tue, 25 Jul 2023 19:51:17 +0200
Date:   Tue, 25 Jul 2023 19:51:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] dt-bindings: net: Add HPE GXP UMAC
Message-ID: <4c19532d-a909-4ca6-a0a7-d4cd9cc828b0@lunn.ch>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-4-nick.hawkins@hpe.com>
 <57d882ed-82e5-4584-8126-ca2007064126@lunn.ch>
 <DM4PR84MB192785EC6F2B8A76FF9E5E3F8803A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR84MB192785EC6F2B8A76FF9E5E3F8803A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:44:30PM +0000, Hawkins, Nick wrote:
> Hi Andrew,
> 
> Thank you for the feedback.
> 
> > > +examples:
> > > +  - |
> > > +    ethernet@4000 {
> > > +      compatible = "hpe,gxp-umac";
> > > +      reg = <0x4000 0x80>;
> > > +      interrupts = <22>;
> > > +      mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
> 
> > Do both ports get the sane MAC address?
> 
> No they do not. The first one will get the MAC address, the second
> will be an external phy we are managing via the MDIO path.

Then please put the mac-address property in the correct place, inside
port@0.

> > > +      ethernet-ports {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        port@0 {
> > > +          reg = <0>;
> > > +          phy-handle = <&eth_phy0>;
> > > +        };

> > > +      mdio {
> 
> > This seems to be wrong. You have a standalone MDIO bus driver, not
> > part of the MAC address space?
> 
> I based this from other yaml examples I found. Is there a better way to
> represent it?

The validator when given examples does not validate phy-handle
actually points to a known node. So you can just leave the mdio bus
out all together.

> mdio0: mdio@4080 {
> 	compatible = "hpe,gxp-umac-mdio";
> 	reg = <0x4080 0x10>;
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 	ext_phy0: ethernt-phy@0 {
> 		compatible = "marvell,88e1415","ethernet-phy-ieee802.3-c22";

which is wrong. Please read the binding document for PHYs.

      Andrew
