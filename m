Return-Path: <linux-kernel+bounces-60327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250CE85033A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B584D2858BD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F112555B;
	Sat, 10 Feb 2024 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BaKaH5If"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606CC3D0CF
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707549018; cv=none; b=u7aNLU92FgYqBvI4qkUe/LPIS+ynmi5XgwXjAOWZAucOeKNrUDZmu8XbkvGqLoM54zKMsBP/g2vK1AC06mkALzoArIUhGuTyzNRC/mTBrQFPF6BVfdbuvCEmSW2nAm6QlLMjw74C5cUo9z1zNBad8PzqhQIG6ED23jOlKc8Cgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707549018; c=relaxed/simple;
	bh=Gr/cjYsEPFS9YtkIRTTBs4NFAZVd1rZbQ149cefKuGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5hufHILYFbYj0AcwxDna5L1K2x7s8OTvmcu3dPplFjv9sOT57OLpkiBJtB8oIpQ4YGG4ybAxBc2sKXhUr4zF3AakkpW/BrrkdHqFXjhTw1MmktQBPVP3bBkcYsUOUaJMbcFRj/DCs/0G0QwDiSnmliwLhgOF9BSXPPDuG7Xdek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BaKaH5If; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d751bc0c15so16127765ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707549015; x=1708153815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRdeafd1oFQ133DVCweG1iG5WfY6aqYTpGOenc4j5OI=;
        b=BaKaH5IfZrHA1ZsmjwfFs6OC5FoDrnN1/2GFDQwhPW0jwF8YCVQODsATXJpkd0eEHN
         5iHEuOnxr5NJq2YLoWom6ADvAUM1yKLgkcUe/0BeqfVZidQjfyYLE5FEWBlrEpGK32e1
         qGxnhE0qeyM3RaXLG9QkwxxhtZGI186YmjBIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707549015; x=1708153815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRdeafd1oFQ133DVCweG1iG5WfY6aqYTpGOenc4j5OI=;
        b=Nxh6WI2iUGLHeFUS0gQoEjLYUHjUquj1PsqVvfRER2e0SF22VcU9NqQK1hMBQbpxkc
         kuRdAGEUG8tRor0+0jYtTUIRwH6Qdra4oehSfEtTol8c/mhFXYBSbQksjAC+gHLypG/l
         fxLa+eT3ZtaEQTCAwdZ89NRg7an6z1SoYjkPBypu84mxzkFtXoMjZlFT+AxlfkidZMoc
         iBfwqB8/tCETQvyfZX/AzNjcPHoUACebz+ifeh9VP3d4NhCPOheCAYzBnQT8yiK4n70J
         9aFaoxBvK+IbAcyCTC0vEkCl9/6KVOGBy9JU3gMB7flIvnyyZ62rMDkLnOaQEVhPyH8J
         M3Gg==
X-Gm-Message-State: AOJu0YyqjxH620Wdlrjz/GJE0bACtmsyi5wNARHUdHK3IReAQUa2intl
	IrumRttdHal33RLtTYs2JSuo1f74tkThy+i2WnC7MOqsHBh9QRlwSakbelmAjg==
X-Google-Smtp-Source: AGHT+IEPebBATSj4xLUJJxKqaWO05lkMH0b2sVPfG4NHB+qrjNTT6Gm4CBU6EDUiPGoN1DCdFsgbxg==
X-Received: by 2002:a17:903:1c3:b0:1d9:f5ef:a053 with SMTP id e3-20020a17090301c300b001d9f5efa053mr2125350plh.28.1707549015013;
        Fri, 09 Feb 2024 23:10:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhvoFacBD758Jr2FAazJV9jtMATSRjM6lLTU+VryD1+MXyMlRL1JUn+pSH1X3C2lhy6Ff4fxx2yZCB8vupGbS6DRn0OfEczHy8cpXMWP5fxR/OSAFV60tnXCLb0nPrl8cPmN5ZFz8p2O0kuh3r1DcBwKJI2BXXA/VcLhQZ+u2ULK18qkk8AHHshWI2iNFS8e3ifKj3IU3kff15f0vfC16jg/drG/ON3QVqEHoemowPSD/o2ewg2OPp3QxenNh1y7nM8UC2oVTGjlvpGLJujkSOC0FKmI0pxQa0MpMBDQdTCdM1wFmfdYjHqSZ9Ry4XiEGfy9lJv12hUCNJfVI+GinDIzp+27LGI1EGGxHrcKOz5GVgvhT4FUWpxcpIwwYJCgKxjC1w67ZNCt+Tm/oq1bIzCnIRS0EP6tz6XOVtej26z1pYNfusp2NMDmPQqVL2w4JSyRqSTruv4QuqKd9q9dgz0TPest5ECnp3ZVb2/pMKUFav+pWx2UnG6en1gbZ/9avZaMYMGBoiog58yw==
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id h9-20020a170902f2c900b001d921bcc621sm2478586plc.243.2024.02.09.23.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 23:10:14 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	cros-qcom-dts-watchers@chromium.org,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 21/22] arm64: dts: qcom: sc7180-trogdor: Make clamshell/detachable fragments
Date: Fri,  9 Feb 2024 23:09:32 -0800
Message-ID: <20240210070934.2549994-22-swboyd@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210070934.2549994-1-swboyd@chromium.org>
References: <20240210070934.2549994-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At a high-level, detachable Trogdors (sometimes known as Strongbads)
don't have a cros_ec keyboard, while all clamshell Trogdors (only known
as Trogdors) always have a cros_ec keyboard. Looking closer though, all
clamshells have a USB type-A connector and a hardwired USB camera. And
all detachables replace the USB camera with a MIPI based one and swap
the USB type-a connector for the detachable keyboard pogo pins.

Split the detachable and clamshell bits into different files so we can
describe these differences in one place instead of in each board that
includes sc7180-trogdor.dtsi. For now this is just the keyboard part,
but eventually this will include the type-a port and the pogo pins.

Cc: <cros-qcom-dts-watchers@chromium.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../boot/dts/qcom/sc7180-trogdor-clamshell.dtsi      |  9 +++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  5 +----
 .../boot/dts/qcom/sc7180-trogdor-detachable.dtsi     | 12 ++++++++++++
 .../arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi |  7 +------
 .../boot/dts/qcom/sc7180-trogdor-kingoftown.dts      |  2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  3 +--
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |  2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  2 +-
 .../boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi  |  7 +------
 arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts       |  2 +-
 .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi    |  5 +----
 11 files changed, 30 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi
new file mode 100644
index 000000000000..bcf3df463f80
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Trogdor dts framgent for clamshells
+ *
+ * Copyright 2024 Google LLC.
+ */
+
+/* This file must be included after sc7180-trogdor.dtsi */
+#include <arm/cros-ec-keyboard.dtsi>
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 7765c8f64905..6e6a4643c4dd 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -7,6 +7,7 @@
 
 #include "sc7180-trogdor.dtsi"
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
+#include "sc7180-trogdor-detachable.dtsi"
 
 /* Deleted nodes from sc7180-trogdor.dtsi */
 
@@ -80,10 +81,6 @@ &camcc {
 };
 
 &cros_ec {
-	keyboard-controller {
-		compatible = "google,cros-ec-keyb-switches";
-	};
-
 	cros_ec_proximity: proximity {
 		compatible = "google,cros-ec-mkbp-proximity";
 		label = "proximity-wifi";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi
new file mode 100644
index 000000000000..ab0f30288871
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Trogdor dts framgent for detachables
+ *
+ * Copyright 2024 Google LLC.
+ */
+
+&cros_ec {
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index 2ba3bbf3b9ad..a86a6c5c3f67 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -8,6 +8,7 @@
 /* This file must be included after sc7180-trogdor.dtsi */
 
 #include "sc7180-trogdor-rt5682i-sku.dtsi"
+#include "sc7180-trogdor-detachable.dtsi"
 
 / {
 	/* BOARD-SPECIFIC TOP LEVEL NODES */
@@ -135,12 +136,6 @@ &camcc {
 	status = "okay";
 };
 
-&cros_ec {
-	keyboard-controller {
-		compatible = "google,cros-ec-keyb-switches";
-	};
-};
-
 &panel {
 	compatible = "samsung,atna33xc20";
 	enable-gpios = <&tlmm 12 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
index d6db7d83adcf..655bea928e52 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
@@ -9,7 +9,7 @@
 
 #include "sc7180-trogdor.dtsi"
 #include "sc7180-trogdor-parade-ps8640.dtsi"
-#include <arm/cros-ec-keyboard.dtsi>
+#include "sc7180-trogdor-clamshell.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
 #include "sc7180-trogdor-rt5682s-sku.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index e9f213d27711..c3fd6760de7a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -5,8 +5,7 @@
  * Copyright 2020 Google LLC.
  */
 
-/* This file must be included after sc7180-trogdor.dtsi */
-#include <arm/cros-ec-keyboard.dtsi>
+#include "sc7180-trogdor-clamshell.dtsi"
 
 &ap_sar_sensor {
 	semtech,cs0-ground;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
index 73aa75621721..60ccd3abddfc 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
@@ -6,7 +6,7 @@
  */
 
 /* This file must be included after sc7180-trogdor.dtsi */
-#include <arm/cros-ec-keyboard.dtsi>
+#include "sc7180-trogdor-clamshell.dtsi"
 
 &ap_sar_sensor {
 	compatible = "semtech,sx9324";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index 0be62331f982..43b2583f0f26 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -7,7 +7,7 @@
 
 #include "sc7180-trogdor.dtsi"
 /* Must come after sc7180-trogdor.dtsi to modify cros_ec */
-#include <arm/cros-ec-keyboard.dtsi>
+#include "sc7180-trogdor-clamshell.dtsi"
 #include "sc7180-trogdor-rt5682i-sku.dtsi"
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
index b7de9fd3fa20..00229b1515e6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
@@ -9,6 +9,7 @@
 
 #include "sc7180-trogdor.dtsi"
 #include "sc7180-trogdor-rt5682i-sku.dtsi"
+#include "sc7180-trogdor-detachable.dtsi"
 
 / {
 	ppvar_lcd: ppvar-lcd-regulator {
@@ -44,12 +45,6 @@ &camcc {
 	status = "okay";
 };
 
-&cros_ec {
-	keyboard-controller {
-		compatible = "google,cros-ec-keyb-switches";
-	};
-};
-
 &gpio_keys {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
index c9667751a990..4b43a9b273c0 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
@@ -9,7 +9,7 @@
 
 #include "sc7180-trogdor.dtsi"
 /* Must come after sc7180-trogdor.dtsi to modify cros_ec */
-#include <arm/cros-ec-keyboard.dtsi>
+#include "sc7180-trogdor-clamshell.dtsi"
 #include "sc7180-trogdor-rt5682i-sku.dtsi"
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index 305ad127246e..1d9fc61b6550 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-detachable.dtsi"
 
 / {
 	avdd_lcd: avdd-lcd-regulator {
@@ -104,10 +105,6 @@ &cros_ec {
 	base_detection: cbas {
 		compatible = "google,cros-cbas";
 	};
-
-	keyboard-controller {
-		compatible = "google,cros-ec-keyb-switches";
-	};
 };
 
 &i2c4 {
-- 
https://chromeos.dev


