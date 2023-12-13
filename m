Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E27810D01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 10:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjLMJIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:08:37 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42378AD;
        Wed, 13 Dec 2023 01:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=5fdPmGKzNE61LFZ6qQg7uwhhdfvIan9bvjKNoWS3W08=; b=vlYZxVWK/QG28Ej/BxtNFG3u45
        qczHktyj23C6zNtVb/yG3OEu2eUyY7sBHs+k0tUgpymPcRP96TxSQtgndZNWxiNuQSmOy986Ngv4X
        XLSNx3yB76nkc49t4GfSJCW6PB3gXmxs6RK/ujn0kyWTw3H9Xxbgsb1kZ7Rc5K70Pc7k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rDLE9-002new-76; Wed, 13 Dec 2023 10:08:25 +0100
Date:   Wed, 13 Dec 2023 10:08:25 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
 <20231212153512.67a7a35b@device.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212153512.67a7a35b@device.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 03:35:12PM +0100, Maxime Chevallier wrote:
> Hi Daniel
> 
> On Tue, 12 Dec 2023 00:05:35 +0000
> Daniel Golle <daniel@makrotopia.org> wrote:
> 
> > Calling led_trigger_register() when attaching a PHY located on an SFP
> > module potentially (and practically) leads into a deadlock.
> > Fix this by not calling led_trigger_register() for PHYs localted on SFP
> > modules as such modules actually never got any LEDs.
> 
> While I don't have a fix for this issue, I think your justification
> isn't good. This isn't about having LEDs on the module or not, but
> rather the PHY triggering LED events for LEDS that can be located
> somewhere else on the system (like the front pannel of a switch).

SFP LEDs are very unlikely to be on the front panel, since there is no
such pins on the SFP cage.

Russell, in your collection of SFPs do you have any with LEDs?

> So I think it would be wiser to avoid the deadlock with a proper
> analysis of what the locking scheme does. Maybe Andrew or Russell
> have a better vision of what's going-on here, I tried to dive into
> it but it doesn't look straightfoward to me :(

I agree we should at least look at the deadlock, and see if we can
rearrange the locks to avoid it, even if there are no SFPs with LEDs.

	  Andrew
