Return-Path: <linux-kernel+bounces-138530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8FA89F2F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E27FB2465E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EE616F914;
	Wed, 10 Apr 2024 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2WiuBvYM"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F015F32D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753223; cv=none; b=o6FdgEQgXYydCXzQMg+lc46DXap+PHhiWXsNiFk5l4JYDHic66+hXowpeogrGCW1iBOPqfQwLMZHYnMcuN3gl4nLXN2pJNGLN4Oj5UZu44kyVPrO4Z3A+vhOd0on5gcYjS4B0Ts4Z0zMCQR/dsqE2gYr5OrskkrY+P3W47rPXsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753223; c=relaxed/simple;
	bh=yuUbhrVP+Y0H7UT/O3thYPD6emXiObImUnYqdZK+3KI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZnP3vfT05GZppEPwNOQ+Ga767h/6KJZczF7ZuaCOOjVrd+/7m2fPK09lR5cCZvGiqHQ4cnDTKmktM0XNt7KQTywsbgIhaAqMmiM8AgGIN9Ew/F1hwluRAjSWb0FOG0mYyVCtYWB+CK+MMZd9zwRlBhIfuM/zAoEMYN5BUbL+TKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2WiuBvYM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d895138d0eso28126061fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712753218; x=1713358018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL+qn26ifXXRkGbTTkra4Pi9LQ/hbimmKLqK5bNd5H0=;
        b=2WiuBvYMKRPzSbRZdcgTIBZeF2KeFTak5ZjKOSGP1zT4nwP01WLMihS7+CcteoZbfr
         EkXuQOYqLM+ccRyz6rlJqGPB/uVzfZbgNRveMI6II2mxaAsNoc9yX83SNTMnCo8Ndzcw
         02o/kSAM6Q9keUYgd+QQwManE+80+xMLNAoUIye1RCm1oTdB0/obMs5ctsbHMgda9kFh
         6Ymxy3h0+PBfa1WUiZekQ8sgjUlfIAKYN4CHi3BceFI6R23p3vBHf7uP5sw3dq+AUFRL
         ndQHC3SLvlJaeT8+GTcKtQpnw6X4WJYEtcdX1unUloFZj3bcKvl5JcVXpOg2UercdYhW
         3MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712753218; x=1713358018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gL+qn26ifXXRkGbTTkra4Pi9LQ/hbimmKLqK5bNd5H0=;
        b=t5GETyf34wJhfid3SPPVMhtjSblRx55u+zzcxTt6KcqKhPw9hhJ9OI2w9WECdllySL
         qjTKlt4FItGprebimnYMfftMsKQrlqhZ09alMaPKCU61ygpvXrkE1b50tXFc8zVgPX/8
         wdA0YCC+qmw75S+seVBY0unXglEtq6HjAxl2hPtNmO1n+gWzKuFiBVfBDV+LTUzSSlVo
         njIdYVN5S4i6KWn6yHFVf/jR+cWwlEoHTCXXK7n3CExooEN8TojaTpJ/tuN/5HinooWX
         uEJ+Bko25gVXc5y+QNR6MfiaIPrPKcTpcdzOkfoizcjkthOyAzIaiCsTIHrgN4SF018/
         MTjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8dXFKwhX1AwfejbL+x9BizjVWCLbipzTXJ5mqnwqBXVWxz29L+LU2x24aMcXgmnzmtUvxHHSjZ2eHofRflxzi/V55dslt2x4yY2aX
X-Gm-Message-State: AOJu0YzuZKaa48/4Lo8H/kyP7G4HA4DLnHM9Zr29EUZzFIqRxEQziR5i
	15dP1wtZxO+Fcy4DIuuADdGt4kd5ndHM/UOAyBvtFBPGtGQ0mTT3QWQsqLZ+j9U=
X-Google-Smtp-Source: AGHT+IFAtqUdx5RNZKwhTA+R/6J6N9lpFC+miW0F6cNugAKikLhl4qd9sCjbuh2MDg1XRgAmue0OEw==
X-Received: by 2002:a2e:a789:0:b0:2d8:c12b:f291 with SMTP id c9-20020a2ea789000000b002d8c12bf291mr1936525ljf.26.1712753217739;
        Wed, 10 Apr 2024 05:46:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:6908:7e99:35c9:d585])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041663450a4asm2150929wmn.45.2024.04.10.05.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:46:57 -0700 (PDT)
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Xilin Wu <wuxilin123@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 05/16] dt-bindings: net: wireless: describe the ath12k PCI module
Date: Wed, 10 Apr 2024 14:46:17 +0200
Message-Id: <20240410124628.171783-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240410124628.171783-1-brgl@bgdev.pl>
References: <20240410124628.171783-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add device-tree bindings for the ATH12K module found in the WCN7850
package.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/wireless/qcom,ath12k.yaml    | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
new file mode 100644
index 000000000000..f04d72d2c88e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2024 Linaro Limited
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies ath12k wireless devices (PCIe)
+
+maintainers:
+  - Jeff Johnson <quic_jjohnson@quicinc.com>
+  - Kalle Valo <kvalo@kernel.org>
+
+description:
+  Qualcomm Technologies IEEE 802.11ax PCIe devices.
+
+properties:
+  compatible:
+    enum:
+      - pci17cb,1107  # WCN7850
+
+  reg:
+    maxItems: 1
+
+  vddaon-supply:
+    description: VDD_AON supply regulator handle
+
+  vddwlcx-supply:
+    description: VDD_WLCX supply regulator handle
+
+  vddwlmx-supply:
+    description: VDD_WLMX supply regulator handle
+
+  vddrfacmn-supply:
+    description: VDD_RFA_CMN supply regulator handle
+
+  vddrfa0p8-supply:
+    description: VDD_RFA_0P8 supply regulator handle
+
+  vddrfa1p2-supply:
+    description: VDD_RFA_1P2 supply regulator handle
+
+  vddrfa1p8-supply:
+    description: VDD_RFA_1P8 supply regulator handle
+
+  vddpcie0p9-supply:
+    description: VDD_PCIE_0P9 supply regulator handle
+
+  vddpcie1p8-supply:
+    description: VDD_PCIE_1P8 supply regulator handle
+
+required:
+  - compatible
+  - reg
+  - vddaon-supply
+  - vddwlcx-supply
+  - vddwlmx-supply
+  - vddrfacmn-supply
+  - vddrfa0p8-supply
+  - vddrfa1p2-supply
+  - vddrfa1p8-supply
+  - vddpcie0p9-supply
+  - vddpcie1p8-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/gpio/gpio.h>
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        pcie@0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            bus-range = <0x01 0xff>;
+
+            wifi@0 {
+                compatible = "pci17cb,1107";
+                reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+                vddaon-supply = <&vreg_pmu_aon_0p59>;
+                vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+                vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+                vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+                vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+                vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+                vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+                vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+                vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+            };
+        };
+    };
-- 
2.40.1


