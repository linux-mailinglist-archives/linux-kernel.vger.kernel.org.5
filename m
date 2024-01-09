Return-Path: <linux-kernel+bounces-20256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34774827C81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D774A2854B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372C320F2;
	Tue,  9 Jan 2024 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Av6YPCMA"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3A428EC;
	Tue,  9 Jan 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6BtEmCtYZmMHFCY50bU7DnIDw00PYo7ASFK/qSsw0RM=; b=Av6YPCMAPr8U6MpxUhGmP7ljKc
	10TfumncpOYXF5qldqNoR4q/HRNHL/y+zucm855Y0H2ITU/eXyfdCWKEmQXHF/9hhvCcfNR3zjrkp
	Bxy/Tl58bcpAAHTdiaxbeHgXYTDfvhCwSuHCMO96sClL1DtEcUu7qBilt3hv7X9ZwD3g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rN0mt-004hLR-HN; Tue, 09 Jan 2024 02:20:15 +0100
Date: Tue, 9 Jan 2024 02:20:15 +0100
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
Subject: Re: [net-next PATCH v9 5/5] net: phy: at803x: add LED support for
 qca808x
Message-ID: <c138382e-096c-4ce0-87bd-4e42e6236972@lunn.ch>
References: <20240105142719.11042-1-ansuelsmth@gmail.com>
 <20240105142719.11042-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105142719.11042-6-ansuelsmth@gmail.com>

On Fri, Jan 05, 2024 at 03:27:17PM +0100, Christian Marangi wrote:
> Add LED support for QCA8081 PHY.
> 
> Documentation for this LEDs PHY is very scarce even with NDA access
> to Documentation for OEMs. Only the blink pattern are documented and are
> very confusing most of the time. No documentation is present about
> forcing the LED on/off or to always blink.
> 
> Those settings were reversed by poking the regs and trying to find the
> correct bits to trigger these modes. Some bits mode are not clear and
> maybe the documentation option are not 100% correct. For the sake of LED
> support the reversed option are enough to add support for current LED
> APIs.
> 
> Supported HW control modes are:
> - tx
> - rx
> - link10
> - link100
> - link1000
> - half_duplex
> - full_duplex
> 
> Also add support for LED polarity set to set LED polarity to active
> high or low. QSDK sets this value to high by default but PHY reset value
> doesn't have this enabled by default.
> 
> QSDK also sets 2 additional bits but their usage is not clear, info about
> this is added in the header. It was verified that for correct function
> of the LED if active high is needed, only BIT 6 is needed.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

