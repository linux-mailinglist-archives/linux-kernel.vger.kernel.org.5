Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A897E7E46
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjKJRmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjKJRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:41:56 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8DA3A22E;
        Fri, 10 Nov 2023 07:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=xdX945D2Jx/pGt01LPI1xFPqlA8WOj4k1izJoiFM9eQ=; b=SrPd3KlFmcQMHkuhaKnxKIFvww
        Q3H3bJ0H1V/+MoOzVUmokQ1jhSH84NPi7y1x58BJWzXlnTmv5pZHPAMDfi6cuWzu3CGf3AoFxK36H
        JUfW4O63U86dKzxelg3FnDtdz3E8W4FbGqf52q1lonSPyiMMGQ4h+XMdEiR4E+yLyd8c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r1TCM-001Iqx-Ry; Fri, 10 Nov 2023 16:13:30 +0100
Date:   Fri, 10 Nov 2023 16:13:30 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     alexey.pakhunov@spacex.com
Cc:     mchan@broadcom.com, vincent.wong2@spacex.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        siva.kallam@broadcom.com, prashant@broadcom.com
Subject: Re: [PATCH v2 1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
Message-ID: <7f1604fd-4bd6-4f16-8aed-2586afac7d15@lunn.ch>
References: <20231110002340.3612515-1-alexey.pakhunov@spacex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110002340.3612515-1-alexey.pakhunov@spacex.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -11895,6 +11903,9 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
>  {
>  	struct rtnl_link_stats64 *old_stats = &tp->net_stats_prev;
>  	struct tg3_hw_stats *hw_stats = tp->hw_stats;
> +	unsigned long rx_dropped;
> +	unsigned long tx_dropped;
> +	int i;
>  
>  	stats->rx_packets = old_stats->rx_packets +
>  		get_stat64(&hw_stats->rx_ucast_packets) +
> @@ -11941,8 +11952,26 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
>  	stats->rx_missed_errors = old_stats->rx_missed_errors +
>  		get_stat64(&hw_stats->rx_discards);
>  
> -	stats->rx_dropped = tp->rx_dropped;
> -	stats->tx_dropped = tp->tx_dropped;
> +	/* Aggregate per-queue counters. The per-queue counters are updated
> +	 * by a single writer, race-free. The result computed by this loop
> +	 * might not be 100% accurate (counters can be updated in the middle of
> +	 * the loop) but the next tg3_get_nstats() will recompute the current
> +	 * value so it is acceptable.
> +	 *
> +	 * Note that these counters wrap around at 4G on 32bit machines.
> +	 */
> +	rx_dropped = (unsigned long)(old_stats->rx_dropped);
> +	tx_dropped = (unsigned long)(old_stats->tx_dropped);

Isn't this wrapping artificial? old_stats is of type
rtnl_link_stats64, so the counters are 64 bit.

> +
> +	for (i = 0; i < tp->irq_cnt; i++) {
> +		struct tg3_napi *tnapi = &tp->napi[i];
> +
> +		rx_dropped += tnapi->rx_dropped;
> +		tx_dropped += tnapi->tx_dropped;
> +	}
> +
> +	stats->rx_dropped = rx_dropped;
> +	stats->tx_dropped = tx_dropped;

state is also rtnl_link_stats64 so has 64 bit counters. So this code
is throwing away the upper 32 bits.

Why not use include/linux/u64_stats_sync.h, which should cost you
nothing on 64 bit machines, and do the right thing on 32 bit machines.

	Andrew
