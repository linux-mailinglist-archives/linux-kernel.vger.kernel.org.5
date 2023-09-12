Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6979D9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjILUIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjILUIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:08:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CB810D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:08:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B849C433C8;
        Tue, 12 Sep 2023 20:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694549287;
        bh=2zowEANPGHQm2tx4WsDlwrTwbvyhGnBL+AaGB6za6lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKkRVlhKEB1HAYTOQdwfccJ2J6ZBitxFe/dakMUZgXm0mvuKLgisyR3CBKdB/RwmT
         FWhVcngHDH7F2Zv9E/VUxCVxeiaF9tyFDnkNFiWIIpAyE55eQg312WEEchfEnTwtcP
         QACs6PTfiZ/PGEP0xzwBHoGqsN/yQcngGQqQnu7ccgP9kw+AIu6ElOn8d4m09BmLZo
         6y5GSipykUAipXKyb27fGpADbdfzTMEmjVqzxTR/5ODBxcj6CRboXR5Cm9zAKsccKW
         Rrx7Psm1x0nUYOXHVUmJ5diLTArXb5/NOoXzR5+QFlBPXVc0ms7TXZAzRyMRxCRoxP
         cKnHhUW0hXpBw==
Date:   Tue, 12 Sep 2023 22:08:00 +0200
From:   Simon Horman <horms@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Petr Machata <petrm@nvidia.com>,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net-next v5 1/1] net: dsa: microchip: Add partial ACL
 support for ksz9477 switches
Message-ID: <20230912200800.GO401982@kernel.org>
References: <20230912050047.1864783-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912050047.1864783-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 07:00:46AM +0200, Oleksij Rempel wrote:
> This patch adds partial Access Control List (ACL) support for the
> ksz9477 family of switches. ACLs enable filtering of incoming layer 2
> MAC, layer 3 IP, and layer 4 TCP/UDP packets on each port. They provide
> additional capabilities for filtering routed network protocols and can
> take precedence over other forwarding functions.
> 
> ACLs can filter ingress traffic based on header fields such as
> source/destination MAC address, EtherType, IPv4 address, IPv4 protocol,
> UDP/TCP ports, and TCP flags. The ACL is an ordered list of up to 16
> access control rules programmed into the ACL Table. Each entry specifies
> a set of matching conditions and action rules for controlling packet
> forwarding and priority.
> 
> The ACL also implements a count function, generating an interrupt
> instead of a forwarding action. It can be used as a watchdog timer or an
> event counter. The ACL consists of three parts: matching rules, action
> rules, and processing entries. Multiple match conditions can be either
> AND'ed or OR'ed together.
> 
> This patch introduces support for a subset of the available ACL
> functionality, specifically layer 2 matching and prioritization of
> matched packets. For example:
> 
> tc qdisc add dev lan2 clsact
> tc filter add dev lan2 ingress protocol 0x88f7 flower action skbedit prio 7
> 
> tc qdisc add dev lan1 clsact
> tc filter add dev lan1 ingress protocol 0x88f7 flower action skbedit prio 7
> 
> The hardware offloading implementation was benchmarked against a
> configuration without hardware offloading. This latter setup relied on a
> software-based Linux bridge. No noticeable differences were observed
> between the two configurations. Here is an example of software-based
> test:
> 
> ip l s dev enu1u1 up
> ip l s dev enu1u2 up
> ip l s dev enu1u4 up
> ethtool -A enu1u1 autoneg off rx off tx off
> ethtool -A enu1u2 autoneg off rx off tx off
> ethtool -A enu1u4 autoneg off rx off tx off
> ip l a name br0 type bridge
> ip l s dev br0 up
> ip l s enu1u1 master br0
> ip l s enu1u2 master br0
> ip l s enu1u4 master br0
> 
> tc qdisc add dev enu1u1 root handle 1:  ets strict 4 priomap 3 3 2 2 1 1 0 0
> tc qdisc add dev enu1u4 root handle 1:  ets strict 4 priomap 3 3 2 2 1 1 0 0
> tc qdisc add dev enu1u2 root handle 1:  ets strict 4 priomap 3 3 2 2 1 1 0 0
> 
> tc qdisc add dev enu1u1 clsact
> tc filter add dev enu1u1 ingress protocol 0x0800  flower action skbedit prio 7
> 
> tc qdisc add dev enu1u4 clsact
> tc filter add dev enu1u4 ingress protocol 0x0800  flower action skbedit prio 0
> 
> On a system attached to the port enu1u2 I run two iperf3 server
> instances:
> iperf3 -s -p 5210 &
> iperf3 -s -p 5211 &
> 
> On systems attached to enu1u4 and enu1u1 I run:
> iperf3 -u -c  172.17.0.1 -p 5210 -b100M  -l1472 -t100
> and
> iperf3 -u -c  172.17.0.1 -p 5211 -b100M  -l1472 -t100
> 
> As a result, IP traffic on port enu1u1 will be prioritized and take
> precedence over IP traffic on port enu1u4
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Hi Oleksij,

some minor feedback from my side.

> diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
> index a6f425866a29a..7a59923ff7b5c 100644
> --- a/drivers/net/dsa/microchip/ksz9477.h
> +++ b/drivers/net/dsa/microchip/ksz9477.h
> @@ -57,4 +57,40 @@ int ksz9477_switch_init(struct ksz_device *dev);
>  void ksz9477_switch_exit(struct ksz_device *dev);
>  void ksz9477_port_queue_split(struct ksz_device *dev, int port);
>  
> +int ksz9477_port_acl_init(struct ksz_device *dev, int port);
> +void ksz9477_port_acl_free(struct ksz_device *dev, int port);
> +int ksz9477_cls_flower_add(struct dsa_switch *ds, int port,
> +			   struct flow_cls_offload *cls, bool ingress);
> +int ksz9477_cls_flower_del(struct dsa_switch *ds, int port,
> +			   struct flow_cls_offload *cls, bool ingress);
> +
> +#define KSZ9477_ACL_ENTRY_SIZE		18
> +#define KSZ9477_ACL_MAX_ENTRIES		16
> +
> +struct ksz9477_acl_entry {
> +	u8 entry[KSZ9477_ACL_ENTRY_SIZE];
> +	unsigned long cookie;
> +	u32 prio;
> +};
> +
> +struct ksz9477_acl_entries {
> +	struct ksz9477_acl_entry entries[KSZ9477_ACL_MAX_ENTRIES];
> +	int entries_count;
> +};
> +
> +struct ksz9477_acl_priv {
> +	struct ksz9477_acl_entries acles;
> +};
> +
> +void ksz9477_acl_remove_entries(struct ksz_device *dev, int port,
> +				struct ksz9477_acl_entries *acles,
> +				unsigned long cookie);
> +int ksz9477_acl_write_list(struct ksz_device *dev, int port);
> +int ksz9477_sort_acl_entries(struct ksz_device *dev, int port);
> +void ksz9477_acl_action_rule_cfg(u8 *entry, bool force_prio, u8 prio_val);
> +void ksz9477_acl_processing_rule_set_action(u8 *entry, u8 action_idx);
> +void ksz9477_acl_match_process_l2(struct ksz_device *dev, int port,
> +				  __be16 ethtype, u8 *src_mac, u8 *dst_mac,

Here the type of the 3rd parameter is __be32.
But in the definition of the function in sz9477_acl.c the type us u16.
It is also passed an u16 when called in ksz9477_flower_parse_key_l2().

As flagged by Sparse.

> +				  unsigned long cookie, u32 prio);
> +
>  #endif
> diff --git a/drivers/net/dsa/microchip/ksz9477_acl.c b/drivers/net/dsa/microchip/ksz9477_acl.c

...

> +/**
> + * ksz9477_acl_remove_entries - Remove ACL entries with a given cookie from a
> + *                              specified ksz9477_acl_entries structure.
> + * @dev: The ksz_device instance.
> + * @port: The port number on which to remove ACL entries.
> + * @acles: The ksz9477_acl_entries instance.
> + * @cookie: The cookie value to match for entry removal.
> + *
> + * This function iterates through the entries array, removing any entries with
> + * a matching cookie value. The remaining entries are then shifted down to fill
> + * the gap.
> + */
> +void ksz9477_acl_remove_entries(struct ksz_device *dev, int port,
> +				struct ksz9477_acl_entries *acles,
> +				unsigned long cookie)
> +{
> +	int entries_count = acles->entries_count;
> +	int ret, i, src_count;
> +	int src_idx = -1;
> +
> +	if (!entries_count)
> +		return;
> +
> +	/* Search for the first position with the cookie */
> +	for (i = 0; i < entries_count; i++) {
> +		if (acles->entries[i].cookie == cookie) {
> +			src_idx = i;
> +			break;
> +		}
> +	}
> +
> +	/* No entries with the matching cookie found */
> +	if (src_idx == -1)
> +		return;
> +
> +	/* Get the size of the cookie entry. We may have complex entries. */
> +	src_count = ksz9477_acl_get_cont_entr(dev, port, src_idx);
> +	if (src_count <= 0)
> +		return;
> +
> +	/* Move all entries down to overwrite removed entry with the cookie */
> +	ret = ksz9477_move_entries_downwards(dev, acles, src_idx,
> +					     src_count,
> +					     entries_count - src_count);

ret us set here but otherwise unused.

As flagged by a W=1 build.

> +
> +	/* Overwrite new empty places at the end of the list with zeros to make
> +	 * sure not unexpected things will happen or no unexplored quirks will
> +	 * come out.
> +	 */
> +	for (i = entries_count - src_count; i < entries_count; i++) {
> +		struct ksz9477_acl_entry *entry = &acles->entries[i];
> +
> +		memset(entry, 0, sizeof(*entry));
> +
> +		/* Set all access bits to be able to write zeroed entry to HW */
> +		entry->entry[KSZ9477_ACL_PORT_ACCESS_10] = 0xff;
> +		entry->entry[KSZ9477_ACL_PORT_ACCESS_11] = 0xff;
> +	}
> +
> +	/* Adjust the total entries count */
> +	acles->entries_count -= src_count;
> +}

...

> +/**
> + * ksz9477_acl_match_process_l2 - Configure Layer 2 ACL matching rules and
> + *                                processing rules.
> + * @dev: Pointer to the ksz_device.
> + * @port: Port number.
> + * @ethtype: Ethernet type.
> + * @src_mac: Source MAC address.
> + * @dst_mac: Destination MAC address.
> + * @cookie: The cookie to associate with the entry.
> + * @prio: The priority of the entry.
> + *
> + * This function sets up matching and processing rules for Layer 2 ACLs.
> + * It takes into account that only one MAC per entry is supported.
> + */
> +void ksz9477_acl_match_process_l2(struct ksz_device *dev, int port,
> +				  u16 ethtype, u8 *src_mac, u8 *dst_mac,
> +				  unsigned long cookie, u32 prio)
> +{
> +	struct ksz9477_acl_priv *acl = dev->ports[port].acl_priv;
> +	struct ksz9477_acl_entries *acles = &acl->acles;
> +	struct ksz9477_acl_entry *entry;
> +
> +	entry = ksz9477_acl_get_init_entry(dev, port, cookie, prio);
> +
> +	/* ACL supports only one MAC per entry */
> +	if (src_mac && dst_mac) {
> +		ksz9477_acl_matching_rule_cfg_l2(entry->entry, ethtype, src_mac,
> +						 true);
> +
> +		/* Add both match entries to first processing rule */
> +		ksz9477_acl_processing_rule_add_match(entry->entry,
> +						      acles->entries_count);
> +		acles->entries_count++;
> +		ksz9477_acl_processing_rule_add_match(entry->entry,
> +						      acles->entries_count);
> +
> +		entry = ksz9477_acl_get_init_entry(dev, port, cookie, prio);
> +		ksz9477_acl_matching_rule_cfg_l2(entry->entry, 0, dst_mac,
> +						 false);
> +		acles->entries_count++;
> +	} else {
> +		u8 *mac = src_mac ? src_mac : dst_mac;
> +		bool is_src = src_mac ? true : false;
> +
> +		ksz9477_acl_matching_rule_cfg_l2(entry->entry, ethtype, mac,
> +						 is_src);
> +		ksz9477_acl_processing_rule_add_match(entry->entry,
> +						      acles->entries_count);
> +		acles->entries_count++;
> +	}
> +}
> diff --git a/drivers/net/dsa/microchip/ksz9477_tc_flower.c b/drivers/net/dsa/microchip/ksz9477_tc_flower.c
> new file mode 100644
> index 0000000000000..8b2f5be667e01
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/ksz9477_tc_flower.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2023 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
> +
> +#include "ksz9477.h"
> +#include "ksz9477_reg.h"
> +#include "ksz_common.h"
> +
> +#define ETHER_TYPE_FULL_MASK		cpu_to_be16(~0)
> +#define KSZ9477_MAX_TC			7
> +
> +/**
> + * ksz9477_flower_parse_key_l2 - Parse Layer 2 key from flow rule and configure
> + *                               ACL entries accordingly.
> + * @dev: Pointer to the ksz_device.
> + * @port: Port number.
> + * @extack: Pointer to the netlink_ext_ack.
> + * @rule: Pointer to the flow_rule.
> + * @cookie: The cookie to associate with the entry.
> + * @prio: The priority of the entry.
> + *
> + * This function parses the Layer 2 key from the flow rule and configures
> + * the corresponding ACL entries. It checks for unsupported offloads and
> + * available entries before proceeding with the configuration.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +static int ksz9477_flower_parse_key_l2(struct ksz_device *dev, int port,
> +				       struct netlink_ext_ack *extack,
> +				       struct flow_rule *rule,
> +				       unsigned long cookie, u32 prio)
> +{
> +	struct ksz9477_acl_priv *acl = dev->ports[port].acl_priv;
> +	struct flow_match_eth_addrs ematch;
> +	struct ksz9477_acl_entries *acles;
> +	int required_entries;
> +	u8 *src_mac = NULL;
> +	u8 *dst_mac = NULL;
> +	u16 ethtype = 0;
> +
> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
> +		struct flow_match_basic match;
> +
> +		flow_rule_match_basic(rule, &match);
> +
> +		if (match.key->n_proto) {
> +			if (match.mask->n_proto != ETHER_TYPE_FULL_MASK) {
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "ethernet type mask must be a full mask");
> +				return -EINVAL;
> +			}
> +
> +			ethtype = be16_to_cpu(match.key->n_proto);
> +		}
> +	}
> +
> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> +		flow_rule_match_eth_addrs(rule, &ematch);
> +
> +		if (!is_zero_ether_addr(ematch.key->src)) {
> +			if (!is_broadcast_ether_addr(ematch.mask->src))
> +				goto not_full_mask_err;
> +
> +			src_mac = ematch.key->src;
> +		}
> +
> +		if (!is_zero_ether_addr(ematch.key->dst)) {
> +			if (!is_broadcast_ether_addr(ematch.mask->dst))
> +				goto not_full_mask_err;
> +
> +			dst_mac = ematch.key->dst;
> +		}
> +	}
> +
> +	acles = &acl->acles;
> +	/* ACL supports only one MAC per entry */
> +	required_entries = src_mac && dst_mac ? 2 : 1;
> +
> +	/* Check if there are enough available entries */
> +	if (acles->entries_count + required_entries > KSZ9477_ACL_MAX_ENTRIES) {
> +		NL_SET_ERR_MSG_MOD(extack, "ACL entry limit reached");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ksz9477_acl_match_process_l2(dev, port, ethtype, src_mac, dst_mac,
> +				     cookie, prio);
> +
> +	return 0;
> +
> +not_full_mask_err:
> +	NL_SET_ERR_MSG_MOD(extack, "MAC address mask must be a full mask");
> +	return -EOPNOTSUPP;
> +}

...
