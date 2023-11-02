Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0EF7DF708
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377078AbjKBPuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376703AbjKBPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:50:00 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3E3192;
        Thu,  2 Nov 2023 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=1mL40+ExHNZuGaOB+rQdlmEOkODuu6jCTNDp6aVzkic=; b=uFE0xkaqy6iZ53No0pBhtodBPX
        h/9SjeSRIwhwfwJFnK07vJv5ibpiyHuCps5CLD9qlsDJVRzhq56OVCo28GXOkaI5GaNn3MrTy8Pf4
        lZzRMm+5Tvae5bkpZrVc/f1sqADUwinAG6Wi2EJamJvSu46rAh9ORfk+SmEvP7BnoB+Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qyZwg-000lND-68; Thu, 02 Nov 2023 16:49:22 +0100
Date:   Thu, 2 Nov 2023 16:49:22 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 1/4] net: phy: aquantia: move to separate
 directory
Message-ID: <3af56cbe-dd9a-4747-b7a7-376367df6f79@lunn.ch>
References: <20231102150032.10740-1-ansuelsmth@gmail.com>
 <5f60b2dc-4e97-49dc-8427-306400fb1b71@lunn.ch>
 <6543bb3e.df0a0220.385df.cdb1@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6543bb3e.df0a0220.385df.cdb1@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 04:07:41PM +0100, Christian Marangi wrote:
> On Thu, Nov 02, 2023 at 04:03:33PM +0100, Andrew Lunn wrote:
> > > diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> > > index 421d2b62918f..4b2451dd6c45 100644
> > > --- a/drivers/net/phy/Kconfig
> > > +++ b/drivers/net/phy/Kconfig
> > > @@ -68,6 +68,8 @@ config SFP
> > >  
> > >  comment "MII PHY device drivers"
> > >  
> > > +source "drivers/net/phy/aquantia/Kconfig"
> > > +
> > >  config AMD_PHY
> > >  	tristate "AMD and Altima PHYs"
> > >  	help
> > > @@ -96,11 +98,6 @@ config ADIN1100_PHY
> > >  	  Currently supports the:
> > >  	  - ADIN1100 - Robust,Industrial, Low Power 10BASE-T1L Ethernet PHY
> > >  
> > > -config AQUANTIA_PHY
> > > -	tristate "Aquantia PHYs"
> > > -	help
> > > -	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
> > > -
> > 
> > Does this move the PHY in the make menuconfig menu? We try to keep it
> > sorted based on the tristate string.
> >
> 
> Oh wasn't aware... Yes it does move it to the top of the list... I can
> just move the source entry where AQUANTIA_PHY was...

Yes, that would be best.

Thanks

    Andrew

---
pw-bot: cr

