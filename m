Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF09763C54
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGZQZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGZQZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:25:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFD0269A;
        Wed, 26 Jul 2023 09:24:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fc02a92dcfso61041375e9.0;
        Wed, 26 Jul 2023 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690388695; x=1690993495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tZOrqlSx6EtPVrqiYjjcjHwrB6+YADDJ9NNf24wUkRM=;
        b=O1mGZNj9F6dB/a6sEeoBfOrX/GqHrM0d4XtpDlOUyrz7uWgoB5YU4ZAxcwNle4rx5y
         JF2P+VvHcBuvlodATqJ0IYWnB4bXBZzGMJTdydng/pQiNa/dZ9Wh0mHGRTOTU6E14EdO
         tPLCmrlwWENuCAfdgDOz0S5TrPp+5Pgl9ps5MSuHctQqtMl143kn/V+0KbgcpeOfvDhZ
         /zJoNk7y4lmRBjfZektwUl5p4ZZHaJJ9E4L5aTAyto4V26HkvZP2cs78kbIyNJnQ+KWS
         G0FaYFqjon7aUbyMONZX/ntAbTqS8QxbpIwIESG1CPu5OjapzgRXVZlkiSSk8WBx7l+P
         cPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388695; x=1690993495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZOrqlSx6EtPVrqiYjjcjHwrB6+YADDJ9NNf24wUkRM=;
        b=hvWy21t91t/VYRTk/UcktY1WJauPipGeFtFaMG5KpXKr/C7dTiwXhDun4EaS+xew4H
         h1sOwd5Uq+ivWlrrvgLTbl5AXgGgMUtCJPf93l+Zlgup4Du3iwm3KetvWvBmnasi192m
         XsbRX02pbrJubJltEkC97LI+v0s8psOm/EPJ9rBJZPpEYQ30eoD5DMWqUm1TqprslOrT
         GxpCuJ8peR3KsmoZRNsgi/4gWSIyJADS9M+0UJrhNZfPkdSc3pHrrpejYMO5NXbhgK8l
         8lFAW52yf8qTGgen7HIBdHFKqpo8/xGKLN3/b7gcE4mlUT0Lun87rPDsIUMgVFfMrlXf
         rl2w==
X-Gm-Message-State: ABy/qLZLsgehJQYWg1980F+t/Og62Lm7uCsTqPD+nr1atwryLJ97Yd/b
        3jgBo6mq/FAm6X2dPgmU0uA=
X-Google-Smtp-Source: APBJJlE874SGRQ/5+20oM8IlkB05LHm1Wr4201GS8pqfQg8RXTfhJ+HJjAX+1b486XDzlvs1jtwGLA==
X-Received: by 2002:adf:ea4b:0:b0:314:49d2:aaab with SMTP id j11-20020adfea4b000000b0031449d2aaabmr1870543wrn.8.1690388694753;
        Wed, 26 Jul 2023 09:24:54 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id m24-20020a056000181800b003143ac73fd0sm20301475wrh.1.2023.07.26.09.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:24:54 -0700 (PDT)
Date:   Wed, 26 Jul 2023 19:24:51 +0300
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
        Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next v2 1/1] net: dsa: microchip: Add partial ACL
 support for ksz9477 switches
Message-ID: <20230726162451.zmwjwdcifqdw5ilr@skbuf>
References: <20230721140224.1465766-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721140224.1465766-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 04:02:24PM +0200, Oleksij Rempel wrote:
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
> ---

Looks good to me. Just a few comments below.

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
>  drivers/net/dsa/microchip/Makefile            |   2 +-
>  drivers/net/dsa/microchip/ksz9477.c           |   7 +
>  drivers/net/dsa/microchip/ksz9477.h           |  33 +
>  drivers/net/dsa/microchip/ksz9477_acl.c       | 706 ++++++++++++++++++
>  drivers/net/dsa/microchip/ksz9477_tc_flower.c | 273 +++++++
>  drivers/net/dsa/microchip/ksz_common.c        |  40 +
>  drivers/net/dsa/microchip/ksz_common.h        |   1 +
>  7 files changed, 1061 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/dsa/microchip/ksz9477_acl.c
>  create mode 100644 drivers/net/dsa/microchip/ksz9477_tc_flower.c
> 
> diff --git a/drivers/net/dsa/microchip/Makefile b/drivers/net/dsa/microchip/Makefile
> index 48360cc9fc68a..49459a50dbc81 100644
> --- a/drivers/net/dsa/microchip/Makefile
> +++ b/drivers/net/dsa/microchip/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON)	+= ksz_switch.o
>  ksz_switch-objs := ksz_common.o
> -ksz_switch-objs += ksz9477.o
> +ksz_switch-objs += ksz9477.o ksz9477_acl.o ksz9477_tc_flower.o
>  ksz_switch-objs += ksz8795.o
>  ksz_switch-objs += lan937x_main.o
>  
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index 83b7f2d5c1ea6..f5d48310cbe8a 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -1100,6 +1100,7 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
>  int ksz9477_setup(struct dsa_switch *ds)
>  {
>  	struct ksz_device *dev = ds->priv;
> +	struct dsa_port *dp;
>  	int ret = 0;
>  
>  	ds->mtu_enforcement_ingress = true;
> @@ -1123,6 +1124,12 @@ int ksz9477_setup(struct dsa_switch *ds)
>  	/* queue based egress rate limit */
>  	ksz_cfg(dev, REG_SW_MAC_CTRL_5, SW_OUT_RATE_LIMIT_QUEUE_BASED, true);
>  
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		ret = ksz9477_port_acl_init(dev, dp->index);
> +		if (ret)
> +			return ret;

Feel free to introduce dsa_switch_for_each_user_port_continue_reverse()
in include/net/dsa.h when you perform the error teardown.

Also, regular teardown (ksz9477_port_acl_free()) should go to
dev->dev_ops->teardown() which I think that ksz9477 currently does not
provide.

There's also a ds->ops->port_setup() and ds->ops->port_teardown() pair
of methods that runs in the context that you need, but it rarely gets
used. You could mode the ACL initialization there.

> +	}
> +
>  	/* enable global MIB counter freeze function */
>  	ksz_cfg(dev, REG_SW_MAC_CTRL_6, SW_MIB_COUNTER_FREEZE, true);
>  
> diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
> index b6f7e3c46e3f9..26b488cd294ef 100644
> --- a/drivers/net/dsa/microchip/ksz9477.h
> +++ b/drivers/net/dsa/microchip/ksz9477.h
> @@ -59,4 +59,37 @@ int ksz9477_switch_init(struct ksz_device *dev);
>  void ksz9477_switch_exit(struct ksz_device *dev);
>  void ksz9477_port_queue_split(struct ksz_device *dev, int port);
>  
> +int ksz9477_port_acl_init(struct ksz_device *dev, int port);
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
> +};
> +
> +struct ksz9477_acl_entries {
> +	struct ksz9477_acl_entry entries[KSZ9477_ACL_MAX_ENTRIES];
> +	int entries_count;
> +	bool entries_unprocessed;
> +};
> +
> +struct ksz9477_acl_priv {
> +	struct ksz9477_acl_entries acles;
> +	unsigned long current_cookie;
> +};
> +
> +void ksz9477_acl_remove_entries(struct ksz9477_acl_entries *acles,
> +				unsigned long cookie);
> +int ksz9477_acl_write_list(struct ksz_device *dev, int port);
> +void ksz9477_acl_action_rule_cfg(u8 *entry, bool force_prio, u8 prio_val);
> +void ksz9477_acl_processing_rule_set_action(u8 *entry, u8 action_idx);
> +void ksz9477_acl_match_process_l2(struct ksz_device *dev, int port,
> +				  u16 ethtype, u8 *src_mac, u8 *dst_mac);
> +
>  #endif
> diff --git a/drivers/net/dsa/microchip/ksz9477_acl.c b/drivers/net/dsa/microchip/ksz9477_acl.c
> new file mode 100644
> index 0000000000000..60d01bf908d38
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/ksz9477_acl.c
> @@ -0,0 +1,706 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2023 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
> +
> +/* Access Control List (ACL) structure:
> + *
> + * There are multiple groups of registers involved in ACL configuration:
> + *
> + * - Matching Rules: These registers define the criteria for matching incoming
> + *   packets based on their header information (Layer 2 MAC, Layer 3 IP, or
> + *   Layer 4 TCP/UDP). Different register settings are used depending on the
> + *   matching rule mode (MD) and the Enable (ENB) settings.
> + *
> + * - Action Rules: These registers define how the ACL should modify the packet's
> + *   priority, VLAN tag priority, and forwarding map once a matching rule has
> + *   been triggered. The settings vary depending on whether the matching rule is
> + *   in Count Mode (MD = 01 and ENB = 00) or not.
> + *
> + * - Processing Rules: These registers control the overall behavior of the ACL,
> + *   such as selecting which matching rule to apply first, enabling/disabling
> + *   specific rules, or specifying actions for matched packets.
> + *
> + * ACL Structure:
> + *                             +----------------------+
> + * +----------------------+    |    (optional)        |
> + * |    Matching Rules    |    |    Matching Rules    |
> + * |    (Layer 2, 3, 4)   |    |    (Layer 2, 3, 4)   |
> + * +----------------------+    +----------------------+
> + *             |			   |

You might want to use spaces everywhere here.

> + *             \___________________________/
> + *                          v
> + *               +----------------------+
> + *               |   Processing Rules   |
> + *               | (action idx,	        |
> + *               | matching rule set)   |
> + *               +----------------------+
> + *                          |
> + *                          v
> + *               +----------------------+
> + *               |    Action Rules      |
> + *               | (Modify Priority,    |
> + *               |  Forwarding Map,     |
> + *               |  VLAN tag, etc)      |
> + *               +----------------------+
> + */
> +
> +#include "ksz9477.h"
> +#include "ksz9477_reg.h"
> +#include "ksz_common.h"
> +
> +#define KSZ9477_PORT_ACL_0		0x600
> +
> +enum ksz9477_acl_port_access {
> +	KSZ9477_ACL_PORT_ACCESS_0  = 0x00,
> +	KSZ9477_ACL_PORT_ACCESS_1  = 0x01,
> +	KSZ9477_ACL_PORT_ACCESS_2  = 0x02,
> +	KSZ9477_ACL_PORT_ACCESS_3  = 0x03,
> +	KSZ9477_ACL_PORT_ACCESS_4  = 0x04,
> +	KSZ9477_ACL_PORT_ACCESS_5  = 0x05,
> +	KSZ9477_ACL_PORT_ACCESS_6  = 0x06,
> +	KSZ9477_ACL_PORT_ACCESS_7  = 0x07,
> +	KSZ9477_ACL_PORT_ACCESS_8  = 0x08,
> +	KSZ9477_ACL_PORT_ACCESS_9  = 0x09,
> +	KSZ9477_ACL_PORT_ACCESS_A  = 0x0A,
> +	KSZ9477_ACL_PORT_ACCESS_B  = 0x0B,
> +	KSZ9477_ACL_PORT_ACCESS_C  = 0x0C,
> +	KSZ9477_ACL_PORT_ACCESS_D  = 0x0D,
> +	KSZ9477_ACL_PORT_ACCESS_E  = 0x0E,
> +	KSZ9477_ACL_PORT_ACCESS_F  = 0x0F,
> +	KSZ9477_ACL_PORT_ACCESS_10 = 0x10,
> +	KSZ9477_ACL_PORT_ACCESS_11 = 0x11
> +};
> +
> +#define KSZ9477_ACL_MD_MASK			GENMASK(5, 4)
> +#define KSZ9477_ACL_MD_DISABLE			0
> +#define KSZ9477_ACL_MD_L2_MAC			1
> +#define KSZ9477_ACL_MD_L3_IP			2
> +#define KSZ9477_ACL_MD_L4_TCP_UDP		3
> +
> +#define KSZ9477_ACL_ENB_MASK			GENMASK(3, 2)
> +#define KSZ9477_ACL_ENB_L2_TYPE			1
> +#define KSZ9477_ACL_ENB_L2_MAC			2
> +#define KSZ9477_ACL_ENB_L2_MAC_TYPE		3
> +
> +/* only IPv4 src or dst can be used with mask */
> +#define KSZ9477_ACL_ENB_L3_IPV4_ADDR_MASK	1
> +/* only IPv4 src and dst can be used without mask */
> +#define KSZ9477_ACL_ENB_L3_IPV4_ADDR_SRC_DST	2
> +
> +#define KSZ9477_ACL_ENB_L4_IP_PROTO	        0
> +#define KSZ9477_ACL_ENB_L4_TCP_SRC_DST_PORT	1
> +#define KSZ9477_ACL_ENB_L4_UDP_SRC_DST_PORT	2
> +#define KSZ9477_ACL_ENB_L4_TCP_SEQ_NUMBER	3
> +
> +#define KSZ9477_ACL_SD_SRC			BIT(1)
> +#define KSZ9477_ACL_SD_DST			0
> +#define KSZ9477_ACL_EQ_EQUAL			BIT(0)
> +#define KSZ9477_ACL_EQ_NOT_EQUAL		0
> +
> +#define KSZ9477_ACL_PM_M			GENMASK(7, 6)
> +#define KSZ9477_ACL_PM_DISABLE			0
> +#define KSZ9477_ACL_PM_HIGHER			1
> +#define KSZ9477_ACL_PM_LOWER			2
> +#define KSZ9477_ACL_PM_REPLACE			3
> +#define KSZ9477_ACL_P_M				GENMASK(5, 3)
> +
> +#define KSZ9477_PORT_ACL_CTRL_0			0x0612
> +
> +#define KSZ9477_ACL_WRITE_DONE			BIT(6)
> +#define KSZ9477_ACL_READ_DONE			BIT(5)
> +#define KSZ9477_ACL_WRITE			BIT(4)
> +#define KSZ9477_ACL_INDEX_M			GENMASK(3, 0)
> +
> +/**
> + * ksz9477_acl_wait_ready - Waits for the ACL operation to complete on a given
> + *			    port.
> + * @dev: The ksz_device instance.
> + * @port: The port number to wait for.
> + *
> + * This function checks if the ACL write or read operation is completed by
> + * polling the specified register. It returns 0 if the operation is successful,
> + * or a negative error code if an error occurs.
> + */
> +static int ksz9477_acl_wait_ready(struct ksz_device *dev, int port)
> +{
> +	unsigned int wr_mask = KSZ9477_ACL_WRITE_DONE | KSZ9477_ACL_READ_DONE;
> +	unsigned int val, reg;
> +	int ret;
> +
> +	reg = dev->dev_ops->get_port_addr(port, KSZ9477_PORT_ACL_CTRL_0);
> +
> +	ret = regmap_read_poll_timeout(dev->regmap[0], reg, val,
> +				       (val & wr_mask) == wr_mask, 1000, 10000);
> +	if (ret)
> +		dev_err(dev->dev, "Failed to read/write ACL table\n");
> +
> +	return ret;
> +}
> +
> +/**
> + * ksz9477_acl_entry_write - Writes an ACL entry to a given port at the
> + *			     specified index.
> + * @dev: The ksz_device instance.
> + * @port: The port number to write the ACL entry to.
> + * @entry: A pointer to the ACL entry data.
> + * @idx: The index at which to write the ACL entry.
> + *
> + * This function writes the provided ACL entry to the specified port at the
> + * given index. It returns 0 if the operation is successful, or a negative error
> + * code if an error occurs.
> + */
> +static int ksz9477_acl_entry_write(struct ksz_device *dev, int port, u8 *entry,
> +				   int idx)
> +{
> +	int ret, i;
> +	u8 val;
> +
> +	for (i = 0; i < KSZ9477_ACL_ENTRY_SIZE; i++) {
> +		ret = ksz_pwrite8(dev, port, KSZ9477_PORT_ACL_0 + i, entry[i]);
> +		if (ret) {
> +			dev_err(dev->dev, "Failed to write ACL entry %d\n", i);
> +			return ret;
> +		}
> +	}
> +
> +	/* write everything down */
> +	val = FIELD_PREP(KSZ9477_ACL_INDEX_M, idx) | KSZ9477_ACL_WRITE;
> +	ret = ksz_pwrite8(dev, port, KSZ9477_PORT_ACL_CTRL_0, val);
> +	if (ret)
> +		return ret;
> +
> +	/* wait until everything is written  */
> +	return ksz9477_acl_wait_ready(dev, port);
> +}
> +
> +/**
> + * ksz9477_acl_port_enable - Enables ACL functionality on a given port.
> + * @dev: The ksz_device instance.
> + * @port: The port number on which to enable ACL functionality.
> + *
> + * This function enables ACL functionality on the specified port by configuring
> + * the appropriate control registers. It returns 0 if the operation is
> + * successful, or a negative error code if an error occurs.
> + *
> + * 0xn801 - KSZ9477S 5.2.8.2 Port Priority Control Register
> + *        Bit 7 - Highest Priority
> + *        Bit 6 - OR'ed Priority
> + *        Bit 4 - MAC Address Priority Classification
> + *        Bit 3 - VLAN Priority Classification
> + *        Bit 2 - 802.1p Priority Classification
> + *        Bit 1 - Diffserv Priority Classification
> + *        Bit 0 - ACL Priority Classification
> + *
> + * Current driver implementation sets 802.1p priority classification by default.
> + * In this function we add ACL priority classification with OR'ed priority.
> + * According to testing, priority set by ACL will supersede the 802.1p priority.
> + *
> + * 0xn803 - KSZ9477S 5.2.8.4 Port Authentication Control Register
> + *        Bit 2 - Access Control List (ACL) Enable
> + *        Bits 1:0 - Authentication Mode
> + *                00 = Reserved
> + *                01 = Block Mode. Authentication is enabled. When ACL is
> + *                     enabled, all traffic that misses the ACL rules is
> + *                     blocked; otherwise ACL actions apply.
> + *                10 = Pass Mode. Authentication is disabled. When ACL is
> + *                     enabled, all traffic that misses the ACL rules is
> + *                     forwarded; otherwise ACL actions apply.
> + *                11 = Trap Mode. Authentication is enabled. All traffic is
> + *                     forwarded to the host port. When ACL is enabled, all
> + *                     traffic that misses the ACL rules is blocked; otherwise
> + *                     ACL actions apply.
> + *
> + * We are using Pass Mode int this function.
> + */
> +static int ksz9477_acl_port_enable(struct ksz_device *dev, int port)
> +{
> +	int ret;
> +
> +	ret = ksz_prmw8(dev, port, P_PRIO_CTRL, 0, PORT_ACL_PRIO_ENABLE |
> +			PORT_OR_PRIO);
> +	if (ret)
> +		return ret;
> +
> +	return ksz_pwrite8(dev, port, REG_PORT_MRI_AUTHEN_CTRL,
> +			   PORT_ACL_ENABLE |
> +			   FIELD_PREP(PORT_AUTHEN_MODE, PORT_AUTHEN_PASS));
> +}
> +
> +/**
> + * ksz9477_acl_port_disable - Disables ACL functionality on a given port.
> + * @dev: The ksz_device instance.
> + * @port: The port number on which to disable ACL functionality.
> + *
> + * This function disables ACL functionality on the specified port by writing a
> + * value of 0 to the REG_PORT_MRI_AUTHEN_CTRL control register and remove
> + * PORT_ACL_PRIO_ENABLE bit from P_PRIO_CTRL register.
> + * It returns 0 if the operation is successful, or a negative error code if an
> + * error occurs.
> + */
> +static int ksz9477_acl_port_disable(struct ksz_device *dev, int port)
> +{
> +	int ret;
> +
> +	ret = ksz_prmw8(dev, port, P_PRIO_CTRL, PORT_ACL_PRIO_ENABLE, 0);
> +	if (ret)
> +		return ret;
> +
> +	return ksz_pwrite8(dev, port, REG_PORT_MRI_AUTHEN_CTRL, 0);
> +}
> +
> +/**
> + * ksz9477_acl_write_list - Write a list of ACL entries to a given port.
> + * @dev: The ksz_device instance.
> + * @port: The port number on which to write ACL entries.
> + *
> + * This function enables ACL functionality on the specified port, writes a list
> + * of ACL entries to the port, and disables ACL functionality if there are no
> + * entries. It returns 0 if the operation is successful, or a negative error
> + * code if an error occurs.
> + */
> +int ksz9477_acl_write_list(struct ksz_device *dev, int port)
> +{
> +	struct ksz9477_acl_priv *acl = dev->ports[port].acl_priv;
> +	struct ksz9477_acl_entries *acles = &acl->acles;
> +	int ret, i;
> +
> +	/* ACL should be enabled before writing entries */
> +	ret = ksz9477_acl_port_enable(dev, port);
> +	if (ret)
> +		return ret;
> +
> +	/* write all entries */
> +	for (i = 0; i < ARRAY_SIZE(acles->entries); i++) {
> +		u8 *entry = acles->entries[i].entry;
> +
> +		/* check if entry was removed and should be zeroed */
> +		if (i >= acles->entries_count &&
> +		    entry[KSZ9477_ACL_PORT_ACCESS_10] == 0 &&
> +		    entry[KSZ9477_ACL_PORT_ACCESS_11] == 0)
> +			continue;
> +
> +		ret = ksz9477_acl_entry_write(dev, port, entry, i);
> +		if (ret)
> +			return ret;
> +
> +		/* now removed entry is clean on HW side, so it can
> +		 * in the cache too
> +		 */
> +		if (i >= acles->entries_count &&
> +		    entry[KSZ9477_ACL_PORT_ACCESS_10] != 0 &&
> +		    entry[KSZ9477_ACL_PORT_ACCESS_11] != 0) {
> +			entry[KSZ9477_ACL_PORT_ACCESS_10] = 0;
> +			entry[KSZ9477_ACL_PORT_ACCESS_11] = 0;
> +		}
> +	}
> +
> +	if (!acles->entries_count)
> +		return ksz9477_acl_port_disable(dev, port);
> +
> +	return 0;
> +}
> +
> +/**
> + * ksz9477_acl_remove_entries - Remove ACL entries with a given cookie from a
> + *                              specified ksz9477_acl_entries structure.
> + * @acles: The ksz9477_acl_entries instance.
> + * @cookie: The cookie value to match for entry removal.
> + *
> + * This function iterates through the entries array, removing any entries with
> + * a matching cookie value. The remaining entries are then shifted down to fill
> + * the gap.
> + */
> +void ksz9477_acl_remove_entries(struct ksz9477_acl_entries *acles,
> +				unsigned long cookie)
> +{
> +	int i, j;
> +
> +	if (!acles->entries_count)
> +		return;
> +
> +	/* Iterate through the entries array */
> +	for (i = 0; i < acles->entries_count;) {
> +		/* Check if the cookie matches */
> +		if (acles->entries[i].cookie == cookie) {

It might save you 1 level of indentation if you do:

		if (acles->entries[i].cookie != cookie) {
			i++;
			continue;
		}

		... delete entry

> +			struct ksz9477_acl_entry *last_entry;
> +
> +			/* Shift remaining entries down */
> +			for (j = i; j < acles->entries_count - 1; ++j)
> +				acles->entries[j] = acles->entries[j + 1];

Does the entry order here affect the order in which the filters get
searched by the hardware? If not, then removal can be as simple as
copying last_entry over acles->entries[i], and decrementing entries_count.

> +
> +			last_entry = &acles->entries[acles->entries_count - 1];
> +
> +			memset(last_entry, 0, sizeof(*last_entry));
> +
> +			/* Set all access bits to be able to write zeroed
> +			 * entry
> +			 */
> +			last_entry->entry[KSZ9477_ACL_PORT_ACCESS_10] = 0xff;
> +			last_entry->entry[KSZ9477_ACL_PORT_ACCESS_11] = 0xff;
> +
> +			/* Decrease the entries_count */
> +			acles->entries_count--;
> +		} else {
> +			/* Move to the next entry if the cookie doesn't match */
> +			i++;
> +		}
> +	}
> +}
> +
> +/**
> + * ksz9477_port_acl_init - Initialize the ACL for a specified port on a ksz
> + *			   device.
> + * @dev: The ksz_device instance.
> + * @port: The port number to initialize the ACL for.
> + *
> + * This function allocates memory for an acl structure, associates it with the
> + * specified port, and initializes the ACL entries to a default state. The
> + * entries are then written using the ksz9477_acl_write_list function, ensuring
> + * the ACL has a predictable initial hardware state.
> + *
> + * Returns: 0 on success, or an error code on failure.
> + */
> +int ksz9477_port_acl_init(struct ksz_device *dev, int port)
> +{
> +	struct ksz9477_acl_entries *acles;
> +	struct ksz9477_acl_priv *acl;
> +	int i;
> +
> +	acl = kzalloc(sizeof(*acl), GFP_KERNEL);
> +	if (!acl)
> +		return -ENOMEM;

This allocates non-devres memory, yet there is no ksz9477_port_acl_free()?
There needs to be more serious consideration to memory leaks, both on
driver removal path and on error teardown.

> +
> +	dev->ports[port].acl_priv = acl;
> +
> +	acles = &acl->acles;
> +	/* write all entries */
> +	for (i = 0; i < ARRAY_SIZE(acles->entries); i++) {
> +		u8 *entry = acles->entries[i].entry;
> +
> +		/* Set all access bits to be able to write zeroed
> +		 * entry
> +		 */
> +		entry[KSZ9477_ACL_PORT_ACCESS_10] = 0xff;
> +		entry[KSZ9477_ACL_PORT_ACCESS_11] = 0xff;
> +	}
> +
> +	return ksz9477_acl_write_list(dev, port);

Even here. err = ksz9477_acl_write_list(); if (err) goto free_acl;

> +}
> +
> +/**
> + * ksz9477_acl_set_reg - Set entry[16] and entry[17] depending on the updated
> + *			   entry[]
> + * @entry: An array containing the entries
> + * @reg: The register of the entry that needs to be updated
> + * @value: The value to be assigned to the updated entry
> + *
> + * This function updates the entry[] array based on the provided register and
> + * value. It also sets entry[0x10] and entry[0x11] according to the ACL byte
> + * enable rules.
> + *
> + * 0x10 - Byte Enable [15:8]
> + *
> + * Each bit enables accessing one of the ACL bytes when a read or write is
> + * initiated by writing to the Port ACL Byte Enable LSB Register.
> + * Bit 0 applies to the Port ACL Access 7 Register
> + * Bit 1 applies to the Port ACL Access 6 Register, etc.
> + * Bit 7 applies to the Port ACL Access 0 Register
> + * 1 = Byte is selected for read/write
> + * 0 = Byte is not selected
> + *
> + * 0x11 - Byte Enable [7:0]
> + *
> + * Each bit enables accessing one of the ACL bytes when a read or write is
> + * initiated by writing to the Port ACL Byte Enable LSB Register.
> + * Bit 0 applies to the Port ACL Access F Register
> + * Bit 1 applies to the Port ACL Access E Register, etc.
> + * Bit 7 applies to the Port ACL Access 8 Register
> + * 1 = Byte is selected for read/write
> + * 0 = Byte is not selected
> + */
> +static void ksz9477_acl_set_reg(u8 *entry, enum ksz9477_acl_port_access reg,
> +				u8 value)
> +{
> +	if (reg >= KSZ9477_ACL_PORT_ACCESS_0 &&
> +	    reg <= KSZ9477_ACL_PORT_ACCESS_7) {
> +		entry[KSZ9477_ACL_PORT_ACCESS_10] |=
> +				BIT(KSZ9477_ACL_PORT_ACCESS_7 - reg);
> +	} else if (reg >= KSZ9477_ACL_PORT_ACCESS_8 &&
> +		   reg <= KSZ9477_ACL_PORT_ACCESS_F) {
> +		entry[KSZ9477_ACL_PORT_ACCESS_11] |=
> +			BIT(KSZ9477_ACL_PORT_ACCESS_F - reg);
> +	} else {
> +		WARN_ON(1);
> +		return;
> +	}
> +
> +	entry[reg] = value;
> +}
> +
> +/**
> + * ksz9477_acl_matching_rule_cfg_l2 - Configure an ACL filtering entry to match
> + *				      L2 types of Ethernet frames
> + * @entry: Pointer to ACL entry buffer
> + * @ethertype: Ethertype value
> + * @eth_addr: Pointer to Ethernet address
> + * @is_src: If true, match the source MAC address; if false, match the
> + *	    destination MAC address
> + *
> + * This function configures an Access Control List (ACL) filtering
> + * entry to match Layer 2 types of Ethernet frames based on the provided
> + * ethertype and Ethernet address. Additionally, it can match either the source
> + * or destination MAC address depending on the value of the is_src parameter.
> + *
> + * Register Descriptions for MD = 01 and ENB != 00 (Layer 2 MAC header
> + * filtering)
> + *
> + * 0x01 - Mode and Enable
> + *        Bits 5:4 - MD (Mode)
> + *                01 = Layer 2 MAC header or counter filtering
> + *        Bits 3:2 - ENB (Enable)
> + *                01 = Comparison is performed only on the TYPE value
> + *                10 = Comparison is performed only on the MAC Address value
> + *                11 = Both the MAC Address and TYPE are tested
> + *        Bit  1   - S/D (Source / Destination)
> + *                0 = Destination address
> + *                1 = Source address
> + *        Bit  0   - EQ (Equal / Not Equal)
> + *                0 = Not Equal produces true result
> + *                1 = Equal produces true result
> + *
> + * 0x02-0x07 - MAC Address
> + *        0x02 - MAC Address [47:40]
> + *        0x03 - MAC Address [39:32]
> + *        0x04 - MAC Address [31:24]
> + *        0x05 - MAC Address [23:16]
> + *        0x06 - MAC Address [15:8]
> + *        0x07 - MAC Address [7:0]
> + *
> + * 0x08-0x09 - EtherType
> + *        0x08 - EtherType [15:8]
> + *        0x09 - EtherType [7:0]
> + */
> +static void ksz9477_acl_matching_rule_cfg_l2(u8 *entry, u16 ethertype,
> +					     u8 *eth_addr, bool is_src)
> +{
> +	u8 enb = 0;
> +	u8 val;
> +
> +	if (ethertype)
> +		enb |= KSZ9477_ACL_ENB_L2_TYPE;
> +	if (eth_addr)
> +		enb |= KSZ9477_ACL_ENB_L2_MAC;
> +
> +	val = FIELD_PREP(KSZ9477_ACL_MD_MASK, KSZ9477_ACL_MD_L2_MAC) |
> +	      FIELD_PREP(KSZ9477_ACL_ENB_MASK, enb) |
> +	      FIELD_PREP(KSZ9477_ACL_SD_SRC, is_src) | KSZ9477_ACL_EQ_EQUAL;
> +	ksz9477_acl_set_reg(entry, KSZ9477_ACL_PORT_ACCESS_1, val);
> +
> +	if (eth_addr) {
> +		int i;
> +
> +		for (i = 0; i < ETH_ALEN; i++) {
> +			ksz9477_acl_set_reg(entry,
> +					    KSZ9477_ACL_PORT_ACCESS_2 + i,
> +					    eth_addr[i]);
> +		}
> +	}
> +
> +	ksz9477_acl_set_reg(entry, KSZ9477_ACL_PORT_ACCESS_8, ethertype >> 8);
> +	ksz9477_acl_set_reg(entry, KSZ9477_ACL_PORT_ACCESS_9, ethertype & 0xff);
> +}
> +
> +/**
> + * ksz9477_acl_action_rule_cfg - Set action for an ACL entry
> + * @entry: Pointer to the ACL entry
> + * @force_prio: If true, force the priority value
> + * @prio_val: Priority value
> + *
> + * This function sets the action for the specified ACL entry. It prepares
> + * the priority mode and traffic class values and updates the entry's
> + * action registers accordingly. Currently, there is no port or VLAN PCP
> + * remapping.
> + *
> + * ACL Action Rule Parameters for Non-Count Modes (MD ≠ 01 or ENB ≠ 00)
> + *
> + * 0x0A - PM, P, RPE, RP[2:1]
> + *        Bits 7:6 - PM[1:0] - Priority Mode
> + *		00 = ACL does not specify the packet priority. Priority is
> + *		     determined by standard QoS functions.
> + *		01 = Change packet priority to P[2:0] if it is greater than QoS
> + *		     result.
> + *		10 = Change packet priority to P[2:0] if it is smaller than the
> + *		     QoS result.
> + *		11 = Always change packet priority to P[2:0].
> + *        Bits 5:3 - P[2:0] - Priority value
> + *        Bit  2   - RPE - Remark Priority Enable
> + *        Bits 1:0 - RP[2:1] - Remarked Priority value (bits 2:1)
> + *		0 = Disable priority remarking
> + *		1 = Enable priority remarking. VLAN tag priority (PCP) bits are
> + *		    replaced by RP[2:0].
> + *
> + * 0x0B - RP[0], MM
> + *        Bit  7   - RP[0] - Remarked Priority value (bit 0)
> + *        Bits 6:5 - MM[1:0] - Map Mode
> + *		00 = No forwarding remapping
> + *		01 = The forwarding map in FORWARD is OR'ed with the forwarding
> + *		     map from the Address Lookup Table.
> + *		10 = The forwarding map in FORWARD is AND'ed with the forwarding
> + *		     map from the Address Lookup Table.
> + *		11 = The forwarding map in FORWARD replaces the forwarding map
> + *		     from the Address Lookup Table.
> + * 0x0D - FORWARD[n:0]
> + *       Bits 7:0 - FORWARD[n:0] - Forwarding map. Bit 0 = port 1,
> + *		    bit 1 = port 2, etc.
> + *		1 = enable forwarding to this port
> + *		0 = do not forward to this port
> + */
> +void ksz9477_acl_action_rule_cfg(u8 *entry, bool force_prio, u8 prio_val)
> +{
> +	u8 prio_mode, val;
> +
> +	if (force_prio)
> +		prio_mode = KSZ9477_ACL_PM_REPLACE;
> +	else
> +		prio_mode = KSZ9477_ACL_PM_DISABLE;
> +
> +	val = FIELD_PREP(KSZ9477_ACL_PM_M, prio_mode) |
> +	      FIELD_PREP(KSZ9477_ACL_P_M, prio_val);
> +	ksz9477_acl_set_reg(entry, KSZ9477_ACL_PORT_ACCESS_A, val);
> +
> +	/* no port or VLAN PCP remapping for now */
> +	ksz9477_acl_set_reg(entry, KSZ9477_ACL_PORT_ACCESS_B, 0);
> +	ksz9477_acl_set_reg(entry, KSZ9477_ACL_PORT_ACCESS_D, 0);
> +}
> +
> +/**
> + * ksz9477_acl_processing_rule_set_action - Set the action for the processing
> + *					    rule set.
> + * @entry: Pointer to the ACL entry
> + * @action_idx: Index of the action to be applied
> + *
> + * This function sets the action for the processing rule set by updating the
> + * appropriate register in the entry. There can be only one action per
> + * processing rule.
> + *
> + * Access Control List (ACL) Processing Rule Registers:
> + *
> + * 0x00 - First Rule Number (FRN)
> + *        Bits 3:0 - First Rule Number. Pointer to an Action rule entry.
> + */
> +void ksz9477_acl_processing_rule_set_action(u8 *entry, u8 action_idx)
> +{
> +	ksz9477_acl_set_reg(entry, KSZ9477_ACL_PORT_ACCESS_0, action_idx);
> +}
> +
> +/**
> + * ksz9477_acl_processing_rule_add_match - Add a matching rule to the rule set
> + * @entry: Pointer to the ACL entry
> + * @match_idx: Index of the matching rule to be added
> + *
> + * This function adds a matching rule to the rule set by updating the
> + * appropriate bits in the entry's rule set registers.
> + *
> + * Access Control List (ACL) Processing Rule Registers:
> + *
> + * 0x0E - RuleSet [15:8]
> + *        Bits 7:0 - RuleSet [15:8] Specifies a set of one or more Matching rule
> + *        entries. RuleSet has one bit for each of the 16 Matching rule entries.
> + *        If multiple Matching rules are selected, then all conditions will be
> + *	  AND'ed to produce a final match result.
> + *		0 = Matching rule not selected
> + *		1 = Matching rule selected
> + *
> + * 0x0F - RuleSet [7:0]
> + *        Bits 7:0 - RuleSet [7:0]
> + */
> +static void ksz9477_acl_processing_rule_add_match(u8 *entry, u8 match_idx)
> +{
> +	u8 vale = entry[KSZ9477_ACL_PORT_ACCESS_E];
> +	u8 valf = entry[KSZ9477_ACL_PORT_ACCESS_F];
> +
> +	if (match_idx < 8)
> +		valf |= BIT(match_idx);
> +	else
> +		vale |= BIT(match_idx - 8);
> +
> +	ksz9477_acl_set_reg(entry, KSZ9477_ACL_PORT_ACCESS_E, vale);
> +	ksz9477_acl_set_reg(entry, KSZ9477_ACL_PORT_ACCESS_F, valf);
> +}
> +
> +/**
> + * ksz9477_acl_get_init_entry - Get a new uninitialized entry for a specified
> + *				port on a ksz_device.
> + * @dev: The ksz_device instance.
> + * @port: The port number to get the uninitialized entry for.
> + *
> + * This function retrieves the next available ACL entry for the specified port,
> + * clears all access flags, and associates it with the current cookie.
> + *
> + * Returns: A pointer to the new uninitialized ACL entry.
> + */
> +
> +static struct ksz9477_acl_entry *
> +ksz9477_acl_get_init_entry(struct ksz_device *dev, int port)
> +{
> +	struct ksz9477_acl_priv *acl = dev->ports[port].acl_priv;
> +	struct ksz9477_acl_entries *acles = &acl->acles;
> +	struct ksz9477_acl_entry *entry;
> +
> +	entry = &acles->entries[acles->entries_count];
> +	entry->cookie = acl->current_cookie;
> +
> +	/* clear all access flags */
> +	entry->entry[KSZ9477_ACL_PORT_ACCESS_10] = 0;
> +	entry->entry[KSZ9477_ACL_PORT_ACCESS_11] = 0;
> +
> +	return entry;
> +}
> +
> +/**
> + * ksz9477_acl_match_process_l2 - Configure Layer 2 ACL matching rules and
> + *                                processing rules.
> + * @dev: Pointer to the ksz_device.
> + * @port: Port number.
> + * @ethtype: Ethernet type.
> + * @src_mac: Source MAC address.
> + * @dst_mac: Destination MAC address.
> + *
> + * This function sets up matching and processing rules for Layer 2 ACLs.
> + * It takes into account that only one MAC per entry is supported.
> + */
> +void ksz9477_acl_match_process_l2(struct ksz_device *dev, int port,
> +				  u16 ethtype, u8 *src_mac, u8 *dst_mac)
> +{
> +	struct ksz9477_acl_priv *acl = dev->ports[port].acl_priv;
> +	struct ksz9477_acl_entries *acles = &acl->acles;
> +	struct ksz9477_acl_entry *entry;
> +
> +	entry = ksz9477_acl_get_init_entry(dev, port);
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
> +		entry = ksz9477_acl_get_init_entry(dev, port);
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
> index 0000000000000..b5690b18c3ea5
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/ksz9477_tc_flower.c
> @@ -0,0 +1,273 @@
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
> + *
> + * This function parses the Layer 2 key from the flow rule and configures
> + * the corresponding ACL entries. It checks for unsupported offloads and
> + * available entries before proceeding with the configuration.
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +static int ksz9477_flower_parse_key_l2(struct ksz_device *dev, int port,
> +				       struct netlink_ext_ack *extack,
> +				       struct flow_rule *rule)
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
> +	ksz9477_acl_match_process_l2(dev, port, ethtype, src_mac, dst_mac);
> +
> +	return 0;
> +
> +not_full_mask_err:
> +	NL_SET_ERR_MSG_MOD(extack, "MAC address mask must be a full mask");
> +	return -EOPNOTSUPP;
> +}
> +
> +/**
> + * ksz9477_flower_parse_key - Parse flow rule keys for a specified port on a
> + *			      ksz_device.
> + * @dev: The ksz_device instance.
> + * @port: The port number to parse the flow rule keys for.
> + * @extack: The netlink extended ACK for reporting errors.
> + * @rule: The flow_rule to parse.
> + *
> + * This function checks if the used keys in the flow rule are supported by
> + * the device and parses the L2 keys if they match. If unsupported keys are
> + * used, an error message is set in the extended ACK.
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +static int ksz9477_flower_parse_key(struct ksz_device *dev, int port,
> +				    struct netlink_ext_ack *extack,
> +				    struct flow_rule *rule)
> +{
> +	struct flow_dissector *dissector = rule->match.dissector;
> +	struct ksz9477_acl_priv *acl = dev->ports[port].acl_priv;
> +	int ret;
> +
> +	if (dissector->used_keys &
> +	    ~(BIT(FLOW_DISSECTOR_KEY_BASIC) |
> +	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
> +	      BIT(FLOW_DISSECTOR_KEY_CONTROL))) {

Also watch out for this pending API change that the driver may conflict
with (although I suspect it might take a few more iterations until that
gets in):
https://patchwork.kernel.org/project/netdevbpf/patch/20230726131223.1230526-1-rkannoth@marvell.com/

> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Unsupported keys used");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC) ||
> +	    flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> +		ret = ksz9477_flower_parse_key_l2(dev, port, extack, rule);
> +		if (ret)
> +			return ret;
> +		acl->acles.entries_unprocessed = true;

Sorry, I don't understand the need for this. What happens if you just
proceed to parse the action without setting this bool flag? Also, the
bool is global to the entire list of ACLs for the port. It gets set for
the first key of the first added filter, and remains set afterwards.

> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ksz9477_flower_parse_action - Parse flow rule actions for a specified port
> + *				 on a ksz_device.
> + * @dev: The ksz_device instance.
> + * @port: The port number to parse the flow rule actions for.
> + * @extack: The netlink extended ACK for reporting errors.
> + * @cls: The flow_cls_offload instance containing the flow rule.
> + * @entry_idx: The index of the ACL entry to store the action.
> + *
> + * This function checks if the actions in the flow rule are supported by
> + * the device. Currently, only actions that change priorities are supported.
> + * If unsupported actions are encountered, an error message is set in the
> + * extended ACK.
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +static int ksz9477_flower_parse_action(struct ksz_device *dev, int port,
> +				       struct netlink_ext_ack *extack,
> +				       struct flow_cls_offload *cls,
> +				       int entry_idx)
> +{
> +	struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
> +	struct ksz9477_acl_priv *acl = dev->ports[port].acl_priv;
> +	const struct flow_action_entry *act;
> +	struct ksz9477_acl_entry *entry;
> +	bool prio_force = false;
> +	u8 prio_val = 0;
> +	int i;
> +
> +	if (TC_H_MIN(cls->classid)) {
> +		NL_SET_ERR_MSG_MOD(extack, "hw_tc is not supported. Use: action skbedit prio");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	flow_action_for_each(i, act, &rule->action) {
> +		switch (act->id) {
> +		case FLOW_ACTION_PRIORITY:
> +			if (act->priority > KSZ9477_MAX_TC) {
> +				NL_SET_ERR_MSG_MOD(extack, "Priority value is too high");
> +				return -EOPNOTSUPP;
> +			}
> +			prio_force = true;
> +			prio_val = act->priority;
> +			break;
> +		default:
> +			NL_SET_ERR_MSG_MOD(extack, "action not supported");
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	/* pick entry to store action */
> +	entry = &acl->acles.entries[entry_idx];
> +
> +	ksz9477_acl_action_rule_cfg(entry->entry, prio_force, prio_val);
> +	ksz9477_acl_processing_rule_set_action(entry->entry, entry_idx);
> +
> +	return 0;
> +}
> +
> +/**
> + * ksz9477_cls_flower_add - Add a flow classification rule for a specified port
> + *			    on a ksz_device.
> + * @ds: The DSA switch instance.
> + * @port: The port number to add the flow classification rule to.
> + * @cls: The flow_cls_offload instance containing the flow rule.
> + * @ingress: A flag indicating if the rule is applied on the ingress path.
> + *
> + * This function adds a flow classification rule for a specified port on a
> + * ksz_device. It checks if the ACL offloading is supported and parses the flow
> + * keys and actions. If the ACL is not supported, it returns an error. If there
> + * are unprocessed entries, it parses the action for the rule.
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int ksz9477_cls_flower_add(struct dsa_switch *ds, int port,
> +			   struct flow_cls_offload *cls, bool ingress)
> +{
> +	struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
> +	struct netlink_ext_ack *extack = cls->common.extack;
> +	struct ksz_device *dev = ds->priv;
> +	struct ksz9477_acl_priv *acl;
> +	int action_entry_idx;
> +	int ret;
> +
> +	acl = dev->ports[port].acl_priv;
> +
> +	if (!acl) {
> +		NL_SET_ERR_MSG_MOD(extack, "ACL offloading is not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* A complex rule set can take multiple entries. Use first entry
> +	 * to store the action.
> +	 */
> +	action_entry_idx = acl->acles.entries_count;
> +	acl->current_cookie = cls->cookie;

Can't you just propagate the cookie as an argument from the tc_flower
code to the ACL code? I don't think that you actually need it to persist
in driver memory after you finish processing one filter.

> +
> +	ret = ksz9477_flower_parse_key(dev, port, extack, rule);
> +	if (ret)
> +		return ret;
> +
> +	if (acl->acles.entries_unprocessed) {
> +		ret = ksz9477_flower_parse_action(dev, port, extack, cls,
> +						  action_entry_idx);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ksz9477_acl_write_list(dev, port);

cls->common.prio is the order in which the filters should take effect
(IIRC, filter with lower prio takes precedence in front of filter with
higher prio). Is it taken into consideration by your implementation?

> +}
> +
> +/**
> + * ksz9477_cls_flower_del - Remove a flow classification rule for a specified
> + *			    port on a ksz_device.
> + * @ds: The DSA switch instance.
> + * @port: The port number to remove the flow classification rule from.
> + * @cls: The flow_cls_offload instance containing the flow rule.
> + * @ingress: A flag indicating if the rule is applied on the ingress path.
> + *
> + * This function removes a flow classification rule for a specified port on a
> + * ksz_device. It checks if the ACL is initialized, and if not, returns an
> + * error. If the ACL is initialized, it removes entries with the specified
> + * cookie and rewrites the ACL list.
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int ksz9477_cls_flower_del(struct dsa_switch *ds, int port,
> +			   struct flow_cls_offload *cls, bool ingress)
> +{
> +	unsigned long cookie = cls->cookie;
> +	struct ksz_device *dev = ds->priv;
> +	struct ksz9477_acl_priv *acl;
> +
> +	acl = dev->ports[port].acl_priv;
> +
> +	if (!acl)
> +		return -EOPNOTSUPP;
> +
> +	ksz9477_acl_remove_entries(&acl->acles, cookie);
> +
> +	return ksz9477_acl_write_list(dev, port);
> +}
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 1de2251a42dc3..2d98c3055f7a0 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -3098,6 +3098,44 @@ static int ksz_switch_detect(struct ksz_device *dev)
>  	return 0;
>  }
>  
> +static int ksz_cls_flower_add(struct dsa_switch *ds, int port,
> +			      struct flow_cls_offload *cls, bool ingress)
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
> +		return ksz9477_cls_flower_add(ds, port, cls, ingress);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ksz_cls_flower_del(struct dsa_switch *ds, int port,
> +			      struct flow_cls_offload *cls, bool ingress)
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
> +		return ksz9477_cls_flower_del(ds, port, cls, ingress);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
>  /* Bandwidth is calculated by idle slope/transmission speed. Then the Bandwidth
>   * is converted to Hex-decimal using the successive multiplication method. On
>   * every step, integer part is taken and decimal part is carry forwarded.
> @@ -3452,6 +3490,8 @@ static const struct dsa_switch_ops ksz_switch_ops = {
>  	.port_hwtstamp_set	= ksz_hwtstamp_set,
>  	.port_txtstamp		= ksz_port_txtstamp,
>  	.port_rxtstamp		= ksz_port_rxtstamp,
> +	.cls_flower_add		= ksz_cls_flower_add,
> +	.cls_flower_del		= ksz_cls_flower_del,
>  	.port_setup_tc		= ksz_setup_tc,
>  	.get_mac_eee		= ksz_get_mac_eee,
>  	.set_mac_eee		= ksz_set_mac_eee,
> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index a4de58847deab..6dca488fbc5f2 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -117,6 +117,7 @@ struct ksz_port {
>  	u32 rgmii_tx_val;
>  	u32 rgmii_rx_val;
>  	struct ksz_device *ksz_dev;
> +	void *acl_priv;
>  	struct ksz_irq pirq;
>  	u8 num;
>  #if IS_ENABLED(CONFIG_NET_DSA_MICROCHIP_KSZ_PTP)
> -- 
> 2.39.2
> 
