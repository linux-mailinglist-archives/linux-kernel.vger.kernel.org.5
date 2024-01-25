Return-Path: <linux-kernel+bounces-37827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9EA83B622
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F12A1F22CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CDC17CE;
	Thu, 25 Jan 2024 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xiYHdRFY"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67DE193
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706143146; cv=none; b=Ii2eIdOwuE00e1/QLl5L9ww3s5CgwZ1KIlRgaZVsOnpfGBREKjX7NTp2oAJgMqq9BVhA/tXFmFB439cDO8EWdYvv35l4mZ/d8rRU0o2JkUwN9c68HHdllP5Q6vNuvCvYxZvUgjYwUeiVGqibKnjVPx6kCxB9u0eZTJmANyvqeFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706143146; c=relaxed/simple;
	bh=C4R+JBwCm8dOyrO3GPSZ78gsgcQgtXLxC1fmPUmqVXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4ZiKO/e4ragpimWSyWyjdzHkCgH1ASOjHK+GPh7CHWFiIedvd2DBKFz4JYfcQhIEfQMuw83JpIoqrDsdIT20JiW6Pe1B6LL+n2Drl8i3nlC/WqJFCvrM2lzaJimcEXlB6aLXSg+snZO1jg2u7OXVNwDVBPeifkpIENHTmmRN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xiYHdRFY; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60036bfdbfeso28250907b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706143143; x=1706747943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM+/EW1tvI/cJKvx9Xvw7jwGwaR4XOJ0Ec4GFxAPe/0=;
        b=xiYHdRFYQ6TDgUe0bztIZ7Mf+zqkhfQ9VuY5G5WCHh3oFXoCA2Q7DLgscoD1QCS7DI
         bwt1BTbxRdknzxmbcrH9TiGC4c9I0ABXcP2/03M+iBIFMiPlZoF7G5+/93bM8NEjzyGn
         H28xFN0hE4cnAtJPTsTdwlkjOL9EVZQIzzu4mFBQot/Bri7yl6dLBa9N/JF/b9rba8BD
         MrcpNjGbxUN/bapOe++tIt7fEYVYjk2NUMT7bJh093n69rxZmXoMq9O61dsheYwp9PaY
         EzD676qBfvq/hDyDehvxrcn4JBHEB9IsUe0uLr2CmBkGd/esmBikV7JebmG58UrLoLX0
         +RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706143143; x=1706747943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gM+/EW1tvI/cJKvx9Xvw7jwGwaR4XOJ0Ec4GFxAPe/0=;
        b=Y6ME1zpOYuHyLRXBm38L+B7VHXpXw58GMn6diPGAKyghE4eE7q0ETiSysWpJEdrqIx
         /89nf59IZmjdYQ/gseAtfBZ6YZMA5XCVY0WHkjnJrBcAEbW+FsEWZgc11dBW3gbmJFf5
         /9J41UwdAaGVB46KyohPHctdRr1RaxHf9RPSGK/ZDoZyUXYE/3kInqU9vUTQ30m6wOh+
         RPtW3mgp74Xs+CfM8rE/G5QpQA3FCqq6yvm4njOb+tkYUw3v3lCvu/n3qj1oeetLq9MC
         VD7ihsYd9QKR19HfCVbJm9cP9rSdk/G8D7XTXLveSrNp9C6usR6igKMVVAg3ytQM8oFO
         wWeA==
X-Gm-Message-State: AOJu0Yz9JkLjxgG2Fp0C+zBhnyVKVTDXDO7DeuyCRtYaLU/QJZfirXhE
	qRep0lFb5rig5t9mVWJ6hxJ8EWYlgK7J+nemcEuECIo1CxJiF+2jpwrESvQeUJI4ak7yayfYp7O
	6wzsMm1k/2wfb2+GY/tXuRsX9LaQbq0kiCIsC
X-Google-Smtp-Source: AGHT+IH6XIoWzgSXXj3oIBMBwL9MYZ9wvTsfQto95obbDMzJxafAPrDDiHgIDmuCRVKinDnDLOPxSjsZcpn6OwKbt/8=
X-Received: by 2002:a05:690c:f89:b0:602:9c74:2285 with SMTP id
 df9-20020a05690c0f8900b006029c742285mr15980ywb.29.1706143142746; Wed, 24 Jan
 2024 16:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123235130.1982654-1-aahila@google.com> <4577.1706076998@famine>
 <CAGfWUPwsh3xFK6JvT9p07eXD2j1V=B=kVNfPOWJj6L4SXyeyDA@mail.gmail.com> <7770.1706120209@famine>
In-Reply-To: <7770.1706120209@famine>
From: Aahil Awatramani <aahila@google.com>
Date: Wed, 24 Jan 2024 16:38:51 -0800
Message-ID: <CAGfWUPzBP_jNxrHeTmmKw0LCCJxuV9MELoKUGCwP648gGE0PQA@mail.gmail.com>
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

>         Could you post it now?  They're logically parts of a single
> feature, so should go together.  As a practical matter, though, it's
> easier to test this patch with the iproute patch available.

Sure, I have uploaded the patch for review, and also cc'd you on the email.
I also realised that I haven't appended coupled_control to procfs.
Will add that change in v6.

On Wed, Jan 24, 2024 at 10:16=E2=80=AFAM Jay Vosburgh
<jay.vosburgh@canonical.com> wrote:
>
> Aahil Awatramani <aahila@google.com> wrote:
>
> >>         Do you have a corresponding iproute2 patch to enable changing
> >> the coupled_control option?
> >
> >I do have the corresponding patch for iproute2 to enable changing
> >coupled_control, I planned to push that patch for review directly
> >after this one.
>
>         Could you post it now?  They're logically parts of a single
> feature, so should go together.  As a practical matter, though, it's
> easier to test this patch with the iproute patch available.
>
>         -J
>
> >
> >On Tue, Jan 23, 2024 at 10:16=E2=80=AFPM Jay Vosburgh
> ><jay.vosburgh@canonical.com> wrote:
> >>
> >> Aahil Awatramani <aahila@google.com> wrote:
> >>
> >> >Add support for the independent control state machine per IEEE
> >> >802.1AX-2008 5.4.15 in addition to the existing implementation of the
> >> >coupled control state machine.
> >> >
> >> >Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING =
in
> >> >the LACP MUX state machine for separated handling of an initial
> >> >Collecting state before the Collecting and Distributing state. This
> >> >enables a port to be in a state where it can receive incoming packets
> >> >while not still distributing. This is useful for reducing packet loss=
 when
> >> >a port begins distributing before its partner is able to collect.
> >> >
> >> >Added new functions such as bond_set_slave_tx_disabled_flags and
> >> >bond_set_slave_rx_enabled_flags to precisely manage the port's collec=
ting
> >> >and distributing states. Previously, there was no dedicated method to
> >> >disable TX while keeping RX enabled, which this patch addresses.
> >> >
> >> >Note that the regular flow process in the kernel's bonding driver rem=
ains
> >> >unaffected by this patch. The extension requires explicit opt-in by t=
he
> >> >user (in order to ensure no disruptions for existing setups) via netl=
ink
> >> >support using the new bonding parameter coupled_control. The default =
value
> >> >for coupled_control is set to 1 so as to preserve existing behaviour.
> >>
> >>         Do you have a corresponding iproute2 patch to enable changing
> >> the coupled_control option?
> >>
> >>         -J
> >>
> >> >Signed-off-by: Aahil Awatramani <aahila@google.com>
> >> >
> >> >v5:
> >> >  Merge documentation patch with changes patch
> >> >  Add version history in comment description
> >> >v4:
> >> >  Remove inline references from c source files
> >> >v3:
> >> >  Edited commit description
> >> >  Edited documentation description
> >> >  Changed function names
> >> >  Only allow coupled_control change when the bond is down
> >> >v2:
> >> >  Removed sysfs changes
> >> >  Added documentation for new paramater
> >> >  Renamed parameter to coupled_control
> >> >  Update bond_set_slave_inactive_flags() with a 8023ad check
> >> >
> >> >---
> >> > Documentation/networking/bonding.rst |  12 ++
> >> > drivers/net/bonding/bond_3ad.c       | 157 +++++++++++++++++++++++++=
--
> >> > drivers/net/bonding/bond_main.c      |   1 +
> >> > drivers/net/bonding/bond_netlink.c   |  16 +++
> >> > drivers/net/bonding/bond_options.c   |  28 ++++-
> >> > include/net/bond_3ad.h               |   2 +
> >> > include/net/bond_options.h           |   1 +
> >> > include/net/bonding.h                |  23 ++++
> >> > include/uapi/linux/if_link.h         |   1 +
> >> > tools/include/uapi/linux/if_link.h   |   1 +
> >> > 10 files changed, 234 insertions(+), 8 deletions(-)
> >> >
> >> >diff --git a/Documentation/networking/bonding.rst b/Documentation/net=
working/bonding.rst
> >> >index f7a73421eb76..e774b48de9f5 100644
> >> >--- a/Documentation/networking/bonding.rst
> >> >+++ b/Documentation/networking/bonding.rst
> >> >@@ -444,6 +444,18 @@ arp_missed_max
> >> >
> >> >       The default value is 2, and the allowable range is 1 - 255.
> >> >
> >> >+coupled_control
> >> >+
> >> >+    Specifies whether the LACP state machine's MUX in the 802.3ad mo=
de
> >> >+    should have separate Collecting and Distributing states.
> >> >+
> >> >+    This is by implementing the independent control state machine pe=
r
> >> >+    IEEE 802.1AX-2008 5.4.15 in addition to the existing coupled con=
trol
> >> >+    state machine.
> >> >+
> >> >+    The default value is 1. This setting does not separate the Colle=
cting
> >> >+    and Distributing states, maintaining the bond in coupled control=
.
> >> >+
> >> > downdelay
> >> >
> >> >       Specifies the time, in milliseconds, to wait before disabling
> >> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bon=
d_3ad.c
> >> >index c99ffe6c683a..f2942e8c6c91 100644
> >> >--- a/drivers/net/bonding/bond_3ad.c
> >> >+++ b/drivers/net/bonding/bond_3ad.c
> >> >@@ -106,6 +106,9 @@ static void ad_agg_selection_logic(struct aggrega=
tor *aggregator,
> >> > static void ad_clear_agg(struct aggregator *aggregator);
> >> > static void ad_initialize_agg(struct aggregator *aggregator);
> >> > static void ad_initialize_port(struct port *port, int lacp_fast);
> >> >+static void ad_enable_collecting(struct port *port);
> >> >+static void ad_disable_distributing(struct port *port,
> >> >+                                  bool *update_slave_arr);
> >> > static void ad_enable_collecting_distributing(struct port *port,
> >> >                                             bool *update_slave_arr);
> >> > static void ad_disable_collecting_distributing(struct port *port,
> >> >@@ -171,9 +174,38 @@ static inline int __agg_has_partner(struct aggre=
gator *agg)
> >> >       return !is_zero_ether_addr(agg->partner_system.mac_addr_value)=
;
> >> > }
> >> >
> >> >+/**
> >> >+ * __disable_distributing_port - disable the port's slave for distri=
buting.
> >> >+ * Port will still be able to collect.
> >> >+ * @port: the port we're looking at
> >> >+ *
> >> >+ * This will disable only distributing on the port's slave.
> >> >+ */
> >> >+static void __disable_distributing_port(struct port *port)
> >> >+{
> >> >+      bond_set_slave_tx_disabled_flags(port->slave, BOND_SLAVE_NOTIF=
Y_LATER);
> >> >+}
> >> >+
> >> >+/**
> >> >+ * __enable_collecting_port - enable the port's slave for collecting=
,
> >> >+ * if it's up
> >> >+ * @port: the port we're looking at
> >> >+ *
> >> >+ * This will enable only collecting on the port's slave.
> >> >+ */
> >> >+static void __enable_collecting_port(struct port *port)
> >> >+{
> >> >+      struct slave *slave =3D port->slave;
> >> >+
> >> >+      if (slave->link =3D=3D BOND_LINK_UP && bond_slave_is_up(slave)=
)
> >> >+              bond_set_slave_rx_enabled_flags(slave, BOND_SLAVE_NOTI=
FY_LATER);
> >> >+}
> >> >+
> >> > /**
> >> >  * __disable_port - disable the port's slave
> >> >  * @port: the port we're looking at
> >> >+ *
> >> >+ * This will disable both collecting and distributing on the port's =
slave.
> >> >  */
> >> > static inline void __disable_port(struct port *port)
> >> > {
> >> >@@ -183,6 +215,8 @@ static inline void __disable_port(struct port *po=
rt)
> >> > /**
> >> >  * __enable_port - enable the port's slave, if it's up
> >> >  * @port: the port we're looking at
> >> >+ *
> >> >+ * This will enable both collecting and distributing on the port's s=
lave.
> >> >  */
> >> > static inline void __enable_port(struct port *port)
> >> > {
> >> >@@ -193,10 +227,27 @@ static inline void __enable_port(struct port *p=
ort)
> >> > }
> >> >
> >> > /**
> >> >- * __port_is_enabled - check if the port's slave is in active state
> >> >+ * __port_move_to_attached_state - check if port should transition b=
ack to attached
> >> >+ * state.
> >> >+ * @port: the port we're looking at
> >> >+ */
> >> >+static bool __port_move_to_attached_state(struct port *port)
> >> >+{
> >> >+      if (!(port->sm_vars & AD_PORT_SELECTED) ||
> >> >+          (port->sm_vars & AD_PORT_STANDBY) ||
> >> >+          !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATI=
ON) ||
> >> >+          !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION=
))
> >> >+              port->sm_mux_state =3D AD_MUX_ATTACHED;
> >> >+
> >> >+      return port->sm_mux_state =3D=3D AD_MUX_ATTACHED;
> >> >+}
> >> >+
> >> >+/**
> >> >+ * __port_is_collecting_distributing - check if the port's slave is =
in the
> >> >+ * combined collecting/distributing state
> >> >  * @port: the port we're looking at
> >> >  */
> >> >-static inline int __port_is_enabled(struct port *port)
> >> >+static int __port_is_collecting_distributing(struct port *port)
> >> > {
> >> >       return bond_is_active_slave(port->slave);
> >> > }
> >> >@@ -942,6 +993,7 @@ static int ad_marker_send(struct port *port, stru=
ct bond_marker *marker)
> >> >  */
> >> > static void ad_mux_machine(struct port *port, bool *update_slave_arr=
)
> >> > {
> >> >+      struct bonding *bond =3D __get_bond_by_port(port);
> >> >       mux_states_t last_state;
> >> >
> >> >       /* keep current State Machine state to compare later if it was
> >> >@@ -999,9 +1051,13 @@ static void ad_mux_machine(struct port *port, b=
ool *update_slave_arr)
> >> >                       if ((port->sm_vars & AD_PORT_SELECTED) &&
> >> >                           (port->partner_oper.port_state & LACP_STAT=
E_SYNCHRONIZATION) &&
> >> >                           !__check_agg_selection_timer(port)) {
> >> >-                              if (port->aggregator->is_active)
> >> >-                                      port->sm_mux_state =3D
> >> >-                                          AD_MUX_COLLECTING_DISTRIBU=
TING;
> >> >+                              if (port->aggregator->is_active) {
> >> >+                                      int state =3D AD_MUX_COLLECTIN=
G_DISTRIBUTING;
> >> >+
> >> >+                                      if (!bond->params.coupled_cont=
rol)
> >> >+                                              state =3D AD_MUX_COLLE=
CTING;
> >> >+                                      port->sm_mux_state =3D state;
> >> >+                              }
> >> >                       } else if (!(port->sm_vars & AD_PORT_SELECTED)=
 ||
> >> >                                  (port->sm_vars & AD_PORT_STANDBY)) =
{
> >> >                               /* if UNSELECTED or STANDBY */
> >> >@@ -1019,11 +1075,45 @@ static void ad_mux_machine(struct port *port,=
 bool *update_slave_arr)
> >> >                       }
> >> >                       break;
> >> >               case AD_MUX_COLLECTING_DISTRIBUTING:
> >> >+                      if (!__port_move_to_attached_state(port)) {
> >> >+                              /* if port state hasn't changed make
> >> >+                               * sure that a collecting distributing
> >> >+                               * port in an active aggregator is ena=
bled
> >> >+                               */
> >> >+                              if (port->aggregator->is_active &&
> >> >+                                  !__port_is_collecting_distributing=
(port)) {
> >> >+                                      __enable_port(port);
> >> >+                                      *update_slave_arr =3D true;
> >> >+                              }
> >> >+                      }
> >> >+                      break;
> >> >+              case AD_MUX_COLLECTING:
> >> >+                      if (!__port_move_to_attached_state(port)) {
> >> >+                              if ((port->sm_vars & AD_PORT_SELECTED)=
 &&
> >> >+                                  (port->partner_oper.port_state & L=
ACP_STATE_SYNCHRONIZATION) &&
> >> >+                                  (port->partner_oper.port_state & L=
ACP_STATE_COLLECTING)) {
> >> >+                                      port->sm_mux_state =3D AD_MUX_=
DISTRIBUTING;
> >> >+                              } else {
> >> >+                                      /* If port state hasn't change=
d, make sure that a collecting
> >> >+                                       * port is enabled for an acti=
ve aggregator.
> >> >+                                       */
> >> >+                                      struct slave *slave =3D port->=
slave;
> >> >+
> >> >+                                      if (port->aggregator->is_activ=
e &&
> >> >+                                          bond_is_slave_rx_disabled(=
slave)) {
> >> >+                                              ad_enable_collecting(p=
ort);
> >> >+                                              *update_slave_arr =3D =
true;
> >> >+                                      }
> >> >+                              }
> >> >+                      }
> >> >+                      break;
> >> >+              case AD_MUX_DISTRIBUTING:
> >> >                       if (!(port->sm_vars & AD_PORT_SELECTED) ||
> >> >                           (port->sm_vars & AD_PORT_STANDBY) ||
> >> >+                          !(port->partner_oper.port_state & LACP_STA=
TE_COLLECTING) ||
> >> >                           !(port->partner_oper.port_state & LACP_STA=
TE_SYNCHRONIZATION) ||
> >> >                           !(port->actor_oper_port_state & LACP_STATE=
_SYNCHRONIZATION)) {
> >> >-                              port->sm_mux_state =3D AD_MUX_ATTACHED=
;
> >> >+                              port->sm_mux_state =3D AD_MUX_COLLECTI=
NG;
> >> >                       } else {
> >> >                               /* if port state hasn't changed make
> >> >                                * sure that a collecting distributing
> >> >@@ -1031,7 +1121,7 @@ static void ad_mux_machine(struct port *port, b=
ool *update_slave_arr)
> >> >                                */
> >> >                               if (port->aggregator &&
> >> >                                   port->aggregator->is_active &&
> >> >-                                  !__port_is_enabled(port)) {
> >> >+                                  !__port_is_collecting_distributing=
(port)) {
> >> >                                       __enable_port(port);
> >> >                                       *update_slave_arr =3D true;
> >> >                               }
> >> >@@ -1082,6 +1172,20 @@ static void ad_mux_machine(struct port *port, =
bool *update_slave_arr)
> >> >                                                         update_slave=
_arr);
> >> >                       port->ntt =3D true;
> >> >                       break;
> >> >+              case AD_MUX_COLLECTING:
> >> >+                      port->actor_oper_port_state |=3D LACP_STATE_CO=
LLECTING;
> >> >+                      port->actor_oper_port_state &=3D ~LACP_STATE_D=
ISTRIBUTING;
> >> >+                      port->actor_oper_port_state |=3D LACP_STATE_SY=
NCHRONIZATION;
> >> >+                      ad_enable_collecting(port);
> >> >+                      ad_disable_distributing(port, update_slave_arr=
);
> >> >+                      port->ntt =3D true;
> >> >+                      break;
> >> >+              case AD_MUX_DISTRIBUTING:
> >> >+                      port->actor_oper_port_state |=3D LACP_STATE_DI=
STRIBUTING;
> >> >+                      port->actor_oper_port_state |=3D LACP_STATE_SY=
NCHRONIZATION;
> >> >+                      ad_enable_collecting_distributing(port,
> >> >+                                                        update_slave=
_arr);
> >> >+                      break;
> >> >               default:
> >> >                       break;
> >> >               }
> >> >@@ -1906,6 +2010,45 @@ static void ad_initialize_port(struct port *po=
rt, int lacp_fast)
> >> >       }
> >> > }
> >> >
> >> >+/**
> >> >+ * ad_enable_collecting - enable a port's receive
> >> >+ * @port: the port we're looking at
> >> >+ *
> >> >+ * Enable @port if it's in an active aggregator
> >> >+ */
> >> >+static void ad_enable_collecting(struct port *port)
> >> >+{
> >> >+      if (port->aggregator->is_active) {
> >> >+              struct slave *slave =3D port->slave;
> >> >+
> >> >+              slave_dbg(slave->bond->dev, slave->dev,
> >> >+                        "Enabling collecting on port %d (LAG %d)\n",
> >> >+                        port->actor_port_number,
> >> >+                        port->aggregator->aggregator_identifier);
> >> >+              __enable_collecting_port(port);
> >> >+      }
> >> >+}
> >> >+
> >> >+/**
> >> >+ * ad_disable_distributing - disable a port's transmit
> >> >+ * @port: the port we're looking at
> >> >+ * @update_slave_arr: Does slave array need update?
> >> >+ */
> >> >+static void ad_disable_distributing(struct port *port, bool *update_=
slave_arr)
> >> >+{
> >> >+      if (port->aggregator &&
> >> >+          !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,
> >> >+                             &(null_mac_addr))) {
> >> >+              slave_dbg(port->slave->bond->dev, port->slave->dev,
> >> >+                        "Disabling distributing on port %d (LAG %d)\=
n",
> >> >+                        port->actor_port_number,
> >> >+                        port->aggregator->aggregator_identifier);
> >> >+              __disable_distributing_port(port);
> >> >+              /* Slave array needs an update */
> >> >+              *update_slave_arr =3D true;
> >> >+      }
> >> >+}
> >> >+
> >> > /**
> >> >  * ad_enable_collecting_distributing - enable a port's transmit/rece=
ive
> >> >  * @port: the port we're looking at
> >> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bo=
nd_main.c
> >> >index 8e6cc0e133b7..30f4b0ff01c0 100644
> >> >--- a/drivers/net/bonding/bond_main.c
> >> >+++ b/drivers/net/bonding/bond_main.c
> >> >@@ -6331,6 +6331,7 @@ static int __init bond_check_params(struct bond=
_params *params)
> >> >       params->ad_actor_sys_prio =3D ad_actor_sys_prio;
> >> >       eth_zero_addr(params->ad_actor_system);
> >> >       params->ad_user_port_key =3D ad_user_port_key;
> >> >+      params->coupled_control =3D 1;
> >> >       if (packets_per_slave > 0) {
> >> >               params->reciprocal_packets_per_slave =3D
> >> >                       reciprocal_value(packets_per_slave);
> >> >diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding=
/bond_netlink.c
> >> >index cfa74cf8bb1a..29b4c3d1b9b6 100644
> >> >--- a/drivers/net/bonding/bond_netlink.c
> >> >+++ b/drivers/net/bonding/bond_netlink.c
> >> >@@ -122,6 +122,7 @@ static const struct nla_policy bond_policy[IFLA_B=
OND_MAX + 1] =3D {
> >> >       [IFLA_BOND_PEER_NOTIF_DELAY]    =3D NLA_POLICY_FULL_RANGE(NLA_=
U32, &delay_range),
> >> >       [IFLA_BOND_MISSED_MAX]          =3D { .type =3D NLA_U8 },
> >> >       [IFLA_BOND_NS_IP6_TARGET]       =3D { .type =3D NLA_NESTED },
> >> >+      [IFLA_BOND_COUPLED_CONTROL]     =3D { .type =3D NLA_U8 },
> >> > };
> >> >
> >> > static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX=
 + 1] =3D {
> >> >@@ -549,6 +550,16 @@ static int bond_changelink(struct net_device *bo=
nd_dev, struct nlattr *tb[],
> >> >                       return err;
> >> >       }
> >> >
> >> >+      if (data[IFLA_BOND_COUPLED_CONTROL]) {
> >> >+              int coupled_control =3D nla_get_u8(data[IFLA_BOND_COUP=
LED_CONTROL]);
> >> >+
> >> >+              bond_opt_initval(&newval, coupled_control);
> >> >+              err =3D __bond_opt_set(bond, BOND_OPT_COUPLED_CONTROL,=
 &newval,
> >> >+                                   data[IFLA_BOND_COUPLED_CONTROL], =
extack);
> >> >+              if (err)
> >> >+                      return err;
> >> >+      }
> >> >+
> >> >       return 0;
> >> > }
> >> >
> >> >@@ -615,6 +626,7 @@ static size_t bond_get_size(const struct net_devi=
ce *bond_dev)
> >> >                                               /* IFLA_BOND_NS_IP6_TA=
RGET */
> >> >               nla_total_size(sizeof(struct nlattr)) +
> >> >               nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_=
TARGETS +
> >> >+              nla_total_size(sizeof(u8)) +    /* IFLA_BOND_COUPLED_C=
ONTROL */
> >> >               0;
> >> > }
> >> >
> >> >@@ -774,6 +786,10 @@ static int bond_fill_info(struct sk_buff *skb,
> >> >                      bond->params.missed_max))
> >> >               goto nla_put_failure;
> >> >
> >> >+      if (nla_put_u8(skb, IFLA_BOND_COUPLED_CONTROL,
> >> >+                     bond->params.coupled_control))
> >> >+              goto nla_put_failure;
> >> >+
> >> >       if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
> >> >               struct ad_info info;
> >> >
> >> >diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding=
/bond_options.c
> >> >index f3f27f0bd2a6..4cdbc7e084f4 100644
> >> >--- a/drivers/net/bonding/bond_options.c
> >> >+++ b/drivers/net/bonding/bond_options.c
> >> >@@ -84,7 +84,8 @@ static int bond_option_ad_user_port_key_set(struct =
bonding *bond,
> >> >                                           const struct bond_opt_valu=
e *newval);
> >> > static int bond_option_missed_max_set(struct bonding *bond,
> >> >                                     const struct bond_opt_value *new=
val);
> >> >-
> >> >+static int bond_option_coupled_control_set(struct bonding *bond,
> >> >+                                         const struct bond_opt_value=
 *newval);
> >> >
> >> > static const struct bond_opt_value bond_mode_tbl[] =3D {
> >> >       { "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAUL=
T},
> >> >@@ -232,6 +233,12 @@ static const struct bond_opt_value bond_missed_m=
ax_tbl[] =3D {
> >> >       { NULL,         -1,     0},
> >> > };
> >> >
> >> >+static const struct bond_opt_value bond_coupled_control_tbl[] =3D {
> >> >+      { "on",  1,  BOND_VALFLAG_DEFAULT},
> >> >+      { "off", 0,  0},
> >> >+      { NULL,  -1, 0},
> >> >+};
> >> >+
> >> > static const struct bond_option bond_opts[BOND_OPT_LAST] =3D {
> >> >       [BOND_OPT_MODE] =3D {
> >> >               .id =3D BOND_OPT_MODE,
> >> >@@ -496,6 +503,15 @@ static const struct bond_option bond_opts[BOND_O=
PT_LAST] =3D {
> >> >               .desc =3D "Delay between each peer notification on fai=
lover event, in milliseconds",
> >> >               .values =3D bond_peer_notif_delay_tbl,
> >> >               .set =3D bond_option_peer_notif_delay_set
> >> >+      },
> >> >+      [BOND_OPT_COUPLED_CONTROL] =3D {
> >> >+              .id =3D BOND_OPT_COUPLED_CONTROL,
> >> >+              .name =3D "coupled_control",
> >> >+              .desc =3D "Opt into using coupled control MUX for LACP=
 states",
> >> >+              .unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD=
)),
> >> >+              .flags =3D BOND_OPTFLAG_IFDOWN,
> >> >+              .values =3D bond_coupled_control_tbl,
> >> >+              .set =3D bond_option_coupled_control_set,
> >> >       }
> >> > };
> >> >
> >> >@@ -1692,3 +1708,13 @@ static int bond_option_ad_user_port_key_set(st=
ruct bonding *bond,
> >> >       bond->params.ad_user_port_key =3D newval->value;
> >> >       return 0;
> >> > }
> >> >+
> >> >+static int bond_option_coupled_control_set(struct bonding *bond,
> >> >+                                         const struct bond_opt_value=
 *newval)
> >> >+{
> >> >+      netdev_info(bond->dev, "Setting coupled_control to %s (%llu)\n=
",
> >> >+                  newval->string, newval->value);
> >> >+
> >> >+      bond->params.coupled_control =3D newval->value;
> >> >+      return 0;
> >> >+}
> >> >diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> >> >index c5e57c6bd873..9ce5ac2bfbad 100644
> >> >--- a/include/net/bond_3ad.h
> >> >+++ b/include/net/bond_3ad.h
> >> >@@ -54,6 +54,8 @@ typedef enum {
> >> >       AD_MUX_DETACHED,        /* mux machine */
> >> >       AD_MUX_WAITING,         /* mux machine */
> >> >       AD_MUX_ATTACHED,        /* mux machine */
> >> >+      AD_MUX_COLLECTING,      /* mux machine */
> >> >+      AD_MUX_DISTRIBUTING,    /* mux machine */
> >> >       AD_MUX_COLLECTING_DISTRIBUTING  /* mux machine */
> >> > } mux_states_t;
> >> >
> >> >diff --git a/include/net/bond_options.h b/include/net/bond_options.h
> >> >index 69292ecc0325..473a0147769e 100644
> >> >--- a/include/net/bond_options.h
> >> >+++ b/include/net/bond_options.h
> >> >@@ -76,6 +76,7 @@ enum {
> >> >       BOND_OPT_MISSED_MAX,
> >> >       BOND_OPT_NS_TARGETS,
> >> >       BOND_OPT_PRIO,
> >> >+      BOND_OPT_COUPLED_CONTROL,
> >> >       BOND_OPT_LAST
> >> > };
> >> >
> >> >diff --git a/include/net/bonding.h b/include/net/bonding.h
> >> >index 5b8b1b644a2d..b61fb1aa3a56 100644
> >> >--- a/include/net/bonding.h
> >> >+++ b/include/net/bonding.h
> >> >@@ -148,6 +148,7 @@ struct bond_params {
> >> > #if IS_ENABLED(CONFIG_IPV6)
> >> >       struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
> >> > #endif
> >> >+      int coupled_control;
> >> >
> >> >       /* 2 bytes of padding : see ether_addr_equal_64bits() */
> >> >       u8 ad_actor_system[ETH_ALEN + 2];
> >> >@@ -167,6 +168,7 @@ struct slave {
> >> >       u8     backup:1,   /* indicates backup slave. Value correspond=
s with
> >> >                             BOND_STATE_ACTIVE and BOND_STATE_BACKUP =
*/
> >> >              inactive:1, /* indicates inactive slave */
> >> >+             rx_disabled:1, /* indicates whether slave's Rx is disab=
led */
> >> >              should_notify:1, /* indicates whether the state changed=
 */
> >> >              should_notify_link:1; /* indicates whether the link cha=
nged */
> >> >       u8     duplex;
> >> >@@ -568,6 +570,14 @@ static inline void bond_set_slave_inactive_flags=
(struct slave *slave,
> >> >               bond_set_slave_state(slave, BOND_STATE_BACKUP, notify)=
;
> >> >       if (!slave->bond->params.all_slaves_active)
> >> >               slave->inactive =3D 1;
> >> >+      if (BOND_MODE(slave->bond) =3D=3D BOND_MODE_8023AD)
> >> >+              slave->rx_disabled =3D 1;
> >> >+}
> >> >+
> >> >+static inline void bond_set_slave_tx_disabled_flags(struct slave *sl=
ave,
> >> >+                                               bool notify)
> >> >+{
> >> >+      bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
> >> > }
> >> >
> >> > static inline void bond_set_slave_active_flags(struct slave *slave,
> >> >@@ -575,6 +585,14 @@ static inline void bond_set_slave_active_flags(s=
truct slave *slave,
> >> > {
> >> >       bond_set_slave_state(slave, BOND_STATE_ACTIVE, notify);
> >> >       slave->inactive =3D 0;
> >> >+      if (BOND_MODE(slave->bond) =3D=3D BOND_MODE_8023AD)
> >> >+              slave->rx_disabled =3D 0;
> >> >+}
> >> >+
> >> >+static inline void bond_set_slave_rx_enabled_flags(struct slave *sla=
ve,
> >> >+                                             bool notify)
> >> >+{
> >> >+      slave->rx_disabled =3D 0;
> >> > }
> >> >
> >> > static inline bool bond_is_slave_inactive(struct slave *slave)
> >> >@@ -582,6 +600,11 @@ static inline bool bond_is_slave_inactive(struct=
 slave *slave)
> >> >       return slave->inactive;
> >> > }
> >> >
> >> >+static inline bool bond_is_slave_rx_disabled(struct slave *slave)
> >> >+{
> >> >+      return slave->rx_disabled;
> >> >+}
> >> >+
> >> > static inline void bond_propose_link_state(struct slave *slave, int =
state)
> >> > {
> >> >       slave->link_new_state =3D state;
> >> >diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_lin=
k.h
> >> >index 29ff80da2775..7a54fcff2eec 100644
> >> >--- a/include/uapi/linux/if_link.h
> >> >+++ b/include/uapi/linux/if_link.h
> >> >@@ -976,6 +976,7 @@ enum {
> >> >       IFLA_BOND_AD_LACP_ACTIVE,
> >> >       IFLA_BOND_MISSED_MAX,
> >> >       IFLA_BOND_NS_IP6_TARGET,
> >> >+      IFLA_BOND_COUPLED_CONTROL,
> >> >       __IFLA_BOND_MAX,
> >> > };
> >> >
> >> >diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/=
linux/if_link.h
> >> >index a0aa05a28cf2..f0d71b2a3f1e 100644
> >> >--- a/tools/include/uapi/linux/if_link.h
> >> >+++ b/tools/include/uapi/linux/if_link.h
> >> >@@ -974,6 +974,7 @@ enum {
> >> >       IFLA_BOND_AD_LACP_ACTIVE,
> >> >       IFLA_BOND_MISSED_MAX,
> >> >       IFLA_BOND_NS_IP6_TARGET,
> >> >+      IFLA_BOND_COUPLED_CONTROL,
> >> >       __IFLA_BOND_MAX,
> >> > };
> >> >
> >> >--
> >> >2.43.0.429.g432eaa2c6b-goog
> >> >
> >> >
>
> ---
>         -Jay Vosburgh, jay.vosburgh@canonical.com

