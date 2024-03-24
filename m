Return-Path: <linux-kernel+bounces-114932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2998188929B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB551C2E2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0807627F8CE;
	Mon, 25 Mar 2024 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sD7ErK0W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD3B179646;
	Sun, 24 Mar 2024 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323608; cv=none; b=F7ropFOfG9lPZn+JoqBLI0oEAvFsp8WdNFfKGjya9VGXMvlGlE6MuKg2oT0B8tkAsSfaMJOV+FyUn/8WGaDTp9T+0vY9Q4SUYUrne5NS3Ij0dFR8nyKKFjk+1VdOUYRflrcN5gJ+72WQLuR9Fwg6KnQiDVjzxHb/daOiQLpSD5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323608; c=relaxed/simple;
	bh=UA6yHe7AjiCpnNsB6/awa3N4u3CNokgehRkPBtewLtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyUFWyrm2/MPOBZjwbgdRFtShNhDmIp9kGsEfRPB6gS2ucxzKR49zv6rv9JkJXS3+VT00leC7X5kSxgZLRGs2C8QNV/88qQIglleM9Isu/YB0D14NbDiq7GTnkXOoQUMG5NPmIqOdhWr0imaCm9C/yNY+lj4qgmhmqlue5fOW/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sD7ErK0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288C3C433C7;
	Sun, 24 Mar 2024 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323607;
	bh=UA6yHe7AjiCpnNsB6/awa3N4u3CNokgehRkPBtewLtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sD7ErK0WhDWhD639FPdXrDlRrTBw5vpjS/t0DbAs7KX9xAUnK/tL0m7p0Jve/z6Q/
	 HPN5fDMog8PgDWZX6Grdp4/X1mroYfRqJKNX73RV26r/63tjut7OUs8c8ZGd+6gQIW
	 HBY2IRqCY0kuVlgJnoP2xnWUdg3k26BH5irD9f+C7zxt+sYUUZZSSWf7s/3mxytanS
	 XJVJFWXSCjo+IC4NbM+dYZri5i1G38alrP2Fkjv18G4eTbqA1u+BFpeW2NNexM144V
	 D9pvW7/P2fVdAjrwS9hrmOSRRS/oeQGUA4bu58uz2A5BCtF3UUdZKRAAzkaDu9JCjT
	 FOwOuYNLRvDxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 314/317] net: dsa: mt7530: fix handling of all link-local frames
Date: Sun, 24 Mar 2024 19:34:54 -0400
Message-ID: <20240324233458.1352854-315-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 834bcb9d44fd7..f36aacebb1bc6 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -993,6 +993,21 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
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
@@ -1007,13 +1022,27 @@ mt753x_trap_frames(struct mt7530_priv *priv)
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
index 7c0820d341db7..03598f9ae288c 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -72,12 +72,25 @@ enum mt753x_id {
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


