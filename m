Return-Path: <linux-kernel+bounces-134796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A2A89B709
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A21B21302
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35BA79D8;
	Mon,  8 Apr 2024 05:00:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706B6AAD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712552452; cv=none; b=gcpsJ3gBfkPbTMaaFo1WjMXAx+VCa2gAOfdZDaUoDyGYO60OYdTWx0Y1iisjrcqN535eGyf5yZV9yUkulAa8U23LXkRU3ITk0I/vJjfm58Ge2BYn0hAzPizKggmGxrYwTVF6+2AQd3bYKBfT0slJ+oQwrlpg/9MDpWNv2QNvxik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712552452; c=relaxed/simple;
	bh=Lx1V6M0BioLigvCbQ2iqx57L9H4L/71UdUoauDEbTf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaKJLYzQDuI5603RiVCIpHEHs/I5Ij1ZMISKMC2nAWeKLzmaBVFn/gVW7Ci3r1uIEn3tWQuEW78D+y0Pin7sqi+NsxHglcpI4ILalFrhkim/DL19TWZATz70Dk+U4Mys0BBc5S9iESxvLhNnHyJvBKuLLUeKv9AXPJgZC/ZGnNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rth7a-0007AY-Hh; Mon, 08 Apr 2024 07:00:42 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rth7X-00B2qd-9t; Mon, 08 Apr 2024 07:00:39 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rth7X-002iiJ-0d;
	Mon, 08 Apr 2024 07:00:39 +0200
Date: Mon, 8 Apr 2024 07:00:39 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
	Woojung.Huh@microchip.com, pabeni@redhat.com, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, kernel@pengutronix.de,
	dsahern@kernel.org, san@skov.dk, willemb@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v3 8/9] net: dsa: microchip: init predictable
 IPV to queue mapping for all non KSZ8xxx variants
Message-ID: <ZhN5923xUnC3LI0M@pengutronix.de>
References: <20240405095216.353829-1-o.rempel@pengutronix.de>
 <20240405095216.353829-9-o.rempel@pengutronix.de>
 <39a736262d87b06ad65e67753c440a1d489c8f8c.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39a736262d87b06ad65e67753c440a1d489c8f8c.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Arun,

On Mon, Apr 08, 2024 at 03:41:46AM +0000, Arun.Ramadoss@microchip.com wrote:
> Hi Oleksij,
> 
> > +static int ksz9477_set_default_prio_queue_mapping(struct ksz_device
> > *dev,
> > +                                                 int port)
> > +{
> > +       u32 queue_map = 0;
> > +       int ipv;
> 
> Just a suggestion for readability: if you can use common variable for
> counter variable like cnt or n similar to return variable ret, it will
> be easier to follow instead of ipv here, queue in other function. 

Sorry, I disagree here. Variable name should describe the purpose of it,
especially if things got complicated. If other function uses "queue" as
variable name but actually ipv is the meaning of it, then it should be
renamed.

> > +
> > +       for (ipv = 0; ipv < dev->info->num_ipvs; ipv++) {
> > +               int queue;
> > +
> > +               /* Traffic Type (TT) is corresponding to the Internal
> > Priority
> > +                * Value (IPV) in the switch. Traffic Class (TC) is
> > +                * corresponding to the queue in the switch.
> > +                */
> > +               queue = ieee8021q_tt_to_tc(ipv, dev->info-
> > >num_tx_queues);
> > +               if (queue < 0)
> > +                       return queue;
> 
> what happens if the num_tx_queues value passed is other than 1 to 8.
> For ex: if it is 9, then ieee8021q_tt_to_tc( ) generates pr_warn as
> invalid number of queue and return queue as 0. if will not execute, so
> queue_map will be updated. Do we need check for valid range of values
> instead of just queue < 0. 
> 
> Not sure this scenario can occur.  

Good point, I should fix ieee8021q_tt_to_tc(), it should return -EINVAL
instead.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

