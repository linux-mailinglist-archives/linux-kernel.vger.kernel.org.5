Return-Path: <linux-kernel+bounces-85233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D792186B297
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778371F28018
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D2A15B96A;
	Wed, 28 Feb 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bTUZz3v4"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E224B39;
	Wed, 28 Feb 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132658; cv=none; b=Rl3otR9/UF6Of4xCJQgPwkR6u4nMqz4TvBd3kINcxbtICgeQCX5RNOgc84czynPmxg9Jx1mAVWmQIfStL1uoaUeeD0lqB9fxLQdTJATsYLhgoTU5lV2np0zsyPfSTEGq0AJ4W0Q5WYLVfpZPdhHAWjYJ3QQjGtm/BGmnux0csc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132658; c=relaxed/simple;
	bh=t9muqhfNN7i4XP7gG3jCRjrTS9ve2WB+DxxVMTVNZA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLkIYbq8+C8Ls3AiwU/URcwv0t20XN4ewV/guflYmq+Ot0mVkFtFJ8PKf4l1lEHz23xSVGbJGDP5w4S6J1AEav/UznGYLf6rgvC09ljSQRuP2LA1P7ISbYaujtGLcqu4EvSnQTI0ysmsBVl2FKOMZkMu2d3BlhlMtNS9p1kPCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bTUZz3v4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dOocNfIFOpPF6lqMWSXAW9AMnznAJXSj9KJvDupMxYg=; b=bTUZz3v4hxXRRqqLkvtLScD7qZ
	/WpJG7GUplG1kh3IxUbHuJznV7aCXbWselztd5/1OrNEIjX4DPWCAT3nwjZus2EnfKmMELkcf/8IJ
	J4b7cgWKvuKSxI+sC5x58oWQ0WEsz0TGSxx/d5ZvgMMy8WpyRjH7+YsKq1ZugZII140Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfLTn-008xT3-DF; Wed, 28 Feb 2024 16:04:19 +0100
Date: Wed, 28 Feb 2024 16:04:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, maxime.chevallier@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: Re: [PATCH v2 3/6] net: phy: DP83640: Add LED handling
Message-ID: <9b06003c-afc9-419a-af36-7b81aab8517e@lunn.ch>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
 <20240227093945.21525-4-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227093945.21525-4-bastien.curutchet@bootlin.com>

> +static int dp83640_led_brightness_set(struct phy_device *phydev, u8 index,
> +				      enum led_brightness brightness)
> +{
> +	int val;
> +
> +	if (index > DP83640_SPDLED_IDX)
> +		return -EINVAL;
> +
> +	phy_write(phydev, PAGESEL, 0);
> +
> +	val = phy_read(phydev, LEDCR) & ~DP83640_LED_DIS(index);
> +	val |= DP83640_LED_DRV(index);
> +	if (brightness)
> +		val |= DP83640_LED_VAL(index);
> +	else
> +		val &= ~DP83640_LED_VAL(index);
> +	phy_write(phydev, LEDCR, val);

I don't understand this driver too well, but should this be using
ext_read() and ext_write().

I'm also woundering if it would be good to implement the .read_page
and .write_page members in phy_driver and then use phy_write_paged()
and phy_write_paged() and phy_modify_paged(), which should do better
locking.

	Andrew

