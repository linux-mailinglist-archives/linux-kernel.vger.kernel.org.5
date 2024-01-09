Return-Path: <linux-kernel+bounces-20320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C34F827D4A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C239C1F244F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261265390;
	Tue,  9 Jan 2024 03:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiaXT9OB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D916D6CE;
	Tue,  9 Jan 2024 03:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4430C433C7;
	Tue,  9 Jan 2024 03:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704770069;
	bh=cXxYTVdcSMeZQ20MjGy87xHWAYYb+d84CTZ50rzCFFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WiaXT9OB9KdfSpvRfYux4VxDOCRb6kakZNFdMbBQL85kDCLa0zhhkLDK8g1Up/gwH
	 1W+T4WyOv+knAHyqypTvY0vE0bEBuxtrFMHZ6KgnUXKt7nAa0CQpSGqf3+6dgZLHZG
	 +sod4qaElNarjiTp4A98B3WuiU1j6qgldk6Tq7dekeRss3+w68dbrTnmiPBszKv9Ld
	 rI3AFBy0IvKK4gJzR/zm9Ft7hfGqp2tVEfvT7lM1UpYpGJJjGHy+OHONmOWl9KIPup
	 8IzS/tLWeCiwBmFAJ+NF8Zz6CxYZ6VPSwoY3ARpHyXh13btdTeEa/cp0OQpIiadRvB
	 eMBxa3OUPOvgg==
Date: Mon, 8 Jan 2024 19:14:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, William Zhang <william.zhang@broadcom.com>, Anand
 Gore <anand.gore@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1p?=
 =?UTF-8?B?xYJlY2tp?= <rafal@milecki.pl>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 =?UTF-8?B?RmVybsOhbmRleg==?= Rojas <noltari@gmail.com>, Sven Schwermer
 <sven.schwermer@disruptive-technologies.com>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v9 0/5] net: phy: generic polarity + LED
 support for qca808x
Message-ID: <20240108191427.6455185a@kernel.org>
In-Reply-To: <20240105142719.11042-1-ansuelsmth@gmail.com>
References: <20240105142719.11042-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jan 2024 15:27:12 +0100 Christian Marangi wrote:
> This small series add LEDs support for qca808x.
> 
> QCA808x apply on PHY reset a strange polarity settings and require
> some tweak to apply a more common configuration found on devices.
> On adding support for it, it was pointed out that a similar
> feature is also being implemented for a marvell PHY where
> LED polarity is set per LED (and not global) and also have
> a special mode where the LED is tristated.
> 
> The first 3 patch are to generalize this as we expect more PHY
> in the future to have a similar configuration.
> 
> The implementation is extensible to support additional special
> mode in the future with minimal changes and don't create regression
> on already implemented PHY drivers.

Looks like we're missing some tags from DTB maintainers here.
Andrew, is there some urgency in getting this merged or can we
defer until v6.9?

