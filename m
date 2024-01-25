Return-Path: <linux-kernel+bounces-39370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D339383CF85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37492B26E13
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DDB11CBE;
	Thu, 25 Jan 2024 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTpbOaZK"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565D61119A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222239; cv=none; b=PoB0tsjf5HyyondzWfJfOIV4WaiEmYFUP1CguylsptkZ/5aUQDLt4mjGjAjt94B8/0DJCe9ptMR9tN7BGKH/wATyPIkvLKr6BpSi5SVDmFtUFIgU8kEchxDDl0ZXAIUtm43OXyax2X9x1N4zot0tbrzWhS3fmuVBKn0Sbvhgz3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222239; c=relaxed/simple;
	bh=VPIXe5iGn4taUd8fRelqDB9jomlQWcwTODwJkKiBRjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sF8dA/PI4k+PB6mNM5PPvPdwVwicvopzbBXp/BczDiZLElk/tviBZ+RCtMCV3hVP5PlC038iF4Bgj0r0x7Iy00xZXSzhYZWvhpyvVRgJDLUlxOeMgX9+lskpWePcDrhAW1jyE5YUTbPh7rg63xkhzXPBGWE/9y6XU5aI/igYPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VTpbOaZK; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-681922a61baso10865746d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706222234; x=1706827034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uEg1kG3BPdX5bDjdupQq7nT9H7YVY2yOM1H0VO06Go=;
        b=VTpbOaZKq8wKlR3IEQ8kYzLTC8JC210XNZpLJybKaZENR0WFbtpL4tXaAjzOO+b2FM
         jNm44xGMFbJ+ce9fjn4V5HfwNaburbcJGS1ciFejeoxEvuPuRKq2MgASi4iVqANOibxq
         7kylcY7hyjHoDdgS+grVvPq+DVUrDxBauJDBwRtGmjPVPNt034qhSIYYimIbaPHUbXVR
         RFFIc0n0c002bl5Vi3r8S21UPT8tH5NiXoBgRgrvGCiLFWtXQ6SOq1VK7t9JtUCYCxAk
         iNPI+U2bIyXnFFchloGoJUTmnATpMImYsGbbjPksl4kFVxui31eH5movBFGbuHZFosOd
         c1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706222234; x=1706827034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uEg1kG3BPdX5bDjdupQq7nT9H7YVY2yOM1H0VO06Go=;
        b=N5KvdtEHAgHpXXF1tmCm4hxscQpKkAsxJuaRgHu86dwnznpg3NBE9ip4i9Y3x+3gk0
         feWJtsvhfPHcgUaPo7RfrUcZDjk2Xoekzi9CFrvqwg72tPOdaMQxbCvhrSI7BW1lfLjD
         Ta6xmhvspZ7OS6y52ASsPiRIAx/a8mIjL+K3PPTE5cd0TOvoVfsCtRVD/f2ixDUt/6Z2
         B/3EAoG+yvtxg8C/QanAvmWZoQW9YmEmp5ypZhhKTCMCxjdqrckm4/fjLbaeC+/kcq93
         T/7Nhr4cFlzuOgzeTpnCH2tV5XV/hBx595/Vr884qBxT79X0+czwq6PY+slGAzjhsYI9
         Atyw==
X-Gm-Message-State: AOJu0Yx9gnQSOgIpBEI1e2ARPoyXZArpbwCccdzvBLYfxPdGr04vIjBu
	8OVOg9Zu0udYkbvrUj9TqxxEY07gej6gUCDS1kEbb05T/reiwaWoUYabd73Yd2hOiqiLoxGQqdn
	CFfAthAOwvepN9iD9sgJXtwaeR6EGESv0LCNU
X-Google-Smtp-Source: AGHT+IH4xiISe+IMb9faiRwgAw13iBB23DCS/0m9W9speWcWouETuC7LAT9Z9ObM4VHc96w34Wbrz7R4LE4c18Gy6VU=
X-Received: by 2002:a05:6214:1381:b0:685:52c7:1c0d with SMTP id
 pp1-20020a056214138100b0068552c71c0dmr3514qvb.58.1706222233695; Thu, 25 Jan
 2024 14:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123235130.1982654-1-aahila@google.com> <4577.1706076998@famine>
 <CAGfWUPwsh3xFK6JvT9p07eXD2j1V=B=kVNfPOWJj6L4SXyeyDA@mail.gmail.com>
 <7770.1706120209@famine> <CAGfWUPzBP_jNxrHeTmmKw0LCCJxuV9MELoKUGCwP648gGE0PQA@mail.gmail.com>
In-Reply-To: <CAGfWUPzBP_jNxrHeTmmKw0LCCJxuV9MELoKUGCwP648gGE0PQA@mail.gmail.com>
From: Aahil Awatramani <aahila@google.com>
Date: Thu, 25 Jan 2024 14:37:02 -0800
Message-ID: <CAGfWUPz_J02VFTjCeqy6nnAvbDspwtj=VvviEd4Kkt5qJ454Ww@mail.gmail.com>
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

> I also realised that I haven't appended coupled_control to procfs.

To clarify, I will hold off on adding coupled_control to procfs until reque=
sted.

Thanks,
Aahil

On Wed, Jan 24, 2024 at 4:38=E2=80=AFPM Aahil Awatramani <aahila@google.com=
> wrote:
>
> >         Could you post it now?  They're logically parts of a single
> > feature, so should go together.  As a practical matter, though, it's
> > easier to test this patch with the iproute patch available.
>
> Sure, I have uploaded the patch for review, and also cc'd you on the emai=
l.
> I also realised that I haven't appended coupled_control to procfs.
> Will add that change in v6.
>
> On Wed, Jan 24, 2024 at 10:16=E2=80=AFAM Jay Vosburgh
> <jay.vosburgh@canonical.com> wrote:
> >
> > Aahil Awatramani <aahila@google.com> wrote:
> >
> > >>         Do you have a corresponding iproute2 patch to enable changin=
g
> > >> the coupled_control option?
> > >
> > >I do have the corresponding patch for iproute2 to enable changing
> > >coupled_control, I planned to push that patch for review directly
> > >after this one.
> >
> >         Could you post it now?  They're logically parts of a single
> > feature, so should go together.  As a practical matter, though, it's
> > easier to test this patch with the iproute patch available.
> >
> >         -J
> >
> > >
> > >On Tue, Jan 23, 2024 at 10:16=E2=80=AFPM Jay Vosburgh
> > ><jay.vosburgh@canonical.com> wrote:
> > >>
> > >> Aahil Awatramani <aahila@google.com> wrote:
> > >>
> > >> >Add support for the independent control state machine per IEEE
> > >> >802.1AX-2008 5.4.15 in addition to the existing implementation of t=
he
> > >> >coupled control state machine.
> > >> >
> > >> >Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTIN=
G in
> > >> >the LACP MUX state machine for separated handling of an initial
> > >> >Collecting state before the Collecting and Distributing state. This
> > >> >enables a port to be in a state where it can receive incoming packe=
ts
> > >> >while not still distributing. This is useful for reducing packet lo=
ss when
> > >> >a port begins distributing before its partner is able to collect.
> > >> >
> > >> >Added new functions such as bond_set_slave_tx_disabled_flags and
> > >> >bond_set_slave_rx_enabled_flags to precisely manage the port's coll=
ecting
> > >> >and distributing states. Previously, there was no dedicated method =
to
> > >> >disable TX while keeping RX enabled, which this patch addresses.
> > >> >
> > >> >Note that the regular flow process in the kernel's bonding driver r=
emains
> > >> >unaffected by this patch. The extension requires explicit opt-in by=
 the
> > >> >user (in order to ensure no disruptions for existing setups) via ne=
tlink
> > >> >support using the new bonding parameter coupled_control. The defaul=
t value
> > >> >for coupled_control is set to 1 so as to preserve existing behaviou=
r.
> > >>
> > >>         Do you have a corresponding iproute2 patch to enable changin=
g
> > >> the coupled_control option?
> > >>
> > >>         -J
> > >>
> > >> >Signed-off-by: Aahil Awatramani <aahila@google.com>
> > >> >
> > >> >v5:
> > >> >  Merge documentation patch with changes patch
> > >> >  Add version history in comment description
> > >> >v4:
> > >> >  Remove inline references from c source files
> > >> >v3:
> > >> >  Edited commit description
> > >> >  Edited documentation description
> > >> >  Changed function names
> > >> >  Only allow coupled_control change when the bond is down
> > >> >v2:
> > >> >  Removed sysfs changes
> > >> >  Added documentation for new paramater
> > >> >  Renamed parameter to coupled_control
> > >> >  Update bond_set_slave_inactive_flags() with a 8023ad check
> > >> >
> > >> >---
> > >> > Documentation/networking/bonding.rst |  12 ++
> > >> > drivers/net/bonding/bond_3ad.c       | 157 +++++++++++++++++++++++=
++--
> > >> > drivers/net/bonding/bond_main.c      |   1 +
> > >> > drivers/net/bonding/bond_netlink.c   |  16 +++
> > >> > drivers/net/bonding/bond_options.c   |  28 ++++-
> > >> > include/net/bond_3ad.h               |   2 +
> > >> > include/net/bond_options.h           |   1 +
> > >> > include/net/bonding.h                |  23 ++++
> > >> > include/uapi/linux/if_link.h         |   1 +
> > >> > tools/include/uapi/linux/if_link.h   |   1 +
> > >> > 10 files changed, 234 insertions(+), 8 deletions(-)
> > >> >
> > >> >diff --git a/Documentation/networking/bonding.rst b/Documentation/n=
etworking/bonding.rst
> > >> >index f7a73421eb76..e774b48de9f5 100644
> > >> >--- a/Documentation/networking/bonding.rst
> > >> >+++ b/Documentation/networking/bonding.rst
> > >> >@@ -444,6 +444,18 @@ arp_missed_max
> > >> >
> > >> >       The default value is 2, and the allowable range is 1 - 255.
> > >> >
> > >> >+coupled_control
> > >> >+
> > >> >+    Specifies whether the LACP state machine's MUX in the 802.3ad =
mode
> > >> >+    should have separate Collecting and Distributing states.
> > >> >+
> > >> >+    This is by implementing the independent control state machine =
per
> > >> >+    IEEE 802.1AX-2008 5.4.15 in addition to the existing coupled c=
ontrol
> > >> >+    state machine.
> > >> >+
> > >> >+    The default value is 1. This setting does not separate the Col=
lecting
> > >> >+    and Distributing states, maintaining the bond in coupled contr=
ol.
> > >> >+
> > >> > downdelay
> > >> >
> > >> >       Specifies the time, in milliseconds, to wait before disablin=
g
> > >> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/b=
ond_3ad.c
> > >> >index c99ffe6c683a..f2942e8c6c91 100644
> > >> >--- a/drivers/net/bonding/bond_3ad.c
> > >> >+++ b/drivers/net/bonding/bond_3ad.c
> > >> >@@ -106,6 +106,9 @@ static void ad_agg_selection_logic(struct aggre=
gator *aggregator,
> > >> > static void ad_clear_agg(struct aggregator *aggregator);
> > >> > static void ad_initialize_agg(struct aggregator *aggregator);
> > >> > static void ad_initialize_port(struct port *port, int lacp_fast);
> > >> >+static void ad_enable_collecting(struct port *port);
> > >> >+static void ad_disable_distributing(struct port *port,
> > >> >+                                  bool *update_slave_arr);
> > >> > static void ad_enable_collecting_distributing(struct port *port,
> > >> >                                             bool *update_slave_arr=
);
> > >> > static void ad_disable_collecting_distributing(struct port *port,
> > >> >@@ -171,9 +174,38 @@ static inline int __agg_has_partner(struct agg=
regator *agg)
> > >> >       return !is_zero_ether_addr(agg->partner_system.mac_addr_valu=
e);
> > >> > }
> > >> >
> > >> >+/**
> > >> >+ * __disable_distributing_port - disable the port's slave for dist=
ributing.
> > >> >+ * Port will still be able to collect.
> > >> >+ * @port: the port we're looking at
> > >> >+ *
> > >> >+ * This will disable only distributing on the port's slave.
> > >> >+ */
> > >> >+static void __disable_distributing_port(struct port *port)
> > >> >+{
> > >> >+      bond_set_slave_tx_disabled_flags(port->slave, BOND_SLAVE_NOT=
IFY_LATER);
> > >> >+}
> > >> >+
> > >> >+/**
> > >> >+ * __enable_collecting_port - enable the port's slave for collecti=
ng,
> > >> >+ * if it's up
> > >> >+ * @port: the port we're looking at
> > >> >+ *
> > >> >+ * This will enable only collecting on the port's slave.
> > >> >+ */
> > >> >+static void __enable_collecting_port(struct port *port)
> > >> >+{
> > >> >+      struct slave *slave =3D port->slave;
> > >> >+
> > >> >+      if (slave->link =3D=3D BOND_LINK_UP && bond_slave_is_up(slav=
e))
> > >> >+              bond_set_slave_rx_enabled_flags(slave, BOND_SLAVE_NO=
TIFY_LATER);
> > >> >+}
> > >> >+
> > >> > /**
> > >> >  * __disable_port - disable the port's slave
> > >> >  * @port: the port we're looking at
> > >> >+ *
> > >> >+ * This will disable both collecting and distributing on the port'=
s slave.
> > >> >  */
> > >> > static inline void __disable_port(struct port *port)
> > >> > {
> > >> >@@ -183,6 +215,8 @@ static inline void __disable_port(struct port *=
port)
> > >> > /**
> > >> >  * __enable_port - enable the port's slave, if it's up
> > >> >  * @port: the port we're looking at
> > >> >+ *
> > >> >+ * This will enable both collecting and distributing on the port's=
 slave.
> > >> >  */
> > >> > static inline void __enable_port(struct port *port)
> > >> > {
> > >> >@@ -193,10 +227,27 @@ static inline void __enable_port(struct port =
*port)
> > >> > }
> > >> >
> > >> > /**
> > >> >- * __port_is_enabled - check if the port's slave is in active stat=
e
> > >> >+ * __port_move_to_attached_state - check if port should transition=
 back to attached
> > >> >+ * state.
> > >> >+ * @port: the port we're looking at
> > >> >+ */
> > >> >+static bool __port_move_to_attached_state(struct port *port)
> > >> >+{
> > >> >+      if (!(port->sm_vars & AD_PORT_SELECTED) ||
> > >> >+          (port->sm_vars & AD_PORT_STANDBY) ||
> > >> >+          !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZA=
TION) ||
> > >> >+          !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATI=
ON))
> > >> >+              port->sm_mux_state =3D AD_MUX_ATTACHED;
> > >> >+
> > >> >+      return port->sm_mux_state =3D=3D AD_MUX_ATTACHED;
> > >> >+}
> > >> >+
> > >> >+/**
> > >> >+ * __port_is_collecting_distributing - check if the port's slave i=
s in the
> > >> >+ * combined collecting/distributing state
> > >> >  * @port: the port we're looking at
> > >> >  */
> > >> >-static inline int __port_is_enabled(struct port *port)
> > >> >+static int __port_is_collecting_distributing(struct port *port)
> > >> > {
> > >> >       return bond_is_active_slave(port->slave);
> > >> > }
> > >> >@@ -942,6 +993,7 @@ static int ad_marker_send(struct port *port, st=
ruct bond_marker *marker)
> > >> >  */
> > >> > static void ad_mux_machine(struct port *port, bool *update_slave_a=
rr)
> > >> > {
> > >> >+      struct bonding *bond =3D __get_bond_by_port(port);
> > >> >       mux_states_t last_state;
> > >> >
> > >> >       /* keep current State Machine state to compare later if it w=
as
> > >> >@@ -999,9 +1051,13 @@ static void ad_mux_machine(struct port *port,=
 bool *update_slave_arr)
> > >> >                       if ((port->sm_vars & AD_PORT_SELECTED) &&
> > >> >                           (port->partner_oper.port_state & LACP_ST=
ATE_SYNCHRONIZATION) &&
> > >> >                           !__check_agg_selection_timer(port)) {
> > >> >-                              if (port->aggregator->is_active)
> > >> >-                                      port->sm_mux_state =3D
> > >> >-                                          AD_MUX_COLLECTING_DISTRI=
BUTING;
> > >> >+                              if (port->aggregator->is_active) {
> > >> >+                                      int state =3D AD_MUX_COLLECT=
ING_DISTRIBUTING;
> > >> >+
> > >> >+                                      if (!bond->params.coupled_co=
ntrol)
> > >> >+                                              state =3D AD_MUX_COL=
LECTING;
> > >> >+                                      port->sm_mux_state =3D state=
;
> > >> >+                              }
> > >> >                       } else if (!(port->sm_vars & AD_PORT_SELECTE=
D) ||
> > >> >                                  (port->sm_vars & AD_PORT_STANDBY)=
) {
> > >> >                               /* if UNSELECTED or STANDBY */
> > >> >@@ -1019,11 +1075,45 @@ static void ad_mux_machine(struct port *por=
t, bool *update_slave_arr)
> > >> >                       }
> > >> >                       break;
> > >> >               case AD_MUX_COLLECTING_DISTRIBUTING:
> > >> >+                      if (!__port_move_to_attached_state(port)) {
> > >> >+                              /* if port state hasn't changed make
> > >> >+                               * sure that a collecting distributi=
ng
> > >> >+                               * port in an active aggregator is e=
nabled
> > >> >+                               */
> > >> >+                              if (port->aggregator->is_active &&
> > >> >+                                  !__port_is_collecting_distributi=
ng(port)) {
> > >> >+                                      __enable_port(port);
> > >> >+                                      *update_slave_arr =3D true;
> > >> >+                              }
> > >> >+                      }
> > >> >+                      break;
> > >> >+              case AD_MUX_COLLECTING:
> > >> >+                      if (!__port_move_to_attached_state(port)) {
> > >> >+                              if ((port->sm_vars & AD_PORT_SELECTE=
D) &&
> > >> >+                                  (port->partner_oper.port_state &=
 LACP_STATE_SYNCHRONIZATION) &&
> > >> >+                                  (port->partner_oper.port_state &=
 LACP_STATE_COLLECTING)) {
> > >> >+                                      port->sm_mux_state =3D AD_MU=
X_DISTRIBUTING;
> > >> >+                              } else {
> > >> >+                                      /* If port state hasn't chan=
ged, make sure that a collecting
> > >> >+                                       * port is enabled for an ac=
tive aggregator.
> > >> >+                                       */
> > >> >+                                      struct slave *slave =3D port=
->slave;
> > >> >+
> > >> >+                                      if (port->aggregator->is_act=
ive &&
> > >> >+                                          bond_is_slave_rx_disable=
d(slave)) {
> > >> >+                                              ad_enable_collecting=
(port);
> > >> >+                                              *update_slave_arr =
=3D true;
> > >> >+                                      }
> > >> >+                              }
> > >> >+                      }
> > >> >+                      break;
> > >> >+              case AD_MUX_DISTRIBUTING:
> > >> >                       if (!(port->sm_vars & AD_PORT_SELECTED) ||
> > >> >                           (port->sm_vars & AD_PORT_STANDBY) ||
> > >> >+                          !(port->partner_oper.port_state & LACP_S=
TATE_COLLECTING) ||
> > >> >                           !(port->partner_oper.port_state & LACP_S=
TATE_SYNCHRONIZATION) ||
> > >> >                           !(port->actor_oper_port_state & LACP_STA=
TE_SYNCHRONIZATION)) {
> > >> >-                              port->sm_mux_state =3D AD_MUX_ATTACH=
ED;
> > >> >+                              port->sm_mux_state =3D AD_MUX_COLLEC=
TING;
> > >> >                       } else {
> > >> >                               /* if port state hasn't changed make
> > >> >                                * sure that a collecting distributi=
ng
> > >> >@@ -1031,7 +1121,7 @@ static void ad_mux_machine(struct port *port,=
 bool *update_slave_arr)
> > >> >                                */
> > >> >                               if (port->aggregator &&
> > >> >                                   port->aggregator->is_active &&
> > >> >-                                  !__port_is_enabled(port)) {
> > >> >+                                  !__port_is_collecting_distributi=
ng(port)) {
> > >> >                                       __enable_port(port);
> > >> >                                       *update_slave_arr =3D true;
> > >> >                               }
> > >> >@@ -1082,6 +1172,20 @@ static void ad_mux_machine(struct port *port=
, bool *update_slave_arr)
> > >> >                                                         update_sla=
ve_arr);
> > >> >                       port->ntt =3D true;
> > >> >                       break;
> > >> >+              case AD_MUX_COLLECTING:
> > >> >+                      port->actor_oper_port_state |=3D LACP_STATE_=
COLLECTING;
> > >> >+                      port->actor_oper_port_state &=3D ~LACP_STATE=
_DISTRIBUTING;
> > >> >+                      port->actor_oper_port_state |=3D LACP_STATE_=
SYNCHRONIZATION;
> > >> >+                      ad_enable_collecting(port);
> > >> >+                      ad_disable_distributing(port, update_slave_a=
rr);
> > >> >+                      port->ntt =3D true;
> > >> >+                      break;
> > >> >+              case AD_MUX_DISTRIBUTING:
> > >> >+                      port->actor_oper_port_state |=3D LACP_STATE_=
DISTRIBUTING;
> > >> >+                      port->actor_oper_port_state |=3D LACP_STATE_=
SYNCHRONIZATION;
> > >> >+                      ad_enable_collecting_distributing(port,
> > >> >+                                                        update_sla=
ve_arr);
> > >> >+                      break;
> > >> >               default:
> > >> >                       break;
> > >> >               }
> > >> >@@ -1906,6 +2010,45 @@ static void ad_initialize_port(struct port *=
port, int lacp_fast)
> > >> >       }
> > >> > }
> > >> >
> > >> >+/**
> > >> >+ * ad_enable_collecting - enable a port's receive
> > >> >+ * @port: the port we're looking at
> > >> >+ *
> > >> >+ * Enable @port if it's in an active aggregator
> > >> >+ */
> > >> >+static void ad_enable_collecting(struct port *port)
> > >> >+{
> > >> >+      if (port->aggregator->is_active) {
> > >> >+              struct slave *slave =3D port->slave;
> > >> >+
> > >> >+              slave_dbg(slave->bond->dev, slave->dev,
> > >> >+                        "Enabling collecting on port %d (LAG %d)\n=
",
> > >> >+                        port->actor_port_number,
> > >> >+                        port->aggregator->aggregator_identifier);
> > >> >+              __enable_collecting_port(port);
> > >> >+      }
> > >> >+}
> > >> >+
> > >> >+/**
> > >> >+ * ad_disable_distributing - disable a port's transmit
> > >> >+ * @port: the port we're looking at
> > >> >+ * @update_slave_arr: Does slave array need update?
> > >> >+ */
> > >> >+static void ad_disable_distributing(struct port *port, bool *updat=
e_slave_arr)
> > >> >+{
> > >> >+      if (port->aggregator &&
> > >> >+          !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,
> > >> >+                             &(null_mac_addr))) {
> > >> >+              slave_dbg(port->slave->bond->dev, port->slave->dev,
> > >> >+                        "Disabling distributing on port %d (LAG %d=
)\n",
> > >> >+                        port->actor_port_number,
> > >> >+                        port->aggregator->aggregator_identifier);
> > >> >+              __disable_distributing_port(port);
> > >> >+              /* Slave array needs an update */
> > >> >+              *update_slave_arr =3D true;
> > >> >+      }
> > >> >+}
> > >> >+
> > >> > /**
> > >> >  * ad_enable_collecting_distributing - enable a port's transmit/re=
ceive
> > >> >  * @port: the port we're looking at
> > >> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/=
bond_main.c
> > >> >index 8e6cc0e133b7..30f4b0ff01c0 100644
> > >> >--- a/drivers/net/bonding/bond_main.c
> > >> >+++ b/drivers/net/bonding/bond_main.c
> > >> >@@ -6331,6 +6331,7 @@ static int __init bond_check_params(struct bo=
nd_params *params)
> > >> >       params->ad_actor_sys_prio =3D ad_actor_sys_prio;
> > >> >       eth_zero_addr(params->ad_actor_system);
> > >> >       params->ad_user_port_key =3D ad_user_port_key;
> > >> >+      params->coupled_control =3D 1;
> > >> >       if (packets_per_slave > 0) {
> > >> >               params->reciprocal_packets_per_slave =3D
> > >> >                       reciprocal_value(packets_per_slave);
> > >> >diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bondi=
ng/bond_netlink.c
> > >> >index cfa74cf8bb1a..29b4c3d1b9b6 100644
> > >> >--- a/drivers/net/bonding/bond_netlink.c
> > >> >+++ b/drivers/net/bonding/bond_netlink.c
> > >> >@@ -122,6 +122,7 @@ static const struct nla_policy bond_policy[IFLA=
_BOND_MAX + 1] =3D {
> > >> >       [IFLA_BOND_PEER_NOTIF_DELAY]    =3D NLA_POLICY_FULL_RANGE(NL=
A_U32, &delay_range),
> > >> >       [IFLA_BOND_MISSED_MAX]          =3D { .type =3D NLA_U8 },
> > >> >       [IFLA_BOND_NS_IP6_TARGET]       =3D { .type =3D NLA_NESTED }=
,
> > >> >+      [IFLA_BOND_COUPLED_CONTROL]     =3D { .type =3D NLA_U8 },
> > >> > };
> > >> >
> > >> > static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_M=
AX + 1] =3D {
> > >> >@@ -549,6 +550,16 @@ static int bond_changelink(struct net_device *=
bond_dev, struct nlattr *tb[],
> > >> >                       return err;
> > >> >       }
> > >> >
> > >> >+      if (data[IFLA_BOND_COUPLED_CONTROL]) {
> > >> >+              int coupled_control =3D nla_get_u8(data[IFLA_BOND_CO=
UPLED_CONTROL]);
> > >> >+
> > >> >+              bond_opt_initval(&newval, coupled_control);
> > >> >+              err =3D __bond_opt_set(bond, BOND_OPT_COUPLED_CONTRO=
L, &newval,
> > >> >+                                   data[IFLA_BOND_COUPLED_CONTROL]=
, extack);
> > >> >+              if (err)
> > >> >+                      return err;
> > >> >+      }
> > >> >+
> > >> >       return 0;
> > >> > }
> > >> >
> > >> >@@ -615,6 +626,7 @@ static size_t bond_get_size(const struct net_de=
vice *bond_dev)
> > >> >                                               /* IFLA_BOND_NS_IP6_=
TARGET */
> > >> >               nla_total_size(sizeof(struct nlattr)) +
> > >> >               nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_N=
S_TARGETS +
> > >> >+              nla_total_size(sizeof(u8)) +    /* IFLA_BOND_COUPLED=
_CONTROL */
> > >> >               0;
> > >> > }
> > >> >
> > >> >@@ -774,6 +786,10 @@ static int bond_fill_info(struct sk_buff *skb,
> > >> >                      bond->params.missed_max))
> > >> >               goto nla_put_failure;
> > >> >
> > >> >+      if (nla_put_u8(skb, IFLA_BOND_COUPLED_CONTROL,
> > >> >+                     bond->params.coupled_control))
> > >> >+              goto nla_put_failure;
> > >> >+
> > >> >       if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
> > >> >               struct ad_info info;
> > >> >
> > >> >diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bondi=
ng/bond_options.c
> > >> >index f3f27f0bd2a6..4cdbc7e084f4 100644
> > >> >--- a/drivers/net/bonding/bond_options.c
> > >> >+++ b/drivers/net/bonding/bond_options.c
> > >> >@@ -84,7 +84,8 @@ static int bond_option_ad_user_port_key_set(struc=
t bonding *bond,
> > >> >                                           const struct bond_opt_va=
lue *newval);
> > >> > static int bond_option_missed_max_set(struct bonding *bond,
> > >> >                                     const struct bond_opt_value *n=
ewval);
> > >> >-
> > >> >+static int bond_option_coupled_control_set(struct bonding *bond,
> > >> >+                                         const struct bond_opt_val=
ue *newval);
> > >> >
> > >> > static const struct bond_opt_value bond_mode_tbl[] =3D {
> > >> >       { "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFA=
ULT},
> > >> >@@ -232,6 +233,12 @@ static const struct bond_opt_value bond_missed=
_max_tbl[] =3D {
> > >> >       { NULL,         -1,     0},
> > >> > };
> > >> >
> > >> >+static const struct bond_opt_value bond_coupled_control_tbl[] =3D =
{
> > >> >+      { "on",  1,  BOND_VALFLAG_DEFAULT},
> > >> >+      { "off", 0,  0},
> > >> >+      { NULL,  -1, 0},
> > >> >+};
> > >> >+
> > >> > static const struct bond_option bond_opts[BOND_OPT_LAST] =3D {
> > >> >       [BOND_OPT_MODE] =3D {
> > >> >               .id =3D BOND_OPT_MODE,
> > >> >@@ -496,6 +503,15 @@ static const struct bond_option bond_opts[BOND=
_OPT_LAST] =3D {
> > >> >               .desc =3D "Delay between each peer notification on f=
ailover event, in milliseconds",
> > >> >               .values =3D bond_peer_notif_delay_tbl,
> > >> >               .set =3D bond_option_peer_notif_delay_set
> > >> >+      },
> > >> >+      [BOND_OPT_COUPLED_CONTROL] =3D {
> > >> >+              .id =3D BOND_OPT_COUPLED_CONTROL,
> > >> >+              .name =3D "coupled_control",
> > >> >+              .desc =3D "Opt into using coupled control MUX for LA=
CP states",
> > >> >+              .unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023=
AD)),
> > >> >+              .flags =3D BOND_OPTFLAG_IFDOWN,
> > >> >+              .values =3D bond_coupled_control_tbl,
> > >> >+              .set =3D bond_option_coupled_control_set,
> > >> >       }
> > >> > };
> > >> >
> > >> >@@ -1692,3 +1708,13 @@ static int bond_option_ad_user_port_key_set(=
struct bonding *bond,
> > >> >       bond->params.ad_user_port_key =3D newval->value;
> > >> >       return 0;
> > >> > }
> > >> >+
> > >> >+static int bond_option_coupled_control_set(struct bonding *bond,
> > >> >+                                         const struct bond_opt_val=
ue *newval)
> > >> >+{
> > >> >+      netdev_info(bond->dev, "Setting coupled_control to %s (%llu)=
\n",
> > >> >+                  newval->string, newval->value);
> > >> >+
> > >> >+      bond->params.coupled_control =3D newval->value;
> > >> >+      return 0;
> > >> >+}
> > >> >diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> > >> >index c5e57c6bd873..9ce5ac2bfbad 100644
> > >> >--- a/include/net/bond_3ad.h
> > >> >+++ b/include/net/bond_3ad.h
> > >> >@@ -54,6 +54,8 @@ typedef enum {
> > >> >       AD_MUX_DETACHED,        /* mux machine */
> > >> >       AD_MUX_WAITING,         /* mux machine */
> > >> >       AD_MUX_ATTACHED,        /* mux machine */
> > >> >+      AD_MUX_COLLECTING,      /* mux machine */
> > >> >+      AD_MUX_DISTRIBUTING,    /* mux machine */
> > >> >       AD_MUX_COLLECTING_DISTRIBUTING  /* mux machine */
> > >> > } mux_states_t;
> > >> >
> > >> >diff --git a/include/net/bond_options.h b/include/net/bond_options.=
h
> > >> >index 69292ecc0325..473a0147769e 100644
> > >> >--- a/include/net/bond_options.h
> > >> >+++ b/include/net/bond_options.h
> > >> >@@ -76,6 +76,7 @@ enum {
> > >> >       BOND_OPT_MISSED_MAX,
> > >> >       BOND_OPT_NS_TARGETS,
> > >> >       BOND_OPT_PRIO,
> > >> >+      BOND_OPT_COUPLED_CONTROL,
> > >> >       BOND_OPT_LAST
> > >> > };
> > >> >
> > >> >diff --git a/include/net/bonding.h b/include/net/bonding.h
> > >> >index 5b8b1b644a2d..b61fb1aa3a56 100644
> > >> >--- a/include/net/bonding.h
> > >> >+++ b/include/net/bonding.h
> > >> >@@ -148,6 +148,7 @@ struct bond_params {
> > >> > #if IS_ENABLED(CONFIG_IPV6)
> > >> >       struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
> > >> > #endif
> > >> >+      int coupled_control;
> > >> >
> > >> >       /* 2 bytes of padding : see ether_addr_equal_64bits() */
> > >> >       u8 ad_actor_system[ETH_ALEN + 2];
> > >> >@@ -167,6 +168,7 @@ struct slave {
> > >> >       u8     backup:1,   /* indicates backup slave. Value correspo=
nds with
> > >> >                             BOND_STATE_ACTIVE and BOND_STATE_BACKU=
P */
> > >> >              inactive:1, /* indicates inactive slave */
> > >> >+             rx_disabled:1, /* indicates whether slave's Rx is dis=
abled */
> > >> >              should_notify:1, /* indicates whether the state chang=
ed */
> > >> >              should_notify_link:1; /* indicates whether the link c=
hanged */
> > >> >       u8     duplex;
> > >> >@@ -568,6 +570,14 @@ static inline void bond_set_slave_inactive_fla=
gs(struct slave *slave,
> > >> >               bond_set_slave_state(slave, BOND_STATE_BACKUP, notif=
y);
> > >> >       if (!slave->bond->params.all_slaves_active)
> > >> >               slave->inactive =3D 1;
> > >> >+      if (BOND_MODE(slave->bond) =3D=3D BOND_MODE_8023AD)
> > >> >+              slave->rx_disabled =3D 1;
> > >> >+}
> > >> >+
> > >> >+static inline void bond_set_slave_tx_disabled_flags(struct slave *=
slave,
> > >> >+                                               bool notify)
> > >> >+{
> > >> >+      bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
> > >> > }
> > >> >
> > >> > static inline void bond_set_slave_active_flags(struct slave *slave=
,
> > >> >@@ -575,6 +585,14 @@ static inline void bond_set_slave_active_flags=
(struct slave *slave,
> > >> > {
> > >> >       bond_set_slave_state(slave, BOND_STATE_ACTIVE, notify);
> > >> >       slave->inactive =3D 0;
> > >> >+      if (BOND_MODE(slave->bond) =3D=3D BOND_MODE_8023AD)
> > >> >+              slave->rx_disabled =3D 0;
> > >> >+}
> > >> >+
> > >> >+static inline void bond_set_slave_rx_enabled_flags(struct slave *s=
lave,
> > >> >+                                             bool notify)
> > >> >+{
> > >> >+      slave->rx_disabled =3D 0;
> > >> > }
> > >> >
> > >> > static inline bool bond_is_slave_inactive(struct slave *slave)
> > >> >@@ -582,6 +600,11 @@ static inline bool bond_is_slave_inactive(stru=
ct slave *slave)
> > >> >       return slave->inactive;
> > >> > }
> > >> >
> > >> >+static inline bool bond_is_slave_rx_disabled(struct slave *slave)
> > >> >+{
> > >> >+      return slave->rx_disabled;
> > >> >+}
> > >> >+
> > >> > static inline void bond_propose_link_state(struct slave *slave, in=
t state)
> > >> > {
> > >> >       slave->link_new_state =3D state;
> > >> >diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_l=
ink.h
> > >> >index 29ff80da2775..7a54fcff2eec 100644
> > >> >--- a/include/uapi/linux/if_link.h
> > >> >+++ b/include/uapi/linux/if_link.h
> > >> >@@ -976,6 +976,7 @@ enum {
> > >> >       IFLA_BOND_AD_LACP_ACTIVE,
> > >> >       IFLA_BOND_MISSED_MAX,
> > >> >       IFLA_BOND_NS_IP6_TARGET,
> > >> >+      IFLA_BOND_COUPLED_CONTROL,
> > >> >       __IFLA_BOND_MAX,
> > >> > };
> > >> >
> > >> >diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uap=
i/linux/if_link.h
> > >> >index a0aa05a28cf2..f0d71b2a3f1e 100644
> > >> >--- a/tools/include/uapi/linux/if_link.h
> > >> >+++ b/tools/include/uapi/linux/if_link.h
> > >> >@@ -974,6 +974,7 @@ enum {
> > >> >       IFLA_BOND_AD_LACP_ACTIVE,
> > >> >       IFLA_BOND_MISSED_MAX,
> > >> >       IFLA_BOND_NS_IP6_TARGET,
> > >> >+      IFLA_BOND_COUPLED_CONTROL,
> > >> >       __IFLA_BOND_MAX,
> > >> > };
> > >> >
> > >> >--
> > >> >2.43.0.429.g432eaa2c6b-goog
> > >> >
> > >> >
> >
> > ---
> >         -Jay Vosburgh, jay.vosburgh@canonical.com

