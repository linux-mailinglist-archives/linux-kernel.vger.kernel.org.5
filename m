Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F607BB855
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjJFM7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjJFM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:59:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A36ECA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:59:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA64C433CC;
        Fri,  6 Oct 2023 12:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696597180;
        bh=iOWyeF/KRwGpiqZfKpX3chHM50vO4O6sz4uB89KKvbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m1zaLxvxNrq/JKivnpB19VtMWfwwpgXr53MZ4plq4TD5Lv6tqCzOQzjEtI4kwUqq9
         fW9g2+YNXBj8Tty4Pki+pG/9Jr8ruf+WVYddCHdV/Hifx/TM9Cii+EpmmhEDz7rJZx
         LYzmf6m0uPyOYlNJKDDO1E/NCl+NVWMDWaovub0H+a0q34H6WFgiF8EM5VABHOiZVy
         gM6FYvgiS3HA/9XVKi8XNo8w0ePseSOejkcZyPPFC+uu1LCPfzMVPjtLhOZIxx38SP
         tVysBsxR2fxYfEtuv6Bvr5+kB27ShcKNgWyghtZM8zMHgXGh3rDNtTJE6ytlKLa1tM
         T9CikPZ4LOCIQ==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: interrupt-controller: arm,gic-v3: Add dma-noncoherent property
Date:   Fri,  6 Oct 2023 14:59:25 +0200
Message-Id: <20231006125929.48591-2-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006125929.48591-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231006125929.48591-1-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rob Herring <robh@kernel.org>
---
 .../bindings/interrupt-controller/arm,gic-v3.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 2bc38479a41e..0f4a062c9d6f 100644
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
+          cacheability attributes but is connected to a non-coherent
+          downstream interconnect.
+
       msi-controller: true
 
       "#msi-cells":
-- 
2.34.1

