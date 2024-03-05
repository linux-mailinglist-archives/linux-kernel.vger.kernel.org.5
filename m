Return-Path: <linux-kernel+bounces-91578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB348713DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ACFEB239F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D619A29416;
	Tue,  5 Mar 2024 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NntN6rcQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D3D18046;
	Tue,  5 Mar 2024 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606860; cv=none; b=U0Tl68XceqY7hDKz6EoJZdCa0k30ZWNCfZabSB+Dk3NYUs9Zq93tVOOGS96yPuxCsWJDQ6Q6KtgNs09+ZU1AdE90Qux+drMSsJgG70dhbsbsN79AbmHV7fm5lkwiu6gxTo1WFUtUmXZOqRWMGKvQ6pYdIAjtGxeSCrkyZCnMPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606860; c=relaxed/simple;
	bh=0T1Pf6i0U9jq7TnISrUd+TgQ25I5SY6Dtbz66ISnEuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnOH8Js59H4lT7WCCpPZEK/7OTUQKKo3fBxgLyZ8GKBxNB6grnONegb5ysT97rVIcwV5Dgoh3vkGhtSHJtwWiSOfLK9Ea0rf3+iqo0lRDuEzrFp0M7fbk7QXJAVrdtUh6sC8MLueQfrEUKfC+MDeEJlNzqgnaL4+/Qu1O7frKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NntN6rcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBFCC433F1;
	Tue,  5 Mar 2024 02:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709606859;
	bh=0T1Pf6i0U9jq7TnISrUd+TgQ25I5SY6Dtbz66ISnEuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NntN6rcQrBzH+ryrj/O7wjmTpVTbXFR6scbPvOAVGwp8pyy9wCL/Q6TM5UzuXim7R
	 5RhzKsRZyp9/sauT3Z2R9Nxr4epg6SDfH3ysSmAQINHlhpRnlbJgdXG5s9m1eza7UZ
	 5/IyXBss8WTcXet09VmIAO9AwChSJqrDtOq5L/bXyjXuRNJ0dtOg1aJhlpAbPqr3gL
	 g4/pF0lWyUP3BamLZ1Dj5t9oh9nRw4T3ByM3+Y7DZzw5+uXxSQtgUe/OCaYeq/aNAV
	 CN5R5HR5e6tx0IrwxN/BFSaU1c6EhD/mYqHJPzmi2O/VgCuicAOypi8XE2kqSE7QmR
	 Ywu4vPc11BmJw==
Date: Mon, 4 Mar 2024 18:47:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v9 07/13] ptp: Move from simple ida to xarray
Message-ID: <20240304184737.30cac57b@kernel.org>
In-Reply-To: <20240226-feature_ptp_netnext-v9-7-455611549f21@bootlin.com>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-7-455611549f21@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 14:39:58 +0100 Kory Maincent wrote:
> +static DEFINE_XARRAY_FLAGS(ptp_clocks_map, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC);

Why _IRQ? anything on the fastpath hopefully has a pointer to the clock
already, I'd hope. And we often reserve ID 0 as invalid.

IOW DEFINE_XARRAY_ALLOC1() ?

BTW could be a standalone patch, Xarray conversion from IDA is an
improvement in itself.

