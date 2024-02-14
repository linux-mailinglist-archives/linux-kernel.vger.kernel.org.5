Return-Path: <linux-kernel+bounces-65659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F23585501A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB671C28FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55DA83CB0;
	Wed, 14 Feb 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rPihSz3S"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8336A002;
	Wed, 14 Feb 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931336; cv=none; b=oJf2gV1uj/0pQkpkIm6CeUSMYf/tZsbyq4x4GmB41Yu0rgYdi4GetPWUUF/4sOPi23UpsNIdZsOTWTdNJWaXtwgIRK8MpxXYunxEepqgpOwlPQAoP7HH9R26C6At3ntIxzKWa91U7Dgr8Ykq8YbEmwMsjugXRTiLJDlm0CDXyc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931336; c=relaxed/simple;
	bh=3ss+Jvydx4YVeV9Nw0m4s1sR+3HmtLWRkF8zwD1CJXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/4SbqmobMl0Y+RjJ99iTBfq6d8yBnkWntuNrxzvudp8y034257SkpJY9qSjrGBXq145BmUwyW3uPNnsjzBPI5EVsQWrKE3U906BROpoB0sQcOygH8cwqZpYprEg9HteZA/cH16dYvhmyUxNQ2FAWC4m/gjL97sX3GUEut04dmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rPihSz3S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MyorRz7r8l4IDMsv/F2dDSyDyLO4psYEtGJ18r7o3bc=; b=rPihSz3SsVCGS3AnD3uiMQo7Gp
	JX5UOr9+A1mfu+FlnGtT0UzoGtZjCwKYS0peogA3oVj5cBiSEuemyVjS7uoDQVakbffWIWPMnACMb
	sysiWeZrqstdY/vFPLZCc5sLGPZXtVmcZJbjfdfac6RaXpNF0A/tmBBDVhvN0kmF3K0I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raIxY-007oBn-Qw; Wed, 14 Feb 2024 18:22:12 +0100
Date: Wed, 14 Feb 2024 18:22:12 +0100
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
Subject: Re: [PATCH net-next v3 07/17] netlink: specs: Modify pse attribute
 prefix
Message-ID: <a410789d-0f51-42d8-bb2a-29ea59b79627@lunn.ch>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-7-531d2674469e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-feature_poe-v3-7-531d2674469e@bootlin.com>

On Thu, Feb 08, 2024 at 02:08:44PM +0100, Kory Maincent wrote:
> Remove podl from the attribute prefix to prepare the support of PoE pse
> netlink spec.
> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

