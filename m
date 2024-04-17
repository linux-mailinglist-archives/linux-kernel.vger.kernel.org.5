Return-Path: <linux-kernel+bounces-149062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2892B8A8B41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91FA287B49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E07C200BA;
	Wed, 17 Apr 2024 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xA9iEd9u"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F318C1F;
	Wed, 17 Apr 2024 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379210; cv=none; b=p99M5lnOAD+iM+/roTFFxmlpuB4vjWiK2/ch9bXqqwnWZcJkaEYVC9Pif53l3pPQcNXHT5dKPzuaitrc2QerbXdqvJCDiSlMJ1tC/1G1GQaL+e9/VRe6chvC1PClG10leh+RcCNFbFtPXKoYGNMTJ9IOInJNsgPNjm2GLxLBBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379210; c=relaxed/simple;
	bh=spypHHCZDVm88N7JJvyzZpQKqPPwL6mqb4fe7v+1d/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgJDcewCO6COoNosfLbKOddm2sk/KohZsj0koeeo5AOsNO+u3i7xOB2FrXwMKa1jFzgmXEgTBgC7JoqDJZcABzA3FBZaYO7iDcB7JSAu0Uq1Gjej8ni8UzPhl/YOMVoaXF2W6M6I12JTX0H+fLK4yN/jNyC2bCykMefrHInuVSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xA9iEd9u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8Chgr1XzB7VSgqVHEHSg5NAelbYbuWSYpJpFWHYQKww=; b=xA9iEd9uSK1xlIdb5ceWhSY5LG
	6QyuyfGuXcUbPN6jWwUfai1cPpUETVoaxAQSAP4aLzeWyZ+LY+GTA5zHGziz29ZwNcfLOal5gYllU
	XnXYMEx7kq5w8oDMDrMS9DN2srLrGKB2ToOQQSk23DPI1dD7QCP+DmK/159KopQ/xjE4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxACI-00DH19-19; Wed, 17 Apr 2024 20:39:54 +0200
Date: Wed, 17 Apr 2024 20:39:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v1 2/4] net: phy: micrel: lan8841: set default
 PTP latency values
Message-ID: <c8e3f5d0-832b-4ab1-a65f-52f983ff110a@lunn.ch>
References: <20240417164316.1755299-1-o.rempel@pengutronix.de>
 <20240417164316.1755299-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417164316.1755299-3-o.rempel@pengutronix.de>

On Wed, Apr 17, 2024 at 06:43:14PM +0200, Oleksij Rempel wrote:
> Set default PTP latency values to provide realistic path delay
> measurements and reflecting internal PHY latency asymetry.
> 
> This values are based on ptp4l measurements for the path delay against
> identical PHY as link partner and latency asymmetry extracted from
> documented SOF Latency values of this PHY.
> 
> Documented SOF Latency values are:
> TX 138ns/RX 430ns @ 1000Mbps
> TX 140ns/RX 615ns @ 100Mbps (fixed latency mode)
> TX 140ns/RX 488-524ns @ 100Mbps (variable latency mode)
> TX 654ns/227-2577ns @ 10Mbps

Does Half Duplex vs Full Duplex make a difference here?

> +static int lan8841_ptp_latency_init(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> +			    LAN8841_PTP_RX_LATENCY_10M,
> +			    LAN8841_PTP_RX_LATENCY_10M_VAL);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> +			    LAN8841_PTP_TX_LATENCY_10M,
> +			    LAN8841_PTP_TX_LATENCY_10M_VAL);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> +			    LAN8841_PTP_RX_LATENCY_100M,
> +			    LAN8841_PTP_RX_LATENCY_100M_VAL);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> +			    LAN8841_PTP_TX_LATENCY_100M,
> +			    LAN8841_PTP_TX_LATENCY_100M_VAL);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> +			    LAN8841_PTP_RX_LATENCY_1000M,
> +			    LAN8841_PTP_RX_LATENCY_1000M_VAL);
> +	if (ret)
> +		return ret;
> +
> +	return phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> +			     LAN8841_PTP_TX_LATENCY_1000M,
> +			     LAN8841_PTP_TX_LATENCY_1000M_VAL);
> +}

What affect does this have on systems which have already applied
adjustments in user space to correct for this? Will this cause
regressions for such systems?

I know Richard has rejected changes like this in the past.

	Andrew

