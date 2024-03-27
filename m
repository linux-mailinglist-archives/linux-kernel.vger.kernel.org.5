Return-Path: <linux-kernel+bounces-121535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B239388E94A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41D31C30C66
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA5712F588;
	Wed, 27 Mar 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtKQdkki"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B02C877;
	Wed, 27 Mar 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553324; cv=none; b=OyjzsCME8FtBtNwQsqgXUoW3WNrE0rWj5ifY/XaImDqU9P7Spnd5EHcosOz9W0BKtgd1bQ+g175EdzSyHvppbgZ0HXW6LipmmWFL6b3LgfMIdGNclyhOCjFLo3z7rGUstUaxUd0rMHzOWRd6t1v9HLb617KYP29ibg6arzknsmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553324; c=relaxed/simple;
	bh=FHkVGrK6WGSw9ut7G2FYEhkDTMQ0kkZKYScpbuAHchw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ojp4Nt1lboO7jk81t343Gw9Knlji9gvWSNPJiwHswFxTvn0yoZZUwU9ZU9k+sCdGyOAxtzBc/ZuYVLuBLQhfsQzdojguqlylsxLsPcUNSWIS+HzkrKx1jp1nAQSKUYQaUGlMZMSIga+xkL6yq017lM/VAqm7w4zMHE/mCHjpvQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtKQdkki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8520AC43390;
	Wed, 27 Mar 2024 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711553324;
	bh=FHkVGrK6WGSw9ut7G2FYEhkDTMQ0kkZKYScpbuAHchw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtKQdkkihsyqzomo25PN6BLsQB2qUsf8lWAp5d7DhpnQjCUIALMlijlXm4C3Vs7Ds
	 tGYH5IxqDD6jNrmLureU9X37fJli4pF6kIDYkK8fUQ6bDcAf6SKcYv0hUPFqBBXcF2
	 IQbSWOmysEL+3/1SN8J7xq6xUaLJiisPlFTESBhGOesyE25CnQggtrT2zvNkK6qyHM
	 yO5UYdZor5zrqV35a2dN5qt0D1y+IJUPcxk+AcLBRG0bremh70cxHvf/trXpz485iG
	 r3oxHqj1w0of6iNTDvr7T5xEwNHK9ME3S+8fzoQdSVV4Ppnht/5k9GSJbU7lHaKe8m
	 8RyBuEUX0qG0Q==
Date: Wed, 27 Mar 2024 15:28:39 +0000
From: Simon Horman <horms@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: marvell: implement cable-test for
 88E308X/88E609X family
Message-ID: <20240327152839.GN403975@kernel.org>
References: <20240326141238.2315974-1-paweldembicki@gmail.com>
 <20240326141238.2315974-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326141238.2315974-2-paweldembicki@gmail.com>

On Tue, Mar 26, 2024 at 03:12:36PM +0100, Pawel Dembicki wrote:
> This commit implements VCT in 88E308X/88E609X Family.
> 
> It require two workarounds with some magic configuration.
> Regular use require only one register configuration. But Open Circuit
> require second workaround.
> It cause implementation two phases for fault length measuring.
> 
> Fast Ethernet PHY have implemented very simple version of VCT. It's
> complitley different than vct5 or vct7.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
>  drivers/net/phy/marvell.c | 252 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 252 insertions(+)
> 
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c

..

> +u32 m88e3082_vct_distrfln_2_cm(u8 distrfln)

nit: This function seems to only be used in this file.
     If so it should be static.

> +{
> +	if (distrfln < 24)
> +		return 0;
> +
> +	/* Original function for meters: y = 0.7861x - 18.862 */
> +	return (7861 * distrfln - 188620) / 100;
> +}

..

