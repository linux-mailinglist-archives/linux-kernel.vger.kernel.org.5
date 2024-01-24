Return-Path: <linux-kernel+bounces-37361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C1083AEC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A871C2296D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6ED7E586;
	Wed, 24 Jan 2024 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XlsU+QGw"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6AC7C08C;
	Wed, 24 Jan 2024 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115303; cv=none; b=Hluzeod9CrmNLEqmKcE6Rcno2TZh0OyEiuORLh2Hrh6t79gCK4APnjli5cA5Q30jd0UOqWGIbFAEpnJffwOAi5aJ2qLven34rAtKp+dj5JqPObKdUEEZhj6aF+BXX2e/7IIWqcvaRiNNDKzy8dys4wTX6c27bmAGjvDHWBpt6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115303; c=relaxed/simple;
	bh=P/TUvoMiEV83YDbhVs2P7c3Lloh6Y4fqxH1XGIUbeYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akhX0ghq0I4SgdrxSYWVx2cTBnsqFnqDA+2f3I+x+tDnB7HjQ04rDo/Xa7I0VqpzYuBf288ocBz7R52DMl2c3hxiNqYiRgLN4/Ps5YGeRZ54fDBwAPpHxV+IJrFmO4cF0orMvq2V4E/F6jp2/cLwFmPhVLKHKQUO0gD/NaPyTdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XlsU+QGw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0JjZ2ka+CTc+RssEjPxt5afJQaecPxb0qSfuLGFpoPg=; b=XlsU+QGwkOeqLzcp7+pDl4JZ5v
	k0wvKbTHQTX/DmSSuz8XMFdsUZoEVvhygV+DgDPQ1g7kpRXQZ+grsML3cYCl0FDqV+K04KWs92LpF
	64+0Tzd4u/0OS3s7kUhhBVbuQPfmz/2BRRbZAJ2Irxti+JXf4Je2EFVNGA/+oorL3IFg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rSgWb-0060kt-9U; Wed, 24 Jan 2024 17:54:53 +0100
Date: Wed, 24 Jan 2024 17:54:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
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
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v5 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <1092441f-c347-4f61-8405-7cc8a07d5850@lunn.ch>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
 <20231221180047.1924733-8-maxime.chevallier@bootlin.com>
 <20240104153401.08ff9809@kernel.org>
 <20240105104311.03a35622@device-28.home>
 <2c955f94-7c95-4f66-b739-f0967ec9c171@lunn.ch>
 <20240124145033.1c711fd1@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124145033.1c711fd1@device-28.home>

> > Another option might be to add PHY support to netdevsim. Add a debugfs
> > interface to allow you to create arbitrary PHY topologies? You can
> > then even add a test script.
> 
> Sorry for the delayed answer, I just took a few hours to give it a try,
> and I was able to spin some very basic PHY support for the netdevsim,
> allowing to attach arbitrary instances of fixed_phy devices. I can
> therefore use that as a mean of testing the dump operation, I'll try to
> include that in the next iteration, that should pave the way for some
> testability of more PHY stuff hopefully.

Great that you looked at this.

FYI: Jakub would like to see changes to netdevsim accompanied with
self tests making you of the features you add. There is also now a
build bot running the self tests against net-next, so these tests
should get run quite frequently.

       Andrew


