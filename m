Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C86A79DB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjILVjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjILVjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:39:46 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F2E10CC;
        Tue, 12 Sep 2023 14:39:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bf66a32f25so79364641fa.2;
        Tue, 12 Sep 2023 14:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694554781; x=1695159581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2KwkPqAJQGEpAJQzIKOOCLdWJ7czGZpLD3jvsx8jZU=;
        b=px2dtja7ArwE4Y8/JdAhFZX9CSz3IJlvhxcr8s4VWQlgUOoxbfPFht1BjJt7zFDYdK
         n0AmfjUKpuUUqMIpIYAxpbzu1pKyTPDQfKuNy3tmfp8riHt6uwGgGY5ivfSwiiPPYQw4
         Tice3GL/Or03I8TV/ohGBlJFWLfwkEBMXagtjFK+wKwkIqs3f9Ne/ye4GuWY7Xawlm3L
         9t+hAV3bIz4+ZP8Bont4rf5wzK9LHfSvgKLbMq42cpzVwEfl1Z2WbZIBKJ3pVZt06a+R
         Kr5HXif1KjZIDn2oBVh//8EX43G2My5ib9NWfCTvJPQPWajqf5ey/2WVoFYitHlaT9Cw
         iVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694554781; x=1695159581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2KwkPqAJQGEpAJQzIKOOCLdWJ7czGZpLD3jvsx8jZU=;
        b=vbBoneONfu6XBu/1xZ+GS4bkUyXihI44i4bm7nJX4yoLRUcy0buSj1GT7AFtZ87NFP
         Gjs+vWYwAl6udd/p7desfQwduqi/jM/yir2lhK/OyKsaGxfvfgpg1uOUL7JirDb1AG2s
         Kp52YWB+1rXJXKeNTmei0CXN4PkxHzCOc61kGYTs7MgWuQB45Y1U9oLh+EkYz24GzUiY
         YnlcF6K1Kpwx1lefPK4GVTzBL0bM7i/EkW7ZwMyQPouWnuPvl7dQPsiOvf02T9019BSq
         Q+aCYpHIYks0zjhsi7rqHOivLziNfG4ifGCMprcENXkFDaKoDyGe2A6+tB6BI9cI2cAP
         RLfQ==
X-Gm-Message-State: AOJu0Yxc9dL4lrE2OBI0ySUZIrKDIDF5yoeCB5KI9V/wpTHN0H4as+nt
        xlYtyaaMrHCmDY3TsAkvcs0=
X-Google-Smtp-Source: AGHT+IHd/q2cvkuJB7PY12aHrsiNDv+TNywu46MmJm8CcJlM5rWEb/mlN3mLeMC1DQVmykOCeVcd2w==
X-Received: by 2002:a2e:87c8:0:b0:2b9:daa4:f4b6 with SMTP id v8-20020a2e87c8000000b002b9daa4f4b6mr622599ljj.45.1694554780476;
        Tue, 12 Sep 2023 14:39:40 -0700 (PDT)
Received: from skbuf ([188.25.254.186])
        by smtp.gmail.com with ESMTPSA id op5-20020a170906bce500b00992ea405a79sm7406451ejb.166.2023.09.12.14.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 14:39:40 -0700 (PDT)
Date:   Wed, 13 Sep 2023 00:39:37 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/8] net: dsa: vsc73xx: introduce tag 8021q
 for vsc73xx
Message-ID: <20230912213937.wqwiex32ojlojnue@skbuf>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-7-paweldembicki@gmail.com>
 <20230912122201.3752918-7-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912122201.3752918-7-paweldembicki@gmail.com>
 <20230912122201.3752918-7-paweldembicki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

On Tue, Sep 12, 2023 at 02:22:00PM +0200, Pawel Dembicki wrote:
> This commit introduces a new tagger based on 802.1q tagging.
> It's designed for the vsc73xx driver. The VSC73xx family doesn't have
> any tag support for the RGMII port, but it could be based on VLANs.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> diff --git a/net/dsa/tag_vsc73xx_8021q.c b/net/dsa/tag_vsc73xx_8021q.c
> new file mode 100644
> index 000000000000..9093a71e6eb0
> --- /dev/null
> +++ b/net/dsa/tag_vsc73xx_8021q.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/* Copyright (C) 2022 Pawel Dembicki <paweldembicki@gmail.com>

2022-2023 by now, maybe?

> + * Based on tag_sja1105.c:
> + * Copyright (c) 2019, Vladimir Oltean <olteanv@gmail.com>
> + */
> +#include <linux/dsa/8021q.h>
> +
> +#include "tag.h"
> +#include "tag_8021q.h"
> +
> +#define VSC73XX_8021Q_NAME "vsc73xx-8021q"
> +
> +static struct sk_buff *vsc73xx_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	struct dsa_port *dp = dsa_slave_to_port(netdev);
> +	u16 queue_mapping = skb_get_queue_mapping(skb);
> +	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
> +	u8 pcp;
> +
> +	if (skb->offload_fwd_mark) {
> +		unsigned int bridge_num = dsa_port_bridge_num_get(dp);
> +		struct net_device *br = dsa_port_bridge_dev_get(dp);
> +
> +		if (br_vlan_enabled(br))
> +			return skb;
> +
> +		tx_vid = dsa_tag_8021q_bridge_vid(bridge_num);
> +	}
> +
> +	pcp = netdev_txq_to_tc(netdev, queue_mapping);
> +
> +	return dsa_8021q_xmit(skb, netdev, ETH_P_8021Q,
> +			      ((pcp << VLAN_PRIO_SHIFT) | tx_vid));
> +}
> +
> +static void vsc73xx_vlan_rcv(struct sk_buff *skb, int *source_port,
> +			     int *switch_id, int *vbid, u16 *vid)
> +{
> +	if (vid_is_dsa_8021q(skb_vlan_tag_get(skb) & VLAN_VID_MASK))
> +		return dsa_8021q_rcv(skb, source_port, switch_id, vbid);
> +
> +	/* Try our best with imprecise RX */
> +	*vid = skb_vlan_tag_get(skb) & VLAN_VID_MASK;
> +}
> +
> +static struct sk_buff *vsc73xx_rcv(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	int src_port = -1, switch_id = -1, vbid = -1;
> +	u16 vid;
> +
> +	if (skb_vlan_tag_present(skb)) {
> +		/* Normal traffic path. */
> +		vsc73xx_vlan_rcv(skb, &src_port, &switch_id, &vbid, &vid);
> +	} else {
> +		netdev_warn(netdev, "Couldn't decode source port\n");
> +		return NULL;
> +	}
> +
> +	if (vbid >= 1)
> +		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
> +	else if (src_port == -1 || switch_id == -1)
> +		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
> +	else
> +		skb->dev = dsa_master_find_slave(netdev, switch_id, src_port);

Hmm, this isn't looking too good.

I think the fact that you had to add my copyright on what should be such
a simple thing as a VLAN-based tagger is a bad sign :)

It's time to consolidate some more stuff that currently lives in
tag_sja1105 and move it into tag_8021q so that you can reuse it more
easily.

I've prepared some (only compile-tested) patches on this branch here:
https://github.com/vladimiroltean/linux/commits/pawel-dembicki-vsc73xx-v3

I need to double-check that they don't introduce regressions, and we
should discuss the merging strategy. Probably you're going to submit
them together with your patch set.

With that, you can drop my part of the copyright :) The remainder should
look like straightforward use of API which can be written in only a
limited number of ways.

> +	if (!skb->dev) {
> +		netdev_warn(netdev, "Couldn't decode source port\n");
> +		return NULL;
> +	}
> +
> +	dsa_default_offload_fwd_mark(skb);
> +
> +	if (dsa_port_is_vlan_filtering(dsa_slave_to_port(skb->dev)) &&
> +	    eth_hdr(skb)->h_proto == htons(ETH_P_8021Q))
> +		__vlan_hwaccel_clear_tag(skb);

Why do you need to do this? We send VLAN-tagged packets to the
VLAN-aware bridge intentionally, so that it knows what VLAN they come
from (in the dsa_find_designated_bridge_port_by_vid() case). So don't
strip it if it's not causing a problem.

> +
> +	return skb;
> +}
