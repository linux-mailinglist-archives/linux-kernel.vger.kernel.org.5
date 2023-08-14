Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F0377B5A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjHNJkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbjHNJjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:39:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D588CE71;
        Mon, 14 Aug 2023 02:39:40 -0700 (PDT)
Received: from eugen-station.. (unknown [86.127.70.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C34966071A3;
        Mon, 14 Aug 2023 10:39:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692005979;
        bh=ReQu8PlNQ3B+RBTqaF0mmwCVGrAXcC7wZ1rVXE/sQWg=;
        h=From:To:Cc:Subject:Date:From;
        b=M8Ca4aLb3WE+Q4DJJJQ067zA0ycljgRWSx763eFg5TmROuoK9lASVtpzn5vnV1MJ6
         rJurNQBtBBAz+RnSBs9tVLUNP15VWi5RoR4++7wTkZ+L9rdgNmjmBG8yo1lhGsAZV5
         iWPU1pRwpvnBPFpNTEV+UQY1BNxGjC/6DarevfEqEXuBboIg4Z8syGF9jMb/VMkigj
         FAfBuV1Iq63HpHktATW1U0t2KT7GkNdnia9/8uHgHw8PI4VEvbQu/pZVzAqATpfsrR
         yx7UQ5F9u9pZe3egS2YZEylFdiOd+t+fDCe/k+qazHnNPRCq4Vin1X1oNWkFz19lkU
         dVHxDJCX3vvlQ==
From:   Eugen Hristev <eugen.hristev@collabora.com>
To:     linux-mediatek@lists.infradead.org
Cc:     chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sam.shih@mediatek.com,
        jieyy.yang@mediatek.com, frank-w@public-files.de,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chris.obbard@collabora.com,
        kernel@collabora.com, Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: mediatek,tphy: allow simple nodename pattern
Date:   Mon, 14 Aug 2023 12:39:30 +0300
Message-Id: <20230814093931.9298-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v2:
- none
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

