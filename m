Return-Path: <linux-kernel+bounces-133995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E076289ABD8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2CB1C20C1E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896EA3CF73;
	Sat,  6 Apr 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AJY2WeF2"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5C38396;
	Sat,  6 Apr 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419260; cv=none; b=DXIg0BYSspmDI2q/yZc/daHODixk0zl5CLh+/2t964hv1FoXuDP64ewt8xRJ93wLPmkgFFUpvWtu/AzW+idUXm+57IuM1zDZdoAoi8vBVz9Nz1xhSKlfBlzfWHLMalczoODsLG+UJF23npWowLT8z/YiaHEPLifXSg1cQZTwHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419260; c=relaxed/simple;
	bh=W7ibIy99moa7c94LlQb8yKxJ8SMMGHAr8swusC9+ITA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmhwivD2lVKZw0HxM6EDRqeIL2xP/k2fH+fIAshfR9BYyXt0GoGewNRfHri1h/U57Eg0EAr/0q0fE3Na7biE8zo1dDhI9qMVtn52e083jtdThW4Gv0QHnPKW+HqASXhf7CxhvVrRaUH8p3YOuUcbaF+Jx3oXlDvODXkz0Jje050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AJY2WeF2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0rjkgPi2loPfJ44sJGwtAfKw5eXmhNwyXDBE9fqA8to=; b=AJY2WeF28z5VWz9b5njr5FvB+w
	RuUt+Dj6BO9LBAt3WDg89UgqtkSTf9XRGl60zsRvF1IYk/pzz7/8dy65zMNVzH1j3LZeO+LhHxaxn
	SqJalFOTGbLVTLzwipQjbI/mQFnbOnB7BX4D0/Ui9BhYB7p37PuWUyYpZjGOnzIINnLU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rt8TR-00CNY3-1S; Sat, 06 Apr 2024 18:00:57 +0200
Date: Sat, 6 Apr 2024 18:00:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v11 11/13] net: ethtool: cable-test: Target the
 command to the requested PHY
Message-ID: <a4de04ca-9a39-43f7-b086-8ec5d190130d@lunn.ch>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
 <20240404093004.2552221-12-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404093004.2552221-12-maxime.chevallier@bootlin.com>

On Thu, Apr 04, 2024 at 11:30:01AM +0200, Maxime Chevallier wrote:
> Cable testing is a PHY-specific command. Instead of targeting the command
> towards dev->phydev, use the request to pick the targeted PHY.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

