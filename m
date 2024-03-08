Return-Path: <linux-kernel+bounces-97181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7AE876694
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BE51F23CB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007455234;
	Fri,  8 Mar 2024 14:47:15 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D1215D0;
	Fri,  8 Mar 2024 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909234; cv=none; b=n7QbI4g+xoiYb6WEOljOBAFfUY5m9F+4OfWnXadX/fdNsIqyMSf2EQsyMnpzHZyrI7ooGYFTRRkW+Y56US6cUEPZtKZKEcFI++mCcJVE0S7Gi2yC+f+Qr9xthsyyAP5fO3FPzK+9KuTtpNrIlEryXQhWn656Je03nj36huQGFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909234; c=relaxed/simple;
	bh=8sEuRsJPVP6JYey+Crp6djns8NX106DrBWF16iCScXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOo7yXOz3GqYkhvw/DMvBVebTv/AtqN3zUlKLm20xITYJBpUcTJcBA982K7PRBnNkJi9ThnCEmvbukb6kLpVE/BaDMpBazdMu2EAlW+yjfIHzN6ZrrRhoUsb9KD4BPIVLzqINpt/FiVEaiOJVO9sR4nIDxFMrUQjVCE6FKhcciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ribUk-0000Uk-1r;
	Fri, 08 Mar 2024 14:46:46 +0000
Date: Fri, 8 Mar 2024 14:46:33 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Justin Swartz <justin.swartz@risingedge.co.za>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: dsa: mt7530: disable LEDs before reset
Message-ID: <ZeskyfVuKECkZB1I@makrotopia.org>
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
 <6064ba52-2470-4c56-958c-35632187f148@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6064ba52-2470-4c56-958c-35632187f148@arinc9.com>

On Fri, Mar 08, 2024 at 12:51:15PM +0300, Arınç ÜNAL wrote:
> Hey Justin.
> 
> I couldn't find anything on the MT7621 Giga Switch Programming Guide v0.3
> document regarding which pin corresponds to which bit on the HWTRAP
> register. There's only this mention on the LED controller section,
> "hardware traps and LEDs share the same pins in GSW". But page 16 of the
> schematics document for Banana Pi BPI-R2 [1] fully documents this.
> 
> The HWTRAP register is populated right after power comes back after the
> switch chip is reset [2]. This means any active link before the reset will
> go away so the high/low state of the pins will go back to being dictated by
> the bootstrapping design of the board. The HWTRAP register will be
> populated before a link can be set up.
> 
> In conclusion, I don't see any need to disable the LED controller before
> resetting the switch chip.
> 
> [1] https://wiki.banana-pi.org/Banana_Pi_BPI-R2#Documents
> 
> [2] I've tested it on my MT7621AT board with a 40MHz XTAL frequency and a
> board with standalone MT7530 with 25MHz XTAL frequency.

How many times did you repeat this test to conclude that there is no
need to disable LEDs before reset?

As Justin is decribing a probabilistic phenomenon ("[...] chance of an
unintended HT_XTAL_FSEL value is reduced.") I believe running a single
test is not enough to conlcude anything.

I have a hard time believing that he was working on this patch without
any reason to do so...


> 
> While the kernel was booting, before the DSA subdriver kicks in:
> - For the board with 40 MHz XTAL: I've connected a Vcc pin to ESW_P3_LED_0
>   to set it high.
> - For the board with 25 MHz XTAL: I've connected a GND pin to ESW_P3_LED_0
>   to set it low.
> 
> Board with 40 MHz XTAL:
> [    2.359428] mt7530-mdio mdio-bus:1f: MT7530 adapts as multi-chip module
> [    2.374918] mt7530-mdio mdio-bus:1f: xtal is 25MHz
> 
> Board with 25 MHz XTAL:
> [    4.324672] mt7530-mdio mdio-bus:1f: xtal is 40MHz
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 51d7b816dd02..beab5e5558d0 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2216,6 +2216,15 @@ mt7530_setup(struct dsa_switch *ds)
>  		return ret;
>  	}
> +	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_25MHZ)
> +		dev_info(priv->dev, "xtal is 25MHz\n");
> +
> +	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_40MHZ)
> +		dev_info(priv->dev, "xtal is 40MHz\n");
> +
> +	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_20MHZ)
> +		dev_info(priv->dev, "xtal is 20MHz\n");
> +
>  	id = mt7530_read(priv, MT7530_CREV);
>  	id >>= CHIP_NAME_SHIFT;
>  	if (id != MT7530_ID) {
> 
> Arınç
> 
> On 5.03.2024 07:39, Justin Swartz wrote:
> > Disable LEDs just before resetting the MT7530 to avoid
> > situations where the ESW_P4_LED_0 and ESW_P3_LED_0 pin
> > states may cause an unintended external crystal frequency
> > to be selected.
> > 
> > The HT_XTAL_FSEL (External Crystal Frequency Selection)
> > field of HWTRAP (the Hardware Trap register) stores a
> > 2-bit value that represents the state of the ESW_P4_LED_0
> > and ESW_P4_LED_0 pins (seemingly) sampled just after the
> > MT7530 has been reset, as:
> > 
> >      ESW_P4_LED_0    ESW_P3_LED_0    Frequency
> >      -----------------------------------------
> >      0               1               20MHz
> >      1               0               40MHz
> >      1               1               25MHz
> > 
> > The value of HT_XTAL_FSEL is bootstrapped by pulling
> > ESW_P4_LED_0 and ESW_P3_LED_0 up or down accordingly,
> > but:
> > 
> >    if a 40MHz crystal has been selected and
> >    the ESW_P3_LED_0 pin is high during reset,
> > 
> >    or a 20MHz crystal has been selected and
> >    the ESW_P4_LED_0 pin is high during reset,
> > 
> >    then the value of HT_XTAL_FSEL will indicate
> >    that a 25MHz crystal is present.
> > 
> > By default, the state of the LED pins is PHY controlled
> > to reflect the link state.
> > 
> > To illustrate, if a board has:
> > 
> >    5 ports with active low LED control,
> >    and HT_XTAL_FSEL bootstrapped for 40MHz.
> > 
> > When the MT7530 is powered up without any external
> > connection, only the LED associated with Port 3 is
> > illuminated as ESW_P3_LED_0 is low.
> > 
> > In this state, directly after mt7530_setup()'s reset
> > is performed, the HWTRAP register (0x7800) reflects
> > the intended HT_XTAL_FSEL (HWTRAP bits 10:9) of 40MHz:
> > 
> >    mt7530-mdio mdio-bus:1f: mt7530_read: 00007800 == 00007dcf
> > 
> >    >>> bin(0x7dcf >> 9 & 0b11)
> >    '0b10'
> > 
> > But if a cable is connected to Port 3 and the link
> > is active before mt7530_setup()'s reset takes place,
> > then HT_XTAL_FSEL seems to be set for 25MHz:
> > 
> >    mt7530-mdio mdio-bus:1f: mt7530_read: 00007800 == 00007fcf
> > 
> >    >>> bin(0x7fcf >> 9 & 0b11)
> >    '0b11'
> > 
> > Once HT_XTAL_FSEL reflects 25MHz, none of the ports
> > are functional until the MT7621 (or MT7530 itself)
> > is reset.
> > 
> > By disabling the LED pins just before reset, the chance
> > of an unintended HT_XTAL_FSEL value is reduced.
> > 
> > Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> > ---
> >   drivers/net/dsa/mt7530.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> > index 3c1f65759..8fa113126 100644
> > --- a/drivers/net/dsa/mt7530.c
> > +++ b/drivers/net/dsa/mt7530.c
> > @@ -2238,6 +2238,12 @@ mt7530_setup(struct dsa_switch *ds)
> >   		}
> >   	}
> > +	/* Disable LEDs before reset to prevent the MT7530 sampling a
> > +	 * potentially incorrect HT_XTAL_FSEL value.
> > +	 */
> > +	mt7530_write(priv, MT7530_LED_EN, 0);
> > +	usleep_range(1000, 1100);
> > +
> >   	/* Reset whole chip through gpio pin or memory-mapped registers for
> >   	 * different type of hardware
> >   	 */

