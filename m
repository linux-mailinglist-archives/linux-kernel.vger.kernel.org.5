Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D961A79E821
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbjIMMgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjIMMgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:36:42 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF2B19A6;
        Wed, 13 Sep 2023 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Znl3NLuXYp7P/vugDRSybZxt9vQVGXDZ3zZmS+2t90I=; b=2AHv4vQxAGFpG5nS4mY2BzHTk7
        o3x8sq4nCEV5EOqXykpo5L1ynfZ9ecym/SZxjOnxroFNUm7p1DhUndMhl87gAXr4UhTMjGc5EI52Y
        Au3VeWaYFT0LItEi9zyxD50rWvs+2x+Y/qgILlDEqEvKvZBiLjCxA9gTzADMdLDhpEts=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgP6Y-006Iyp-G8; Wed, 13 Sep 2023 14:36:26 +0200
Date:   Wed, 13 Sep 2023 14:36:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Message-ID: <61a58960-f2f3-4772-8f12-0d1f9cfec2c5@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
 <20230913104458.1d4cdd51@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913104458.1d4cdd51@wsk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Just maybe mine small remark. IMHO the reset shall not pollute the IRQ
> hander. The RESETC is just set on the initialization phase and only
> then shall be served. Please correct me if I'm wrong, but it will not
> be handled during "normal" operation.

This is something i also wondered. Maybe if the firmware in the
MAC-PHY crashes, burns, and a watchdog reset it, could it assert
RESETC? I think maybe a WARN_ON_ONCE() for RESETC in the interrupt
handler would be useful, but otherwise ignore it. Probe can then poll
during its reset.

> > +				regval = RESETC;
> > +				/* SPI host should write RESETC bit
> > with one to
> > +				 * clear the reset interrupt status.
> > +				 */
> > +				ret = oa_tc6_perform_ctrl(tc6,
> > OA_TC6_STS0,
> > +							  &regval,
> > 1, true,
> > +							  false);
> 
> Is this enough to have the IRQ_N deasserted (i.e. pulled HIGH)?
> 
> The documentation states it clearly that one also needs to set SYNC bit
> (BIT(15)) in the OA_CONFIG0 register (which would have the 0x8006 value).
> 
> Mine problem is that even after writing 0x40 to OA_STATUS0 and 0x8006
> to OA_CONFIG0 the IRQ_N is still LOW (it is pulled up via 10K resistor).
> 
> (I'm able to read those registers and those show expected values)

What does STATUS0 and STATUS1 contain? That might be a dumb question,
i've not read the details for interrupt handling yet, but maybe there
is another interrupt pending? Or the interrupt mask needs writing?

> Was it on purpose to not use the RST_N pin to perform GPIO based reset?
> 
> When I generate reset pulse (and keep it for low for > 5us) the IRQ_N
> gets high. After some time it gets low (as expected). But then it
> doesn't get high any more.

Does the standard say RST_N is mandatory to be controlled by software?
I could imagine RST_N is tied to the board global reset when the power
supply is stable. Software reset is then used at probe time.

So this could be a board design decision. I can see this code getting
extended in the future, an optional gpiod passed to the core for it to
use.

> > msecs_to_jiffies(1));
> 
> Please also clarify - does the LAN8651 require up to 1ms "settle down"
> (after reset) time before it gets operational again?

If this is not part of the standard, it really should be in the MAC
driver, or configurable, since different devices might need different
delays. But ideally, if the status bit says it is good to go, i would
really expect it to be good to go. So this probably should be a
LAN8651 quirk.

	Andrew
