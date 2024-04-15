Return-Path: <linux-kernel+bounces-144958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 858228A4D24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14100B231CC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87556BB45;
	Mon, 15 Apr 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ceFPL0tS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215A6775E;
	Mon, 15 Apr 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178826; cv=none; b=Lqxt2qFuwY4esFMjpSvR/uUDMiVERyYnM1YajBqJcBUpxageeGWob2RdwTdyM0+8cYbrYmCp3fi4BIzfLUOkcYXjaz1l+gvH0CBmWhe6LdiX9BUFzovSTrbJ7bgVQuae6oLj8WiMV0uBEI4czaJ7hii7WyFyX8SzDfz/MGoAoGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178826; c=relaxed/simple;
	bh=rbitL/G4lMP6ZRIY1343sC0cOyk85gecRetdOVOsnao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjXRzf3bEvgyCJMrokWHHmCmE0s0LVqCMFd+qtDaz4J6aBvqFPCHUMbA1XpInHphRcqT0swYs0yVUybnyPU8TOV9SlvylJxJx5qEL/Qr4RXkhbQbuwNMNtjBhPXJYHep60l/EWLG/GeZwEcmTHlcNuwNKN8e+YbpfBXXyPNVN+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ceFPL0tS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713178823;
	bh=rbitL/G4lMP6ZRIY1343sC0cOyk85gecRetdOVOsnao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ceFPL0tS31X7+m3GQVuGOIF3tKxiBvCaN+PMZK1/3Ips81SCnj0P3aQ9PGoKUGNg4
	 1peSJk3/hFH0XM+/7Lcsx/lEdFyf4kyL1BIXUf+Mn4ncwJ/33yX1BiQadYHlJBPnX7
	 wndrbkjLQWp0GgC98RXfh9OHM8U/j2BKjbX/2ivkKtP/VH/xcEoiY5z/qTjHzRWBsA
	 VbegNVl1rtzZYTekEuRiEfgK5poxf7qfPpxz4hEGCP7IK125AEl/iuks7p9NhPVy8C
	 6lEDFk9q4xipHe5R3D+Of5dqdI79vp3kYrJ6onfUa5z1xDMxQ72m4bxHw6bhmxtvvp
	 ObJuIEZVrAWnw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E6D5E3782123;
	Mon, 15 Apr 2024 11:00:21 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-scsi@vger.kernel.org
Cc: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	peter.wang@mediatek.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 5/8] dt-bindings: ufs: mediatek,ufs: Document MT8192 compatible with MT8183
Date: Mon, 15 Apr 2024 13:00:09 +0200
Message-ID: <20240415110012.148871-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
References: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8192 UFS controller is compatible with the MT8183 one:
document this by allowing to assign both compatible strings
"mediatek,mt8192-ufshci", "mediatek,mt8183-ufshci" to the UFSHCI node.

Moreover, since no MT8192 devicetree ever declared any UFSHCI node,
disallow specifying only the MT8192 compatible.

In preparation for adding MT8195 to the mix, the MT8192 compatible
was added as enum instead of const.

Also, while at it, replace Stanley Chu with me in the maintainers
field, as he is unreachable and his email isn't active anymore.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/ufs/mediatek,ufs.yaml         | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
index 32fd535a514a..f14887ea6fdc 100644
--- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
@@ -7,16 +7,19 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Mediatek Universal Flash Storage (UFS) Controller
 
 maintainers:
-  - Stanley Chu <stanley.chu@mediatek.com>
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
 
 allOf:
   - $ref: ufs-common.yaml
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt8183-ufshci
-      - mediatek,mt8192-ufshci
+    oneOf:
+      - const: mediatek,mt8183-ufshci
+      - items:
+          - enum:
+              - mediatek,mt8192-ufshci
+          - const: mediatek,mt8183-ufshci
 
   clocks:
     maxItems: 1
-- 
2.44.0


