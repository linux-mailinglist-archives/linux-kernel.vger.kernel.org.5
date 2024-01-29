Return-Path: <linux-kernel+bounces-43466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5B4841442
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C26B2584B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681C77605F;
	Mon, 29 Jan 2024 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="en2Oqj+D"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C932276026
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560067; cv=none; b=JGoeSF+UK9oisRYBUgS9zIWo9eP8Qxbn3XdpoT0r8Pihmf6kb5B6YwiZVv5Jsue26fj67HIGQ3aiZmBgcP7952xq2igHuMW9cxOQ++37LLxmrvkgClo9cyzPAVXMCFiOOeSI2WOSKFW0kgVkGetubfFnBdP8nxzAdrjydoMC4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560067; c=relaxed/simple;
	bh=GoJyYIFzb2k3PH6MsdMgvKMEtmaYsFJBTFhPAPN75GE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ZPS31a4ei3kr7ApObT67xxw+RkgQQns6rBldk7BB9AVZHk/3M+bPd6YVXxluzaghqysWUSB4m/YY7tXy3zzaYDirwTmJ0OlI0wDsOOIJ42/weVOYZrNY5k1Ki75AwiSf2Sh+Y7jSViHPQtdHITS69OQJBp9YdVrRXfY5uVm+eYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=en2Oqj+D; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ffee6fcdc1so60820817b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706560065; x=1707164865; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aLvLnDQ7/vpYs8k5kEen087KIVrTKI7RDsqBRn44s28=;
        b=en2Oqj+D+2P9NU9GsH+gk1asxGQSzUKOQ812hS7IgsqfqfXmeEAntPNLRJ3/lWx687
         64G0VN+pA63aQuBuaakmqMV6EHd1ohoW67Eh5qLpY+bYMpS3w032ilxudO4fVvhz4QIZ
         X13dsv0dhbz66uxB6C6xAckyZHGEWCcUm7PBps7u0RC2Exfz07WfNyceOMwMbx9Oxw/R
         509T7KgXYF5K/+q8kWAHe5sp58dw7ja7042gGFgjPH0SHHAwvrS06+FLsDRGQzh3REcP
         QOtYVJW2+WoJ/8FIFy/lymMrUgh6GRZ6Ahm3UAoMDf81mAwVUgCWA2wnUw3T//aSHnv4
         V5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706560065; x=1707164865;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLvLnDQ7/vpYs8k5kEen087KIVrTKI7RDsqBRn44s28=;
        b=wBDPc6us6o4f3mN5Bta0Glpq+ef0AqQS1OyH0d6foXY/QHJxJT0SUMeKkth+ecR0uc
         SV8BmkKbwqqNNHNpVmc6I2W9rsTfclhnOH+BxiKZcR93afHf+G0QEHRufglumavExO8N
         hLQ4VDpzujMPt1scKUHtLobOHyiT3PAlc6iihViULGgRO2ZJdl/y+y4ylEpWZB+6TJwK
         E7uAMcORY0CPwgs8L0EvM48EFpgnthpRUxsQ2upQVDmTyu47h1Dl0U3NNP+lbh1wpLrU
         1ox+tO7kgzlMn+946Tcdv6vhvnGeG7fLMiS6OVL5oyKlzCF9t2NOdvMCpXSMbXXIweJf
         PE3Q==
X-Gm-Message-State: AOJu0YxG0ijAYj3cS+ieeLkFUyxmN/zeHUTOpyjz7t24gFGxozqXFLF6
	V1tB+eTpuQ9PX7w/n7G6TxAZjAVTYJzTVcbOXTJmZ3IRCF/DJki1O2e/nCy5noa7zkW9BzUzabh
	8lQ==
X-Google-Smtp-Source: AGHT+IFl++Qy+UjzC8OUREGFNW1om42d1+IkbIqdpRtxy94ZFe63+8eLcraJnQFRnp8NK4bj48n/JlMJgHY=
X-Received: from aahila.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2f3])
 (user=aahila job=sendgmr) by 2002:a81:57d5:0:b0:5e6:27ee:67fb with SMTP id
 l204-20020a8157d5000000b005e627ee67fbmr1798718ywb.4.1706560064826; Mon, 29
 Jan 2024 12:27:44 -0800 (PST)
Date: Mon, 29 Jan 2024 20:27:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129202741.3424902-1-aahila@google.com>
Subject: [PATCH net-next v6] bonding: Add independent control state machine
From: Aahil Awatramani <aahila@google.com>
To: Aahil Awatramani <aahila@google.com>, David Dillow <dave@thedillows.org>, 
	Mahesh Bandewar <maheshb@google.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for the independent control state machine per IEEE
802.1AX-2008 5.4.15 in addition to the existing implementation of the
coupled control state machine.

Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
the LACP MUX state machine for separated handling of an initial
Collecting state before the Collecting and Distributing state. This
enables a port to be in a state where it can receive incoming packets
while not still distributing. This is useful for reducing packet loss when
a port begins distributing before its partner is able to collect.

Added new functions such as bond_set_slave_tx_disabled_flags and
bond_set_slave_rx_enabled_flags to precisely manage the port's collecting
and distributing states. Previously, there was no dedicated method to
disable TX while keeping RX enabled, which this patch addresses.

Note that the regular flow process in the kernel's bonding driver remains
unaffected by this patch. The extension requires explicit opt-in by the
user (in order to ensure no disruptions for existing setups) via netlink
support using the new bonding parameter coupled_control. The default value
for coupled_control is set to 1 so as to preserve existing behaviour.

Signed-off-by: Aahil Awatramani <aahila@google.com>

v6:
  Added coupled_control to procfs
v5:
  Merge documentation patch with changes patch
  Add version history in comment description
v4:
  Remove inline references from c source files
v3:
  Edited commit description
  Edited documentation description
  Changed function names
  Only allow coupled_control change when the bond is down
v2:
  Removed sysfs changes
  Added documentation for new paramater
  Renamed parameter to coupled_control
  Update bond_set_slave_inactive_flags() with a 8023ad check

---
 Documentation/networking/bonding.rst |  12 ++
 drivers/net/bonding/bond_3ad.c       | 157 +++++++++++++++++++++++++--
 drivers/net/bonding/bond_main.c      |   1 +
 drivers/net/bonding/bond_netlink.c   |  16 +++
 drivers/net/bonding/bond_options.c   |  28 ++++-
 drivers/net/bonding/bond_procfs.c    |   2 +
 include/net/bond_3ad.h               |   2 +
 include/net/bond_options.h           |   1 +
 include/net/bonding.h                |  23 ++++
 include/uapi/linux/if_link.h         |   1 +
 tools/include/uapi/linux/if_link.h   |   1 +
 11 files changed, 236 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index f7a73421eb76..e774b48de9f5 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -444,6 +444,18 @@ arp_missed_max
 
 	The default value is 2, and the allowable range is 1 - 255.
 
+coupled_control
+
+    Specifies whether the LACP state machine's MUX in the 802.3ad mode
+    should have separate Collecting and Distributing states.
+
+    This is by implementing the independent control state machine per
+    IEEE 802.1AX-2008 5.4.15 in addition to the existing coupled control
+    state machine.
+
+    The default value is 1. This setting does not separate the Collecting
+    and Distributing states, maintaining the bond in coupled control.
+
 downdelay
 
 	Specifies the time, in milliseconds, to wait before disabling
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c99ffe6c683a..f2942e8c6c91 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -106,6 +106,9 @@ static void ad_agg_selection_logic(struct aggregator *aggregator,
 static void ad_clear_agg(struct aggregator *aggregator);
 static void ad_initialize_agg(struct aggregator *aggregator);
 static void ad_initialize_port(struct port *port, int lacp_fast);
+static void ad_enable_collecting(struct port *port);
+static void ad_disable_distributing(struct port *port,
+				    bool *update_slave_arr);
 static void ad_enable_collecting_distributing(struct port *port,
 					      bool *update_slave_arr);
 static void ad_disable_collecting_distributing(struct port *port,
@@ -171,9 +174,38 @@ static inline int __agg_has_partner(struct aggregator *agg)
 	return !is_zero_ether_addr(agg->partner_system.mac_addr_value);
 }
 
+/**
+ * __disable_distributing_port - disable the port's slave for distributing.
+ * Port will still be able to collect.
+ * @port: the port we're looking at
+ *
+ * This will disable only distributing on the port's slave.
+ */
+static void __disable_distributing_port(struct port *port)
+{
+	bond_set_slave_tx_disabled_flags(port->slave, BOND_SLAVE_NOTIFY_LATER);
+}
+
+/**
+ * __enable_collecting_port - enable the port's slave for collecting,
+ * if it's up
+ * @port: the port we're looking at
+ *
+ * This will enable only collecting on the port's slave.
+ */
+static void __enable_collecting_port(struct port *port)
+{
+	struct slave *slave = port->slave;
+
+	if (slave->link == BOND_LINK_UP && bond_slave_is_up(slave))
+		bond_set_slave_rx_enabled_flags(slave, BOND_SLAVE_NOTIFY_LATER);
+}
+
 /**
  * __disable_port - disable the port's slave
  * @port: the port we're looking at
+ *
+ * This will disable both collecting and distributing on the port's slave.
  */
 static inline void __disable_port(struct port *port)
 {
@@ -183,6 +215,8 @@ static inline void __disable_port(struct port *port)
 /**
  * __enable_port - enable the port's slave, if it's up
  * @port: the port we're looking at
+ *
+ * This will enable both collecting and distributing on the port's slave.
  */
 static inline void __enable_port(struct port *port)
 {
@@ -193,10 +227,27 @@ static inline void __enable_port(struct port *port)
 }
 
 /**
- * __port_is_enabled - check if the port's slave is in active state
+ * __port_move_to_attached_state - check if port should transition back to attached
+ * state.
+ * @port: the port we're looking at
+ */
+static bool __port_move_to_attached_state(struct port *port)
+{
+	if (!(port->sm_vars & AD_PORT_SELECTED) ||
+	    (port->sm_vars & AD_PORT_STANDBY) ||
+	    !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) ||
+	    !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION))
+		port->sm_mux_state = AD_MUX_ATTACHED;
+
+	return port->sm_mux_state == AD_MUX_ATTACHED;
+}
+
+/**
+ * __port_is_collecting_distributing - check if the port's slave is in the
+ * combined collecting/distributing state
  * @port: the port we're looking at
  */
-static inline int __port_is_enabled(struct port *port)
+static int __port_is_collecting_distributing(struct port *port)
 {
 	return bond_is_active_slave(port->slave);
 }
@@ -942,6 +993,7 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker)
  */
 static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 {
+	struct bonding *bond = __get_bond_by_port(port);
 	mux_states_t last_state;
 
 	/* keep current State Machine state to compare later if it was
@@ -999,9 +1051,13 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 			if ((port->sm_vars & AD_PORT_SELECTED) &&
 			    (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) &&
 			    !__check_agg_selection_timer(port)) {
-				if (port->aggregator->is_active)
-					port->sm_mux_state =
-					    AD_MUX_COLLECTING_DISTRIBUTING;
+				if (port->aggregator->is_active) {
+					int state = AD_MUX_COLLECTING_DISTRIBUTING;
+
+					if (!bond->params.coupled_control)
+						state = AD_MUX_COLLECTING;
+					port->sm_mux_state = state;
+				}
 			} else if (!(port->sm_vars & AD_PORT_SELECTED) ||
 				   (port->sm_vars & AD_PORT_STANDBY)) {
 				/* if UNSELECTED or STANDBY */
@@ -1019,11 +1075,45 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 			}
 			break;
 		case AD_MUX_COLLECTING_DISTRIBUTING:
+			if (!__port_move_to_attached_state(port)) {
+				/* if port state hasn't changed make
+				 * sure that a collecting distributing
+				 * port in an active aggregator is enabled
+				 */
+				if (port->aggregator->is_active &&
+				    !__port_is_collecting_distributing(port)) {
+					__enable_port(port);
+					*update_slave_arr = true;
+				}
+			}
+			break;
+		case AD_MUX_COLLECTING:
+			if (!__port_move_to_attached_state(port)) {
+				if ((port->sm_vars & AD_PORT_SELECTED) &&
+				    (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) &&
+				    (port->partner_oper.port_state & LACP_STATE_COLLECTING)) {
+					port->sm_mux_state = AD_MUX_DISTRIBUTING;
+				} else {
+					/* If port state hasn't changed, make sure that a collecting
+					 * port is enabled for an active aggregator.
+					 */
+					struct slave *slave = port->slave;
+
+					if (port->aggregator->is_active &&
+					    bond_is_slave_rx_disabled(slave)) {
+						ad_enable_collecting(port);
+						*update_slave_arr = true;
+					}
+				}
+			}
+			break;
+		case AD_MUX_DISTRIBUTING:
 			if (!(port->sm_vars & AD_PORT_SELECTED) ||
 			    (port->sm_vars & AD_PORT_STANDBY) ||
+			    !(port->partner_oper.port_state & LACP_STATE_COLLECTING) ||
 			    !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) ||
 			    !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION)) {
-				port->sm_mux_state = AD_MUX_ATTACHED;
+				port->sm_mux_state = AD_MUX_COLLECTING;
 			} else {
 				/* if port state hasn't changed make
 				 * sure that a collecting distributing
@@ -1031,7 +1121,7 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 				 */
 				if (port->aggregator &&
 				    port->aggregator->is_active &&
-				    !__port_is_enabled(port)) {
+				    !__port_is_collecting_distributing(port)) {
 					__enable_port(port);
 					*update_slave_arr = true;
 				}
@@ -1082,6 +1172,20 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 							  update_slave_arr);
 			port->ntt = true;
 			break;
+		case AD_MUX_COLLECTING:
+			port->actor_oper_port_state |= LACP_STATE_COLLECTING;
+			port->actor_oper_port_state &= ~LACP_STATE_DISTRIBUTING;
+			port->actor_oper_port_state |= LACP_STATE_SYNCHRONIZATION;
+			ad_enable_collecting(port);
+			ad_disable_distributing(port, update_slave_arr);
+			port->ntt = true;
+			break;
+		case AD_MUX_DISTRIBUTING:
+			port->actor_oper_port_state |= LACP_STATE_DISTRIBUTING;
+			port->actor_oper_port_state |= LACP_STATE_SYNCHRONIZATION;
+			ad_enable_collecting_distributing(port,
+							  update_slave_arr);
+			break;
 		default:
 			break;
 		}
@@ -1906,6 +2010,45 @@ static void ad_initialize_port(struct port *port, int lacp_fast)
 	}
 }
 
+/**
+ * ad_enable_collecting - enable a port's receive
+ * @port: the port we're looking at
+ *
+ * Enable @port if it's in an active aggregator
+ */
+static void ad_enable_collecting(struct port *port)
+{
+	if (port->aggregator->is_active) {
+		struct slave *slave = port->slave;
+
+		slave_dbg(slave->bond->dev, slave->dev,
+			  "Enabling collecting on port %d (LAG %d)\n",
+			  port->actor_port_number,
+			  port->aggregator->aggregator_identifier);
+		__enable_collecting_port(port);
+	}
+}
+
+/**
+ * ad_disable_distributing - disable a port's transmit
+ * @port: the port we're looking at
+ * @update_slave_arr: Does slave array need update?
+ */
+static void ad_disable_distributing(struct port *port, bool *update_slave_arr)
+{
+	if (port->aggregator &&
+	    !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,
+			       &(null_mac_addr))) {
+		slave_dbg(port->slave->bond->dev, port->slave->dev,
+			  "Disabling distributing on port %d (LAG %d)\n",
+			  port->actor_port_number,
+			  port->aggregator->aggregator_identifier);
+		__disable_distributing_port(port);
+		/* Slave array needs an update */
+		*update_slave_arr = true;
+	}
+}
+
 /**
  * ad_enable_collecting_distributing - enable a port's transmit/receive
  * @port: the port we're looking at
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 8e6cc0e133b7..30f4b0ff01c0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6331,6 +6331,7 @@ static int __init bond_check_params(struct bond_params *params)
 	params->ad_actor_sys_prio = ad_actor_sys_prio;
 	eth_zero_addr(params->ad_actor_system);
 	params->ad_user_port_key = ad_user_port_key;
+	params->coupled_control = 1;
 	if (packets_per_slave > 0) {
 		params->reciprocal_packets_per_slave =
 			reciprocal_value(packets_per_slave);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index cfa74cf8bb1a..29b4c3d1b9b6 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -122,6 +122,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 	[IFLA_BOND_PEER_NOTIF_DELAY]    = NLA_POLICY_FULL_RANGE(NLA_U32, &delay_range),
 	[IFLA_BOND_MISSED_MAX]		= { .type = NLA_U8 },
 	[IFLA_BOND_NS_IP6_TARGET]	= { .type = NLA_NESTED },
+	[IFLA_BOND_COUPLED_CONTROL]	= { .type = NLA_U8 },
 };
 
 static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
@@ -549,6 +550,16 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BOND_COUPLED_CONTROL]) {
+		int coupled_control = nla_get_u8(data[IFLA_BOND_COUPLED_CONTROL]);
+
+		bond_opt_initval(&newval, coupled_control);
+		err = __bond_opt_set(bond, BOND_OPT_COUPLED_CONTROL, &newval,
+				     data[IFLA_BOND_COUPLED_CONTROL], extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -615,6 +626,7 @@ static size_t bond_get_size(const struct net_device *bond_dev)
 						/* IFLA_BOND_NS_IP6_TARGET */
 		nla_total_size(sizeof(struct nlattr)) +
 		nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_TARGETS +
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_COUPLED_CONTROL */
 		0;
 }
 
@@ -774,6 +786,10 @@ static int bond_fill_info(struct sk_buff *skb,
 		       bond->params.missed_max))
 		goto nla_put_failure;
 
+	if (nla_put_u8(skb, IFLA_BOND_COUPLED_CONTROL,
+		       bond->params.coupled_control))
+		goto nla_put_failure;
+
 	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
 		struct ad_info info;
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index f3f27f0bd2a6..4cdbc7e084f4 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -84,7 +84,8 @@ static int bond_option_ad_user_port_key_set(struct bonding *bond,
 					    const struct bond_opt_value *newval);
 static int bond_option_missed_max_set(struct bonding *bond,
 				      const struct bond_opt_value *newval);
-
+static int bond_option_coupled_control_set(struct bonding *bond,
+					   const struct bond_opt_value *newval);
 
 static const struct bond_opt_value bond_mode_tbl[] = {
 	{ "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
@@ -232,6 +233,12 @@ static const struct bond_opt_value bond_missed_max_tbl[] = {
 	{ NULL,		-1,	0},
 };
 
+static const struct bond_opt_value bond_coupled_control_tbl[] = {
+	{ "on",  1,  BOND_VALFLAG_DEFAULT},
+	{ "off", 0,  0},
+	{ NULL,  -1, 0},
+};
+
 static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 	[BOND_OPT_MODE] = {
 		.id = BOND_OPT_MODE,
@@ -496,6 +503,15 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 		.desc = "Delay between each peer notification on failover event, in milliseconds",
 		.values = bond_peer_notif_delay_tbl,
 		.set = bond_option_peer_notif_delay_set
+	},
+	[BOND_OPT_COUPLED_CONTROL] = {
+		.id = BOND_OPT_COUPLED_CONTROL,
+		.name = "coupled_control",
+		.desc = "Opt into using coupled control MUX for LACP states",
+		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
+		.flags = BOND_OPTFLAG_IFDOWN,
+		.values = bond_coupled_control_tbl,
+		.set = bond_option_coupled_control_set,
 	}
 };
 
@@ -1692,3 +1708,13 @@ static int bond_option_ad_user_port_key_set(struct bonding *bond,
 	bond->params.ad_user_port_key = newval->value;
 	return 0;
 }
+
+static int bond_option_coupled_control_set(struct bonding *bond,
+					   const struct bond_opt_value *newval)
+{
+	netdev_info(bond->dev, "Setting coupled_control to %s (%llu)\n",
+		    newval->string, newval->value);
+
+	bond->params.coupled_control = newval->value;
+	return 0;
+}
diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 43be458422b3..95d88df94756 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -154,6 +154,8 @@ static void bond_info_show_master(struct seq_file *seq)
 			   (bond->params.lacp_active) ? "on" : "off");
 		seq_printf(seq, "LACP rate: %s\n",
 			   (bond->params.lacp_fast) ? "fast" : "slow");
+		seq_printf(seq, "LACP coupled_control: %s\n",
+			   (bond->params.coupled_control) ? "on" : "off");
 		seq_printf(seq, "Min links: %d\n", bond->params.min_links);
 		optval = bond_opt_get_val(BOND_OPT_AD_SELECT,
 					  bond->params.ad_select);
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index c5e57c6bd873..9ce5ac2bfbad 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -54,6 +54,8 @@ typedef enum {
 	AD_MUX_DETACHED,	/* mux machine */
 	AD_MUX_WAITING,		/* mux machine */
 	AD_MUX_ATTACHED,	/* mux machine */
+	AD_MUX_COLLECTING,	/* mux machine */
+	AD_MUX_DISTRIBUTING,	/* mux machine */
 	AD_MUX_COLLECTING_DISTRIBUTING	/* mux machine */
 } mux_states_t;
 
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index 69292ecc0325..473a0147769e 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -76,6 +76,7 @@ enum {
 	BOND_OPT_MISSED_MAX,
 	BOND_OPT_NS_TARGETS,
 	BOND_OPT_PRIO,
+	BOND_OPT_COUPLED_CONTROL,
 	BOND_OPT_LAST
 };
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 5b8b1b644a2d..b61fb1aa3a56 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -148,6 +148,7 @@ struct bond_params {
 #if IS_ENABLED(CONFIG_IPV6)
 	struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
 #endif
+	int coupled_control;
 
 	/* 2 bytes of padding : see ether_addr_equal_64bits() */
 	u8 ad_actor_system[ETH_ALEN + 2];
@@ -167,6 +168,7 @@ struct slave {
 	u8     backup:1,   /* indicates backup slave. Value corresponds with
 			      BOND_STATE_ACTIVE and BOND_STATE_BACKUP */
 	       inactive:1, /* indicates inactive slave */
+	       rx_disabled:1, /* indicates whether slave's Rx is disabled */
 	       should_notify:1, /* indicates whether the state changed */
 	       should_notify_link:1; /* indicates whether the link changed */
 	u8     duplex;
@@ -568,6 +570,14 @@ static inline void bond_set_slave_inactive_flags(struct slave *slave,
 		bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
 	if (!slave->bond->params.all_slaves_active)
 		slave->inactive = 1;
+	if (BOND_MODE(slave->bond) == BOND_MODE_8023AD)
+		slave->rx_disabled = 1;
+}
+
+static inline void bond_set_slave_tx_disabled_flags(struct slave *slave,
+						 bool notify)
+{
+	bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
 }
 
 static inline void bond_set_slave_active_flags(struct slave *slave,
@@ -575,6 +585,14 @@ static inline void bond_set_slave_active_flags(struct slave *slave,
 {
 	bond_set_slave_state(slave, BOND_STATE_ACTIVE, notify);
 	slave->inactive = 0;
+	if (BOND_MODE(slave->bond) == BOND_MODE_8023AD)
+		slave->rx_disabled = 0;
+}
+
+static inline void bond_set_slave_rx_enabled_flags(struct slave *slave,
+					       bool notify)
+{
+	slave->rx_disabled = 0;
 }
 
 static inline bool bond_is_slave_inactive(struct slave *slave)
@@ -582,6 +600,11 @@ static inline bool bond_is_slave_inactive(struct slave *slave)
 	return slave->inactive;
 }
 
+static inline bool bond_is_slave_rx_disabled(struct slave *slave)
+{
+	return slave->rx_disabled;
+}
+
 static inline void bond_propose_link_state(struct slave *slave, int state)
 {
 	slave->link_new_state = state;
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 29ff80da2775..7a54fcff2eec 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -976,6 +976,7 @@ enum {
 	IFLA_BOND_AD_LACP_ACTIVE,
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
+	IFLA_BOND_COUPLED_CONTROL,
 	__IFLA_BOND_MAX,
 };
 
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index a0aa05a28cf2..f0d71b2a3f1e 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -974,6 +974,7 @@ enum {
 	IFLA_BOND_AD_LACP_ACTIVE,
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
+	IFLA_BOND_COUPLED_CONTROL,
 	__IFLA_BOND_MAX,
 };
 
-- 
2.43.0.429.g432eaa2c6b-goog


