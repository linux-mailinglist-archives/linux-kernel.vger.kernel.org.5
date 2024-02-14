Return-Path: <linux-kernel+bounces-65638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67FE854FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D967D1C21ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052CA83A17;
	Wed, 14 Feb 2024 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="35fvl8bj"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4A7F7E0;
	Wed, 14 Feb 2024 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931143; cv=none; b=DcP4o+yc7Zrys9WChikFsjtbe8XguIjwYCSaEeooHp35FmI0nzYn5EkfLm8QCo5dNx+e/HwUJHDUkQr/cX0nNRvNRg4WOm9egGA7eBAGZuvfnY6/A/hiC82egsDoJt+UR/BGLq1sf09orz29epYcMt/6GN5HMYKSpwlWsgHP3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931143; c=relaxed/simple;
	bh=FzmanoFfNktS2f2G7iWqRptc+GWThwORnp08ceRIa4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIP7xbNGG65ZScvawCoTBYbs5Xu6JiyLEnkxV7yop6ZNQUwAAQOEfztQ3LBETep2sNAKJtMJogiDUWINLMjbi9kbmsKh0hdSB6Obg3iDXuaNF8ZAoTDO2fTHyqu6/ebKnEOnv8LnTK8Ujjvat1vSBdded1uTdrKyOtgJIPcKjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=35fvl8bj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rqjuTCEFxSun0myagncIypgOBLIS1dt11iBFupB/8I0=; b=35fvl8bjUNypOVFnnp7BYsLaCU
	htuVcTLOpxRx5y6RRlA9/WqKclOgTV47qY8c6NfL7YGMbIBx+MIRCEjT2nY2lJTVLPBbVaWW8KXYt
	ch1niwMWsbH4e9GxFF89AOQhp44UDWWLlkYFlT9CDZL6kQgrJSk/0dEEpH6Qpipl3X+g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raIuR-007oA8-FZ; Wed, 14 Feb 2024 18:18:59 +0100
Date: Wed, 14 Feb 2024 18:18:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 05/17] net: pse-pd: Introduce PSE types
 enumeration
Message-ID: <d2f974e4-6b31-49c0-88ac-7741a980739c@lunn.ch>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-5-531d2674469e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-feature_poe-v3-5-531d2674469e@bootlin.com>

On Thu, Feb 08, 2024 at 02:08:42PM +0100, Kory Maincent wrote:
> Introduce an enumeration to define PSE types (C33 or PoDL),
> utilizing a bitfield for potential future support of both types.
> Include 'pse_get_types' helper for external access to PSE type info.
> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

