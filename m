Return-Path: <linux-kernel+bounces-70010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6AF8591B1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0771F21A83
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA8F7E0E7;
	Sat, 17 Feb 2024 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPq12BBf"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E9A7E107;
	Sat, 17 Feb 2024 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708194169; cv=none; b=SXQJ06x+1S42W/mWe+CXj48/GuAn0xkBfvypejNFcas3YnDHHipyBdCALvqILbwWEXHykS/osFLYf6VfwkjxU+6betX9T+VLkRYqW8UCTLZmktp3Oex/+akpWv68WHJaG8zWFA67E3lbPzdZMLq0nBRgOrn3AZjSeWeM1tl0pqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708194169; c=relaxed/simple;
	bh=8oifpfarV9J6Wvv+SArdQLyLIPIXjJtvpilJDp3o5xY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d2OUUaeCf/mgXr+wagj5VNjMo2sYWQbXHnADSJb81g9uoxZu7x4nvK3Y3OkEdH9wl921YdAccP2Cp8/+Hm//pGb+vxzIEnM4MtjrGxT/GGUqE+oilfYoBlChs9yOkyS2dtcof7vuBm9EWdwvaAkGw7eTHSNiNkg2jjDpzGLznDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPq12BBf; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5120ecfd75cso4267917e87.0;
        Sat, 17 Feb 2024 10:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708194164; x=1708798964; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dovcf13yx7y8WE/3o6ZxD6mwwUIJXyS5E3nGvyjgRKw=;
        b=RPq12BBf3Drt8NYv1CSOm1tP8T5jG5T1noI7UpOfVjIA7zgvCFEg0NYaytHaone9e/
         1EFoa5Mk/Eqa6pG1epXTuAPQZC9Ugla0nteCqpqR+tqtyDY+0YOREOGTGUeAvJUqeIZH
         mMk0FyFWmuoyI0gBNSnfnBiEFkcZNcrXGLJ8J5IWJt0IiUewFxdJo9/7yrvgq9IMzLyt
         2YivJcE1/Wu4PxkRGRDU3AeXhz21+uVcC89B+rTYBkvJcvntwMcRmHh5VrurDfA2SjiM
         Q9uabP4OZHja2roIajH7JYQruKdH9IMUDLdK+gDKmFxsdmSPi0X1Uj97DRcyRqyaqlyI
         ZGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708194164; x=1708798964;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dovcf13yx7y8WE/3o6ZxD6mwwUIJXyS5E3nGvyjgRKw=;
        b=xUZD8gr3cl2XPFGIHYrbQxA92IBdWQTU3N3lnLJgIz5/iM8KFz+R28xGMNWZ2ySeal
         ct0gk5rvQJ7WeVn+SdkQmJzoTmbWiRHLXFhn+cIte2L3W+uH9pOL3YRJ/cAQBfAAmOdy
         wyBuvR2fLIvwJtgBJE0nwbwdGv5r8ipNvZNCKvxZecKIj6bJvVwknJ1ggSgjUBS4JNOv
         RN3dWEBSJrqHVNPx6iewAR4eeoPgr01qgBKT47/SIu6NM03Fp1HQT3NEid3uooqImnFU
         rb62CnONCefVtejkxaxrpy3ZV47v0tuzjt3QVzVETKwr3y4bJO1As0/6GU4mFaj/qWjb
         mUdw==
X-Forwarded-Encrypted: i=1; AJvYcCW5mn+RWSGUme6+h1HRTkwFGlrIKEaHfNMSDS7gEdPeUqivhIH2jAb0RqFCX/f0oFDkB9/IZZMoD8zDLdNXXHWIjkGxTUF+LwC+o96Nu/V/tqNOByTHW4qk5ChNulTDDUCNWAvcAslTyIwzgWM3IzzN6GtCHA/niH6WS/3JBkZD7TbAWpTF7WQG1jEu
X-Gm-Message-State: AOJu0YyDsaqqQvnyVLbK171efDGgECejl6xzv9qSSUgBakpZ5MNYhcZC
	ovhnagdbV/w7kRlNWHBvvQij0/o+vGAlrcUo6qMTvNsUkcHQJAdEytUUVByj
X-Google-Smtp-Source: AGHT+IFA9gLy0VjL49HWtcm3DCshExQ/nRE0roMCJYdiHrnptZHlUeEpYO5V+0rz/0w1MwdGSnujaQ==
X-Received: by 2002:a19:6904:0:b0:511:6b24:ba46 with SMTP id e4-20020a196904000000b005116b24ba46mr4771705lfc.34.1708194163841;
        Sat, 17 Feb 2024 10:22:43 -0800 (PST)
Received: from hex.my.domain (83.8.201.110.ipv4.supernova.orange.pl. [83.8.201.110])
        by smtp.gmail.com with ESMTPSA id p4-20020a05640243c400b00560c6ff443esm1058750edc.66.2024.02.17.10.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 10:22:43 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 17 Feb 2024 19:22:40 +0100
Subject: [PATCH] ARM: dts: exynos4412-*: decrease memory to account for
 unusable region
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-exynos4-memsize-fix-v1-1-7858e9c5f844@gmail.com>
X-B4-Tracking: v=1; b=H4sIAG/50GUC/x2MSwqAMBDFriKzdkCLH/Qq4kLbp87CKh0QP3h3i
 8sEkocUQaDUJg8FHKKy+Qh5mpBdBj+DxUUmk5kiM3nNOC+/acErVpUbPMnJzlo3Nhjr0lUUyz0
 g6v/a9e/7AfbELrllAAAA
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Henrik Grimler <henrik@grimler.se>, 
 =?utf-8?q?Martin_J=C3=BCcker?= <martin.juecker@gmail.com>, 
 Jack Knightly <J__A__K@hotmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, replicant@osuosl.org, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708194162; l=3075;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=8oifpfarV9J6Wvv+SArdQLyLIPIXjJtvpilJDp3o5xY=;
 b=1fLMVp+k6r+NLxpjwtkrkl5xzZEBvgwcASiLsLI04vAxZIDYv6RqkfRVLBWBFQDbaxpvTZw9P
 OdR5+rinfu0DgUKACC2D5z46VIwXk2ph+yL1jjbWGUtfdQubndboTyS
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The last 4 MiB of RAM on those devices is likely used by trustzone
firmware, and is unusable under Linux. Change the device tree memory
node accordingly.

The proprietary bootloader (S-BOOT) passes these memory ranges through
ATAG_MEM; this change allows us to have the correct memory ranges
without relying on ATAG_MEM.

Tested-by: Henrik Grimler <henrik@grimler.se> # i9300, i9305
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---

This follows a similar fix implemented for the exynos5420-based
Galaxy Tab boards:
https://lore.kernel.org/all/20240130-galaxy-tab-s-cleanup-v1-3-d4e17857241d@grimler.se/
..which in turn is inspired by another fix applied to exynos5422
Odroid devices, 6591a02e17e6 ("ARM: dts: reduce total RAM by 22 MiB
for exynos5422-odroidxu3"):
https://lore.kernel.org/all/1421842972-25807-1-git-send-email-m.szyprowski@samsung.com/
---
 arch/arm/boot/dts/samsung/exynos4412-i9300.dts   | 2 +-
 arch/arm/boot/dts/samsung/exynos4412-i9305.dts   | 2 +-
 arch/arm/boot/dts/samsung/exynos4412-n710x.dts   | 2 +-
 arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4412-i9300.dts b/arch/arm/boot/dts/samsung/exynos4412-i9300.dts
index 61aca5798f38..b79d456e976d 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-i9300.dts
+++ b/arch/arm/boot/dts/samsung/exynos4412-i9300.dts
@@ -18,7 +18,7 @@ / {
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0x40000000 0x40000000>;
+		reg = <0x40000000 0x3fc00000>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/samsung/exynos4412-i9305.dts b/arch/arm/boot/dts/samsung/exynos4412-i9305.dts
index 77083f1a8273..1048ef5d9bc3 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-i9305.dts
+++ b/arch/arm/boot/dts/samsung/exynos4412-i9305.dts
@@ -11,7 +11,7 @@ / {
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0x40000000 0x80000000>;
+		reg = <0x40000000 0x7fc00000>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/samsung/exynos4412-n710x.dts b/arch/arm/boot/dts/samsung/exynos4412-n710x.dts
index 0a151437fc73..eee1000dea92 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-n710x.dts
+++ b/arch/arm/boot/dts/samsung/exynos4412-n710x.dts
@@ -9,7 +9,7 @@ / {
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0x40000000 0x80000000>;
+		reg = <0x40000000 0x7fc00000>;
 	};
 
 	/* bootargs are passed in by bootloader */
diff --git a/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi b/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
index 0b89d5682f85..95fc63295860 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
@@ -23,7 +23,7 @@ / {
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0x40000000 0x80000000>;
+		reg = <0x40000000 0x7fc00000>;
 	};
 
 	aliases {

---
base-commit: 0f1dd5e91e2ba3990143645faff2bcce2d99778e
change-id: 20240217-exynos4-memsize-fix-dccdb9eb75d6

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


