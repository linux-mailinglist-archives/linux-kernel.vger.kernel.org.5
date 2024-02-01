Return-Path: <linux-kernel+bounces-48150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 214C78457FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07F8291319
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C586641;
	Thu,  1 Feb 2024 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUhyzWlF"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E08662D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791489; cv=none; b=c6JludateV3gWASs/0MYSlRrCMe459/9Kk3umTIPfype5fYdJ1mR8aWmRKsP2ZZGEiKRfwOu/P20YNIZzWNDjvXrUxUfVPsAUHzQQ5VaB6r73DFJIGGwbmnNC/dG1VmuhYyHiEzzKkmH+huffkPziileeFBJPp8rRl0EvzGz96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791489; c=relaxed/simple;
	bh=cMOgKHl3hFEvrtZHLmzMkolouVi6dIm35eDyzehQC/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tfdcrXLtJ8GM1sam8PmR2dWHrN1OuqpsLvC9J/+0lrGGuHMdMh/h0ioCyaIAoNCNcL/7SfPvgcArndDYSGiNjJmpGPBw8EZYX2B9bIquGzNTq+MV99l8QpeQQdCNafpevAAFNvtQramHjKh1AVeW1vyC8+Mh/B4YTqnknALgwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUhyzWlF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ef75adf44so7931385e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706791486; x=1707396286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6IHYNEjrz+fMnkN7rBKRPCSWZe0v/T0N15MdaE6oBBg=;
        b=lUhyzWlFNM/vkQyNLzY7cXCYAOAV0XSUwuQlFVp4c4I+CVbXKYp20Qycd4pflkGLIh
         0f58dRln8al2h1kTEWdBvjrpoSXASs467HoL+T1v00rHdUoCcB1x+1a/zJwv2f9SdiCJ
         SottA5C8fhHSjDHgti2eSyECgiZhf7pzk7sWZ9EFIehB7YJI3Y1LwReH5guXshL/Mpip
         SSd2muHZdqN71beaTZzmA8lFR4knfS44LcbS/EMWFWrPytodSuwcAav2ysdyeRbtItSx
         kLe6WeAcNkygBVF/FN/j/2M+sPTWXK/eVf4RyQtxQzlCNJw46WZv5GWcKgd5um4isAv9
         aUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791486; x=1707396286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6IHYNEjrz+fMnkN7rBKRPCSWZe0v/T0N15MdaE6oBBg=;
        b=oaUpbHse9oducIb7lrpjDZA6D8CoxXrgHRCP6F46VZN8yyH8CNn0ewWKSLckUIQU+d
         xXfbupxVLsHgXNCz6G5tr/KOnzJL56tGiJBbx1QGLEQgJJHZSc5V3uVHrUd9GHN1k2AB
         aoos5F+4gup2Cbn3UDUCkirvPx9cCn1IjrnQPzpRVWdWFzrW249DxekPqFIaHnFYG+9R
         sLo2lPZY83j5UX7J6fuc8gm1et+oTP59ZrJjdk23Axb135VZH04RzgZZzteyDPCZrUXQ
         G4Dr5R+rpesuTsy2lhG7EMxdceOCqLsrOHT1S1fQyAJlfqsb2JiAi7rK8uJpPCgH2kp4
         XhEA==
X-Gm-Message-State: AOJu0YzR5lAJ0SMBOyy278rzo9D2HryTqArcXlqPt+kXgSlVQEAJH8aI
	iqk4ndlptsO1N6UgWKPX7GiyH5bbD2fcs1pWF+bmwrOPC059no7/0qsVTx5f
X-Google-Smtp-Source: AGHT+IH9YbsjSMfEN7/ZxTFY71wHCViMJcRPseJso13x5uspbJi9rylCpTSQtwzo5cDG75EvN3c24g==
X-Received: by 2002:a05:600c:4f4d:b0:40f:b65c:6127 with SMTP id m13-20020a05600c4f4d00b0040fb65c6127mr2881416wmq.35.1706791486133;
        Thu, 01 Feb 2024 04:44:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXlasx3CmtE47ZwaWveo1MK/khSiwuxBliYYlFYx+i+SBYU4+x+KwjTVjMkDXRdGNuESyYhHgDgYGk6JOefzcidpECDxibfwcgQJP6LgYCgIXc9EUXy6txcDe9ROJQRbRJC0F31qDOqxEtpdgkewY9lwB5i88X6kN4=
Received: from localhost.localdomain (2a02-8388-180a-cd80-ae73-baa1-6de4-2169.cable.dynamic.v6.surfer.at. [2a02:8388:180a:cd80:ae73:baa1:6de4:2169])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c1d9700b0040e9d507424sm4483028wms.5.2024.02.01.04.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:44:45 -0800 (PST)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	jakob.unterwurzacher@theobroma-systems.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: add attiny_rst_gate to Ringneck
Date: Thu,  1 Feb 2024 13:44:27 +0100
Message-ID: <20240201124427.279986-1-jakob.unterwurzacher@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ringneck v1.4 can contain (placement option) an on-board ATtiny
microcontroller instead of an STM32. In normal operation, this
is transparent to the software, as both microcontrollers emulate
the same ICs (amc6821 and isl1208).

For flashing the ATtiny, the SWITCH_REG1 regulator of the board's PMIC is
used to enable the ATtiny UPDI debug interface. If the STM32 is placed, or if
we are running on an older Ringneck revision, SWITCH_REG1 is not connected
and has no effect.

Add attiny-updi-gate-regulator so userspace can control it via sysfs:

  echo enabled > /sys/devices/platform/attiny-updi-gate-regulator/state

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index dec29a75d361..1f7f4b2ea66a 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -15,6 +15,12 @@ aliases {
 		rtc1 = &rk809;
 	};
 
+	/* allows userspace to control the gate of the ATtiny UPDI pass FET via sysfs */
+	attiny-updi-gate-regulator {
+		compatible = "regulator-output";
+		vout-supply = <&vg_attiny_updi>;
+	};
+
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		pinctrl-0 = <&emmc_reset>;
@@ -146,6 +152,7 @@ rk809: pmic@20 {
 		vcc5-supply = <&vcc_3v3>;
 		vcc6-supply = <&vcc_3v3>;
 		vcc7-supply = <&vcc_3v3>;
+		vcc8-supply = <&vcc5v0_sys>;
 		vcc9-supply = <&vcc5v0_sys>;
 
 		regulators {
@@ -290,6 +297,11 @@ regulator-state-mem {
 					regulator-suspend-microvolt = <1800000>;
 				};
 			};
+
+			/* supplies the gate of the ATtiny UPDI pass FET */
+			vg_attiny_updi: SWITCH_REG1 {
+				regulator-name = "vg_attiny_updi";
+			};
 		};
 	};
 };
-- 
2.43.0


