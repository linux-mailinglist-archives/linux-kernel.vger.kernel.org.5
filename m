Return-Path: <linux-kernel+bounces-92990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29A287291F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87064B23646
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F41B809;
	Tue,  5 Mar 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="dPWtEVu7"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C5712839C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672874; cv=none; b=cYlbt7Xe5kluzPeu3D3rAFIzeTJ3wTxmXt2eVRZVQt7JAOfEbm+/SPk+kmygG+28vhpqcFz1SwXNMCJlTxipzs6KnSkjoXS2Nq8Aw9QWzLouSRiXYuEgo2aDDYeKHrn0jID6BFUNcFOBYf3PGKMRl1lk1VGxz5j6gclIODGsh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672874; c=relaxed/simple;
	bh=HSIlCnw1qMgu44wxMsObqpARuyB4m2pEpfiWpv5vzoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+u0+5yRotSf8qdHqI2SfFko3U5nR7nKc4dQa6Wy3YG4mRwPm/ddEhMgWBFCmIPRf1FC+v9XvTVWFCTepyWEIynY4uv+sBa7HBAcoqZ7vdia+OnHTReRZKRjJdPWmj78/3l5Qn07PCr4Rsm5mLGeB85aN/zatVCEitbENKTtg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=dPWtEVu7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412e4619e5eso18425025e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 13:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1709672871; x=1710277671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUZlwMdx9trvWwV1CHNIcS1af0QbtpnuHqxTxJgHydg=;
        b=dPWtEVu7LDz30cZHEDpQ36ACeaPWy+HkcfeL7yDuAgehPxPmgcm5q1vghdwRjBDQXo
         qq/Dk94ynfXWc/z9M38U6k+NAi6DoPGaXcL8i8H4JStdxl7VhjiEStekNXAHlK2zttHE
         /iLVI03vKFaOr+sW7nSfQoc3OPBBFtLYOSw+wxVIAoo7Hor31qofc87K7jFbtTC2M7DT
         Ewd3lBdg36ETZOzb97dtbRme8ASGwsCqqTHtW/LyS29jMs/FSv9TZB+O1sLPzya5ROtw
         mUaqla268NalaZ4eRAmZAglo8z4nCDOhzXfFRp0AMwb43BZjiGIZiYNcMUgXVSdcjsv9
         RDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672871; x=1710277671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUZlwMdx9trvWwV1CHNIcS1af0QbtpnuHqxTxJgHydg=;
        b=WB4hImHdR7BTuocGSVa+F2rCtxL9cGuNLEQkudw2nj7SyMjg44zCkQdHset91SeAmf
         eBRD1kSStGA2EgXBkeHq5sfNUiJ9LEEMS9b8uSo8Ly1N/b8ovlbv5Dmy7+AG0GKoLkHk
         KufysDWS3flCKLHaY8BvZ4J4BknKDGqm9xYHP62e/XxAbclhsL2WHt6qTcQG3UTjpLxR
         HHf9HPxWlkGZ9Fta8JQAwgvJmsdlaOxiKtjOojyD+tlA6bGhHuLWFqEcDMvrUMw8HWCY
         GM+HWxCn31XyA821FuW3OJlbEihD2I4ES9ewVdpX8nIgqmwB4ScK0MZkh+Eaho2XvzMC
         Y6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUGXH3alRiCBo4eC5tMl7ydV+IytMH0EsvLCaoOokNjh28TBNN0ZDco3+3ZoZxztOJLQz2q3eDfRq3jfyPUK84uO00lFaJ3ElB5ThFs
X-Gm-Message-State: AOJu0YxZ3PVBuw3VTTpQeIGzAm4g+yhM+fs7H1ZT8b6wpl9Qcm+ERvhC
	R615gxoSK/ZXeQCSnU/H9qoXRk8YeQCxJyHPUi/zcYxWFnXSCrJ1RjYYrNmyi+w=
X-Google-Smtp-Source: AGHT+IEfDsoa7C4IQErRpmZhXBkz4dEb+SR6QUtROnF1ttdcOCL4FggRjCi1sjsm4AP2ez8teSczag==
X-Received: by 2002:a05:600c:4f4f:b0:412:b62f:2c3 with SMTP id m15-20020a05600c4f4f00b00412b62f02c3mr11487950wmq.21.1709672870672;
        Tue, 05 Mar 2024 13:07:50 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b00412ad64cc69sm18811777wmq.29.2024.03.05.13.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 13:07:50 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Naresh Solanki <naresh.solanki@9elements.com>
Cc: mazziesaccount@gmail.com,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: hwmon: tda38640: Add interrupt & regulator properties
Date: Wed,  6 Mar 2024 02:37:46 +0530
Message-ID: <20240305210747.1377506-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add properties for interrupt & regulator.
Also update example.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

---
Changes in V3:
1. Update regulator node from vout0 to vout.

Changes in V2:
1. Remove TEST=..
2. Update regulator subnode property as vout0
3. Restore commented line in example
4. blank line after interrupts property in example.
---
 .../hwmon/pmbus/infineon,tda38640.yaml        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
index ded1c115764b..5c4e52b472ad 100644
--- a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
@@ -30,6 +30,23 @@ properties:
       unconnected(has internal pull-down).
     type: boolean
 
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description:
+      list of regulators provided by this controller.
+
+    properties:
+      vout:
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -38,6 +55,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -45,5 +63,15 @@ examples:
         tda38640@40 {
             compatible = "infineon,tda38640";
             reg = <0x40>;
+
+            interrupt-parent = <&smb_pex_cpu0_event>;
+            interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+
+            regulators {
+                pvnn_main_cpu0: vout {
+                    regulator-name = "pvnn_main_cpu0";
+                    regulator-enable-ramp-delay = <200>;
+                };
+            };
         };
     };

base-commit: 78cc80d834ed3b792605bc9c2215ed9e63825459
-- 
2.42.0


