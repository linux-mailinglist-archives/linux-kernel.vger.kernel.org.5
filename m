Return-Path: <linux-kernel+bounces-86027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0546C86BEB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995511F259CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3B336AE1;
	Thu, 29 Feb 2024 02:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZcCEcbJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB29E2D638;
	Thu, 29 Feb 2024 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172322; cv=none; b=JlQAQCJTkV+ZA+qfOhiS+BkUTOE6QINKqL78f5wlxmMXCJ/OmRyvHXCpohmlVOMGWv0VBVEc2v4UtctHE1GBA50UGU3juvOdCwR6JdlMw8wmfFVl68vMg+xzYBKeHYCrgKBR6+inxl83Pk+Kptqls4e90K5hww6gbR8ZZXzhTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172322; c=relaxed/simple;
	bh=fqsiv75ue6xl6cHe9uXd44i3iEeE5fdO87JHWHg3h/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdvh3oG3sIo50g1A8e8ZoLN5bokgfdjF1ljQEiuqVXqPbxFlTvtpDta4OKlWte8SeLtLxxOf0r+2RjljnaxFdHNcSMKx+CzRNVN1z0g85eeZyqfPW2U/bf9czEkX5Ra+NJUo7E4siSGkfshQtjuJPEHpOsPRHQjYrfF/phF+yuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZcCEcbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673F9C433C7;
	Thu, 29 Feb 2024 02:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709172322;
	bh=fqsiv75ue6xl6cHe9uXd44i3iEeE5fdO87JHWHg3h/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HZcCEcbJAOOVBYRh7frp3IJCZBT+4Fjgw86FcTURFeVoVjRPckBU//4A3xSyu0Oyy
	 5gxKhzQpa0K/LZdp3OS18OTxc2GVqywAYK+XKC8zXv7blaFE0HbaRiAs9+lPF31hZy
	 L2FW0ixCzn2NOXp1AWcgBm52OPgJHfZVq0IHVGSyys683h2w4QXQerkrbqbsHpxGFI
	 3OOJVnwpRvBHKakCT0WItju9r5KQW5yTzEE3RN5WHNIWy7fGNuddruXFaifTjAfYWR
	 aOtTzVYfbBGlKTMprk1U/iEs0Zvl705TdIm+yJsrhW/hoGCW+gSsy5YGXDSOce2n0/
	 T4eRU3jMGDunA==
Date: Wed, 28 Feb 2024 18:05:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Richard Cochran <richardcochran@gmail.com>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Hangbin Liu <liuhangbin@gmail.com>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Justin Stitt
 <justinstitt@google.com>, Randy Dunlap <rdunlap@infradead.org>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>,
 Jacob Keller <jacob.e.keller@intel.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Message-ID: <20240228180520.5cea0f8b@kernel.org>
In-Reply-To: <20240223192658.45893-2-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
	<20240223192658.45893-2-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 11:24:45 -0800 Rahul Rameshbabu wrote:
> +/**
> + * struct ethtool_ts_stats - HW timestamping statistics
> + * @layer: input field denoting whether stats should be queried from the DMA or
> + *        PHY timestamping layer. Defaults to the active layer for packet
> + *        timestamping.

I think we're better off attaching this to an existing message in the
dump (using ETHTOOL_FLAG_STATS / ethtool -I), like we do for pause, 
fec, etc., rather than having to build a separate hierarchy and copy
identifiers within ETHTOOL_MSG_STATS_GET.

Sorry if I mis-directed you this way.

