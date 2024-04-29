Return-Path: <linux-kernel+bounces-162828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B1A8B611D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B61E1F22449
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F125D12A152;
	Mon, 29 Apr 2024 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+4A0mhF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602E1E529;
	Mon, 29 Apr 2024 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415440; cv=none; b=e1cQuPhNBCqpt/u7Rm7sCi/myxl84K+QpTKri5URIIyUTJPQDV9S+ypd9S7feM1RBkDir28fGnDS57Lb0B2InC52DepK2eUWqOs8TIkvt58d0H0o7jrh4i/7B29a7IiKy02t4+iIJyuZFclfNC2jCgYoEL4GUbOEMCjpeXGTnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415440; c=relaxed/simple;
	bh=FaReNWfkCpcHh4aoUxanTbqVxVGYZtVPHbOmTpw9Lts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCT2KWIgDbxCX/UbomRNH+hN54UNvPeDTufWNuvI+F6dA+Ezx5Ueq9lj0zd1Guv3rM+R8z49zUtqnZf+mWIOcXT6ffYX7rlys066MwKJBgL6FqEnL7rMS3hfxulkllJO+Fz2G8PGknX4HuZjmsiX2eA24AVJK/GvtPTDCmvnScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+4A0mhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3DEC113CD;
	Mon, 29 Apr 2024 18:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714415439;
	bh=FaReNWfkCpcHh4aoUxanTbqVxVGYZtVPHbOmTpw9Lts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+4A0mhFdeQrbGu6U7QJo3MzgH4oVDAqzBApw0imCfDSAXhowcIuz2uW4FPcz8x8X
	 E5sIkC+nVa3suvMOUTAkCLBo6SK9Cz21qXae+vl/xeXOnEwc6PbzeuvyRaUtlh2svF
	 7oEqSMezkAWzC284OLKQ6Q5YcnnQ94kOQP+6BNxlCS6SZcywAPKZzoF1VXis3KtqhN
	 HVx3E2GOk8d4VO8BQj6Lb7tRRECIoioclQCULwVlGukzz4JJ5ihfHu2iXDObEUCep4
	 rSVMxMPhrkySGl7GGHO1wAtNjLs7j8bdSZAHca8E11cTaRzPQOlhCPJNyowk+jziG4
	 WShAN9rOo/zQg==
Date: Mon, 29 Apr 2024 19:30:34 +0100
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
Message-ID: <20240429183034.GG516117@kernel.org>
References: <20240429071501.547680-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429071501.547680-1-danishanwar@ti.com>

On Mon, Apr 29, 2024 at 12:45:01PM +0530, MD Danish Anwar wrote:
> Add SW IRQ coalescing based on hrtimers for RX and TX data path for ICSSG
> driver, which can be enabled by ethtool commands:
> 
> - RX coalescing
>   ethtool -C eth1 rx-usecs 50
> 
> - TX coalescing can be enabled per TX queue
> 
>   - by default enables coalesing for TX0

nit: coalescing

Please consider running patches through ./checkpatch --codespell

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
> Compared to gro_flush_timeout and napi_defer_hard_irqs this patch allows
> to enable IRQ coalescing for RX path separately.
> 
> Benchmarking numbers:
>  ===============================================================
> | Method                  | Tput_TX | CPU_TX | Tput_RX | CPU_RX |
> | ==============================================================
> | Default Driver           943 Mbps    31%      517 Mbps  38%   |
> | IRQ Coalescing (Patch)   943 Mbps    28%      518 Mbps  25%   |
>  ===============================================================
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Changes from v1 [1] to v2:
> *) Added Benchmarking numbers in the commit message as suggested by
>    Andrew Lunn <andrew@lunn.ch>. Full logs [2]
> *) Addressed comments given by Simon Horman <horms@kernel.org> in v1.

Sorry to be bothersome, but the W=1 problem isn't entirely fixed.

> 
> [1] https://lore.kernel.org/all/20240424091823.1814136-1-danishanwar@ti.com/
> 
> [2] https://gist.githubusercontent.com/danish-ti/47855631be9f3635cee994693662a988/raw/94b4eb86b42fe243ab03186a88a314e0cb272fd0/gistfile1.txt

..

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c

..

> @@ -190,19 +191,37 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
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
> +	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget,
> +						  &tdown);
>  
>  	if (num_tx_packets >= budget)
>  		return budget;
>  
> -	if (napi_complete_done(napi_tx, num_tx_packets))
> -		enable_irq(tx_chn->irq);
> +	if (napi_complete_done(napi_tx, num_tx_packets)) {
> +		if (unlikely(tx_chn->tx_pace_timeout_ns && !tdown)) {
> +			hrtimer_start(&tx_chn->tx_hrtimer,
> +				      ns_to_ktime(tx_chn->tx_pace_timeout_ns),
> +				      HRTIMER_MODE_REL_PINNED);
> +		} else {
> +			enable_irq(tx_chn->irq);
> +		}

This compiles with gcc-13 and clang-18 W=1
(although the inner {} are unnecessary).

> +	}
>  
>  	return num_tx_packets;
>  }

..

> @@ -872,7 +894,13 @@ int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>  	}
>  
>  	if (num_rx < budget && napi_complete_done(napi_rx, num_rx))
> -		enable_irq(emac->rx_chns.irq[rx_flow]);
> +		if (unlikely(emac->rx_pace_timeout_ns)) {
> +			hrtimer_start(&emac->rx_hrtimer,
> +				      ns_to_ktime(emac->rx_pace_timeout_ns),
> +				      HRTIMER_MODE_REL_PINNED);
> +		} else {
> +			enable_irq(emac->rx_chns.irq[rx_flow]);
> +		}

But this does not; I think outer (but not inner) {} are needed.

FIIIW, I believe this doesn't show-up in the netdev automated testing
because this driver isn't built for x86 allmodconfig.

>  
>  	return num_rx;
>  }

..

-- 
pw-bot: changes-requested

