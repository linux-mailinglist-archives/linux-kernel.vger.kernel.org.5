Return-Path: <linux-kernel+bounces-95482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271ED874E25
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D132A2822B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D8612FF75;
	Thu,  7 Mar 2024 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C8Vr3cde"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987B12FB20;
	Thu,  7 Mar 2024 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811944; cv=none; b=axTX03wKPSedoFzuyYv9hO6/dki3wxFPDek0uSy8hzwfmn/S6kdKKeiDiKOxog9HVKFRyyGbKNJ8/Xc39tjcurit7E5oOZxtKCgsQDiqqoXIOs3TKzzhlHbKXKm0gbMTUIySIetP0Lk4zhu17+DK83pKTb2BjpHlffiUy1zW7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811944; c=relaxed/simple;
	bh=BjmfZXl22mdfps23MxkqwAgw/ZqRP6PywU29zGmeXH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCzNQ/v74M0tz4SHuRwFGiOTV/F8nT5hbcAXDuECRJMIi6Fp9BvGljmZ0dA3r5qvSO16LPdKTWKW2Lr8egNj2Gv3TcjqRPzBeMQN6igwHWpqCXttZhqhUP0k2eycPhkiYMYdcr071if5vJHOOe8dxEd5w7kH2BzySD25r7tnvL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C8Vr3cde; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709811940;
	bh=BjmfZXl22mdfps23MxkqwAgw/ZqRP6PywU29zGmeXH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8Vr3cdeo2Ly12hYAJrgtSPnzHhm4oUN4qD8BV9br45lzZvw/XtuzaTtwmGd6+7r1
	 lox8F/l4KeEWV2YaC/3ZnpyTjeYv+UnmJw7YBVWtnWKvtNWHfql8cutQ9H8NkxYH3h
	 8ZmmoUdVavqkRXKejn9uFPcdcwvJGZGOA/irIceroXztj0JsuuVR8qZjyqRonvXACp
	 /We/n2fz2rrp1OpWifllsyuqS/ncBhZqPQTYP07HK/U2cTxrxAkyyT8qVduP8yQ1ly
	 UC/2B0DtWqMQUoAuZMSMh+9mF6ROL0SMRk/6P0yeJbYpkpuU34wJMce9UKfPr/kHKq
	 ZfUzxgeusP8Cw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7FAE537820ED;
	Thu,  7 Mar 2024 11:45:38 +0000 (UTC)
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
Subject: [PATCH v2 20/22] ASoC: dt-bindings: mt8186: Document audio-routing and dai-link subnode
Date: Thu,  7 Mar 2024 12:44:43 +0100
Message-ID: <20240307114445.196981-21-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
References: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
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
 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   | 102 ++++++++++++++--
 2 files changed, 199 insertions(+), 15 deletions(-)

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
index bdf7b0960533..c4d6acaf2094 100644
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
@@ -62,13 +73,62 @@ properties:
       A list of the desired dai-links in the sound card. Each entry is a
       name defined in the machine driver.
 
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
 additionalProperties: false
 
 required:
   - compatible
   - mediatek,platform
-  - headset-codec
-  - playback-codecs
+
+allOf:
+  - $ref: sound-card-common.yaml#
+
+  # Disallow xxx-dai-link nodes if the legacy properties are specified
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
@@ -76,23 +136,49 @@ examples:
 
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


