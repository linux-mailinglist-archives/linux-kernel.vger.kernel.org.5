Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D305792B74
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbjIEQxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354336AbjIEKrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:47:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE8E199;
        Tue,  5 Sep 2023 03:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 626E4B811DC;
        Tue,  5 Sep 2023 10:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F996C433C8;
        Tue,  5 Sep 2023 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693910852;
        bh=rwu/ICLddZviRmw2ibPmYNuYJYieVb9gj5s0F4BZk2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrektR0OvmkeZ5I62+XN2ZIEywqRUsADhv8DRXcKFRY3TThydbyXNpJNtEQTDhLR6
         7cTVGugCfDArcKjy3J27sspy6ipEILeBNKTHDJBBXyl+vfB2ET+qnVdZgfXJKjtj5d
         rr5/JKUI2zujSKXAXAGp+sYXMqZT78CuCGItBfb2S5i8U+XT9OpAv3Tz7GvKvy9+0f
         wFEVU+/eX7FWDAMZE+0pmvcMm4NRagPiMcyilymVkbgUjm24ithPCw+zh9ppw59ZrR
         gcpUbwIDD55dqVJJ7vonbA9mDBrQZsz3VR1N8ba1JPe6Jm1vsk/Sa0ZNUsHzxXBEDI
         2E7i3zzRy1y4A==
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
Subject: [PATCH 1/2] dt-bindings: interrupt-controller: arm,gic-v3: Add dma-noncoherent property
Date:   Tue,  5 Sep 2023 12:47:20 +0200
Message-Id: <20230905104721.52199-2-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905104721.52199-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
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
 .../bindings/interrupt-controller/arm,gic-v3.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 39e64c7f6360..0a81ae4519a6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -106,6 +106,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     maximum: 4096
 
+  dma-noncoherent:
+    description: |
+      Present if the GIC redistributors are not cache coherent with the CPU.
+
   msi-controller:
     description:
       Only present if the Message Based Interrupt functionality is
@@ -193,6 +197,10 @@ patternProperties:
       compatible:
         const: arm,gic-v3-its
 
+      dma-noncoherent:
+        description: |
+          Present if the GIC ITS is not cache coherent with the CPU.
+
       msi-controller: true
 
       "#msi-cells":
-- 
2.34.1

