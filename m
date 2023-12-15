Return-Path: <linux-kernel+bounces-778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970CF8145EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B21B226B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F1A24B51;
	Fri, 15 Dec 2023 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kVTRpd/Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE01A73F;
	Fri, 15 Dec 2023 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702637166;
	bh=/CmNXLjXKNYtE3QqvhH1lwezEnrtQSIJkJcxeOmHOgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVTRpd/QXiE/fuAxIqthRZXkouBjFQYgItywSZsLJrn7P2ek1WFaczYYy6AezJwvu
	 z1n1jckY6JH9ZDRGuMPKp2I4IiRmEqGd+sDufnJa1aB49oanAmcIERk5gWE6ajzSC+
	 JRG7lL7NYb2XVWbX2jyon60DbIkHTnyIaCaWQqqTnpvlPoXufRHv9zczg85fDebCRI
	 +s/hW2SvwIhpf1qyaQ7xwlvqVSCLrOjVIXxaNgaTcq3Yyi05skff9e9l9RQbFqX8DN
	 SGsmV24D01n7jHIYh4GlSGG77R37fan293irVkgoYmLdHWrtMJVIU6zCWdDD/fbNVM
	 3HVsXNzZWiR9g==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BDE013781FD6;
	Fri, 15 Dec 2023 10:46:05 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com,
	linux-media@vger.kernel.org,
	tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v2 3/7] dt-bindings: media: mtk-vcodec-encoder: fix non-vp8 clock name
Date: Fri, 15 Dec 2023 12:45:47 +0200
Message-Id: <20231215104551.233679-3-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215104551.233679-1-eugen.hristev@collabora.com>
References: <20231215104551.233679-1-eugen.hristev@collabora.com>
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
---
Changes in v2:
- new patch.
 .../bindings/media/mediatek,vcodec-encoder.yaml       | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index 403530de5624..5166c1c6934e 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
@@ -111,10 +111,7 @@ allOf:
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
@@ -124,8 +121,8 @@ allOf:
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
@@ -133,7 +130,7 @@ allOf:
             maxItems: 1
         clock-names:
           items:
-            - const: venc_lt_sel
+            - const: venc_sel
 
 additionalProperties: false
 
-- 
2.34.1


