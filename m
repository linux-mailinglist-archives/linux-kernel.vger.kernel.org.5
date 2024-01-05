Return-Path: <linux-kernel+bounces-18202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D94E8259FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423551C231FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD91135883;
	Fri,  5 Jan 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="5b28g5td"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C734CFE;
	Fri,  5 Jan 2024 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 889101A8358;
	Fri,  5 Jan 2024 19:21:50 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1704478910; bh=Zd/QIL3RU/XZlGubxDcUGduBTA9ghSJPnexMb7uMPkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=5b28g5tdhYjmeIVp67lsuAzXWN+OZvbWOUDS7fBOBp5SLPuoLblTJISHX7SrLtL5q
	 XRobKJwIkizfH3xueEeo8vNaA5HwHgqjP9kWVH16WNSvkEljfSNriF5HnJ/Pqjhr1W
	 4CABjaJKCKTd6gFGK60cqLQwor08KNCLel8qSP7f1IIHOvcgiiWVmUz9v9tBjvfK2p
	 J9U2K1LFoWOihDAEKmaMzPzHZJ3UQ3R1ZiXJHusDgCS7p29yJntBsLQ21sSnODROwv
	 FaqispTRFj6Hz/X2jkuH1VUMylgCEp5vGT8cAB244sqLFFdrA9HtpKHmjLo7MCyRH3
	 +xJah2vi/Q53w==
Date: Fri, 5 Jan 2024 19:21:48 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, "open list:STMMAC ETHERNET DRIVER"
 <netdev@vger.kernel.org>, "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>, "moderated list:ARM/STM32
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:ARM/Allwinner sunXi SoC support"
 <linux-sunxi@lists.linux.dev>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH] net: stmmac: protect statistics updates with a spinlock
Message-ID: <20240105192148.0accd8f2@meshulam.tesarici.cz>
In-Reply-To: <a8bb0eb0-8398-4e7e-8dc5-6ebf2f981ca8@lunn.ch>
References: <20240105091556.15516-1-petr@tesarici.cz>
	<CANn89iLuYZBersxq4aH-9Fg_ojD0fh=0xtdLbRdbMrup=nvrkA@mail.gmail.com>
	<20240105113402.0f5f1232@meshulam.tesarici.cz>
	<CANn89iLEvW9ZS=+WPETPC=mKRyu9AKmueGCWZZOrz9oX3Xef=g@mail.gmail.com>
	<20240105121447.11ae80d1@meshulam.tesarici.cz>
	<20240105142732.1903bc70@meshulam.tesarici.cz>
	<CANn89iLHLvGFX_JEYU-en0ZoCUpTvjXPBzFECxLFfa_Jhpcjmg@mail.gmail.com>
	<CANn89iKWSemsKmfsLjupwWBnyeKjtHH+mZjTzYiJT4G=xyUrNQ@mail.gmail.com>
	<20240105154558.2ca38aca@meshulam.tesarici.cz>
	<a8bb0eb0-8398-4e7e-8dc5-6ebf2f981ca8@lunn.ch>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jan 2024 18:36:45 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > This only leaves an atomic_t in hard irq context. I have tried to find
> > something that could relax the requirement, but AFAICS at least some
> > setups use several interrupts that can be delivered to different CPUs
> > simultaneously, and all of them will walk over all channels. So we're
> > left with an atomic_t here.  
> 
> You might want to consider per CPU statistics. Since each CPU has its
> own structure of statistics, you don't need atomic.
> 
> The code actually using the statistics then needs to sum up the per
> CPU statistics, and using syncp should be sufficient for that.

Thanks for the tip.

Honestly, the more I'm looking into this, the less I am convinced that
it is worth the effort, but yeah, if we touch this code now, let's do
things properly. ;-)

> Maybe look at mvneta.c for inspiration.

I think I know what you mean, but I'll have a look.

Petr T

