Return-Path: <linux-kernel+bounces-136407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C1289D3BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28373B224FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD3D7E0F3;
	Tue,  9 Apr 2024 08:02:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9069DF4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649751; cv=none; b=jzURZZRISNLXQyaTE2HreKdFqzSwIkYeG1nI4gY/wwDvsV0BNnEhlzj9JFKUmicI3fj+223QF+jMpp8SNyVzfCUqofDlYePkyZOVqLiw3yk+GS5TjcwN/WtANnGTsKA4x0MFmcp7o5EhdYE3f2hyvQYAgvq8ls2+YMjuVXoZujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649751; c=relaxed/simple;
	bh=Ht+zLsqe77IM1iTP8cb68mcbeS237HYbrtzTXyf4W8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgHVA+zbzVSDKf/UCbjYJRZN1PRO5bKc1iabmBl+pE/nxCdJh2fDjNjn6vHvlD7YfRPqd7sXB+vSrqNPv2EY0fI4qhgv+Jc2+VJH2zMnYl7njIcMy9kB3z8/LyT2Pboy5+LYc6GC1b7ON/DzLOU5Ny44AaBTbOVqL8tUuQSBxzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ru6Qv-0002UM-UW; Tue, 09 Apr 2024 10:02:21 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1ru6Qu-00BGSs-45; Tue, 09 Apr 2024 10:02:20 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ru6Qu-004P6s-05;
	Tue, 09 Apr 2024 10:02:20 +0200
Date: Tue, 9 Apr 2024 10:02:20 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
	Woojung.Huh@microchip.com, pabeni@redhat.com, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, kernel@pengutronix.de,
	dsahern@kernel.org, san@skov.dk, willemb@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v4 6/9] net: dsa: microchip: dcb: add special
 handling for KSZ88X3 family
Message-ID: <ZhT2DEowBo4c46_I@pengutronix.de>
References: <20240408074758.1825674-1-o.rempel@pengutronix.de>
 <20240408074758.1825674-7-o.rempel@pengutronix.de>
 <7f0684fb1729dafc92f8b81ce81f10c91385c0c2.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f0684fb1729dafc92f8b81ce81f10c91385c0c2.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Arun,

On Mon, Apr 08, 2024 at 04:26:34PM +0000, Arun.Ramadoss@microchip.com wrote:
> Hi Oleksij,
> > + * Return: 0 on success, or a negative error code on failure
> > + */
> > +static int ksz88x3_port0_apptrust_quirk(struct ksz_device *dev, int
> > port,
> > +                                       int reg, u8 data)
> > +{
> > +       u8 port1_data;
> 
> why can't we have some common reference, because it is somewhat
> confusing. function name is port0, but apptrust config is for port1 and
> u8 port1_data. atleast instead of port1_data, port0_data, we can have
> variable name as data, since they are handled in two different
> functions. 

Ack, I renamed variables and functions to be more in sync with the
documentation and add defines for ports

Is it possible to add this erratum to the chip errata documentation?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

