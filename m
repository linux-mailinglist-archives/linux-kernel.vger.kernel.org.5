Return-Path: <linux-kernel+bounces-12611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7E281F7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9721D1F249BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8EB79FE;
	Thu, 28 Dec 2023 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="raq68Je8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D96FCA;
	Thu, 28 Dec 2023 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703763177;
	bh=8UVn3bqlJ8hPorONnus5laiB1PvUXo1CSznLEpz4ZA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=raq68Je83mcITqxOybvgxYCVSoMJ7WIAJhff4NUTXg3gLq+PK4x3U04LS7YWb8l7M
	 GE6AGzmPGodTx0+56r0TXCRU+nuG8wltyQBNPD+wFICW5D9W70vgvbyKdQDbtLTmO7
	 V4BQpop7tAN2vu0PQYRUCyEDJ4+kui4HCUY8NTBVUhRFt82Y9NSVUKrRKdwWUkFg0B
	 j5kylonE6ATE9Mf8WFz54m53MvP052WSh71vQIpBBliUuNn9kZiPsT6Q/A9YQRLr62
	 Tnh53chX3c+tX+WEEszAlmx9tGbiLsdx3tSsLQpkYD99BWrdc3gYnj6PtK26xqPEvW
	 pxgF+QbUFlHVw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CE75237813C4;
	Thu, 28 Dec 2023 11:32:56 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org
Cc: eugen.hristev@collabora.com,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	kernel@collabora.com,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/6] dt-bindings: media: mtk-vcodec-encoder: fix non-vp8 clock name
Date: Thu, 28 Dec 2023 13:32:41 +0200
Message-Id: <20231228113245.174706-3-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228113245.174706-1-eugen.hristev@collabora.com>
References: <20231228113245.174706-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looking at the binding it makes sense that the `-vp8` compatible has
the `venc_lt_sel` while the other bindings have the `venc_sel` as name for
the clock.
This was also mentioned in the txt version of the binding before the
conversion:
 `
 clock-names: avc encoder must contain "venc_sel", vp8 encoder must
 contain "venc_lt_sel", decoder must contain "vcodecpll", "univpll_d2",
 `

So it is easier to check for compatible that includes vp8, since that's
just one, to have the requirement for the clock name property as
`venc_lt_sel`, rather than for all the others, some of which are missing,
thus for them, the requirement is wrongly `venc_lt_sel`.

Reordered the if/then/else to match `-vp8` and have all the rest of
the compatibles using the other clock name (`venc_sel`).

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
- collect R-B
Changes in v2:
- new patch.
 .../bindings/media/mediatek,vcodec-encoder.yaml       | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index a2051b31fa29..849721c0571a 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
@@ -109,10 +109,7 @@ allOf:
       properties:
         compatible:
           enum:
-            - mediatek,mt8173-vcodec-enc
-            - mediatek,mt8188-vcodec-enc
-            - mediatek,mt8192-vcodec-enc
-            - mediatek,mt8195-vcodec-enc
+            - mediatek,mt8173-vcodec-enc-vp8
 
     then:
       properties:
@@ -122,8 +119,8 @@ allOf:
             maxItems: 1
         clock-names:
           items:
-            - const: venc_sel
-    else:  # for vp8 hw encoder
+            - const: venc_lt_sel
+    else:
       properties:
         clock:
           items:
@@ -131,7 +128,7 @@ allOf:
             maxItems: 1
         clock-names:
           items:
-            - const: venc_lt_sel
+            - const: venc_sel
 
 additionalProperties: false
 
-- 
2.34.1


