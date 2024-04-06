Return-Path: <linux-kernel+bounces-133992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F28F89ABD1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DFF1C20D27
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435173BBDE;
	Sat,  6 Apr 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fuKZqE5r"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77D38396;
	Sat,  6 Apr 2024 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419126; cv=none; b=T6CUFoHLgIjs1DvJ2uyc8LG5H0xI10PhOvh+lcuHeI2ZFSvXV1RmD9/SDi1nU/I8EiBKxjBdD9aCgifoJwO0etZ+DiJgFdh0fH0pgWS4wygxot7H1Y2flTLemSyUgvTwi9GEY38lRpK3xPzil8k1G1AtHwzRBc3lIKJ50TfJ/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419126; c=relaxed/simple;
	bh=nNdKTO1hqqrwsAK7J5UWvHyMQWy/DPFAecbNqFDFKx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8KZTHLlNgLAhNUwWNj++j03ek7noizh3AwFSbRWNaMhDN7XFVzYmXnq2RV0lkTJUGUpTkl3VTkxpNebIG8FgPVKJ2mNGPMryfJLUcPea8gDC3vvSvNuuEHm1pxhYd6grXeNNEkJ8BsrTJ9dz3wr7QrN0N+sGY8Jryf4FJldL9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fuKZqE5r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j4wsuCXSqn6uoRNQn7YbhCaXFnmRpqFl6kS8zFaXYgg=; b=fuKZqE5r+3JLdPKZBwuyf5obJq
	623AkBjqhSEu5NSgQRxygFKrQ7bklm/amGQR5jL+rr+DcaNnZxMMurdjPtZ7hBfG4TtpTCOnAfPqN
	+TuulBU7RRg0GBDvKN6Au9tHNM5SSjSLGn3v2QLJtQQT2kq4gBwezDEbxKHFh/EDni8E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rt8RF-00CNV6-SB; Sat, 06 Apr 2024 17:58:41 +0200
Date: Sat, 6 Apr 2024 17:58:41 +0200
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
Subject: Re: [PATCH net-next v11 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <a5e5c188-bae8-4827-914a-e089cd0bf5c9@lunn.ch>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
 <20240404093004.2552221-8-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404093004.2552221-8-maxime.chevallier@bootlin.com>

On Thu, Apr 04, 2024 at 11:29:57AM +0200, Maxime Chevallier wrote:
> As we have the ability to track the PHYs connected to a net_device
> through the link_topology, we can expose this list to userspace. This
> allows userspace to use these identifiers for phy-specific commands and
> take the decision of which PHY to target by knowing the link topology.
> 
> Add PHY_GET and PHY_DUMP, which can be a filtered DUMP operation to list
> devices on only one interface.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

It would be good if Jakub reviewed this as well, since i don't know
netlink too well. But:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

