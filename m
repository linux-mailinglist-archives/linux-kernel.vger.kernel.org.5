Return-Path: <linux-kernel+bounces-85406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD2686B57A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9F11F28926
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7D23FBA0;
	Wed, 28 Feb 2024 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x6+4Vun1"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089F6EF11;
	Wed, 28 Feb 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139799; cv=none; b=bqtptrPgR1Z2r/tMen8p7f/2z3cPdcl62pI7souYvXzhhLEmaCmw5nLN2m1RwMwEoZ0lqRSykg6oNNALUO+XQTq7uhw1PeT9CgUMc0VLsBI1+qGL/N3CkL0AZMxE56MllCSxkr/xsXn6dBOAftjU1oscbJRnDJxlAbVVISHYY+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139799; c=relaxed/simple;
	bh=BYXJGv7dAgJecW7P0Y0TtC6QmvDjA9vPjNKxGnXoRto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv/rPD1Z4wEKz4w/KPjRscCAgw1PAvhEmd6vr32EckuapIlF8eG0lwMz0JUJtF4zAfOyNuFW8YgLV9H2RSJemxvifG7VnK+5iQ2pDxixkRsAsh0gNf9AGeasI7OTmXY3/uOIyG/lh8RAo6M438qhTWelAt89ZQYy7NXlrpPKjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x6+4Vun1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WZIwgafTAhhv1XNOq3h2R/R0NGX/4FdMgEriBHnaWc8=; b=x6+4Vun1Hd1wQAOSnoqkj2N3kJ
	Ub86h0jXx+yPPE6dM8BsY5ZC+87HNyKdToJuy7XA2gAhO1YE8gGuAFLXzu0OM60D6HEWDSfvWlhUa
	UF1LuhJPLeKxQCNClC+yN+UZucewwlCasgwBlHYR2eXPZ05zMyZ/HNc2Bk5sv6bJ2Ffk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfNKe-008y7o-6Z; Wed, 28 Feb 2024 18:03:00 +0100
Date: Wed, 28 Feb 2024 18:03:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Lukasz Majewski <lukma@denx.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: hsr: Provide RedBox support
Message-ID: <c3880444-3665-4a60-b6ec-f8ae8a9fbf8d@lunn.ch>
References: <20240228150735.3647892-1-lukma@denx.de>
 <20240228083115.01d4c93e@hermes.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228083115.01d4c93e@hermes.local>

On Wed, Feb 28, 2024 at 08:31:15AM -0800, Stephen Hemminger wrote:
> On Wed, 28 Feb 2024 16:07:35 +0100
> Lukasz Majewski <lukma@denx.de> wrote:
> 
> >  
> > +/* hsr_proxy_node_table_show - Formats and prints proxy node_table entries */
> > +static int
> > +hsr_proxy_node_table_show(struct seq_file *sfp, void *data)
> > +{
> > +	struct hsr_priv *priv = (struct hsr_priv *)sfp->private;
> > +	struct hsr_node *node;
> > +
> > +	seq_printf(sfp, "Proxy Node Table entries for HSR device\n");
> > +	seq_puts(sfp, "MAC-Address-SAN,        time_in\n");
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(node, &priv->proxy_node_db, mac_list) {
> > +		seq_printf(sfp, "%pM ", &node->macaddress_A[0]);
> > +		seq_printf(sfp, "%10lx\n", node->time_in[HSR_PT_INTERLINK]);
> > +	}
> > +	rcu_read_unlock();
> > +	return 0;
> > +}
> > +
> >  DEFINE_SHOW_ATTRIBUTE(hsr_node_table);
> > +DEFINE_SHOW_ATTRIBUTE(hsr_proxy_node_table);
> 
> NAK
> Do not abuse sysfs to be a debug proc style output.

This is actually debugfs, not sysfs.

However, i agree, we want information like this exported via netlink
as the primary interface to the end user. debugfs is not suitable for
that.

	 Andrew

