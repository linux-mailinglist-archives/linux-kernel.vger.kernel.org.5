Return-Path: <linux-kernel+bounces-154587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED588ADDFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5B71C217EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98F92C190;
	Tue, 23 Apr 2024 07:08:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2C1F505
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856092; cv=none; b=FG4l3jv7owjnFLsBOxgP4LdVCHpXNkgN4AAMxc8OBa0Xlm/oBv7kXnlkCzAjZ5ZeFZ3uZEXwVtdBOShomO/Lgn2UkOIt1i7tvyZtrKmjQdMuWnV+VCKUgG/fDzFjzD/oLJic/VuTLpPUfbCsHD49o0lkgmxTLA7crWEOaj+qI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856092; c=relaxed/simple;
	bh=LbZv+IFW0ABDVGbIyrN2XXjy2qr1emVrakdBmUuQ5Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM9zZVVyUblopzmqoztYlTq3Cc9PwxdsXYsRH0l2AVA/6jsyPb3o3DuijY9+36XN4oSYvqMLtWvls/6KnpWD+XD3lOzbk9sx8A90pMbtjwnS8zc0lRDzNRCFYFG2yWSFclUS4UnT15dkvZeSJ/lRqWLydwOfVXyHTOQ2+8sfl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rzAG2-0004PC-Fe; Tue, 23 Apr 2024 09:08:02 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rzAG0-00Dppn-33; Tue, 23 Apr 2024 09:08:00 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rzAFz-009lmk-3C;
	Tue, 23 Apr 2024 09:08:00 +0200
Date: Tue, 23 Apr 2024 09:07:59 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Russell King <linux@armlinux.org.uk>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v1 2/4] net: phy: micrel: lan8841: set default
 PTP latency values
Message-ID: <ZideTxpOcPTbR9yt@pengutronix.de>
References: <20240417164316.1755299-1-o.rempel@pengutronix.de>
 <20240417164316.1755299-3-o.rempel@pengutronix.de>
 <c8e3f5d0-832b-4ab1-a65f-52f983ff110a@lunn.ch>
 <ZiAtREiqPuvXkB4S@pengutronix.de>
 <b44a4aee-f76f-4472-9b5c-343a09ed0d33@lunn.ch>
 <ZiITWEZgTx9aPqIy@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZiITWEZgTx9aPqIy@hoboy.vegasvil.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Richard,

On Thu, Apr 18, 2024 at 11:46:48PM -0700, Richard Cochran wrote:
> On Wed, Apr 17, 2024 at 10:23:07PM +0200, Andrew Lunn wrote:
> > I suggest you go read older messages from Richard. It was a discussion
> > with Microchip about one of their PHYs.
> 
> My 2 cents:
> 
> User space has all of the hooks needed to configure corrections for a
> given setup.
> 
> Hard coding corrections in device drivers is bound to fail, based on
> prior experience with Vendors not knowing or caring how their products
> actually work.  Vendors will publish value X one year, then delete the
> info (to avoid embarrassment), then publish the new value Y, once
> customers have forgotten about X.
> 
> So, prudent users will always calibrate their beloved systems, not
> trusting the Vendors to provide anything close to reasonable.
> 
> Ergo, adding new magical correction in a kernel release causes
> regressions for prudent users.
> 
> But, in the end, that doesn't matter, because prudent users are used
> to being abused by well-meaning yet misguided device driver authors.
> 
> Prudent users are wise, and they will re-calibrate their systems
> before rolling out an updated kernel.

Ok, i see. Thank you for your feedback.

Are the recommended FOSS projects managing calibration values per-
linkmode/port/device in user space?

What is recommended way for calibration? Using some recommended device?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

