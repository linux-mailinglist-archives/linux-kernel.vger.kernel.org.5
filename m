Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCE37D4D55
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjJXKJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjJXKJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:09:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF1A118
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:09:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qvELd-0007oV-5Y; Tue, 24 Oct 2023 12:09:17 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qvELb-003vF3-LM; Tue, 24 Oct 2023 12:09:15 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qvELb-00G6XA-IY; Tue, 24 Oct 2023 12:09:15 +0200
Date:   Tue, 24 Oct 2023 12:09:15 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     UNGLinuxDriver@microchip.com, andrew@lunn.ch, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
        robh+dt@kernel.org, woojung.huh@microchip.com
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Message-ID: <20231024100915.GC3803936@pengutronix.de>
References: <20231023143635.GD3787187@pengutronix.de>
 <20231024075643.25519-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024075643.25519-1-ante.knezic@helmholz.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 09:56:43AM +0200, Ante Knezic wrote:
> On Mon, 23 Oct 2023 16:36:35 +0200, Oleksij Rempel wrote:
> > If I see it correctly, in both cases there is only one bit to configure
> > direction. The code need to support two interface modes:
> > - PHY_INTERFACE_MODE_RMII (MAC mode) PLL is the clock provider. REFCLKO
> >  is used.
> > - PHY_INTERFACE_MODE_REVRMII (PHY mode) PLL is not used, REFCLKI is the
>    clock provider.
> 
> As you suggested, it looks like KSZ9897 clocking mode depends on RMII interface
> mode (with strapping pins), but I don't see this for KSZ8863. The PHY/MAC mode
> is selected with Register 0x35 bit 7 and the clocking mode is selected via
> strapping pins EN_REFCLKO and SMTXD32 (and additional register 0xC6 bit 3).
> I guess its possible for the KSZ8863 to be the clock provider/consumer
> regardless of PHY/MAC mode?

Register 0x35 bit 7 is for MII mode
Register 0xC6 bit 3 is for RMII mode

MII != RMII

> Table 3-5: RMII CLOCK SETTING of KSZ8863 datasheet describes the available 
> clocking modes. If we try to create a relation between KSZ9897 and KSZ8863:
> 
> KSZ9897 "Normal Mode" is equivalent to KSZ8863 mode described in first column
> of table 3-5: 
> - EN_REFCLKO = 0, 0xC6(3) = 0 -> external 50Mhz OSC input to REFCLKI and X1 
>   pin directly
> 
> KSZ9897 "Clock Mode" is equivalent to KSZ8863 mode described in fourth/fifth 
> column (difference is only clock frequency) of table 3-5:
> - EN_REFCLKO = 1, 0xC6(3) = 1 -> 50/25Mhz on X1 pin, 50/25Mhz RMII clock goes
>   to REFCLKI internally. REFCLKI can be pulled down by resistor.
> 
> That leaves us with additional columns 2 and 3 of table 3-5 for KSZ8863, that
> are similar to KSZ9897 Clock mode, but REFCLKI needs to be fed externally from
> REFCLKO.

All of 5 variants described in "Table 3-5: RMII CLOCK SETTING of KSZ8863"
can be boiled down to two main configurations:

REFCLKI is used as clock source for internal MAC == Normal Mode or
RevRMII mode.
REFCLKI is not used as clock source for internal MAC == Clock Mode or
RMII mode.

Variants 1, 2, 3 describe only how can we feed REFCLKI from outside of
the chip. Even variant 2 and 3 make the switch to be an actually
physical clock provider, we still need to use REFCLKI and wire it
outside of the chip which make it practically a Normal Mode or RevRMII mode.

> > I already did some work to configure CPU interface, where which can be at least
> > partially reused for your work:
> > https://lore.kernel.org/all/20230517121034.3801640-2-o.rempel@pengutronix.de/
> > (Looks I forgot to complete mainlining for this patch)
> > 
> > If implanted as described, no new devicetree properties will be needed.
> 
> I don't quite get how the proposed patch might effect this topic?

You will need to add ksz8_phylink_mac_link_up() as this patch already
dose.

> By setting PHY/MAC mode? As noted, I dont see the same relation between clock and
> MII mode for KSZ8863 as for KSZ9897? 

I hope current mail will clear it.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
