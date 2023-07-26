Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4ED762CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjGZHKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjGZHJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:09:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EF555BF;
        Wed, 26 Jul 2023 00:06:45 -0700 (PDT)
Received: from eugen-station.. (unknown [82.76.24.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A02CC6607115;
        Wed, 26 Jul 2023 08:06:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690355187;
        bh=iz0YvQ3fnQ9vjxmywIwYRGMCuKmZv1tpf33ccDhklTc=;
        h=From:To:Cc:Subject:Date:From;
        b=UZUUdkhhH4JX93a4W1Gq/45Jt2H5arXOhIrMz0YvKRZl45tpQLrhi0UHtRwg+QxAj
         1I9tNi9nl0jSWJ5Ws9d5RVCPajRg6V+ikrD8OgSGRCM+G7hwdGuCA6Vaz/mzhU7Aoa
         Yiju2Bs/nmq2pZhA/SBRs5ZuKMnPGcGHd26g2TZnQOwxt007Nly4s2mC39Komd7sEJ
         45f/rnwKqFo8mvq2eJHhsqOEkvcQThcoIRb0PXloEg3V6feCYhk4iN4hZBYYXYGkzT
         InHAOlZVLMqB7EC9dHHSf8FdY5PciM2lJ4GUKQpH4s3EwenPqzaAAx/U4SnvJ1ZSdv
         FF/MIJjZsY0ag==
From:   Eugen Hristev <eugen.hristev@collabora.com>
To:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     david.wu@rock-chips.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com,
        Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v2] dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay defaults/range in schema
Date:   Wed, 26 Jul 2023 10:06:15 +0300
Message-Id: <20230726070615.673564-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The range and the defaults are specified in the description instead of
being specified in the schema.
Fix it by adding the default value in the `default` field and specifying
the range as `minimum` and `maximum`.

Fixes: b331b8ef86f0 ("dt-bindings: net: convert rockchip-dwmac to json-schema")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
changes in v2:
- also move the range as minimum/maximum in the schema

 .../devicetree/bindings/net/rockchip-dwmac.yaml        | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index bb943c96c196..70bbc4220e2a 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -92,12 +92,18 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
 
   tx_delay:
-    description: Delay value for TXD timing. Range value is 0~0x7F, 0x30 as default.
+    description: Delay value for TXD timing.
     $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0x7F
+    default: 0x30
 
   rx_delay:
-    description: Delay value for RXD timing. Range value is 0~0x7F, 0x10 as default.
+    description: Delay value for RXD timing.
     $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0x7F
+    default: 0x10
 
   phy-supply:
     description: PHY regulator
-- 
2.34.1

