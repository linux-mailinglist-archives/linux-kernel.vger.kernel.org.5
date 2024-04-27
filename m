Return-Path: <linux-kernel+bounces-161056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BB68B467D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3116E281747
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42C84F5F9;
	Sat, 27 Apr 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeqPbEqb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DD343172;
	Sat, 27 Apr 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714225287; cv=none; b=YO7YKWHOgK51PFXdTndmBcQBV4b/TJC7rx1DotDNHAKEtmJnm4UuqK68NlI48tAUp0xGZ17S7C6HCn4pQob0cIsCK6Lpyi6l/1z20I6xLfYtUNZcpe/F5MApoXvO57x+r0HnwbjotZWH2WjA23N9nElerQiP48ixXqXl3KY/Q9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714225287; c=relaxed/simple;
	bh=ctU/LpKIKbHCskOW6XQyFcbdqyCFxcZAeTG9GtPpceo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj406MIr94tYv9G9g+IK8hbo6XUzj/HAxmPVTI0ZkDbQkQ55iW92r4oF/6Zn94q/NwdePRa4F9nCoMoD4wKVySWkhap2Xu4/anLaTfe7inj+5IDSvildn8l60dlI46CBJMnpLnPYiF7vZNOqVY7Su4cxizkcV+mhCJ8apir3LkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeqPbEqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF7AC113CE;
	Sat, 27 Apr 2024 13:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714225286;
	bh=ctU/LpKIKbHCskOW6XQyFcbdqyCFxcZAeTG9GtPpceo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YeqPbEqbUCCjLEc+h/fPy7aD+KWfsBgKRcI1cpk9Tokt2L2sBnmEgIcxLhtIQMbVB
	 Ugk2jlNgFSVSD5O+s1tMLfVjoI6p/fYPuKaWDuXnGIgqbrCVqZe4iAwp/IZyTahupz
	 +XYdvWgJqgbmKG/yQngfkHZWPmAIYKdSX9xZpFOnpi0fiJE1uKCZXUGNmsP1hmfRNf
	 lpiPFFzIW6U6vkfjCVOIWZWnuerj2+KphWpkFnNe+BAbykDVIru8SKYW5l2hQ8iNrn
	 s1Chs0ptP0yiNbYbtn7br6GQ56zn86LuuNrPZnQasu41z2yWejgHJkETlKoQMg8Ds7
	 +tElHcAEVebxw==
Date: Sat, 27 Apr 2024 14:41:20 +0100
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
Subject: Re: [PATCH net-next] net: ti: icssg_prueth: Add SW TX / RX
 Coalescing based on hrtimers
Message-ID: <20240427134120.GJ516117@kernel.org>
References: <20240424091823.1814136-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424091823.1814136-1-danishanwar@ti.com>

On Wed, Apr 24, 2024 at 02:48:23PM +0530, MD Danish Anwar wrote:
> Add SW IRQ coalescing based on hrtimers for RX and TX data path for ICSSG
> driver, which can be enabled by ethtool commands:
> 
> - RX coalescing
>   ethtool -C eth1 rx-usecs 50
> 
> - TX coalescing can be enabled per TX queue
> 
>   - by default enables coalesing for TX0
>   ethtool -C eth1 tx-usecs 50
>   - configure TX0
>   ethtool -Q eth0 queue_mask 1 --coalesce tx-usecs 100
>   - configure TX1
>   ethtool -Q eth0 queue_mask 2 --coalesce tx-usecs 100
>   - configure TX0 and TX1
>   ethtool -Q eth0 queue_mask 3 --coalesce tx-usecs 100 --coalesce
> tx-usecs 100
> 
> Minimum value for both rx-usecs and tx-usecs is 20us.
> 
> Comapared to gro_flush_timeout and napi_defer_hard_irqs this patch

nit: Compared

> allows to enable IRQ coalescing for RX path separately.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

..

> @@ -190,19 +191,35 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  	return num_tx;
>  }
>  
> +static enum hrtimer_restart emac_tx_timer_callback(struct hrtimer *timer)
> +{
> +	struct prueth_tx_chn *tx_chns =
> +			container_of(timer, struct prueth_tx_chn, tx_hrtimer);
> +
> +	enable_irq(tx_chns->irq);
> +	return HRTIMER_NORESTART;
> +}
> +
>  static int emac_napi_tx_poll(struct napi_struct *napi_tx, int budget)
>  {
>  	struct prueth_tx_chn *tx_chn = prueth_napi_to_tx_chn(napi_tx);
>  	struct prueth_emac *emac = tx_chn->emac;
> +	bool tdown = false;
>  	int num_tx_packets;
>  
> -	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget);
> +	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget, &tdown);

Please consider limiting lines to 80 columns wide in Networking code.

>  
>  	if (num_tx_packets >= budget)
>  		return budget;
>  
> -	if (napi_complete_done(napi_tx, num_tx_packets))
> -		enable_irq(tx_chn->irq);
> +	if (napi_complete_done(napi_tx, num_tx_packets)) {
> +		if (unlikely(tx_chn->tx_pace_timeout_ns && !tdown))
> +			hrtimer_start(&tx_chn->tx_hrtimer,
> +				      ns_to_ktime(tx_chn->tx_pace_timeout_ns),
> +				      HRTIMER_MODE_REL_PINNED);
> +		else
> +			enable_irq(tx_chn->irq);
> +	}
>  
>  	return num_tx_packets;
>  }

..

> @@ -870,7 +889,12 @@ int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>  	}
>  
>  	if (num_rx < budget && napi_complete_done(napi_rx, num_rx))
> -		enable_irq(emac->rx_chns.irq[rx_flow]);
> +		if (unlikely(emac->rx_pace_timeout_ns))
> +			hrtimer_start(&emac->rx_hrtimer,
> +				      ns_to_ktime(emac->rx_pace_timeout_ns),
> +				      HRTIMER_MODE_REL_PINNED);
> +		else
> +			enable_irq(emac->rx_chns.irq[rx_flow]);

clang-18 and gcc-13 both complain about the if/else logic above.
I think it would be best to add {} to the outer if statement.

>  
>  	return num_rx;
>  }

..

