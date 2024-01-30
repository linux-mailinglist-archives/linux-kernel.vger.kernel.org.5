Return-Path: <linux-kernel+bounces-44553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F0842421
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D250286824
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A9679F4;
	Tue, 30 Jan 2024 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLd3MiRr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BCA679E4;
	Tue, 30 Jan 2024 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615552; cv=none; b=twrCa2Woe02fqTrpcNeEAore2k6/mAWhbGp8bs/e0o7CqcKMKgQeFJdUM3SkeW5WpSArhUHYiAMPTYBQOQONN8Vx5CaQDefXxahoKksPo39hxexemYpYcOPanot8xZfNVH+H2Xx+ewVw9J319iCt67Mwad2424cdgDIXUIN9ZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615552; c=relaxed/simple;
	bh=DMspNHe+PyuwZG/IydiW/Wdtvh3uR5JF2oe/i9uuk5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6veGF+Xb+q5G1IsBvw+qQndDBnTwhcIcQSBAKBAZkKar9JeyAo+YWe9guO+dvxSLwEbWelE3UlBiC4ewSn6ec7B55ncQ8Da9JPZGNdgvWzsJvfGJXo8RHMUS89RhGHTGMxc4n9Qz5x62tBAVpwzPhLBdSMd+Sr6HROk5v8Rrk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLd3MiRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD77C433F1;
	Tue, 30 Jan 2024 11:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706615551;
	bh=DMspNHe+PyuwZG/IydiW/Wdtvh3uR5JF2oe/i9uuk5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tLd3MiRrPCcMgjVjHBWZko6Az5rZSFR1TS04dBkF6SIlhgzavZ2stqYFKUjlYdcgz
	 CUm7cZDSLxFrXzePWm05avfoOHKiqK3DWlv/ZpMl4Fbk24sTIvCe9Ad7MmJZ7Huvvi
	 JK1VLQEXMckAltshWu+H0x/ncIpjIlmb5TTFb6OVzHS8xm9VPhnBxdPSJwFZ7kx29b
	 O4hDrkrHy1F2o3o8FdBROYbPGiljw4vd+CDssP8WvjexD/SSs6VTTDk/bMsGGQ/WhM
	 +yAfrdEE4Gke6UPP5de/5dsmvbanSxCQT9o+813w0EqxCvGItuM9kUDGYXnlZQog6a
	 j5Pwxm/sKwtkg==
Date: Tue, 30 Jan 2024 19:39:35 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
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
	Marc Haber <mh+netdev@zugschlus.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: protect updates of 64-bit statistics
 counters
Message-ID: <Zbjf9yQRV26EO7le@xhacker>
References: <20240128193529.24677-1-petr@tesarici.cz>
 <ZbiCWtY8ODrroHIq@xhacker>
 <20240130083539.4ea26a8d@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130083539.4ea26a8d@meshulam.tesarici.cz>

On Tue, Jan 30, 2024 at 08:35:39AM +0100, Petr Tesařík wrote:
> On Tue, 30 Jan 2024 13:00:10 +0800
> Jisheng Zhang <jszhang@kernel.org> wrote:
> 
> > On Sun, Jan 28, 2024 at 08:35:29PM +0100, Petr Tesarik wrote:
> > > As explained by a comment in <linux/u64_stats_sync.h>, write side of struct
> > > u64_stats_sync must ensure mutual exclusion, or one seqcount update could
> > > be lost on 32-bit platforms, thus blocking readers forever. Such lockups
> > > have been observed in real world after stmmac_xmit() on one CPU raced with
> > > stmmac_napi_poll_tx() on another CPU.
> > > 
> > > To fix the issue without introducing a new lock, split the statics into
> > > three parts:
> > > 
> > > 1. fields updated only under the tx queue lock,
> > > 2. fields updated only during NAPI poll,
> > > 3. fields updated only from interrupt context,
> > > 
> > > Updates to fields in the first two groups are already serialized through
> > > other locks. It is sufficient to split the existing struct u64_stats_sync
> > > so that each group has its own.
> > > 
> > > Note that tx_set_ic_bit is updated from both contexts. Split this counter
> > > so that each context gets its own, and calculate their sum to get the total
> > > value in stmmac_get_ethtool_stats().
> > > 
> > > For the third group, multiple interrupts may be processed by different CPUs
> > > at the same time, but interrupts on the same CPU will not nest. Move fields
> > > from this group to a newly created per-cpu struct stmmac_pcpu_stats.
> > > 
> > > Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where necessary")
> > > Link: https://lore.kernel.org/netdev/Za173PhviYg-1qIn@torres.zugschlus.de/t/
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Petr Tesarik <petr@tesarici.cz>  
> > 
> > Thanks for the fix patch. One trivial improviement below
> > s/netdev_alloc_pcpu_stats/devm_netdev_alloc_pcpu_stats to simplify
> > error and exit code path.
> 
> Thanks for your review.
> 
> In fact, many other allocations in stmmac could be converted to devm_*.
> I wanted to stay consistent with the existing code, but hey, you're

there's already devm_* usage in stmmac_dvr_probe(), eg. devm_alloc_etherdev_mqs
I believe other parts are from the old days when there's no devm_* APIs

> right there's no good reason for it.
> 
> Plus, I can send convert the other places with another patch.
> 
> > With that:
> > Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> > 
> > PS: when I sent the above "net: stmmac: use per-queue 64 bit statistics
> > where necessary", I had an impression: there are too much statistics in
> > stmmac driver, I didn't see so many statistics in other eth drivers, is
> > it possible to remove some useless or not that useful statistic members?
> 
> I don't feel authorized to make the decision. But I also wonder about
> some counters. For example, why is there tx_packets and tx_pkt_n? The
> former is shown as RX packets by "ip stats show dev end0", the latter
> is shown by as tx_pkt_n by "ethtools -S end0". The values do differ,
> but I have no clue why, and if they are even expected to be different
> or if it's a bug.
> 
> Petr T

