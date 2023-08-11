Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7377905F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjHKNIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbjHKNHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:07:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D8F3582;
        Fri, 11 Aug 2023 06:07:22 -0700 (PDT)
Received: from eugen-station.. (unknown [82.76.24.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F38F0660724A;
        Fri, 11 Aug 2023 14:07:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691759238;
        bh=VXusoYfjHaf1R8Q5raJ4gZK4qcwaz24tSqOkD12Aa0A=;
        h=From:To:Cc:Subject:Date:From;
        b=m8YQ5hghF7NJPiDxoc0eVVVZW0KT3+2lKdL7KpjLs3T6BxQzGVqflAELP09jpQOva
         HlTaaoipnyBpu/3hJSrIVt4UDpTzRWTR4qmJhHq9X8Azx4jDM7yZizsCCk3H3t1Fhb
         ceQ30FZ58AU7DW3MyV5yuuYLrnAwLkSwn2zYf4C/fRHCrPtY36/oyHHugo0IlG4sE1
         l/DJM/FmWQsaF94awvFv8xWprPaUGPYDcV0QQPw7J3kx0HwW0xFh6B8SDTexcgr11o
         1DPHnpoDWquQy189H7EWvcmQUQPP3Hib3n7MMGjmeJ0749lDj6aXjNAfQkb7dzxTCV
         D4KR5yNet74cA==
From:   Eugen Hristev <eugen.hristev@collabora.com>
To:     linux-mediatek@lists.infradead.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        kernel@collabora.com, Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH 1/2] dt-bindings: phy: mediatek,tphy: allow simple nodename pattern
Date:   Fri, 11 Aug 2023 16:06:59 +0300
Message-Id: <20230811130700.72787-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern for the nodename only allows t-phy@... , however, for the case
when the t-phy has no `reg` and only `ranges` (basically when the t-phy
is just a parent node), dtc will throw this warning:

Warning (unit_address_vs_reg): /t-phy@1a243000: node has a unit name, but no reg or ranges property

For a node like this:

	sata_phy: t-phy@1a243000 {
		ranges;

		sata_port: sata-phy@1a243000 {
			reg = <0 0x1a243000 0 0x0100>;
		};
	};

it is normal that the parent node 't-phy' would be without any address, as in:

	sata_phy: t-phy {
		ranges;

		sata_port: sata-phy@1a243000 {
			reg = <0 0x1a243000 0 0x0100>;
		};
	};

because being just a holder it does not have its own reg.

However the binding does not allow such a name for the t-phy, so with this
patch, making the `@[0-9a-f]+` part optional, such node is possible.

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
index 230a17f24966..2bb91542e984 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
@@ -64,7 +64,7 @@ description: |
 
 properties:
   $nodename:
-    pattern: "^t-phy@[0-9a-f]+$"
+    pattern: "^t-phy(@[0-9a-f]+)?$"
 
   compatible:
     oneOf:
-- 
2.34.1

