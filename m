Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E5B810E02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjLMKGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbjLMKGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:06:20 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EDDA7;
        Wed, 13 Dec 2023 02:06:26 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9EFC1C0007;
        Wed, 13 Dec 2023 10:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702461985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Vs/12xGUPJSfdWRakvw+41gON0/vxkSbuDwoub7QLg=;
        b=ZOxkW6T/ELZrsNiwkrU6xsQkgx1LcKuMCRHv61QxMzNGi0jWd3xgscZOFXvyUe2BTy6sel
        Bj2sjLZctVjWhC1Oz5MdvSTAj62j/7PZv3CNRjg/qqHalD54Lw9LLBzQGPIgaoj/R2hxTW
        CyG4NYjlS4W0H4X+0x/NeWIj9WBX9qr8OSyLPgCOCb4seW0G0fm2dwvpe0N/curKpsYiug
        TByedK/NZGHq5wV4s+UTbRrOs2CqXuAiYs3zO8B1jTk2TzLbPzd4Ye7SU9QuN5a7EmFsUy
        ivMjRqhfp0Wpu/cvJgH+Q4sDgVJ8uWnC8uRH4mjNjm9sh/+NrGU1Wdu5LIG5eQ==
Date:   Wed, 13 Dec 2023 11:06:22 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <20231213110622.29f53391@device.home>
In-Reply-To: <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
        <20231212153512.67a7a35b@device.home>
        <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 10:08:25 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Dec 12, 2023 at 03:35:12PM +0100, Maxime Chevallier wrote:
> > Hi Daniel
> > 
> > On Tue, 12 Dec 2023 00:05:35 +0000
> > Daniel Golle <daniel@makrotopia.org> wrote:
> >   
> > > Calling led_trigger_register() when attaching a PHY located on an SFP
> > > module potentially (and practically) leads into a deadlock.
> > > Fix this by not calling led_trigger_register() for PHYs localted on SFP
> > > modules as such modules actually never got any LEDs.  
> > 
> > While I don't have a fix for this issue, I think your justification
> > isn't good. This isn't about having LEDs on the module or not, but
> > rather the PHY triggering LED events for LEDS that can be located
> > somewhere else on the system (like the front pannel of a switch).  
> 
> SFP LEDs are very unlikely to be on the front panel, since there is no
> such pins on the SFP cage.
> 
> Russell, in your collection of SFPs do you have any with LEDs?

I mean, aren't the led triggers generic so that it can trigger any
other LED to blink, and it's up to the user to decide ?

I do however see one good thing with this patch is that it makes the
behaviour coherent regarding triggers regardless if we have a
media-converter or not.

If we have a SFP bus with phylink as its upstream (SFP bus directly
connected to the MAC), then the phy is going to be attached through
phy_attach_direct(), and before this patch, led triggers will be
registered.

If we have an intermediate PHY acting as a media-converter and
connected to the SFP bus, then the phy isn't attached to the net_device,
and the triggers aren't registered.

So if in the end it doesn't make sense to register led triggers for
PHY in modules, it might be more coherent not registering them at all
as this patch does. What do you think ?

Thanks,

Maxime
