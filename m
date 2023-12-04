Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67538802A1F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjLDCDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbjLDCDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:03:02 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B32811A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 18:03:07 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bdec453c8so2486932e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 18:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701655385; x=1702260185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObBx9TWLrIBpB0H9q8V9qBSHqmx+qoGHKzq0yJDmTtU=;
        b=Wj/bQjc03wNcfC2zoBnv5PekO8ZphTPcnUhI9qlWfGsO9wnUdpuiMy9zk7OyeGMf2+
         2iwd8h05WEoM4UxRAC5IMpjVkE5WhnQ9CQkLP67MdFhDH5GUZes8rE5BawILvODUEpUr
         +ICV0JifG41DKT/2tJoP1n6c9PwCv0OVhDogMT+H9vi4yV7ndPw7cLCzMMMXOwGKxU25
         WT0+KPf3GyvCYNDhsNU78SV0IfCOUrSroSP6s+m43JzKZn26UfWuRhTVsZ21f2OS4eTR
         HyuQ6H/8M7WX/UTLDDbpVeH4X4V/LHpky/n3+HJ+h/X7W8Hx+MFWoAEyEcK+HPrZDUNS
         Mgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701655385; x=1702260185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObBx9TWLrIBpB0H9q8V9qBSHqmx+qoGHKzq0yJDmTtU=;
        b=HEUVBODUxISugcH4gI2KuReJSpF1UpSIhgGMds63U5t6YPYdTXDNnPU1YHD3KKShis
         UgL+CUDDGup5UzZK2xxKOYzTwKWtcZHlWzwO/y5kYH0NeF3shqO4t3o2rMNn2J9cgr3m
         /wGkQEb/ePrK+KGuFAMU/Xm//oxyuyvtxgubazgsLUXXN5Qgh/fkC2GBG7bNiJZzH9vr
         gPXZvFRsW2+l+Rk6czXAq3F+5O0E3Fpip7Y0iG1BPvvGXUKoq0Z6Gbv0asJoy6/hDaTW
         VV8trQkzd9IcYScETxOnqvXnV0g0B3fTI9bIgwdi47/C0Jnxk35G5qtM/OIkHtJFUIik
         584A==
X-Gm-Message-State: AOJu0YzlJhxh4R/hPYTkqDPlR5LvHz8gg/OV+WslSVk9ZO2mvL96z8ct
        cHjwVlaZ0mA9gLjYVFeAhmVetA==
X-Google-Smtp-Source: AGHT+IGQ0l3lZw9Y9VLkl78eTQoCX7i8NWPwi3Mb9gkL2b9k9s3lIiyNJDsNIkxsTjgfigkS3zcfGA==
X-Received: by 2002:ac2:5ec2:0:b0:50b:f776:1d57 with SMTP id d2-20020ac25ec2000000b0050bf7761d57mr400656lfq.28.1701655385280;
        Sun, 03 Dec 2023 18:03:05 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512348c00b0050bea5c2850sm525381lfr.39.2023.12.03.18.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 18:03:04 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Mark Gross" <markgross@kernel.org>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: connector: usb: add altmodes description
Date:   Mon,  4 Dec 2023 04:03:00 +0200
Message-ID: <20231204020303.2287338-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204020303.2287338-1-dmitry.baryshkov@linaro.org>
References: <20231204020303.2287338-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/connector/usb-connector.yaml     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 7c8a3e8430d3..28660b931d0c 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -171,6 +171,32 @@ properties:
       offer the power, Capability Mismatch is set. Required for power sink and
       power dual role.
 
+  altmodes:
+    type: object
+    description: List of Alternative Modes supported by the schematics on the
+      particular device. This is only necessary if there are no other means to
+      discover supported alternative modes (e.g. through the UCSI firmware
+      interface).
+
+    additionalProperties: false
+
+    patternProperties:
+      "^(displayport)$":
+        type: object
+        description:
+          A single USB-C Alternative Mode as supported by the USB-C connector logic.
+
+        additionalProperties: false
+
+        properties:
+          svid:
+            $ref: /schemas/types.yaml#/definitions/uint16
+            description: Unique value assigned by USB-IF to the Vendor / AltMode.
+            enum: [ 0xff01 ]
+          vdo:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: VDO returned by Discover Modes USB PD command.
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description: OF graph bindings modeling a data bus to the connector, e.g.
@@ -289,6 +315,13 @@ examples:
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

