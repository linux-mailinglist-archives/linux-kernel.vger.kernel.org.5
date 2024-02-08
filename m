Return-Path: <linux-kernel+bounces-58632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E884E912
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F6D284C8B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E11381DD;
	Thu,  8 Feb 2024 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="JLoTR5YT"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8679C3770B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707421292; cv=none; b=FkNxof6qeHyTBoxYVE1oaMFG6I6LDkEm1IEf9czqXp/1yxF5xb964h14Ra4RRtGqhMgiKua+bNU9Ox2NEfMKcl0jEIXlyhkdmSpHAOsOdlGlIt3NyamLKoyTJ/X9rnSN1wM/92PtFoqBZ7b9vwMZpZqSnJqy3mVrNpkibUFJBVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707421292; c=relaxed/simple;
	bh=opZ3ssT8sjym6Pvoim1o6dI7WUwmY+CBpKJVfryTELE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0GKUc/IL1JfQPEubOe5QFtfam+MpyH5FUIrR4vk0uQZY7tCOd6yqgeqTEx6I6Hhf72bMASURD0xgL6uBxfML+LHKwrYpXhduSL0euB+n63RWvk/SC28/Di5nsqQ/UIeLHTv3GgT3djW8SdWYIVf1SJPRK5rSOohfvqDXEGi9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=JLoTR5YT; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59883168a83so89828eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 11:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707421289; x=1708026089; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaVWU02hJD7IfCilvqmn8I4qxNAVVyYhKwZVKkHOTd4=;
        b=JLoTR5YTh66JZYBLJRosVqhIBPA41MTq+T9kYAyGMocXt8Krjip8GgJ4q8b1r9mkcX
         4yTShQLKDWvzJLkM6ZPZdT/mRgSIoUiwdDIixLYYDLALnMuvOQ0alX8Da9YLJsBU0n5f
         WpqwHfMFWzkBRtpTCUBsnRicnlSLVekTDVBkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707421289; x=1708026089;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaVWU02hJD7IfCilvqmn8I4qxNAVVyYhKwZVKkHOTd4=;
        b=OBIh52GaJwg9FaeRiNh/S3T0yfNaT9i6KexLjGZZ9dvXklXbJ0ny4LceeJHG+xtiWj
         3kbWKjzKiPyBG7sR6753mVi28mgKbEE5oJ9PhOv+E+owpxpJe2g96o9VZXpaHuDvfM7h
         mdm4aaqyTeD2bsDTjZUV/ks50TXX2ShbVklV8jLP6YQoWnYZIrMACgWOQDOGxWFvDgie
         R9vg5yyMSqxcD/MJh2Kh9x9XL7SRStFzrtUxlp401a1YmGyeKGQqK9hSLD5l4OdxQd/5
         rIFoH5exntUGICuMelcSU487kD8Ystuj2K/ikYn/3EeQ6Ta1iepOop+3wj4/LSwJvv3F
         9O0A==
X-Gm-Message-State: AOJu0YzOP4L3B6KZIjX/dzdyO2qh+l0ITxYdfUQ/DUxg71H+vrK7TDur
	dx7z7Ac1X0Pfrq0UYzK9PTQgNKm2a2zSM5/0CH1XiL2+eDkRkk8Mnx48ehx7OPw=
X-Google-Smtp-Source: AGHT+IGtjDBJf7DunhoNr4ewGT3uM0NMHpsvm5Nd0mQlyZuTS2s0ICF9POG9y0QUL0L620cQQbqZlQ==
X-Received: by 2002:a05:6358:4194:b0:178:fadb:d191 with SMTP id w20-20020a056358419400b00178fadbd191mr139079rwc.28.1707421289497;
        Thu, 08 Feb 2024 11:41:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7jlSjlU8QAkXZ3ZmUImhqDJh0gptuVJMqCJquIAAK2n5hMcEdSofy3O3po1rLvE3PYivDqk3eksnlopvgVK1JJLalTXAJtKZnVUUvpVAskXYfXiSg36XoMCrthTvdSOgpejv1NMZ0uhloFYiKk0csXPyIlLNMjWyO7gB5O8ydkjD87ngGHshbXwpuyW8cUXus/zo5eWlE76FItF4mg2/hiYWvJ9RDNjr/7gEjEs3WC/h0ZMEqLstvnoT1NVt2RQQ3hTEOiGLuoxOm4TYqbTTc5hFUZcixj7viwuk+XUGLRD4ZKmM5/4TSlCo2WIDRGqFgsH3x0W7RNTWXRF5vRxRrl3MNbib2pobE1bOaju61/11qd/kyuOo2FjM+k+z0BcR9RRjqWkyGUhKOP37/Uz8M1ueBo7jb59XyQ49jLCI3X3jDlAY=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id x129-20020a636387000000b005c6617b52e6sm217384pgb.5.2024.02.08.11.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2024 11:41:29 -0800 (PST)
Date: Thu, 8 Feb 2024 11:41:26 -0800
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	rrameshbabu@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net/mlx5e: link NAPI instances to queues and
 IRQs
Message-ID: <20240208194125.GA3166@fastly.com>
References: <20240208030702.27296-1-jdamato@fastly.com>
 <8c083e6d-5fcd-4557-88dd-0f95acdbc747@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c083e6d-5fcd-4557-88dd-0f95acdbc747@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Thu, Feb 08, 2024 at 09:13:25PM +0200, Tariq Toukan wrote:
> 
> 
> On 08/02/2024 5:07, Joe Damato wrote:
> >Make mlx5 compatible with the newly added netlink queue GET APIs.
> >
> >Signed-off-by: Joe Damato <jdamato@fastly.com>
> >---
> >v2 -> v3:
> >   - Fix commit message subject
> >   - call netif_queue_set_napi in mlx5e_ptp_activate_channel and
> >     mlx5e_ptp_deactivate_channel to enable/disable NETDEV_QUEUE_TYPE_RX for
> >     the PTP channel.
> >   - Modify mlx5e_activate_txqsq and mlx5e_deactivate_txqsq to set
> >     NETDEV_QUEUE_TYPE_TX which should take care of all TX queues including
> >     QoS/HTB and PTP.
> >   - Rearrange mlx5e_activate_channel and mlx5e_deactivate_channel for
> >     better ordering when setting and unsetting NETDEV_QUEUE_TYPE_RX NAPI
> >     structs
> >
> >v1 -> v2:
> >   - Move netlink NULL code to mlx5e_deactivate_channel
> >   - Move netif_napi_set_irq to mlx5e_open_channel and avoid storing the
> >     irq, after netif_napi_add which itself sets the IRQ to -1
> >
> >  drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c  | 3 +++
> >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++++
> >  2 files changed, 10 insertions(+)
> >
> >diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> >index 078f56a3cbb2..fbbc287d924d 100644
> >--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> >+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> >@@ -927,6 +927,8 @@ void mlx5e_ptp_activate_channel(struct mlx5e_ptp *c)
> >  	int tc;
> >  	napi_enable(&c->napi);
> >+	netif_queue_set_napi(c->netdev, c->rq.ix, NETDEV_QUEUE_TYPE_RX,
> >+			     &c->napi);
> >  	if (test_bit(MLX5E_PTP_STATE_TX, c->state)) {
> >  		for (tc = 0; tc < c->num_tc; tc++)
> >@@ -951,6 +953,7 @@ void mlx5e_ptp_deactivate_channel(struct mlx5e_ptp *c)
> >  			mlx5e_deactivate_txqsq(&c->ptpsq[tc].txqsq);
> >  	}
> >+	netif_queue_set_napi(c->netdev, c->rq.ix, NETDEV_QUEUE_TYPE_RX, NULL);
> >  	napi_disable(&c->napi);
> >  }
> >diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >index c8e8f512803e..2f1792854dd5 100644
> >--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >@@ -1806,6 +1806,7 @@ void mlx5e_activate_txqsq(struct mlx5e_txqsq *sq)
> >  	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
> >  	netdev_tx_reset_queue(sq->txq);
> >  	netif_tx_start_queue(sq->txq);
> >+	netif_queue_set_napi(sq->channel->netdev, sq->txq_ix, NETDEV_QUEUE_TYPE_TX, &sq->channel->napi);
> 
> Might be called with channel==NULL.
> For example for PTP.
> 
> Prefer sq->netdev and sq->cq.napi.

OK, I'll make that change for the v4 which I'll send sometime tomorrow.

Thanks.

> >  }
> >  void mlx5e_tx_disable_queue(struct netdev_queue *txq)
> >@@ -1819,6 +1820,7 @@ void mlx5e_deactivate_txqsq(struct mlx5e_txqsq *sq)
> >  {
> >  	struct mlx5_wq_cyc *wq = &sq->wq;
> >+	netif_queue_set_napi(sq->channel->netdev, sq->txq_ix, NETDEV_QUEUE_TYPE_TX, NULL);
> 
> Same here.
> 
> >  	clear_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
> >  	synchronize_net(); /* Sync with NAPI to prevent netif_tx_wake_queue. */
> >@@ -2560,6 +2562,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
> >  	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
> >  	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
> >+	netif_napi_set_irq(&c->napi, irq);
> >  	err = mlx5e_open_queues(c, params, cparam);
> >  	if (unlikely(err))
> >@@ -2602,12 +2605,16 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
> >  		mlx5e_activate_xsk(c);
> >  	else
> >  		mlx5e_activate_rq(&c->rq);
> >+
> >+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
> >  }
> >  static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
> >  {
> >  	int tc;
> >+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
> >+
> >  	if (test_bit(MLX5E_CHANNEL_STATE_XSK, c->state))
> >  		mlx5e_deactivate_xsk(c);
> >  	else

