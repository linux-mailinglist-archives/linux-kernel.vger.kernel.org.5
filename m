Return-Path: <linux-kernel+bounces-29194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EA6830AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6D41C25E99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E1A25622;
	Wed, 17 Jan 2024 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QK7JaqDA"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D30224B5E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507722; cv=none; b=W8rkuI4zQehMDXCCTCftb7Xr0zF1x4IZr4PotERjmQQlip6nXVtsX/P+8hUvWYPt9ypwQiLIJjSGqQamfFx489aqUrbc6VgpiBH6RfYp3F0cQHxt0db/W6yVKRDWWApngZHASjnUv4MlOWue+0KDIgwQnUuyWOHhBWViSt4u6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507722; c=relaxed/simple;
	bh=mM8PwsCjRqxpEKB13QqnWtlTPmsb6ofAXID4BuBezD4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=Wp4/2VdUmtXiP3hKRdr2ynRN58o0AA2lFXmdWutkhw2dwdHjWoh+UzvGH+ujeslbwazAp7U9f4zzRE+/o4Nq5FhAzPQjG9foc2rkp7Vmc9Tfatm4jyoDewhOKOZh9NeO169a0H7vbRGbak83/4Y/LFIzQEDmQ7utab9DgdBbfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QK7JaqDA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-337c40fde20so629141f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705507719; x=1706112519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KiJFCSMkHl908ixeSikSO3f5Gun1Y9vXqztuxAOHIc=;
        b=QK7JaqDAX6UeY03/jWwluKciFOE4L7Z5QtbBbJsRWC+y010PQ5RkuSa7L3v3FXLFkZ
         +tSgLHDiYLvyGfbzKdaoYKrzIDO49cM+ZQ8nhgOfiHJKx40DfnX1+0aPK0FsNALedjOP
         JqIC25RgMeeUU31utBLG3fsLKCbCYSCaO11r0x8RpW7+jBrx/hmOZ8JkSG5vT0daH1+z
         1mWxjBcWyxs0Zpf/9AZyBD2Xz1ThUcQS+lq4kFOAcU7ubuvUbHRePdZSWWeBbQUlcO2c
         UDjoFIgh1/ceEp8738+sR7R0oiVQ5lciXFigpkpJMHjp/wZuaCqAYcY+wgLGvHX42Zim
         cVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705507719; x=1706112519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KiJFCSMkHl908ixeSikSO3f5Gun1Y9vXqztuxAOHIc=;
        b=K9pMDhd5PuKB7NBKm4U7qy5Eo0xF64X6c1lVAlRga82WFxvTK6ysaBBu1aaHD1iTJO
         CL36yCh2VMLtyAPI01P8maJSRK1MjseaFzLuoRQlJb9opD2/ZJJgWP/4xR5HGJAURcA5
         pcHgn+8zjW5tDkr34OLoaHhI8lj4Tq4CSpaJr+f0/iePRS9AUC88PnJmSXktmopABbip
         HZT5UKPY8HEqmj3+pl+eT2Fc2o9jiNPOWF9PG9zQWxW8W9tueTesHw8ZNpxDAMhFsjux
         t45RJLTmFDz4K+zHavMp2XrRRK8GZXrGEleGPv/gleo8DdPkF/WN5t996k9cr1c/W53f
         6FRg==
X-Gm-Message-State: AOJu0YyIF3RpU2tvmX9slDcqmNrNLgpsj2DSwG2ZJXG1+F/mJPfDxpk4
	YCIJficXxeE6SXC6bSCQhwvVo8nbKUvtOw==
X-Google-Smtp-Source: AGHT+IE09EQiEo3vEyiN4aUkmSSulxM60vCAFa6QFBzATdMqmCKCemxhHosUEgDD4K1ltVFvSuduEg==
X-Received: by 2002:adf:e90b:0:b0:336:6bf0:a005 with SMTP id f11-20020adfe90b000000b003366bf0a005mr4715360wrm.92.1705507719524;
        Wed, 17 Jan 2024 08:08:39 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d0b5:43ec:48:baad])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d6a4a000000b00337b0374a3dsm1972092wrw.57.2024.01.17.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 08:08:39 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Lukas Wunner <lukas@wunner.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 8/9] dt-bindings: wireless: ath11k: describe WCN7850
Date: Wed, 17 Jan 2024 17:07:47 +0100
Message-Id: <20240117160748.37682-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117160748.37682-1-brgl@bgdev.pl>
References: <20240117160748.37682-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Describe the ath11k variant present on the WCN7850 module.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/wireless/qcom,ath11k-pci.yaml         | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index c8ec9d313d93..5648c855a122 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - pci17cb,1101  # QCA6390
       - pci17cb,1103  # WCN6855
+      - pci17cb,1107  # WCN7850
 
   reg:
     maxItems: 1
@@ -28,13 +29,25 @@ properties:
       string to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
 
+  clocks:
+    maxItems: 1
+
   enable-gpios:
     description: GPIO line enabling the ATH11K module when asserted.
     maxItems: 1
 
+  vdd-supply:
+    description: VDD supply regulator handle
+
+  vdddig-supply:
+    description: VDD_DIG supply regulator handle
+
   vddio-supply:
     description: VDD_IO supply regulator handle
 
+  vddio12-supply:
+    description: VDD_IO12 supply regulator handle
+
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
@@ -61,6 +74,18 @@ required:
   - reg
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - pci17cb,1101
+    then:
+      properties:
+        clocks: false
+        vdd-supply: false
+        vdddig-supply: false
+        vddio12-supply: false
   - if:
       properties:
         compatible:
@@ -69,7 +94,11 @@ allOf:
               - pci17cb,1103
     then:
       properties:
+        clocks: false
         enable-gpios: false
+        vdd-supply: false
+        vddio12-supply: false
+        vdddig-supply: false
         vddio-supply: false
         vddaon-supply: false
         vddpmu-supply: false
@@ -78,6 +107,18 @@ allOf:
         vddrfa3-supply: false
         vddpcie1-supply: false
         vddpcie2-supply: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - pci17cb,1107
+    then:
+      properties:
+        vddpmu-supply: false
+        vddrfa3-supply: false
+        vddpcie1-supply: false
+        vddpcie2-supply: false
 
 additionalProperties: false
 
-- 
2.40.1


