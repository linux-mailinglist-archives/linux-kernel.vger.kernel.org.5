Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388F1752ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjGNBi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjGNBiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:38:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A614730C6;
        Thu, 13 Jul 2023 18:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58E7A61BF0;
        Fri, 14 Jul 2023 01:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100CAC433BA;
        Fri, 14 Jul 2023 01:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689298687;
        bh=nF3EmHcWtWLkDXimiim466Bc4X1g6roUx9bQ5B5nTbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcGm+D1MFbHeRrqPgs09yEHJ6hehNFtSasXHXiCZuIaxuERiQyVdeijfqnXsOqxO6
         lQB1VVq0EEPdIzXfdQ9BlLMg7tKl21kHAGdGT9gRizA2x3n++ZvgIiNnPOUI1yayLS
         t4dTkGuqB4Vl5eddSjAzcwU8NuFP//QGaItP4bAhtE5424LER77xSxI0FDratLQGQM
         dKBpUE+8vwKtGwLygQdxWsm02ojpJnl5CMglOYqHggudOtYrMm6cQWlvuXn9SGQCJi
         rQsg/F4OrDDliadPUrreGgrrT2mG+cp3/YSPKuNkmTKjPl7807ev7IiRhLt+zima2u
         uLmqbAsCnHATg==
Received: by mercury (Postfix, from userid 1000)
        id F0C5910676F7; Fri, 14 Jul 2023 03:37:58 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 15/19] dt-bindings: display: st7789v: bound the number of Rx data lines
Date:   Fri, 14 Jul 2023 03:37:52 +0200
Message-Id: <20230714013756.1546769-16-sre@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714013756.1546769-1-sre@kernel.org>
References: <20230714013756.1546769-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

The ST7789V LCD controller supports regular SPI wiring, as well as no Rx
data line at all. The operating system needs to know whether it can read
registers from the device or not. Let's detail this specific design
possibility by bounding the spi-rx-bus-width property.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Tested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../devicetree/bindings/display/panel/sitronix,st7789v.yaml   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
index 9f4157b02b84..905c064cd106 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
@@ -29,6 +29,10 @@ properties:
   spi-cpha: true
   spi-cpol: true
 
+  spi-rx-bus-width:
+    minimum: 0
+    maximum: 1
+
   dc-gpios:
     maxItems: 1
     description: DCX pin, Display data/command selection pin in parallel interface
-- 
2.40.1

