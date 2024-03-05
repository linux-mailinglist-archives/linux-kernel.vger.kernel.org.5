Return-Path: <linux-kernel+bounces-91566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1D28713B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412831C2352B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014F728E3C;
	Tue,  5 Mar 2024 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM+i0cEA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53338FA7;
	Tue,  5 Mar 2024 02:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606451; cv=none; b=VgxrWWTUgMVoxkrv4hGEBj33D9t26oBvZqO1MN6IZ0GyUcNgMcUPqoURcvtW4zJtcCvcFIrwiatErscsIUeY8lgUi7paIi00xzTjXAJsTxsYEZte9wWjrobdawU7nEJY3DdGtoYaGZmU8C6XCBMbuZlGZJFN61wfeslo/KIpOXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606451; c=relaxed/simple;
	bh=CQzMKNCwVTjpr3SSD1NmN7SsJXn83hglz+/F6GSKw3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiML74pgTHOWDWAJn65J5pezYZJbDGM996gyBa6Y/YSjwj7K95Ml6y2q0IttDxf/2++Yk+LfWSrXpu2qov6hCZGE0yqGFTFiFdtzDm9/i5UrMgnSJ7XHR4EZWvsVLRx9fDhzmE4ao67sOfoFGVwmDIfeg6lXD6O7diEvfkzntx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM+i0cEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53716C433F1;
	Tue,  5 Mar 2024 02:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709606450;
	bh=CQzMKNCwVTjpr3SSD1NmN7SsJXn83hglz+/F6GSKw3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BM+i0cEAgMy8ZPWrCMe8NFXsg2Ndg/+9RJ4RICl2m7QwcbkSUTM8OVLs2rNiV8jDD
	 q8312IGOEx/Io5NWkO9Q3ijsN/l71S9NUJso4ja/DCx3EtQR/stuQgSQaGZao/CvIA
	 bz340722QkXYzabtrNwwvJA7DqWlsSjwyEDfPkUB+H0RdiTN2eBm8YglGYbtnFlTWc
	 vo329/BB45dAeDOoLooX5f45PiR7HjAE+kKrP6vrOAVkD0QzUaxw4WaoGZ0k1xh61s
	 EUXbGjI+EmHuKj6u0Ya14r6fEl2ws5OMJxUVkIQu4CTqYIWjhRaNI94tGtMTszWWKi
	 de8IyeNdIHmMg==
Date: Mon, 4 Mar 2024 18:40:48 -0800
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
Subject: Re: [PATCH net-next v9 02/13] net: Make dev_get_hwtstamp_phylib
 accessible
Message-ID: <20240304184048.1c1724fa@kernel.org>
In-Reply-To: <20240226-feature_ptp_netnext-v9-2-455611549f21@bootlin.com>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-2-455611549f21@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 14:39:53 +0100 Kory Maincent wrote:
> Make the dev_get_hwtstamp_phylib function accessible in prevision to use
> it from ethtool to read the hwtstamp current configuration.

ethtool can't be a module, exports are only needed for code which ends
up being called from modules. 

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index f07c8374f29c..7f78aef73fe1 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4005,6 +4005,8 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
>  int dev_set_hwtstamp_phylib(struct net_device *dev,
>  			    struct kernel_hwtstamp_config *cfg,
>  			    struct netlink_ext_ack *extack);
> +int dev_get_hwtstamp_phylib(struct net_device *dev,
> +			    struct kernel_hwtstamp_config *cfg);

since we don't expect modules to call this, how about we move dev_set*
and the new declaration to net/core/dev.h ?

