Return-Path: <linux-kernel+bounces-113597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC7D888598
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDA91F2408F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363621CD637;
	Sun, 24 Mar 2024 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+R09BbD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454311CD61A;
	Sun, 24 Mar 2024 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320400; cv=none; b=jDiiXCXRqp726UvfH9jZSYyGIhw2rJjf/apyz438L9GP6Sl9CU2kJYQToWtCgBjTU9k3VExi6eKA0tufz+L3lEnwpzdsCdqDmnM39RMKPc0TzINjdnLehpF3ofOvP/p4mFqXdKVR1SicB00q10Cke+/c7rXN7bA490z7MZVnHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320400; c=relaxed/simple;
	bh=/yGu9VbczJuWFAYJ9lPv7pDz8h7g7UTH4iXjJWm+pOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2tpHXsLQg3q0tlkqv2CYQahraSosXvnLvKAxhJ7ik5euRYCpBczM0nSUiKqHhkuKM/0eMvCog2b+qdyHkpoq3QilWtu+UFvS4d0YSFH9S1v2LPQzn25tzAepCatx1b/URX/UM0RogoKKJfIQu7GvzndfRxuc/8S8JzL0/pk2x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+R09BbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A3BC43601;
	Sun, 24 Mar 2024 22:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320400;
	bh=/yGu9VbczJuWFAYJ9lPv7pDz8h7g7UTH4iXjJWm+pOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+R09BbDb+MVXzlYd2ofZw3S4eAdiptmdo5tjh+M3oTlE/FA6ZFndhXxGqkHoicKK
	 N6uDYkAx1V+/RQ3N0+be2q7xa5LutpRgofQeFZUygZLwtKe0KizcMW4WqI1vKY4tvH
	 7Hfg4AEy4ZVIFCvfPtolVWxwNApbhce6xV3zhOKYbNe1oxY/WG7Tr8fVeHbLpFLiHi
	 RQGHf9dP3808CG9meNp4jcJRY3ZN9nNWONFL9tbpfdcf9+ax1PE520Kp6eTsevLOA0
	 t6p7vauBcF2Zo7I6e2+yEOT3USjtUZ8pdK+7Mi9B5AoPh51wXq+s3PKGpTfUIv5kWe
	 F5l3be/c5DFDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 706/715] net: dsa: mt7530: fix link-local frames that ingress vlan filtering ports
Date: Sun, 24 Mar 2024 18:34:45 -0400
Message-ID: <20240324223455.1342824-707-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arınç ÜNAL <arinc.unal@arinc9.com>

[ Upstream commit e8bf353577f382c7066c661fed41b2adc0fc7c40 ]

Whether VLAN-aware or not, on every VID VLAN table entry that has the CPU
port as a member of it, frames are set to egress the CPU port with the VLAN
tag stacked. This is so that VLAN tags can be appended after hardware
special tag (called DSA tag in the context of Linux drivers).

For user ports on a VLAN-unaware bridge, frame ingressing the user port
egresses CPU port with only the special tag.

For user ports on a VLAN-aware bridge, frame ingressing the user port
egresses CPU port with the special tag and the VLAN tag.

This causes issues with link-local frames, specifically BPDUs, because the
software expects to receive them VLAN-untagged.

There are two options to make link-local frames egress untagged. Setting
CONSISTENT or UNTAGGED on the EG_TAG bits on the relevant register.
CONSISTENT means frames egress exactly as they ingress. That means
egressing with the VLAN tag they had at ingress or egressing untagged if
they ingressed untagged. Although link-local frames are not supposed to be
transmitted VLAN-tagged, if they are done so, when egressing through a CPU
port, the special tag field will be broken.

BPDU egresses CPU port with VLAN tag egressing stacked, received on
software:

00:01:25.104821 AF Unknown (382365846), length 106:
                                     | STAG  | | VLAN  |
        0x0000:  0000 6c27 614d 4143 0001 0000 8100 0001  ..l'aMAC........
        0x0010:  0026 4242 0300 0000 0000 0000 6c27 614d  .&BB........l'aM
        0x0020:  4143 0000 0000 0000 6c27 614d 4143 0000  AC......l'aMAC..
        0x0030:  0000 1400 0200 0f00 0000 0000 0000 0000  ................

BPDU egresses CPU port with VLAN tag egressing untagged, received on
software:

00:23:56.628708 AF Unknown (25215488), length 64:
                                     | STAG  |
        0x0000:  0000 6c27 614d 4143 0001 0000 0026 4242  ..l'aMAC.....&BB
        0x0010:  0300 0000 0000 0000 6c27 614d 4143 0000  ........l'aMAC..
        0x0020:  0000 0000 6c27 614d 4143 0000 0000 1400  ....l'aMAC......
        0x0030:  0200 0f00 0000 0000 0000 0000            ............

BPDU egresses CPU port with VLAN tag egressing tagged, received on
software:

00:01:34.311963 AF Unknown (25215488), length 64:
                                     | Mess  |
        0x0000:  0000 6c27 614d 4143 0001 0001 0026 4242  ..l'aMAC.....&BB
        0x0010:  0300 0000 0000 0000 6c27 614d 4143 0000  ........l'aMAC..
        0x0020:  0000 0000 6c27 614d 4143 0000 0000 1400  ....l'aMAC......
        0x0030:  0200 0f00 0000 0000 0000 0000            ............

To prevent confusing the software, force the frame to egress UNTAGGED
instead of CONSISTENT. This way, frames can't possibly be received TAGGED
by software which would have the special tag field broken.

VLAN Tag Egress Procedure

   For all frames, one of these options set the earliest in this order will
   apply to the frame:

   - EG_TAG in certain registers for certain frames.
     This will apply to frame with matching MAC DA or EtherType.

   - EG_TAG in the address table.
     This will apply to frame at its incoming port.

   - EG_TAG in the PVC register.
     This will apply to frame at its incoming port.

   - EG_CON and [EG_TAG per port] in the VLAN table.
     This will apply to frame at its outgoing port.

   - EG_TAG in the PCR register.
     This will apply to frame at its outgoing port.

   EG_TAG in certain registers for certain frames:

   PPPoE Discovery_ARP/RARP: PPP_EG_TAG and ARP_EG_TAG in the APC register.
   IGMP_MLD: IGMP_EG_TAG and MLD_EG_TAG in the IMC register.
   BPDU and PAE: BPDU_EG_TAG and PAE_EG_TAG in the BPC register.
   REV_01 and REV_02: R01_EG_TAG and R02_EG_TAG in the RGAC1 register.
   REV_03 and REV_0E: R03_EG_TAG and R0E_EG_TAG in the RGAC2 register.
   REV_10 and REV_20: R10_EG_TAG and R20_EG_TAG in the RGAC3 register.
   REV_21 and REV_UN: R21_EG_TAG and RUN_EG_TAG in the RGAC4 register.

With this change, it can be observed that a bridge interface with stp_state
and vlan_filtering enabled will properly block ports now.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 23 +++++++++++++++--------
 drivers/net/dsa/mt7530.h |  9 ++++++++-
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 9c9a592c053ed..ae39d669d30ce 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1001,16 +1001,23 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 static void
 mt753x_trap_frames(struct mt7530_priv *priv)
 {
-	/* Trap BPDUs to the CPU port(s) */
-	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
+	/* Trap 802.1X PAE frames and BPDUs to the CPU port(s) and egress them
+	 * VLAN-untagged.
+	 */
+	mt7530_rmw(priv, MT753X_BPC, MT753X_PAE_EG_TAG_MASK |
+		   MT753X_PAE_PORT_FW_MASK | MT753X_BPDU_EG_TAG_MASK |
+		   MT753X_BPDU_PORT_FW_MASK,
+		   MT753X_PAE_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   MT753X_PAE_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+		   MT753X_BPDU_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
 		   MT753X_BPDU_CPU_ONLY);
 
-	/* Trap 802.1X PAE frames to the CPU port(s) */
-	mt7530_rmw(priv, MT753X_BPC, MT753X_PAE_PORT_FW_MASK,
-		   MT753X_PAE_PORT_FW(MT753X_BPDU_CPU_ONLY));
-
-	/* Trap LLDP frames with :0E MAC DA to the CPU port(s) */
-	mt7530_rmw(priv, MT753X_RGAC2, MT753X_R0E_PORT_FW_MASK,
+	/* Trap LLDP frames with :0E MAC DA to the CPU port(s) and egress them
+	 * VLAN-untagged.
+	 */
+	mt7530_rmw(priv, MT753X_RGAC2, MT753X_R0E_EG_TAG_MASK |
+		   MT753X_R0E_PORT_FW_MASK,
+		   MT753X_R0E_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
 		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY));
 }
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 17e42d30fff4b..cef2af3f24d58 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -65,12 +65,18 @@ enum mt753x_id {
 
 /* Registers for BPDU and PAE frame control*/
 #define MT753X_BPC			0x24
-#define  MT753X_BPDU_PORT_FW_MASK	GENMASK(2, 0)
+#define  MT753X_PAE_EG_TAG_MASK		GENMASK(24, 22)
+#define  MT753X_PAE_EG_TAG(x)		FIELD_PREP(MT753X_PAE_EG_TAG_MASK, x)
 #define  MT753X_PAE_PORT_FW_MASK	GENMASK(18, 16)
 #define  MT753X_PAE_PORT_FW(x)		FIELD_PREP(MT753X_PAE_PORT_FW_MASK, x)
+#define  MT753X_BPDU_EG_TAG_MASK	GENMASK(8, 6)
+#define  MT753X_BPDU_EG_TAG(x)		FIELD_PREP(MT753X_BPDU_EG_TAG_MASK, x)
+#define  MT753X_BPDU_PORT_FW_MASK	GENMASK(2, 0)
 
 /* Register for :03 and :0E MAC DA frame control */
 #define MT753X_RGAC2			0x2c
+#define  MT753X_R0E_EG_TAG_MASK		GENMASK(24, 22)
+#define  MT753X_R0E_EG_TAG(x)		FIELD_PREP(MT753X_R0E_EG_TAG_MASK, x)
 #define  MT753X_R0E_PORT_FW_MASK	GENMASK(18, 16)
 #define  MT753X_R0E_PORT_FW(x)		FIELD_PREP(MT753X_R0E_PORT_FW_MASK, x)
 
@@ -253,6 +259,7 @@ enum mt7530_port_mode {
 enum mt7530_vlan_port_eg_tag {
 	MT7530_VLAN_EG_DISABLED = 0,
 	MT7530_VLAN_EG_CONSISTENT = 1,
+	MT7530_VLAN_EG_UNTAGGED = 4,
 };
 
 enum mt7530_vlan_port_attr {
-- 
2.43.0


