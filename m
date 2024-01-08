Return-Path: <linux-kernel+bounces-20046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485EC8278A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE65B225AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DE854FAE;
	Mon,  8 Jan 2024 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="StdF7YxJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89AD46533;
	Mon,  8 Jan 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id MvO7rxILJx8edMvO7reY5P; Mon, 08 Jan 2024 20:34:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704742463;
	bh=XIQMN8dYwQf2pqovuJTPQrW6UVnEhGAQOnLHxTnQdQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=StdF7YxJG7QFddR6jpfM9LUHY2lbvt3R+VhZ479y87b3V/xqw5OlLcRIJ0dmVRJzt
	 YgJScirWI+NmZ8rwHQSDnypoTNJxu2JIQV+N4wuhfUJFSZG0R8swTX0ssbuFxD61KL
	 /wDdBl714aGa/kb7sIW1rinVn2jOpLsF+qxzjYyNr80o/jpbuAfToSt7jQ/hlMF5G5
	 cgIwVlz04GOEIuX34O0GkDO0EK1tSNNQwOvBYKXVIe2dIonTVFcnsWi09OrGDxahtw
	 s7lOceQQVgvf77LrAY0urhQjWvYfEa7XD1UF4Uy4QPdEawhzzSADQIgx8pWDm+KuXw
	 HI5kdP6L9U0WQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 08 Jan 2024 20:34:23 +0100
X-ME-IP: 92.140.202.140
Message-ID: <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
Date: Mon, 8 Jan 2024 20:34:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Content-Language: fr
To: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Harald Mommer <harald.mommer@opensynergy.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux.dev
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/01/2024 à 14:10, Mikhail Golubev-Ciuchea a écrit :
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> - CAN Control
> 
>    - "ip link set up can0" starts the virtual CAN controller,
>    - "ip link set up can0" stops the virtual CAN controller
> 
> - CAN RX
> 
>    Receive CAN frames. CAN frames can be standard or extended, classic or
>    CAN FD. Classic CAN RTR frames are supported.
> 
> - CAN TX
> 
>    Send CAN frames. CAN frames can be standard or extended, classic or
>    CAN FD. Classic CAN RTR frames are supported.
> 
> - CAN BusOff indication
> 
>    CAN BusOff is handled by a bit in the configuration space.
> 
> Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
> Signed-off-by: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
> Co-developed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>
> ---

Hi,
a few nits below, should there be a v6.


> +static int virtio_can_alloc_tx_idx(struct virtio_can_priv *priv)
> +{
> +	int tx_idx;
> +
> +	tx_idx = ida_alloc_range(&priv->tx_putidx_ida, 0,
> +				 priv->can.echo_skb_max - 1, GFP_KERNEL);
> +	if (tx_idx >= 0)
> +		atomic_add(1, &priv->tx_inflight);

atomic_inc() ?

> +
> +	return tx_idx;
> +}
> +
> +static void virtio_can_free_tx_idx(struct virtio_can_priv *priv,
> +				   unsigned int idx)
> +{
> +	ida_free(&priv->tx_putidx_ida, idx);
> +	atomic_sub(1, &priv->tx_inflight);

atomic_dec() ?

> +}

...

> +static int virtio_can_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_can_priv *priv;
> +	struct net_device *dev;
> +	int err;
> +
> +	dev = alloc_candev(sizeof(struct virtio_can_priv),
> +			   VIRTIO_CAN_ECHO_SKB_MAX);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	priv = netdev_priv(dev);
> +
> +	ida_init(&priv->tx_putidx_ida);
> +
> +	netif_napi_add(dev, &priv->napi, virtio_can_rx_poll);
> +	netif_napi_add(dev, &priv->napi_tx, virtio_can_tx_poll);
> +
> +	SET_NETDEV_DEV(dev, &vdev->dev);
> +
> +	priv->dev = dev;
> +	priv->vdev = vdev;
> +	vdev->priv = priv;
> +
> +	priv->can.do_set_mode = virtio_can_set_mode;
> +	/* Set Virtio CAN supported operations */
> +	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
> +	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD)) {
> +		err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD);
> +		if (err != 0)
> +			goto on_failure;
> +	}
> +
> +	/* Initialize virtqueues */
> +	err = virtio_can_find_vqs(priv);
> +	if (err != 0)
> +		goto on_failure;
> +
> +	INIT_LIST_HEAD(&priv->tx_list);
> +
> +	spin_lock_init(&priv->tx_lock);
> +	mutex_init(&priv->ctrl_lock);
> +
> +	init_completion(&priv->ctrl_done);
> +
> +	virtio_can_populate_vqs(vdev);
> +
> +	register_virtio_can_dev(dev);

Check for error?

CJ

> +
> +	napi_enable(&priv->napi);
> +	napi_enable(&priv->napi_tx);
> +
> +	/* Request device going live */
> +	virtio_device_ready(vdev); /* Optionally done by virtio_dev_probe() */
> +
> +	return 0;
> +
> +on_failure:
> +	virtio_can_free_candev(dev);
> +	return err;
> +}

...


