Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BB1768725
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjG3Sl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 14:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3Sl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:41:56 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA5C10EB;
        Sun, 30 Jul 2023 11:41:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [109.229.201.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id B15C01600D2;
        Sun, 30 Jul 2023 20:41:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1690742508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rIjfNf3fQPSIJXgNJjDjWAUn7CeY7yXp/BQkpmY3epQ=;
        b=CycAV7ChKq2GloUgehfEl15dM8rK9D3uF/5ePIdk30DtoU1v0oXBWHG9daaEt4f077Kdjw
        qG9qZcwZ72MF8Pb5DsMy6MAHgp95SbugvVfeEfOWo+QXLq/1Bm0dpEpXDiAvVFeKhfVBuv
        e+zhTts70Lw6NtQ03qIPODtzp3P/2q0=
From:   David Heidelberg <david@ixit.cz>
To:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liu Ying <victor.liu@nxp.com>
Cc:     kernel@puri.sm, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mxsfb: Exclude i.MX8MQ from power-domains requirement
Date:   Sun, 30 Jul 2023 21:41:20 +0300
Message-Id: <20230730184120.94984-1-david@ixit.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MQ uses as secondary compatible fsl,imx6sx-lcdif, which triggers
requirement of power-domains, thou it's not required.

Fixes: f62678a77d58 ("dt-bindings: mxsfb: Document i.MX8M/i.MX6SX/i.MX6SL power-domains property")

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/display/fsl,lcdif.yaml        | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
index fc11ab5fc465..2d868276b0f9 100644
--- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
+++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
@@ -129,8 +129,15 @@ allOf:
               - fsl,imx8mp-lcdif
               - fsl,imx93-lcdif
     then:
-      required:
-        - power-domains
+      if:
+        properties:
+          compatible:
+            not:
+              contains:
+                const: fsl,imx8mq-lcdif
+      then:
+        required:
+          - power-domains
 
 examples:
   - |
-- 
2.40.1

