Return-Path: <linux-kernel+bounces-100944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB39879FED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC76C1C21A79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C73E5381A;
	Tue, 12 Mar 2024 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXgBWYl+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2A651C3B;
	Tue, 12 Mar 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287629; cv=none; b=Muh06ZoXi+J+ThHFynRmjXD0J4V0aQSB9bMZ0qFEkuAL40xGuENo3gLMBqR0g4h8Np/hY8LB1DLYa2QVazmsEjUjLVdsNhZ/YfxqOI1rBUFfip2wtB87N3gB0VSTTW1mNrU/IP/M2z3a5Eh7ANhKgpXxigQ58818+ClHF+8asTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287629; c=relaxed/simple;
	bh=QyUcVoiFBH6lEX6Up734N1/h/U5ZNuzaTmYYuEdRf30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqKnbtyfH8GobbAjhPdxPuqQgOikBO5Gp6WcbF2jm2Wp+FyEn8C0kUAnaWQih+wdeuDvev/huJX4l37J7faUe+34Ls8ZgkR2IG0TzxnOkTP56GZSP66DWcTv8csaGiWDG7Lrd6FL2E5BDj0IoaBQq03+/fUAAEAznwJbyPY/Au0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXgBWYl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7657AC433F1;
	Tue, 12 Mar 2024 23:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710287628;
	bh=QyUcVoiFBH6lEX6Up734N1/h/U5ZNuzaTmYYuEdRf30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fXgBWYl+S4cHuj5SvafvgWUAIUbapF+Lc6Im8xuIj2QZNLDbxPDpWngAf0RK+yn2g
	 8WIVUDN1N7v0rZglYiR1iuMLn39lLK7ZV4WiT/XtbF1+B5wawCY9QtSnkLOo4Rv6uJ
	 Y6kNH4UiqaeLA/vBMcIHIcgSADXe6OmNgQGcUmNh3YoPtcOPNvwx3/OlCNjFLn67Lb
	 Xc4Rp6XBAwOF2qaXHvyND5T33SXkiKBoWPV8SI82uubhCuS1OJ93CY/DDPmf/SxHp/
	 +Icm6dqeA5DTFFe4Ecaqs3+GMbzHxN4USNF79niJW+ekEBNzXnZGeYfZJqDAneYF9X
	 jHjS3G0SWY9uQ==
Date: Tue, 12 Mar 2024 16:53:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, corbet@lwn.net,
 davem@davemloft.net, dtatulea@nvidia.com, edumazet@google.com,
 gal@nvidia.com, hkallweit1@gmail.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, joabreu@synopsys.com, justinstitt@google.com,
 kory.maincent@bootlin.com, leon@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH RFC v2 1/6] ethtool: add interface to read Tx hardware
 timestamping statistics
Message-ID: <20240312165346.14ec1941@kernel.org>
In-Reply-To: <20240309084440.299358-2-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-2-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 Mar 2024 00:44:35 -0800 Rahul Rameshbabu wrote:
> Multiple network devices that support hardware timestamping appear to have
> common behavior with regards to timestamp handling. Implement common Tx
> hardware timestamping statistics in a tx_stats struct_group. Common Rx
> hardware timestamping statistics can subsequently be implemented in a
> rx_stats struct_group for ethtool_ts_stats.

>  Documentation/netlink/specs/ethtool.yaml | 20 +++++++++
>  include/linux/ethtool.h                  | 21 ++++++++++
>  include/uapi/linux/ethtool_netlink.h     | 15 +++++++
>  net/ethtool/tsinfo.c                     | 52 +++++++++++++++++++++++-
>  4 files changed, 107 insertions(+), 1 deletion(-)

Feels like we should mention the new stats somehow in 
Documentation/networking/ethtool-netlink.rst

> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 197208f419dc..f99b003c78c0 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -559,6 +559,21 @@ attribute-sets:
>        -
>          name: tx-lpi-timer
>          type: u32
> +  -
> +    name: ts-stat
> +    attributes:
> +      -
> +        name: pad
> +        type: pad

You can remove the pad entry, and...

> +      -
> +        name: tx-pkts
> +        type: u64

..use the uint type for the stats

> +      -
> +        name: tx-lost
> +        type: u64
> +      -
> +        name: tx-err
> +        type: u64
>    -
>      name: tsinfo
>      attributes:

> +/**
> + * struct ethtool_ts_stats - HW timestamping statistics
> + * @tx_stats: struct group for TX HW timestamping
> + *	@pkts: Number of packets successfully timestamped by the queried
> + *	      layer.
> + *	@lost: Number of packet timestamps that failed to get applied on a
> + *	      packet by the queried layer.
> + *	@err: Number of timestamping errors that occurred on the queried
> + *	     layer.

the kdocs for @lost and @err are not very clear

> + * @get_ts_stats: Query the device hardware timestamping statistics.

Let's copy & paste the "Drivers must not zero" text in here?
People seem to miss that requirement anyway, but at least we'll
have something to point at in review.

> +enum {
> +	ETHTOOL_A_TS_STAT_UNSPEC,
> +	ETHTOOL_A_TS_STAT_PAD,
> +
> +	ETHTOOL_A_TS_STAT_TX_PKT,			/* array, u64 */
> +	ETHTOOL_A_TS_STAT_TX_LOST,			/* array, u64 */
> +	ETHTOOL_A_TS_STAT_TX_ERR,			/* array, u64 */

I don't think these are arrays.

> +
> +	/* add new constants above here */
> +	__ETHTOOL_A_TS_STAT_CNT,
> +	ETHTOOL_A_TS_STAT_MAX = (__ETHTOOL_A_TS_STAT_CNT - 1)
> +
> +};

