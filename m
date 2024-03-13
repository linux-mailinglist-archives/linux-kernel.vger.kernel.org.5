Return-Path: <linux-kernel+bounces-101400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4774487A6A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2687282ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41C93F9E9;
	Wed, 13 Mar 2024 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uEdGdLdy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D2A54919;
	Wed, 13 Mar 2024 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327768; cv=none; b=DDjUFajnl7W+uqF0PWkfefPIWB0SpttygN/KXUmbz5lJVw6mSYeTI1PxRPdYxJm5Mxn1VmX5+C07NePuekT1SJn3+VPxOB/TlbjckWuYGUu8hsAV1789+Qi+Lk/KrZcpnV3pM+pzl2KpqnwoJqPxy45NhHeQuvTFCLKIn6wSLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327768; c=relaxed/simple;
	bh=ejVpkmUpG3TujjmS9PY7/wxf0vTDuhO45Kdib7+YOaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhJlDSE0ndTrlhBWs1hyP4PKe3MSYU5PI1+3qzfxfDTSs3ETL0l07sfdshz4TeYneYHff/eqEV4BJtzxQ8SnDVQDavAWv/d8mmAun3IVSEa0xTzyFkLDmt1vWBojIB9gmmoywOvuYARymKWEizW3Mv4im11GyLrMz6rdc2LOM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uEdGdLdy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710327765;
	bh=ejVpkmUpG3TujjmS9PY7/wxf0vTDuhO45Kdib7+YOaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uEdGdLdyuL/OYGUVBvXT3W0MW3cxwohDqGRDvehG1wX0/uhPJIw7EEAWpBGBXtusD
	 Oe6SN1qG+Wb6QIh4gkN1b7CP51vhm/qPD1irpOjeusoIo1ai/9Utx6TQhW1AohCC/b
	 Z38dpkfXGcB85iZ+9dy0G3EbrIUSr8LvlZTvX1U5fuMoe+RndxCGYOwTAaYT4aED4w
	 mZ4dXPVyo1CdsfdZ98VQFcd6Ft2yS6k4BfKmdOZBGj5ymnUIjaph92gJ0rbYB/VauO
	 H+7wOvUoi6u7OJQZZst2arwg2a8jyk1maXmkMQEjoBnjvfDH9vb6GcHnE0W/F6/pDi
	 I2kUsfsskVkGw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0ED6D3782079;
	Wed, 13 Mar 2024 11:02:43 +0000 (UTC)
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
Subject: [PATCH v3 20/22] ASoC: dt-bindings: mt8186: Document audio-routing and dai-link subnode
Date: Wed, 13 Mar 2024 12:01:45 +0100
Message-ID: <20240313110147.1267793-21-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
References: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
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

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../sound/mt8186-mt6366-da7219-max98357.yaml  | 131 ++++++++++++++++--
 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   | 120 ++++++++++++++--
 2 files changed, 233 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
index 9853c11a1330..cbc641ecbe94 100644
--- a/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
@@ -12,17 +12,46 @@ maintainers:
 description:
   This binding describes the MT8186 sound card.
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
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
+    minItems: 2
+    items:
+      enum:
+        # Sinks
+        - HDMI1
+        - Headphones
+        - Line Out
+        - MIC
+        - Speakers
+
+        # Sources
+        - Headset Mic
+        - HPL
+        - HPR
+        - Speaker
+        - TX
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
@@ -32,6 +61,7 @@ properties:
 
   playback-codecs:
     type: object
+    deprecated: true
     additionalProperties: false
     properties:
       sound-dai:
@@ -53,32 +83,115 @@ properties:
       A list of the desired dai-links in the sound card. Each entry is a
       name defined in the machine driver.
 
-additionalProperties: false
+patternProperties:
+  ".*-dai-link$":
+    type: object
+    additionalProperties: false
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
+    required:
+      - link-name
+
+unevaluatedProperties: false
 
 required:
   - compatible
   - mediatek,platform
-  - headset-codec
-  - playback-codecs
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
 
 examples:
   - |
 
     sound: mt8186-sound {
         compatible = "mediatek,mt8186-mt6366-da7219-max98357-sound";
-        mediatek,platform = <&afe>;
+        model = "mt8186_da7219_m98357";
         pinctrl-names = "aud_clk_mosi_off",
                         "aud_clk_mosi_on";
         pinctrl-0 = <&aud_clk_mosi_off>;
         pinctrl-1 = <&aud_clk_mosi_on>;
+        mediatek,platform = <&afe>;
+
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
 
-        headset-codec {
-            sound-dai = <&da7219>;
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
index bdf7b0960533..ed93f18ef985 100644
--- a/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
@@ -12,6 +12,9 @@ maintainers:
 description:
   This binding describes the MT8186 sound card.
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     enum:
@@ -19,6 +22,34 @@ properties:
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
+    minItems: 2
+    items:
+      enum:
+        # Sinks
+        - HDMI1
+        - Headphone
+        - IN1P
+        - IN1N
+        - Line Out
+        - Speakers
+
+        # Sources
+        - Headset Mic
+        - HPOL
+        - HPOR
+        - Speaker
+        - SPOL
+        - SPOR
+        - TX
+
   mediatek,platform:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: The phandle of MT8186 ASoC platform.
@@ -32,6 +63,7 @@ properties:
 
   headset-codec:
     type: object
+    deprecated: true
     additionalProperties: false
     properties:
       sound-dai:
@@ -41,6 +73,7 @@ properties:
 
   playback-codecs:
     type: object
+    deprecated: true
     additionalProperties: false
     properties:
       sound-dai:
@@ -62,13 +95,56 @@ properties:
       A list of the desired dai-links in the sound card. Each entry is a
       name defined in the machine driver.
 
-additionalProperties: false
+patternProperties:
+  ".*-dai-link$":
+    type: object
+    additionalProperties: false
+    description:
+      Container for dai-link level properties and CODEC sub-nodes.
+
+    properties:
+      link-name:
+        description: Indicates dai-link name and PCM stream name
+        enum: [ I2S0, I2S1, I2S2, I2S3 ]
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
-  - playback-codecs
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
 
 examples:
   - |
@@ -76,23 +152,49 @@ examples:
 
     sound: mt8186-sound {
         compatible = "mediatek,mt8186-mt6366-rt1019-rt5682s-sound";
-        mediatek,platform = <&afe>;
+        model = "mt8186_rt1019_rt5682s";
         pinctrl-names = "aud_clk_mosi_off",
                         "aud_clk_mosi_on",
                         "aud_gpio_dmic_sec";
         pinctrl-0 = <&aud_clk_mosi_off>;
         pinctrl-1 = <&aud_clk_mosi_on>;
         pinctrl-2 = <&aud_gpio_dmic_sec>;
+        mediatek,platform = <&afe>;
 
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


