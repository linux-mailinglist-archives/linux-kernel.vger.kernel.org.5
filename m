Return-Path: <linux-kernel+bounces-146397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 753898A64C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6EB281C98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10CA15B967;
	Tue, 16 Apr 2024 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fYTAnl9w"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1D15B56D;
	Tue, 16 Apr 2024 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251694; cv=none; b=qIu/2xDFXPNaGGTCD/o/ORXMwUHhomQBUeuPvbsrmiT5pcpNye9B5clkyfiSjQ2q8e4I8YUnH9OUTaeRThNVgVOwC9KqujpU7aIf3tEEIjfEsp0T/GcHho3/zx09QFsAIms8m0C3Bo2yEYLTUcFU9kqUm0tc81Kftebs2n6/nJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251694; c=relaxed/simple;
	bh=l/YgE2jHDgEGiO5tZpMnwUUm+KuVZjmQoNRva6TC6eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMT1TB7XfSJBj/+tBWjvgKiWp2F+0pMn9c2waCApVdxu/HF+GfrpMmdirT3YrVQCH0oBktd1VDG00nmydCU5ZzD8dBQBzgqN05sBTcxxaW2bW7KexESol5ch+LOuofe3B4XJ9tr+Og7jMArqd7QvsyAGcH72kISFwXGjAibZdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fYTAnl9w; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713251691;
	bh=l/YgE2jHDgEGiO5tZpMnwUUm+KuVZjmQoNRva6TC6eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fYTAnl9wUuwE0R1aGy712w49sD5mzXirOnwJn5yVauxOU6KFy6Gz24C2YdlxEtwYI
	 Kn8fJUyYWUBpSi09VisqJE+/5wl1GlIP3jbqJbzH5+hLmca2ODeSLom20TZMC7jdnz
	 2HWGvaZBYHLCZDmpMmxyyV1kkjLR3nBh3p4zG0YB0g2+UiNsO+MeTKUg6eUXMfkZUd
	 SO+P1i//UHG5gT/rl8dy5lkmGFs3AoGtqNNDH1xyen6CK7tcRPRne8rS25cYLfeZae
	 8DU9hTs8SSnvyLIpAFJ55vnpNmP//g9LcRRO+cUb6SFooBaVHG5LeZOKoahqeo529r
	 m3F/4ift/AqHw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AF68A3782123;
	Tue, 16 Apr 2024 07:14:49 +0000 (UTC)
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
Subject: [PATCH v5 14/18] ASoC: dt-bindings: mt8195: Document audio-routing and dai-link subnode
Date: Tue, 16 Apr 2024 09:14:06 +0200
Message-ID: <20240416071410.75620-15-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416071410.75620-1-angelogioacchino.delregno@collabora.com>
References: <20240416071410.75620-1-angelogioacchino.delregno@collabora.com>
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
used with driver hardcoded configuration.

Also, since describing machine specific audio hardware and links replaces
the now deprecated old logic doing the same in a driver hardcoded fashion,
it is not allowed to have both the old and new properties together.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/sound/mt8195-mt6359.yaml         | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
index c1ddbf672ca3..2af1d8ffbd8b 100644
--- a/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml
@@ -12,6 +12,9 @@ maintainers:
 description:
   This binding describes the MT8195 sound card.
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     enum:
@@ -23,6 +26,33 @@ properties:
     $ref: /schemas/types.yaml#/definitions/string
     description: User specified audio sound card name
 
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
+        - Ext Spk
+        - Headphone
+        - IN1P
+        - Left Spk
+        - Right Spk
+
+        # Sources
+        - Headset Mic
+        - HPOL
+        - HPOR
+        - Left BE_OUT
+        - Left SPO
+        - Right BE_OUT
+        - Right SPO
+        - Speaker
+
   mediatek,platform:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: The phandle of MT8195 ASoC platform.
@@ -30,10 +60,12 @@ properties:
   mediatek,dptx-codec:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: The phandle of MT8195 Display Port Tx codec node.
+    deprecated: true
 
   mediatek,hdmi-codec:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: The phandle of MT8195 HDMI codec node.
+    deprecated: true
 
   mediatek,adsp:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -45,20 +77,122 @@ properties:
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
+        enum:
+          - DPTX_BE
+          - ETDM1_IN_BE
+          - ETDM2_IN_BE
+          - ETDM1_OUT_BE
+          - ETDM2_OUT_BE
+          - ETDM3_OUT_BE
+          - PCM1_BE
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
 
+# Disallow legacy properties if xxx-dai-link nodes are specified
+if:
+  not:
+    patternProperties:
+      ".*-dai-link$": false
+then:
+  properties:
+    mediatek,dptx-codec: false
+    mediatek,hdmi-codec: false
+
 examples:
   - |
 
     sound: mt8195-sound {
         compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
+        model = "mt8195_r1019_5682";
         mediatek,platform = <&afe>;
         pinctrl-names = "default";
         pinctrl-0 = <&aud_pins_default>;
+
+        audio-routing =
+                "Headphone", "HPOL",
+                "Headphone", "HPOR",
+                "IN1P", "Headset Mic",
+                "Ext Spk", "Speaker";
+
+        mm-dai-link {
+                link-name = "ETDM1_IN_BE";
+                mediatek,clk-provider = "cpu";
+        };
+
+        hs-playback-dai-link {
+                link-name = "ETDM1_OUT_BE";
+                mediatek,clk-provider = "cpu";
+                codec {
+                        sound-dai = <&headset_codec>;
+                };
+        };
+
+        hs-capture-dai-link {
+                link-name = "ETDM2_IN_BE";
+                mediatek,clk-provider = "cpu";
+                codec {
+                        sound-dai = <&headset_codec>;
+                };
+        };
+
+        spk-playback-dai-link {
+                link-name = "ETDM2_OUT_BE";
+                mediatek,clk-provider = "cpu";
+                codec {
+                        sound-dai = <&spk_amplifier>;
+                };
+        };
+
+        hdmi-dai-link {
+                link-name = "ETDM3_OUT_BE";
+                codec {
+                        sound-dai = <&hdmi_tx>;
+                };
+        };
+
+        displayport-dai-link {
+                link-name = "DPTX_BE";
+                codec {
+                        sound-dai = <&dp_tx>;
+                };
+        };
     };
 
 ...
-- 
2.44.0


