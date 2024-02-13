Return-Path: <linux-kernel+bounces-63519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604EE8530B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A89281C34
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA39941764;
	Tue, 13 Feb 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKxIq7oi"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD12EB12;
	Tue, 13 Feb 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828118; cv=none; b=d1AzzF+tqrgrjLUkA1QWacQChTAlWlOG4FDWqo28v/W8hoNk2eLn2URbpCpVXlFuaIpUvsKGBG0dkU2pdlsVOmaYlGG5vyegcmR8s5znq3JEk3G7b/xSmNa4vG5Cd7ZMidbE5/owjoWFOtnOWvUjSge8eeKUNGbWF2A6CkPmtD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828118; c=relaxed/simple;
	bh=7HTb1FTG0w4am0moU2ZfJ+vXyBYLytKgdVhTQ/rfeJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nv9YI+fX98zZ9M+URataMp77lxv0CvKXXDes21hZQo/6HpmFRXlyLglGHhnGCVR4Uvf+6bCJ7j5l3RhudEtCyv6krbIfhBYiac+loSsScUK4I2Whl7IIWH0YGMwasGWOMib1XnpplBRW6PpVTVa8HA/+vK8rpHWyCgEoW0uERHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKxIq7oi; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21d56bb3714so35037fac.2;
        Tue, 13 Feb 2024 04:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707828115; x=1708432915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3H9KUGhzPdQrreUofYKz+zO35fKsLzTBb4VkOZjhuu4=;
        b=TKxIq7oiHw3B9Ag4537jmuSh8z0Fqkz38b0EqyzLJ/2x4qHL5pPr1VuFnUcNob0Zrk
         iNwcxLo4o+TrEKYTpNoyXZqmeIASps7d+uER8GRCE5KKE6a+V++REvzPVUi9o6we7SBL
         RswLJIaBEQkjEduzFYw3L1St7qjUpplt30NB1z86nd7zmlHUfGmlCS/+Hktl0dY/ItH0
         79GunPRYh3EmYhU/ytF1ROjKc7loWhXKihWo/9yu9ReH/Y5FmiTt1VwQJbrC+5FT6g3F
         gypWDxIZQ6weikFzLERgN7Kejjm2D1M80H7ZOkVUVsSdfSQZV9Qmp7T95tBakK5PpcHk
         mmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828115; x=1708432915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3H9KUGhzPdQrreUofYKz+zO35fKsLzTBb4VkOZjhuu4=;
        b=fptBnWXBpZ/grCLn+e9ET8+5r0H65P99xaNbuqVKDO8930QNi14YajKlCnJsbAz0JV
         z5y08lu9OqDBmZzCLZVymhWpP0YERQ/hiznEDLxxXsbkEZethtLLPUmUjuUh095Hn2z7
         W99mpwplfsdkLc68BfqX2x5gpab8dDHZ0IUTTRVrd9C5qqVPThbrBjAj+l2XnJOVs3SG
         vEvFlmPWrq+/qpUfTi3Q/+ZoKMxL8IdZp6ZrP+G2xOJ80RFpZEYquuN1Zb0QUkPkx8Bf
         xJOt5tojpgO39r5PCGQNlYVxit0uD8NAkPbhlRfeznhjevFPbeT+goX2DNHl5B0yXiSC
         Xgdg==
X-Forwarded-Encrypted: i=1; AJvYcCVdtDQ7kMAoUm2xq/BJ7nDc3mUd7hpLyNqeW9Mzz7E8/OLKuoyJVU/QnLpnbAxN72ae1gPsfgcdld9Lldl2EF4R0JYs+/4F+r6bGeuLWO78F79G3TwhWNbD502wzjlf+netKAX4xk+yFg==
X-Gm-Message-State: AOJu0Yyl7WQ6W1aENkraz59K0KaG5VOy+JlS+yXcDCel0xDmjMENuHv0
	PkBA1RVLR8Fnpcdr0pYC/oy33NW9MVj2WGjnrnVZSHTZh7O6I10KyqyvvqeT
X-Google-Smtp-Source: AGHT+IFzUXvMoAAyLBJl8/bQkVkxeHRfO+AbIFfEm0xabkjcD0mmuJu/kJbcF2bRTjBvvAJepwBW8A==
X-Received: by 2002:a05:6870:46a6:b0:218:73ae:3f24 with SMTP id a38-20020a05687046a600b0021873ae3f24mr12286829oap.13.1707828115011;
        Tue, 13 Feb 2024 04:41:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+IqbakiLosG4JttF1fz0dUcS7rrSYtd0FyPbqq8P6vPJ8A3E0n6ePVRfF24Fave9tXBcAbIabuIFJVvaFz50Fc8YvW8uEq4mtFH8V6fteGCBTuLr3UCOw/hB6rfZCBFroGigRoWYkCtUEFOZOk4xUwWINJblyoJ26/p3pxyqSnxDJr6cCmGquW12JXC7qwMNf29s/cfY3uO/MyCTuatNpQaTnAwmq4uJ3iueFD1ZMIJCDxgU5n5UnCS3sEojyf5g9lCS9/P5i3jI9hZ8r4wDroD6B1UGEDa44WrOpH4ODk4DnqSsi8ZKQDAptMrTz
Received: from aford-System-Version.lan ([2601:447:d002:5be:cae3:528f:52c:80d8])
        by smtp.gmail.com with ESMTPSA id c3-20020ac86603000000b0042dae4c1594sm483385qtp.47.2024.02.13.04.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:41:54 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-omap@vger.kernel.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	=?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm: dts: omap3:  Migrate hsmmc driver to sdhci driver
Date: Tue, 13 Feb 2024 06:41:45 -0600
Message-ID: <20240213124146.202391-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sdhci driver has been around for several years, and it supports
the OMAP3 family.  Instead of using the older driver, let's finally
migrate to the newer one.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/ti/omap/omap3.dtsi b/arch/arm/boot/dts/ti/omap/omap3.dtsi
index 92cd4c99dae7..218d7212c749 100644
--- a/arch/arm/boot/dts/ti/omap/omap3.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3.dtsi
@@ -507,7 +507,7 @@ hdqw1w: 1w@480b2000 {
 		};
 
 		mmc1: mmc@4809c000 {
-			compatible = "ti,omap3-hsmmc";
+			compatible = "ti,omap3-sdhci";
 			reg = <0x4809c000 0x200>;
 			interrupts = <83>;
 			ti,hwmods = "mmc1";
@@ -518,7 +518,7 @@ mmc1: mmc@4809c000 {
 		};
 
 		mmc2: mmc@480b4000 {
-			compatible = "ti,omap3-hsmmc";
+			compatible = "ti,omap3-sdhci";
 			reg = <0x480b4000 0x200>;
 			interrupts = <86>;
 			ti,hwmods = "mmc2";
@@ -527,7 +527,7 @@ mmc2: mmc@480b4000 {
 		};
 
 		mmc3: mmc@480ad000 {
-			compatible = "ti,omap3-hsmmc";
+			compatible = "ti,omap3-sdhci";
 			reg = <0x480ad000 0x200>;
 			interrupts = <94>;
 			ti,hwmods = "mmc3";
-- 
2.43.0


