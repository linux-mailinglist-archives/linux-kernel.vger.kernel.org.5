Return-Path: <linux-kernel+bounces-138528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF689F2BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B37D1F25D38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F1315F414;
	Wed, 10 Apr 2024 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HZryfxtr"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A815E5DC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753219; cv=none; b=aY2Y7OB7NgsRRZpdvKQ68sy9zeUHqb4jDnLSZ9fC0CqBN4RkyXEAJW4ewdGrlwT8NmWA3rYJS1G2o2IZJOrh+uvDYF/Q4Imk+vYXlH+p3Ep6+uazsjRlRfs2E2XmPTi3R+5BWSpABnfbiTORMmVShzTBZSZQoSigrO8JOVx3Mgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753219; c=relaxed/simple;
	bh=wf7ju8vqsLnPRCFf/XISMutA94e5S8E6OhesXhPqqxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQjTeeZaftPtvu9pJCVQtpRSPDsJr2WJdCWDfTKMJFDryfmnVaF0KgX5KbMGInFI5E+Etaq8xsmi3lbigLycX0czinKGaXBtF9cf9tyuUJEWn2054vLt9RiOOMMxlNBUQ24FLOpNQKM0PIu2WWjohyG5DKtf3/QOGR9S0n3/W7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HZryfxtr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3462178fbf9so799230f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712753215; x=1713358015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+WJda3ss7hoIdDj+/OQZmjsnCcOcWE53qMUaI5LDqg=;
        b=HZryfxtrIz5VXzJyoWCLnD96ko07VR4Kf+VTiIlbagZseuBPwnrcTZibdPsJRh8ZJQ
         VcQuhi7YoeUZFcDzxn928KEtpyuNB4vqkSgtjtUep8Qt8bYKkJdfQ8YFqpApcvilxIrg
         uxSENXI+ib97lha2GcXI2z7ayCvwkQFP84tja7gsoJc1yxqvhmuKVMLyrUAbXaTShVeI
         C1v6JraGclfV6esDqzRIUSpQ3PCq0JUv4gYb87dOCGhInqHLciZzgKYZodIbcCluJj13
         V0ZWzr21zQv9XwEjH9p8dnAZRln8B7BtcGjJ6xNY19L+JlL+SRI35dq+W3D7b7Ql98GP
         BHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712753215; x=1713358015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+WJda3ss7hoIdDj+/OQZmjsnCcOcWE53qMUaI5LDqg=;
        b=fVWcqM1bF3Rf0nSgjmuAMwfZjpK4QLpZcp5LPqwopCpkF6ICsEyYt8PLcWYIPmthwB
         wQ0yNfuY3wItol2Sh+2IDWwBEuAWJWH1JeWCFrB7K7ZMTRWetjPcWC5GOa17J9e1+vQB
         6vx2fWd0np1X0kbRd1ZixJBYs6OulV98Fpb7cjBHiYvmrV3z3foux6Wgn/nOQT2jCirt
         5zBgW3yKQZ/D3L6N/RrcKffg4ExvWfXb0QkRtTX06T32VY4c7Cv8ESeM1d5XhExPEYmx
         PgCFsvG9YrXViV+3ueAgTNTEh+5W1OslfCGJxRubvI42Di+c6WgN0ua9khq4FXi/VmHU
         7NhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFCjVToZCrMPC9HMfSkGQiP+qqKgsgmSmzO8Ok31LbtdczHR9xQnXigLhi16oaBcoGfEcij0dX6HEWCvOmPZvyrsirl9zbzaPaSvot
X-Gm-Message-State: AOJu0YzCaLX+XG4d4PTg+LCtJttCcXlTGuQ1L8QbP2VbmUjst6829qDC
	2d/UHQ7F6SuLerwzzREqffElaAqQF3CTEzZCGp1AumrisN4sdV/PwQieqNIZPi8=
X-Google-Smtp-Source: AGHT+IEMD5NLD7GnAz7Fnhxb7rz8Ka8o7MjK0O+Jpjw70GJ1GLUqicj0kPjIH2WTWtR3ljiFvgSD2w==
X-Received: by 2002:a5d:6e0b:0:b0:346:66d8:f7ac with SMTP id h11-20020a5d6e0b000000b0034666d8f7acmr1868640wrz.31.1712753214829;
        Wed, 10 Apr 2024 05:46:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:6908:7e99:35c9:d585])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041663450a4asm2150929wmn.45.2024.04.10.05.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:46:54 -0700 (PDT)
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
Subject: [PATCH v7 03/16] dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
Date: Wed, 10 Apr 2024 14:46:15 +0200
Message-Id: <20240410124628.171783-4-brgl@bgdev.pl>
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

QCA6390 has a compatible listed in the bindings but is missing the
regulators description. Add the missing supply property and list the
required ones in the allOf section.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../net/bluetooth/qualcomm-bluetooth.yaml       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 528ef3572b62..d844acaec1d3 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -62,6 +62,9 @@ properties:
   vdddig-supply:
     description: VDD_DIG supply regulator handle
 
+  vddbtcmx-supply:
+    description: VDD_BT_CMX supply regulator handle
+
   vddbtcxmx-supply:
     description: VDD_BT_CXMX supply regulator handle
 
@@ -180,6 +183,20 @@ allOf:
         - vddrfa0p8-supply
         - vddrfa1p2-supply
         - vddrfa1p9-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qca6390-bt
+    then:
+      required:
+        - vddrfacmn-supply
+        - vddaon-supply
+        - vddbtcmx-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p7-supply
 
 examples:
   - |
-- 
2.40.1


