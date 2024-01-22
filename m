Return-Path: <linux-kernel+bounces-33882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05165836FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6B41C28E92
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7605BAF9;
	Mon, 22 Jan 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wvLWSTTT"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05745BAF0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946302; cv=none; b=VBvVFNL7t8lpBKpsFRtCxSHLiW3h6vyPy3Qnf2ij/CPhIjTxHC3+Qb1QuSIs8x8Z8dRy92r719bUjBl1ry7lVcCcE9QIClNrzhmgNqCueJk4CqsgQHLg7vWdAWzlHfVLxUXexc8DH/CN+gWyu5iqWmgjXRQcRCeeSws4WovqoKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946302; c=relaxed/simple;
	bh=GGj0RLex6nXUgR/FlJLbx1wER3woIMNhrexujgoKtqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=n2Ze3O8F9GROwaxz8v8YnxnO/vbxMvTOMB1N8L8HsDFbQYObzldqMsDKH2bPVLrUZvTmOLqBnLVQWQeSiXAqH5T8Cl7jELtbo0alsPhqSkwA/Sakv64nJteMVds8UGlUELatqeWhhJNg1jDM1klNRVUWG1j6Q5TVQ2lN3zl2ZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wvLWSTTT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc3645c083aso1138883276.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705946300; x=1706551100; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egxt38KxRq2s5s0Yzj0OS9EVBwB1Zj9bY7AnGM0Rs80=;
        b=wvLWSTTTuCjKsFPvohrlcg4lBiZHkLJ72akaGxiykeGvXz5jIZhvnCWTN6RDwYfQKE
         DCXvF4WUzIwwgXZbWWglVGAdmHbetirAXjZc9NMAZXj+Qus7qtCQrj147J7/Af0Sp0Lk
         l3g6qtQvyOooR7fVjhDAsspSW1pAxJ/IWdSWtCHVNY8kwHMCNp5gRAfI9mhtKElkeo5k
         f46J/c6f5kRfMrJautAsRITg/J+yO9i+uQ9fyG6X0mQTOlOnYS3up6hIH85eM7DIeqVs
         tAr+GTaMwrok2JCtH11C7NBONyyuHSCfexirMmvO2mTCWzxW9Bel0tOtykQIH3R2kM+Q
         qtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705946300; x=1706551100;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egxt38KxRq2s5s0Yzj0OS9EVBwB1Zj9bY7AnGM0Rs80=;
        b=by91orPH/3NlNsnKoYJPLvlW9d+H2VanvO3f9X+faVJfHJHpJaGLPMBmhhZhnp3v+v
         rkyp94ELN3ixb3qTeAgdVeZ4YlOZzOffefT4uTKRzwbCuCZYLMQNhwmAj+R24BHfLt7m
         OkdW9hjTlIeeQ13T6la1IaIVav6sEuDnkBNp9lqrPMk9ns9v70dwp6H7uwBmuWmE/cqR
         u2wh1aL1uWQwuMcS3h+qHlRmq7B88lu2AVd+BOiIgeDlT2hJvWuUi+CGoUnwK12UX+1O
         N4zfyI2gCxEILfs0OswG8nLBho6WVhA6GvH5OW6fmOTao4V4hYwAla2fpTqRZfrqucgq
         Gp7g==
X-Gm-Message-State: AOJu0YzzgD7QE9cdVHI6lOMxh9LB832AIa3S/xZkysNnvoNgt3Nbgexs
	zh3WwzmjKSNdPKvYxTgktSFE/JnYJOp1hj5yLtZFF6Vt8MlNub4ALU8Dx+/nEHiDLWWuj8CdVWL
	Y6g==
X-Google-Smtp-Source: AGHT+IGnb2VLI3CrGR88hlP4/xDElO4E/UMF/8SK3JRooEGZhzA4WyzwMfvjF6kYFMqRY7uUuEUQL1bqyRI=
X-Received: from aahila.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2f3])
 (user=aahila job=sendgmr) by 2002:a05:6902:2412:b0:dc2:4cf5:9ed0 with SMTP id
 dr18-20020a056902241200b00dc24cf59ed0mr2154921ybb.5.1705946299887; Mon, 22
 Jan 2024 09:58:19 -0800 (PST)
Date: Mon, 22 Jan 2024 17:58:10 +0000
In-Reply-To: <20240122175810.1942504-1-aahila@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122175810.1942504-1-aahila@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122175810.1942504-2-aahila@google.com>
Subject: [PATCH net-next v3 2/2] bonding: Add independent control state machine
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
---
 drivers/net/bonding/bond_3ad.c     | 157 +++++++++++++++++++++++++++--
 drivers/net/bonding/bond_main.c    |   1 +
 drivers/net/bonding/bond_netlink.c |  16 +++
 drivers/net/bonding/bond_options.c |  28 ++++-
 include/net/bond_3ad.h             |   2 +
 include/net/bond_options.h         |   1 +
 include/net/bonding.h              |  23 +++++
 include/uapi/linux/if_link.h       |   1 +
 tools/include/uapi/linux/if_link.h |   1 +
 9 files changed, 222 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c99ffe6c683a..ff52c10b382e 100644
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
+static inline void __disable_distributing_port(struct port *port)
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
+static inline void __enable_collecting_port(struct port *port)
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
+static inline bool __port_move_to_attached_state(struct port *port)
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
+static inline int __port_is_collecting_distributing(struct port *port)
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
2.43.0.275.g3460e3d667-goog


