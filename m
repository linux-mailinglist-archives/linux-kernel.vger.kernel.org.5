Return-Path: <linux-kernel+bounces-54155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC6784AB9D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954791F24E82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BFE1870;
	Tue,  6 Feb 2024 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="i3wfo3O7"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177526FD7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183173; cv=none; b=eV7T+F6T1Qb/7ahW5MUftTMzwALCRhhhdtizqtiKT8pQlAhWoMC7ft6khY6T2Jys4Jl+6EeJU2/GRuMW/TDwKNXwh3hvEKlRPnIi7vDiVDTarOCnxDj+hAfou79KoknvfslhFGD4A9wh8v7gMy0/ofdITbp5ZiALzRDSLU2RSYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183173; c=relaxed/simple;
	bh=pBkCYd7B0CYbCUsFx1V+bQ/EoKILx+Ug6j39eib3yNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVCH95agVm03g7zDjS7LhaMOlCMJl5sVTQTOJmDjOpgGcLKLPkEsUtQfGf8UHng/IKwGUJN+EqFv++Fp8Zl6n3IkW9fi4ob1fjk04MikcdwEMS+q1YheTG1Tyu/RPWJQBLrb1cQujUUBOFiKOWMaI3ks8M7sb8PVWP1aOqcxlK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=i3wfo3O7; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59a6f2eecf6so2329151eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 17:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707183170; x=1707787970; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHuOPEoYQA+w2xuM98mJBf47nO7PTxDkSYQ4f4HqMbQ=;
        b=i3wfo3O7ujfvOnFQ8iUYnkD8BGhx2lz1AIqqU/cDsJwukfbePa+PQJQO8KQtXQVbeo
         NaPbynDWLtb40dkbfq+SqyECXU9PKiN0PTVSewTiDn3KrwGFf2uzUgSYcLCSmTd6flU2
         N0mg/0ynm5IIbfHFg6QwuhnFIp/ifMlrVO5Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707183170; x=1707787970;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHuOPEoYQA+w2xuM98mJBf47nO7PTxDkSYQ4f4HqMbQ=;
        b=CmF11JgNvijAnLPWEMMPyw67wNFZBEr+VsdGh8g7aHwJGBYRf2gv1RXMYl72O8Cmz6
         n6o2P9duj1TV9AdiGN0dF96H48IZos7TjDhQqFEeWtCJShpbxJp6ANtw+MEiZ5CQWOa2
         viYb78K8h8uIoX++bbu45EDcADmrHGnABeF2wwflYRUghsUL3UDJHc4izr0AC3SB3OxQ
         boaJWwkWYum+JMjNG7y/O3Adn2mr/TK8byaQ4IwB4J5Iwa5WCuGjkJZ5WvjFj64/ELiS
         /fHyU1Ops6G+W6K7zTO5uTft/purQeaY2buegg9Ycbb8Dz9WoFL+jAux2ov9jRyPAmbW
         l4xQ==
X-Gm-Message-State: AOJu0YyZ6JldliY7XnxFnyyQs1UlwQGSFEyHkdHP912+B2eEoEzpRhqA
	r6z+rm6TakeRgsHF9x0WB6vHhyNp4XGXAPBScf4owucKTRt8CjeWhXCScdD6paw=
X-Google-Smtp-Source: AGHT+IEfUdobcaRYKtUSizm1hySV21NrDxUEoJ4N7Mo8m0VLv1K2M5EQHQwZUtLidkFEp9q1hOWDnw==
X-Received: by 2002:a05:6358:719:b0:175:cfa7:953d with SMTP id e25-20020a056358071900b00175cfa7953dmr1872310rwj.2.1707183170011;
        Mon, 05 Feb 2024 17:32:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWztDuxk32cFuyDyhLEKLkKPT490E0I7gmkTVzjmDoSKJnp28RU+Dy8Y5itHl3on59Xm0/r2yd5B83SbO2D9uhReh989XI620M1TSaNFpohO7me7+2C2KuPjuJa7j7I1KiYa9zZyQ/r1vrvtfD2HPXq7jAYDvnmx+4o1mKQrB06cCiHlLfMR48cx2A+nDt/T1ImI0XRo7XBzG1RKrjptLzvSELC/WU9ndVfTrxph4tK076ILZZ9zDhAAScFNE/8DnhFBlSHmCri/g3/lH3aWkMmf67urd/KhgTceFZVXX7KvwMXwKJCH5c=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id v18-20020aa799d2000000b006e0414d7cf8sm554769pfi.95.2024.02.05.17.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 17:32:49 -0800 (PST)
Date: Mon, 5 Feb 2024 17:32:47 -0800
From: Joe Damato <jdamato@fastly.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and
 IRQs
Message-ID: <20240206013246.GA11217@fastly.com>
References: <20240206010311.149103-1-jdamato@fastly.com>
 <878r3ymlnk.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r3ymlnk.fsf@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Mon, Feb 05, 2024 at 05:09:09PM -0800, Rahul Rameshbabu wrote:
> On Tue, 06 Feb, 2024 01:03:11 +0000 Joe Damato <jdamato@fastly.com> wrote:
> > Make mlx5 compatible with the newly added netlink queue GET APIs.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
> >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 ++++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> > index 55c6ace0acd5..3f86ee1831a8 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> > @@ -768,6 +768,7 @@ struct mlx5e_channel {
> >  	u16                        qos_sqs_size;
> >  	u8                         num_tc;
> >  	u8                         lag_port;
> > +	unsigned int		   irq;
> >  
> >  	/* XDP_REDIRECT */
> >  	struct mlx5e_xdpsq         xdpsq;
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index c8e8f512803e..e1bfff1fb328 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > @@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
> >  	mlx5e_close_tx_cqs(c);
> >  	mlx5e_close_cq(&c->icosq.cq);
> >  	mlx5e_close_cq(&c->async_icosq.cq);
> > +
> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
> 
> This should be set to NULL *before* actually closing the rqs, sqs, and
> related cqs right? I would expect these two lines to be the first ones
> called in mlx5e_close_queues. Btw, I think this should be done in
> mlx5e_deactivate_channel where the NAPI is disabled.
> 
> >  }
> >  
> >  static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
> > @@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
> >  	c->stats    = &priv->channel_stats[ix]->ch;
> >  	c->aff_mask = irq_get_effective_affinity_mask(irq);
> >  	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
> > +	c->irq		= irq;
> >  
> >  	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
> >  
> > @@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
> >  		mlx5e_activate_xsk(c);
> >  	else
> >  		mlx5e_activate_rq(&c->rq);
> > +
> > +	netif_napi_set_irq(&c->napi, c->irq);
> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);
> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
> 
> It's weird that netlink queue API is being configured in
> mlx5e_activate_channel and deconfigured in mlx5e_close_queues. This
> leads to a problem where the napi will be falsely referred to even when
> we deactivate the channels in mlx5e_switch_priv_channels and may not
> necessarily get to closing the channels due to an error.
> 
> Typically, we use the following clean up patterns.
> 
> mlx5e_activate_channel -> mlx5e_deactivate_channel
> mlx5e_open_queues -> mlx5e_close_queues

OK, I'll move it to mlx5e_deactivate_channel before the NAPI is disabled.
That makes sense to me.

