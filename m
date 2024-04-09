Return-Path: <linux-kernel+bounces-137147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5789DD93
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEBD28D368
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2FD12FF99;
	Tue,  9 Apr 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKiQvibS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E1613118D;
	Tue,  9 Apr 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674884; cv=none; b=IroK1//Pex9z6LPuQz24HuuIwaMe2/GGjzoKsw4pkxFsSkBpt5XT/uSqZg25WFuY6wrh/SRsS4D1BqxmGJ08ifW+AZUQEQVYuhoqqH2IoWIC48rNZ3NOvpc5QRGh0RwEIBrCZn2gmnHsyuqv/q+2PJ/sg1Qix3DxzLZklX5fMzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674884; c=relaxed/simple;
	bh=B4ew2Qkt0jyTjmfuReVOB8iNkVJ1pQBfZZbnCGpT7PY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DAx9VQpKhElwDsopOl2E7FCyqiWspWTd/kDY67ci1b5I6rp/GP5ynbOOAx47SxLGmJaWVQ/Jkv1Ata7RdkLO8L/Q+JwZ3D59gGNfT0+Yckmi9JGH9xtJgRntna1aIFi2XJenvX5tDEK7wfr/8KNw9AIdDL18C+LTb4z0iI6/c3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKiQvibS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7DC9C433F1;
	Tue,  9 Apr 2024 15:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712674884;
	bh=B4ew2Qkt0jyTjmfuReVOB8iNkVJ1pQBfZZbnCGpT7PY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=pKiQvibSSbQkiG7OkgG37INCkqJdmlZosElvVr2pnuiDj/GGZit6qi39up/MHsgBK
	 XdN1HO+YqOHqXDlW9c8Iki4gnkZeQ/SinVgURlzBl5a/BOOEEW/FCZ4oT/yzYxvcL5
	 vuFMVH5qVHbJpzgWsTWBn9mEsywD2DIWH+GE8S7JRE+fAvgQiR6Wpvqap11y7FFUUN
	 5LmsP6I2ryVIF5WXUsMkk37BAuY59ppFR9NFYew0RVpo38ESiSqp/bkvGbtnmAO20T
	 ZMVdgIxzOte0w0KQtnnn5bASGnyng3vLn91/nrVeVpb881Qv4jWT1hv2wMvUbLH+RQ
	 ulusI2bQaEAyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD83CD128A;
	Tue,  9 Apr 2024 15:01:23 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Tue, 09 Apr 2024 18:01:14 +0300
Subject: [PATCH net v2] net: dsa: mt7530: trap link-local frames regardless
 of ST Port State
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240409-b4-for-net-mt7530-fix-link-local-when-stp-discarding-v2-1-07b1150164ac@arinc9.com>
X-B4-Tracking: v=1; b=H4sIADlYFWYC/52OQQ6CMBREr0L+2m9KKSCuvIdhUcoHfoSWtAQ1h
 LtbiSdwOTOZebNBIM8U4Jps4GnlwM5GIU8JmEHbnpDbqEEKqYQSKTYKO+fR0oLTUuaZwI5fOLJ
 94OiMHvE5kMWwzNhyMNq3bHssSGpFGV2KUkOcnj3F1oG9Q5yCOpoDh8X593FlTY/oRy3/o64pf
 v82UmhTZSovb9qzNdXZuAnqfd8/mR9ayf4AAAA=
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712674879; l=25758;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=4hvAXxPZPZ3ZX21lHhBrmf2ehXeho17xrQz23bl6zJk=;
 b=T9GVXfpwu8JF3OQRNrxTufxkqb084/jRWBn96rT+CkkIWIXImwTeXdpnds4Mnzk1/gHTddX3Y
 w8cUbQZClxeC/eGGUxhYRNAtx6V3UixyGjgIoSf31EaR6ht+kZAbF56
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

In Clause 5 of IEEE Std 802-2014, two sublayers of the data link layer
(DLL) of the Open Systems Interconnection basic reference model (OSI/RM)
are described; the medium access control (MAC) and logical link control
(LLC) sublayers. The MAC sublayer is the one facing the physical layer.

In 8.2 of IEEE Std 802.1Q-2022, the Bridge architecture is described. A
Bridge component comprises a MAC Relay Entity for interconnecting the Ports
of the Bridge, at least two Ports, and higher layer entities with at least
a Spanning Tree Protocol Entity included.

Each Bridge Port also functions as an end station and shall provide the MAC
Service to an LLC Entity. Each instance of the MAC Service is provided to a
distinct LLC Entity that supports protocol identification, multiplexing,
and demultiplexing, for protocol data unit (PDU) transmission and reception
by one or more higher layer entities.

It is described in 8.13.9 of IEEE Std 802.1Q-2022 that in a Bridge, the LLC
Entity associated with each Bridge Port is modeled as being directly
connected to the attached Local Area Network (LAN).

On the switch with CPU port architecture, CPU port functions as Management
Port, and the Management Port functionality is provided by software which
functions as an end station. Software is connected to an IEEE 802 LAN that
is wholly contained within the system that incorporates the Bridge.
Software provides access to the LLC Entity associated with each Bridge Port
by the value of the source port field on the special tag on the frame
received by software.

We call frames that carry control information to determine the active
topology and current extent of each Virtual Local Area Network (VLAN),
i.e., spanning tree or Shortest Path Bridging (SPB) and Multiple VLAN
Registration Protocol Data Units (MVRPDUs), and frames from other link
constrained protocols, such as Extensible Authentication Protocol over LAN
(EAPOL) and Link Layer Discovery Protocol (LLDP), link-local frames. They
are not forwarded by a Bridge. Permanently configured entries in the
filtering database (FDB) ensure that such frames are discarded by the
Forwarding Process. In 8.6.3 of IEEE Std 802.1Q-2022, this is described in
detail:

Each of the reserved MAC addresses specified in Table 8-1
(01-80-C2-00-00-[00,01,02,03,04,05,06,07,08,09,0A,0B,0C,0D,0E,0F]) shall be
permanently configured in the FDB in C-VLAN components and ERs.

Each of the reserved MAC addresses specified in Table 8-2
(01-80-C2-00-00-[01,02,03,04,05,06,07,08,09,0A,0E]) shall be permanently
configured in the FDB in S-VLAN components.

Each of the reserved MAC addresses specified in Table 8-3
(01-80-C2-00-00-[01,02,04,0E]) shall be permanently configured in the FDB
in TPMR components.

The FDB entries for reserved MAC addresses shall specify filtering for all
Bridge Ports and all VIDs. Management shall not provide the capability to
modify or remove entries for reserved MAC addresses.

The addresses in Table 8-1, Table 8-2, and Table 8-3 determine the scope of
propagation of PDUs within a Bridged Network, as follows:

  The Nearest Bridge group address (01-80-C2-00-00-0E) is an address that
  no conformant Two-Port MAC Relay (TPMR) component, Service VLAN (S-VLAN)
  component, Customer VLAN (C-VLAN) component, or MAC Bridge can forward.
  PDUs transmitted using this destination address, or any other addresses
  that appear in Table 8-1, Table 8-2, and Table 8-3
  (01-80-C2-00-00-[00,01,02,03,04,05,06,07,08,09,0A,0B,0C,0D,0E,0F]), can
  therefore travel no further than those stations that can be reached via a
  single individual LAN from the originating station.

  The Nearest non-TPMR Bridge group address (01-80-C2-00-00-03), is an
  address that no conformant S-VLAN component, C-VLAN component, or MAC
  Bridge can forward; however, this address is relayed by a TPMR component.
  PDUs using this destination address, or any of the other addresses that
  appear in both Table 8-1 and Table 8-2 but not in Table 8-3
  (01-80-C2-00-00-[00,03,05,06,07,08,09,0A,0B,0C,0D,0F]), will be relayed
  by any TPMRs but will propagate no further than the nearest S-VLAN
  component, C-VLAN component, or MAC Bridge.

  The Nearest Customer Bridge group address (01-80-C2-00-00-00) is an
  address that no conformant C-VLAN component, MAC Bridge can forward;
  however, it is relayed by TPMR components and S-VLAN components. PDUs
  using this destination address, or any of the other addresses that appear
  in Table 8-1 but not in either Table 8-2 or Table 8-3
  (01-80-C2-00-00-[00,0B,0C,0D,0F]), will be relayed by TPMR components and
  S-VLAN components but will propagate no further than the nearest C-VLAN
  component or MAC Bridge.

Because the LLC Entity associated with each Bridge Port is provided via CPU
port, we must not filter these frames but forward them to CPU port.

In a Bridge, the transmission Port is majorly decided by ingress and egress
rules, FDB, and spanning tree Port State functions of the Forwarding
Process. For link-local frames, only CPU port should be designated as
destination port in the FDB, and the other functions of the Forwarding
Process must not interfere with the decision of the transmission Port. We
call this process trapping frames to CPU port.

Therefore, on the switch with CPU port architecture, link-local frames must
be trapped to CPU port, and certain link-local frames received by a Port of
a Bridge comprising a TPMR component or an S-VLAN component must be
excluded from it.

A Bridge of the switch with CPU port architecture cannot comprise a
Two-Port MAC Relay (TPMR) component as a TPMR component supports only a
subset of the functionality of a MAC Bridge. A Bridge comprising two Ports
(Management Port doesn't count) of this architecture will either function
as a standard MAC Bridge or a standard VLAN Bridge.

Therefore, a Bridge of this architecture can only comprise S-VLAN
components, C-VLAN components, or MAC Bridge components. Since there's no
TPMR component, we don't need to relay PDUs using the destination addresses
specified on the Nearest non-TPMR section, and the proportion of the
Nearest Customer Bridge section where they must be relayed by TPMR
components.

One option to trap link-local frames to CPU port is to add static FDB
entries with CPU port designated as destination port. However, because that
Independent VLAN Learning (IVL) is being used on every VID, each entry only
applies to a single VLAN Identifier (VID). For a Bridge comprising a MAC
Bridge component or a C-VLAN component, there would have to be 16 times
4096 entries. This switch intellectual property can only hold a maximum of
2048 entries. Using this option, there also isn't a mechanism to prevent
link-local frames from being discarded when the spanning tree Port State of
the reception Port is discarding.

The remaining option is to utilise the BPC, RGAC1, RGAC2, RGAC3, and RGAC4
registers. Whilst this applies to every VID, it doesn't contain all of the
reserved MAC addresses without affecting the remaining Standard Group MAC
Addresses. The REV_UN frame tag utilised using the RGAC4 register covers
the remaining 01-80-C2-00-00-[04,05,06,07,08,09,0A,0B,0C,0D,0F] destination
addresses. It also includes the 01-80-C2-00-00-22 to 01-80-C2-00-00-FF
destination addresses which may be relayed by MAC Bridges or VLAN Bridges.
The latter option provides better but not complete conformance.

This switch intellectual property also does not provide a mechanism to trap
link-local frames with specific destination addresses to CPU port by
Bridge, to conform to the filtering rules for the distinct Bridge
components.

Therefore, regardless of the type of the Bridge component, link-local
frames with these destination addresses will be trapped to CPU port:

01-80-C2-00-00-[00,01,02,03,0E]

In a Bridge comprising a MAC Bridge component or a C-VLAN component:

  Link-local frames with these destination addresses won't be trapped to
  CPU port which won't conform to IEEE Std 802.1Q-2022:

  01-80-C2-00-00-[04,05,06,07,08,09,0A,0B,0C,0D,0F]

In a Bridge comprising an S-VLAN component:

  Link-local frames with these destination addresses will be trapped to CPU
  port which won't conform to IEEE Std 802.1Q-2022:

  01-80-C2-00-00-00

  Link-local frames with these destination addresses won't be trapped to
  CPU port which won't conform to IEEE Std 802.1Q-2022:

  01-80-C2-00-00-[04,05,06,07,08,09,0A]

Currently on this switch intellectual property, if the spanning tree Port
State of the reception Port is discarding, link-local frames will be
discarded.

To trap link-local frames regardless of the spanning tree Port State, make
the switch regard them as Bridge Protocol Data Units (BPDUs). This switch
intellectual property only lets the frames regarded as BPDUs bypass the
spanning tree Port State function of the Forwarding Process.

With this change, the only remaining interference is the ingress rules.
When the reception Port has no PVID assigned on software, VLAN-untagged
frames won't be allowed in. There doesn't seem to be a mechanism on the
switch intellectual property to have link-local frames bypass this function
of the Forwarding Process.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Changes in v2:
- Add a Fixes: trailer.
- Slightly adjust the patch log and the comment section.
- Link to v1: https://lore.kernel.org/r/20240407-b4-for-net-mt7530-fix-link-local-when-stp-discarding-v1-1-b4b20ac93457@arinc9.com
---
 drivers/net/dsa/mt7530.c | 229 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/net/dsa/mt7530.h |   5 ++
 2 files changed, 200 insertions(+), 34 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 1035820c2377..fd62b38ae913 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -950,20 +950,173 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 	mutex_unlock(&priv->reg_mutex);
 }
 
-/* On page 205, section "8.6.3 Frame filtering" of the active standard, IEEE Std
- * 802.1Q™-2022, it is stated that frames with 01:80:C2:00:00:00-0F as MAC DA
- * must only be propagated to C-VLAN and MAC Bridge components. That means
- * VLAN-aware and VLAN-unaware bridges. On the switch designs with CPU ports,
- * these frames are supposed to be processed by the CPU (software). So we make
- * the switch only forward them to the CPU port. And if received from a CPU
- * port, forward to a single port. The software is responsible of making the
- * switch conform to the latter by setting a single port as destination port on
- * the special tag.
+/* In Clause 5 of IEEE Std 802-2014, two sublayers of the data link layer (DLL)
+ * of the Open Systems Interconnection basic reference model (OSI/RM) are
+ * described; the medium access control (MAC) and logical link control (LLC)
+ * sublayers. The MAC sublayer is the one facing the physical layer.
  *
- * This switch intellectual property cannot conform to this part of the standard
- * fully. Whilst the REV_UN frame tag covers the remaining :04-0D and :0F MAC
- * DAs, it also includes :22-FF which the scope of propagation is not supposed
- * to be restricted for these MAC DAs.
+ * In 8.2 of IEEE Std 802.1Q-2022, the Bridge architecture is described. A
+ * Bridge component comprises a MAC Relay Entity for interconnecting the Ports
+ * of the Bridge, at least two Ports, and higher layer entities with at least a
+ * Spanning Tree Protocol Entity included.
+ *
+ * Each Bridge Port also functions as an end station and shall provide the MAC
+ * Service to an LLC Entity. Each instance of the MAC Service is provided to a
+ * distinct LLC Entity that supports protocol identification, multiplexing, and
+ * demultiplexing, for protocol data unit (PDU) transmission and reception by
+ * one or more higher layer entities.
+ *
+ * It is described in 8.13.9 of IEEE Std 802.1Q-2022 that in a Bridge, the LLC
+ * Entity associated with each Bridge Port is modeled as being directly
+ * connected to the attached Local Area Network (LAN).
+ *
+ * On the switch with CPU port architecture, CPU port functions as Management
+ * Port, and the Management Port functionality is provided by software which
+ * functions as an end station. Software is connected to an IEEE 802 LAN that is
+ * wholly contained within the system that incorporates the Bridge. Software
+ * provides access to the LLC Entity associated with each Bridge Port by the
+ * value of the source port field on the special tag on the frame received by
+ * software.
+ *
+ * We call frames that carry control information to determine the active
+ * topology and current extent of each Virtual Local Area Network (VLAN), i.e.,
+ * spanning tree or Shortest Path Bridging (SPB) and Multiple VLAN Registration
+ * Protocol Data Units (MVRPDUs), and frames from other link constrained
+ * protocols, such as Extensible Authentication Protocol over LAN (EAPOL) and
+ * Link Layer Discovery Protocol (LLDP), link-local frames. They are not
+ * forwarded by a Bridge. Permanently configured entries in the filtering
+ * database (FDB) ensure that such frames are discarded by the Forwarding
+ * Process. In 8.6.3 of IEEE Std 802.1Q-2022, this is described in detail:
+ *
+ * Each of the reserved MAC addresses specified in Table 8-1
+ * (01-80-C2-00-00-[00,01,02,03,04,05,06,07,08,09,0A,0B,0C,0D,0E,0F]) shall be
+ * permanently configured in the FDB in C-VLAN components and ERs.
+ *
+ * Each of the reserved MAC addresses specified in Table 8-2
+ * (01-80-C2-00-00-[01,02,03,04,05,06,07,08,09,0A,0E]) shall be permanently
+ * configured in the FDB in S-VLAN components.
+ *
+ * Each of the reserved MAC addresses specified in Table 8-3
+ * (01-80-C2-00-00-[01,02,04,0E]) shall be permanently configured in the FDB in
+ * TPMR components.
+ *
+ * The FDB entries for reserved MAC addresses shall specify filtering for all
+ * Bridge Ports and all VIDs. Management shall not provide the capability to
+ * modify or remove entries for reserved MAC addresses.
+ *
+ * The addresses in Table 8-1, Table 8-2, and Table 8-3 determine the scope of
+ * propagation of PDUs within a Bridged Network, as follows:
+ *
+ *   The Nearest Bridge group address (01-80-C2-00-00-0E) is an address that no
+ *   conformant Two-Port MAC Relay (TPMR) component, Service VLAN (S-VLAN)
+ *   component, Customer VLAN (C-VLAN) component, or MAC Bridge can forward.
+ *   PDUs transmitted using this destination address, or any other addresses
+ *   that appear in Table 8-1, Table 8-2, and Table 8-3
+ *   (01-80-C2-00-00-[00,01,02,03,04,05,06,07,08,09,0A,0B,0C,0D,0E,0F]), can
+ *   therefore travel no further than those stations that can be reached via a
+ *   single individual LAN from the originating station.
+ *
+ *   The Nearest non-TPMR Bridge group address (01-80-C2-00-00-03), is an
+ *   address that no conformant S-VLAN component, C-VLAN component, or MAC
+ *   Bridge can forward; however, this address is relayed by a TPMR component.
+ *   PDUs using this destination address, or any of the other addresses that
+ *   appear in both Table 8-1 and Table 8-2 but not in Table 8-3
+ *   (01-80-C2-00-00-[00,03,05,06,07,08,09,0A,0B,0C,0D,0F]), will be relayed by
+ *   any TPMRs but will propagate no further than the nearest S-VLAN component,
+ *   C-VLAN component, or MAC Bridge.
+ *
+ *   The Nearest Customer Bridge group address (01-80-C2-00-00-00) is an address
+ *   that no conformant C-VLAN component, MAC Bridge can forward; however, it is
+ *   relayed by TPMR components and S-VLAN components. PDUs using this
+ *   destination address, or any of the other addresses that appear in Table 8-1
+ *   but not in either Table 8-2 or Table 8-3 (01-80-C2-00-00-[00,0B,0C,0D,0F]),
+ *   will be relayed by TPMR components and S-VLAN components but will propagate
+ *   no further than the nearest C-VLAN component or MAC Bridge.
+ *
+ * Because the LLC Entity associated with each Bridge Port is provided via CPU
+ * port, we must not filter these frames but forward them to CPU port.
+ *
+ * In a Bridge, the transmission Port is majorly decided by ingress and egress
+ * rules, FDB, and spanning tree Port State functions of the Forwarding Process.
+ * For link-local frames, only CPU port should be designated as destination port
+ * in the FDB, and the other functions of the Forwarding Process must not
+ * interfere with the decision of the transmission Port. We call this process
+ * trapping frames to CPU port.
+ *
+ * Therefore, on the switch with CPU port architecture, link-local frames must
+ * be trapped to CPU port, and certain link-local frames received by a Port of a
+ * Bridge comprising a TPMR component or an S-VLAN component must be excluded
+ * from it.
+ *
+ * A Bridge of the switch with CPU port architecture cannot comprise a Two-Port
+ * MAC Relay (TPMR) component as a TPMR component supports only a subset of the
+ * functionality of a MAC Bridge. A Bridge comprising two Ports (Management Port
+ * doesn't count) of this architecture will either function as a standard MAC
+ * Bridge or a standard VLAN Bridge.
+ *
+ * Therefore, a Bridge of this architecture can only comprise S-VLAN components,
+ * C-VLAN components, or MAC Bridge components. Since there's no TPMR component,
+ * we don't need to relay PDUs using the destination addresses specified on the
+ * Nearest non-TPMR section, and the proportion of the Nearest Customer Bridge
+ * section where they must be relayed by TPMR components.
+ *
+ * One option to trap link-local frames to CPU port is to add static FDB entries
+ * with CPU port designated as destination port. However, because that
+ * Independent VLAN Learning (IVL) is being used on every VID, each entry only
+ * applies to a single VLAN Identifier (VID). For a Bridge comprising a MAC
+ * Bridge component or a C-VLAN component, there would have to be 16 times 4096
+ * entries. This switch intellectual property can only hold a maximum of 2048
+ * entries. Using this option, there also isn't a mechanism to prevent
+ * link-local frames from being discarded when the spanning tree Port State of
+ * the reception Port is discarding.
+ *
+ * The remaining option is to utilise the BPC, RGAC1, RGAC2, RGAC3, and RGAC4
+ * registers. Whilst this applies to every VID, it doesn't contain all of the
+ * reserved MAC addresses without affecting the remaining Standard Group MAC
+ * Addresses. The REV_UN frame tag utilised using the RGAC4 register covers the
+ * remaining 01-80-C2-00-00-[04,05,06,07,08,09,0A,0B,0C,0D,0F] destination
+ * addresses. It also includes the 01-80-C2-00-00-22 to 01-80-C2-00-00-FF
+ * destination addresses which may be relayed by MAC Bridges or VLAN Bridges.
+ * The latter option provides better but not complete conformance.
+ *
+ * This switch intellectual property also does not provide a mechanism to trap
+ * link-local frames with specific destination addresses to CPU port by Bridge,
+ * to conform to the filtering rules for the distinct Bridge components.
+ *
+ * Therefore, regardless of the type of the Bridge component, link-local frames
+ * with these destination addresses will be trapped to CPU port:
+ *
+ * 01-80-C2-00-00-[00,01,02,03,0E]
+ *
+ * In a Bridge comprising a MAC Bridge component or a C-VLAN component:
+ *
+ *   Link-local frames with these destination addresses won't be trapped to CPU
+ *   port which won't conform to IEEE Std 802.1Q-2022:
+ *
+ *   01-80-C2-00-00-[04,05,06,07,08,09,0A,0B,0C,0D,0F]
+ *
+ * In a Bridge comprising an S-VLAN component:
+ *
+ *   Link-local frames with these destination addresses will be trapped to CPU
+ *   port which won't conform to IEEE Std 802.1Q-2022:
+ *
+ *   01-80-C2-00-00-00
+ *
+ *   Link-local frames with these destination addresses won't be trapped to CPU
+ *   port which won't conform to IEEE Std 802.1Q-2022:
+ *
+ *   01-80-C2-00-00-[04,05,06,07,08,09,0A]
+ *
+ * To trap link-local frames to CPU port as conformant as this switch
+ * intellectual property can allow, link-local frames are made to be regarded as
+ * Bridge Protocol Data Units (BPDUs). This is because this switch intellectual
+ * property only lets the frames regarded as BPDUs bypass the spanning tree Port
+ * State function of the Forwarding Process.
+ *
+ * The only remaining interference is the ingress rules. When the reception Port
+ * has no PVID assigned on software, VLAN-untagged frames won't be allowed in.
+ * There doesn't seem to be a mechanism on the switch intellectual property to
+ * have link-local frames bypass this function of the Forwarding Process.
  */
 static void
 mt753x_trap_frames(struct mt7530_priv *priv)
@@ -971,35 +1124,43 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 	/* Trap 802.1X PAE frames and BPDUs to the CPU port(s) and egress them
 	 * VLAN-untagged.
 	 */
-	mt7530_rmw(priv, MT753X_BPC, MT753X_PAE_EG_TAG_MASK |
-		   MT753X_PAE_PORT_FW_MASK | MT753X_BPDU_EG_TAG_MASK |
-		   MT753X_BPDU_PORT_FW_MASK,
-		   MT753X_PAE_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_PAE_PORT_FW(MT753X_BPDU_CPU_ONLY) |
-		   MT753X_BPDU_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_BPDU_CPU_ONLY);
+	mt7530_rmw(priv, MT753X_BPC,
+		   MT753X_PAE_BPDU_FR | MT753X_PAE_EG_TAG_MASK |
+			   MT753X_PAE_PORT_FW_MASK | MT753X_BPDU_EG_TAG_MASK |
+			   MT753X_BPDU_PORT_FW_MASK,
+		   MT753X_PAE_BPDU_FR |
+			   MT753X_PAE_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   MT753X_PAE_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+			   MT753X_BPDU_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   MT753X_BPDU_CPU_ONLY);
 
 	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and egress
 	 * them VLAN-untagged.
 	 */
-	mt7530_rmw(priv, MT753X_RGAC1, MT753X_R02_EG_TAG_MASK |
-		   MT753X_R02_PORT_FW_MASK | MT753X_R01_EG_TAG_MASK |
-		   MT753X_R01_PORT_FW_MASK,
-		   MT753X_R02_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_R02_PORT_FW(MT753X_BPDU_CPU_ONLY) |
-		   MT753X_R01_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_BPDU_CPU_ONLY);
+	mt7530_rmw(priv, MT753X_RGAC1,
+		   MT753X_R02_BPDU_FR | MT753X_R02_EG_TAG_MASK |
+			   MT753X_R02_PORT_FW_MASK | MT753X_R01_BPDU_FR |
+			   MT753X_R01_EG_TAG_MASK | MT753X_R01_PORT_FW_MASK,
+		   MT753X_R02_BPDU_FR |
+			   MT753X_R02_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   MT753X_R02_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+			   MT753X_R01_BPDU_FR |
+			   MT753X_R01_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   MT753X_BPDU_CPU_ONLY);
 
 	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and egress
 	 * them VLAN-untagged.
 	 */
-	mt7530_rmw(priv, MT753X_RGAC2, MT753X_R0E_EG_TAG_MASK |
-		   MT753X_R0E_PORT_FW_MASK | MT753X_R03_EG_TAG_MASK |
-		   MT753X_R03_PORT_FW_MASK,
-		   MT753X_R0E_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY) |
-		   MT753X_R03_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_BPDU_CPU_ONLY);
+	mt7530_rmw(priv, MT753X_RGAC2,
+		   MT753X_R0E_BPDU_FR | MT753X_R0E_EG_TAG_MASK |
+			   MT753X_R0E_PORT_FW_MASK | MT753X_R03_BPDU_FR |
+			   MT753X_R03_EG_TAG_MASK | MT753X_R03_PORT_FW_MASK,
+		   MT753X_R0E_BPDU_FR |
+			   MT753X_R0E_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+			   MT753X_R03_BPDU_FR |
+			   MT753X_R03_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   MT753X_BPDU_CPU_ONLY);
 }
 
 static void
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index d17b318e6ee4..2deffe741484 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -65,6 +65,7 @@ enum mt753x_id {
 
 /* Registers for BPDU and PAE frame control*/
 #define MT753X_BPC			0x24
+#define  MT753X_PAE_BPDU_FR		BIT(25)
 #define  MT753X_PAE_EG_TAG_MASK		GENMASK(24, 22)
 #define  MT753X_PAE_EG_TAG(x)		FIELD_PREP(MT753X_PAE_EG_TAG_MASK, x)
 #define  MT753X_PAE_PORT_FW_MASK	GENMASK(18, 16)
@@ -75,20 +76,24 @@ enum mt753x_id {
 
 /* Register for :01 and :02 MAC DA frame control */
 #define MT753X_RGAC1			0x28
+#define  MT753X_R02_BPDU_FR		BIT(25)
 #define  MT753X_R02_EG_TAG_MASK		GENMASK(24, 22)
 #define  MT753X_R02_EG_TAG(x)		FIELD_PREP(MT753X_R02_EG_TAG_MASK, x)
 #define  MT753X_R02_PORT_FW_MASK	GENMASK(18, 16)
 #define  MT753X_R02_PORT_FW(x)		FIELD_PREP(MT753X_R02_PORT_FW_MASK, x)
+#define  MT753X_R01_BPDU_FR		BIT(9)
 #define  MT753X_R01_EG_TAG_MASK		GENMASK(8, 6)
 #define  MT753X_R01_EG_TAG(x)		FIELD_PREP(MT753X_R01_EG_TAG_MASK, x)
 #define  MT753X_R01_PORT_FW_MASK	GENMASK(2, 0)
 
 /* Register for :03 and :0E MAC DA frame control */
 #define MT753X_RGAC2			0x2c
+#define  MT753X_R0E_BPDU_FR		BIT(25)
 #define  MT753X_R0E_EG_TAG_MASK		GENMASK(24, 22)
 #define  MT753X_R0E_EG_TAG(x)		FIELD_PREP(MT753X_R0E_EG_TAG_MASK, x)
 #define  MT753X_R0E_PORT_FW_MASK	GENMASK(18, 16)
 #define  MT753X_R0E_PORT_FW(x)		FIELD_PREP(MT753X_R0E_PORT_FW_MASK, x)
+#define  MT753X_R03_BPDU_FR		BIT(9)
 #define  MT753X_R03_EG_TAG_MASK		GENMASK(8, 6)
 #define  MT753X_R03_EG_TAG(x)		FIELD_PREP(MT753X_R03_EG_TAG_MASK, x)
 #define  MT753X_R03_PORT_FW_MASK	GENMASK(2, 0)

---
base-commit: 365af7ace014ef3fc6f5d0a373c96cc7193db4ce
change-id: 20240401-b4-for-net-mt7530-fix-link-local-when-stp-discarding-6e2a4e3e867a

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



