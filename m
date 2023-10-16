Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6EA7CA94A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjJPNXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPNXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:23:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B300AD;
        Mon, 16 Oct 2023 06:23:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso732091966b.1;
        Mon, 16 Oct 2023 06:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697462617; x=1698067417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xplfKxEu9H5pyuAr8acOn92DzGyWqIhk6bqTTc3uJ8E=;
        b=XDMna+BpMkRmYEccxbu7AlBDjLo7xZ4CNtmlFvaj0bf9ZkJ42b+R/sBxXDC1rgaY+Q
         4KBVXF/K/DRdyYFQfhk26usA27JXGTICUSYH3WsqIixFHRTq+Ot3GeK7QcWw954G+GLz
         ZmWMqOahR1dHT6roHzQNcH3G6iZhw/Iemlf8HVnmTPjK6uoO8Ah57o4bjG/W+L6yAFhG
         eeALbN9EN1imHWFMYN/75nvQv5JdNwJ9HHQhSB7paSNRPjBA05qqdXAwIitAQufLeiY5
         JCpv+oE4+Wn13izAxfoNmTEtuBgRK+ZlDfIvGMDLj50ioBNjElxx+h2BvfhcBxYHYC+H
         z9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697462617; x=1698067417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xplfKxEu9H5pyuAr8acOn92DzGyWqIhk6bqTTc3uJ8E=;
        b=qCdIL3xuapm7sQZqq67RdPQSn+kQ0LUcOKRlVJDpgWXUaGeufv1iBPnvxVQGXVoBlk
         jFIdOE5G4dan2XhNUQJ9ATDXDwlD3wQMaAqKSzSruxqz4uTxLn/XHK8iXCcM7JWslxao
         DVrQu3vOiLqiSIqWW0r6GI1Rw3dDXEo0q668bliuYuOiEiitTmiOnTyZUq/VXzyVmDlB
         3PQJxheX+RIwxzi06IQBudQdFTl611JiUxx/xt2AIWLoUgg9o6YGnOQfHnU2CvGp/eh2
         wnrMCACwe1dfPpFrwdfDkeXtvL4ZXo0G90vxDwfGdV9oZ2m/lsQjYijIeCYBV7RyrR5K
         AuZQ==
X-Gm-Message-State: AOJu0YxzGIV7Sy2iMIpReBw1XxD0h2XRIc60MSlWO5ox4j1MjK7XJtX+
        U4f997z9T6zuVy6UH2s2+EYu4CtAbKRN+w==
X-Google-Smtp-Source: AGHT+IGHGQXU64uDzVod2ZR+p9QX6+Cah5kteT0ccB58cq0G3W4x2qf0oDOJI8dusto3yF0DkwdEXw==
X-Received: by 2002:a17:906:dc89:b0:9bf:d70:fc6b with SMTP id cs9-20020a170906dc8900b009bf0d70fc6bmr5691421ejc.71.1697462616726;
        Mon, 16 Oct 2023 06:23:36 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id lu9-20020a170906fac900b0099bcf9c2ec6sm4044079ejb.75.2023.10.16.06.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:23:36 -0700 (PDT)
Date:   Mon, 16 Oct 2023 16:23:34 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v3 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231016132334.b5pz7kw5oitk32z2@skbuf>
References: <20231013215251.152912-1-florian.fainelli@broadcom.com>
 <20231013215251.152912-1-florian.fainelli@broadcom.com>
 <20231013215251.152912-2-florian.fainelli@broadcom.com>
 <20231013215251.152912-2-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013215251.152912-2-florian.fainelli@broadcom.com>
 <20231013215251.152912-2-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 02:52:50PM -0700, Florian Fainelli wrote:
> Use more inclusive terms throughout the DSA subsystem by moving away
> from "master" which is replaced by "conduit" and "slave" which is
> replaced by "user". No functional changes.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> diff --git a/Documentation/networking/dsa/configuration.rst b/Documentation/networking/dsa/configuration.rst
> index d2934c40f0f1..e6c9719874b0 100644
> --- a/Documentation/networking/dsa/configuration.rst
> +++ b/Documentation/networking/dsa/configuration.rst
> -Past this point, the DSA slave network devices get delivered regular Ethernet
> +Past this point, the DSA user network devices get delivered regular Ethernet
>  frames that can be processed by the networking stack.
>  
> -Slave network devices
> +User network devices
>  ---------------------

Please adjust section underline width.

Do we want a sentence in the documentation that clarifies that "user interfaces"
and "conduit interfaces" used to be called "slave interfaces" and "master interfaces"
(for 15 years), so that old time users don't get confused as to what happened?

> @@ -863,7 +863,7 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
>  }
>  
>  /* This enforces legacy behavior for switch drivers which assume they can't
> - * receive VLAN configuration when enslaved to a bridge with vlan_filtering=0
> + * receive VLAN configuration when enuserd to a bridge with vlan_filtering=0

when joining a bridge

>   */
>  bool dsa_port_skip_vlan_configuration(struct dsa_port *dp)
>  {
> @@ -1057,7 +1057,7 @@ static int dsa_switch_event(struct notifier_block *nb,
>  		err = dsa_switch_tag_8021q_vlan_del(ds, info);
>  		break;
>  	case DSA_NOTIFIER_MASTER_STATE_CHANGE:

As Stephen points out, maybe you want to change this notifier name as well.

> -		err = dsa_switch_master_state_change(ds, info);
> +		err = dsa_switch_conduit_state_change(ds, info);
>  		break;
>  	default:
>  		err = -EOPNOTSUPP;
> diff --git a/net/dsa/tag.h b/net/dsa/tag.h
> index 32d12f4a9d73..f6b9c73718df 100644
> --- a/net/dsa/tag.h
> +++ b/net/dsa/tag.h
> @@ -9,7 +9,7 @@
>  #include <net/dsa.h>
>  
>  #include "port.h"
> -#include "slave.h"
> +#include "user.h"
>  
>  struct dsa_tag_driver {
>  	const struct dsa_device_ops *ops;
> @@ -29,7 +29,7 @@ static inline int dsa_tag_protocol_overhead(const struct dsa_device_ops *ops)
>  	return ops->needed_headroom + ops->needed_tailroom;
>  }
>  
> -static inline struct net_device *dsa_master_find_slave(struct net_device *dev,
> +static inline struct net_device *dsa_conduit_find_user(struct net_device *dev,
>  						       int device, int port)

Please adjust alignment.

>  {
>  	struct dsa_port *cpu_dp = dev->dsa_ptr;
> diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
> index cbdfc392f7e0..71b26ae6db39 100644
> --- a/net/dsa/tag_8021q.c
> +++ b/net/dsa/tag_8021q.c
> @@ -468,10 +468,10 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
>  }
>  EXPORT_SYMBOL_GPL(dsa_8021q_xmit);
>  
> -struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *master,
> +struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
>  						   int vbid)

Alignment.

>  {
> -	struct dsa_port *cpu_dp = master->dsa_ptr;
> +	struct dsa_port *cpu_dp = conduit->dsa_ptr;
>  	struct dsa_switch_tree *dst = cpu_dp->dst;
>  	struct dsa_port *dp;
>  
> diff --git a/net/dsa/tag_8021q.h b/net/dsa/tag_8021q.h
> index b75cbaa028ef..41f7167ac520 100644
> --- a/net/dsa/tag_8021q.h
> +++ b/net/dsa/tag_8021q.h
> @@ -16,7 +16,7 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
>  void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
>  		   int *vbid);
>  
> -struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *master,
> +struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
>  						   int vbid);

Alignment.

> diff --git a/net/dsa/slave.c b/net/dsa/user.c
> similarity index 62%
> rename from net/dsa/slave.c
> rename to net/dsa/user.c
> index 4c3e502d7e16..c03e41e4e660 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/user.c
> @@ -2898,15 +2898,15 @@ static int dsa_slave_prechangeupper(struct net_device *dev,
>  	else if (netif_is_lag_master(info->upper_dev) && !info->linking)
>  		dsa_port_pre_lag_leave(dp, info->upper_dev);
>  	/* dsa_port_pre_hsr_leave is not yet necessary since hsr cannot be
> -	 * meaningfully enslaved to a bridge yet
> +	 * meaningfully enuserd to a bridge yet

"cannot be meaningfully be placed under a bridge yet"

>  	 */
>  
>  	return NOTIFY_DONE;
>  }
>  
>  static int
> -dsa_slave_lag_changeupper(struct net_device *dev,
> -			  struct netdev_notifier_changeupper_info *info)
> +dsa_user_lag_changeupper(struct net_device *dev,
> +			 struct netdev_notifier_changeupper_info *info)
>  {
>  	struct net_device *lower;
>  	struct list_head *iter;
> @@ -2991,7 +2991,7 @@ dsa_prevent_bridging_8021q_upper(struct net_device *dev,
>  	if (br_vlan_enabled(br) &&
>  	    netif_is_bridge_master(info->upper_dev) && info->linking) {
>  		NL_SET_ERR_MSG_MOD(ext_ack,
> -				   "Cannot enslave VLAN device into VLAN aware bridge");
> +				   "Cannot enuser VLAN device into VLAN aware bridge");

"Cannot make VLAN device join VLAN-aware bridge"

>  		return notifier_from_errno(-EINVAL);
>  	}
>  
> @@ -3050,17 +3050,17 @@ dsa_slave_prechangeupper_sanity_check(struct net_device *dev,
>  	}
>  
>  	if (is_vlan_dev(info->upper_dev))
> -		return dsa_slave_check_8021q_upper(dev, info);
> +		return dsa_user_check_8021q_upper(dev, info);
>  
>  	return NOTIFY_DONE;
>  }
>  
> -/* To be eligible as a DSA master, a LAG must have all lower interfaces be
> - * eligible DSA masters. Additionally, all LAG slaves must be DSA masters of
> +/* To be eligible as a DSA conduit, a LAG must have all lower interfaces be
> + * eligible DSA conduits. Additionally, all LAG users must be DSA conduits of

"Additionally, all LAG slaves" should not be replaced with "users".
"Lowers", "ports" or "slaves", preferably leaving it as "slaves" because
it isn't the topic of this patch.

>   * switches in the same switch tree.
>   */
> -static int dsa_lag_master_validate(struct net_device *lag_dev,
> -				   struct netlink_ext_ack *extack)
> +static int dsa_lag_conduit_validate(struct net_device *lag_dev,
> +				    struct netlink_ext_ack *extack)
>  {
>  	struct net_device *lower1, *lower2;
>  	struct list_head *iter1, *iter2;
> diff --git a/net/dsa/user.h b/net/dsa/user.h
> new file mode 100644
> index 000000000000..425ed9257858
> --- /dev/null
> +++ b/net/dsa/user.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef __DSA_OPERATIVE_H
> +#define __DSA_OPERATIVE_H

__DSA_USER_H

> +
> +#include <linux/if_bridge.h>
> +#include <linux/if_vlan.h>
> +#include <linux/list.h>
> +#include <linux/netpoll.h>
> +#include <linux/types.h>
> +#include <net/dsa.h>
> +#include <net/gro_cells.h>
