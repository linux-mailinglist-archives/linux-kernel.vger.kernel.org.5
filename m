Return-Path: <linux-kernel+bounces-17418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37283824CE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F381F213F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0DE2107;
	Fri,  5 Jan 2024 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o4GsTItl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CC31FBF;
	Fri,  5 Jan 2024 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9Fm13D6HkTMzEZBlOarDnIVaiSDDHq61aKHqbRpbK1E=; b=o4GsTItlbg+grt7he924K/ku2I
	5+z0tWqqFd2nbLjRcJ8orIs0aKlySKR+eL+k4wUwmoF4/O5x2EniSQ2Qga17JV0zNUmjgPDIaH1Ee
	s0V1ZkV/FPJ+h0CtIu6Pel8NQDLjdCDPNaPuqRdEaDINZtPui0O9ZNztJI6M/ncFOrcE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLZtq-004Pl0-14; Fri, 05 Jan 2024 03:25:30 +0100
Date: Fri, 5 Jan 2024 03:25:30 +0100
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
Message-ID: <957df01b-bb92-4f8a-9f2b-aacd3de1208d@lunn.ch>
References: <20240104110114.2020-1-ansuelsmth@gmail.com>
 <20240104110114.2020-4-ansuelsmth@gmail.com>
 <47f18def-d34f-4224-9de2-6e0ae7122a52@lunn.ch>
 <6597286c.050a0220.4684a.182e@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6597286c.050a0220.4684a.182e@mx.google.com>

> > > +	 * @dev: PHY device which has the LED
> > > +	 * @index: Which LED of the PHY device or -1
> > > +	 * @modes: bitmap of LED polarity modes
> > > +	 *
> > > +	 * Configure LED with all the required polarity modes in @modes
> > > +	 * to make it correctly turn ON or OFF.
> > 
> > index == -1 should be explained.
> >
> 
> If you are referring to the special way of setting the LED globally,
> that is not a thing anymore. Rob pointed out that having the double
> reference in DT is problematic and PHY driver should handle that
> internally.

So it sounds like you need to change

> > > +	 * @index: Which LED of the PHY device or -1

to remove the 'or -1'

   Andrew

