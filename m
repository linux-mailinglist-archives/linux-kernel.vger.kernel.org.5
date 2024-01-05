Return-Path: <linux-kernel+bounces-18003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF2E8256D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105761F2331E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B561F2E641;
	Fri,  5 Jan 2024 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jrhu6jAu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8902E63A;
	Fri,  5 Jan 2024 15:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B461C433C8;
	Fri,  5 Jan 2024 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704469185;
	bh=Fd9R1t7XEMCEHJZB7WawIlb8aaIzMwLL0iD9yFevkzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jrhu6jAub+POaFLe7c9KTb6YFKz04dIwf3OvlE17GXqA9kPJawkiC4YX4hsIJMCR9
	 STdE147ItVPDswOTs3fe1gi40PP2u/UAQNn179K9mJJ2FjJwnh0BeVn9sO8LiMCBts
	 nY9DZKgqk9R9XHgnS4cXbWOnwwWTK6kncWmCPHReOOpdCYQ+zBRwORflga8MtpqcCM
	 Kz3x85pQcxeqahhfPp1ML/f+QgoC7qz+bZhlDnVruA/nX4DZiLPJgrRtaHF/svyFgV
	 H3h8UsDzQFGI6hmMvui3se514N7mmdMs/yfUvL5/FNmNVQXy804B0b+bVfK6UGJXC/
	 Y5+P6fZefy1PQ==
Date: Fri, 5 Jan 2024 07:39:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v5 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <20240105073943.43fc2720@kernel.org>
In-Reply-To: <20240105104311.03a35622@device-28.home>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<20231221180047.1924733-8-maxime.chevallier@bootlin.com>
	<20240104153401.08ff9809@kernel.org>
	<20240105104311.03a35622@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jan 2024 10:43:11 +0100 Maxime Chevallier wrote:
> > > +static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
> > > +				   struct nlattr **tb)
> > > +{
> > > +	struct phy_link_topology *topo = &req_base->dev->link_topo;
> > > +	struct phy_req_info *req_info = PHY_REQINFO(req_base);
> > > +	struct phy_device_node *pdn;
> > > +
> > > +	if (!req_base->phydev)
> > > +		return 0;    
> > 
> > The PHY INDEX should probably be a required attr, with 
> > GENL_REQ_ATTR_CHECK()? Without phydev being specified
> > what's the point?  
> 
> We can still have a phydev without passing a PHY INDEX, this would
> report information on the netdev->phydev device, that can be helpful
> for users to know which PHY is targeted by commands such as "ethtool
> --cable-test eth0" when no PHY index is passed

But req_base->phydev will be netdev->phydev if user didn't specify 
the index. Are you saying this is for commands which can operate
on netdevs as well as on PHYs (e.g. "integrated NICs" which don't
user phylib?)

