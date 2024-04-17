Return-Path: <linux-kernel+bounces-149174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD2C8A8CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77AE2809E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8688F37703;
	Wed, 17 Apr 2024 20:13:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41339EC5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384796; cv=none; b=Dn7gedsEoam9neCLv695onC8Q1z5jX7/686DognewVjiO0jng7KKlaoBx8OqZszlfi1U+ZbMTrl5mBxsSCXSOfEzwIeRIQhItzdtxWOlmLxxnUIkiLWeZaMZX/1O56OWQ4MD3lx5+XRF2oF5ywYKJ9LabmjZD+G5Zy8DjjOHtv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384796; c=relaxed/simple;
	bh=apenWwIbFDlnjM9pc1bq24NpEQjHTQNVORIhcS46yek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaANVdtd/Yf5g9i4mED8hzD0lcyl1w8ZKrg27AVdUAR7JHcGVwmEvII5oTYEK4aOAww24ShvD1H+dtf/hsJll/S2FBYXSCEo/TWrZISaRGkjKTHXlyrEnrMj2FdDyeBX0xytZbt1U11pCiyXai51Ghe83au9eC9U524kdrkY/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rxBeJ-0002QQ-DG; Wed, 17 Apr 2024 22:12:55 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rxBeG-00Cqux-Hd; Wed, 17 Apr 2024 22:12:52 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rxBeG-00HZBU-1Q;
	Wed, 17 Apr 2024 22:12:52 +0200
Date: Wed, 17 Apr 2024 22:12:52 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <ZiAtREiqPuvXkB4S@pengutronix.de>
References: <20240417164316.1755299-1-o.rempel@pengutronix.de>
 <20240417164316.1755299-3-o.rempel@pengutronix.de>
 <c8e3f5d0-832b-4ab1-a65f-52f983ff110a@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8e3f5d0-832b-4ab1-a65f-52f983ff110a@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2024 at 08:39:54PM +0200, Andrew Lunn wrote:
> On Wed, Apr 17, 2024 at 06:43:14PM +0200, Oleksij Rempel wrote:
> > Set default PTP latency values to provide realistic path delay
> > measurements and reflecting internal PHY latency asymetry.
> > 
> > This values are based on ptp4l measurements for the path delay against
> > identical PHY as link partner and latency asymmetry extracted from
> > documented SOF Latency values of this PHY.
> > 
> > Documented SOF Latency values are:
> > TX 138ns/RX 430ns @ 1000Mbps
> > TX 140ns/RX 615ns @ 100Mbps (fixed latency mode)
> > TX 140ns/RX 488-524ns @ 100Mbps (variable latency mode)
> > TX 654ns/227-2577ns @ 10Mbps

Here is a typo 2277-2577ns

> Does Half Duplex vs Full Duplex make a difference here?

Yes, Half Duplex will be even less predictable. It would make no sense to
use it for the time sync.

> > +static int lan8841_ptp_latency_init(struct phy_device *phydev)
> > +{
> > +	int ret;
> > +
> > +	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> > +			    LAN8841_PTP_RX_LATENCY_10M,
> > +			    LAN8841_PTP_RX_LATENCY_10M_VAL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> > +			    LAN8841_PTP_TX_LATENCY_10M,
> > +			    LAN8841_PTP_TX_LATENCY_10M_VAL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> > +			    LAN8841_PTP_RX_LATENCY_100M,
> > +			    LAN8841_PTP_RX_LATENCY_100M_VAL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> > +			    LAN8841_PTP_TX_LATENCY_100M,
> > +			    LAN8841_PTP_TX_LATENCY_100M_VAL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> > +			    LAN8841_PTP_RX_LATENCY_1000M,
> > +			    LAN8841_PTP_RX_LATENCY_1000M_VAL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> > +			     LAN8841_PTP_TX_LATENCY_1000M,
> > +			     LAN8841_PTP_TX_LATENCY_1000M_VAL);
> > +}
> 
> What affect does this have on systems which have already applied
> adjustments in user space to correct for this? Will this cause
> regressions for such systems?

Yes.

> I know Richard has rejected changes like this in the past.

In this case I would need to extend the ethtool interface. The driver
should provide recommended values and the user space can optionally
read them and optionally write them to the HW.

Get Recommended TimeSync Data Path Delays
    Command Name: ETHTOOL_G_TS_DELAYS_RECOMMENDED
    Description: This command retrieves the recommended TimeSync data path
    delays for transmit and receive paths, typically based on the interface
    type and link speed. This values are not stable.

Get Currently Active TimeSync Data Path Delays
    Command Name: ETHTOOL_G_TS_DELAYS_ACTIVE
    Description: This command retrieves the currently active TimeSync data path
    delays that are being applied by the PHY. This is useful for real-time
    diagnostics and monitoring.

Set Currently Active TimeSync Data Path Delays
    Command Name: ETHTOOL_S_TS_DELAYS_ACTIVE
    Description: This command sets the currently active TimeSync data path
    delays. This would allow the system administrator or the network management
    system to manually adjust the TimeSync delays to either align them with the
    recommended values or to tweak them for specific network conditions or
    compliance requirements.

What do you think about this?

Should the delay value be bound to the link mode or only to the speed?

What if we have multiple components with delays? SoC/MAC specific delays,
interface converters RGMII to xMII, etc? Should the ethtool interface provide
summ of all delays in the chain, or we need to have access to each separately?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

