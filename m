Return-Path: <linux-kernel+bounces-34273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 622308376F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E3B1F25136
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C4E4C3A3;
	Mon, 22 Jan 2024 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKiFJ1GC"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D32EB0C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964263; cv=none; b=tk9n43Sfugimq+Dciw/7DbLzMVOK3lDffFM9QaGdK5kWs/CY93dzWAJOgkBu0c9O97Rm6ZhcwGjXhxlyG03JQV1UbF4xZs/KD55hvG4iLRWS2hMkx2GlY9ySxzNjkuGibu/3d0e3Xlp+0slILba0BQdlcfI8bGm1edRzsBL2SSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964263; c=relaxed/simple;
	bh=6Fww45r8KMq9qH9gjFBGszYrLznUeDKKB4S+eDk2dqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEjnGDnRVLLx6JnGE8Xgv5Iur7kU4yWNlNWF3UP15/C8ykUNxkGy4R1pwKGHi/ZIBFYic7J6FByt8saI/uW+riDZI3b0JNamDijCgxOOgnpxINDlvk1RBZSgkM3CNEYsbU7t3SWOVQnl7ifESExajXpZFcamoRlltIEp0RrABGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jKiFJ1GC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e80046264so47533605e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705964260; x=1706569060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR0AO5T3Lm52GetAuhWGDlBbvPmAefipWgZrjsJSJcM=;
        b=jKiFJ1GCKKlFtDaECgZa64YK1ExR9aWypvp9vvl5lhUd3K49tl7R+MojlpME9pL3kq
         kw8ZdngSy98q2b2gXYSYMe8q27mIlvuHx6AuErBItlaEVq7tNhQDYianBmVG3OqxIaBw
         gQ9G1Ls1UhJ0gP25eqJT5lh2JyYYXJTcdb8AC1aIzgfHb78kaIhG4CP+J8lojdYa7hkP
         UhO6PqcWlXyAzRb68oBZfnI5SOC582eMaQ8GRL06xtO7EgB2Urtv70hFKDsAKHnURPM0
         JO2ahBDkOViF8pBzCm0/tBNkketXwBEvDzynQpYUCC3DM+vnmUDQokXnaCUYU8UdLxlv
         CdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705964260; x=1706569060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR0AO5T3Lm52GetAuhWGDlBbvPmAefipWgZrjsJSJcM=;
        b=DHNLUA5NzsDSEcZhIdUSDIUHXa511WpH74EMwGyN4+RbAgpqqNiVQ6dmFIAP1DqToT
         U75e3DRvz0GPWbHTEO9pV+NEyMj5s66vIjEqZ7V7cuczXDtjDtYLDV6SLNmpvUenJDtS
         WzTMYLH3xccddGXgjg68e9THqYj2JpLxVVNz5yHDAGNLEw08MANqnxTtIFFib1NgUAAT
         /I6QqoNyTAltlTsUtOv04mfUqEV+b9SvfNyFSxwEIZy3UOnQm/X1lLP/7y0b3acm+UD3
         sDdGWggmfpQjNfqaaq/EI0uUD4+yyq/Vs5My4yKJCzOchpoGvjl+FfIhOaQp8WqQpHa4
         gIoQ==
X-Gm-Message-State: AOJu0YzA++Wq/WltDvEeOz8y82JExVkR400rShiVcgzoHVvcuQ+sg13z
	IFYs7sEUmag8apAWecdHuirD3FokLAm5ZTx8SHq+jRoOlIGRuimfSZiCjDrGfmc=
X-Google-Smtp-Source: AGHT+IE/3oSYmQaHmUVIEZrmPeRaKj7ezaMnrpX2IRhfyS/TY5XiBAOhqPClwNkExF4LwyWJ4DWvjA==
X-Received: by 2002:a05:600c:a43:b0:40e:62aa:fa7b with SMTP id c3-20020a05600c0a4300b0040e62aafa7bmr2887046wmq.111.1705964260529;
        Mon, 22 Jan 2024 14:57:40 -0800 (PST)
Received: from gpeter-l.lan (host-92-18-76-30.as13285.net. [92.18.76.30])
        by smtp.gmail.com with ESMTPSA id fa26-20020a05600c519a00b0040e89ff10f5sm19776847wmb.1.2024.01.22.14.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:57:38 -0800 (PST)
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
Subject: [PATCH 9/9] ARM: dts: exynos5250: remove deprecated samsung,syscon-phandle
Date: Mon, 22 Jan 2024 22:57:10 +0000
Message-ID: <20240122225710.1952066-10-peter.griffin@linaro.org>
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
 arch/arm/boot/dts/samsung/exynos5250.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/samsung/exynos5250.dtsi b/arch/arm/boot/dts/samsung/exynos5250.dtsi
index 99c84bebf25a..2bbeb0f0d898 100644
--- a/arch/arm/boot/dts/samsung/exynos5250.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos5250.dtsi
@@ -312,7 +312,6 @@ watchdog@101d0000 {
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_WDT>;
 			clock-names = "watchdog";
-			samsung,syscon-phandle = <&pmu_system_controller>;
 		};
 
 		mfc: codec@11000000 {
-- 
2.43.0.429.g432eaa2c6b-goog


