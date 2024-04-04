Return-Path: <linux-kernel+bounces-131088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608EB8982EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908C81C22539
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E8C6BFD4;
	Thu,  4 Apr 2024 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="q6gk3PZZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE867752;
	Thu,  4 Apr 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218607; cv=none; b=UHBI79QKk+BzL5/jJ2okpbD4v5pIj0Cs6TCJ8crUS897+Xhr9WGXGjzZ01Yl3hqbTqJF9/pXQKTw3HDJ+4mx7pMEIU6Cc8km2uU+VBC0MiCZOyl0hmmq3byPc6tw4nPNdCBe7yhO/f1tmdarqjyK4+yBHHLspEQyWW/Mx3mzR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218607; c=relaxed/simple;
	bh=jkfVHXis1dIiIoD00USp12skWB8veAyftXYu9xdtMWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qig9qu/GjZUgTXQf1h+kkMWs0jX6jeOZUVHym5/qCRRn4IqENdG0qY1K48IWMSZhr6cOw1HO8vWAs1mhk0iJJcCRmHbr+4shI5XQidTx02smAh00SlOIL8wWiL+ryHKyW3ZjAl1bxGoOkvPq7Et+chrKBsO8t5qIBSIkSzMaZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=q6gk3PZZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712218604;
	bh=jkfVHXis1dIiIoD00USp12skWB8veAyftXYu9xdtMWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6gk3PZZwEP1i4QppgCUu3WEdzGz6fVQtrdxDb6NvDUq00qJN4BN9zJfJfpW8xMBz
	 0+gDGFhnSmmBB3g1pBVICBCbucnspHMc9XoR5V0be0Dq2wgju23i9ao+SJ9wdkw+OX
	 b5GRhaGpWVvC4Ue421GW93FyTcPZz/IyhJ6QEtCPKJTcLITfbl4G781mDqiNxTqHh1
	 JOV2Rm/ra0ohZJgk6VrZIWkU/+XHQmbUe8xPyP27UZhTwp+/jIMoXv+7awnvfpU/vK
	 5lZwpz6M9ji0CyVvsaP6/a5JHHxlcPcgw0ESAPFpevRiUzHRDHFvJ4V1E9KWJJGs7B
	 reHc6XULknp1Q==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 92C803782129;
	Thu,  4 Apr 2024 08:16:43 +0000 (UTC)
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
Subject: [PATCH v1 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph support for board path
Date: Thu,  4 Apr 2024 10:16:34 +0200
Message-ID: <20240404081635.91412-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404081635.91412-1-angelogioacchino.delregno@collabora.com>
References: <20240404081635.91412-1-angelogioacchino.delregno@collabora.com>
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
index b3c6888c1457..90758bb5bcb1 100644
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
+      required:
+        - endpoint@0
+
 required:
   - compatible
   - reg
-- 
2.44.0


