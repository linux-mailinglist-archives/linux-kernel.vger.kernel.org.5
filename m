Return-Path: <linux-kernel+bounces-36505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A9483A1EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FB3282B54
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F7DF51B;
	Wed, 24 Jan 2024 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JjnzNrHx"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88FEF9C6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706077008; cv=none; b=f/s14kIBFr9eHZnCV94/zdLj2DolFvk7w6E1ElIDh9qYcUiKy11jqdPqP+vDxbRK7JVotuywaHNPZj9E6Zitbf0koC6rMBUkd45tkmSxNaR7danYxYSWQIwIhkYxh6/dd+sPlZF80KvFZFTsevdzNOJ9m/7GRQ1/OQo6Nno4BsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706077008; c=relaxed/simple;
	bh=NDfNY1A91hOJk9nmptpBj0Mh4yR5eif4UOu+e5UdAfg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=cUae+PZLgVtwjOQM5n8mLNdqnU7sGoCdGxWjDN5xlMDllrnao59tkc+cQjCS/xVR+3lrX9LFuL6GDN5cCcVndsHv5Af1Kbp0loJaqFieD1Mlp4r9t+d7FPx83LFb84XxFcntrs4/1CnSi9nbFJlLa7SCyzTM7vN2Rcp/1Jp8zgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JjnzNrHx; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 89FC7404AC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706077002;
	bh=kFFEEkklruLef2CO1f3reSuxLlXcxHiLnng/cmxVKXI=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=JjnzNrHxKn8llFR3D3CaMMMb6S6LWWIO1GsHApUybhLLt/6+RYxwqcha0DBvxZCnl
	 lKiesd3j4lhq2HF7e+73ueWYbejCJ9ATcxnJB/bQ17277uY4VwaInfTUCnXUAxRE8i
	 OZHiad6rEIC3gD0RQusUej6hbWXnj5kSu1gSb3x3rpluXyE377Afb5h824MuTA+CG7
	 FnLiy6wnpZpoETA0Ji1X3oQcrwrLwBR3aXb7Wm2rpoe0rUiZZGmY3yIKrcGg103AGk
	 f/gSERgBHqoEbdHJt3aG/nRtlbJG96613rBal+IhDcBvkU5+S2iTEb/XWDI/TuN5FD
	 zqlHaooaeoaRw==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bb9f35fbfcso5572413b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706076999; x=1706681799;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFFEEkklruLef2CO1f3reSuxLlXcxHiLnng/cmxVKXI=;
        b=wKGY3SfEsUvsUldfyJxpfGLVthQQpL0cMmIDGz4vTQtg1J0CRH6eu0elcqxSEkyK97
         LKl2wW0YEeGzcBFVTv3/EopCOvbDryG6eEHMV++sZ+PMaqeWYl6FxtvvjTHUpibJSU7c
         0KDAGOVbyC1KfRfdYdyCnUhJ8M60ri2Lio3r6Q9X3H77NxYKeqQj8bLq6pS3+L/yFtz9
         I41TC5dDWUEcrt+ng+aJpR29nSMWXARp8wbgJ7k+gi4UlsCbbHP06azaCXlEIQihNx16
         Ik7V28/1ugbY+2BJ4c6Xbo5LFwu2FCoe+5+/tdHRkMkTvawomP5TJh1QNhhhCnk50QqB
         /pFw==
X-Gm-Message-State: AOJu0YzPwsRGiJBMJ/hHzX6JmdsUpLp8f6D+3+YIdF1neUgDIg2aMsKJ
	9NLL4hTvFH4An3aYm7exflcd8CrSOmX9Q8cZQt+Pk+FxUW9o7qxL+O1natQn9zwhKv/3iJUYzCK
	aLiJm7g5qHO5GhzacUG3URp0GBeQEYqTk/2yt3qdX3U3RiGYPKudbe5cLQVhJI9q96+ePgphh82
	Doqw==
X-Received: by 2002:a05:6808:3989:b0:3bd:815d:3cb1 with SMTP id gq9-20020a056808398900b003bd815d3cb1mr1244230oib.57.1706076999363;
        Tue, 23 Jan 2024 22:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1hgrVCmud/U1vi99cbG/x+TS9Bd+N2nvmR79+cTQR4674lXFlt6niWEOiBbocxI0RQA5fqQ==
X-Received: by 2002:a05:6808:3989:b0:3bd:815d:3cb1 with SMTP id gq9-20020a056808398900b003bd815d3cb1mr1244218oib.57.1706076999022;
        Tue, 23 Jan 2024 22:16:39 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78007000000b006d638fd230bsm13119714pfi.93.2024.01.23.22.16.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 22:16:38 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 21ABB5FFF6; Tue, 23 Jan 2024 22:16:38 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 1BA7C9FB50;
	Tue, 23 Jan 2024 22:16:38 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Aahil Awatramani <aahila@google.com>
cc: David Dillow <dave@thedillows.org>,
    Mahesh Bandewar <maheshb@google.com>,
    Hangbin Liu <liuhangbin@gmail.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Martin KaFai Lau <martin.lau@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] bonding: Add independent control state machine
In-reply-to: <20240123235130.1982654-1-aahila@google.com>
References: <20240123235130.1982654-1-aahila@google.com>
Comments: In-reply-to Aahil Awatramani <aahila@google.com>
   message dated "Tue, 23 Jan 2024 23:51:30 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4576.1706076998.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jan 2024 22:16:38 -0800
Message-ID: <4577.1706076998@famine>

Aahil Awatramani <aahila@google.com> wrote:

>Add support for the independent control state machine per IEEE
>802.1AX-2008 5.4.15 in addition to the existing implementation of the
>coupled control state machine.
>
>Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
>the LACP MUX state machine for separated handling of an initial
>Collecting state before the Collecting and Distributing state. This
>enables a port to be in a state where it can receive incoming packets
>while not still distributing. This is useful for reducing packet loss whe=
n
>a port begins distributing before its partner is able to collect.
>
>Added new functions such as bond_set_slave_tx_disabled_flags and
>bond_set_slave_rx_enabled_flags to precisely manage the port's collecting
>and distributing states. Previously, there was no dedicated method to
>disable TX while keeping RX enabled, which this patch addresses.
>
>Note that the regular flow process in the kernel's bonding driver remains
>unaffected by this patch. The extension requires explicit opt-in by the
>user (in order to ensure no disruptions for existing setups) via netlink
>support using the new bonding parameter coupled_control. The default valu=
e
>for coupled_control is set to 1 so as to preserve existing behaviour.

	Do you have a corresponding iproute2 patch to enable changing
the coupled_control option?

	-J

>Signed-off-by: Aahil Awatramani <aahila@google.com>
>
>v5:
>  Merge documentation patch with changes patch
>  Add version history in comment description
>v4:
>  Remove inline references from c source files
>v3:
>  Edited commit description
>  Edited documentation description
>  Changed function names
>  Only allow coupled_control change when the bond is down
>v2:
>  Removed sysfs changes
>  Added documentation for new paramater
>  Renamed parameter to coupled_control
>  Update bond_set_slave_inactive_flags() with a 8023ad check
>
>---
> Documentation/networking/bonding.rst |  12 ++
> drivers/net/bonding/bond_3ad.c       | 157 +++++++++++++++++++++++++--
> drivers/net/bonding/bond_main.c      |   1 +
> drivers/net/bonding/bond_netlink.c   |  16 +++
> drivers/net/bonding/bond_options.c   |  28 ++++-
> include/net/bond_3ad.h               |   2 +
> include/net/bond_options.h           |   1 +
> include/net/bonding.h                |  23 ++++
> include/uapi/linux/if_link.h         |   1 +
> tools/include/uapi/linux/if_link.h   |   1 +
> 10 files changed, 234 insertions(+), 8 deletions(-)
>
>diff --git a/Documentation/networking/bonding.rst b/Documentation/network=
ing/bonding.rst
>index f7a73421eb76..e774b48de9f5 100644
>--- a/Documentation/networking/bonding.rst
>+++ b/Documentation/networking/bonding.rst
>@@ -444,6 +444,18 @@ arp_missed_max
> =

> 	The default value is 2, and the allowable range is 1 - 255.
> =

>+coupled_control
>+
>+    Specifies whether the LACP state machine's MUX in the 802.3ad mode
>+    should have separate Collecting and Distributing states.
>+
>+    This is by implementing the independent control state machine per
>+    IEEE 802.1AX-2008 5.4.15 in addition to the existing coupled control
>+    state machine.
>+
>+    The default value is 1. This setting does not separate the Collectin=
g
>+    and Distributing states, maintaining the bond in coupled control.
>+
> downdelay
> =

> 	Specifies the time, in milliseconds, to wait before disabling
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index c99ffe6c683a..f2942e8c6c91 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -106,6 +106,9 @@ static void ad_agg_selection_logic(struct aggregator =
*aggregator,
> static void ad_clear_agg(struct aggregator *aggregator);
> static void ad_initialize_agg(struct aggregator *aggregator);
> static void ad_initialize_port(struct port *port, int lacp_fast);
>+static void ad_enable_collecting(struct port *port);
>+static void ad_disable_distributing(struct port *port,
>+				    bool *update_slave_arr);
> static void ad_enable_collecting_distributing(struct port *port,
> 					      bool *update_slave_arr);
> static void ad_disable_collecting_distributing(struct port *port,
>@@ -171,9 +174,38 @@ static inline int __agg_has_partner(struct aggregato=
r *agg)
> 	return !is_zero_ether_addr(agg->partner_system.mac_addr_value);
> }
> =

>+/**
>+ * __disable_distributing_port - disable the port's slave for distributi=
ng.
>+ * Port will still be able to collect.
>+ * @port: the port we're looking at
>+ *
>+ * This will disable only distributing on the port's slave.
>+ */
>+static void __disable_distributing_port(struct port *port)
>+{
>+	bond_set_slave_tx_disabled_flags(port->slave, BOND_SLAVE_NOTIFY_LATER);
>+}
>+
>+/**
>+ * __enable_collecting_port - enable the port's slave for collecting,
>+ * if it's up
>+ * @port: the port we're looking at
>+ *
>+ * This will enable only collecting on the port's slave.
>+ */
>+static void __enable_collecting_port(struct port *port)
>+{
>+	struct slave *slave =3D port->slave;
>+
>+	if (slave->link =3D=3D BOND_LINK_UP && bond_slave_is_up(slave))
>+		bond_set_slave_rx_enabled_flags(slave, BOND_SLAVE_NOTIFY_LATER);
>+}
>+
> /**
>  * __disable_port - disable the port's slave
>  * @port: the port we're looking at
>+ *
>+ * This will disable both collecting and distributing on the port's slav=
e.
>  */
> static inline void __disable_port(struct port *port)
> {
>@@ -183,6 +215,8 @@ static inline void __disable_port(struct port *port)
> /**
>  * __enable_port - enable the port's slave, if it's up
>  * @port: the port we're looking at
>+ *
>+ * This will enable both collecting and distributing on the port's slave=
.
>  */
> static inline void __enable_port(struct port *port)
> {
>@@ -193,10 +227,27 @@ static inline void __enable_port(struct port *port)
> }
> =

> /**
>- * __port_is_enabled - check if the port's slave is in active state
>+ * __port_move_to_attached_state - check if port should transition back =
to attached
>+ * state.
>+ * @port: the port we're looking at
>+ */
>+static bool __port_move_to_attached_state(struct port *port)
>+{
>+	if (!(port->sm_vars & AD_PORT_SELECTED) ||
>+	    (port->sm_vars & AD_PORT_STANDBY) ||
>+	    !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) ||
>+	    !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION))
>+		port->sm_mux_state =3D AD_MUX_ATTACHED;
>+
>+	return port->sm_mux_state =3D=3D AD_MUX_ATTACHED;
>+}
>+
>+/**
>+ * __port_is_collecting_distributing - check if the port's slave is in t=
he
>+ * combined collecting/distributing state
>  * @port: the port we're looking at
>  */
>-static inline int __port_is_enabled(struct port *port)
>+static int __port_is_collecting_distributing(struct port *port)
> {
> 	return bond_is_active_slave(port->slave);
> }
>@@ -942,6 +993,7 @@ static int ad_marker_send(struct port *port, struct b=
ond_marker *marker)
>  */
> static void ad_mux_machine(struct port *port, bool *update_slave_arr)
> {
>+	struct bonding *bond =3D __get_bond_by_port(port);
> 	mux_states_t last_state;
> =

> 	/* keep current State Machine state to compare later if it was
>@@ -999,9 +1051,13 @@ static void ad_mux_machine(struct port *port, bool =
*update_slave_arr)
> 			if ((port->sm_vars & AD_PORT_SELECTED) &&
> 			    (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) &&
> 			    !__check_agg_selection_timer(port)) {
>-				if (port->aggregator->is_active)
>-					port->sm_mux_state =3D
>-					    AD_MUX_COLLECTING_DISTRIBUTING;
>+				if (port->aggregator->is_active) {
>+					int state =3D AD_MUX_COLLECTING_DISTRIBUTING;
>+
>+					if (!bond->params.coupled_control)
>+						state =3D AD_MUX_COLLECTING;
>+					port->sm_mux_state =3D state;
>+				}
> 			} else if (!(port->sm_vars & AD_PORT_SELECTED) ||
> 				   (port->sm_vars & AD_PORT_STANDBY)) {
> 				/* if UNSELECTED or STANDBY */
>@@ -1019,11 +1075,45 @@ static void ad_mux_machine(struct port *port, boo=
l *update_slave_arr)
> 			}
> 			break;
> 		case AD_MUX_COLLECTING_DISTRIBUTING:
>+			if (!__port_move_to_attached_state(port)) {
>+				/* if port state hasn't changed make
>+				 * sure that a collecting distributing
>+				 * port in an active aggregator is enabled
>+				 */
>+				if (port->aggregator->is_active &&
>+				    !__port_is_collecting_distributing(port)) {
>+					__enable_port(port);
>+					*update_slave_arr =3D true;
>+				}
>+			}
>+			break;
>+		case AD_MUX_COLLECTING:
>+			if (!__port_move_to_attached_state(port)) {
>+				if ((port->sm_vars & AD_PORT_SELECTED) &&
>+				    (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) &&
>+				    (port->partner_oper.port_state & LACP_STATE_COLLECTING)) {
>+					port->sm_mux_state =3D AD_MUX_DISTRIBUTING;
>+				} else {
>+					/* If port state hasn't changed, make sure that a collecting
>+					 * port is enabled for an active aggregator.
>+					 */
>+					struct slave *slave =3D port->slave;
>+
>+					if (port->aggregator->is_active &&
>+					    bond_is_slave_rx_disabled(slave)) {
>+						ad_enable_collecting(port);
>+						*update_slave_arr =3D true;
>+					}
>+				}
>+			}
>+			break;
>+		case AD_MUX_DISTRIBUTING:
> 			if (!(port->sm_vars & AD_PORT_SELECTED) ||
> 			    (port->sm_vars & AD_PORT_STANDBY) ||
>+			    !(port->partner_oper.port_state & LACP_STATE_COLLECTING) ||
> 			    !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) ||
> 			    !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION)) {
>-				port->sm_mux_state =3D AD_MUX_ATTACHED;
>+				port->sm_mux_state =3D AD_MUX_COLLECTING;
> 			} else {
> 				/* if port state hasn't changed make
> 				 * sure that a collecting distributing
>@@ -1031,7 +1121,7 @@ static void ad_mux_machine(struct port *port, bool =
*update_slave_arr)
> 				 */
> 				if (port->aggregator &&
> 				    port->aggregator->is_active &&
>-				    !__port_is_enabled(port)) {
>+				    !__port_is_collecting_distributing(port)) {
> 					__enable_port(port);
> 					*update_slave_arr =3D true;
> 				}
>@@ -1082,6 +1172,20 @@ static void ad_mux_machine(struct port *port, bool=
 *update_slave_arr)
> 							  update_slave_arr);
> 			port->ntt =3D true;
> 			break;
>+		case AD_MUX_COLLECTING:
>+			port->actor_oper_port_state |=3D LACP_STATE_COLLECTING;
>+			port->actor_oper_port_state &=3D ~LACP_STATE_DISTRIBUTING;
>+			port->actor_oper_port_state |=3D LACP_STATE_SYNCHRONIZATION;
>+			ad_enable_collecting(port);
>+			ad_disable_distributing(port, update_slave_arr);
>+			port->ntt =3D true;
>+			break;
>+		case AD_MUX_DISTRIBUTING:
>+			port->actor_oper_port_state |=3D LACP_STATE_DISTRIBUTING;
>+			port->actor_oper_port_state |=3D LACP_STATE_SYNCHRONIZATION;
>+			ad_enable_collecting_distributing(port,
>+							  update_slave_arr);
>+			break;
> 		default:
> 			break;
> 		}
>@@ -1906,6 +2010,45 @@ static void ad_initialize_port(struct port *port, =
int lacp_fast)
> 	}
> }
> =

>+/**
>+ * ad_enable_collecting - enable a port's receive
>+ * @port: the port we're looking at
>+ *
>+ * Enable @port if it's in an active aggregator
>+ */
>+static void ad_enable_collecting(struct port *port)
>+{
>+	if (port->aggregator->is_active) {
>+		struct slave *slave =3D port->slave;
>+
>+		slave_dbg(slave->bond->dev, slave->dev,
>+			  "Enabling collecting on port %d (LAG %d)\n",
>+			  port->actor_port_number,
>+			  port->aggregator->aggregator_identifier);
>+		__enable_collecting_port(port);
>+	}
>+}
>+
>+/**
>+ * ad_disable_distributing - disable a port's transmit
>+ * @port: the port we're looking at
>+ * @update_slave_arr: Does slave array need update?
>+ */
>+static void ad_disable_distributing(struct port *port, bool *update_slav=
e_arr)
>+{
>+	if (port->aggregator &&
>+	    !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,
>+			       &(null_mac_addr))) {
>+		slave_dbg(port->slave->bond->dev, port->slave->dev,
>+			  "Disabling distributing on port %d (LAG %d)\n",
>+			  port->actor_port_number,
>+			  port->aggregator->aggregator_identifier);
>+		__disable_distributing_port(port);
>+		/* Slave array needs an update */
>+		*update_slave_arr =3D true;
>+	}
>+}
>+
> /**
>  * ad_enable_collecting_distributing - enable a port's transmit/receive
>  * @port: the port we're looking at
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 8e6cc0e133b7..30f4b0ff01c0 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -6331,6 +6331,7 @@ static int __init bond_check_params(struct bond_par=
ams *params)
> 	params->ad_actor_sys_prio =3D ad_actor_sys_prio;
> 	eth_zero_addr(params->ad_actor_system);
> 	params->ad_user_port_key =3D ad_user_port_key;
>+	params->coupled_control =3D 1;
> 	if (packets_per_slave > 0) {
> 		params->reciprocal_packets_per_slave =3D
> 			reciprocal_value(packets_per_slave);
>diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bon=
d_netlink.c
>index cfa74cf8bb1a..29b4c3d1b9b6 100644
>--- a/drivers/net/bonding/bond_netlink.c
>+++ b/drivers/net/bonding/bond_netlink.c
>@@ -122,6 +122,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_=
MAX + 1] =3D {
> 	[IFLA_BOND_PEER_NOTIF_DELAY]    =3D NLA_POLICY_FULL_RANGE(NLA_U32, &del=
ay_range),
> 	[IFLA_BOND_MISSED_MAX]		=3D { .type =3D NLA_U8 },
> 	[IFLA_BOND_NS_IP6_TARGET]	=3D { .type =3D NLA_NESTED },
>+	[IFLA_BOND_COUPLED_CONTROL]	=3D { .type =3D NLA_U8 },
> };
> =

> static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1=
] =3D {
>@@ -549,6 +550,16 @@ static int bond_changelink(struct net_device *bond_d=
ev, struct nlattr *tb[],
> 			return err;
> 	}
> =

>+	if (data[IFLA_BOND_COUPLED_CONTROL]) {
>+		int coupled_control =3D nla_get_u8(data[IFLA_BOND_COUPLED_CONTROL]);
>+
>+		bond_opt_initval(&newval, coupled_control);
>+		err =3D __bond_opt_set(bond, BOND_OPT_COUPLED_CONTROL, &newval,
>+				     data[IFLA_BOND_COUPLED_CONTROL], extack);
>+		if (err)
>+			return err;
>+	}
>+
> 	return 0;
> }
> =

>@@ -615,6 +626,7 @@ static size_t bond_get_size(const struct net_device *=
bond_dev)
> 						/* IFLA_BOND_NS_IP6_TARGET */
> 		nla_total_size(sizeof(struct nlattr)) +
> 		nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_TARGETS +
>+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_COUPLED_CONTROL */
> 		0;
> }
> =

>@@ -774,6 +786,10 @@ static int bond_fill_info(struct sk_buff *skb,
> 		       bond->params.missed_max))
> 		goto nla_put_failure;
> =

>+	if (nla_put_u8(skb, IFLA_BOND_COUPLED_CONTROL,
>+		       bond->params.coupled_control))
>+		goto nla_put_failure;
>+
> 	if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
> 		struct ad_info info;
> =

>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index f3f27f0bd2a6..4cdbc7e084f4 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -84,7 +84,8 @@ static int bond_option_ad_user_port_key_set(struct bond=
ing *bond,
> 					    const struct bond_opt_value *newval);
> static int bond_option_missed_max_set(struct bonding *bond,
> 				      const struct bond_opt_value *newval);
>-
>+static int bond_option_coupled_control_set(struct bonding *bond,
>+					   const struct bond_opt_value *newval);
> =

> static const struct bond_opt_value bond_mode_tbl[] =3D {
> 	{ "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
>@@ -232,6 +233,12 @@ static const struct bond_opt_value bond_missed_max_t=
bl[] =3D {
> 	{ NULL,		-1,	0},
> };
> =

>+static const struct bond_opt_value bond_coupled_control_tbl[] =3D {
>+	{ "on",  1,  BOND_VALFLAG_DEFAULT},
>+	{ "off", 0,  0},
>+	{ NULL,  -1, 0},
>+};
>+
> static const struct bond_option bond_opts[BOND_OPT_LAST] =3D {
> 	[BOND_OPT_MODE] =3D {
> 		.id =3D BOND_OPT_MODE,
>@@ -496,6 +503,15 @@ static const struct bond_option bond_opts[BOND_OPT_L=
AST] =3D {
> 		.desc =3D "Delay between each peer notification on failover event, in =
milliseconds",
> 		.values =3D bond_peer_notif_delay_tbl,
> 		.set =3D bond_option_peer_notif_delay_set
>+	},
>+	[BOND_OPT_COUPLED_CONTROL] =3D {
>+		.id =3D BOND_OPT_COUPLED_CONTROL,
>+		.name =3D "coupled_control",
>+		.desc =3D "Opt into using coupled control MUX for LACP states",
>+		.unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
>+		.flags =3D BOND_OPTFLAG_IFDOWN,
>+		.values =3D bond_coupled_control_tbl,
>+		.set =3D bond_option_coupled_control_set,
> 	}
> };
> =

>@@ -1692,3 +1708,13 @@ static int bond_option_ad_user_port_key_set(struct=
 bonding *bond,
> 	bond->params.ad_user_port_key =3D newval->value;
> 	return 0;
> }
>+
>+static int bond_option_coupled_control_set(struct bonding *bond,
>+					   const struct bond_opt_value *newval)
>+{
>+	netdev_info(bond->dev, "Setting coupled_control to %s (%llu)\n",
>+		    newval->string, newval->value);
>+
>+	bond->params.coupled_control =3D newval->value;
>+	return 0;
>+}
>diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
>index c5e57c6bd873..9ce5ac2bfbad 100644
>--- a/include/net/bond_3ad.h
>+++ b/include/net/bond_3ad.h
>@@ -54,6 +54,8 @@ typedef enum {
> 	AD_MUX_DETACHED,	/* mux machine */
> 	AD_MUX_WAITING,		/* mux machine */
> 	AD_MUX_ATTACHED,	/* mux machine */
>+	AD_MUX_COLLECTING,	/* mux machine */
>+	AD_MUX_DISTRIBUTING,	/* mux machine */
> 	AD_MUX_COLLECTING_DISTRIBUTING	/* mux machine */
> } mux_states_t;
> =

>diff --git a/include/net/bond_options.h b/include/net/bond_options.h
>index 69292ecc0325..473a0147769e 100644
>--- a/include/net/bond_options.h
>+++ b/include/net/bond_options.h
>@@ -76,6 +76,7 @@ enum {
> 	BOND_OPT_MISSED_MAX,
> 	BOND_OPT_NS_TARGETS,
> 	BOND_OPT_PRIO,
>+	BOND_OPT_COUPLED_CONTROL,
> 	BOND_OPT_LAST
> };
> =

>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index 5b8b1b644a2d..b61fb1aa3a56 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -148,6 +148,7 @@ struct bond_params {
> #if IS_ENABLED(CONFIG_IPV6)
> 	struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
> #endif
>+	int coupled_control;
> =

> 	/* 2 bytes of padding : see ether_addr_equal_64bits() */
> 	u8 ad_actor_system[ETH_ALEN + 2];
>@@ -167,6 +168,7 @@ struct slave {
> 	u8     backup:1,   /* indicates backup slave. Value corresponds with
> 			      BOND_STATE_ACTIVE and BOND_STATE_BACKUP */
> 	       inactive:1, /* indicates inactive slave */
>+	       rx_disabled:1, /* indicates whether slave's Rx is disabled */
> 	       should_notify:1, /* indicates whether the state changed */
> 	       should_notify_link:1; /* indicates whether the link changed */
> 	u8     duplex;
>@@ -568,6 +570,14 @@ static inline void bond_set_slave_inactive_flags(str=
uct slave *slave,
> 		bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
> 	if (!slave->bond->params.all_slaves_active)
> 		slave->inactive =3D 1;
>+	if (BOND_MODE(slave->bond) =3D=3D BOND_MODE_8023AD)
>+		slave->rx_disabled =3D 1;
>+}
>+
>+static inline void bond_set_slave_tx_disabled_flags(struct slave *slave,
>+						 bool notify)
>+{
>+	bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
> }
> =

> static inline void bond_set_slave_active_flags(struct slave *slave,
>@@ -575,6 +585,14 @@ static inline void bond_set_slave_active_flags(struc=
t slave *slave,
> {
> 	bond_set_slave_state(slave, BOND_STATE_ACTIVE, notify);
> 	slave->inactive =3D 0;
>+	if (BOND_MODE(slave->bond) =3D=3D BOND_MODE_8023AD)
>+		slave->rx_disabled =3D 0;
>+}
>+
>+static inline void bond_set_slave_rx_enabled_flags(struct slave *slave,
>+					       bool notify)
>+{
>+	slave->rx_disabled =3D 0;
> }
> =

> static inline bool bond_is_slave_inactive(struct slave *slave)
>@@ -582,6 +600,11 @@ static inline bool bond_is_slave_inactive(struct sla=
ve *slave)
> 	return slave->inactive;
> }
> =

>+static inline bool bond_is_slave_rx_disabled(struct slave *slave)
>+{
>+	return slave->rx_disabled;
>+}
>+
> static inline void bond_propose_link_state(struct slave *slave, int stat=
e)
> {
> 	slave->link_new_state =3D state;
>diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
>index 29ff80da2775..7a54fcff2eec 100644
>--- a/include/uapi/linux/if_link.h
>+++ b/include/uapi/linux/if_link.h
>@@ -976,6 +976,7 @@ enum {
> 	IFLA_BOND_AD_LACP_ACTIVE,
> 	IFLA_BOND_MISSED_MAX,
> 	IFLA_BOND_NS_IP6_TARGET,
>+	IFLA_BOND_COUPLED_CONTROL,
> 	__IFLA_BOND_MAX,
> };
> =

>diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linu=
x/if_link.h
>index a0aa05a28cf2..f0d71b2a3f1e 100644
>--- a/tools/include/uapi/linux/if_link.h
>+++ b/tools/include/uapi/linux/if_link.h
>@@ -974,6 +974,7 @@ enum {
> 	IFLA_BOND_AD_LACP_ACTIVE,
> 	IFLA_BOND_MISSED_MAX,
> 	IFLA_BOND_NS_IP6_TARGET,
>+	IFLA_BOND_COUPLED_CONTROL,
> 	__IFLA_BOND_MAX,
> };
> =

>-- =

>2.43.0.429.g432eaa2c6b-goog
>
>

