Return-Path: <linux-kernel+bounces-117102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A05788A70F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772BE1C29BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88141411E4;
	Mon, 25 Mar 2024 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OY/nE9Jo"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125F713E403
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372623; cv=none; b=urNYvjQEbzSn+mJzemLRN7yllQ3gk60NeLOzB9dKV5RhlKJuYtMzywSK26vPyAYX65d47NDSRBLoIDeEQ/etlmQYvVNGzkmb8Sp0fp3qoxURQsqWDftXKRY/fYZdbizWAclEj/X1fF/3Trixvcb92pBD0nEm8J9C7pZYNGjob3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372623; c=relaxed/simple;
	bh=umsASWScraRruZvXdnmzX+2rRPtkGm6CyEV2OmvBy7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p33pW8hbnY3YVhaJ2BRr9sSwzRJT5GmRvsUtAyUcN7yGRGyNtNP4Lf1Bho0QC9UOv2giaGkRaKm51QgnrCS4MB/GEJ4VIG02hS+BFYV25qR20xZkbKwUGqjqtotSlKz48Wayt0YBnmHIs5q3KTbz85RTWFsVkD9RFpZTQpBjsjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OY/nE9Jo; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so55110851fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711372618; x=1711977418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42yZYptcgZvWjTHjWqqNlYhVo8nNiy2t/Uk2MgznhqE=;
        b=OY/nE9JoWvTSiSHrx6GYHQ1SAsVh8ZjTSOdeRYBKQmI02iiz4d5RbMBBTcZtsTtQUG
         HNC4+cVe6XT40KINgpbFkIwUQK7bdhWFj3W7J6dQFDlZrR9WlN0ermaBxp7zdr3cR4l2
         +jtbh4hurca3kmY+NiIwFrLl2GsjZkoNdrst3KscCUgNYQArOL5gH5RLf8F24SRP/Thj
         36sSQsBRdNaSP019Y2qxuFCC3gf5CPpg5b47X5LLldk7d6R4pMrwbLXsCq2LCyOG7ZhI
         C1oGl2uGCbCKpBAgJ1BVbwzQSOmZgGQFVF61qoBHH8KzyAdTyDSIKIznNpW+Ydsn5lm3
         cBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372618; x=1711977418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42yZYptcgZvWjTHjWqqNlYhVo8nNiy2t/Uk2MgznhqE=;
        b=MdmX3gdHqabtserI/ik9A5d6c2MEavAI4/NjcBEHDWesokBiAscBY/sNRoHmqd3gIy
         0ClKl/KdGuOsqD++PqhK7iQ9VWhANvMt/Ortjgt8FJqXUbA1v3UcrUkY7Tcgvtjo1/OI
         up9g4f2DAKEmKvkVYUGPtoH6szEvREA/J86xPpZ5gmyLnx6c9mQamp9iNESu6ehle+76
         Fq6tvpL16OcrJ/TCRr03/OvymI6fOikbaQE1Mgje8PU4zjx11fNLTYXByxeOSoxDyRGf
         StfxeLGz1aeTy5bKzbJT6Yw8kbsrLD7tnTIaq414X95MzIuOBN9ZuTZMOeyr3IYsQ3bo
         248w==
X-Forwarded-Encrypted: i=1; AJvYcCWrx/bME5ZTsjL9kAADiRN4dGA6x94mZlYY73DgihInc5l79Cqsyth2Y/aufHMxqcVN2SNNkygdo60An3Mo9YMuXMj0n+01hBAnt7/I
X-Gm-Message-State: AOJu0Yw4NtpL2WOdXBvyDGRn+Sub3DfdwJ7R+Q6ENFd0QH1WMFfkeelC
	Razl7BI4SX6w2cwWybuvNNsyByhyhWgwH3FS4U+pZMrfHL+DSRGnob+K3+k2Uq4=
X-Google-Smtp-Source: AGHT+IFRrpEIcF9g0oJWmhIi/sNJq/ERO6ZaZaYx2MQaEKjs8/2dotoG1QNrwY1XmiNhKxbpF4ccvw==
X-Received: by 2002:a2e:98c2:0:b0:2d6:9481:b38 with SMTP id s2-20020a2e98c2000000b002d694810b38mr4810233ljj.20.1711372617692;
        Mon, 25 Mar 2024 06:16:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id p11-20020a056000018b00b0033e75e5f280sm9485245wrx.113.2024.03.25.06.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:16:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6 01/16] regulator: dt-bindings: describe the PMU module of the QCA6390 package
Date: Mon, 25 Mar 2024 14:16:09 +0100
Message-Id: <20240325131624.26023-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325131624.26023-1-brgl@bgdev.pl>
References: <20240325131624.26023-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The QCA6390 package contains discreet modules for WLAN and Bluetooth. They
are powered by the Power Management Unit (PMU) that takes inputs from the
host and provides LDO outputs. This document describes this module.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../bindings/regulator/qcom,qca6390-pmu.yaml  | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
new file mode 100644
index 000000000000..9d39ff9a75fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. QCA6390 PMU Regulators
+
+maintainers:
+  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
+
+description:
+  The QCA6390 package contains discreet modules for WLAN and Bluetooth. They
+  are powered by the Power Management Unit (PMU) that takes inputs from the
+  host and provides LDO outputs. This document describes this module.
+
+properties:
+  compatible:
+    const: qcom,qca6390-pmu
+
+  vddaon-supply:
+    description: VDD_AON supply regulator handle
+
+  vddpmu-supply:
+    description: VDD_PMU supply regulator handle
+
+  vddrfa0p95-supply:
+    description: VDD_RFA_0P95 supply regulator handle
+
+  vddrfa1p3-supply:
+    description: VDD_RFA_1P3 supply regulator handle
+
+  vddrfa1p9-supply:
+    description: VDD_RFA_1P9 supply regulator handle
+
+  vddpcie1p3-supply:
+    description: VDD_PCIE_1P3 supply regulator handle<S-Del>
+
+  vddpcie1p9-supply:
+    description: VDD_PCIE_1P9 supply regulator handle
+
+  vddio-supply:
+    description: VDD_IO supply regulator handle
+
+  wlan-enable-gpios:
+    maxItems: 1
+    description: GPIO line enabling the ATH11K WLAN module supplied by the PMU
+
+  bt-enable-gpios:
+    maxItems: 1
+    description: GPIO line enabling the ATH11K Bluetooth module supplied by the PMU
+
+  regulators:
+    type: object
+    description:
+      LDO outputs of the PMU
+
+    patternProperties:
+      "^ldo[0-9]$":
+        $ref: regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - regulators
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,qca6390-pmu
+    then:
+      required:
+        - vddaon-supply
+        - vddpmu-supply
+        - vddrfa0p95-supply
+        - vddrfa1p3-supply
+        - vddrfa1p9-supply
+        - vddpcie1p3-supply
+        - vddpcie1p9-supply
+        - vddio-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    pmu {
+        compatible = "qcom,qca6390-pmu";
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
+
+        vddaon-supply = <&vreg_s6a_0p95>;
+        vddpmu-supply = <&vreg_s2f_0p95>;
+        vddrfa0p95-supply = <&vreg_s2f_0p95>;
+        vddrfa1p3-supply = <&vreg_s8c_1p3>;
+        vddrfa1p9-supply = <&vreg_s5a_1p9>;
+        vddpcie1p3-supply = <&vreg_s8c_1p3>;
+        vddpcie1p9-supply = <&vreg_s5a_1p9>;
+        vddio-supply = <&vreg_s4a_1p8>;
+
+        wlan-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+        bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+
+        regulators {
+            vreg_pmu_rfa_cmn: ldo0 {
+                regulator-name = "vreg_pmu_rfa_cmn";
+            };
+
+            vreg_pmu_aon_0p59: ldo1 {
+                regulator-name = "vreg_pmu_aon_0p59";
+            };
+
+            vreg_pmu_wlcx_0p8: ldo2 {
+                regulator-name = "vreg_pmu_wlcx_0p8";
+            };
+
+            vreg_pmu_wlmx_0p85: ldo3 {
+                regulator-name = "vreg_pmu_wlmx_0p85";
+            };
+
+            vreg_pmu_btcmx_0p85: ldo4 {
+                regulator-name = "vreg_pmu_btcmx_0p85";
+            };
+
+            vreg_pmu_rfa_0p8: ldo5 {
+                regulator-name = "vreg_pmu_rfa_0p8";
+            };
+
+            vreg_pmu_rfa_1p2: ldo6 {
+                regulator-name = "vreg_pmu_rfa_1p2";
+            };
+
+            vreg_pmu_rfa_1p7: ldo7 {
+                regulator-name = "vreg_pmu_rfa_1p7";
+            };
+
+            vreg_pmu_pcie_0p9: ldo8 {
+                regulator-name = "vreg_pmu_pcie_0p9";
+            };
+
+            vreg_pmu_pcie_1p8: ldo9 {
+                regulator-name = "vreg_pmu_pcie_1p8";
+            };
+        };
+    };
-- 
2.40.1


