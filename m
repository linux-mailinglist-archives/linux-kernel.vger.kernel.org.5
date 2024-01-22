Return-Path: <linux-kernel+bounces-34268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C098376CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E82328B47A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E92448CD9;
	Mon, 22 Jan 2024 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mcmFjQTl"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C30E381DB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964254; cv=none; b=GN0lsyn7weLUZVqLBZ2zehBGdL/Np0xQ4YkZEoI+RlnM/Im5ubzcYFkfDt/EX6ri7yxoROXG/WQJoNuQXhCH33yxVIYQ9RnkWUcgGkbAe48JWDUoSRYUbML1mwwueklOq3nGg+ymsq2Y6zrilmqjwww/RIZnHe9ZpVOtmTrHO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964254; c=relaxed/simple;
	bh=BoHzIuF9/gjqWNPMlzNp4FmNG1UNGUTagv+K3rRO0Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ycq87wvIKir4pJeQ3uEdayOqWj2QA/yu3xnZtU6XGID33nAicODHDUTvUjNaZ0TbmHlvRz05KiOjsaaW63aqkcT0xZv/MBfKYxjBZ/M/Nod7yo5HJ4SNtfIfvXjPsBbvmPlFeGxfsx1SpjoznNAGQda48KJui7F+NlJBjAIeBHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mcmFjQTl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eb0836f8dso10014855e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705964251; x=1706569051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4bTzUw+MKMULDVrOGqPlspEn1WsvCRNgroEJ1fsBHQ=;
        b=mcmFjQTlw5O3sD4pXK8wVxzni0TDCUA8+MWev8ndkjg4jzx6W5Cptz/p2dQUnBvg3i
         q1tDBpRcYP7XeKkuR2itCEICt7WTXgJQSwgtgFLZs656hVK5GmA9IIp5aVj2F0Tah6uB
         Ou9efJEBz/GvO6t2nUnNX0BfPCjJUtbAId+6Wfw9/c9rqJ5KViEsAemrqDJetfLqs6v4
         5Z1FLep+pbSo4wuFN0A6IIeNS/HVYCBAnPrvEmQ2Fe/fI0NMPt+fLC6Lf0I7qvM/ErF8
         05VWBqdMYJ83d4NBmXeOBfgc2rhqas5rbCpB5EZH/zTGIjkvZj/7mTius1P6J/abPYGR
         6tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705964251; x=1706569051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4bTzUw+MKMULDVrOGqPlspEn1WsvCRNgroEJ1fsBHQ=;
        b=brheMuvfpHFMPT3A3dPwOwHAX2p6K93z5lmt8AuO01zQkKKhua9X+KnoevnHWSBCnx
         GpfLnPzJVl0d6RMWKHx7NWwad8FyKl7Aq2lZTxDOa7DGzp99RQEf0VR6DQKUxhgRyDAJ
         WjOGLs9MqeaFagVB2X4m35x7NPAu5zUBGZ6XwU23RDrrVKvK8VrFjHBA0GcATgvTwWVx
         ICHLsYRT9MCyUJ7JM0ZdVMinczok98D8skceT8O3GLZzZ6tWe5GJpcVFOYdbzwLJSah0
         NA6uIiip+afev4/pdf/ZUA1ehuYRf4NTUxlspirQ45/buHfCOMvrNSgxSkO04C1dugqu
         yPvw==
X-Gm-Message-State: AOJu0Yzn/mg+oG4H6ca3Yp6EswtFMzqP73M3a4WGTt4Rg1UiVLP2g3+i
	+joU97a4KnzpK8ZiLTAR22cfi9KOovWDM9bm+HvFQfZQ0v7iQJHcJ7u1+njHUZE=
X-Google-Smtp-Source: AGHT+IETd2PX8JmJBxIqCh7S7rWJGs2+2BZQchWv4xtVboyS/6Q+VsUVSnmnkjvLrWfcHXbLQv6r8g==
X-Received: by 2002:a7b:cd0e:0:b0:40d:3dd7:46f8 with SMTP id f14-20020a7bcd0e000000b0040d3dd746f8mr2773352wmj.127.1705964251630;
        Mon, 22 Jan 2024 14:57:31 -0800 (PST)
Received: from gpeter-l.lan (host-92-18-76-30.as13285.net. [92.18.76.30])
        by smtp.gmail.com with ESMTPSA id fa26-20020a05600c519a00b0040e89ff10f5sm19776847wmb.1.2024.01.22.14.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:57:30 -0800 (PST)
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
Subject: [PATCH 4/9] arm64: dts: fsd: remove deprecated samsung,syscon-phandle
Date: Mon, 22 Jan 2024 22:57:05 +0000
Message-ID: <20240122225710.1952066-5-peter.griffin@linaro.org>
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
 arch/arm64/boot/dts/tesla/fsd.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index aaffb50b8b60..9b55e44c1db0 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -625,7 +625,6 @@ watchdog_0: watchdog@100a0000 {
 			compatible = "tesla,fsd-wdt", "samsung,exynos7-wdt";
 			reg = <0x0 0x100a0000 0x0 0x100>;
 			interrupts = <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>;
-			samsung,syscon-phandle = <&pmu_system_controller>;
 			clocks = <&fin_pll>;
 			clock-names = "watchdog";
 		};
@@ -634,7 +633,6 @@ watchdog_1: watchdog@100b0000 {
 			compatible = "tesla,fsd-wdt", "samsung,exynos7-wdt";
 			reg = <0x0 0x100b0000 0x0 0x100>;
 			interrupts = <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>;
-			samsung,syscon-phandle = <&pmu_system_controller>;
 			clocks = <&fin_pll>;
 			clock-names = "watchdog";
 		};
@@ -643,7 +641,6 @@ watchdog_2: watchdog@100c0000 {
 			compatible = "tesla,fsd-wdt", "samsung,exynos7-wdt";
 			reg = <0x0 0x100c0000 0x0 0x100>;
 			interrupts = <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>;
-			samsung,syscon-phandle = <&pmu_system_controller>;
 			clocks = <&fin_pll>;
 			clock-names = "watchdog";
 		};
-- 
2.43.0.429.g432eaa2c6b-goog


