Return-Path: <linux-kernel+bounces-140376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4649E8A1381
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CAF28B168
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB314A4C7;
	Thu, 11 Apr 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PheXcQ6g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081B145B07;
	Thu, 11 Apr 2024 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835989; cv=none; b=cqiC6C06YyTcJIG+ic/rVyms3iZEVkEU7ZACqZNLJBteY8jaADWMrSfHgQkNkt9Hg2GtdQ6MYrh/woL4ENS6QXFoFC8mFT3RNl8F5IISkZzcZZ7a0L1yrHmWkl6bOuuLJ9fDTn6bAmx6vAkaToyhy7hxmzmgZPMG+Xwm1cg0QZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835989; c=relaxed/simple;
	bh=jdKUR9TIihCL86D2ZLjqOjAi+/Eo0ggnHy2umwqjOdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNg+0wN8T3+KtFHzDEKsSya8O4bHNv/MdhQ3oRQ+VvN/enEbrTeEwx3DZJgo/zSYwQJjZgCNWx5fy7caAROwZOSTOgDa9g9lRG6+okJlwkzcv/7LriSJioDBr5THnNtyFTPE3f0cRi7/5ez9uhcabw8MXQuUgAicCcwsk4nsi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PheXcQ6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F055EC433C7;
	Thu, 11 Apr 2024 11:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712835989;
	bh=jdKUR9TIihCL86D2ZLjqOjAi+/Eo0ggnHy2umwqjOdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PheXcQ6g81dg5IucfxbuD1+o2P1d5Sp+n2L3b522d7O8m/0HD+10YxUXsHkNhPD8T
	 cp0eZ1ZXc7kYWHrXCxfBxvfyp4z1zPJafB2EO8I4rgaRQPUPfMMeSX0vasKIPRqa4+
	 /RDlgTfkyky2XNKsxoXPnonscnhpLqDrD0L+Rf+DHep6+b3DG6QuHnkl+g+CFs6yC1
	 10CLd7FID3B5HfKqZrI8Pdi2BB50OZSUiss/qF4DCuOBF7cGCSqofmqYOYYgbKR6Ub
	 2MoIpnlxyWv/WoS4D+fEgwK+SA1N+AQqXHA1ueAwnC/LsVonNe5va4W4jIPWZiA6qs
	 ltsCfOb6qZHwg==
Date: Thu, 11 Apr 2024 12:46:23 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v6 3/9] net: add IEEE 802.1q specific helpers
Message-ID: <20240411114623.GI514426@kernel.org>
References: <20240410080556.1241048-1-o.rempel@pengutronix.de>
 <20240410080556.1241048-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410080556.1241048-4-o.rempel@pengutronix.de>

On Wed, Apr 10, 2024 at 10:05:50AM +0200, Oleksij Rempel wrote:
> IEEE 802.1q specification provides recommendation and examples which can
> be used as good default values for different drivers.
> 
> This patch implements mapping examples documented in IEEE 802.1Q-2022 in
> Annex I "I.3 Traffic type to traffic class mapping" and IETF DSCP naming
> and mapping DSCP to Traffic Type inspired by RFC8325.
> 
> This helpers will be used in followup patches for dsa/microchip DCB
> implementation.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

..

> diff --git a/include/net/ieee8021q.h b/include/net/ieee8021q.h
> new file mode 100644
> index 0000000000000..3bec7ec951362
> --- /dev/null
> +++ b/include/net/ieee8021q.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de> */
> +
> +#ifndef _NET_IEEE8021Q_H
> +#define _NET_IEEE8021Q_H
> +
> +#include <linux/errno.h>
> +
> +/**
> + * enum ieee8021q_traffic_type - 802.1Q traffic type priority values (802.1Q-2022)
> + *
> + * @IEEE8021Q_TT_BK: Background
> + * @IEEE8021Q_TT_BE: Best Effort (default). According to 802.1Q-2022, BE is 0
> + * but has higher priority than BK which is 1.
> + * @IEEE8021Q_TT_EE: Excellent Effort
> + * @IEEE8021Q_TT_CA: Critical Applications
> + * @IEEE8021Q_TT_VI: Video, < 100 ms latency and jitter
> + * @IEEE8021Q_TT_VO: Voice, < 10 ms latency and jitter
> + * @IEEE8021Q_TT_IC: Internetwork Control
> + * @IEEE8021Q_TT_NC: Network Control
> + */
> +enum ieee8021q_traffic_type {
> +	IEEE8021Q_TT_BK = 0,
> +	IEEE8021Q_TT_BE = 1,
> +	IEEE8021Q_TT_EE = 2,
> +	IEEE8021Q_TT_CA = 3,
> +	IEEE8021Q_TT_VI = 4,
> +	IEEE8021Q_TT_VO = 5,
> +	IEEE8021Q_TT_IC = 6,
> +	IEEE8021Q_TT_NC = 7,
> +

Hi Oleksij,

I think the following line should go here to keep ./scripts/kernel-doc -none
happy:

	/* private: */

> +	IEEE8021Q_TT_MAX,
> +};

..

