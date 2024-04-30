Return-Path: <linux-kernel+bounces-164581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCAE8B7FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D8C1C236E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432EF1836EE;
	Tue, 30 Apr 2024 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoKFBS0o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B71180A92;
	Tue, 30 Apr 2024 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501308; cv=none; b=r7c9RjhalFkgUXUbCSY0lGz2DYggp6p3GpMEK798vv/xWhu2TACtxCe+KSynDKlU6024ClnJkILrWIMZLS+mh9rSn2JeHGKmvnOOkD/zPdj16pjdWcSKnIxkM62wWV2T+9qguj1D2Q6RBRsCV5R4Hwb0nKcL2YzKOosCDy4WG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501308; c=relaxed/simple;
	bh=e8R5pNN2IsLACAwBDVyNGSn3zTMo3zNZ2dNsVU58FAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAcdDQO3/Qs+TmZC7bXbHXt9LVViMtGkijQO8IiHRU8sn0+AEn0RDtzBnzhjAPpPzkjEkwfgDLOe6LKAHBKUQlzfA41FR3hnX5co3MMdn2if3wHKjLwLLs85rvirexGZVn5AnUAm/6NgQQ26Z0LyTF2YdAexuhZE9UzAf/zs7Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoKFBS0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8DEC2BBFC;
	Tue, 30 Apr 2024 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714501308;
	bh=e8R5pNN2IsLACAwBDVyNGSn3zTMo3zNZ2dNsVU58FAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uoKFBS0oWnJcn5AdrjfuWyIkjg2MAAkA4VXWGlkuJpeO3isRw7tzGSQCr8k0jK/s/
	 j51yGThqNL/UTuSjLfQuERbZIA6/RR462aK9UR49PvH14iimEeBtauE97B+Rn144tA
	 EAiYurlFqXopiuoOtIr/WqoIvx6xgAlvAwyXQMZ2KQ28kmbdzS+VpG+/c8D16SA84U
	 Phw2RgTDYvjJWtggVTwYSUYuxKUtKuhAez8zUnAGm04qEp1b2tbX8zNIhvFkprsKnP
	 I6ZydNCTiPdlowBbxVR8j0AXv5ugZVa2/YciVsAusdd5mKFFpEbFm/y0TZt//24ZDs
	 1tNh0FQNdrhDQ==
Date: Tue, 30 Apr 2024 19:21:42 +0100
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Jan Kiszka <jan.kiszka@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2] net: ti: icssg_prueth: Add SW TX / RX
 Coalescing based on hrtimers
Message-ID: <20240430182142.GC2575892@kernel.org>
References: <20240429071501.547680-1-danishanwar@ti.com>
 <20240429183034.GG516117@kernel.org>
 <5b7cf22a-ca91-4975-bd26-c76a16781ad7@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7cf22a-ca91-4975-bd26-c76a16781ad7@ti.com>

On Tue, Apr 30, 2024 at 03:12:58PM +0530, MD Danish Anwar wrote:
> Simon,
> 
> On 30/04/24 12:00 am, Simon Horman wrote:
> > On Mon, Apr 29, 2024 at 12:45:01PM +0530, MD Danish Anwar wrote:
> >> Add SW IRQ coalescing based on hrtimers for RX and TX data path for ICSSG
> >> driver, which can be enabled by ethtool commands:
> >>
> >> - RX coalescing
> >>   ethtool -C eth1 rx-usecs 50
> >>
> >> - TX coalescing can be enabled per TX queue
> >>
> >>   - by default enables coalesing for TX0
> > 
> > nit: coalescing
> > 
> > Please consider running patches through ./checkpatch --codespell
> > 
> >>   ethtool -C eth1 tx-usecs 50
> >>   - configure TX0
> >>   ethtool -Q eth0 queue_mask 1 --coalesce tx-usecs 100
> >>   - configure TX1
> >>   ethtool -Q eth0 queue_mask 2 --coalesce tx-usecs 100
> >>   - configure TX0 and TX1
> >>   ethtool -Q eth0 queue_mask 3 --coalesce tx-usecs 100 --coalesce
> >> tx-usecs 100
> >>
> >> Minimum value for both rx-usecs and tx-usecs is 20us.
> >>
> >> Compared to gro_flush_timeout and napi_defer_hard_irqs this patch allows
> >> to enable IRQ coalescing for RX path separately.
> >>
> >> Benchmarking numbers:
> >>  ===============================================================
> >> | Method                  | Tput_TX | CPU_TX | Tput_RX | CPU_RX |
> >> | ==============================================================
> >> | Default Driver           943 Mbps    31%      517 Mbps  38%   |
> >> | IRQ Coalescing (Patch)   943 Mbps    28%      518 Mbps  25%   |
> >>  ===============================================================
> >>
> >> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >> ---
> 
> [ ... ]
> >>  	if (num_tx_packets >= budget)
> >>  		return budget;
> >>  
> >> -	if (napi_complete_done(napi_tx, num_tx_packets))
> >> -		enable_irq(tx_chn->irq);
> >> +	if (napi_complete_done(napi_tx, num_tx_packets)) {
> >> +		if (unlikely(tx_chn->tx_pace_timeout_ns && !tdown)) {
> >> +			hrtimer_start(&tx_chn->tx_hrtimer,
> >> +				      ns_to_ktime(tx_chn->tx_pace_timeout_ns),
> >> +				      HRTIMER_MODE_REL_PINNED);
> >> +		} else {
> >> +			enable_irq(tx_chn->irq);
> >> +		}
> > 
> > This compiles with gcc-13 and clang-18 W=1
> > (although the inner {} are unnecessary).
> > 
> >> +	}
> >>  
> >>  	return num_tx_packets;
> >>  }
> > 
> > ...
> > 
> >> @@ -872,7 +894,13 @@ int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
> >>  	}
> >>  
> >>  	if (num_rx < budget && napi_complete_done(napi_rx, num_rx))
> >> -		enable_irq(emac->rx_chns.irq[rx_flow]);
> >> +		if (unlikely(emac->rx_pace_timeout_ns)) {
> >> +			hrtimer_start(&emac->rx_hrtimer,
> >> +				      ns_to_ktime(emac->rx_pace_timeout_ns),
> >> +				      HRTIMER_MODE_REL_PINNED);
> >> +		} else {
> >> +			enable_irq(emac->rx_chns.irq[rx_flow]);
> >> +		}
> > 
> > But this does not; I think outer (but not inner) {} are needed.
> > 
> 
> For both of these if checks, by having {} for outer if I am not seeing
> the warnings anymore. The braces don't seem to be neccessary for inner if.
> 
> For both of these ifs I'll keep both inner and outer ifs in braces as
> this will help readablity as Dan pointed out.
> 
> I will post v3 with this change.

Thanks, sounds good to me.

