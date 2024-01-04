Return-Path: <linux-kernel+bounces-17032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B504782475C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4841C2429D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E46B28E28;
	Thu,  4 Jan 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb5A7FTI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043D28E29;
	Thu,  4 Jan 2024 17:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEE7C433C7;
	Thu,  4 Jan 2024 17:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704388785;
	bh=IA55/z/VCfQyUlpRMsvuMO6NANKwsanr77HuZLv9tYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nb5A7FTIbIDzsGHPUXsC9IN7PSV0Ts78G88LVHRqCQKnqpIKftq9dPEMz8Ziq7Sd1
	 MB2jpVHGk5TvuYngc97lKbNFnpe+zARUqDyKCQcdh/1I6wcET5miHE09BKbOOiJWl6
	 /KKH9bDm+n2vTpnx8TO1k4Q+h8JWC72FeZkthOJbc+2MIF4/Icl74dXcLUWh9HLxd4
	 p1p6M6ioxXVc8KzB9JY9bG7u9C8Vzrtb2h4/tqOA4CUQb0ltmapo02Y+qsqbrdyCaH
	 goH1VGel3TMoKi+bZj6fvjzE+Li2CA1xo/Hz5sncrUCBYAWHEkWMucILvtN8WrBGC3
	 +9crPZ+ivOdHg==
Date: Thu, 4 Jan 2024 17:19:40 +0000
From: Simon Horman <horms@kernel.org>
To: Bhavya Kapoor <b-kapoor@ti.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr,
	rcsekar@samsung.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, mkl@pengutronix.de,
	wg@grandegger.com, vigneshr@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH] net: can: Add support for aliases in CAN
Message-ID: <20240104171940.GI31813@kernel.org>
References: <20240102102949.138607-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102102949.138607-1-b-kapoor@ti.com>

On Tue, Jan 02, 2024 at 03:59:49PM +0530, Bhavya Kapoor wrote:
> When multiple CAN's are present, then names that are getting assigned
> changes after every boot even after providing alias in the device tree.
> Thus, Add support for implementing CAN aliasing so that names or
> alias for CAN will now be provided from device tree.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>

Hi Bhavya,

some minor feedback from my side.

...

> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 3a3be5cdfc1f..ed483c23ec79 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -247,12 +247,14 @@ void can_setup(struct net_device *dev)
>  
>  /* Allocate and setup space for the CAN network device */
>  struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
> -				    unsigned int txqs, unsigned int rxqs)
> +					unsigned int txqs, unsigned int rxqs,
> +					struct device *candev)
>  {
>  	struct can_ml_priv *can_ml;
>  	struct net_device *dev;
>  	struct can_priv *priv;
> -	int size;
> +	int size, aliasid;
> +	char devname[6] = "can%d";

nit: Please consider arranging local variables in Networking code
     in reverse xmas tree order - longest line to shortest.

>  
>  	/* We put the driver's priv, the CAN mid layer priv and the
>  	 * echo skb into the netdevice's priv. The memory layout for
> @@ -273,7 +275,14 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>  		size = ALIGN(size, sizeof(struct sk_buff *)) +
>  			echo_skb_max * sizeof(struct sk_buff *);
>  
> -	dev = alloc_netdev_mqs(size, "can%d", NET_NAME_UNKNOWN, can_setup,
> +	if (candev) {
> +		aliasid = of_alias_get_id(candev->of_node, "can");
> +		if (aliasid >= 0)
> +			snprintf(devname, sizeof(devname), "%s%d", "can", aliasid);

The size of devname is 6 bytes (can%d\0).
This means that snprintf() will truncate devname if alias is greater than 99.
Is this a concern?

If so, perhaps devname could be declared to be IFNAMSIZ bytes long?

Flagged by gcc-13 -Wformat-truncation

> +	}
> +	dev_dbg(candev, "Name of CAN assigned is : %s\n", devname);
> +
> +	dev = alloc_netdev_mqs(size, devname, NET_NAME_UNKNOWN, can_setup,
>  			       txqs, rxqs);
>  	if (!dev)
>  		return NULL;

...

