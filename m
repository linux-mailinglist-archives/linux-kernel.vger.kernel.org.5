Return-Path: <linux-kernel+bounces-165912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695808B934B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184B8B22B92
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B324179BD;
	Thu,  2 May 2024 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAFgY1D+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69D817543;
	Thu,  2 May 2024 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714615768; cv=none; b=NQfEhpZUjAIu6SdG125JvirmYc64qAjqfo5zZubWKIG/ckHmwLtz1aRFw3lYsPFDdtRDgANEadOfVE3H3/S3lS4gCJD1LEwNMmVWxtyzfjA4NSh1k154i4fdIkU/RNoQ0GTFf7Bl5b21HMGwUfp4o9AJs9GHhuZKAbv/KFMez74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714615768; c=relaxed/simple;
	bh=gdObBBGhWXQFFeenVvWJpJgDsGdn/fzETCpIOEIRmGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qc01+DICC4A73KQ3FrAaTajaF+JqTDSfTVjb3qfExNLUIlYssPpn5SinnR70aoqCdf6UtEDkqxcZ+Jgpf3QxvadbLzc6Ght3IaKHPcCmvm8YgQzSZmvVsPxMKaFoc4Y6mMsjt/7EETjrDQTnAAN0aQLwWLh7ByT3AO3/pwiAkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAFgY1D+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F37C072AA;
	Thu,  2 May 2024 02:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714615768;
	bh=gdObBBGhWXQFFeenVvWJpJgDsGdn/fzETCpIOEIRmGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZAFgY1D+Weh0f6lq5gzwdcChgv7XcXWC1iYIYuBiTjHqaOQGQQJ5DGbQNrY7z7xFF
	 CMCSU/o+kgffMwYcA2qHXG9J6X8qBviZpPv8d9N0PijN+wrRKatNnjXy+nTK8CKEkK
	 /xsIZU50NxCz5Knwrm2XoiwmWVS5UNNJkHiqwWbL9Lo3tm9K/k3SRccBbZsxP4xwTp
	 y4F25ymE/QiZayIcbP80ve/OAe7HZmzh1UZowscUaO19f92h3ofdbY7UzIHJGOd12U
	 0inOGPT/vADwCHTOJZnK4pQgnHsk69rjrdb6z3gQNaiMfEw3TtvhI+8dvLTjf4Ymf5
	 nxHe2ZEIfW4qg==
Date: Wed, 1 May 2024 19:09:25 -0700
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
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Alexandra Winter
 <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v12 00/13] net: Make timestamping selectable
Message-ID: <20240501190925.34c76ada@kernel.org>
In-Reply-To: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
References: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 17:49:43 +0200 Kory Maincent wrote:
> Up until now, there was no way to let the user select the hardware
> PTP provider at which time stamping occurs. The stack assumed that PHY time
> stamping is always preferred, but some MAC/PHY combinations were buggy.
> 
> This series updates the default MAC/PHY default timestamping and aims to
> allow the user to select the desired hwtstamp provider administratively.

Looks like there's a linking problem starting with patch 9. On a quick
look the functions from a module are now called by build-in code.
-- 
pw-bot: cr

