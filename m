Return-Path: <linux-kernel+bounces-19633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FEC827013
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362D12840AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977DC45943;
	Mon,  8 Jan 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g/89ezCx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A145948;
	Mon,  8 Jan 2024 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eG9T8lTouYuHP4iTNggEDal9BKSEaIu9o9UHqgV4zmU=; b=g/89ezCx8XKj8W9WmBVIIO1o2v
	Xrhg/GZiVeJL8+zT0PrmSbue3YHm45GvMqN34rXMHhRVjLn5ggcS5uLitaN9K3ZBf9LvpoTlX3G2l
	f1q+wmn+Iq76ScsWq6Apwf8I0AEZUWJTBs5u7YApblPFDXs5zD4uka8lxEKjQ+BwNpwc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rMpsM-004dvG-Sa; Mon, 08 Jan 2024 14:41:10 +0100
Date: Mon, 8 Jan 2024 14:41:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Laight <David.Laight@aculab.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Eric Dumazet <edumazet@google.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH] net: stmmac: protect statistics updates with a spinlock
Message-ID: <32c4095e-ec33-4059-a8d3-f85e18363c77@lunn.ch>
References: <CANn89iLuYZBersxq4aH-9Fg_ojD0fh=0xtdLbRdbMrup=nvrkA@mail.gmail.com>
 <20240105113402.0f5f1232@meshulam.tesarici.cz>
 <CANn89iLEvW9ZS=+WPETPC=mKRyu9AKmueGCWZZOrz9oX3Xef=g@mail.gmail.com>
 <20240105121447.11ae80d1@meshulam.tesarici.cz>
 <20240105142732.1903bc70@meshulam.tesarici.cz>
 <CANn89iLHLvGFX_JEYU-en0ZoCUpTvjXPBzFECxLFfa_Jhpcjmg@mail.gmail.com>
 <CANn89iKWSemsKmfsLjupwWBnyeKjtHH+mZjTzYiJT4G=xyUrNQ@mail.gmail.com>
 <20240105154558.2ca38aca@meshulam.tesarici.cz>
 <a8bb0eb0-8398-4e7e-8dc5-6ebf2f981ca8@lunn.ch>
 <d05ca29283eb47df9c58838cb87a887c@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d05ca29283eb47df9c58838cb87a887c@AcuMS.aculab.com>

> > You might want to consider per CPU statistics. Since each CPU has its
> > own structure of statistics, you don't need atomic.
> > 
> > The code actually using the statistics then needs to sum up the per
> > CPU statistics, and using syncp should be sufficient for that.
> 
> Doesn't that consume rather a lot of memory on systems with
> 'silly numbers' of cpu?

Systems with silly number of CPUS tend to also have silly amounts of
memory. We are talking about maybe a dozen u64 here. So the memory
usage goes from 144 bytes, to 144K for a 1024CPU system.  Is 144K
excessive for such a system?

> Updating an atomic_t is (pretty much) the same as taking a lock.
> unlock() is also likely to also contain an atomic operation.
> So if you update more than two atomic_t it is likely that a lock
> will be faster.

True, but all those 1024 CPUs in your silly system get affected by a
lock or an atomic. They all need to do something with there L1 and L2
cache when using atomics. Spending an extra 144K of RAM means the
other 1023 CPUs don't notice anything at all during the increment
phase, which could be happening 1M times a second. They only get
involved when something in user space wants the statistics, so maybe
once per second from the SNMP agent.

Also, stmmac is not used on silly CPU systems. It used in embedded
systems. I doubt its integrated into anything with more than 8 CPUs.

       Andrew

