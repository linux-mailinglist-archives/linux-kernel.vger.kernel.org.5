Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0477985D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbjHKUPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbjHKUPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:15:11 -0400
Received: from out-79.mta1.migadu.com (out-79.mta1.migadu.com [IPv6:2001:41d0:203:375::4f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D9135A7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:15:08 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691784906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hW1ak8KgoejCSW9QrrxKnaZZBYUUgvs8EvZwonWW7Q=;
        b=CD4lRSohS0DnXE6VQTtKXerkV30clc05gHhy1KjszANLvk8PDxlFSV7Qua/nro9kKonJHc
        e8eoHeaLZp5s7KZlNwDK34rkKsUWBfUCmWTCwRWVwy5QVgHHMZM8sSork3+go0HP+WS2zL
        +wBm7nWZHqrkbT8zDGGfazKRPg1VK2rWYNYP0YW6raQ/isdg1uta45WuZX3DZboZBPOXsr
        DA0c5ijB5Kpf3Kj+R7DF+Ni0j9/bqE9IkI7pP9wCtKYgDEMMQjTSXd1APKUViWkkroB+Sh
        CrJoPs2fjzC35iszArbzoMgCTxYKK2L00BJPuquI4sL0bH08DFY/JDbOupdFfg==
From:   John Watts <contact@jookia.org>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, John Watts <contact@jookia.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/7] dt-bindings: sound: sun4i-i2s: Add channel-dins property
Date:   Sat, 12 Aug 2023 06:14:05 +1000
Message-ID: <20230811201406.4096210-7-contact@jookia.org>
In-Reply-To: <20230811201406.4096210-1-contact@jookia.org>
References: <20230811201406.4096210-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R329 variant of the sun4i I2S controller supports multiple
data input pins (din pins) for receiving data. Each channel can have
its data input pin configured.

Allow this to be configured using a new channel-dins property.

Signed-off-by: John Watts <contact@jookia.org>
---
 .../sound/allwinner,sun4i-a10-i2s.yaml        | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index 739114fb6549..402549f9941c 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -52,6 +52,13 @@ properties:
       - const: apb
       - const: mod
 
+  channel-dins:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description:
+      This is a list of DIN pin numbers, each used for a receiving I2S
+      channel. Pins are mapped to channels based on array index.
+      Channel 0 is the first number, then channel 1, and so on.
+
   # Even though it only applies to subschemas under the conditionals,
   # not listing them here will trigger a warning because of the
   # additionalsProperties set to false.
@@ -144,4 +151,19 @@ examples:
         dma-names = "rx", "tx";
     };
 
+  - |
+    i2s0_d1: i2s@2032000 {
+            #sound-dai-cells = <0>;
+            compatible = "allwinner,sun20i-d1-i2s",
+                         "allwinner,sun50i-r329-i2s";
+            reg = <0x2032000 0x1000>;
+            interrupts = <0 26 0>;
+            clocks = <&ccu 86>, <&ccu 82>;
+            clock-names = "apb", "mod";
+            resets = <&ccu 34>;
+            dmas = <&dma 3>, <&dma 3>;
+            dma-names = "rx", "tx";
+            channel-dins = /bits/ 8 <0 0 1 1 2 2>;
+    };
+
 ...
-- 
2.41.0

