Return-Path: <linux-kernel+bounces-117105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F6688A728
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946691C3D97A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB841487DA;
	Mon, 25 Mar 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VUqPhL5I"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E3D140391
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372627; cv=none; b=H6U/YqGeA2xSpmsx1HNxMxFp0KW/fuQm4HM0sqN4TxkeTRNbX9eUdTQ42XZQbGfB/QHZATY3oprRfECUajm2oTD9EKZFuzDIXgl4occTocHO594j7suI1TYA4s+v1TjDP6vdrODhVpo/l64gU1w1K4VvtejLwRXAwdf8YyeR2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372627; c=relaxed/simple;
	bh=hfgHIMnmFRtgUtFw/WNES77oLFQa+HHCcDhOj+ME/vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rf45u4/fwTl8Ctc3ioVebrEzahdaxHXVegwBtBKsrRb+62FS0Se3PAgu4UELQWr1EZH4f+RzQ5HxP1liY0mvthxv/9c5dbF3hYyR9Tnmcyz1Pg+FcZxoFw4td12V29GWkBDnMnpVC86TLLFsnoYRfdNzNXhIFuZS+tW7LnWq2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VUqPhL5I; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4148c04396dso2023735e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711372623; x=1711977423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGOfh5Up2s4Hsb0xRVMMugzy1VQqOQKd6pFoEiLe/18=;
        b=VUqPhL5I8BiB9qCPijxmso0QfhUJA6kqCUxzrs7jWb5qWPn6s8ZTyU5DCyw8eqPZYm
         tl47Fcxm/PD4KefzYWfATuusl2WTQgiDV1249UrwnqkQ0p/o3aOGl35FOo9g1qDIzUmv
         9GogrgpyYPZQNMis19K6XZxJ+Gv4RPWVgyRsoUBCEovHahW29SzLaptLSuUVHOv/cme5
         jIdxO7hZMLxorF5ROk2ibQ5UbXbWXS1YBnmw+65RwpwGMhjvwx6xBQMyatIVYdenoqAW
         fgGQJe7MloM4mp2EPHkgkzOjLO3CePYdJ611ZHmyQbpJ2k/SUu9kKHA4ilpWAxlGZY9z
         6/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372623; x=1711977423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGOfh5Up2s4Hsb0xRVMMugzy1VQqOQKd6pFoEiLe/18=;
        b=A7uw4LVUQ7Dqsw1JtU+s5YSyX8nsV3XfFKf8whDQBEHhy4ZhoIZH9sEhn3GR3OqBg2
         ajMTHSEMSv1zWOnJimcXXltV5kOg6ueihB82SozMH6OddSsu9lU7mFv5oJlCILslO1Ky
         DhTmZRKG36mz7IuNSOippempSHo11BnHK8/HNkYmun41RqN2PoAoIT/C97ekTvuKHPlm
         DKeZ+18io1lF5DZ21dlYa9jxRhmsNPQAsl18ugKVvAhPP8qOstmXkV36V1J9Ta+Gtpg0
         CkJ5TM/gB+tvT6e23x8btRKDGMvd4+/ZaV7fSt/gXVnaZscEN/j0FndVTZ4RoUiF1TlU
         x6lg==
X-Forwarded-Encrypted: i=1; AJvYcCWMGQAoY3Evh/8/NkmiVl0LeIQTJGq2NitP9g3hOl8MJYvXpUUtq4UhnbA03xRA+/IzLheUjozAO81QY05Tgtwd5IGbT3Ridkw5y1oQ
X-Gm-Message-State: AOJu0YwEUKXekRlu8jmrRimVESH8sB7S/PiJ2PALYxbZmnnYzzFmTM/t
	AZf4hVvAaw7Vl20e1IkGEx7SkiV1bP2WKHB0p7CaCsP9ofP/6B849MmgeblmDdY=
X-Google-Smtp-Source: AGHT+IHZRY1QWKBr33rhlgymM9kBVbcL1shwEGnPH+sbwWy/MBO17W93kXESsMvT66cCBqV7Q+yhyA==
X-Received: by 2002:a05:600c:4714:b0:414:7e73:1f8c with SMTP id v20-20020a05600c471400b004147e731f8cmr4727120wmo.37.1711372622673;
        Mon, 25 Mar 2024 06:17:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id p11-20020a056000018b00b0033e75e5f280sm9485245wrx.113.2024.03.25.06.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:17:02 -0700 (PDT)
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
Subject: [PATCH v6 04/16] dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on QCA6390
Date: Mon, 25 Mar 2024 14:16:12 +0100
Message-Id: <20240325131624.26023-5-brgl@bgdev.pl>
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

Add a PCI compatible for the ATH11K module on QCA6390 and describe the
power inputs from the PMU that it consumes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/wireless/qcom,ath11k-pci.yaml         | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index 41d023797d7d..8675d7d0215c 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -17,6 +17,7 @@ description: |
 properties:
   compatible:
     enum:
+      - pci17cb,1101  # QCA6390
       - pci17cb,1103  # WCN6855
 
   reg:
@@ -28,10 +29,55 @@ properties:
       string to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
 
+  vddrfacmn-supply:
+    description: VDD_RFA_CMN supply regulator handle
+
+  vddaon-supply:
+    description: VDD_AON supply regulator handle
+
+  vddwlcx-supply:
+    description: VDD_WL_CX supply regulator handle
+
+  vddwlmx-supply:
+    description: VDD_WL_MX supply regulator handle
+
+  vddrfa0p8-supply:
+    description: VDD_RFA_0P8 supply regulator handle
+
+  vddrfa1p2-supply:
+    description: VDD_RFA_1P2 supply regulator handle
+
+  vddrfa1p7-supply:
+    description: VDD_RFA_1P7 supply regulator handle
+
+  vddpcie0p9-supply:
+    description: VDD_PCIE_0P9 supply regulator handle
+
+  vddpcie1p8-supply:
+    description: VDD_PCIE_1P8 supply regulator handle
+
 required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: pci17cb,1101
+    then:
+      required:
+        - vddrfacmn-supply
+        - vddaon-supply
+        - vddwlcx-supply
+        - vddwlmx-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p7-supply
+        - vddpcie0p9-supply
+        - vddpcie1p8-supply
+
 additionalProperties: false
 
 examples:
-- 
2.40.1


