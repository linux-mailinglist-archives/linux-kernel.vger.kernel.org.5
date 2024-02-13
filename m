Return-Path: <linux-kernel+bounces-62860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E3385271D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501FBB2A286
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9FD1119A;
	Tue, 13 Feb 2024 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMdQrm3A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8A8BE3;
	Tue, 13 Feb 2024 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787513; cv=none; b=H2ZiJuI/Fs7agSpRiUZYSEQOlW/BYyjZRTjLZKlqfs03xvspkprXTIuKnaRFdFlWBiu1XKCxehh0bdNMxRMdquTrx0z550MhBxOafxI4pwbHIFhNAQY4oy77AE8/+HJzU2B2/4zcE1PxCu5NaX18wJwIdYEUDj8RKI/UCwoX2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787513; c=relaxed/simple;
	bh=5LKrz3nxxHWru0zmySaGtmxb2865EnGn98Cu4JRkuNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgE5DXRF30/341p5Dh3F5sSwmIP3NHuiCbWZCXE0EQDnOuJLJOYR2F5gTS1Gx/WiSKMcPdcF70z/eb1JXRSHYEmSG9SiwZw0UyvdMrDO5HjWxK7hUh7Vs0fwocAJzM2UFnGf46+ggj4sMz/Q8E866SrIN5uzX+rd68qMPyKbSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMdQrm3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A336C433C7;
	Tue, 13 Feb 2024 01:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707787512;
	bh=5LKrz3nxxHWru0zmySaGtmxb2865EnGn98Cu4JRkuNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IMdQrm3AnEP8ovLWnZKyiNFZG8ubQmVRKAyZv/TrsOsHMj2cWM2kjbTtn24JtWoxx
	 7SspmNQH13CiRKj4Nnw+MdpVA6FOV/tgvjDvFKQ1uv2XS4sC5UrFeyoKDFdWjMpS/b
	 e/SPQKytVhbwpD3K9JOaNyoC68KM6Boh5tzyzMjF5Ik9S0H7Fs7DdGhP7xnneYk4Co
	 EDsTsYFGK9vpFBr3ZUkLSZiDKRQuqpLzt0x0I8c4bFPAxRgI47iRL+4HfoFmERPxbZ
	 C5wGw7VuR/LiLZwfkQlYUPq/1AZ4YaYz0CRIEWHkGNH6RrAMz4IiRoFr1PgxTEtpiD
	 MU9AXLsQP36/g==
Date: Mon, 12 Feb 2024 17:25:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>, Richard
 Cochran <richardcochran@gmail.com>, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next 1/3] net: phy: Add support for inband
 extensions
Message-ID: <20240212172511.42cd058d@kernel.org>
In-Reply-To: <20240212173307.1124120-2-maxime.chevallier@bootlin.com>
References: <20240212173307.1124120-1-maxime.chevallier@bootlin.com>
	<20240212173307.1124120-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 18:33:04 +0100 Maxime Chevallier wrote:
> +/**
> + * PHY modes in the USXGMII family can have extensions, with data transmitted
> + * in the frame preamble.
> + * For now, only QUSGMII is supported, but other variants like USGMII and
> + * OUSGMII can be added in the future.
> + */
> +static inline bool phy_interface_has_inband_ext(phy_interface_t interface)


Spurious use of /**, it seems. You either need to use full kdoc format,
or the normal /* comment start.
-- 
pw-bot: cr

