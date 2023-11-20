Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA33B7F176C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjKTPfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjKTPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:35:17 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A4F9F;
        Mon, 20 Nov 2023 07:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=o0mw2JgobxwE3CByukMe4G5waOUJCs1Oqg/+hT2lg0M=; b=MZhPMwcajRhLZ9BHsVAMYvESlP
        unjmzfPzaUvwIeYdhuX++Sh2goFYq41AnneW4mEzZduSkQu0TCF5uFbT7UXMFxo0xAiQYrzZhZehi
        HCwTGcu1aMnsiFKPW9OgnQBF7yiwyWyw28BTWjA4EUg0mVDZdAB5AevPSZjr8XkxnLus=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r56IZ-000ewk-Vn; Mon, 20 Nov 2023 16:34:55 +0100
Date:   Mon, 20 Nov 2023 16:34:55 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hkallweit1@gmail.com, corbet@lwn.net, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/6] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <1d4d7761-6b42-48ec-af40-747cb4b84ca5@lunn.ch>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
 <20231118062754.2453-4-quic_luoj@quicinc.com>
 <1eb60a08-f095-421a-bec6-96f39db31c09@lunn.ch>
 <ZVkRkhMHWcAR37fW@shell.armlinux.org.uk>
 <eee39816-b0b8-475c-aa4a-8500ba488a29@lunn.ch>
 <fef2ab86-ccd7-4693-8a7e-2dac2c80fd53@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fef2ab86-ccd7-4693-8a7e-2dac2c80fd53@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew,
> The interface mode 10G_QXGMII is a type of USXGMII-M, the other modes
> such as 20G-QXGMII, 20G-OXGMII...
> 
> As for the interface mode 10G-QXGMII, there is a multiplexer for 4 PHYs,
> then do 66bit/68bit encode in xpcs and pass to PMA, the link topology:
> quad PHY --- multiplexer ---XPCS --- PMA.
> the 10G-QXGMII interface block includes multiplexer, XPCS and PMA.
> 
> when the PHY works on SGMII mode, then there is no xpcs, the only fourth
> PHY of qca8084 can work on SGMII mode, the link topology:
> the fourth PHY --- PCS --- PMA, the SGMII block includes PCS and PMA.

What i missed is that you have two different PMA blocks. PHY4 can be
muxed to either the QXGMII PMA or the 2500BaseX PMA. This is not clear
in the commit message, and i think why you are getting questions about
how 2500BaseX can work over QXGMII. Please expand you commit message
to explain the architecture in more detail.

So, next question. How do you control what PMA PHY4 is connected to?
Is this going to be based on interface mode? QXGMII it is configured
to use the QXGMII PMA? SGMII, 1000BaseX, and 2500BaseX it is
configured to the other PMA?

> Here is a problem as Russell mentioned earlier, we need to know which PHY
> device is changing the link status when the 10G-QXGMII mode is used,
> since there are 4 PHYs, when one of them has the link change, there is no
> PHY device information passed to the PHYLINK, so the PCS driver don't
> which PHY is changing link status and 10G-QXGMII mode don't know which
> channel(mapped to PHY) should be configured.

This is the first time QXGMII has been seen in mainline, so its good
to explain the background.

Are you saying there is a USXGMII-M level link change status? The link
between the SoC and the PHY package is up/down? If it is down, all
four MAC-PHY links are down. If it is up, it is possible to carry
frames between the SoC and the PHY package, but maybe the PHYs
themselves are down?

Withing the four multiplex streams, is there a per stream link change
indication?

	Andrew
