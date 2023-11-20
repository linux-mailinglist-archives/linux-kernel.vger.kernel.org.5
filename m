Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEEB7F20A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjKTWtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjKTWt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:49:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2AED9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:49:23 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a29c7eefso6998479e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700520562; x=1701125362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTZE+Yyh5kIyB1ncprfjmtJf/HhgeQFmAHJ18g9kLYU=;
        b=Z+dM2GfbMb9MkZJGoomW+/RFhjH3ISvghR7CKm28zzYJz62samQIA1mcUk6eMcs1rp
         hWKE13y/OIO7E1g+Ux+whMdk1lssRtf32iSYuMAtrOUwZcoiSoqoRAuXdPWpjm+Gi0X3
         vjeM5TbMh+6DxK2TaWl/n3YkikR6xH1ocB4uOQ99qOwYazFD/G14brbwmEW7CeRV5+/1
         98BXGpxqLfwwVs4cmo7KX8oYge9e1D3V7qsQ/SjemFcEJbKJ06cqs2U87nGIxOV8S/AT
         LXFSWWS4F8v1mAMSHLZZm/eMVcyr5IL9xrto0xOi9Z1ItELqGSOOutsypp/KpetuGDir
         K3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700520562; x=1701125362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTZE+Yyh5kIyB1ncprfjmtJf/HhgeQFmAHJ18g9kLYU=;
        b=JsW3wC7lK6VQsPbYQ8mUlT/0n5d+i/jne2lKOl/UPaYpf3VcqRL0E31Oqyd03BO/Pq
         YF8fm8BJZfUPrEHGg/mcxD7Uy9MtR7IXxOdVw5FbDSM0BXZodZZI5nwuqAJAWQcsLMFn
         LDjn0FhcmFeXqChcJtmSs8bpCgd79etvW0nNE2+ot/NpQrx82ms+z3Jtv/T1YadC5fMm
         YfbLHYvCPjsHlbm+N2SxJcbXzE5C6X6D+8sV4AKQSnO7in2p4RLyoyzfTl76p66+V+VA
         39a8u0YeZJ5wyVj1PIWg74bzHTH/E7Hsg60UkZBDERNahgL4BJAGUl4TeByT2t3DB+b9
         OrCQ==
X-Gm-Message-State: AOJu0Yw7dQWHrxD8CVpnOxfcv+3jzApewYD4Z6aEcYyBHppPEL/OoTeZ
        reXEe3AqL82VGo1ZlV3u31oKtg==
X-Google-Smtp-Source: AGHT+IET8ZFead2qL40qpVsAg7bFbRz1l/L2umnEoT+GoBgTHa6uj75zEbiibhyfKA16qDxUC9hLjA==
X-Received: by 2002:ac2:43a5:0:b0:501:c406:c296 with SMTP id t5-20020ac243a5000000b00501c406c296mr6204735lfl.31.1700520562151;
        Mon, 20 Nov 2023 14:49:22 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id c26-20020ac25f7a000000b00503189d8b8csm1297756lfc.198.2023.11.20.14.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:49:21 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: connector: usb: add altmodes description
Date:   Tue, 21 Nov 2023 00:00:18 +0200
Message-ID: <20231120224919.2293730-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120224919.2293730-1-dmitry.baryshkov@linaro.org>
References: <20231120224919.2293730-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of the USB-C AltModes supported on the particular USB-C
connector. This is required for devices like Qualcomm Robotics RB5,
which have no other way to express alternative modes supported by the
hardware platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/connector/usb-connector.yaml     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 7c8a3e8430d3..c1aaac861d9d 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -171,6 +171,28 @@ properties:
       offer the power, Capability Mismatch is set. Required for power sink and
       power dual role.
 
+  altmodes:
+    type: object
+    description: List of Alternative Modes supported by the schematics on the
+      particular device. This is only necessary if there are no other means to
+      discover supported alternative modes (e.g. through the UCSI firmware
+      interface).
+
+    patternProperties:
+      "^(displayport)$":
+        type: object
+        description:
+          A single USB-C Alternative Mode as supported by the USB-C connector logic.
+        properties:
+          svid:
+            $ref: /schemas/types.yaml#/definitions/uint16
+            description: Unique value assigned by USB-IF to the Vendor / AltMode.
+          vdo:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: VDO returned by Discover Modes USB PD command.
+        additionalProperties: false
+    additionalProperties: false
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description: OF graph bindings modeling a data bus to the connector, e.g.
@@ -289,6 +311,13 @@ examples:
             compatible = "usb-c-connector";
             label = "USB-C";
 
+            altmodes {
+                displayport {
+                    svid = /bits/ 16 <0xff01>;
+                    vdo = <0x00001c46>;
+                };
+            };
+
             ports {
                 #address-cells = <1>;
                 #size-cells = <0>;
-- 
2.42.0

