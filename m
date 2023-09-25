Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B927ACEB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjIYDWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIYDWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:22:38 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5440EA3;
        Sun, 24 Sep 2023 20:22:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 06D9FE0003;
        Mon, 25 Sep 2023 03:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695612148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eKfAb9dM9HwZutIwv6iuMVTU5vDPqNRcb/JuqRISlpc=;
        b=VYt2ld/QSBksI0sK2Zb46u9XVVfPjTn+ibxWXtoA+pc620ovzyeEntnjzlvCAWCFceT+pG
        a/p7P0jBbPvahwhzyGOpVnetQEpg0OlyrPnSVZGyQT5Jc7l0zzc0eetc+dpFacxx9LJPJ+
        PfkFvFoDlaMhlW+SkV1SMssyrKqrL6d4NFPBddhshLa3nLcJjxtnHAggc7NAmE7Muoa7Mp
        9/uGhVP8jRcbYtsciTHcBcd8bcqBMFj04jcspIv5oaALRElxGX5uukVYjy6yBGF/U/EDun
        06AfTT3VLpyJ6a214vLYKBZ4hSp9fNQ555dbYhW7VUnDbiWHEmQJGZV9cUymOw==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     devicetree@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2] dt-bindings: input: touchscreen: goodix: clarify irq-gpios misleading text
Date:   Mon, 25 Sep 2023 05:22:08 +0200
Message-Id: <20230925032208.11698-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq-gpios description misleading, apparently saying that driving the
IRQ GPIO resets the device, which is even more puzzling as there is a reset
GPIO as well.

In reality the IRQ pin can be driven during the reset sequence to configure
the client address, as it becomes clear after checking both the datasheet
and the driver code. Improve the text to clarify that.

Also rephrase to remove reference to the driver, which is not appropriate
in the bindings.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v2:
 - reworded to clarify even further
---
 .../devicetree/bindings/input/touchscreen/goodix.yaml        | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
index 3d016b87c8df..2a2d86cfd104 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
@@ -37,8 +37,9 @@ properties:
     maxItems: 1
 
   irq-gpios:
-    description: GPIO pin used for IRQ. The driver uses the interrupt gpio pin
-      as output to reset the device.
+    description: GPIO pin used for IRQ input. Additionally, this line is
+      sampled by the device on reset deassertion to select the I2C client
+      address, thus it can be driven by the host during the reset sequence.
     maxItems: 1
 
   reset-gpios:
-- 
2.34.1

