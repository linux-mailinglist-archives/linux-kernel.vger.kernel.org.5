Return-Path: <linux-kernel+bounces-16698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D120582429C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D37F1F2269D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53A2233A;
	Thu,  4 Jan 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UihrHtrq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF421374;
	Thu,  4 Jan 2024 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Yjf0yIFfs+i6yyGRMaFNHLw0zbWSp5xq8DiLwHvL6ew=; b=UihrHtrq21yZ8dwOFw43Jyiq5G
	zwvFwzPZ0ivxq7HFSxubc1TOoou+OaqF1DIoomhRZ85CtQvTWhf1OH23RR8zOr4rVgwpKMfrLEQwF
	a1VJCSdXa/YSQxnoq2MQ8Q1OsLJip8AAPbB+tLmKpMYnp+ilssBcZJQrAbDmKryqnV/k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLNeP-004LlA-HB; Thu, 04 Jan 2024 14:20:45 +0100
Date: Thu, 4 Jan 2024 14:20:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	=?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v8 3/5] net: phy: add support for PHY LEDs
 polarity modes
Message-ID: <47f18def-d34f-4224-9de2-6e0ae7122a52@lunn.ch>
References: <20240104110114.2020-1-ansuelsmth@gmail.com>
 <20240104110114.2020-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104110114.2020-4-ansuelsmth@gmail.com>

> +	if (phydev->drv->led_polarity_set) {
> +		if (of_property_read_bool(led, "active-low"))
> +			set_bit(PHY_LED_ACTIVE_LOW, &modes);
> +		if (of_property_read_bool(led, "inactive-high-impedance"))
> +			set_bit(PHY_LED_INACTIVE_HIGH_IMPEDANCE, &modes);
> +
> +		err = phydev->drv->led_polarity_set(phydev, index, modes);
> +		if (err)
> +			return err;
> +	}

I think we should return an error if asked to set the mode, but its
not implemented by the driver. Something like:

	if (of_property_read_bool(led, "active-low"))
		set_bit(PHY_LED_ACTIVE_LOW, &modes);
	if (of_property_read_bool(led, "inactive-high-impedance"))
		set_bit(PHY_LED_INACTIVE_HIGH_IMPEDANCE, &modes);

		
	if (mode)
		if (phydev->drv->led_polarity_set) {
			return -EINVAL;
		} else {
			err = phydev->drv->led_polarity_set(phydev, index, modes);
			if (err)
				return err;
		}
	}

> +	/**
> +	 * @led_polarity_set: Set the LED polarity if active low

The 'if active low' is not ouw of date, since it is used for more than
that.

> +	 * @dev: PHY device which has the LED
> +	 * @index: Which LED of the PHY device or -1
> +	 * @modes: bitmap of LED polarity modes
> +	 *
> +	 * Configure LED with all the required polarity modes in @modes
> +	 * to make it correctly turn ON or OFF.

index == -1 should be explained.

> +	 *
> +	 * Returns 0, or an error code.
> +	 */
> +	int (*led_polarity_set)(struct phy_device *dev, int index,
> +				unsigned long modes);


    Andrew

---
pw-bot: cr

