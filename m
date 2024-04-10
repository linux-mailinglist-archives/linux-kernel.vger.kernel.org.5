Return-Path: <linux-kernel+bounces-138955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F003589FC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F7E1F21CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189D117967E;
	Wed, 10 Apr 2024 16:11:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8297179668
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765495; cv=none; b=Ufkv/1+L1NX+KHeGuaMyYu18G89gdxau74zM3GkDTC0n1N5IqTjJKvJxKz7ra7XA3GQpshZXLYAht8db5BnvlEhYagAIfRxf3rf8lQRc+HECvGEzYBJ2RcstR4LPGgkKKyalz93voBspffOuqVmmNf9ZPLoBkYJooUs3kVDQIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765495; c=relaxed/simple;
	bh=Brha+pzHRoTDzGvY8i5/hWAwyVOrjvBDcmO3xAizNl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8NZ2ShPxIm6GQ9LV65IsTDrGyD1QCWf9Uj1hHdx/NBi8kVTmnGLk503N1L3E3h0Bf+r/IvexjurAoftZpXDc5Sz3DqFkdmlAGEKVhFpbYE3o7N2p2eOjf5a3gVUQPisaQW2zjqlmFDnDa6gArMvP8hC0476rFLhdNVCWDmfjuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ruaXn-0006DP-HG; Wed, 10 Apr 2024 18:11:27 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1ruaXl-00BWip-Vm; Wed, 10 Apr 2024 18:11:25 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ruaXl-0068ZL-2q;
	Wed, 10 Apr 2024 18:11:25 +0200
Date: Wed, 10 Apr 2024 18:11:25 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v6 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Message-ID: <Zha6Lf72N8fc0Ju1@pengutronix.de>
References: <20240410080556.1241048-1-o.rempel@pengutronix.de>
 <20240410080556.1241048-6-o.rempel@pengutronix.de>
 <20240410153236.d3ncotfhzwv4dlb7@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410153236.d3ncotfhzwv4dlb7@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2024 at 06:32:36PM +0300, Vladimir Oltean wrote:
> On Wed, Apr 10, 2024 at 10:05:52AM +0200, Oleksij Rempel wrote:
> > diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
> > new file mode 100644
> > index 0000000000000..d2122f844c80b
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/ksz_dcb.c
> > +/**
> > + * ksz_supported_apptrust[] - Supported apptrust selectors and Priority Order
> > + *			      of Internal Priority Value (IPV) sources.
> > + *
> > + * This array defines the apptrust selectors supported by the hardware, where
> > + * the index within the array indicates the priority of the selector - lower
> > + * indices correspond to higher priority. This fixed priority scheme is due to
> > + * the hardware's design, which does not support configurable priority among
> > + * different priority sources.
> > + *
> > + * The priority sources, including Tail Tag, ACL, VLAN PCP and DSCP are ordered
> > + * by the hardware's fixed logic, as detailed below. The order reflects a
> > + * non-configurable precedence where certain types of priority information
> > + * override others:
> > + *
> > + * 1. Tail Tag - Highest priority, overrides ACL, VLAN PCP, and DSCP priorities.
> > + * 2. ACL - Overrides VLAN PCP and DSCP priorities.
> > + * 3. VLAN PCP - Overrides DSCP priority.
> > + * 4. DSCP - Lowest priority, does not override any other priority source.
> > + *
> > + * In this context, the array's lower index (higher priority) for
> > + * 'DCB_APP_SEL_PCP' suggests its relative priority over
> > + * 'IEEE_8021QAZ_APP_SEL_DSCP' within the system's fixed priority scheme.
> > + *
> > + * DCB_APP_SEL_PCP - Priority Code Point selector
> > + * IEEE_8021QAZ_APP_SEL_DSCP - Differentiated Services Code Point selector
> > + */
> > +static const u8 ksz_supported_apptrust[] = {
> > +	DCB_APP_SEL_PCP,
> > +	IEEE_8021QAZ_APP_SEL_DSCP,
> > +};
> 
> I've no idea how kernel-doc is supposed to document arrays. But this
> generates a scripts/kernel-doc warning:
> 
>   CHECK   ../drivers/net/dsa/microchip/ksz_dcb.c
> ./drivers/net/dsa/microchip/ksz_dcb.c:81: warning: cannot understand function prototype: 'const u8 ksz_supported_apptrust[] = '
> 
> Worst case, it doesn't need to be a kernel-doc?

I can remove the part which makes this comment a kenrel doc.

Are there other issues for this patch? Can it get your Reviewed-by if
fixed?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

