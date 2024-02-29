Return-Path: <linux-kernel+bounces-86886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE12586CC42
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2231F237ED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1E7137C41;
	Thu, 29 Feb 2024 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SNg+/umZ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407182860;
	Thu, 29 Feb 2024 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218785; cv=none; b=JdKVeEL85j+Ssey9AFaGFyFCduk0asXmZOeCRJfAAU4gqpqXZSBQAzql9ft65OokOd3fclFSWOHg1vshHZE22v20/geK3zXdreaXu3k2NRi/+c0tsIpVQgzEbzmHBT7ddc6B/5M1A50VKV3ev+CKxIEp3GNc0EqxLedyujsBF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218785; c=relaxed/simple;
	bh=K+5tBSC4Xcoa5sB1xPKFfLn4Z11QAga8+1gmTV6Y9xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cToAlNEky/r/XgrkEC/w3lO4r9Io+xikhXnYbYLM2vUJBsk+l7q65owGHapbXOTM07dn/6diJmr08mVKVWf2Baj7j4A22pgWXnQM4MabHRXg24EgPoKw3FMb/d1DK9gHnWGlN/CpaGvv97h1K/Ywc+rrxXY4PMXJTdVsqJyBcjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SNg+/umZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vBT+bWqpdoEnAANUaHRk4UvSWJZiuneIDAe2zHQnLmo=; b=SNg+/umZiNdf0R/XwdM/kEf0jq
	LhpcrAla86DEKiFumE4Hx3NPldLipR42eH9p5CAa3SBeE9TuhvH96ctdeLI+DHrBeu6zUD4dnIWWW
	rIVt9i/irqzU+4EycX0UKcGZz5+QAqWQxw7nZn6qUu2hBbmGVjyKBaBLPJFf1uwJmdEQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfhsc-00936k-7A; Thu, 29 Feb 2024 15:59:26 +0100
Date: Thu, 29 Feb 2024 15:59:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
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
Message-ID: <399bf6c2-c9be-4f41-8df5-8d9655e34003@lunn.ch>
References: <20240228150735.3647892-1-lukma@denx.de>
 <20240228083115.01d4c93e@hermes.local>
 <c3880444-3665-4a60-b6ec-f8ae8a9fbf8d@lunn.ch>
 <20240229102557.615c02f3@wsk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229102557.615c02f3@wsk>

On Thu, Feb 29, 2024 at 10:25:57AM +0100, Lukasz Majewski wrote:
> Hi Andrew,
> 
> > On Wed, Feb 28, 2024 at 08:31:15AM -0800, Stephen Hemminger wrote:
> > > On Wed, 28 Feb 2024 16:07:35 +0100
> > > Lukasz Majewski <lukma@denx.de> wrote:
> > >   
> > > >  
> > > > +/* hsr_proxy_node_table_show - Formats and prints proxy
> > > > node_table entries */ +static int
> > > > +hsr_proxy_node_table_show(struct seq_file *sfp, void *data)
> > > > +{
> > > > +	struct hsr_priv *priv = (struct hsr_priv *)sfp->private;
> > > > +	struct hsr_node *node;
> > > > +
> > > > +	seq_printf(sfp, "Proxy Node Table entries for HSR
> > > > device\n");
> > > > +	seq_puts(sfp, "MAC-Address-SAN,        time_in\n");
> > > > +	rcu_read_lock();
> > > > +	list_for_each_entry_rcu(node, &priv->proxy_node_db,
> > > > mac_list) {
> > > > +		seq_printf(sfp, "%pM ", &node->macaddress_A[0]);
> > > > +		seq_printf(sfp, "%10lx\n",
> > > > node->time_in[HSR_PT_INTERLINK]);
> > > > +	}
> > > > +	rcu_read_unlock();
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  DEFINE_SHOW_ATTRIBUTE(hsr_node_table);
> > > > +DEFINE_SHOW_ATTRIBUTE(hsr_proxy_node_table);  
> > > 
> > > NAK
> > > Do not abuse sysfs to be a debug proc style output.  
> > 
> > This is actually debugfs, not sysfs.
> > 
> > However, i agree, we want information like this exported via netlink
> > as the primary interface to the end user. debugfs is not suitable for
> > that.
> 
> Am I correct, that recommended approach would be to:
> 
> 1. Modify iproute2 to support for example:
> 
> ip addr show dev hsr1 nodes {proxy} ?

Something like that. iproute2 is more than the ip command. There is
also bridge, dcb, vdpa, etc. So you need to decide where it fits best.
Maybe as part of bridge? Or even a command of its own.

> 2. Shall the currently exported:
> 
> /sys/kernel/debug/hsr/hsrX/node_table be left as it is (for legacy
> usage) or shall it be removed and replaced with netlink and iproute2 ?

There is no legacy usage. debugfs is unstable, it is not KAPI. Nothing
is expected to use it, because it could disappear at any time, its
format can change, etc. For a long time, debugfs was not liked in
networking, because it was abused and tools built on top of it, often
vendor tools. We much prefer well defined interfaces such as
netlink. But it seems like things are becoming a little bit more
loose. If you have a well defined netlink API making debugfs
pointless, you can probably keep the debugfs code :-) But you can also
remove it.

	   Andrew

