Return-Path: <linux-kernel+bounces-34271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2C08376DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F951F253A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EDC4B5C4;
	Mon, 22 Jan 2024 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOnk8lb+"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7A4A98E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964260; cv=none; b=g7TVc550+RQnPesouphLSjT147epW0Gm9ZIICsV13CmLG3la01YhuUyrxfNz4Ag+8qmOUEqnN0ePOMtetibJv93k9zO24VvK6kUpVDR7rjpFbW/rd/K6iOt/8R0Ms8Sy0/9+SIPoyPJ7ov/DFV1EEYw3Rnvi/aR1GPmDk+RlHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964260; c=relaxed/simple;
	bh=VbkBWnzy+0UFddPvAXBKeoRNgIhOC3IP1F6/lPbA/gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rN7nU4e/z9tqAw6Ft7qPccQ5ErdUBeA37FaaDD0qUTGrLQjOUmrT6jlDCMyDWTDfef2Qs+cW0mWr5zQRFyOUiSrlOKLvylsV5WoJf8HarHcR2OWlJcICBIcmFap+5wsGCCqfVG8VJRjbcUvQ5I74B32KDr4b+zNPG9DkY9OnT8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WOnk8lb+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40ea5653f6bso31327245e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705964257; x=1706569057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6ViflgtGKoar4JoRupvo6UR3+8nq9fr7o9SkHHwUZY=;
        b=WOnk8lb+B85aeoOIuthPlyiCSOwnxdQ5+kTfxa72PIquEmDgDtBSC9UpqWBTxPSTQh
         08j66f9IS8VxIEUXV9Sid87pId/9t2bYJ+kcLZ4uCPJP0vrQYba4wfO9WEgumANLmCUh
         4nB6LqYI0A+WAULwntiyoOmSn9IqRmyQGBk1yjR9hMBKoTUqijiU0CDR5JGMbfxPYHng
         HQSPU+sj+1XfBabLG4FudjAo6xcfSSH2Mxg97OagYwB2bTbdP7ynL6FoYVnVidxFg1R3
         b+P1bH1/82DFIbarP82nDHxXWH5Tp5pUO56fR7rURJt9DW9vLmOktHDYqQTD9jf2T+vL
         0zuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705964257; x=1706569057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6ViflgtGKoar4JoRupvo6UR3+8nq9fr7o9SkHHwUZY=;
        b=WyYj1qayoVo0uT2piLRHaptfnqfTunFClE14qx3V/KY98g+pWomBlVgPc9IzWO7HN6
         wxRJTKNM6Zj5bRBd13L2kYcSuTOr4YMvF/NA+10Rt2eK0JILutKJGKkqSwLJCgq0JAaM
         4DoUyEFaUE/y7w8B28swDHKNan20ybb0KAFKAI6mPaDZ6izbD6ITfvE25K1KWPxBekYF
         9NcaycJwxg2BiDR8vOVRJ7jmrysNipdk/OxJA5ShqJaArSioIKOHpK+MJT6zOleX6Fex
         vPS0VHh83/o3328/siXhQZk2bYzuJchozL86XZtlP2ZLsZYywLlQ4ivrzwOAJr57feIy
         f+qQ==
X-Gm-Message-State: AOJu0YxQ9A28H6BOTHplTskI1gB4hg+OGNhp3to/+c8mP41/r1AmPAxT
	bgEqNfs+axxdMr8TnpK5AbNcyPlakrDDXaJhRJpqAHrpDfBP6567YMk0ar2ufvM=
X-Google-Smtp-Source: AGHT+IHwPlPcC1gFMy2RUxu4+dzTot/pZ/X/gGnPYFqMXOZZ3nFzZdmylLHz87taKykx7APs0vxeGw==
X-Received: by 2002:a05:600c:358a:b0:40e:93b4:25ef with SMTP id p10-20020a05600c358a00b0040e93b425efmr2798923wmq.26.1705964256708;
        Mon, 22 Jan 2024 14:57:36 -0800 (PST)
Received: from gpeter-l.lan (host-92-18-76-30.as13285.net. [92.18.76.30])
        by smtp.gmail.com with ESMTPSA id fa26-20020a05600c519a00b0040e89ff10f5sm19776847wmb.1.2024.01.22.14.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:57:35 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: arnd@arndb.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	jaewon02.kim@samsung.com,
	chanho61.park@samsung.com,
	semen.protsenko@linaro.org
Cc: kernel-team@android.com,
	peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	linux-fsd@tesla.com,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 7/9] arm64: dts: exynos7: remove deprecated samsung,syscon-phandle
Date: Mon, 22 Jan 2024 22:57:08 +0000
Message-ID: <20240122225710.1952066-8-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240122225710.1952066-1-peter.griffin@linaro.org>
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

samsung,syscon-phandle is no longer used by the Samsung watchdog driver
to access PMU registers.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 9cb6bd61262e..347c346e3cfb 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -555,7 +555,6 @@ watchdog: watchdog@101d0000 {
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peris PCLK_WDT>;
 			clock-names = "watchdog";
-			samsung,syscon-phandle = <&pmu_system_controller>;
 			status = "disabled";
 		};
 
-- 
2.43.0.429.g432eaa2c6b-goog


