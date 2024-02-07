Return-Path: <linux-kernel+bounces-56913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787A684D144
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D961F21F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEBF84051;
	Wed,  7 Feb 2024 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h4Th093X"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149847C6C3;
	Wed,  7 Feb 2024 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330960; cv=none; b=OKGicHvfMJIHGwlzWoq91G3TT1rTFqj8zDiApYPZvJ/UOqMOBhHFJQZvJcThDTNjFRwTsC1diwqsPkC8sdtust9v4LwxTC9nFy5LCmlPs0/ielcrTzL4hAhLCkqqlYSfXD7NNVos/tbbe45WaVNC5YYdAkbIBFmQMeGfqL1OY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330960; c=relaxed/simple;
	bh=lkNHQRx7cP8WxvbNAxHIS1vk/aCtQJ1xXsEBIup2hCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keC77M/P2fJqr65qmlgbzydPo391PE7nMDoee31eoc5kO9uxe0u2zo/1g3fu/EVxL0Cs5vIKbYFJaav5ZZxbss4DYYT6uBQg2Kdw7ZIf0Iev5eZzB3gpjrywVaHztVjb6pT5EWqpr18NN6zV0l4MeRGOb3b0WUeq+J/rUXkeAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h4Th093X; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wrpxBqwHncq3/AVtUlOf/t5NUVetBaPosLkRUy+KHIs=; b=h4Th093XM6VLykfkp2F8vMCesy
	1Xas2fUfEePdW//Ffhq96BxxA/TDgFw/sq3xC8+qWxOvqGoAVKUgh17R46xiVqfADRFVuUy9KMW/O
	TWJD04hPVF488TkYeMk/Mbpy0sT67qNhzx4VIvygCG4TqF7g1YfQHbwPbNHlF9RHSh4g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXmlv-007FAL-TR; Wed, 07 Feb 2024 19:35:47 +0100
Date: Wed, 7 Feb 2024 19:35:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, afd@ti.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de
Subject: Re: [PATCH v2 2/2] net: phy: dp83826: support TX data voltage tuning
Message-ID: <4dc382bd-3477-45cb-8044-fc5c2c7251f4@lunn.ch>
References: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
 <20240207175845.764775-2-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207175845.764775-2-catalin.popescu@leica-geosystems.com>

> +static int dp83826_config_init(struct phy_device *phydev)
> +{
> +	struct dp83822_private *dp83822 = phydev->priv;
> +	u16 val, mask;
> +	int ret;
> +
> +	if (dp83822->cfg_dac_minus != DP83826_CFG_DAC_MINUS_DEFAULT) {
> +		val = FIELD_PREP(DP83826_VOD_CFG1_MINUS_MDI_MASK, dp83822->cfg_dac_minus) |
> +		      FIELD_PREP(DP83826_VOD_CFG1_MINUS_MDIX_MASK,
> +				 FIELD_GET(DP83826_CFG_DAC_MINUS_MDIX_5_TO_4,
> +					   dp83822->cfg_dac_minus));
> +		mask = DP83826_VOD_CFG1_MINUS_MDIX_MASK | DP83826_VOD_CFG1_MINUS_MDI_MASK;
> +		ret = phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83826_VOD_CFG1, mask, val);
> +		if (ret)
> +			return ret;
> +
> +		val = FIELD_PREP(DP83826_VOD_CFG2_MINUS_MDIX_MASK,
> +				 FIELD_GET(DP83826_CFG_DAC_MINUS_MDIX_3_TO_0,
> +					   dp83822->cfg_dac_minus));
> +		mask = DP83826_VOD_CFG2_MINUS_MDIX_MASK;
> +		ret = phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83826_VOD_CFG2, mask, val);
> +		if (ret)
> +			return ret;
> +	}

I could be reading this wrong, but it looks like
DP83826_CFG_DAC_MINUS_DEFAULT actually means leave the value
unchanged? Is there anything guaranteeing it does in fact have the
default value in the hardware?

	Andrew

