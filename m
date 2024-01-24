Return-Path: <linux-kernel+bounces-37482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4372483B0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C0BB2F9D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC4612A143;
	Wed, 24 Jan 2024 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9JMF494"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6231272CF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119475; cv=none; b=WgKr+oNU7cIxF5QLnM4ycS2p/Dq6hk/8s/2edfswnyzX9CGUhCP8g2kFexCw4BfE1iJiD4eB5f6gJBRWQhs3AeEELuLjH7zK0ebGvyxtSBDTLcCkVkuWF+mj0s0Pqwz4MFWx5HCTaTjB0cLinbm7KaL3M0+Ex1TTuIsnjYpiZ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119475; c=relaxed/simple;
	bh=UiYySL0kiue3sbaAKX3UMN0tpfwxI1X7fKjQ68DSo34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1Z76wNlfo8ldF7c4EVYG7y/2NnssUZovUKi3I0rwD05rUtFESNMuEBTLy1wwR+Y+QskY51FlrmoGL1T2FjuBdOTd0JGk/oyLL6a0sha/Kymv5+eeO9DJLSTxpqjGoaN/rqIRUOGoMswklJTUkla61J4EI5BCF1UHaO+QcZgNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9JMF494; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68198aa2c7fso28420216d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706119471; x=1706724271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWHeqRF52VSJQeKDkkjv4u5FetoNMuuYeHTPMFDweNM=;
        b=Y9JMF494EkrwI9ziYfLXU/U6xoqMWUpAPDzkd1k2y+uAtF2Ti/R8Tly1Lf1K8ap5Zy
         O3PqDSdYxNAhCV0qRqqGzOhL3kk2W2njiTMXpneBONbyw/Hp5mJ7ACxZoWZ4jQhGwhGq
         3fumL0FGflkV4ja8msUCyUbbhHdrbDS555A7QASyPGFeyHbRNTi1wpAA3IPSH2zcncxc
         8oxas1RSSCkYCkuK1K8UsrZpZcdvCV1DFYOcgHDutdsKC+5mmNb2ZUor/K0FhvHlA2Vl
         AF+s0w86/ZRhXZplMCCi4obOlCLDkVc6Y6/Djfcsso6+XaMaN412bAuh/Lpv8fzPwwQ0
         qtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706119471; x=1706724271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWHeqRF52VSJQeKDkkjv4u5FetoNMuuYeHTPMFDweNM=;
        b=RKxTdpaJCtkaoFSDSCgV9lFHrnwKES5kOX7aBGUiSJobeE+2njvfoPE6ICfm0nwWh3
         spgYBwhMR7O9qc7cx0MKM8Ddp/1BWgUClqVC9YC/8+Pg0wC4HuDIf4EPlx00lmPQHb6T
         5UOrimJCAID7ecS4z6Ox22Mlx379x/WX0hQCuvBKS0b5zcU67EHdH3uxXttztelmLT44
         EEuezhWz3qjHWvh9HW1T0CfjP0I+h0uBU0w6yaY+rslMQc3gXxlLZfy62o1Q1oLE0xCJ
         JwRLRkuTiBLWjfCUBWinA7atsjd9NGQvtVg4Q5hw1Q+TjbKKhUrtxPWvWASIdd67uAcF
         MWqA==
X-Gm-Message-State: AOJu0Ywj//XE5bjnx7LOQCR8KuG32OmzLLdSpthK0jYlrS9JmSZz6HH6
	kPUA3W/B4daRJf6vVMn7xge4PjQsZiyILpeG7poOxRHNzlLsV7y3zUsuwgWqjDQdg9nSkCmtpBy
	Svk20vHwaebvV+H02kFok3XxGwtE5qxIjqYXB
X-Google-Smtp-Source: AGHT+IERgTfZtUod63u03AjovR9jxNonDt5XvOdAY0EHbUOZXgNxoro1SP1hL1yTw3kqw6/jpyTE4BhkyIC8mbp+NMs=
X-Received: by 2002:a05:6214:2463:b0:67f:dc29:f9d0 with SMTP id
 im3-20020a056214246300b0067fdc29f9d0mr3914479qvb.114.1706119471462; Wed, 24
 Jan 2024 10:04:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123235130.1982654-1-aahila@google.com> <4577.1706076998@famine>
In-Reply-To: <4577.1706076998@famine>
From: Aahil Awatramani <aahila@google.com>
Date: Wed, 24 Jan 2024 10:04:19 -0800
Message-ID: <CAGfWUPwsh3xFK6JvT9p07eXD2j1V=B=kVNfPOWJj6L4SXyeyDA@mail.gmail.com>
Subject: Re: [PATCH net-next v5] bonding: Add independent control state machine
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: David Dillow <dave@thedillows.org>, Mahesh Bandewar <maheshb@google.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>         Do you have a corresponding iproute2 patch to enable changing
> the coupled_control option?

I do have the corresponding patch for iproute2 to enable changing
coupled_control, I planned to push that patch for review directly
after this one.


On Tue, Jan 23, 2024 at 10:16=E2=80=AFPM Jay Vosburgh
<jay.vosburgh@canonical.com> wrote:
>
> Aahil Awatramani <aahila@google.com> wrote:
>
> >Add support for the independent control state machine per IEEE
> >802.1AX-2008 5.4.15 in addition to the existing implementation of the
> >coupled control state machine.
> >
> >Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
> >the LACP MUX state machine for separated handling of an initial
> >Collecting state before the Collecting and Distributing state. This
> >enables a port to be in a state where it can receive incoming packets
> >while not still distributing. This is useful for reducing packet loss wh=
en
> >a port begins distributing before its partner is able to collect.
> >
> >Added new functions such as bond_set_slave_tx_disabled_flags and
> >bond_set_slave_rx_enabled_flags to precisely manage the port's collectin=
g
> >and distributing states. Previously, there was no dedicated method to
> >disable TX while keeping RX enabled, which this patch addresses.
> >
> >Note that the regular flow process in the kernel's bonding driver remain=
s
> >unaffected by this patch. The extension requires explicit opt-in by the
> >user (in order to ensure no disruptions for existing setups) via netlink
> >support using the new bonding parameter coupled_control. The default val=
ue
> >for coupled_control is set to 1 so as to preserve existing behaviour.
>
>         Do you have a corresponding iproute2 patch to enable changing
> the coupled_control option?
>
>         -J
>
> >Signed-off-by: Aahil Awatramani <aahila@google.com>
> >
> >v5:
> >  Merge documentation patch with changes patch
> >  Add version history in comment description
> >v4:
> >  Remove inline references from c source files
> >v3:
> >  Edited commit description
> >  Edited documentation description
> >  Changed function names
> >  Only allow coupled_control change when the bond is down
> >v2:
> >  Removed sysfs changes
> >  Added documentation for new paramater
> >  Renamed parameter to coupled_control
> >  Update bond_set_slave_inactive_flags() with a 8023ad check
> >
> >---
> > Documentation/networking/bonding.rst |  12 ++
> > drivers/net/bonding/bond_3ad.c       | 157 +++++++++++++++++++++++++--
> > drivers/net/bonding/bond_main.c      |   1 +
> > drivers/net/bonding/bond_netlink.c   |  16 +++
> > drivers/net/bonding/bond_options.c   |  28 ++++-
> > include/net/bond_3ad.h               |   2 +
> > include/net/bond_options.h           |   1 +
> > include/net/bonding.h                |  23 ++++
> > include/uapi/linux/if_link.h         |   1 +
> > tools/include/uapi/linux/if_link.h   |   1 +
> > 10 files changed, 234 insertions(+), 8 deletions(-)
> >
> >diff --git a/Documentation/networking/bonding.rst b/Documentation/networ=
king/bonding.rst
> >index f7a73421eb76..e774b48de9f5 100644
> >--- a/Documentation/networking/bonding.rst
> >+++ b/Documentation/networking/bonding.rst
> >@@ -444,6 +444,18 @@ arp_missed_max
> >
> >       The default value is 2, and the allowable range is 1 - 255.
> >
> >+coupled_control
> >+
> >+    Specifies whether the LACP state machine's MUX in the 802.3ad mode
> >+    should have separate Collecting and Distributing states.
> >+
> >+    This is by implementing the independent control state machine per
> >+    IEEE 802.1AX-2008 5.4.15 in addition to the existing coupled contro=
l
> >+    state machine.
> >+
> >+    The default value is 1. This setting does not separate the Collecti=
ng
> >+    and Distributing states, maintaining the bond in coupled control.
> >+
> > downdelay
> >
> >       Specifies the time, in milliseconds, to wait before disabling
> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3=
ad.c
> >index c99ffe6c683a..f2942e8c6c91 100644
> >--- a/drivers/net/bonding/bond_3ad.c
> >+++ b/drivers/net/bonding/bond_3ad.c
> >@@ -106,6 +106,9 @@ static void ad_agg_selection_logic(struct aggregator=
 *aggregator,
> > static void ad_clear_agg(struct aggregator *aggregator);
> > static void ad_initialize_agg(struct aggregator *aggregator);
> > static void ad_initialize_port(struct port *port, int lacp_fast);
> >+static void ad_enable_collecting(struct port *port);
> >+static void ad_disable_distributing(struct port *port,
> >+                                  bool *update_slave_arr);
> > static void ad_enable_collecting_distributing(struct port *port,
> >                                             bool *update_slave_arr);
> > static void ad_disable_collecting_distributing(struct port *port,
> >@@ -171,9 +174,38 @@ static inline int __agg_has_partner(struct aggregat=
or *agg)
> >       return !is_zero_ether_addr(agg->partner_system.mac_addr_value);
> > }
> >
> >+/**
> >+ * __disable_distributing_port - disable the port's slave for distribut=
ing.
> >+ * Port will still be able to collect.
> >+ * @port: the port we're looking at
> >+ *
> >+ * This will disable only distributing on the port's slave.
> >+ */
> >+static void __disable_distributing_port(struct port *port)
> >+{
> >+      bond_set_slave_tx_disabled_flags(port->slave, BOND_SLAVE_NOTIFY_L=
ATER);
> >+}
> >+
> >+/**
> >+ * __enable_collecting_port - enable the port's slave for collecting,
> >+ * if it's up
> >+ * @port: the port we're looking at
> >+ *
> >+ * This will enable only collecting on the port's slave.
> >+ */
> >+static void __enable_collecting_port(struct port *port)
> >+{
> >+      struct slave *slave =3D port->slave;
> >+
> >+      if (slave->link =3D=3D BOND_LINK_UP && bond_slave_is_up(slave))
> >+              bond_set_slave_rx_enabled_flags(slave, BOND_SLAVE_NOTIFY_=
LATER);
> >+}
> >+
> > /**
> >  * __disable_port - disable the port's slave
> >  * @port: the port we're looking at
> >+ *
> >+ * This will disable both collecting and distributing on the port's sla=
ve.
> >  */
> > static inline void __disable_port(struct port *port)
> > {
> >@@ -183,6 +215,8 @@ static inline void __disable_port(struct port *port)
> > /**
> >  * __enable_port - enable the port's slave, if it's up
> >  * @port: the port we're looking at
> >+ *
> >+ * This will enable both collecting and distributing on the port's slav=
e.
> >  */
> > static inline void __enable_port(struct port *port)
> > {
> >@@ -193,10 +227,27 @@ static inline void __enable_port(struct port *port=
)
> > }
> >
> > /**
> >- * __port_is_enabled - check if the port's slave is in active state
> >+ * __port_move_to_attached_state - check if port should transition back=
 to attached
> >+ * state.
> >+ * @port: the port we're looking at
> >+ */
> >+static bool __port_move_to_attached_state(struct port *port)
> >+{
> >+      if (!(port->sm_vars & AD_PORT_SELECTED) ||
> >+          (port->sm_vars & AD_PORT_STANDBY) ||
> >+          !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION)=
 ||
> >+          !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION))
> >+              port->sm_mux_state =3D AD_MUX_ATTACHED;
> >+
> >+      return port->sm_mux_state =3D=3D AD_MUX_ATTACHED;
> >+}
> >+
> >+/**
> >+ * __port_is_collecting_distributing - check if the port's slave is in =
the
> >+ * combined collecting/distributing state
> >  * @port: the port we're looking at
> >  */
> >-static inline int __port_is_enabled(struct port *port)
> >+static int __port_is_collecting_distributing(struct port *port)
> > {
> >       return bond_is_active_slave(port->slave);
> > }
> >@@ -942,6 +993,7 @@ static int ad_marker_send(struct port *port, struct =
bond_marker *marker)
> >  */
> > static void ad_mux_machine(struct port *port, bool *update_slave_arr)
> > {
> >+      struct bonding *bond =3D __get_bond_by_port(port);
> >       mux_states_t last_state;
> >
> >       /* keep current State Machine state to compare later if it was
> >@@ -999,9 +1051,13 @@ static void ad_mux_machine(struct port *port, bool=
 *update_slave_arr)
> >                       if ((port->sm_vars & AD_PORT_SELECTED) &&
> >                           (port->partner_oper.port_state & LACP_STATE_S=
YNCHRONIZATION) &&
> >                           !__check_agg_selection_timer(port)) {
> >-                              if (port->aggregator->is_active)
> >-                                      port->sm_mux_state =3D
> >-                                          AD_MUX_COLLECTING_DISTRIBUTIN=
G;
> >+                              if (port->aggregator->is_active) {
> >+                                      int state =3D AD_MUX_COLLECTING_D=
ISTRIBUTING;
> >+
> >+                                      if (!bond->params.coupled_control=
)
> >+                                              state =3D AD_MUX_COLLECTI=
NG;
> >+                                      port->sm_mux_state =3D state;
> >+                              }
> >                       } else if (!(port->sm_vars & AD_PORT_SELECTED) ||
> >                                  (port->sm_vars & AD_PORT_STANDBY)) {
> >                               /* if UNSELECTED or STANDBY */
> >@@ -1019,11 +1075,45 @@ static void ad_mux_machine(struct port *port, bo=
ol *update_slave_arr)
> >                       }
> >                       break;
> >               case AD_MUX_COLLECTING_DISTRIBUTING:
> >+                      if (!__port_move_to_attached_state(port)) {
> >+                              /* if port state hasn't changed make
> >+                               * sure that a collecting distributing
> >+                               * port in an active aggregator is enable=
d
> >+                               */
> >+                              if (port->aggregator->is_active &&
> >+                                  !__port_is_collecting_distributing(po=
rt)) {
> >+                                      __enable_port(port);
> >+                                      *update_slave_arr =3D true;
> >+                              }
> >+                      }
> >+                      break;
> >+              case AD_MUX_COLLECTING:
> >+                      if (!__port_move_to_attached_state(port)) {
> >+                              if ((port->sm_vars & AD_PORT_SELECTED) &&
> >+                                  (port->partner_oper.port_state & LACP=
_STATE_SYNCHRONIZATION) &&
> >+                                  (port->partner_oper.port_state & LACP=
_STATE_COLLECTING)) {
> >+                                      port->sm_mux_state =3D AD_MUX_DIS=
TRIBUTING;
> >+                              } else {
> >+                                      /* If port state hasn't changed, =
make sure that a collecting
> >+                                       * port is enabled for an active =
aggregator.
> >+                                       */
> >+                                      struct slave *slave =3D port->sla=
ve;
> >+
> >+                                      if (port->aggregator->is_active &=
&
> >+                                          bond_is_slave_rx_disabled(sla=
ve)) {
> >+                                              ad_enable_collecting(port=
);
> >+                                              *update_slave_arr =3D tru=
e;
> >+                                      }
> >+                              }
> >+                      }
> >+                      break;
> >+              case AD_MUX_DISTRIBUTING:
> >                       if (!(port->sm_vars & AD_PORT_SELECTED) ||
> >                           (port->sm_vars & AD_PORT_STANDBY) ||
> >+                          !(port->partner_oper.port_state & LACP_STATE_=
COLLECTING) ||
> >                           !(port->partner_oper.port_state & LACP_STATE_=
SYNCHRONIZATION) ||
> >                           !(port->actor_oper_port_state & LACP_STATE_SY=
NCHRONIZATION)) {
> >-                              port->sm_mux_state =3D AD_MUX_ATTACHED;
> >+                              port->sm_mux_state =3D AD_MUX_COLLECTING;
> >                       } else {
> >                               /* if port state hasn't changed make
> >                                * sure that a collecting distributing
> >@@ -1031,7 +1121,7 @@ static void ad_mux_machine(struct port *port, bool=
 *update_slave_arr)
> >                                */
> >                               if (port->aggregator &&
> >                                   port->aggregator->is_active &&
> >-                                  !__port_is_enabled(port)) {
> >+                                  !__port_is_collecting_distributing(po=
rt)) {
> >                                       __enable_port(port);
> >                                       *update_slave_arr =3D true;
> >                               }
> >@@ -1082,6 +1172,20 @@ static void ad_mux_machine(struct port *port, boo=
l *update_slave_arr)
> >                                                         update_slave_ar=
r);
> >                       port->ntt =3D true;
> >                       break;
> >+              case AD_MUX_COLLECTING:
> >+                      port->actor_oper_port_state |=3D LACP_STATE_COLLE=
CTING;
> >+                      port->actor_oper_port_state &=3D ~LACP_STATE_DIST=
RIBUTING;
> >+                      port->actor_oper_port_state |=3D LACP_STATE_SYNCH=
RONIZATION;
> >+                      ad_enable_collecting(port);
> >+                      ad_disable_distributing(port, update_slave_arr);
> >+                      port->ntt =3D true;
> >+                      break;
> >+              case AD_MUX_DISTRIBUTING:
> >+                      port->actor_oper_port_state |=3D LACP_STATE_DISTR=
IBUTING;
> >+                      port->actor_oper_port_state |=3D LACP_STATE_SYNCH=
RONIZATION;
> >+                      ad_enable_collecting_distributing(port,
> >+                                                        update_slave_ar=
r);
> >+                      break;
> >               default:
> >                       break;
> >               }
> >@@ -1906,6 +2010,45 @@ static void ad_initialize_port(struct port *port,=
 int lacp_fast)
> >       }
> > }
> >
> >+/**
> >+ * ad_enable_collecting - enable a port's receive
> >+ * @port: the port we're looking at
> >+ *
> >+ * Enable @port if it's in an active aggregator
> >+ */
> >+static void ad_enable_collecting(struct port *port)
> >+{
> >+      if (port->aggregator->is_active) {
> >+              struct slave *slave =3D port->slave;
> >+
> >+              slave_dbg(slave->bond->dev, slave->dev,
> >+                        "Enabling collecting on port %d (LAG %d)\n",
> >+                        port->actor_port_number,
> >+                        port->aggregator->aggregator_identifier);
> >+              __enable_collecting_port(port);
> >+      }
> >+}
> >+
> >+/**
> >+ * ad_disable_distributing - disable a port's transmit
> >+ * @port: the port we're looking at
> >+ * @update_slave_arr: Does slave array need update?
> >+ */
> >+static void ad_disable_distributing(struct port *port, bool *update_sla=
ve_arr)
> >+{
> >+      if (port->aggregator &&
> >+          !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,
> >+                             &(null_mac_addr))) {
> >+              slave_dbg(port->slave->bond->dev, port->slave->dev,
> >+                        "Disabling distributing on port %d (LAG %d)\n",
> >+                        port->actor_port_number,
> >+                        port->aggregator->aggregator_identifier);
> >+              __disable_distributing_port(port);
> >+              /* Slave array needs an update */
> >+              *update_slave_arr =3D true;
> >+      }
> >+}
> >+
> > /**
> >  * ad_enable_collecting_distributing - enable a port's transmit/receive
> >  * @port: the port we're looking at
> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_=
main.c
> >index 8e6cc0e133b7..30f4b0ff01c0 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> >@@ -6331,6 +6331,7 @@ static int __init bond_check_params(struct bond_pa=
rams *params)
> >       params->ad_actor_sys_prio =3D ad_actor_sys_prio;
> >       eth_zero_addr(params->ad_actor_system);
> >       params->ad_user_port_key =3D ad_user_port_key;
> >+      params->coupled_control =3D 1;
> >       if (packets_per_slave > 0) {
> >               params->reciprocal_packets_per_slave =3D
> >                       reciprocal_value(packets_per_slave);
> >diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bo=
nd_netlink.c
> >index cfa74cf8bb1a..29b4c3d1b9b6 100644
> >--- a/drivers/net/bonding/bond_netlink.c
> >+++ b/drivers/net/bonding/bond_netlink.c
> >@@ -122,6 +122,7 @@ static const struct nla_policy bond_policy[IFLA_BOND=
_MAX + 1] =3D {
> >       [IFLA_BOND_PEER_NOTIF_DELAY]    =3D NLA_POLICY_FULL_RANGE(NLA_U32=
, &delay_range),
> >       [IFLA_BOND_MISSED_MAX]          =3D { .type =3D NLA_U8 },
> >       [IFLA_BOND_NS_IP6_TARGET]       =3D { .type =3D NLA_NESTED },
> >+      [IFLA_BOND_COUPLED_CONTROL]     =3D { .type =3D NLA_U8 },
> > };
> >
> > static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + =
1] =3D {
> >@@ -549,6 +550,16 @@ static int bond_changelink(struct net_device *bond_=
dev, struct nlattr *tb[],
> >                       return err;
> >       }
> >
> >+      if (data[IFLA_BOND_COUPLED_CONTROL]) {
> >+              int coupled_control =3D nla_get_u8(data[IFLA_BOND_COUPLED=
_CONTROL]);
> >+
> >+              bond_opt_initval(&newval, coupled_control);
> >+              err =3D __bond_opt_set(bond, BOND_OPT_COUPLED_CONTROL, &n=
ewval,
> >+                                   data[IFLA_BOND_COUPLED_CONTROL], ext=
ack);
> >+              if (err)
> >+                      return err;
> >+      }
> >+
> >       return 0;
> > }
> >
> >@@ -615,6 +626,7 @@ static size_t bond_get_size(const struct net_device =
*bond_dev)
> >                                               /* IFLA_BOND_NS_IP6_TARGE=
T */
> >               nla_total_size(sizeof(struct nlattr)) +
> >               nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_TAR=
GETS +
> >+              nla_total_size(sizeof(u8)) +    /* IFLA_BOND_COUPLED_CONT=
ROL */
> >               0;
> > }
> >
> >@@ -774,6 +786,10 @@ static int bond_fill_info(struct sk_buff *skb,
> >                      bond->params.missed_max))
> >               goto nla_put_failure;
> >
> >+      if (nla_put_u8(skb, IFLA_BOND_COUPLED_CONTROL,
> >+                     bond->params.coupled_control))
> >+              goto nla_put_failure;
> >+
> >       if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
> >               struct ad_info info;
> >
> >diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bo=
nd_options.c
> >index f3f27f0bd2a6..4cdbc7e084f4 100644
> >--- a/drivers/net/bonding/bond_options.c
> >+++ b/drivers/net/bonding/bond_options.c
> >@@ -84,7 +84,8 @@ static int bond_option_ad_user_port_key_set(struct bon=
ding *bond,
> >                                           const struct bond_opt_value *=
newval);
> > static int bond_option_missed_max_set(struct bonding *bond,
> >                                     const struct bond_opt_value *newval=
);
> >-
> >+static int bond_option_coupled_control_set(struct bonding *bond,
> >+                                         const struct bond_opt_value *n=
ewval);
> >
> > static const struct bond_opt_value bond_mode_tbl[] =3D {
> >       { "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
> >@@ -232,6 +233,12 @@ static const struct bond_opt_value bond_missed_max_=
tbl[] =3D {
> >       { NULL,         -1,     0},
> > };
> >
> >+static const struct bond_opt_value bond_coupled_control_tbl[] =3D {
> >+      { "on",  1,  BOND_VALFLAG_DEFAULT},
> >+      { "off", 0,  0},
> >+      { NULL,  -1, 0},
> >+};
> >+
> > static const struct bond_option bond_opts[BOND_OPT_LAST] =3D {
> >       [BOND_OPT_MODE] =3D {
> >               .id =3D BOND_OPT_MODE,
> >@@ -496,6 +503,15 @@ static const struct bond_option bond_opts[BOND_OPT_=
LAST] =3D {
> >               .desc =3D "Delay between each peer notification on failov=
er event, in milliseconds",
> >               .values =3D bond_peer_notif_delay_tbl,
> >               .set =3D bond_option_peer_notif_delay_set
> >+      },
> >+      [BOND_OPT_COUPLED_CONTROL] =3D {
> >+              .id =3D BOND_OPT_COUPLED_CONTROL,
> >+              .name =3D "coupled_control",
> >+              .desc =3D "Opt into using coupled control MUX for LACP st=
ates",
> >+              .unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
> >+              .flags =3D BOND_OPTFLAG_IFDOWN,
> >+              .values =3D bond_coupled_control_tbl,
> >+              .set =3D bond_option_coupled_control_set,
> >       }
> > };
> >
> >@@ -1692,3 +1708,13 @@ static int bond_option_ad_user_port_key_set(struc=
t bonding *bond,
> >       bond->params.ad_user_port_key =3D newval->value;
> >       return 0;
> > }
> >+
> >+static int bond_option_coupled_control_set(struct bonding *bond,
> >+                                         const struct bond_opt_value *n=
ewval)
> >+{
> >+      netdev_info(bond->dev, "Setting coupled_control to %s (%llu)\n",
> >+                  newval->string, newval->value);
> >+
> >+      bond->params.coupled_control =3D newval->value;
> >+      return 0;
> >+}
> >diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> >index c5e57c6bd873..9ce5ac2bfbad 100644
> >--- a/include/net/bond_3ad.h
> >+++ b/include/net/bond_3ad.h
> >@@ -54,6 +54,8 @@ typedef enum {
> >       AD_MUX_DETACHED,        /* mux machine */
> >       AD_MUX_WAITING,         /* mux machine */
> >       AD_MUX_ATTACHED,        /* mux machine */
> >+      AD_MUX_COLLECTING,      /* mux machine */
> >+      AD_MUX_DISTRIBUTING,    /* mux machine */
> >       AD_MUX_COLLECTING_DISTRIBUTING  /* mux machine */
> > } mux_states_t;
> >
> >diff --git a/include/net/bond_options.h b/include/net/bond_options.h
> >index 69292ecc0325..473a0147769e 100644
> >--- a/include/net/bond_options.h
> >+++ b/include/net/bond_options.h
> >@@ -76,6 +76,7 @@ enum {
> >       BOND_OPT_MISSED_MAX,
> >       BOND_OPT_NS_TARGETS,
> >       BOND_OPT_PRIO,
> >+      BOND_OPT_COUPLED_CONTROL,
> >       BOND_OPT_LAST
> > };
> >
> >diff --git a/include/net/bonding.h b/include/net/bonding.h
> >index 5b8b1b644a2d..b61fb1aa3a56 100644
> >--- a/include/net/bonding.h
> >+++ b/include/net/bonding.h
> >@@ -148,6 +148,7 @@ struct bond_params {
> > #if IS_ENABLED(CONFIG_IPV6)
> >       struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
> > #endif
> >+      int coupled_control;
> >
> >       /* 2 bytes of padding : see ether_addr_equal_64bits() */
> >       u8 ad_actor_system[ETH_ALEN + 2];
> >@@ -167,6 +168,7 @@ struct slave {
> >       u8     backup:1,   /* indicates backup slave. Value corresponds w=
ith
> >                             BOND_STATE_ACTIVE and BOND_STATE_BACKUP */
> >              inactive:1, /* indicates inactive slave */
> >+             rx_disabled:1, /* indicates whether slave's Rx is disabled=
 */
> >              should_notify:1, /* indicates whether the state changed */
> >              should_notify_link:1; /* indicates whether the link change=
d */
> >       u8     duplex;
> >@@ -568,6 +570,14 @@ static inline void bond_set_slave_inactive_flags(st=
ruct slave *slave,
> >               bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
> >       if (!slave->bond->params.all_slaves_active)
> >               slave->inactive =3D 1;
> >+      if (BOND_MODE(slave->bond) =3D=3D BOND_MODE_8023AD)
> >+              slave->rx_disabled =3D 1;
> >+}
> >+
> >+static inline void bond_set_slave_tx_disabled_flags(struct slave *slave=
,
> >+                                               bool notify)
> >+{
> >+      bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
> > }
> >
> > static inline void bond_set_slave_active_flags(struct slave *slave,
> >@@ -575,6 +585,14 @@ static inline void bond_set_slave_active_flags(stru=
ct slave *slave,
> > {
> >       bond_set_slave_state(slave, BOND_STATE_ACTIVE, notify);
> >       slave->inactive =3D 0;
> >+      if (BOND_MODE(slave->bond) =3D=3D BOND_MODE_8023AD)
> >+              slave->rx_disabled =3D 0;
> >+}
> >+
> >+static inline void bond_set_slave_rx_enabled_flags(struct slave *slave,
> >+                                             bool notify)
> >+{
> >+      slave->rx_disabled =3D 0;
> > }
> >
> > static inline bool bond_is_slave_inactive(struct slave *slave)
> >@@ -582,6 +600,11 @@ static inline bool bond_is_slave_inactive(struct sl=
ave *slave)
> >       return slave->inactive;
> > }
> >
> >+static inline bool bond_is_slave_rx_disabled(struct slave *slave)
> >+{
> >+      return slave->rx_disabled;
> >+}
> >+
> > static inline void bond_propose_link_state(struct slave *slave, int sta=
te)
> > {
> >       slave->link_new_state =3D state;
> >diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> >index 29ff80da2775..7a54fcff2eec 100644
> >--- a/include/uapi/linux/if_link.h
> >+++ b/include/uapi/linux/if_link.h
> >@@ -976,6 +976,7 @@ enum {
> >       IFLA_BOND_AD_LACP_ACTIVE,
> >       IFLA_BOND_MISSED_MAX,
> >       IFLA_BOND_NS_IP6_TARGET,
> >+      IFLA_BOND_COUPLED_CONTROL,
> >       __IFLA_BOND_MAX,
> > };
> >
> >diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/lin=
ux/if_link.h
> >index a0aa05a28cf2..f0d71b2a3f1e 100644
> >--- a/tools/include/uapi/linux/if_link.h
> >+++ b/tools/include/uapi/linux/if_link.h
> >@@ -974,6 +974,7 @@ enum {
> >       IFLA_BOND_AD_LACP_ACTIVE,
> >       IFLA_BOND_MISSED_MAX,
> >       IFLA_BOND_NS_IP6_TARGET,
> >+      IFLA_BOND_COUPLED_CONTROL,
> >       __IFLA_BOND_MAX,
> > };
> >
> >--
> >2.43.0.429.g432eaa2c6b-goog
> >
> >

