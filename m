Return-Path: <linux-kernel+bounces-83931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C066886A037
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F601C25644
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F75C524DF;
	Tue, 27 Feb 2024 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qs4BWPQg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D3EEDD;
	Tue, 27 Feb 2024 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062214; cv=none; b=jdonQYtPUORdVEvuvLgcFOJx/qfuVRucppWT72Jo4mfzrI+cHf0jSWkRXk3MT0Nl3MTnBrSkhUqxlQ9We0cAHBikfZbkSyH4dYK2gcR1Y5mwL2zlJb7re5/FpknxnpGuqruD36f03XrisEbO4awKXAR/IuSK79f3a8pUrJPhoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062214; c=relaxed/simple;
	bh=WtsUJfgn8IaWoMU4stYEKnDjr95yzayhTgBN8SNHDA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXVP/6Kn5yQaD+3guf0HlR5Y8iTSlS3oC51xviyZDvrMqRgKPaMnG/7CcC+wh3GUQN+zc5FS3RjRtVGhu7MntWRnu9JatbqkwL2pM/ev+iAjrzcERSt0mTWjzD5fuQ4HkI46cetopQMOVJ8lfUKrAt84EQqQA09DT+Zku6NhJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qs4BWPQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692C2C433C7;
	Tue, 27 Feb 2024 19:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709062214;
	bh=WtsUJfgn8IaWoMU4stYEKnDjr95yzayhTgBN8SNHDA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qs4BWPQg/AxovE4vrnNcsqcVAfH4EbdUaa3yGk5wJaqQnT489fBrU0Ax2PRwgwqVU
	 PD/dzqH8B9UC57hh5XSN527SyU9c5ztQOHhoX2JWN18FgG+cJ3iXAoHhuSaANeejqS
	 nPx7IWexL4GR1KUeS9MKmMkPqNqLfDbp2mMemXOwokT949OVvNMt02p6Udd2f3r/67
	 usy94APC6iIEaT0SgNjlBQbLgbJswY0lLszqZaWBr5p0bKQuSLk8PCKU07w9uEFOsp
	 gX36Wim2Rc2SS04vW6t5mIpBYy8kqD9VNYUNa750sBWvNaOkG4M4xnalc8cRLMl1l/
	 XHfdkttH+oIbg==
Date: Tue, 27 Feb 2024 19:30:09 +0000
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
Subject: Re: [PATCH net-next v5 16/16] net: dsa: vsc73xx: start treating the
 BR_LEARNING flag
Message-ID: <20240227193009.GO277116@kernel.org>
References: <20240223210049.3197486-1-paweldembicki@gmail.com>
 <20240223210049.3197486-17-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223210049.3197486-17-paweldembicki@gmail.com>

On Fri, Feb 23, 2024 at 10:00:46PM +0100, Pawel Dembicki wrote:
> This patch implements .port_pre_bridge_flags() and .port_bridge_flags(),
> which are required for properly treating the BR_LEARNING flag. Also,
> .port_stp_state_set() is tweaked and now disables learning for standalone
> ports.
> 
> Disabling learning for standalone ports is required to avoid situations
> where one port sees traffic originating from another, which could cause
> invalid operations.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

..

> +static int vsc73xx_port_bridge_flags(struct dsa_switch *ds, int port,
> +				     struct switchdev_brport_flags flags,
> +				     struct netlink_ext_ack *extack)
> +{
> +	if (flags.mask & BR_LEARNING) {
> +		struct vsc73xx *vsc = ds->priv;
> +		u32 val = flags.val & BR_LEARNING ? BIT(port) : 0;

Hi Pawel,

as it seems there will be a new revision anyway,
please consider arranging local variables in reverse xmas tree order -
longest line to shortest.

> +
> +		return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +					   VSC73XX_LEARNMASK, BIT(port), val);
> +	}
> +
> +	return 0;
> +}
> +
>  static int vsc73xx_port_bridge_join(struct dsa_switch *ds, int port,
>  				    struct dsa_bridge bridge,
>  				    bool *tx_fwd_offload,

..

