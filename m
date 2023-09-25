Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149177AE182
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjIYWFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjIYWFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:05:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E7180
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:05:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5D5C433C8;
        Mon, 25 Sep 2023 22:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695679532;
        bh=FmZZfIJ7IjqsgMWeiyIf/YJBP5eLlOuuOdfPlbttg+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4+YavJePbk5XQhufDOKssIq1IW9tGV2SLanMeov18NhO3LjgeJSUdunp+PCdUPid
         cv6cNmJubZL8ILBF8xH3B9XfYk3Epuj212eYufl9Z3GBSGCaWPJ2Y924Ftlif9vhST
         JFp6ozAm1b+YgUOl5QeIamrwJ2spycsWUBPhLIQTP2IJE9iRqY1KR+DiviCyZyOW7i
         GvlMAIMvxBNT7LGNXXu+MrY9uKnrq+6zNLdGHwCWem90eIqJ/ew9VaKt8x6V8kNh+D
         ivOOj6JOuYTIrtAiCV8UZusUZLTFS0iyvQZOgirkJt7JF+yUXTFLYmaiFmhG2vXIoc
         qJv/N3jqi16gA==
Received: (nullmailer pid 2027056 invoked by uid 1000);
        Mon, 25 Sep 2023 22:05:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm,coresight-cti: Add missing additionalProperties on child nodes
Date:   Mon, 25 Sep 2023 17:05:06 -0500
Message-Id: <20230925220511.2026514-2-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925220511.2026514-1-robh@kernel.org>
References: <20230925220511.2026514-1-robh@kernel.org>
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

Just as unevaluatedProperties or additionalProperties are required at
the top level of schemas, they should (and will) also be required for
child node schemas. That ensures only documented properties are
present for any node.

Adding additionalProperties constraint on 'trig-conns' nodes results in
warnings that 'cpu' and 'arm,cs-dev-assoc' are not allowed. These are
already defined for the parent node, but need to be duplicated for the
child node. Drop the free form description that the properties also apply
to the child nodes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/arm,coresight-cti.yaml       | 33 ++++++++++++++-----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
index b9bdfc8969cd..2d5545a2b49c 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
@@ -93,9 +93,7 @@ properties:
 
   cpu:
     description:
-      Handle to cpu this device is associated with. This must appear in the
-      base cti node if compatible string arm,coresight-cti-v8-arch is used,
-      or may appear in a trig-conns child node when appropriate.
+      Handle to cpu this CTI is associated with.
 
   power-domains:
     maxItems: 1
@@ -112,12 +110,12 @@ properties:
     description:
       defines a phandle reference to an associated CoreSight trace device.
       When the associated trace device is enabled, then the respective CTI
-      will be enabled. Use in a trig-conns node, or in CTI base node when
-      compatible string arm,coresight-cti-v8-arch used. If the associated
-      device has not been registered then the node name will be stored as
-      the connection name for later resolution. If the associated device is
-      not a CoreSight device or not registered then the node name will remain
-      the connection name and automatic enabling will not occur.
+      will be enabled. Use in CTI base node when compatible string
+      arm,coresight-cti-v8-arch used. If the associated device has not been
+      registered then the node name will be stored as the connection name for
+      later resolution. If the associated device is not a CoreSight device or
+      not registered then the node name will remain the connection name and
+      automatic enabling will not occur.
 
   # size cells and address cells required if trig-conns node present.
   "#size-cells":
@@ -129,6 +127,8 @@ properties:
 patternProperties:
   '^trig-conns@([0-9]+)$':
     type: object
+    additionalProperties: false
+
     description:
       A trigger connections child node which describes the trigger signals
       between this CTI and another hardware device. This device may be a CPU,
@@ -140,6 +140,21 @@ patternProperties:
       reg:
         maxItems: 1
 
+      cpu:
+        description:
+          Handle to cpu this trigger connection is associated with.
+
+      arm,cs-dev-assoc:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description:
+          defines a phandle reference to an associated CoreSight trace device.
+          When the associated trace device is enabled, then the respective CTI
+          will be enabled. If the associated device has not been registered
+          then the node name will be stored as the connection name for later
+          resolution. If the associated device is not a CoreSight device or
+          not registered then the node name will remain the connection name
+          and automatic enabling will not occur.
+
       arm,trig-in-sigs:
         $ref: /schemas/types.yaml#/definitions/uint32-array
         minItems: 1
-- 
2.40.1

