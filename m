Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A575760F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjGYJ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjGYJ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:28:10 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AE44216;
        Tue, 25 Jul 2023 02:26:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 2A26440006;
        Tue, 25 Jul 2023 09:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690277163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/7VRBWCE3zQkjZUnwqNM+hf1oXBkNM8jqaefsT3cImE=;
        b=Gt6FasdCK1y9iOK5dlqpx1KvrhbGV7fd8/BtCu7DUhiXguTHlWVJajWZUzkbe/jOYIW+a1
        EQkV5yuPW79QZHp8XY365fScCFPV5cK+ajMI5ZE5DvaSehrCEDatuOIdv5acuv8pssFGMl
        X0GwsbiYiJU2UZV0CRKtGb3225UrU7JaZK/z37kgW3UGJnmmkxejDlDOOJLi2eQzvkztyf
        eo1C+2uTw+RCYxm5OeXfSoiYJJZNRr19fF1DxyC1GaWdg2UOCzImA2XLgkF5jURzOJzk8p
        MxA//vOLiETfZ4DDUx7tl6m+MWpD6YNB3H7YLpwFzlS+Nw1DHjW3wqL/wn6xCg==
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
Subject: [PATCH 25/26] dt-bindings: net: fsl,qmc-hdlc: Add framer support
Date:   Tue, 25 Jul 2023 11:24:01 +0200
Message-ID: <20230725092417.43706-26-herve.codina@bootlin.com>
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

A framer can be connected to the QMC HDLC.
If present, this framer is the interface between the TDM used by the QMC
HDLC and the E1/T1 line.
The QMC HDLC can use this framer to get information about the line and
configure the line.

Add an optional framer property to reference the framer itself.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
index 8bb6f34602d9..bf29863ab419 100644
--- a/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
@@ -27,6 +27,11 @@ properties:
       Should be a phandle/number pair. The phandle to QMC node and the QMC
       channel to use.
 
+  framer:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the framer node
+
 required:
   - compatible
   - fsl,qmc-chan
-- 
2.41.0

