Return-Path: <linux-kernel+bounces-115584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419AD889CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E248B2A1D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0206342262;
	Mon, 25 Mar 2024 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDmanbIh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9DF14BFBB;
	Sun, 24 Mar 2024 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321143; cv=none; b=l/yEsCnyTTg3TPKa3h80LFpxhJIzql4SKonIzjM8+PbB7KwBxTgYoRG7g318HDvHnH0NHO9SR8Eo8S9iuuYBGfO7czrPJdv6jkmXmed7j/xhlSHc6aTOLe/WrynT3hshcZW5/3FugCYjJbOeuoj8u9yoPX08dVaoVlfWkTA5Oaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321143; c=relaxed/simple;
	bh=3vQoBjkWrEZW+KNq//2LOSBjgnvZ71cIKCXkbqSyVwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E25xtPQ/sN7bj2aaK3yWbMzT6Ewns2DFtzas98Tq86d1bsA+LP7xE17K5Gc8aPluzexQN4nqJkl7i4CXF0fRnYHf6Zzv4XOFvaa04baXtdpFNDXUDGGwdXiVJq7bIJnXntKLka7vexAe5yxfR6rKcG6A2SN6tft6EyTFg0ScIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDmanbIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFD0C433C7;
	Sun, 24 Mar 2024 22:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321143;
	bh=3vQoBjkWrEZW+KNq//2LOSBjgnvZ71cIKCXkbqSyVwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDmanbIh4bX7Aw5Fp/grWdbM+nILfMRLdsSabcH9cv7N8MGSo6lEhQ/Iq1ffrrlOT
	 kQ2vOcW9wbkU+YantJiz0GFIVgRCMiRC4+qu4jwLnG6bgjZt+6txkQf2FVUSrMi6+q
	 T+CEANcu0o82rGPhUEplZ1gOxpStf6Y0dRdv5zr8yB8nV/nmGJ7FDyjzIWo9ZyvbcP
	 QRF2atJtsQW/q9swFNA8ZRxrG5c14x8ReQe50Asu3toH2EpxQdY9zRTa+n8WzIi8zh
	 qr9Xq29E6ydPTz5L+0aBFFN0et9Ip3RR4l56TunZUi/YeP5mlHZFEG4H3NT5HK0kG7
	 nYxP1GlpJesCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 705/713] net: dsa: mt7530: fix handling of all link-local frames
Date: Sun, 24 Mar 2024 18:47:11 -0400
Message-ID: <20240324224720.1345309-706-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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

[ Upstream commit 69ddba9d170bdaee1dc0eb4ced38d7e4bb7b92af ]

Currently, the MT753X switches treat frames with :01-0D and :0F MAC DAs as
regular multicast frames, therefore flooding them to user ports.

On page 205, section "8.6.3 Frame filtering" of the active standard, IEEE
Std 802.1Q™-2022, it is stated that frames with 01:80:C2:00:00:00-0F as MAC
DA must only be propagated to C-VLAN and MAC Bridge components. That means
VLAN-aware and VLAN-unaware bridges. On the switch designs with CPU ports,
these frames are supposed to be processed by the CPU (software). So we make
the switch only forward them to the CPU port. And if received from a CPU
port, forward to a single port. The software is responsible of making the
switch conform to the latter by setting a single port as destination port
on the special tag.

This switch intellectual property cannot conform to this part of the
standard fully. Whilst the REV_UN frame tag covers the remaining :04-0D and
:0F MAC DAs, it also includes :22-FF which the scope of propagation is not
supposed to be restricted for these MAC DAs.

Set frames with :01-03 MAC DAs to be trapped to the CPU port(s). Add a
comment for the remaining MAC DAs.

Note that the ingress port must have a PVID assigned to it for the switch
to forward untagged frames. A PVID is set by default on VLAN-aware and
VLAN-unaware ports. However, when the network interface that pertains to
the ingress port is attached to a vlan_filtering enabled bridge, the user
can remove the PVID assignment from it which would prevent the link-local
frames from being trapped to the CPU port. I am yet to see a way to forward
link-local frames while preventing other untagged frames from being
forwarded too.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 37 +++++++++++++++++++++++++++++++++----
 drivers/net/dsa/mt7530.h | 13 +++++++++++++
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index f5b2535307652..e6b8bf6035565 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -998,6 +998,21 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 	mutex_unlock(&priv->reg_mutex);
 }
 
+/* On page 205, section "8.6.3 Frame filtering" of the active standard, IEEE Std
+ * 802.1Q™-2022, it is stated that frames with 01:80:C2:00:00:00-0F as MAC DA
+ * must only be propagated to C-VLAN and MAC Bridge components. That means
+ * VLAN-aware and VLAN-unaware bridges. On the switch designs with CPU ports,
+ * these frames are supposed to be processed by the CPU (software). So we make
+ * the switch only forward them to the CPU port. And if received from a CPU
+ * port, forward to a single port. The software is responsible of making the
+ * switch conform to the latter by setting a single port as destination port on
+ * the special tag.
+ *
+ * This switch intellectual property cannot conform to this part of the standard
+ * fully. Whilst the REV_UN frame tag covers the remaining :04-0D and :0F MAC
+ * DAs, it also includes :22-FF which the scope of propagation is not supposed
+ * to be restricted for these MAC DAs.
+ */
 static void
 mt753x_trap_frames(struct mt7530_priv *priv)
 {
@@ -1012,13 +1027,27 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 		   MT753X_BPDU_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
 		   MT753X_BPDU_CPU_ONLY);
 
-	/* Trap LLDP frames with :0E MAC DA to the CPU port(s) and egress them
-	 * VLAN-untagged.
+	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and egress
+	 * them VLAN-untagged.
+	 */
+	mt7530_rmw(priv, MT753X_RGAC1, MT753X_R02_EG_TAG_MASK |
+		   MT753X_R02_PORT_FW_MASK | MT753X_R01_EG_TAG_MASK |
+		   MT753X_R01_PORT_FW_MASK,
+		   MT753X_R02_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   MT753X_R02_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+		   MT753X_R01_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   MT753X_BPDU_CPU_ONLY);
+
+	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and egress
+	 * them VLAN-untagged.
 	 */
 	mt7530_rmw(priv, MT753X_RGAC2, MT753X_R0E_EG_TAG_MASK |
-		   MT753X_R0E_PORT_FW_MASK,
+		   MT753X_R0E_PORT_FW_MASK | MT753X_R03_EG_TAG_MASK |
+		   MT753X_R03_PORT_FW_MASK,
 		   MT753X_R0E_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY));
+		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+		   MT753X_R03_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   MT753X_BPDU_CPU_ONLY);
 }
 
 static int
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index cef2af3f24d58..75bc9043c8c0a 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -73,12 +73,25 @@ enum mt753x_id {
 #define  MT753X_BPDU_EG_TAG(x)		FIELD_PREP(MT753X_BPDU_EG_TAG_MASK, x)
 #define  MT753X_BPDU_PORT_FW_MASK	GENMASK(2, 0)
 
+/* Register for :01 and :02 MAC DA frame control */
+#define MT753X_RGAC1			0x28
+#define  MT753X_R02_EG_TAG_MASK		GENMASK(24, 22)
+#define  MT753X_R02_EG_TAG(x)		FIELD_PREP(MT753X_R02_EG_TAG_MASK, x)
+#define  MT753X_R02_PORT_FW_MASK	GENMASK(18, 16)
+#define  MT753X_R02_PORT_FW(x)		FIELD_PREP(MT753X_R02_PORT_FW_MASK, x)
+#define  MT753X_R01_EG_TAG_MASK		GENMASK(8, 6)
+#define  MT753X_R01_EG_TAG(x)		FIELD_PREP(MT753X_R01_EG_TAG_MASK, x)
+#define  MT753X_R01_PORT_FW_MASK	GENMASK(2, 0)
+
 /* Register for :03 and :0E MAC DA frame control */
 #define MT753X_RGAC2			0x2c
 #define  MT753X_R0E_EG_TAG_MASK		GENMASK(24, 22)
 #define  MT753X_R0E_EG_TAG(x)		FIELD_PREP(MT753X_R0E_EG_TAG_MASK, x)
 #define  MT753X_R0E_PORT_FW_MASK	GENMASK(18, 16)
 #define  MT753X_R0E_PORT_FW(x)		FIELD_PREP(MT753X_R0E_PORT_FW_MASK, x)
+#define  MT753X_R03_EG_TAG_MASK		GENMASK(8, 6)
+#define  MT753X_R03_EG_TAG(x)		FIELD_PREP(MT753X_R03_EG_TAG_MASK, x)
+#define  MT753X_R03_PORT_FW_MASK	GENMASK(2, 0)
 
 enum mt753x_bpdu_port_fw {
 	MT753X_BPDU_FOLLOW_MFC,
-- 
2.43.0


