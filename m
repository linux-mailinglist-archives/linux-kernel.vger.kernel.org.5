Return-Path: <linux-kernel+bounces-75232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B8185E4F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADEB2859E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0D83CBC;
	Wed, 21 Feb 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t09f8tuz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF583CD2;
	Wed, 21 Feb 2024 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538042; cv=none; b=fcC321waLWgV1TOMKPYAyr6lG0/Jpz7vMnIx/39QWagNxPuHRpXi2wxoh3vlJc03GD6oSloFLgjyaLcINBklR3Tc1TkfakUxWhmBq8UtJF2bTU2VUfkOFBUKgAcGELjaIohqukD1SIDHjvkxcZi5EvGzT0qta/S9pZFSzINuCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538042; c=relaxed/simple;
	bh=XeaEaox6hE414P2S4pbvJ+ZOuxNVhudeaZWZheWvRYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAmBJ9mcEAwA6R+ihv+V2E3/eQBL+ha2Iuv91cjnyFuZB18whV4aShca37L1Cav17sOYc1tzg71Ek+hYOlrijFLwrK/K52kQK44tTFOUIBuUxmTZRyShKKp+w3p4m1dkAqSZzeh49hEmiRLCi2DIZOvn8nGgyrXQzQCWL7GOCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t09f8tuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A994FC433F1;
	Wed, 21 Feb 2024 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708538042;
	bh=XeaEaox6hE414P2S4pbvJ+ZOuxNVhudeaZWZheWvRYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t09f8tuzAWJq6UCSVXCEQMPo05RoClwUY8pUeIT3kTczagizzFUOerJFiGTlxkyP/
	 16PbsN0U5Z6+PeO5ZF1vYdUeEmNuRNucMsNAIQ4nC0nW1hfV9b3WzZDiI96pBaAUUL
	 TB2dcc515UzctMgxxklA07ZCykG7cuT+h3VRkv86c8I5shQV4d+Y41z9+bqkGIIWSi
	 OxhHABbiMlFeik3hxi8zbA7gBOynqJh5LeGZisdimKM5wF8qo6FHHpCumHLm8bKKLD
	 nQUWZVoCHwsUvxbDdOJ0mgj/Mk2JrQO+OeBnsFQTjvo7RI+8kTWduqfLk9ZZc5Ra1B
	 pEJUx9OoZ91Mw==
Date: Wed, 21 Feb 2024 17:53:57 +0000
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
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 1/1] net: dsa: microchip: Add support for
 bridge port isolation
Message-ID: <20240221175357.GE722610@kernel.org>
References: <20240221093429.802077-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221093429.802077-1-o.rempel@pengutronix.de>

On Wed, Feb 21, 2024 at 10:34:29AM +0100, Oleksij Rempel wrote:
> Implement bridge port isolation for KSZ switches. Enabling the isolation
> of switch ports from each other while maintaining connectivity with the
> CPU and other forwarding ports. For instance, to isolate swp1 and swp2
> from each other, use the following commands:
> - bridge link set dev swp1 isolated on
> - bridge link set dev swp2 isolated on
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> ---
> changes v2:
> - add comments and new lines
> 
>  drivers/net/dsa/microchip/ksz_common.c | 55 +++++++++++++++++++++++---
>  drivers/net/dsa/microchip/ksz_common.h |  1 +
>  2 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 7cd37133ec05..efe54c9492e8 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1898,6 +1898,29 @@ static void ksz_get_strings(struct dsa_switch *ds, int port,
>  	}
>  }
>  
> +/**
> + * ksz_adjust_port_member - Adjust port forwarding rules based on STP state and
> + *			    isolation settings.
> + * @dev: A pointer to the struct ksz_device representing the device.
> + * @port: The port number to adjust.
> +
> + * This function dynamically adjusts the port membership configuration for a
> + * specified port and other device ports, based on Spanning Tree Protocol (STP)
> + * states and port isolation settings. Each port, including the CPU port, has a
> + * membership register, represented as a bitfield, where each bit corresponds
> + * to a port number. A set bit indicates permission to forward frames to that
> + * port. This function iterates over all ports, updating the membership register
> + * to reflect current forwarding permissions:
> + *
> + * 1. Forwards frames only to ports that are part of the same bridge group and
> + *    in the BR_STATE_FORWARDING state.
> + * 2. Takes into account the isolation status of ports; ports in the
> + *    BR_STATE_FORWARDING state with BR_ISOLATED configuration will not forward
> + *    frames to each other, even if they are in the same bridge group.
> + * 3. Ensures that the CPU port is included in the membership based on its
> + *    upstream port configuration, allowing for management and control traffic
> + *    to flow as required.
> + */
>  static void ksz_update_port_member(struct ksz_device *dev, int port)

..

Hi Oleksij,

I haven't looked over this patch closely.
But it does seem to have some Kernel doc problems.

  .../ksz_common.c:1905: warning: bad line:
  .../ksz_common.c:1924: warning: expecting prototype for ksz_adjust_port_member(). Prototype was for ksz_update_port_member() instead

You can observe these by running ./scripts/kernel-doc -none

I'm going to flag this as Changes Requested in patchwork
as typically this kind of problem gets flagged by bots sooner or later.

pw-bot: changes-requested


