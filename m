Return-Path: <linux-kernel+bounces-8865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F6081BD62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C8EB2658B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C8364A9E;
	Thu, 21 Dec 2023 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d36LhB8w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1F973197;
	Thu, 21 Dec 2023 17:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EA8C433C9;
	Thu, 21 Dec 2023 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703180143;
	bh=ZwPaf2YiUAFo26j3q+Xlvg2stXM5VfmpeeF0eOmjf18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d36LhB8whBedTR6PvrUN8kBNxy5VVeXx/gnDo/RuoDW7EwBn3Ignp76RRvD4Kf+7m
	 3R8//3v7rzp5IqRQ/O1f2+4UfRIKrHaULzME/PN/3jAiFEYq0hmVGkBZ55+l9C3rp1
	 eubtwp0zXx1MvMSr3TMoB3j/tef37M07mxbt898/pKr69KHkyEyLc4RZox8yILGLTr
	 jNI6k4z88V5BvpCsX/drBcZ05xGDp3RjhV9O1JuhZRWxa4Qfjm5vtvEvz1oX6IWqhK
	 H85PInpBeHPVdrfZlinvKJv7ynW3tQblOcn/zlqNviuwu3X8wIe6V8yMwCYhzX29oh
	 ggf+TsBmwf6aQ==
Date: Thu, 21 Dec 2023 18:35:31 +0100
From: Simon Horman <horms@kernel.org>
To: Aahil Awatramani <aahila@google.com>
Cc: Mahesh Bandewar <maheshb@google.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] bonding: Extending LACP MUX State Machine to
 include a Collecting State.
Message-ID: <20231221173531.GA1202958@kernel.org>
References: <20231221023650.3208767-1-aahila@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221023650.3208767-1-aahila@google.com>

On Thu, Dec 21, 2023 at 02:36:50AM +0000, Aahil Awatramani wrote:
> Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
> the LACP MUX state machine for separated handling of an initial
> Collecting state before the Collecting and Distributing state. This
> enables a port to be in a state where it can receive incoming packets
> while not still distributing. This is useful for reducing packet loss when
> a port begins distributing before its partner is able to collect.
> Additionally this also brings the 802.3ad bonding driver's implementation
> closer to the LACP specification which already predefined this behaviour.
> 
> With this change, 802.3ad mode will use new
> bond_set_slave_txrx_{enabled|disabled}_flags() set of functions only
> instead of the earlier one (bond_set_slave_{active|inactive}_flags).
> Additionally, it adds new functions such as
> bond_set_slave_tx_disabled_flags and bond_set_slave_rx_enabled_flags to
> precisely manage the port's collecting and distributing states.
> Previously, there was no dedicated method to disable TX while keeping RX
> enabled, which this patch addresses.
> 
> Note that the regular flow process in the kernel's bonding driver remains
> unaffected by this patch. The extension requires explicit opt-in by the
> user (in order to ensure no disruptions for existing setups) via netlink
> or sysfs support using the new bonding parameter lacp_extended_mux. The
> default value for lacp_extended_mux is set to 0 so as to preserve existing
> behaviour.
> 
> Signed-off-by: Aahil Awatramani <aahila@google.com>

...

> @@ -1906,6 +2005,46 @@ static void ad_initialize_port(struct port *port, int lacp_fast)
>  	}
>  }
>  
> +/**
> + * ad_enable_collecting - enable a port's receive
> + * @port: the port we're looking at
> + * @update_slave_arr: Does slave array need update?

The line above documenting @update_slave_arr
should be removed as the parameter is not in
the function definition below.

> + *
> + * Enable @port if it's in an active aggregator
> + */
> +static void ad_enable_collecting(struct port *port)
> +{
> +	if (port->aggregator->is_active) {
> +		struct slave *slave = port->slave;
> +
> +		slave_dbg(slave->bond->dev, slave->dev,
> +			  "Enabling collecting on port %d (LAG %d)\n",
> +			  port->actor_port_number,
> +			  port->aggregator->aggregator_identifier);
> +		__enable_collecting_port(port);
> +	}
> +}

The above is a pretty minor problem, but the bots are likely
to complain about it, so please fix it in v2 after waiting
for feedback from others on this patch.

When posting v2 please target it at the net-next tree.

	Subject: [PATCH net-next v2] ...

-- 
pw-bot: changes-requested

