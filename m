Return-Path: <linux-kernel+bounces-83929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B4E86A02E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038A31C2470E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3A14A08B;
	Tue, 27 Feb 2024 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECPEzu2J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702952F70;
	Tue, 27 Feb 2024 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062061; cv=none; b=Zzay5Pk5OlcZnRqecMDfBBQupMNkEEzNVvuO6y/k7kiDHUdHz9lx46taxR0f82R+DL9BNHDf+UIRjbHHhDFvUfAsWmKhTO4otUDFI3WnINIkPi8RXT/3dG9g9fxUzkjHFEOqzGnSKMgIYDOODLwNpid2CRrUkLexOThVowDMFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062061; c=relaxed/simple;
	bh=45xmqJKmdxDwAgfJRfqOYWDfp6n7n2+wVRaIaBrPvCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msru7Xjz7zZsrf0j5UwrOHW/+8kRMUi9Tt+bqWbluEm1RF4Veb8ehUohylE/QcLmNnMtW3P3Jsxi5j6QmoFxWoOHQMbULrFSR5WWDgxO4D7iY1eJSguHi0QuPeYCxEsd6H63MXbUQdDmkOTa+xqktFnABZolti1T31X/tyFXSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECPEzu2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820D3C433F1;
	Tue, 27 Feb 2024 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709062060;
	bh=45xmqJKmdxDwAgfJRfqOYWDfp6n7n2+wVRaIaBrPvCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECPEzu2JiafYY2pChQlCuM9pLcSDLzBLMxaW6z9VXuPL+aQceIODBfzQt2Gk8mnTa
	 a6QFbEgF2+417nZVeEZYPiJzzHsHWRkHSiRKfOiL74dwM+plvwR7nmFPffCV7z+F50
	 L6b8h9+QNfAd/tCDYL5lZJDZ7VnzuXiMQXH66ZI5nj8BvO5rPFWIpzFyCCgg7TT/Lx
	 tySxaH8XxkkoloV3no87lhzud5zhD4Vil+6z3PneaPZH1u8nKZHLjE621XrUm2d5F1
	 3sEs9+vGjL/C0aB9oDtTV2AVltax0YNYLp4KSlYBbyxbHB/KN4Ti6XDXqOr7auLy3/
	 o9F+Rdtwgujyw==
Date: Tue, 27 Feb 2024 19:27:35 +0000
From: Simon Horman <horms@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/16] net: dsa: vsc73xx: add
 port_stp_state_set function
Message-ID: <20240227192735.GN277116@kernel.org>
References: <20240223210049.3197486-1-paweldembicki@gmail.com>
 <20240223210049.3197486-7-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223210049.3197486-7-paweldembicki@gmail.com>

On Fri, Feb 23, 2024 at 10:00:36PM +0100, Pawel Dembicki wrote:
> This isn't a fully functional implementation of 802.1D, but
> port_stp_state_set is required for a future tag8021q operations.
> 
> This implementation handles properly all states, but vsc73xx doesn't
> forward STP packets.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

..

> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c

..

> @@ -1036,6 +1029,89 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
>  	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
>  }
>  
> +static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
> +{
> +	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
> +	struct vsc73xx *vsc = ds->priv;
> +	u16 mask;
> +
> +	if (state != BR_STATE_FORWARDING) {
> +		/* Ports that aren't in the forwarding state must not
> +		 * forward packets anywhere.
> +		 */
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_SRCMASKS + port,
> +				    VSC73XX_SRCMASKS_PORTS_MASK, 0);
> +
> +		dsa_switch_for_each_available_port(other_dp, ds) {
> +			if (other_dp == dp)
> +				continue;
> +			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +					    VSC73XX_SRCMASKS + other_dp->index,
> +					    BIT(port), 0);
> +		}
> +
> +	return;

Nit: the line above should be indented by one more tab.

> +	}

..

