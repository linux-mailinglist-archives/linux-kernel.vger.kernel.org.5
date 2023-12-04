Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54A6803B54
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjLDRW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjLDRWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:22:54 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0380FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:22:59 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3bdbf1fb5so55151067b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701710579; x=1702315379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QagWLgs2h5+JriAq/VG8W2CPIQLr8/EIksrOH5rGRok=;
        b=iJHL+ainzGbec5xnxYzL0+kGDHtG3jttn9tf8pvu0apBSrFXzhHpO1YylpaIQTkpsK
         eJSlsEf2q5/xvv0pKOocrI6a0h72GFWUxCNXc3SqwjoKybTD2Aj4eTzTqe0rFV6Y2DsQ
         c8uSx4mOFkIxRN1bJ33tboq33x0lhqsCAujr3dI7nAfJvzEAP4PlXjXCP49gU1q74KZ4
         y32O3BVUu+qSSQuB4Y0dSgjCdQN1/xi6VnEh98xRxT52pvMO2K9J+qPvSDx/zMt1LYsM
         LZjpjVsy4Lt9qA2HitMPf9Bf5Ygt5o33UgvU79NmEUx633kxMwSLKLH+W4wHBbc+shBb
         fqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710579; x=1702315379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QagWLgs2h5+JriAq/VG8W2CPIQLr8/EIksrOH5rGRok=;
        b=OBcP7Vxh584HgvEpCnLxU1CSx8fB0BgfBW0PnCy47+VuXnf+/erkJlC81enZGiG0jo
         t4v4smStl7OY4n/J68e4BLRA67dqtwGBSdeBW4h5HjsVO/az6gU4/mZ/15r3LcoDKCf0
         MRd0xnkEPvp0AADSoNBsYNm3YrL9H6eDwJk+IwhrrMuyurvEHXFRbJaXSV2KEW4NPhP9
         PMENwMFhiyjVTtNqzFr4SeJFvKFBv6g0oJ7bMF2el2HvpULBXKdOVR8MeS7NjAgwkkYg
         NllIII6UZ5XGq2u2sinyRoWcRsirbrl9eQKXja98712nctibDEKf5IS9uJ+GcbT2guCo
         H7nw==
X-Gm-Message-State: AOJu0Yyr66Nexz8A1UlohLDoFgOYML39LCDFKRvIZzfOdP0fjkKNuev6
        2mirzmBa53lsyXNoy6pLpWgs350JmxeN
X-Google-Smtp-Source: AGHT+IEd9vWzgDWbNklyIFzMD3b54MAcf1KAW0FQHYWTCA9FVIaju91gFmTJLgGBIMKSsG84zlbDdhS7HGBy
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:ac51:a57:5e72:a957])
 (user=kyletso job=sendgmr) by 2002:a81:4425:0:b0:5d3:472b:3427 with SMTP id
 r37-20020a814425000000b005d3472b3427mr393951ywa.6.1701710579266; Mon, 04 Dec
 2023 09:22:59 -0800 (PST)
Date:   Tue,  5 Dec 2023 01:22:46 +0800
In-Reply-To: <20231204172247.1087152-1-kyletso@google.com>
Mime-Version: 1.0
References: <20231204172247.1087152-1-kyletso@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204172247.1087152-2-kyletso@google.com>
Subject: [PATCH v4 1/2] dt-bindings: connector: Add child nodes for multiple
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

The realtime Power Delivery capabilities of a port may not be always the
same under different hardware status such as the port usage of a
multiple port system or the status of the battery pack. Define the PD
capability sets in DT for better configurability in Type-C/PD port
drivers.

Define an optional child node "capabilities" to contain multiple USB
Power Delivery capabilities.

Define child nodes with pattern (e.g. caps-0, caps-1) under
"capabilities". Each node contains PDO data of a selectable Power
Delivery capability.

Also define common properties for source-pdos, sink-pdos, and
op-sink-microwatt that can be referenced.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
v3 -> v4
 - modified the structure of the bindings as corrected in v2
 - modified the commit message to better describe the reason of this
   change

.../bindings/connector/usb-connector.yaml     | 78 ++++++++++++-------
 1 file changed, 49 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 7c8a3e8430d3..50fec97436d8 100644
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
@@ -119,30 +121,6 @@ properties:
 
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
@@ -166,11 +144,6 @@ properties:
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
@@ -231,6 +204,21 @@ properties:
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
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
 dependencies:
   sink-vdos-v1: [ sink-vdos ]
   sink-vdos: [ sink-vdos-v1 ]
@@ -238,6 +226,38 @@ dependencies:
 required:
   - compatible
 
+$defs:
+  capabilities:
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
+    sink-pdos:
+      description: An array of u32 with each entry providing supported power sink
+        data object(PDO), the detailed bit definitions of PDO can be found in
+        "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
+        Sink Capabilities Message, the order of each entry(PDO) should follow the
+        PD spec chapter 6.4.1. Required for power sink and power dual role. User
+        can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
+        in dt-bindings/usb/pd.h.
+      minItems: 1
+      maxItems: 7
+      $ref: /schemas/types.yaml#/definitions/uint32-array
+
+    op-sink-microwatt:
+      description: Sink required operating power in microwatt, if source can't
+        offer the power, Capability Mismatch is set. Required for power sink and
+        power dual role.
+
 allOf:
   - if:
       properties:
-- 
2.43.0.rc2.451.g8631bc7472-goog

