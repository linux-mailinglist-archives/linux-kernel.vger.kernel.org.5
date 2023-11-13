Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0957E9F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjKMOxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjKMOxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:53:36 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0651728
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:53:33 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso6417522e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699887211; x=1700492011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mRz0RhXvXEDvxsQyGFzA2Dam68j7hbTQ8jEDNkV7Cw=;
        b=dx8NiN0PKia3f3DOJGnqv/Xwu0qJwQaVxU6+sxmyNfKiCq0Hcvi9ac4pGJjkACPQFR
         TPZX/2gNlO685kkohl42SddBsEh5Q2mldIPPX+w+rKbAZMrVyJDI5slY3P+B5zGZK4KA
         VbX871XJEiiGtXWRRjJcidOb4FTAvA8ymcwRZOBVj+n0MWDYTPgHo8pzUhvzr1FZuWvp
         lciz2SGH9sgl0zoouh2dfC6aUNFccMckVrFJykR3n1+kxH/Hs5Kz5Xa2DwfrTbRiHm8e
         ++1mIv+zPzxAA4CpbP3KY6dbUzk1F0nc2/ilQ8aToDFRiLe+anZoBmEtemXwCue68vRo
         yCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699887211; x=1700492011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mRz0RhXvXEDvxsQyGFzA2Dam68j7hbTQ8jEDNkV7Cw=;
        b=qzbDjGgP0PxIYJ2oeTK55jyT6mxWJa6u+/WQKUGpnVr7vraBHLnTd6752sGvYKblUj
         jHLFlMY47tN7jKvDUt0DtFLEJWRE0BAXLSXhjmBLslScUoIUlODKjqu2ovvJ71nuUmoh
         kZ1sFZvQEj8z/r23uAfFHlpIQt23DVLsIVjcqxM4j3aK8yhOrNKBNTp+LlRwlouNM/5i
         dcZmPXjwizZIwqHToNcgrOocCJGRXU4kuwd46ltSXxuD9ahKDDXUyl1JrQZpNJ11tei7
         z1dl9ZR6X5OoeUN8YUvhKltlFyuWrphox50fFbh9qHx3pjMa2xqr3LdjMs4/7hjOdRZn
         JStw==
X-Gm-Message-State: AOJu0YwC3CArRq6vitiGD6SbX/ylmhGpfIddtkqGZZvO8Y30cuHJl+PP
        /mqef/wfFQNIzSi3ZjRHiZtQCw==
X-Google-Smtp-Source: AGHT+IGexvXHE9m92iJ8rHBEKfIRIdYbC12J7VLNjDkZ8FPbr7i6C9RDxa06fLL1FfG1wxc/8RUEZA==
X-Received: by 2002:a19:2d4b:0:b0:507:9787:6776 with SMTP id t11-20020a192d4b000000b0050797876776mr4929444lft.5.1699887210818;
        Mon, 13 Nov 2023 06:53:30 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x24-20020ac24898000000b0050794b05c8asm991429lfc.42.2023.11.13.06.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 06:53:29 -0800 (PST)
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
Subject: [PATCH 1/3] dt-bindings: connector: usb: add altmodes description
Date:   Mon, 13 Nov 2023 16:33:07 +0200
Message-ID: <20231113145328.42575-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231113145328.42575-1-dmitry.baryshkov@linaro.org>
References: <20231113145328.42575-1-dmitry.baryshkov@linaro.org>
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
 .../bindings/connector/usb-connector.yaml     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 7c8a3e8430d3..9922622abf51 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -14,6 +14,30 @@ description:
   of a USB interface controller or a separate node when it is attached to both
   MUX and USB interface controller.
 
+$defs:
+  altmode-desc:
+    type: object
+    description:
+      A single USB-C Alternative Mode as supported by the USB-C connector logic.
+    properties:
+      svid:
+        $ref: /schemas/types.yaml#/definitions/uint16
+        description: Unique value assigned by USB-IF to the Vendor / AltMode.
+      vdo:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: VDO returned by Discover Modes USB PD command.
+
+  altmodes-list:
+    descrption: List of Alternative Modes supported by the schematics on the
+      particular device. This is only necessary if there are no other means to
+      discover supported alternative modes (e.g. through the UCSI firmware
+      interface).
+
+    patternProperties:
+      "^[a-z][a-z0-9]*$":
+        $ref: "#/$defs/altmode-desc"
+        unevaluatedProperties: false
+
 properties:
   compatible:
     oneOf:
@@ -171,6 +195,10 @@ properties:
       offer the power, Capability Mismatch is set. Required for power sink and
       power dual role.
 
+  altmodes:
+    $ref: "#/$defs/altmodes-list"
+    unevaluatedProperties: false
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description: OF graph bindings modeling a data bus to the connector, e.g.
@@ -289,6 +317,13 @@ examples:
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

