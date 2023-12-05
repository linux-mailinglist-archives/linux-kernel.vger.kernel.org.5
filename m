Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C748804567
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbjLEDBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjLEDBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:01:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92401CA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:01:24 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db53c05f802so3265626276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 19:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701745284; x=1702350084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVN/UyIKfUocTS971YedMZD71CaFzOVitN/DmVfXb7o=;
        b=pLjwRiyPofMjLt+dbqCNQIV8FiXFgjEgJV3ty7RRKj08Fq7RS8c1yzSEInk9fyWPfC
         0y190FA6IuDvTTein7GUb5D4UipMSzzx3CCpMYgbP8eABtLjW1nKavlXX1oxognqkCy6
         1iKWrFA19LBDFt/lS19N6PmUKcV+iOiWXV9JZoDck+hBqHmzxyaSHEXnVBZ/xLCQk9K1
         F8cVXZN9lV4+C0LsJoa+Y3rGKIYUY28zEUCfdHAyMZD+SX1bdJyzGuorCEGgkXS6jpJY
         Fm7rmRcjC4YG4QOV0tgUh74c4dgPKKfGdabZSJ9z2E+BDlQ8vzHql1c1pC6Z/ePiDkvw
         nLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701745284; x=1702350084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVN/UyIKfUocTS971YedMZD71CaFzOVitN/DmVfXb7o=;
        b=FFsItgsp0oE52rqLkJyezPr3tjcqiL7kravhY2wBg+MiwBRoax5BnrEarIHJzCllsC
         CCQ6dD/zQv5FA08VnYmLknIaSge70n8sL7UIIMBUa4ceqEDoF1U8m9evqqvIAxs3L2g4
         5Ny/GKGGjRXj7wS5CfEO2N+PcXMC+mMk2l51NG2vobX9Fum833R8DNdCAg9eNt8fQASo
         XqYeANjZa0vdyLM4pB2PJx7O3O71hO9xFpidNbQiQg2mdnESRldoOoExth34DT/l/XaU
         Ff+DfGu6t43PEFu/N2LMEvcuk5MAxgzcgPdk+qBgkwecGClp39uqpiAnDow0FPCcdWb4
         ixyw==
X-Gm-Message-State: AOJu0YzS7J+c9x8r9v/kApEP9I2/Dcg5UWwVa4Wc/ZlYupX39zlHLlra
        ZB5ysc67zjGps5tu07LKOUygbSZb65vX
X-Google-Smtp-Source: AGHT+IGr1CA0HYxMGxqnHV2w7hHHn8podQKfyMatY1A92sO17LKhvVGwcmkEByID4hmcE1VKawqjkCVaCxwa
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:ac51:a57:5e72:a957])
 (user=kyletso job=sendgmr) by 2002:a25:da49:0:b0:da0:6216:7990 with SMTP id
 n70-20020a25da49000000b00da062167990mr39881ybf.3.1701745283874; Mon, 04 Dec
 2023 19:01:23 -0800 (PST)
Date:   Tue,  5 Dec 2023 11:01:13 +0800
In-Reply-To: <20231205030114.1349089-1-kyletso@google.com>
Mime-Version: 1.0
References: <20231205030114.1349089-1-kyletso@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231205030114.1349089-2-kyletso@google.com>
Subject: [PATCH v5 1/2] dt-bindings: connector: Add child nodes for multiple
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 662a60102c12 ("usb: typec: Separate USB Power Delivery from USB
Type-C") allows userspace to configure the PD of a port by selecting
different set of predefined PD capabilities. Define the PD capability
sets in DT for better configurability in device modules.

Define an optional child node "capabilities" to contain multiple USB
Power Delivery capabilities.

Define child nodes with pattern (e.g. caps-0, caps-1) under
"capabilities". Each node contains PDO data of a selectable Power
Delivery capability.

Also define common properties for source-pdos, sink-pdos, and
op-sink-microwatt that can be referenced.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
v4 -> v5:
- Fixed DT_CHECK errors

 .../bindings/connector/usb-connector.yaml     | 88 +++++++++++++------
 1 file changed, 59 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 7c8a3e8430d3..7945d09d1f59 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -14,6 +14,8 @@ description:
   of a USB interface controller or a separate node when it is attached to both
   MUX and USB interface controller.
 
+$ref: "#/$defs/capabilities"
+
 properties:
   compatible:
     oneOf:
@@ -67,6 +69,15 @@ properties:
       model it as a regulator. See bindings/regulator/fixed-regulator.yaml
 
   # The following are optional properties for "usb-c-connector".
+  source-pdos:
+    $ref: "#/$defs/capabilities/properties/source-pdos"
+
+  sink-pdos:
+    $ref: "#/$defs/capabilities/properties/sink-pdos"
+
+  op-sink-microwatt:
+    $ref: "#/$defs/capabilities/properties/op-sink-microwatt"
+
   power-role:
     description: Determines the power role that the Type C connector will
       support. "dual" refers to Dual Role Port (DRP).
@@ -119,30 +130,6 @@ properties:
 
   # The following are optional properties for "usb-c-connector" with power
   # delivery support.
-  source-pdos:
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
-
-  sink-pdos:
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
-
   sink-vdos:
     description: An array of u32 with each entry, a Vendor Defined Message Object (VDO),
       providing additional information corresponding to the product, the detailed bit
@@ -166,11 +153,6 @@ properties:
     maxItems: 6
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
-  op-sink-microwatt:
-    description: Sink required operating power in microwatt, if source can't
-      offer the power, Capability Mismatch is set. Required for power sink and
-      power dual role.
-
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description: OF graph bindings modeling a data bus to the connector, e.g.
@@ -231,6 +213,20 @@ properties:
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
+        $ref: "#/$defs/capabilities"
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
 dependencies:
   sink-vdos-v1: [ sink-vdos ]
   sink-vdos: [ sink-vdos-v1 ]
@@ -238,6 +234,40 @@ dependencies:
 required:
   - compatible
 
+$defs:
+  capabilities:
+    type: object
+
+    properties:
+      source-pdos:
+        description: An array of u32 with each entry providing supported power
+          source data object(PDO), the detailed bit definitions of PDO can be found
+          in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
+          Source_Capabilities Message, the order of each entry(PDO) should follow
+          the PD spec chapter 6.4.1. Required for power source and power dual role.
+          User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
+          defined in dt-bindings/usb/pd.h.
+        minItems: 1
+        maxItems: 7
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      sink-pdos:
+        description: An array of u32 with each entry providing supported power sink
+          data object(PDO), the detailed bit definitions of PDO can be found in
+          "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
+          Sink Capabilities Message, the order of each entry(PDO) should follow the
+          PD spec chapter 6.4.1. Required for power sink and power dual role. User
+          can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
+          in dt-bindings/usb/pd.h.
+        minItems: 1
+        maxItems: 7
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      op-sink-microwatt:
+        description: Sink required operating power in microwatt, if source can't
+          offer the power, Capability Mismatch is set. Required for power sink and
+          power dual role.
+
 allOf:
   - if:
       properties:
-- 
2.43.0.472.g3155946c3a-goog

