Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12A679CFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjILLSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjILLS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:18:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D359B3;
        Tue, 12 Sep 2023 04:18:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bdcade7fbso687230166b.1;
        Tue, 12 Sep 2023 04:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694517501; x=1695122301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhPXBvdMzzFCCyh5EMSdfHYvamVPgNFZb56JwAkYJW4=;
        b=qPi1RPPRudYSueyiQ9Km1rU20EB98da1f80DqFz+q+cwIBYOgqAMDQwh37F9CjtYYA
         +/I9TN1cHwQGE1NV/2xW7WDtSx5pL0dqNikuncB4jfazdh4kYsceujYmfrC632da55e3
         ViFvxCKpNb7gpivAazsjGKSvIqXbL7bePNNXSeT58/l5F8XDDznEIZZGnj/d1qGReukv
         SkgRD35WyApkfGt7TUbvAmm7SEM32vPwT7oZCSZRx4dMmUnXzUxoJwqof2dLJUSL2PFj
         bofH5ODiXIJJrURrQ/vPcBw0o91gkWfUJNN+Yy7z7oEcSOjKRVKHvtXb3yTdQTS1pYAR
         cDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694517501; x=1695122301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhPXBvdMzzFCCyh5EMSdfHYvamVPgNFZb56JwAkYJW4=;
        b=PKa5mLQdJ7dgVpnE+yYXtT+p40Q1FnSoX0naLz23vN5O7wCVxzVzOmAgDXfSET9l7+
         9Rec9ie2DC9Wkw/lEavgmknhGWB4qZvyQt8JnSpuEzGuexcONk1Fe0iYrhLOSiOyky2W
         cOnqPsgiVkfSJnonpiM9qAMblAhFKNnbtw1DXgj6HfUZWqoN5murV4EGWAJ2HtI6ck8l
         bSzg+/GzROFbjgmDZlCL/uKiipthnPEvLpLLltaD6da5J0FQh7gC82jFqinAbZSvDZU0
         RVpG93hLuzuvQGFdaHSNOYoFmpO9VgPAEQYP/lblC5O9O+zJP7TXaXJ7pR9L4LmSyrtu
         E+SA==
X-Gm-Message-State: AOJu0YxLRO3apaBHl8fuAVwyYRVQRDsPF/HWmNgCS4PKnJb29Z5ghVab
        JiXuiTEc8kAMk1ZBdrleg64=
X-Google-Smtp-Source: AGHT+IHr3j/Z9WbW+qxDVCpzdXqnFbrHwVF/h+7J9fRRT7UdRP+cz1nhObFueliSVuHPWkOiI1BiRw==
X-Received: by 2002:a17:906:21b:b0:9a1:ea01:35a8 with SMTP id 27-20020a170906021b00b009a1ea0135a8mr11386487ejd.42.1694517501226;
        Tue, 12 Sep 2023 04:18:21 -0700 (PDT)
Received: from skbuf ([188.25.254.186])
        by smtp.gmail.com with ESMTPSA id us5-20020a170906bfc500b0099cfd0b2437sm6704754ejb.99.2023.09.12.04.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 04:18:20 -0700 (PDT)
Date:   Tue, 12 Sep 2023 14:18:18 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Petr Machata <petrm@nvidia.com>,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net-next v5 1/1] net: dsa: microchip: Add partial ACL
 support for ksz9477 switches
Message-ID: <20230912111818.kv6f6h6wq7nmzsrk@skbuf>
References: <20230912050047.1864783-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912050047.1864783-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

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

you can write "protocol ipv4" here.

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
> ---
> changes v5:
> - rebase on latest net-next
> 
> changes v4:
> - implement entry sorting according to the rule priority
> - use .port_setup to inti the ACL and .port_teardown to free it.
> - pass cookie directly to related functions and do not store it in the
>   acl privat struct.
> 
> changes v3:
> - fix double note warning in one of comments
> - convert ethtype to CPU endian before making byte order math.
> - init prio_val value and avoid currently false positive warning.
> 
> changes v2:
> - fix issues reported by the kernel test robot
>   Link: https://lore.kernel.org/oe-kbuild-all/202304121352.Fv5JpXcQ-lkp@intel.com/
> - add skbedit prio and remove hw_tc support
> - add some more clarifications about undocumented HW specific
>   behaviors.
> - Do more testing, compare it with tc software based implementation and
>   document results in the commit message.
> ---

The patch looks good to me. I only have some minor comments.

> +/**
> + * ksz9477_acl_get_cont_entr - Get count of contiguous ACL entries and validate
> + *                             the matching rules.
> + * @dev: Pointer to the KSZ9477 device structure.
> + * @port: Port number.
> + * @index: Index of the starting ACL entry.
> + *
> + * Based on the KSZ9477 switch's Access Control List (ACL) system, the RuleSet
> + * in an ACL entry indicates which entries contain Matching rules linked to it.
> + * This RuleSet is represented by two registers: KSZ9477_ACL_PORT_ACCESS_E and
> + * KSZ9477_ACL_PORT_ACCESS_F. Each bit set in these registers corresponds to
> + * an entry containing a Matching rule for this RuleSet.
> + *
> + * For a single Matching rule linked, only one bit is set. However, when an
> + * entry links multiple Matching rules, forming what's termed a 'complex rule',
> + * multiple bits are set in these registers.
> + *
> + * This function checks that, for complex rules, the entries containing the
> + * linked Matching rules are contiguous in terms of their indices. It calculates
> + * and returns the number of these contiguous entries.
> + *
> + * Return: Count of contiguous linked entries if part of a complex rule and
> + * validation is successful. Returns -EINVAL in case of validation failures, or
> + * 0 if the entry is empty and can be safely overwritten.

nit: this doesn't document -ENOTEMPTY, and that specific return code is
actually checked from ksz9477_get_next_block_start().

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

nit: "ret" set but not used

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
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index ee77c44e99f65..c93ecb2ce546e 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2628,6 +2628,45 @@ void ksz_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>  	ksz_update_port_member(dev, port);
>  }
>  
> +static int ksz_port_setup(struct dsa_switch *ds, int port)
> +{
> +	struct ksz_device *dev = ds->priv;
> +
> +	switch (dev->chip_id) {
> +	case KSZ8563_CHIP_ID:
> +	case KSZ9477_CHIP_ID:
> +	case KSZ9563_CHIP_ID:
> +	case KSZ9567_CHIP_ID:
> +	case KSZ9893_CHIP_ID:
> +	case KSZ9896_CHIP_ID:
> +	case KSZ9897_CHIP_ID:
> +		/* Theoretically, the ACL is supported on all ports, but
> +		 * currently we can't configure the CPU port for user space.
> +		 */
> +		if (dsa_is_user_port(ds, port))
> +			return ksz9477_port_acl_init(dev, port);
> +	}
> +
> +	return 0;
> +}

nit: Pretty confusing that dev->dev_ops->port_setup() is called from
dsa_switch_ops :: port_enable() (coming from ndo_open) and not from
dsa_switch_ops :: port_setup(). I wonder if it could be moved there as a
preparatory patch?

If you did that, you could also move ksz9477_port_acl_init() to
ksz9477_port_acl_init() and remove the checks based on dev->chip_id.

> +
> +static void ksz_port_teardown(struct dsa_switch *ds, int port)
> +{
> +	struct ksz_device *dev = ds->priv;
> +
> +	switch (dev->chip_id) {
> +	case KSZ8563_CHIP_ID:
> +	case KSZ9477_CHIP_ID:
> +	case KSZ9563_CHIP_ID:
> +	case KSZ9567_CHIP_ID:
> +	case KSZ9893_CHIP_ID:
> +	case KSZ9896_CHIP_ID:
> +	case KSZ9897_CHIP_ID:
> +		if (dsa_is_user_port(ds, port))
> +			ksz9477_port_acl_free(dev, port);
> +	}
> +}
> +
>  static int ksz_port_pre_bridge_flags(struct dsa_switch *ds, int port,
>  				     struct switchdev_brport_flags flags,
>  				     struct netlink_ext_ack *extack)
> @@ -3173,6 +3212,44 @@ static int ksz_switch_detect(struct ksz_device *dev)
>  	return 0;
>  }
