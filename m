Return-Path: <linux-kernel+bounces-4931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2730B8183FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DCDFB23807
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E2012B69;
	Tue, 19 Dec 2023 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxmJVAnK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565A125B0;
	Tue, 19 Dec 2023 09:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88831C433C7;
	Tue, 19 Dec 2023 09:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702976427;
	bh=7lPJeEGRA+v+htYV42yko4yF0KBUn2IyqKKgjcCAxrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IxmJVAnKZj+06aLhm7xhf2DPFrjWcriT2r501VOULyHpFR08ACZ7k4OeDjmewzi6I
	 e/TDOV/63BWqsTI3luxnPvb7cnrykXZIIlvC3LmZdiuCvdtLJ8OVtHbz8EWrTvldfW
	 VuhJ8quHz+Jo8qEP1iLmhxc845PD3edozq6bpQI5uIXoCxmzL6srDblkkPnYu7esfi
	 qrKMHjfJJlGGPLHUQn5KWFL1WK2xkKg6Kb//htWNFPZ21agunQ70bfeJ2jQJobv2Q7
	 I/Ojsi0B6wKPfjIxZEv1+N3+uLSE+buJwfVkfVa63dtRKLNuze7v5ZUEMABFX6G1pN
	 2COE1D2MdNaFw==
Date: Tue, 19 Dec 2023 08:58:51 +0000
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>
Subject: Re: [PATCH net-next v4 13/13] Documentation: networking: document
 phy_link_topology
Message-ID: <20231219085851.GC811967@kernel.org>
References: <20231215171237.1152563-1-maxime.chevallier@bootlin.com>
 <20231215171237.1152563-14-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215171237.1152563-14-maxime.chevallier@bootlin.com>

On Fri, Dec 15, 2023 at 06:12:35PM +0100, Maxime Chevallier wrote:

...

> +UAPI
> +====
> +
> +There exist a set of netlink commands to query the link topology from userspace,
> +see ``Documentation/networking/ethtool-netlink.rst``.
> +
> +The whole point of having a topology representation is to assign the phyindex
> +field in :c:type:`struct phy_device <phy_device>`. This index is reported to
> +userspace using the ``ETHTOOL_MSG_PHY_GET`` ethtnl command. Performing a DUMP operation
> +will result in all PHYs from all net_device being listed. The DUMP command
> +accepts either a ``ETHTOOL_A_HEADER_DEV_INDEX`` or ``ETHTOOL_A_HEADER_DEV_NAME``
> +to be passed in the request to filter the DUMP to a single net_device.
> +
> +The retrieved index can then be passed as a request parameter using the
> +``ETHTOOL_A_HEADER_PHY_INDEX`` field in the following ethnl commands :
> +
> +* ``ETHTOOL_MSG_STRSET_GET`` to get the stats strig set from a given PHY

string

> +* ``ETHTOOL_MSG_CABLE_TEST_ACT`` and ``ETHTOOL_MSG_CABLE_TEST_ACT``, to perform
> +  cable testing on a given PHY on the link (most likely the outermost PHY)
> +* ``ETHTOOL_MSG_PSE_SET`` and ``ETHTOOL_MSG_PSE_GET`` for PHY-controlled PoE and PSE settings
> +* ``ETHTOOL_MSG_PLCA_GET_CFG``, ``ETHTOOL_MSG_PLCA_SET_CFG`` and ``ETHTOOL_MSG_PLCA_GET_STATUS``
> +  to set the PLCA (Physical Layer Collision Avoidance) parameters
> +
> +Note that the PHY index can be passed to other requests, which will silently
> +ignore it if present and irrelevant.
> -- 
> 2.43.0
> 

