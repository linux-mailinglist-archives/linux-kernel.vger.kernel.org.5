Return-Path: <linux-kernel+bounces-127476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1B0894C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC29C2838BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695933B182;
	Tue,  2 Apr 2024 07:09:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E863BBC2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041791; cv=none; b=UKDyi2v7PhHRllxk/I/OjKaU98DGFiCTHAnXUsXgAJ/15H+0F3VHdU7dDwIB4n21fkXvPu+EEKvpk4sZGCTdXYfzDUADsZrSQuF3JzvOQ3uiiQpwwCYinU/tDisCriy2ZIbcgE5hy0M+/7SZznOolJXGvfbQBzXqYnsG5EY2lzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041791; c=relaxed/simple;
	bh=rXyFgSFt0I1uwtFJWy6dBP2dVw6hwZmEtb3B8gGjNXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP0j/qg22kDRa64lNo/jLv2swrrTpTxlC+WaA+rwTMw5J/PTY5PYjyP4ySZL/N30cYEVNHwso9jOZFunG24zLI7U9pURP1rfiH9v+6LBz4h8RRdyKJIktdzUMVPg6uYp1NnElB06qWPbYsANDkTIh49eniJWX4EcqNdfF8ZxQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rrYHA-0004uI-OR; Tue, 02 Apr 2024 09:09:44 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rrYHA-009w6e-6m; Tue, 02 Apr 2024 09:09:44 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rrYHA-00AjCq-0M;
	Tue, 02 Apr 2024 09:09:44 +0200
Date: Tue, 2 Apr 2024 09:09:44 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
	Woojung.Huh@microchip.com, pabeni@redhat.com, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, kernel@pengutronix.de,
	dsahern@kernel.org, san@skov.dk, willemb@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 8/9] net: dsa: microchip: init predictable
 IPV to queue mapping for all non KSZ8xxx variants
Message-ID: <ZguvOF6czMQg4iaF@pengutronix.de>
References: <20240328160518.2396238-1-o.rempel@pengutronix.de>
 <20240328160518.2396238-9-o.rempel@pengutronix.de>
 <0331845071e66b8f8f725100f6a138215b77f0a7.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0331845071e66b8f8f725100f6a138215b77f0a7.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Arun,

On Tue, Apr 02, 2024 at 04:07:30AM +0000, Arun.Ramadoss@microchip.com wrote:
> Hi Oleksij,
> 
> On Thu, 2024-03-28 at 17:05 +0100, Oleksij Rempel wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > Init priority to queue mapping in the way as it shown in IEEE 802.1Q
> > mapping example.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/net/dsa/microchip/ksz_common.c | 53 ++++++++++++++--------
> > ----
> >  1 file changed, 29 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > b/drivers/net/dsa/microchip/ksz_common.c
> > index 08426f85f7707..78e9610044ea8 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.c
> > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/of_net.h>
> >  #include <linux/micrel_phy.h>
> >  #include <net/dsa.h>
> > +#include <net/ieee8021q.h>
> >  #include <net/pkt_cls.h>
> >  #include <net/switchdev.h>
> > 
> > @@ -2692,9 +2693,29 @@ static int ksz_port_mdb_del(struct dsa_switch
> > *ds, int port,
> >         return dev->dev_ops->mdb_del(dev, port, mdb, db);
> >  }
> > 
> > +static int ksz_set_default_prio_queue_mapping(struct ksz_device
> > *dev, int port)
> 
> Since this function is related to KSZ9477 series switch, do we need to
> move this function out of ksz_common.c or function name prefixed with
> ksz9477_set_default_prio_queue_mapping to differentiate it. 

Ack. Sounds good, will update it.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

