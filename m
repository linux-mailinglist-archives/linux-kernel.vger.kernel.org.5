Return-Path: <linux-kernel+bounces-19741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA685827272
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766661F23635
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFBD4C3D6;
	Mon,  8 Jan 2024 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="USfx4zi6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86D4C3C8;
	Mon,  8 Jan 2024 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 63D5F1ABA94;
	Mon,  8 Jan 2024 16:12:42 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1704726762; bh=T5GyI4pZHaFZHAhkulFmwZFJg3xQW0QBAO0wRAeQ28g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=USfx4zi6oqdMofzUxQ/Inw8yxy1wDFQs3waZUpBETRNn00EV71suAAfAm+naH9mzf
	 reYcMTEEkgelI63XHhQjAcvWcS0HAdPLCkDYU/VxO8NOl8mAIsm3j0EJwyuLMvMMGP
	 VdBPlvTg1bKzLWrooPTmJdYqWbp8+4eBLJZoBS5b5W1eRU8mUoiVlGSoERdNxgDM8y
	 1HLUT2ew2czqCHuuCT1RlsgZLrZ2llTutn7C8YJ5HI3lb8+8G1nqES7JLJImHhO8vY
	 zynaYWbheQSQafSRMBJCpwbagkzWIydg+ZahmvqqCB2r9EZl+jUJv9eUL+ReMulBYX
	 GB6+1prgC/2+Q==
Date: Mon, 8 Jan 2024 16:12:41 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Laight <David.Laight@aculab.com>, Eric Dumazet
 <edumazet@google.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, "moderated
 list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:ARM/Allwinner sunXi SoC support"
 <linux-sunxi@lists.linux.dev>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH] net: stmmac: protect statistics updates with a spinlock
Message-ID: <20240108161241.625df103@meshulam.tesarici.cz>
In-Reply-To: <32c4095e-ec33-4059-a8d3-f85e18363c77@lunn.ch>
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
	<32c4095e-ec33-4059-a8d3-f85e18363c77@lunn.ch>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jan 2024 14:41:10 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > > You might want to consider per CPU statistics. Since each CPU has its
> > > own structure of statistics, you don't need atomic.
> > > 
> > > The code actually using the statistics then needs to sum up the per
> > > CPU statistics, and using syncp should be sufficient for that.  
> > 
> > Doesn't that consume rather a lot of memory on systems with
> > 'silly numbers' of cpu?  
> 
> Systems with silly number of CPUS tend to also have silly amounts of
> memory. We are talking about maybe a dozen u64 here. So the memory
> usage goes from 144 bytes, to 144K for a 1024CPU system.  Is 144K
> excessive for such a system?

I'm not even sure it's worth converting _all_ statistic counters to
per-CPU variables. Most of them are already guarded by a lock (either
the queue lock, or NAPI scheduling). Only the hard interrupt counter is
not protected by anything, so it's more like 8k on a 1024-CPU system....

> > Updating an atomic_t is (pretty much) the same as taking a lock.
> > unlock() is also likely to also contain an atomic operation.
> > So if you update more than two atomic_t it is likely that a lock
> > will be faster.  
> 
> True, but all those 1024 CPUs in your silly system get affected by a
> lock or an atomic. They all need to do something with there L1 and L2
> cache when using atomics. Spending an extra 144K of RAM means the
> other 1023 CPUs don't notice anything at all during the increment
> phase, which could be happening 1M times a second. They only get
> involved when something in user space wants the statistics, so maybe
> once per second from the SNMP agent.
> 
> Also, stmmac is not used on silly CPU systems. It used in embedded
> systems. I doubt its integrated into anything with more than 8 CPUs.

I also doubt it as of today, but hey, it seems that more CPU cores is
the future of embedded. Ten years ago, who would have imagined putting
an 8-core CPU into a smartphone? OTOH who would have imagined a
smartphone with 24G of RAM...

Petr T

