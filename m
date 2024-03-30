Return-Path: <linux-kernel+bounces-125750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D8A892BA1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EE2282C30
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D60383A1;
	Sat, 30 Mar 2024 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZjG4kDdv"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC981C0DD5;
	Sat, 30 Mar 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711810552; cv=none; b=kBPAq2GmPn5VEpxqE9LWkBpupDoU2I5UbhWf26TMrFoPNwwH2uvlpasFxVR8CCXDeQOALxh6gLAzC7jhC1Uq0amh9w/lqOcg4h2HIheOu8bzIkLlxoJqy34idxouaG5KLXiUCy5W2EFvpa12F6fMcch0y3I3arBy5e3d5KAROxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711810552; c=relaxed/simple;
	bh=Bu98VYPJpdmrwrEz8b1VMmazgKsb+agiRZbtiMnaTQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghCMwNSPOR3s2BmSONAE7n6buJC66KW+qWnzV7AuoEtLT5+16GWHm886qJ+MMtLKs6NMcBNx8AtLL8/HqA1bAy7TGrAQbQlRPKa1T5Kkr9i0vAMtyANfWfIuaFSYT+du2kiDGggJjSqjfMYZu56GiPdc1YwQOPHjVJmUlBg2CeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZjG4kDdv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i/6JfkfliaNMfwhDGWlvIXAGN6NTlYUrDkhzdTnQte4=; b=ZjG4kDdvIpKXA5GJPbn7sy969m
	ocfEnE7p6HBX6JZF80QePZXJGeRsYeDtNQ6eHpTkDmtfX8QkZ7B2K5AD071vJS/pZGiwyl9p47OU2
	Imq1mLdmDAs4/36hiFZXMWJbUpikGpAgMdZzi15kUkF3iBb8jcWDqA/Gnz7dOA5q0GqQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rqa7S-00Bj3E-0y; Sat, 30 Mar 2024 15:55:42 +0100
Date: Sat, 30 Mar 2024 15:55:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v1 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Message-ID: <4380faf1-9911-4188-9982-a7060e143394@lunn.ch>
References: <20240328160518.2396238-1-o.rempel@pengutronix.de>
 <20240328160518.2396238-6-o.rempel@pengutronix.de>
 <SJ2PR18MB56358EDD37EA961C7004CB27A23A2@SJ2PR18MB5635.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR18MB56358EDD37EA961C7004CB27A23A2@SJ2PR18MB5635.namprd18.prod.outlook.com>

On Fri, Mar 29, 2024 at 09:29:32AM +0000, Naveen Mamindlapalli wrote:
> 
> > +int ksz_init_global_dscp_map(struct ksz_device *dev) {
> > +	int reg, per_reg, ret, dscp;
> > +	u8 data = 0;
> > +	u8 mask;
> > +
> > +	/* On KSZ9xxx variants, DSCP remapping is disabled by default.
> > +	 * Enable to have, predictable and reproducible behavior across
> > +	 * different devices.
> > +	 */
> > +	if (!is_ksz8(dev)) {
> > +		ret = ksz_rmw8(dev, KSZ9477_REG_SW_MAC_TOS_CTRL,
> > +			       KSZ9477_SW_TOS_DSCP_REMAP,
> > +			       KSZ9477_SW_TOS_DSCP_REMAP);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ksz_get_dscp_prio_reg(dev, &reg, &per_reg, &mask);
> > +
> > +	for (dscp = 0; dscp < DSCP_MAX; dscp++) {
> > +		int ipv, shift;
> > +
> > +		/* Map DSCP to Traffic Type, which is corresponding to the
> > +		 * Internal Priority Value (IPV) in the switch.
> > +		 */
> > +		if (!is_ksz8(dev)) {
> > +			ipv = ietf_dscp_to_ieee8021q_tt(dscp);
> > +		} else {
> > +			ipv =
> > ieee8021q_tt_to_tc(ietf_dscp_to_ieee8021q_tt(dscp),
> > +						 dev->info->num_tx_queues);
> > +		}
> 
> No need for braces for single statement.

Please trim the email when replying. It is very easy to miss comments
when it is 99% quoted text with a couple of one-liners mixed in.

     Andrew

