Return-Path: <linux-kernel+bounces-83206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9565386903A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36466B29C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C8313B797;
	Tue, 27 Feb 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOFLqdpy"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6313B2B2;
	Tue, 27 Feb 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036261; cv=none; b=pjc7tHZrcQO4iWKdfP5kWfIl8np0Jsvys/6dxGIHp45pOVQwuYp8oPGLZd4jpUn0JlpE9e7IcUE28TJ7r0x7Egv/3p/CtL3BNCWZZgyluCVlntM2sISYThpuanATr0BoeOlwrGXUXRSg+0mIDEG2yI/T7XFNsi3uSgDgln3Qo44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036261; c=relaxed/simple;
	bh=SzCGOoE3hkaTLGJ0e9jX5jGhMOFFBIeUwgKDelutdcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4ZYUWh8ENf9qQmTJ4r7j1Vy/iaI/zt4Vd4r1gt6dJl/524AuwC8Re9XVLt3ycXEV5DZ3+k2M8yZFqHMb1ePBm1y/+SCITznGgp/6SUhhKEbq9FOBM82JM/K5YceN1xkyf0VcXlbnCP03Mrt6FLaFUiH/l66/ZNQGFOUuoZAEfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOFLqdpy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc0e5b223eso34571425ad.1;
        Tue, 27 Feb 2024 04:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709036259; x=1709641059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lb5Ok4w85QGgWrvRTc/uH58nsPSEhf/ecmwtP/8f9Eo=;
        b=iOFLqdpyt7XD8j0E3PmQFAdtS+epPXHnFrZiIER39HR8jJRq8LAn/KgMo+7cr1WF6O
         O3hIRf7eSBlVSXDB066oRh+7BpCDiEjFm39CNxQ5Keb9QgzKj91YIK7EjqKMjrkG8dbZ
         882e5maEsqtMIwL37OVxuT1AlQdgP9G3FuE1HY0uV182QLx+bhmw/XBaAEQUQPwH1C3o
         Evcj7vcp2Eva4il2f8rvMfFOxSXMrzHdBnPTWP9Uc30Q6vlVnvfUA88H69zKyljGJKYm
         WJQAHkMLDrFh0YcGi8gqqKPs8B156vzeUyaYmMjJyL9ATVzguyPQxqmFJlKNP4hjQKSZ
         o1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036260; x=1709641060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lb5Ok4w85QGgWrvRTc/uH58nsPSEhf/ecmwtP/8f9Eo=;
        b=k/KomnL4a5spHldudmA0F3RaSvszQXPQn092ugDQnXl38OW5yYKipYjs85tXrzZFMm
         dEUK2j4fy41282O6CgCoLbJ0oyqlZ79868URZJjd4z7dXPa0qef163G8+/zw+kCl909A
         h18Uusw0ZYEdNGMw3MhgcZlqQ2f2ceKdpnoSvXNKmbbFhU6xHlVHiWAbWZOQP/N363WB
         ArXaxLTRBeJJ0aXAcCx+HnDoPTn7jGvHG4OTSyYiB6CLE7wFKger7bbUAoli9faZnxjR
         +KN41B++egw/zWmTP8T0+GohBovnlZhvui/YCXQCqn+ADZdZB42pT97yI+v80zXBOMIF
         GDFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr3mVpAz9JV1baym1Y3HT2TYBeYa6NdtwqHJvgcSs8G5pKakXWrGvjE7j1kHx8kqdfuWKJe9PBRhHpJiadusS9iCOMWjdAsF+knMGsRsY922sNUhIylTP0ZshnLEwS9biard/F4hba2w==
X-Gm-Message-State: AOJu0YzzdYHkmbggPaaWxR2k8w64WWp3drBV4FFCY/Q2dJUOIGBjkMkJ
	pD5Ya8jQoabyj9Q5GCg0RrBHuGM+XWgIIdrFvORrY34M/qGON6M9kkSilXWD
X-Google-Smtp-Source: AGHT+IEcM3MIDSca5SOpzZzWwLBD513CZOSAx7EE4Xr+yOIidSgoXE8OWqlw3xvn0zXeXDqhQF+SFg==
X-Received: by 2002:a17:902:6506:b0:1dc:8fb0:2b9e with SMTP id b6-20020a170902650600b001dc8fb02b9emr5212017plk.34.1709036259350;
        Tue, 27 Feb 2024 04:17:39 -0800 (PST)
Received: from localhost.localdomain ([103.149.249.227])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902c45100b001d77a0e1374sm1409563plm.151.2024.02.27.04.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:17:38 -0800 (PST)
From: Jianhua Lu <lujianhua000@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH] arm64: dts: qcom: sm8250-xiaomi-elish: set rotation
Date: Tue, 27 Feb 2024 20:17:44 +0800
Message-ID: <20240227121744.10918-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xiaomi Pad 5 Pro has a 2560x1600 portrait screen, set RIGHT_UP rotation
to make it look like a landscape screen.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 946365f15a59..6f54f50a70b0 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /*
- * Copyright (c) 2022, 2023 Jianhua Lu <lujianhua000@gmail.com>
+ * Copyright (c) 2022-2024 Jianhua Lu <lujianhua000@gmail.com>
  */
 
 #include <dt-bindings/arm/qcom,ids.h>
@@ -551,6 +551,7 @@ display_panel: panel@0 {
 		vddio-supply = <&vreg_l14a_1p88>;
 		reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
 		backlight = <&backlight>;
+		rotation = <90>;
 
 		status = "disabled";
 
-- 
2.43.2


