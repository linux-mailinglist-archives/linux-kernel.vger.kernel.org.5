Return-Path: <linux-kernel+bounces-91612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A48487143B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0108D284AC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F024381D9;
	Tue,  5 Mar 2024 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubp8Qqjj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4142F44;
	Tue,  5 Mar 2024 03:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609256; cv=none; b=Ic4qVT/Z+E+4ozh71VARHvfvA3I9xKZtj9bwZ+94YVQZosuOgMgB8ulN0LeAoFKx2metR2T/tVdel0UnO7L4oT6HPuUaiIlhUTU/Ef6iubCzkJa3vUAYwuPcUSGSp3qUggpD8Gi6L8DVXyEd7EmDdeZ2K2rNi24soFGlRofa+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609256; c=relaxed/simple;
	bh=8eLP8q/e1Jsj+5xYLAE+n9OlktnlF9oBMjjDVgvv7hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnWDYtUBnrpu1KY7JGhBSbNwLyB2dUZS+yNxAcEaou9L3hwv2H3D4c1uUVzEifiZQKHkwFSL3Xz+kpbbptsRkPPEXiJ9ZbI4BSSOVrfnvKvNtlQD0NiNKhjsau3MaKaamzv+VLiGfQSZzBk9f0tW4fpM6zGDCCW5qKTIOtApgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubp8Qqjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96519C433F1;
	Tue,  5 Mar 2024 03:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709609255;
	bh=8eLP8q/e1Jsj+5xYLAE+n9OlktnlF9oBMjjDVgvv7hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ubp8Qqjj7tv+dZb1x5FxPqHtxDW+xuHwE74HM4muyhRnmhct1cpkGYFQddKpvbdhS
	 zcbNy0vfk7aP0KlVmFtpMLTtQOBzGK8o/rzbMNWAy79GUUZYH7koCbkOV3imN9/FR8
	 qwNZbrWjUKkq0tiek5CtVS59n5z6hjxW1K0ysjR0VFk+mQKiOZzr6li6vxWlKDfbOb
	 aTmQXdYpIT8C1BPuYjeleRzf366Rqc5BwX2hMj3DvGhjB9UiahA2bzLB7ol++ks7J6
	 OPakSteX6xskjrDEL1Hz+zfU6WBe7Wp0xGhIYHiW2CGkBmoyV1DoB1Vz+uAzctxPh4
	 49fKiSvoUuVew==
Date: Mon, 4 Mar 2024 19:27:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v9 12/13] net: ethtool: tsinfo: Add support for
 hwtstamp provider and get/set hwtstamp config
Message-ID: <20240304192733.1e8e08cc@kernel.org>
In-Reply-To: <20240226-feature_ptp_netnext-v9-12-455611549f21@bootlin.com>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-12-455611549f21@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 14:40:03 +0100 Kory Maincent wrote:
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index b3f45c307301..37071929128a 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -426,6 +426,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] = {
>  	[const_ilog2(SOF_TIMESTAMPING_OPT_TX_SWHW)]  = "option-tx-swhw",
>  	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     = "bind-phc",
>  	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   = "option-id-tcp",
> +	[const_ilog2(SOF_TIMESTAMPING_GHWTSTAMP)]    = "get-hwtstamp",

What is this new SOF_TIMESTAMPING_GHWTSTAMP? If there's 
a good reason for it to exist it should be documented in
Documentation/networking/timestamping.rst

> +const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX + 1] = {
>  	[ETHTOOL_A_TSINFO_HEADER]		=
>  		NLA_POLICY_NESTED(ethnl_header_policy),
> +	[ETHTOOL_A_TSINFO_TIMESTAMPING] = { .type = NLA_NESTED },
> +	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST] = { .type = NLA_NESTED },

link the policy by NLA_POLICY_NESTED() so that user space can inspect
the sub-layers via the control family.

>  };
>  
> +static int
> +tsinfo_parse_request(struct ethnl_req_info *req_base, struct nlattr **tb,
> +		     struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *hwtst_tb[ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy)];
> +	struct tsinfo_req_info *req = TSINFO_REQINFO(req_base);
> +	unsigned long val = 0, mask = 0;
> +	int ret;
> +
> +	req->hwtst.index = -1;
> +
> +	if (tb[ETHTOOL_A_TSINFO_TIMESTAMPING]) {
> +		ret = ethnl_parse_bitset(&val, &mask, __SOF_TIMESTAMPING_CNT,
> +					 tb[ETHTOOL_A_TSINFO_TIMESTAMPING],
> +					 sof_timestamping_names, extack);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (val & SOF_TIMESTAMPING_GHWTSTAMP) {
> +			/* We support only the get of the current hwtstamp config
> +			 * for now.
> +			 */
> +			if (tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST])

NL_SET_ERR_MSG_ATTR(...)

> +				return -EOPNOTSUPP;
> +
> +			req->get_hwtstamp = true;
> +			return 0;
> +		}
> +	}
> +
> +	if (!tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST])
> +		return 0;
> +
> +	ret = nla_parse_nested(hwtst_tb,
> +			       ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy) - 1,
> +			       tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST],
> +			       ethnl_tsinfo_hwtstamp_provider_policy, extack);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX] ||
> +	    !hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER])
> +		return -EINVAL;

NL_REQ_ATTR_CHECK()

> +	ret = nla_get_u32(hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX]);
> +	if (ret < 0)
> +		return -EINVAL;

How's the get_u32 going to return a negative value?
That's the purpose of this check?
The policy should contain the max expected value - NLA_POLICY_MAX().

> +	req->hwtst.index = ret;
> +
> +	ret = nla_get_u32(hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER]);
> +	if (ret < 0 || HWTSTAMP_PROVIDER_QUALIFIER_CNT <= ret)
> +		return -EINVAL;
> +	req->hwtst.qualifier = ret;
> +
> +	return 0;
> +}
> +
>  static int tsinfo_prepare_data(const struct ethnl_req_info *req_base,
>  			       struct ethnl_reply_data *reply_base,
>  			       const struct genl_info *info)
>  {
>  	struct tsinfo_reply_data *data = TSINFO_REPDATA(reply_base);
> +	struct tsinfo_req_info *req = TSINFO_REQINFO(req_base);
>  	struct net_device *dev = reply_base->dev;
>  	int ret;
>  
>  	ret = ethnl_ops_begin(dev);
>  	if (ret < 0)
>  		return ret;
> -	ret = __ethtool_get_ts_info(dev, &data->ts_info);
> +
> +	if (!netif_device_present(dev)) {

 ethnl_ops_begin() checks for presence

> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (req->get_hwtstamp) {
> +		struct kernel_hwtstamp_config cfg = {};
> +
> +		if (!dev->netdev_ops->ndo_hwtstamp_get) {
> +			ret = -EOPNOTSUPP;
> +			goto out;
> +		}
> +
> +		ret = dev_get_hwtstamp_phylib(dev, &cfg);
> +		data->hwtst_config.tx_type = BIT(cfg.tx_type);
> +		data->hwtst_config.rx_filter = BIT(cfg.rx_filter);
> +		data->hwtst_config.flags = BIT(cfg.flags);
> +		goto out;
> +	}

This goto could be an else

> +	if (req->hwtst.index != -1) {
> +		struct hwtstamp_provider hwtstamp;
> +
> +		hwtstamp.ptp = ptp_clock_get_by_index(req->hwtst.index);
> +		if (!hwtstamp.ptp) {
> +			ret = -ENODEV;
> +			goto out;
> +		}
> +		hwtstamp.qualifier = req->hwtst.qualifier;
> +
> +		ret = ethtool_get_ts_info_by_phc(dev, &data->ts_info,
> +						 &hwtstamp);
> +	} else {
> +		ret = __ethtool_get_ts_info(dev, &data->ts_info);

Not sure I grok why we need 3 forms of getting the tstamp config.

Please make sure to always update
Documentation/networking/ethtool-netlink.rst
when extending ethtool-nl.

> +	}
> +
> +out:
>  	ethnl_ops_complete(dev);
>  
>  	return ret;
>  }

> +	if (ts_info->phc_index >= 0) {
> +		/* _TSINFO_HWTSTAMP_PROVIDER_NEST */
> +		len += nla_total_size(sizeof(u32) * 2);

That translates to two raw u32s into a single attribute.
Is that what you mean?

>  		len += nla_total_size(sizeof(u32));	/* _TSINFO_PHC_INDEX */
> +	}
>  
>  	return len;
>  }
>  


> +	if (ts_info->phc_index >= 0) {
> +		ret = nla_put_u32(skb, ETHTOOL_A_TSINFO_PHC_INDEX,
> +				  ts_info->phc_index);
> +		if (ret)
> +			return -EMSGSIZE;
> +
> +		nest = nla_nest_start(skb, ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST);
> +		if (!nest)
> +			return -EMSGSIZE;
> +
> +		ret = nla_put_u32(skb,
> +				  ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX,
> +				  ts_info->phc_index);

You can assume nla_put_u32 only returns EMSGSIZE, so doing:

if (nla_put_u32(....) ||
    nla_put_u32(....))
	return -EMSGSIZE;

is generally considered to be fine.

> +		if (ret) {
> +			nla_nest_cancel(skb, nest);
> +			return ret;
> +		}
> +
> +		ret = nla_put_u32(skb,
> +				  ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER,
> +				  ts_info->phc_qualifier);
> +		if (ret) {
> +			nla_nest_cancel(skb, nest);
> +			return ret;
> +		}
> +
> +		nla_nest_end(skb, nest);
> +	}
> +	return 0;
> +}

> +static int ethnl_set_tsinfo(struct ethnl_req_info *req_base,
> +			    struct genl_info *info)
> +{
> +	struct nlattr *hwtst_tb[ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy)];
> +	unsigned long mask = 0, req_rx_filter, req_tx_type;
> +	struct kernel_hwtstamp_config hwtst_config = {0};
> +	struct net_device *dev = req_base->dev;
> +	struct hwtstamp_provider hwtstamp;
> +	struct nlattr **tb = info->attrs;
> +	int ret, phc_index = 0;
> +	bool mod = false;
> +
> +	BUILD_BUG_ON(__HWTSTAMP_TX_CNT > 32);
> +	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT > 32);
> +
> +	if (!netif_device_present(dev))
> +		return -ENODEV;
> +
> +	if (tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST]) {
> +		ret = nla_parse_nested(hwtst_tb,
> +				       ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy) - 1,
> +				       tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST],
> +				       ethnl_tsinfo_hwtstamp_provider_policy, info->extack);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (!hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX] ||
> +		    !hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER])
> +			return -EINVAL;
> +
> +		memcpy(&hwtstamp, &dev->hwtstamp, sizeof(hwtstamp));
> +		if (hwtstamp.ptp)
> +			phc_index = ptp_clock_index(hwtstamp.ptp);
> +
> +		ethnl_update_u32(&phc_index,
> +				 hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX],
> +				 &mod);
> +		ethnl_update_u32(&hwtstamp.qualifier,
> +				 hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER],
> +				 &mod);
> +
> +		/* Does the hwtstamp supported in the netdev topology */
> +		if (mod) {
> +			hwtstamp.ptp = ptp_clock_get_by_index(phc_index);

This just returns a pointer without any refcounting, right?
What guarantees the ptp object doesn't disappear?

> +			if (!hwtstamp.ptp)
> +				return -ENODEV;
> +
> +			if (!netdev_support_hwtstamp(dev, &hwtstamp))
> +				return -ENODEV;

these need extacks

> +		}
> +	}

