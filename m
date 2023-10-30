Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDEF7DBE96
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjJ3ROH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjJ3ROD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:14:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAB29F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:14:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afe220cadeso35034967b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698686040; x=1699290840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8iKDVNsfQwoRxvvaiYCTHXcr4RTujdFfq5CMELZsH0=;
        b=dnkuBXmBEng6TyQi9oKbkeeiXz7SZVRKOHuqElRgAZQy+14HPuTf4oUstfyka50zht
         B2WX87SkdQQD6IdvwD+miiJHLvg0u4d5+aVDO0vBu1hXEwOtlpWqEcSsx8be5pZPHmY1
         dCCJYU5xmWzVb0OxJ2N/ojYorcCuuahlUH+d09sVTwkm04PYgSIEEGs7gvYZRyN4N1eP
         e3bv+yX6xuDLUfvIHG1nmv5PDkstz7KoiMAKe/47yPsM3P1hn7GzJ2XZ2veppQr0kEN+
         n5W2F/BfIWBaYh1ZC19Yi/j9h2ACUIXLJJjvMI9JVfxE9z6nLiFWvNYy8nghTdjLYU8J
         qBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698686040; x=1699290840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8iKDVNsfQwoRxvvaiYCTHXcr4RTujdFfq5CMELZsH0=;
        b=ZjjaN3CYgIOjn6qLfwZXTDO/KOkU7gfM1bVSIIlsOxvqTb2FG/wWd2Dx8iCTRu1qsO
         VGMSRiJh6ypYiEWslPcMPGtTBcI/WdzobTk5at+4ic7mG2wRVBlHWl5PHyUdy6LoTxNK
         gZkKqXNTv2eUB1M1etGmO3trEIvOIcmrpjUQt5RjGzSLYpTnwd23MrHo8NIfQU5Y93Ct
         aY9pw2JZshgoT0CTiN+r++xukNk7l57TdNO/npEvvZsF3OQoWz6/E3bY6nFSNGyHRvHg
         Q7jU+V/XwYVpB2GekcEiWE69c8LdBxomiQUOUAwyejWui1A9CqQRA8b/bbSMNOhyw2rQ
         jrSQ==
X-Gm-Message-State: AOJu0Yw6pEIRmt+dqZbZG+hGDJhyuiqOGqdteDZe9pvqucZioBRmpDLy
        Xaj4MJjlDm6qxSl8zDH+P9G+ADn3tm1/
X-Google-Smtp-Source: AGHT+IFCobSs7f7lUn7grteQL7zVQdPUD6EkBGNh9TaVbwF6QkbcBHQPOXcg4Ka4yeDKsnRZpGaTk4xXD+dN
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:99ae:e3b5:518:c5b4])
 (user=kyletso job=sendgmr) by 2002:a25:9841:0:b0:d9a:3a14:a5a2 with SMTP id
 k1-20020a259841000000b00d9a3a14a5a2mr212052ybo.13.1698686039808; Mon, 30 Oct
 2023 10:13:59 -0700 (PDT)
Date:   Tue, 31 Oct 2023 01:13:47 +0800
In-Reply-To: <20231030171348.600621-1-kyletso@google.com>
Mime-Version: 1.0
References: <20231030171348.600621-1-kyletso@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030171348.600621-2-kyletso@google.com>
Subject: [PATCH v3 1/2] dt-bindings: connector: Add child nodes for multiple
 PD capabilities
From:   Kyle Tso <kyletso@google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 662a60102c12 ("usb: typec: Separate USB Power Delivery from USB
Type-C") allows userspace to configure the PD of a port by selecting
different set of predefined PD capabilities. Define the PD capability
sets in DT for better configurability in device modules.

Define a child node "capabilities" to contain multiple USB Power
Delivery capabilities.

Define a child node with pattern (e.g. caps-0, caps-1) under
"capabilities". Each node contains PDO data of a selectable Power
Delivery capability.

Also define common properties for source-pdos, sink-pdos, and
op-sink-microwatt that can be referenced.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
v2 -> v3
- Updated the commit message
- Remain unchanged for the comments about the property/node refactor

.../bindings/connector/usb-connector.yaml     | 80 +++++++++++++------
 1 file changed, 57 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 7c8a3e8430d3..d7ece063cb2c 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -120,28 +120,10 @@ properties:
   # The following are optional properties for "usb-c-connector" with power
   # delivery support.
   source-pdos:
-    description: An array of u32 with each entry providing supported power
-      source data object(PDO), the detailed bit definitions of PDO can be found
-      in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
-      Source_Capabilities Message, the order of each entry(PDO) should follow
-      the PD spec chapter 6.4.1. Required for power source and power dual role.
-      User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
-      defined in dt-bindings/usb/pd.h.
-    minItems: 1
-    maxItems: 7
-    $ref: /schemas/types.yaml#/definitions/uint32-array
+    $ref: "#/$defs/source-pdos"
 
   sink-pdos:
-    description: An array of u32 with each entry providing supported power sink
-      data object(PDO), the detailed bit definitions of PDO can be found in
-      "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
-      Sink Capabilities Message, the order of each entry(PDO) should follow the
-      PD spec chapter 6.4.1. Required for power sink and power dual role. User
-      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
-      in dt-bindings/usb/pd.h.
-    minItems: 1
-    maxItems: 7
-    $ref: /schemas/types.yaml#/definitions/uint32-array
+    $ref: "#/$defs/sink-pdos"
 
   sink-vdos:
     description: An array of u32 with each entry, a Vendor Defined Message Object (VDO),
@@ -167,9 +149,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
   op-sink-microwatt:
-    description: Sink required operating power in microwatt, if source can't
-      offer the power, Capability Mismatch is set. Required for power sink and
-      power dual role.
+    $ref: "#/$defs/op-sink-microwatt"
 
   port:
     $ref: /schemas/graph.yaml#/properties/port
@@ -231,6 +211,30 @@ properties:
       SNK_READY for non-pd link.
     type: boolean
 
+  capabilities:
+    description: A child node to contain all the selectable USB Power Delivery capabilities.
+    type: object
+
+    patternProperties:
+      "^caps-[0-9]+$":
+        description: Child nodes under "capabilities" node. Each node contains a selectable USB
+          Power Delivery capability.
+        type: object
+
+        properties:
+          source-pdos:
+            $ref: "#/$defs/source-pdos"
+
+          sink-pdos:
+            $ref: "#/$defs/sink-pdos"
+
+          op-sink-microwatt:
+            $ref: "#/$defs/op-sink-microwatt"
+
+        additionalProperties: false
+
+    additionalProperties: false
+
 dependencies:
   sink-vdos-v1: [ sink-vdos ]
   sink-vdos: [ sink-vdos-v1 ]
@@ -238,6 +242,36 @@ dependencies:
 required:
   - compatible
 
+$defs:
+  source-pdos:
+    description: An array of u32 with each entry providing supported power
+      source data object(PDO), the detailed bit definitions of PDO can be found
+      in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
+      Source_Capabilities Message, the order of each entry(PDO) should follow
+      the PD spec chapter 6.4.1. Required for power source and power dual role.
+      User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
+      defined in dt-bindings/usb/pd.h.
+    minItems: 1
+    maxItems: 7
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  sink-pdos:
+    description: An array of u32 with each entry providing supported power sink
+      data object(PDO), the detailed bit definitions of PDO can be found in
+      "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
+      Sink Capabilities Message, the order of each entry(PDO) should follow the
+      PD spec chapter 6.4.1. Required for power sink and power dual role. User
+      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
+      in dt-bindings/usb/pd.h.
+    minItems: 1
+    maxItems: 7
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  op-sink-microwatt:
+    description: Sink required operating power in microwatt, if source can't
+      offer the power, Capability Mismatch is set. Required for power sink and
+      power dual role.
+
 allOf:
   - if:
       properties:
-- 
2.42.0.820.g83a721a137-goog

