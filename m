Return-Path: <linux-kernel+bounces-83198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226E186901D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960531F27CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541E14F999;
	Tue, 27 Feb 2024 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bZXye4ij"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B714F966;
	Tue, 27 Feb 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035863; cv=none; b=DYcuM31pSDos1fZG2SK7avmOGnEjohakp/9kEYOy0hMpHJ6KuAx+gpUo80kUKJ2zQ5LvVxUs/aFcGDVtXzqCgB4TZOo6Aw/w6wmb4sHxp8khh88Q37c8MgMEC3KRHtwDRUAPM7qzSGkmXcSZ4RpCkxkH1bN1e8ERQd6UKM+QJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035863; c=relaxed/simple;
	bh=XFXwQ/JEkL5l1w5pVJ7u/EzqhjFbZ7661NknXSt9R18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msrxOnhSbhWp5f4nDLOGuWGtxnvRLVnyYKdYdZjaCkqdjxgu3n43YMqJyDMSBeSmjOYg88vRpOfOrWXyFoRlKpCfZ2KoZ/nbCsf4njvw7I+L3kwvRyjbERlUKXrTrI0rz+FSVKxt0JAtFWi4P3SLi7HwGijdWL7SUMEWP4JA1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bZXye4ij; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709035859;
	bh=XFXwQ/JEkL5l1w5pVJ7u/EzqhjFbZ7661NknXSt9R18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZXye4ijSKMd1hTMZsS7DH0kjwZDRH+66DW9MBMO9FOvzBsPgAsegxyTkfXxU7bPE
	 FV/G+JA9PsZ5+y4d9uYE9WskEqO4kx4gR1ZmARlVce1wYesFAzP96TIrpertDPxzJ/
	 ukLcfuaMTCP/VGEPMeNy/FoCXvONSfxK6F8tptGEILUIxzfYh5fgJ3IDOuR0XpiDw9
	 coUCRDFBjNeVH2N8xdzqVsMPFJDtJBmD7p7nxMT+2TDBB2ZLYPPv7NtDGvb/5dyAAc
	 d75hrM28aTtsYMBIRQDQTVx9OHhR8qXeGTcfgTg3UFA7/FaxlifnOUPG2PNZYejOOC
	 8f9zhi0uu+PfA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 21C2B37820EA;
	Tue, 27 Feb 2024 12:10:57 +0000 (UTC)
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
Subject: [PATCH 20/22] ASoC: dt-bindings: mt8186: Document audio-routing and dai-link subnode
Date: Tue, 27 Feb 2024 13:09:37 +0100
Message-ID: <20240227120939.290143-21-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227120939.290143-1-angelogioacchino.delregno@collabora.com>
References: <20240227120939.290143-1-angelogioacchino.delregno@collabora.com>
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

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../sound/mt8186-mt6366-da7219-max98357.yaml  | 112 ++++++++++++++++--
 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   | 112 ++++++++++++++++--
 2 files changed, 210 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
index 9853c11a1330..ef22b972f85c 100644
--- a/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
@@ -17,12 +17,22 @@ properties:
     enum:
       - mediatek,mt8186-mt6366-da7219-max98357-sound
 
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+      Valid names could be the input or output widgets of audio components,
+      power supplies, MicBias of codec and the software switch.
+
   mediatek,platform:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: The phandle of MT8186 ASoC platform.
 
   headset-codec:
     type: object
+    deprecated: true
     additionalProperties: false
     properties:
       sound-dai:
@@ -32,6 +42,7 @@ properties:
 
   playback-codecs:
     type: object
+    deprecated: true
     additionalProperties: false
     properties:
       sound-dai:
@@ -53,13 +64,75 @@ properties:
       A list of the desired dai-links in the sound card. Each entry is a
       name defined in the machine driver.
 
+patternProperties:
+  ".*-dai-link$":
+    type: object
+    description:
+      Container for dai-link level properties and CODEC sub-nodes.
+
+    properties:
+      link-name:
+        description: Indicates dai-link name and PCM stream name
+        items:
+          enum:
+            - I2S0
+            - I2S1
+            - I2S2
+            - I2S3
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
+        items:
+          enum:
+            - i2s
+            - right_j
+            - left_j
+            - dsp_a
+            - dsp_b
+
+      mediatek,clk-provider:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: Indicates dai-link clock master.
+        items:
+          enum:
+            - cpu
+            - codec
+
+    additionalProperties: false
+
+    required:
+      - link-name
+
 additionalProperties: false
 
 required:
   - compatible
   - mediatek,platform
-  - headset-codec
-  - playback-codecs
+
+allOf:
+  # Disallow dai-link-xxx nodes if the legacy properties are specified
+  - if:
+      patternProperties:
+        ".*-dai-link$": false
+    then:
+      required:
+        - headset-codec
+        - speaker-codecs
+    else:
+      properties:
+        headset-codec: false
+        speaker-codecs: false
 
 examples:
   - |
@@ -72,13 +145,38 @@ examples:
         pinctrl-0 = <&aud_clk_mosi_off>;
         pinctrl-1 = <&aud_clk_mosi_on>;
 
-        headset-codec {
-            sound-dai = <&da7219>;
+        audio-routing =
+                "Headphones", "HPL",
+                "Headphones", "HPR",
+                "MIC", "Headset Mic",
+                "Speakers", "Speaker",
+                "HDMI1", "TX";
+
+        hs-playback-dai-link {
+                link-name = "I2S0";
+                dai-format = "i2s";
+                mediatek,clk-provider = "cpu";
+                codec {
+                        sound-dai = <&da7219>;
+                };
+        };
+
+        hs-capture-dai-link {
+                link-name = "I2S1";
+                dai-format = "i2s";
+                mediatek,clk-provider = "cpu";
+                codec {
+                        sound-dai = <&da7219>;
+                };
         };
 
-        playback-codecs {
-            sound-dai = <&anx_bridge_dp>,
-                        <&max98357a>;
+        spk-dp-playback-dai-link {
+                link-name = "I2S3";
+                dai-format = "i2s";
+                mediatek,clk-provider = "cpu";
+                codec {
+                        sound-dai = <&anx_bridge_dp>, <&max98357a>;
+                };
         };
     };
 
diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml b/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
index bdf7b0960533..0342b46690f4 100644
--- a/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
@@ -19,6 +19,15 @@ properties:
       - mediatek,mt8186-mt6366-rt5682s-max98360-sound
       - mediatek,mt8186-mt6366-rt5650-sound
 
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+      Valid names could be the input or output widgets of audio components,
+      power supplies, MicBias of codec and the software switch.
+
   mediatek,platform:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: The phandle of MT8186 ASoC platform.
@@ -32,6 +41,7 @@ properties:
 
   headset-codec:
     type: object
+    deprecated: true
     additionalProperties: false
     properties:
       sound-dai:
@@ -41,6 +51,7 @@ properties:
 
   playback-codecs:
     type: object
+    deprecated: true
     additionalProperties: false
     properties:
       sound-dai:
@@ -62,13 +73,75 @@ properties:
       A list of the desired dai-links in the sound card. Each entry is a
       name defined in the machine driver.
 
+patternProperties:
+  ".*-dai-link$":
+    type: object
+    description:
+      Container for dai-link level properties and CODEC sub-nodes.
+
+    properties:
+      link-name:
+        description: Indicates dai-link name and PCM stream name
+        items:
+          enum:
+            - I2S0
+            - I2S1
+            - I2S2
+            - I2S3
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
+        items:
+          enum:
+            - i2s
+            - right_j
+            - left_j
+            - dsp_a
+            - dsp_b
+
+      mediatek,clk-provider:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: Indicates dai-link clock master.
+        items:
+          enum:
+            - cpu
+            - codec
+
+    additionalProperties: false
+
+    required:
+      - link-name
+
 additionalProperties: false
 
 required:
   - compatible
   - mediatek,platform
-  - headset-codec
-  - playback-codecs
+
+allOf:
+  # Disallow dai-link-xxx nodes if the legacy properties are specified
+  - if:
+      patternProperties:
+        ".*-dai-link$": false
+    then:
+      required:
+        - headset-codec
+        - speaker-codecs
+    else:
+      properties:
+        headset-codec: false
+        speaker-codecs: false
 
 examples:
   - |
@@ -86,13 +159,38 @@ examples:
 
         dmic-gpios = <&pio 23 GPIO_ACTIVE_HIGH>;
 
-        headset-codec {
-            sound-dai = <&rt5682s>;
+        audio-routing =
+                "Headphone", "HPOL",
+                "Headphone", "HPOR",
+                "IN1P", "Headset Mic",
+                "Speakers", "Speaker",
+                "HDMI1", "TX";
+
+        hs-playback-dai-link {
+                link-name = "I2S0";
+                dai-format = "i2s";
+                mediatek,clk-provider = "cpu";
+                codec {
+                        sound-dai = <&rt5682s 0>;
+                };
+        };
+
+        hs-capture-dai-link {
+                link-name = "I2S1";
+                dai-format = "i2s";
+                mediatek,clk-provider = "cpu";
+                codec {
+                        sound-dai = <&rt5682s 0>;
+                };
         };
 
-        playback-codecs {
-             sound-dai = <&it6505dptx>,
-                         <&rt1019p>;
+        spk-hdmi-playback-dai-link {
+                link-name = "I2S3";
+                dai-format = "i2s";
+                mediatek,clk-provider = "cpu";
+                codec {
+                        sound-dai = <&it6505dptx>, <&rt1019p>;
+                };
         };
     };
 
-- 
2.44.0


