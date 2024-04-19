Return-Path: <linux-kernel+bounces-151298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5658AAC96
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A591C210B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45E812C805;
	Fri, 19 Apr 2024 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2Aayrm2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5547F7C5;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521378; cv=none; b=mHHF+Clcb0lFqKBzk5IbQ45ZwgXp/R0yiO8ohHMElF9AKwB8J9qeizRJVgOCrWwUB5MvcNg2qS+0TcQ7KPTh2UaA5cizrIT1fYDNqNuO2/Ik21j85Fq8g7dNdxJ8S768PCoxO54E7EQjhHJyUZJIUzu808+ES9a49h8hKmx5Jho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521378; c=relaxed/simple;
	bh=Oh54loCHRJVtFGJB4q2HCwiYLcs9oRYxgNGQDVhsNV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cq5+Tu+MxYWY4vVLu6AK5BPuJPzMEeUuQHX7mamr+c9PVTBSVRennfYKakAyqUvEQtlO8W/hIO5ryqTXG6n7fhKJjGVi5JYkzLAmYePVKGVJBsvWra8L2rq1g/5h68nhzeTkdjd6xiB+v8HTz3M5ZN+wh0UomtMxfpZkRxJhHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2Aayrm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B80EC4AF16;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521378;
	bh=Oh54loCHRJVtFGJB4q2HCwiYLcs9oRYxgNGQDVhsNV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e2Aayrm2VdczGpLjFUKoPvnhNKjRSorQazsy17gI21caKdIX51UX5MCdYNJj8qhqW
	 6SkIkXB09U8/xUqQFbmddZwvpEmUnvHDHVYEhqOK7h0wX6DSRmccucpZy/uxtzunwT
	 iqyWC4F4Xnkyzypz7g+wJO2/XyEIvtmSG588kHs4UnjnrxnXoqlcwV9vChM2xxTp8i
	 IS54lavsPQNbz7Pun1mXmVr2gXvf0VLChUdzDiZ2sguQyALnc15R4oAOn5LS8QdRbj
	 9zBPPx5PQpzo9KJ6B/uo6ZV7u8mGAMZVN2bETjal67HwTOIUzdFMeMWXb+99ufhO3Q
	 P5xezx5ncMcFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2362AC04FF6;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 19 Apr 2024 13:09:34 +0300
Subject: [PATCH net-next 11/13] net: dsa: mt7530: refactor
 MT7530_PMEEECR_P()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240419-for-netnext-mt7530-improvements-4-v1-11-6d852ca79b1d@arinc9.com>
References: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
In-Reply-To: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713521374; l=2734;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=5wCatVwUOJ5yoMFPAyKVGUVnt4uS95CCabQrn8tU2fM=;
 b=0maqjVEcj9wlVirz6+trEGtEtGukLTt1jDOulxmYgtc5awUa2FB0JBcInEGiTz/1ZtI7g0Nkx
 nrBY7jShcPgD+dXTV3+bj4vkREykqXSfz+yJ1z1WqjGU0jWdA7aeM5x
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The MT7530_PMEEECR_P() register is on MT7530, MT7531, and the switch on the
MT7988 SoC. Rename the definition for them to MT753X_PMEEECR_P(). Use the
FIELD_PREP and FIELD_GET macros. Rename GET_LPI_THRESH() and
SET_LPI_THRESH() to LPI_THRESH_GET() and LPI_THRESH_SET().

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c |  8 ++++----
 drivers/net/dsa/mt7530.h | 13 +++++++------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 842c2573dfe4..5e69ff0a4b24 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3051,10 +3051,10 @@ static int mt753x_get_mac_eee(struct dsa_switch *ds, int port,
 			      struct ethtool_keee *e)
 {
 	struct mt7530_priv *priv = ds->priv;
-	u32 eeecr = mt7530_read(priv, MT7530_PMEEECR_P(port));
+	u32 eeecr = mt7530_read(priv, MT753X_PMEEECR_P(port));
 
 	e->tx_lpi_enabled = !(eeecr & LPI_MODE_EN);
-	e->tx_lpi_timer = GET_LPI_THRESH(eeecr);
+	e->tx_lpi_timer = LPI_THRESH_GET(eeecr);
 
 	return 0;
 }
@@ -3068,11 +3068,11 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 	if (e->tx_lpi_timer > 0xFFF)
 		return -EINVAL;
 
-	set = SET_LPI_THRESH(e->tx_lpi_timer);
+	set = LPI_THRESH_SET(e->tx_lpi_timer);
 	if (!e->tx_lpi_enabled)
 		/* Force LPI Mode without a delay */
 		set |= LPI_MODE_EN;
-	mt7530_rmw(priv, MT7530_PMEEECR_P(port), mask, set);
+	mt7530_rmw(priv, MT753X_PMEEECR_P(port), mask, set);
 
 	return 0;
 }
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 1f3aeccc77be..6a6ef34b48c4 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -364,13 +364,14 @@ enum mt7530_vlan_port_acc_frm {
 					 PMCR_FORCE_SPEED_100 | \
 					 PMCR_FORCE_FDX | PMCR_FORCE_LNK)
 
-#define MT7530_PMEEECR_P(x)		(0x3004 + (x) * 0x100)
-#define  WAKEUP_TIME_1000(x)		(((x) & 0xFF) << 24)
-#define  WAKEUP_TIME_100(x)		(((x) & 0xFF) << 16)
+#define MT753X_PMEEECR_P(x)		(0x3004 + (x) * 0x100)
+#define  WAKEUP_TIME_1000_MASK		GENMASK(31, 24)
+#define  WAKEUP_TIME_1000(x)		FIELD_PREP(WAKEUP_TIME_1000_MASK, x)
+#define  WAKEUP_TIME_100_MASK		GENMASK(23, 16)
+#define  WAKEUP_TIME_100(x)		FIELD_PREP(WAKEUP_TIME_100_MASK, x)
 #define  LPI_THRESH_MASK		GENMASK(15, 4)
-#define  LPI_THRESH_SHT			4
-#define  SET_LPI_THRESH(x)		(((x) << LPI_THRESH_SHT) & LPI_THRESH_MASK)
-#define  GET_LPI_THRESH(x)		(((x) & LPI_THRESH_MASK) >> LPI_THRESH_SHT)
+#define  LPI_THRESH_GET(x)		FIELD_GET(LPI_THRESH_MASK, x)
+#define  LPI_THRESH_SET(x)		FIELD_PREP(LPI_THRESH_MASK, x)
 #define  LPI_MODE_EN			BIT(0)
 
 #define MT7530_PMSR_P(x)		(0x3008 + (x) * 0x100)

-- 
2.40.1



