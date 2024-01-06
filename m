Return-Path: <linux-kernel+bounces-18520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93340825EB1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74CCB23411
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1466346A6;
	Sat,  6 Jan 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFXeACEH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA13C15;
	Sat,  6 Jan 2024 07:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9290FC433C7;
	Sat,  6 Jan 2024 07:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704525408;
	bh=dG0phtdnvCCkXxKsiM0aT+uPfINQvrWi1CxX3oZjNpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFXeACEHnSPawP6cd9scXaSiG/L0zYDNa6b03SxmQ06d+UguZqTrXUbK74SEx+QXa
	 jXkGyoBBeJjY7TO/u0N50pS0Tfc624K+B4RUakx1tZ60wTlblLS+Tc9ZEYPX4z7Alw
	 AgzgcBeA3CF+LkFyjNODcKMSNCb4oXWfJsu+rJFH7f6F2uQcSIXdroOKp0BB5YGdEw
	 xOT3zbXOH6VrIY8NMQwd/yH80j4zHFV5kkJ0U8P3SHQwcKL8oHI5MSUHTtGKNlMKZE
	 ynS31RyIRXfXEug2ZqdRD0jozOi/gP14IYrlGOn2LVYXpJsevBm4O7rPrWfX/jfgG2
	 4avy2DAskjOyQ==
Date: Sat, 6 Jan 2024 15:04:01 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Petr Tesarik <petr@tesarici.cz>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: fix ethtool per-queue  statistics
Message-ID: <ZZj7YfYa3Hl5TW1n@xhacker>
References: <20240105201642.30904-1-petr@tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240105201642.30904-1-petr@tesarici.cz>

On Fri, Jan 05, 2024 at 09:16:42PM +0100, Petr Tesarik wrote:
> Fix per-queue statistics for devices with more than one queue.
> 
> The output data pointer is currently reset in each loop iteration,
> effectively summing all queue statistics in the first four u64 values.
> 
> The summary values are not even labeled correctly. For example, if eth0 has
> 2 queues, ethtool -S eth0 shows:
> 
>      q0_tx_pkt_n: 374 (actually tx_pkt_n over all queues)
>      q0_tx_irq_n: 23  (actually tx_normal_irq_n over all queues)
>      q1_tx_pkt_n: 462 (actually rx_pkt_n over all queues)
>      q1_tx_irq_n: 446 (actually rx_normal_irq_n over all queues)
>      q0_rx_pkt_n: 0
>      q0_rx_irq_n: 0
>      q1_rx_pkt_n: 0
>      q1_rx_irq_n: 0
> 
> Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where necessary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>

Good catch! I mixed this with the statics sum up for
stmmac_qstats_string[].

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index f628411ae4ae..112a36a698f1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -543,15 +543,12 @@ static void stmmac_get_per_qstats(struct stmmac_priv *priv, u64 *data)
>  	u32 rx_cnt = priv->plat->rx_queues_to_use;
>  	unsigned int start;
>  	int q, stat;
> -	u64 *pos;
>  	char *p;
>  
> -	pos = data;
>  	for (q = 0; q < tx_cnt; q++) {
>  		struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[q];
>  		struct stmmac_txq_stats snapshot;
>  
> -		data = pos;
>  		do {
>  			start = u64_stats_fetch_begin(&txq_stats->syncp);
>  			snapshot = *txq_stats;
> @@ -559,17 +556,15 @@ static void stmmac_get_per_qstats(struct stmmac_priv *priv, u64 *data)
>  
>  		p = (char *)&snapshot + offsetof(struct stmmac_txq_stats, tx_pkt_n);
>  		for (stat = 0; stat < STMMAC_TXQ_STATS; stat++) {
> -			*data++ += (*(u64 *)p);
> +			*data++ = (*(u64 *)p);
>  			p += sizeof(u64);
>  		}
>  	}
>  
> -	pos = data;
>  	for (q = 0; q < rx_cnt; q++) {
>  		struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[q];
>  		struct stmmac_rxq_stats snapshot;
>  
> -		data = pos;
>  		do {
>  			start = u64_stats_fetch_begin(&rxq_stats->syncp);
>  			snapshot = *rxq_stats;
> @@ -577,7 +572,7 @@ static void stmmac_get_per_qstats(struct stmmac_priv *priv, u64 *data)
>  
>  		p = (char *)&snapshot + offsetof(struct stmmac_rxq_stats, rx_pkt_n);
>  		for (stat = 0; stat < STMMAC_RXQ_STATS; stat++) {
> -			*data++ += (*(u64 *)p);
> +			*data++ = (*(u64 *)p);
>  			p += sizeof(u64);
>  		}
>  	}
> -- 
> 2.43.0
> 

