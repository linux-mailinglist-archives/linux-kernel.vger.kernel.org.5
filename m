Return-Path: <linux-kernel+bounces-46697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 538988442D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E690D1F27276
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EE284A5A;
	Wed, 31 Jan 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="onpjRWH+"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950955A7A1;
	Wed, 31 Jan 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714237; cv=none; b=T31uDpNzTWT3L/zW3eWwXfIwAiHrnod8E1D4vgs6kL1wmcyqDapOHFc0ctzE1sQU9+U/Wv3wXMQnuHEE5kO4BABhazKRr+88nsqZGuLA2p5cttJdPw2Qg82CIzN4aixU0u7IRl3TVDWL7fIzaOu1v3vgiyafnxanCDqK8kb+IPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714237; c=relaxed/simple;
	bh=hFGYNYSwKpaPbXeOXJB0apsWaOTWlpNeqIOPl+Y7Dds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQiedav+eJlhRlkbDPBDP7ng0LkpjyN7FXnYT2RM6XjqY7g6Ji4+5JFEZMWY4duWy6HVav4euymKEAaw75b63+zJcs4ahBtvrxQTz26N+cdIcbDcqF6THji9zLPQbxf8KIXO1Qao9rELx9I/TeNPkl/hPeeJKlKAPBu0uTxPmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=onpjRWH+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jgq0nqHL6hJy8i/S2yhh41C+vCOE2itOZ8xdJIlt13k=; b=onpjRWH+4TyRswys1smojkLyIW
	LGzMq2HZsiV88wa4/8WH6l+vpZxonQPmORWtIJZsfpK3SOvRZ5M1K9XLHyMNoLrDo+5AjYlbWbHXP
	zF5UH3+0JC0bgexAQCDjzXUoxyPct1v9pz0SaQXwefirPGHfAtKT+EaAzmpfp4sybtak=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVCKo-006aoK-E3; Wed, 31 Jan 2024 16:17:06 +0100
Date: Wed, 31 Jan 2024 16:17:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Message-ID: <65071184-428b-4850-9e0c-baaa73513c6d@lunn.ch>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122212848.3645785-9-dima.fedrau@gmail.com>

> +static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct device *hwmon;
> +	char *hwmon_name;
> +	int ret;
> +
> +	/* Enable temperature sensor interrupt */
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
> +			       MDIO_MMD_PCS_MV_TEMP_SENSOR1,
> +			       MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT_EN);

You enable an interrupt, but i don't see any changes to the interrupt
handler to handle any interrupts which are generated?

	Andrew

