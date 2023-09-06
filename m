Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E287793884
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjIFJly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjIFJlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:41:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B810F8;
        Wed,  6 Sep 2023 02:41:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD1DC433CC;
        Wed,  6 Sep 2023 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693993310;
        bh=uvMohTUIVeiywkoIARLtBnL5Gws4wgsW2IQCs1Sn+FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PXhbeW8TylgrJVIWVzkejuVUN4CAiGALmQGlve6e415+0FfoMICdfFr9IMpJ0J8rk
         TASjBwhpcefpF0KfzNw5pMSNykSZfRqnxvpaxygvQtdALy/FEOIAjH4JevNbVPyNv8
         bLSSaWqU4V+UzELmF2UOYXvqi42IGHUgTlJRnY6b7hKW5yGdoOGzSrQyfTV1y47FZy
         1WTq+pLcS/qKFEyKrozmhj3UJbaSKF2n+cfqJQszaVFsThnXLPNvR5KN2kjkJYUG7X
         gEusb6JcBwt5cjDviwT+WpK33i6trvxaJIBrdSCTMH+vvkOpKcWckVMEC6frbJtWod
         ms4OqKTGWehvg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller: arm,gic-v3: Add dma-noncoherent property
Date:   Wed,  6 Sep 2023 11:41:38 +0200
Message-Id: <20230906094139.16032-2-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906094139.16032-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230906094139.16032-1-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GIC v3 specifications allow redistributors and ITSes interconnect
ports used to access memory to be wired up in a way that makes the
respective initiators/memory observers non-coherent.

Add the standard dma-noncoherent property to the GICv3 bindings to
allow firmware to describe the redistributors/ITSes components and
interconnect ports behaviour in system designs where the redistributors
and ITSes are not coherent with the CPU.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rob Herring <robh@kernel.org>
---
 .../bindings/interrupt-controller/arm,gic-v3.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 39e64c7f6360..c9bc9aad93f1 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -106,6 +106,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     maximum: 4096
 
+  dma-noncoherent:
+    description:
+      Present if the GIC redistributors permit programming shareability
+      and cacheability attributes but are connected to a non-coherent
+      downstream interconnect.
+
   msi-controller:
     description:
       Only present if the Message Based Interrupt functionality is
@@ -193,6 +199,12 @@ patternProperties:
       compatible:
         const: arm,gic-v3-its
 
+      dma-noncoherent:
+        description:
+          Present if the GIC ITS permits programming shareability and
+          cacheability attributes but are connected to a non-coherent
+          downstream interconnect.
+
       msi-controller: true
 
       "#msi-cells":
-- 
2.34.1

