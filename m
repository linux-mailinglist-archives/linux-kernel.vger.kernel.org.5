Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF10785650
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjHWK4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjHWK4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:56:06 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8ECCD5;
        Wed, 23 Aug 2023 03:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=A0IfQ3GE4OZYWrbHk+XuRIci+HdUerkCEp4gSqVg1CY=; b=ixH5wEv23MRgT8EdKOFC+2XcBq
        Zbr7ojt4TgC3mlPHt2/nt3SiGzNEazg42Cm44GEOB2TOaMgeDHAGmOMzdnAcYYj4XOWG4xyH+QT+s
        NxJBkOZlXDI2vwhZK1crUAzDdVN7gzmeAr+sJIW6bG+YRljNivIfIZ0Do5zoH6H80rayAz0r0ndFb
        gzNul1mtpWANTsi6QBCsBQfG9lQvPaBiAa6fdlqY34Kgm2a+VtJ80jyDf7y18eQJsJj+NuN7T5rP0
        cF3wLemJJxsr4m3IOFlnM7AKX6w04ziNtyja2TNm56Nh6yjqG+WrAhk9qZJ5qeDTmZfD5RsKbY+Xr
        9on7KwXw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55524)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qYlWU-0002dt-13;
        Wed, 23 Aug 2023 11:55:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qYlWQ-0006l0-4y; Wed, 23 Aug 2023 11:55:34 +0100
Date:   Wed, 23 Aug 2023 11:55:34 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Rohan G Thomas <rohan.g.thomas@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Synopsis XLGMII MAC, IEEE 802.3 and XLGMII interfaces
Message-ID: <ZOXlpkbcAZ4okric@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Okay, I think it's time to get to the bottom of this, and below are my
ramblings so far.

According to IEEE 802.3 80.1.3, XLGMII is the 40 Gb/s MII and CGMII
is the 100 Gb/s MII. 81.1 goes on to state:

The XLGMII/CGMII has the following characteristics:

  a)    The XLGMII supports a speed of 40 Gb/s.
  b)    The CGMII supports a speed of 100 Gb/s.
  c)    Data and delimiters are synchronous to a clock reference.
  d)    It provides independent 64-bit wide transmit and receive data paths.
  e)    It supports full duplex operation only.

That seems very clear.

According to
https://www.synopsys.com/dw/ipdir.php?ds=dwc_ether_enterprise_mac
XLGMII operates at 25 Gb/s, 40 Gb/s, 50 Gb/s and 100 Gb/s. This
appears to "disagree" with IEEE 802.3.

It appears, at least to me, that CGMII and XLGMII are physically
similar interfaces, the only difference seems to be the speed of
operation, so it would be entirely possible to have a MAC that
can operate at both speeds - or indeed at other speeds such as
Synopsys' "XLGMII" MAC.

Now, the problem is... phylink interprets PHY_INTERFACE_MODE_XLGMII
to mean the IEEE 802.3 defined 40 Gb/s mode - in that it _only_
supports 40 Gb/s over that interface mode. Clearly, that's the right
thing to be doing, because this is what IEEE defines and vendor
stuff doesn't apply for generic code.

phylib hasn't defined PHY_INTERFACE_MODE_CGMII yet, so phylink doesn't
provide that (maybe it should.) However, when it does, phylink will
then allow 100 Gb/s over CGMII.

Are there other standards that define 25 and 50 Gb/s over an XLGMII-
like link?

Given the way things are at present, it means that the switch statement
in stmmac_mac_link_up() for PHY_INTERFACE_MODE_XLGMII, only one case
will ever be used - SPEED_40000. I'm guessing this isn't a problem as
no one has reported any problems.

Then... there's the inclusion of 10G, 2.5G and 1G in the XLGMII switch.
The above link to Synopsys website suggests that XGMII is used for 10G
and GMII for 1G.

Given that this is just the MAC, and we would normally have a PCS after
it (which may be XPCS), the interface used between the MAC and PCS isn't
all that relevant, since PHY_INTERFACE_MODE_xxx primerily defines the
interface to any PHY that is connected, and as a secondary function the
interface to fiber (since [MAC - PCS - Serdes] - PHY - media and
[MAC - PCS - Serdes] - media are common, it has made sense to use the
PHY interface mode to define the protocol used on that part of the
link that a PHY _could_ be connected to.)

So, I'm not convinced that the fact that this MAC core uses XLGMII,
XGMII and GMII has any relevance to the PHY_INTERFACE_MODE_ passed
by phylink into functions such as stmmac_mac_link_up(), _unless_ a
PHY is connected directly to the MAC.

If XPCS is connected, that interface mode would be whatever XPCS is
using to talk to the "outside world" not what the connection is
between the MAC and XPCS. If we want to know what that is, then
stmmac needs to be asking XPCS for that information (and maybe
phylink needs to get that from its PCS on behalf of the MAC driver.)

I think there's a lot that needs to be thought about here.

Part 2 of this will be USXGMII... which I'll do as a separate email.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
