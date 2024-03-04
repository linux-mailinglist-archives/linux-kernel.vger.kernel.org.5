Return-Path: <linux-kernel+bounces-90905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75898870692
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB651F21861
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE164C62E;
	Mon,  4 Mar 2024 16:07:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490204AED8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568447; cv=none; b=CJndC5CVib4c+ZvLXi7JPNazUIFk7297C3P/1fp9BcfyNuGEOrXqKyXDiifSWGUF7xJwiHRhvgG4nC7ClRLO7VciY6anAXA9B7Fg1ZrRkUzMQK54kFaWxNbKDlzTDZ74GBsO/Lhjp9ycy5/oi7t78164TAGtrINMYoKkbJWdR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568447; c=relaxed/simple;
	bh=uPaTZgs5cRzUd+YyEpm2IizZ7X5Rc5zf9/l+VMieE7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2nsvXu9jtQNwoPiX1s1x+4fULp7043na2RXFkHYUg5vUhav3gQIQ5FzaQLjh2+jjphx6VKjYVZnC7XO3SybBW7BanHpZ9XhHRELKI0Me6Ei2nAMmDv29Ya5iJ4NNTtGFMhI5EwdG4mmNbSamrVJwijr5w/bg8GpZAVq/Fk7JhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rhAqP-0000oU-RA; Mon, 04 Mar 2024 17:07:13 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rhAqN-004NoP-UA; Mon, 04 Mar 2024 17:07:11 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rhAqN-001wSs-2h;
	Mon, 04 Mar 2024 17:07:11 +0100
Date: Mon, 4 Mar 2024 17:07:11 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
	Woojung.Huh@microchip.com, pabeni@redhat.com, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v1 1/1] net: dsa: microchip: make sure drive strength
 configuration is not lost by soft reset
Message-ID: <ZeXxr1qZ0ZP4U--O@pengutronix.de>
References: <20240304135612.814404-1-o.rempel@pengutronix.de>
 <5a830dd5c253d12d719a5e979a1d43c5fb47e011.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a830dd5c253d12d719a5e979a1d43c5fb47e011.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Arun,

On Mon, Mar 04, 2024 at 02:25:54PM +0000, Arun.Ramadoss@microchip.com wrote:
> Hi Oleksij,
> 
> On Mon, 2024-03-04 at 14:56 +0100, Oleksij Rempel wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > This driver has two separate reset sequence in different places:
> > - gpio/HW reset on start of ksz_switch_register()
> > - SW reset on start of ksz_setup()
> > 
> > The second one will overwrite drive strength configuration made in
> > the
> > ksz_switch_register().
> > 
> > To fix it, move ksz_parse_drive_strength() from ksz_switch_register()
> > to
> > ksz_setup().
> > 
> > Fixes: d67d7247f641 ("net: dsa: microchip: Add drive strength
> > configuration")
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/net/dsa/microchip/ksz_common.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > b/drivers/net/dsa/microchip/ksz_common.c
> > index d58cc685478b1..83a5936506059 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.c
> > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > @@ -2260,6 +2260,8 @@ static int ksz_pirq_setup(struct ksz_device
> > *dev, u8 p)
> >         return ksz_irq_common_setup(dev, pirq);
> >  }
> > 
> > +static int ksz_parse_drive_strength(struct ksz_device *dev);
> > +
> 
> IMO: move the ksz_parse_drive_strength( ) here instead of prototype
> alone. Since the function is used in only one place and it will be
> logical to follow. 

I fully agree, but I fear this change would be too big for stable.

@Jakub, what is your preference?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

