Return-Path: <linux-kernel+bounces-166414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B014B8B9A53
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616351F227BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AE869D31;
	Thu,  2 May 2024 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N0Z8OZIc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F077A1E;
	Thu,  2 May 2024 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714650999; cv=none; b=i377OI+EtuH4S3aZw6PLNDDeNRc6K8quvO+jsYWxWVc/1Nh7dOAdIjKhn3K/0C+jcKt9TD0Pf5dFOI1WDkwJbZ+B0s+ck008KbBe6/g0IZeDm7iR6VWfiLSpKdyBhqyqAfKItCBBmdU0KEEJayOuGBqrDJ8pCeAKRSrCH/Gw4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714650999; c=relaxed/simple;
	bh=3XmqRbJJ+6Xm4vCkKTXcFr+ki230AzYei44k0LgLG5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mm6vlK0loiBZWQeQLgR0srb9phIQHL2K8ukpunVvI+hkJZQHCQHWAyW02xLX7IGgW7/ph9WI1GUTKC8mBQQL59nOwM/ItZzOwRjYk65IQpldp0SIiCbR4P/g1URy6u2SFg8rp89WWT0aDUEW1zBf762oEycJhrBkZlKc8NRviB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N0Z8OZIc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714650995;
	bh=3XmqRbJJ+6Xm4vCkKTXcFr+ki230AzYei44k0LgLG5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0Z8OZIck6+4ADleMnXW2At4y7Y90h5hz/oh8kjLP9uVW/1MNZCM8x7JfRrxvYEcu
	 3rar8vu6/BQslRhR7U5RIzSr1OI2sT6zwtuSzPD2TibOEk1CeeP6QLQvPuXforw2L2
	 WHJSgkfCRNz7DACLRtYDTX3QR5weW7UfcEu8hngaX0HOpjGz+1hy6WLDBLi2W/P7Kt
	 TuMANBnMyxlE92LGT4KisLi1iMaqbvXf4ox4xWHM+NoxF6h1h39QslBgL9TjdN0PlG
	 8irY6FrtG7H4/kzZx8BQ8ZXOwCDkUnyvrn2ikow8YWzr2l7gZLpbl1ObQAx8MnVIa3
	 urenvoWD5uyBA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D0C233782108;
	Thu,  2 May 2024 11:56:33 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	shawn.sung@mediatek.com,
	yu-chang.lee@mediatek.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	wenst@chromium.org,
	kernel@collabora.com
Subject: [PATCH v3 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph support for board path
Date: Thu,  2 May 2024 13:56:21 +0200
Message-ID: <20240502115622.248456-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240502115622.248456-1-angelogioacchino.delregno@collabora.com>
References: <20240502115622.248456-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document OF graph on MMSYS/VDOSYS: this supports up to three DDP paths
per HW instance (so potentially up to six displays for multi-vdo SoCs).

The MMSYS or VDOSYS is always the first component in the DDP pipeline,
so it only supports an output port with multiple endpoints - where each
endpoint defines the starting point for one of the (currently three)
possible hardware paths.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/arm/mediatek/mediatek,mmsys.yaml | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
index b3c6888c1457..4e9acd966aa5 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
@@ -93,6 +93,29 @@ properties:
   '#reset-cells':
     const: 1
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      Output port node. This port connects the MMSYS/VDOSYS output to
+      the first component of one display pipeline, for example one of
+      the available OVL or RDMA blocks.
+      Some MediaTek SoCs support up to three display outputs per MMSYS.
+    properties:
+      endpoint@0:
+        $ref: /schemas/graph.yaml#/properties/endpoint
+        description: Output to the primary display pipeline
+
+      endpoint@1:
+        $ref: /schemas/graph.yaml#/properties/endpoint
+        description: Output to the secondary display pipeline
+
+      endpoint@2:
+        $ref: /schemas/graph.yaml#/properties/endpoint
+        description: Output to the tertiary display pipeline
+
+    required:
+      - endpoint@0
+
 required:
   - compatible
   - reg
-- 
2.45.0


