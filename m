Return-Path: <linux-kernel+bounces-81558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3104A867790
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E381F24104
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F76F12B171;
	Mon, 26 Feb 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jaEfZJGZ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7748129A9D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956133; cv=none; b=NXiNt2xbvK1Jr35k1HQfTKqExFsrzvs43WWRt3kNBv5prxGf9VugZIQVaUgrrVWUAAAMqIX5wZlvIc/aMFEbPr82AJwPTexCApN5IQb5Ez31YMo8iYd86vXuzh7H8xuoMuSSBu/iFUKDlV7mLwPzxhxFp9LaAA6wDfnv5JEE1oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956133; c=relaxed/simple;
	bh=RB7Eb842OpfsNPEOj+50LxyJbOuZfxgXUF/IRPIlUPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mYKfgvQZ3618oFGnEx8I3ThzuPHwT/drrhaa3BupCuhuHbZ01ErpSHquJHtAX8qeeydAS10AC5MqY+EGLmNvHCaYM3MJq2JjKqc20d/LSofsgFJg+yQbbXmx564pUf5MrI5iGiiDt4kyRqqktVvK7696elMxw/C4tIG39N3/hoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jaEfZJGZ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d23a22233fso30419161fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708956130; x=1709560930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJrWsRR3ts/FqJ8eyXIf3fjxmrfS3S4Qmfe209Uxc5s=;
        b=jaEfZJGZTuMWv/2ajCyFsOmpVp7xFe8Tn187QpqMiYCROzwNuOVf0ykVEGGxSuqmXs
         6w4Y2g9MriLE49eaSsp/Pt1UIWfqK9ggnX7GrD9cxw4qLuJA39+/TCUEHZD2sfhz7ENV
         JHdYMsxAHFl7gxIKAtmkQrN4afXFZh3XdH3ZIdqqVvUM+pWpvR32dxE+WbPHC2U0+p9C
         vTa82jQzR5m7l5nUeBbANZuedG29tpZXksWqbE1I+IhPHrYiM0ZRurSx3YuZ019mWBL5
         ryE88OJ72ZrbA9di0+ixIG/yDajU6tEAVBLfc1qiybsyBxtb0y0feTrccv8bA1Mf/tDn
         pNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708956130; x=1709560930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJrWsRR3ts/FqJ8eyXIf3fjxmrfS3S4Qmfe209Uxc5s=;
        b=qEPyLU5ui+BZSeyn1gaFH3HmO0qc0GLUbdr65/RrH5BA8FuKB8mWbvDRcJeHY0Gx6V
         DmBm0wHxCxX0JKsD4CICZoeoaefAIlSOiY+oCz7RZGFQEsMCnJGokzxMKankLhymaIR8
         wAxNS/fMu4qu1TdjfFMmUHUmlGlAsYjBkf0sVsWyIKg7NnyrDn/AXoAxAyStF5UIrGjg
         EZaSXOGlSb3HIre7xge90c1KzfhqdELiJePboBZdWk0JvfYLUFsO4WSrCIOyEzSfT59k
         aaI43ANPoUM5MAuuMGTyshmWoJKr+Z0Ql2JReiU/z+o0wXpSJIz538avjcw+4LtOUUnp
         Q1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWPD5qaNeoT1d5udEFcXpWqkZz21s7vxVmVGfvQtF2+Wi9gJoPhUIIC3+IVesyfTaild6OZwU67nax4VBa1sPSXebwISET7W/Eo+noV
X-Gm-Message-State: AOJu0YxuU95Wq83mWDBEQQLe0aDhYL31WydYWbXWChbAnhxOSVxvY0dD
	EF75xr3NKyON+A8QFxmcWe2bfpj7K4mlwvUnnjPwkiuvNITDH5acAitaRnWh67g=
X-Google-Smtp-Source: AGHT+IHDZFe0UVmHW49F9REvA6iVNdf2dZuGdONwBfA2sUMFo7E6cmXdifUIZXkHWrSREuG4kPnzdg==
X-Received: by 2002:a2e:be87:0:b0:2d2:6200:e661 with SMTP id a7-20020a2ebe87000000b002d26200e661mr5150052ljr.51.1708956129400;
        Mon, 26 Feb 2024 06:02:09 -0800 (PST)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d33-20020a05600c4c2100b004129f87a2c6sm2838475wmp.1.2024.02.26.06.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 06:02:08 -0800 (PST)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Mon, 26 Feb 2024 15:01:40 +0100
Subject: [PATCH 02/18] ASoC: dt-bindings: mediatek,mt8365-mt6357: Add audio
 sound card document
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v1-2-4fa1cea1667f@baylibre.com>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
In-Reply-To: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3936; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=RB7Eb842OpfsNPEOj+50LxyJbOuZfxgXUF/IRPIlUPQ=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBl3JncV4ua0Er/v7s+bW1PDrfmI/r/eo2np+/0blY8
 AicPQtaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZdyZ3AAKCRArRkmdfjHURURJEA
 CStUBeJ8/Qq1vZrA9KzH/y9WMN4PUjkealopyiDxH2qcK9wceUHZ4XqZmjdR/w3HnZhoIEp7+nhb6t
 gNCBBTKKTYkEJeKnWFcOIzshxvUF3v880968wo+j6XkCJCNUVgU2uoGLi80iv9Cw4s+xAtGl68DE1t
 MKCtsl8/Z2h03HWmM4/D27mxa0Ynh5VWIwkSpSieqrWD/2CYW9gyq4Q4NltQlg1IVzkkMNdYaviq+R
 dE3BR6wwx45UfG1JocWbN4FjhgScINA5hy9LfRLLAGIeqX/xFbz3RetQ4jPMBrFhAUbqm6QXiXJ8HU
 BRV7RGXS8LjeCFo6Gb8TuYFpNd7aEJW4VZvf8KWmbW6Q08u5cLlhW05R4zSoUmkVd35n0ivv2mJbBW
 asIyHtP42GeCvbK1uQXZCcXp527nW5H4i6AZtE3r4m24MaQykrCkwyo/Xg5Azbk4scn4Z2U0jk1+jl
 0QvZ41IRAuHvwsnsYEqAyrdXpwiPzLlW1a6slshF0sMLqHd6x7n5I5PbzyQMUw3dnTz/iRHgEJhh1A
 hGZcPtokNWAOYXe2iajGauzr5KlUWa0Cyg650ze7IlYW3UyArh4ZQ60L19ovBJB1FWvYxIOyHXKm0b
 SaN/2bFaJirdgpXsM6Ux4tFyasECdxgDza7JsQDXacXggb49zGECpPRc/5ig==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add soundcard bindings for the MT8365 SoC with the MT6357 audio codec.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../bindings/sound/mediatek,mt8365-mt6357.yaml     | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml
new file mode 100644
index 000000000000..f469611ec6b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt8365-mt6357.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT8365 sound card with MT6357 sound codec.
+
+maintainers:
+  - Alexandre Mergnat <amergnat@baylibre.com>
+
+description:
+  This binding describes the MT8365 sound card.
+
+properties:
+  compatible:
+    const: mediatek,mt8365-mt6357
+
+  mediatek,hp-pull-down:
+    description:
+      Earphone driver positive output stage short to the
+      audio reference ground.
+      Default value is false.
+    type: boolean
+
+  mediatek,micbias0-microvolt:
+    description: |
+      Selects MIC Bias 0 output voltage.
+      [1.7v, 1.8v, 1.9v, 2.0v, 2.1v, 2.5v, 2.6v, 2.7v]
+    enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
+  mediatek,micbias1-microvolt:
+    description: |
+      Selects MIC Bias 1 output voltage.
+      [1.7v, 1.8v, 1.9v, 2.0v, 2.1v, 2.5v, 2.6v, 2.7v]
+    enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
+  mediatek,platform:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of MT8365 ASoC platform.
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: aud_default
+      - const: aud_dmic
+      - const: aud_miso_off
+      - const: aud_miso_on
+      - const: aud_mosi_off
+      - const: aud_mosi_on
+
+  vaud28-supply:
+    description:
+      2.8 volt supply for the audio codec
+
+patternProperties:
+  "^dai-link-[0-9]+$":
+    type: object
+    description:
+      Container for dai-link level properties and CODEC sub-nodes.
+
+    properties:
+      codec:
+        type: object
+        description: Holds subnode which indicates codec dai.
+
+        properties:
+          sound-dai:
+            maxItems: 1
+            description: phandle of the codec DAI
+
+        additionalProperties: false
+
+      link-name:
+        description:
+          This property corresponds to the name of the BE dai-link to which
+          we are going to update parameters in this node.
+        items:
+          const: 2ND I2S BE
+
+      sound-dai:
+        maxItems: 1
+        description: phandle of the CPU DAI
+
+    additionalProperties: false
+
+    required:
+      - link-name
+      - sound-dai
+
+additionalProperties: false
+
+required:
+  - compatible
+  - mediatek,platform
+  - pinctrl-names
+  - vaud28-supply
+
+examples:
+  - |
+    sound {
+        compatible = "mediatek,mt8365-mt6357";
+        mediatek,platform = <&afe>;
+        pinctrl-names = "aud_default",
+            "aud_dmic",
+            "aud_miso_off",
+            "aud_miso_on",
+            "aud_mosi_off",
+            "aud_mosi_on";
+        pinctrl-0 = <&aud_default_pins>;
+        pinctrl-1 = <&aud_dmic_pins>;
+        pinctrl-2 = <&aud_miso_off_pins>;
+        pinctrl-3 = <&aud_miso_on_pins>;
+        pinctrl-4 = <&aud_mosi_off_pins>;
+        pinctrl-5 = <&aud_mosi_on_pins>;
+        vaud28-supply = <&mt6357_vaud28_reg>;
+
+        /* hdmi interface */
+        dai-link-0 {
+            sound-dai = <&afe>;
+            link-name = "2ND I2S BE";
+
+            codec {
+                sound-dai = <&it66121hdmitx>;
+            };
+        };
+    };

-- 
2.25.1


