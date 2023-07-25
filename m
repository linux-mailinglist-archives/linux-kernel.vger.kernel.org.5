Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E92760EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjGYJZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjGYJZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:25:14 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A1519F;
        Tue, 25 Jul 2023 02:25:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id F1BF840008;
        Tue, 25 Jul 2023 09:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690277104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Yo43qISdINrTXoBGMrpCx+B9kqhLajfGlqFUUD8Czs=;
        b=hlCdvQbxeve6hG8yi+7vxdIc1azx1JXyYRmkFu+1UKc2rJ6kabWxhF10Bed1z4BWDmpcWp
        v41Zmf6DNeCiZ9UvSBGTcTCCDWYF2Xmg5Bcf4mwA+Ed9seDLsvKKykjiNZHLi29VicVUAI
        eP2d51mb+rsvNBqlhWmVM0dXU9ZJoGxvwqV7lvg8soHb7latBvHKf5oZJIkDCbtDieG2lf
        6AWrkKgYGqd59gHU2ZnpBNUdLLpXgSBmD/Czh4QFay4ZIjMOn0Jrv+rEu7Hake71o5eIGy
        Ic6vErwVpLHEw8Pu6XDMoljzP9RDqV/bdISilESfSiWnN/HKC1eij4MwrgJ6Tg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 03/26] dt-bindings: net: Add support for QMC HDLC
Date:   Tue, 25 Jul 2023 11:23:39 +0200
Message-ID: <20230725092417.43706-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725092417.43706-1-herve.codina@bootlin.com>
References: <20230725092417.43706-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMC (QUICC mutichannel controller) is a controller present in some
PowerQUICC SoC such as MPC885.
The QMC HDLC uses the QMC controller to transfer HDLC data.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../devicetree/bindings/net/fsl,qmc-hdlc.yaml | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml

diff --git a/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
new file mode 100644
index 000000000000..8bb6f34602d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,qmc-hdlc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QMC HDLC
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  The QMC HDLC uses a QMC (QUICC Multichannel Controller) channel to transfer
+  HDLC data.
+
+properties:
+  compatible:
+    const: fsl,qmc-hdlc
+
+  fsl,qmc-chan:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to QMC node
+          - description: Channel number
+    description:
+      Should be a phandle/number pair. The phandle to QMC node and the QMC
+      channel to use.
+
+required:
+  - compatible
+  - fsl,qmc-chan
+
+additionalProperties: false
+
+examples:
+  - |
+    hdlc {
+        compatible = "fsl,qmc-hdlc";
+        fsl,qmc-chan = <&qmc 16>;
+    };
-- 
2.41.0

