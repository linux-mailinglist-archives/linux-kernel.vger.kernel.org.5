Return-Path: <linux-kernel+bounces-136786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C064A89D820
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769C028ACBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D131353E8;
	Tue,  9 Apr 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4x8N+MmA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444513441D;
	Tue,  9 Apr 2024 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662449; cv=none; b=ByaQ1vsBHjEX49ZeMZwmnzzdTAsewffy/ZK76cFawvgFOzuQIDHQpZmlj3J6l65R2Oi4nzWDcTtNhP7WP1JhnuwdYvzFault5mtxMygvnee6nMSF6bDqkN1BBPZmUz4Hs4LI7WjYRXKX7sjT700ENm/ISiGBwKGyG+ZEJkROWqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662449; c=relaxed/simple;
	bh=6SqN9wWBxnCEthQ3e1Jy5DMt1UHcxaWeOQWQPNIAVhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDfzk9CDV/O0UWf8wjRzZDm3r9rZCrtRtGv89aYjPmb9PJQn8J0yuTk4CREmn9oBJbAtGGpt/KW2NpPVYmeYj816k3QBjzXYtGVTz8RUossGk1EwnUZNXLofyY9OJD7lwh6t36yE/gC/1vu20GLuMtawwANCtEHHKx+jCbyFZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4x8N+MmA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712662445;
	bh=6SqN9wWBxnCEthQ3e1Jy5DMt1UHcxaWeOQWQPNIAVhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=4x8N+MmAOwtwucfgJSxQR6oDDw4XDAWHS5cs9u95XsjwtWPDEh4ZHvc8wOT0IVT0I
	 OxYNj3DG5CLxtzkEugDvcD2S+iNguTPv5PTwACBbjqgBegqqe8t2erLpbkulcTnaZN
	 d/HWxiZYmrPEd5z+40C95nphZq9uy/vNNNSHeZ+HcDrjd1lEPQLBZ5yDV/nJofps+g
	 GDFENdMKjw874sNxJD/0pTiL+aRPU9uxB8EFROOkoy8A/8AYhEN4dWKC+DyDpfRk00
	 KZs7BargTWGMJh9H5LQAtANTyifXYV04B1YL4RXgwf/VjbvlGzW5d9gGO6+ZSDIUDZ
	 qxFAtfJ3aJjmQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AE89537820F8;
	Tue,  9 Apr 2024 11:34:03 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: wenst@chromium.org,
	lgirdwood@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	trevor.wu@mediatek.com,
	maso.huang@mediatek.com,
	xiazhengqiao@huaqin.corp-partner.google.com,
	arnd@arndb.de,
	kuninori.morimoto.gx@renesas.com,
	shraash@google.com,
	amergnat@baylibre.com,
	nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de,
	dianders@chromium.org,
	frank.li@vivo.com,
	allen-kh.cheng@mediatek.com,
	eugen.hristev@collabora.com,
	claudiu.beznea@tuxon.dev,
	jarkko.nikula@bitmer.com,
	jiaxin.yu@mediatek.com,
	alpernebiyasak@gmail.com,
	ckeepax@opensource.cirrus.com,
	zhourui@huaqin.corp-partner.google.com,
	nfraprado@collabora.com,
	alsa-devel@alsa-project.org,
	shane.chien@mediatek.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 15/18] ASoC: dt-bindings: mt8192: Document audio-routing and dai-link subnode
Date: Tue,  9 Apr 2024 13:33:07 +0200
Message-ID: <20240409113310.303261-16-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409113310.303261-1-angelogioacchino.delregno@collabora.com>
References: <20240409113310.303261-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the dai-link subnodes and the audio-routing property, allowing
to describe machine specific audio hardware and links in device tree.

While at it, also deprecate the old properties which were previously
used with the driver's partially hardcoded configuration.

Also, since describing machine specific audio hardware and links replaces
the now deprecated old logic doing the same in a driver hardcoded fashion,
it is not allowed to have both the old and new properties together.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 139 ++++++++++++++++--
 1 file changed, 129 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
index 7e50f5d65c8f..c4e68f31aaab 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
@@ -13,6 +13,9 @@ maintainers:
 description:
   This binding describes the MT8192 sound card.
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     enum:
@@ -20,6 +23,31 @@ properties:
       - mediatek,mt8192_mt6359_rt1015p_rt5682
       - mediatek,mt8192_mt6359_rt1015p_rt5682s
 
+  audio-routing:
+    description:
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+      Valid names could be the input or output widgets of audio components,
+      power supplies, MicBias of codec and the software switch.
+    minItems: 2
+    items:
+      enum:
+        # Sinks
+        - Speakers
+        - Headphone Jack
+        - IN1P
+        - Left Spk
+        - Right Spk
+
+        # Sources
+        - Headset Mic
+        - HPOL
+        - HPOR
+        - Left SPO
+        - Right SPO
+        - Speaker
+
   mediatek,platform:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: The phandle of MT8192 ASoC platform.
@@ -27,10 +55,12 @@ properties:
   mediatek,hdmi-codec:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: The phandle of HDMI codec.
+    deprecated: true
 
   headset-codec:
     type: object
     additionalProperties: false
+    deprecated: true
 
     properties:
       sound-dai:
@@ -41,6 +71,7 @@ properties:
   speaker-codecs:
     type: object
     additionalProperties: false
+    deprecated: true
 
     properties:
       sound-dai:
@@ -51,33 +82,121 @@ properties:
     required:
       - sound-dai
 
-additionalProperties: false
+patternProperties:
+  ".*-dai-link$":
+    type: object
+    additionalProperties: false
+
+    description:
+      Container for dai-link level properties and CODEC sub-nodes.
+
+    properties:
+      link-name:
+        description: Indicates dai-link name and PCM stream name
+        enum:
+          - I2S0
+          - I2S1
+          - I2S2
+          - I2S3
+          - I2S4
+          - I2S5
+          - I2S6
+          - I2S7
+          - I2S8
+          - I2S9
+          - TDM
+
+      codec:
+        description: Holds subnode which indicates codec dai.
+        type: object
+        additionalProperties: false
+        properties:
+          sound-dai:
+            minItems: 1
+            maxItems: 2
+        required:
+          - sound-dai
+
+      dai-format:
+        description: audio format
+        enum: [ i2s, right_j, left_j, dsp_a, dsp_b ]
+
+      mediatek,clk-provider:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: Indicates dai-link clock master.
+        enum: [ cpu, codec ]
+
+    required:
+      - link-name
+
+unevaluatedProperties: false
 
 required:
   - compatible
   - mediatek,platform
-  - headset-codec
-  - speaker-codecs
+
+# Disallow legacy properties if xxx-dai-link nodes are specified
+if:
+  not:
+    patternProperties:
+      ".*-dai-link$": false
+then:
+  properties:
+    headset-codec: false
+    speaker-codecs: false
+    mediatek,hdmi-codec: false
 
 examples:
   - |
 
     sound: mt8192-sound {
         compatible = "mediatek,mt8192_mt6359_rt1015_rt5682";
-        mediatek,platform = <&afe>;
-        mediatek,hdmi-codec = <&anx_bridge_dp>;
+        model = "mt8192_mt6359_rt1015_rt5682";
         pinctrl-names = "aud_clk_mosi_off",
                         "aud_clk_mosi_on";
         pinctrl-0 = <&aud_clk_mosi_off>;
         pinctrl-1 = <&aud_clk_mosi_on>;
+        mediatek,platform = <&afe>;
+
+        audio-routing =
+                "Headphone Jack", "HPOL",
+                "Headphone Jack", "HPOR",
+                "IN1P", "Headset Mic",
+                "Speakers", "Speaker";
+
+        spk-playback-dai-link {
+                link-name = "I2S3";
+                dai-format = "i2s";
+                mediatek,clk-provider = "cpu";
+                codec {
+                        sound-dai = <&rt1015p>;
+                };
+        };
+
+        hs-playback-dai-link {
+                link-name = "I2S8";
+                dai-format = "i2s";
+                mediatek,clk-provider = "cpu";
+                codec {
+                        sound-dai = <&rt5682 0>;
+                };
+        };
 
-        headset-codec {
-            sound-dai = <&rt5682>;
+        hs-capture-dai-link {
+                link-name = "I2S9";
+                dai-format = "i2s";
+                mediatek,clk-provider = "cpu";
+                codec {
+                        sound-dai = <&rt5682 0>;
+                };
         };
 
-        speaker-codecs {
-            sound-dai = <&rt1015_l>,
-                        <&rt1015_r>;
+        displayport-dai-link {
+                link-name = "TDM";
+                dai-format = "dsp_a";
+                codec {
+                        sound-dai = <&anx_bridge_dp>;
+                };
         };
     };
 
-- 
2.44.0


