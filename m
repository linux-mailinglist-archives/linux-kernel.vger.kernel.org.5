Return-Path: <linux-kernel+bounces-17321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C74824BC1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E3C282B8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4306F2D054;
	Thu,  4 Jan 2024 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEZCQLn0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB9B2D02A;
	Thu,  4 Jan 2024 23:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AD6C433C8;
	Thu,  4 Jan 2024 23:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704410118;
	bh=8+oSXyf0wqRRdg8sq1ozcCxD/jtiSJlDv+ZMldve9G0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sEZCQLn0iqKE1N3rT6Ql9/kVD9IKcrDzs7hCYNntqjHx8Cw4zDpFyFborzSnwlJhS
	 fMHuPa1qp+wBYUKHPyz/Sm1df6gyfxra24auI87wCtfYET39jH2gHnLOZD6qNWIuh9
	 yuRPsROw2t+iejPRZukvyeoWWaN0RYsXer41olwjd0F9NfugfzPEoPSgzPaEv8+0V2
	 maBj7V4QJCx0Dy2Of+MUAjkfdiUPKsps1HoqZal0HgXqkmKTVOPppUDD0/ROpUjmKV
	 /DoOfp9MuCEYyIhjKflgJ5CU+xZA6dNQTyLFyMguSykA4z5/3zJf9usnCyEItGf26Y
	 hx3lWBBqE5C0g==
Date: Thu, 4 Jan 2024 15:15:16 -0800
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
Subject: Re: [PATCH net-next v5 05/13] net: ethtool: Allow passing a phy
 index for some commands
Message-ID: <20240104151516.5f424dbf@kernel.org>
In-Reply-To: <20231221180047.1924733-6-maxime.chevallier@bootlin.com>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<20231221180047.1924733-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 19:00:38 +0100 Maxime Chevallier wrote:
> @@ -20,6 +21,7 @@ const struct nla_policy ethnl_header_policy[] = {
>  					    .len = ALTIFNAMSIZ - 1 },
>  	[ETHTOOL_A_HEADER_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
>  							  ETHTOOL_FLAGS_BASIC),
> +	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
>  };
>  
>  const struct nla_policy ethnl_header_policy_stats[] = {
> @@ -28,6 +30,7 @@ const struct nla_policy ethnl_header_policy_stats[] = {
>  					    .len = ALTIFNAMSIZ - 1 },
>  	[ETHTOOL_A_HEADER_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
>  							  ETHTOOL_FLAGS_STATS),
> +	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
>  };

You should define (copy/paste) a new header policy and use it
only for commands which actually make use of the PHY index.
That's why we have separate copies already for stats.

