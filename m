Return-Path: <linux-kernel+bounces-153985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FE38AD5AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE369281135
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6CD1553BE;
	Mon, 22 Apr 2024 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8DUaG7l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2EE15532F;
	Mon, 22 Apr 2024 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816663; cv=none; b=lHRUhfJHVpOnmDruaC+zHN5f64NpTtzOvokSVALsindgmzwAmG95+m4BZZd88HzwCAPTPtFTyjlsDqOFiX5qqQvDWvUCwYFg4IjYJsmUoKaGkUI5mf6T0AMjor/yWJsKwW6u1u8YQAyPPKjk2te+qbo/z3L/3Uf7w1ofSS5el/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816663; c=relaxed/simple;
	bh=8OXJv3D3XB9FIg16Ygxe6dGNkOlCc0SqV2Syf7zCGNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l16S0gIREC4XHH53I1uTted6UXY/N54IxjuoV6LBPKeqWT84oDSw9klmtQDyCbJwGWH/gblACf17Pl9Gm37oZ5R2wpqIzT0iBDFzJGR1RSz/xdA3JL0u+MtZKT/pKkKQUvdGIV2tpPCRjB8PcfpCtwgtJSVX7U0jIFXhVj8yBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8DUaG7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0279DC116B1;
	Mon, 22 Apr 2024 20:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713816663;
	bh=8OXJv3D3XB9FIg16Ygxe6dGNkOlCc0SqV2Syf7zCGNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8DUaG7l8cWyh+/TFEZenyVAA06XGzbUh+z4QnSZy/SyPW5buJ/voty+9FGtneeKy
	 oat9XU1D4hCku43EV76z1zlYbnKkvV2RRdLhH4+07d2JN6jwQVBH1ye0hxnOtnmI8N
	 FvOl9zJX+AOVDQ6IAyTmRp4tuvYDY8Fz/9Imw9qoBDzJZhlIkBypeUuB910of2od/p
	 OcZSRna5KKmpXistUZzmtTsJ6WY3JIgZXl42fhqqHArdu2Uv+aiIJll7fDZSqTk+mu
	 eVLEeoBOXQ9CZF0zme8afvDh18EaEsahon1VcjzPND/52FRf6ir7kza0MiZ7IOfw+e
	 Ti12kNzspTF4Q==
Date: Mon, 22 Apr 2024 21:10:55 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v11 12/13] net: ethtool: tsinfo: Add support for
 hwtstamp provider and get/set hwtstamp config
Message-ID: <20240422201055.GG42092@kernel.org>
References: <20240422-feature_ptp_netnext-v11-0-f14441f2a1d8@bootlin.com>
 <20240422-feature_ptp_netnext-v11-12-f14441f2a1d8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-feature_ptp_netnext-v11-12-f14441f2a1d8@bootlin.com>

On Mon, Apr 22, 2024 at 02:50:27PM +0200, Kory Maincent wrote:
> Enhance 'get' command to retrieve tsinfo of hwtstamp providers within a
> network topology and read current hwtstamp configuration.
> 
> Introduce support for ETHTOOL_MSG_TSINFO_SET ethtool netlink socket to
> configure hwtstamp of a PHC provider. Note that simultaneous hwtstamp
> isn't supported; configuring a new one disables the previous setting.
> 
> Also, add support for a specific dump command to retrieve all hwtstamp
> providers within the network topology, with added functionality for
> filtered dump to target a single interface.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Hi Kory,

Some minor feedback from my side.

> diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
> index 23b43f59fcfb..f901394507b3 100644
> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -426,6 +426,43 @@ struct ptp_clock *ptp_clock_get_by_index(struct device *dev, int index);
>  
>  void ptp_clock_put(struct device *dev, struct ptp_clock *ptp);
>  
> +/**
> + * netdev_ptp_clock_find() - obtain the next PTP clock in the netdev
> + *			     topology
> + *
> + * @dev:    Pointer of the net device
> + * @indexp:  Pointer of ptp clock index start point
> + */

Recently -Wall was added to the kernel CI ./scripts/kernel-doc -none
test, which means that Kernel docs are now expected to
document return values. It would be nice to add them for new
code.

> +
> +struct ptp_clock *netdev_ptp_clock_find(struct net_device *dev,
> +					unsigned long *indexp);

..

> diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c

..

> -const struct nla_policy ethnl_tsinfo_get_policy[] = {
> +const struct nla_policy
> +ethnl_tsinfo_hwtstamp_provider_policy[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_MAX + 1] = {

ethnl_tsinfo_hwtstamp_provider_policy seems to only be used in this file,
so it should be static.

> +	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX] =
> +		NLA_POLICY_MIN(NLA_S32, 0),
> +	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER] =
> +		NLA_POLICY_MAX(NLA_U32, HWTSTAMP_PROVIDER_QUALIFIER_CNT - 1)
> +};
> +
> +const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX + 1] = {
>  	[ETHTOOL_A_TSINFO_HEADER]		=
>  		NLA_POLICY_NESTED(ethnl_header_policy_stats),
> +	[ETHTOOL_A_TSINFO_GHWTSTAMP] =
> +		NLA_POLICY_MAX(NLA_U8, 1),
> +	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST] =
> +		NLA_POLICY_NESTED(ethnl_tsinfo_hwtstamp_provider_policy),
>  };

..

> +static int ethnl_tsinfo_dump_one_ptp(struct sk_buff *skb, struct net_device *dev,
> +				     struct netlink_callback *cb,
> +				     struct ptp_clock *ptp)
> +{
> +	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
> +	struct tsinfo_reply_data *reply_data;
> +	struct tsinfo_req_info *req_info;
> +	void *ehdr;
> +	int ret;
> +
> +	reply_data = ctx->reply_data;
> +	req_info = ctx->req_info;
> +	req_info->hwtst.index = ptp_clock_index(ptp);
> +
> +	for (; ctx->pos_phcqualifier < HWTSTAMP_PROVIDER_QUALIFIER_CNT;
> +	     ctx->pos_phcqualifier++) {
> +		if (!netdev_support_hwtstamp_qualifier(dev,
> +						       ctx->pos_phcqualifier))
> +			continue;
> +
> +		ehdr = ethnl_dump_put(skb, cb,
> +				      ETHTOOL_MSG_TSINFO_GET_REPLY);
> +		if (!ehdr)
> +			return -EMSGSIZE;
> +
> +		memset(reply_data, 0, sizeof(*reply_data));
> +		reply_data->base.dev = dev;
> +		req_info->hwtst.qualifier = ctx->pos_phcqualifier;
> +		ret = tsinfo_prepare_data(&req_info->base,
> +					  &reply_data->base,
> +					  genl_info_dump(cb));
> +		if (ret < 0)
> +			break;
> +
> +		ret = ethnl_fill_reply_header(skb, dev,
> +					      ETHTOOL_A_TSINFO_HEADER);
> +		if (ret < 0)
> +			break;
> +
> +		ret = tsinfo_fill_reply(skb, &req_info->base,
> +					&reply_data->base);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	reply_data->base.dev = NULL;
> +	if (ret < 0)
> +		genlmsg_cancel(skb, ehdr);
> +	else
> +		genlmsg_end(skb, ehdr);

I suppose it can't occur, but if the for loop iterates zero times,
then ret and ehdr will be uninitialised here.

Flagged by Smatch.

> +	return ret;
> +}

..

