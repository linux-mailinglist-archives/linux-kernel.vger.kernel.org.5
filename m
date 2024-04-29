Return-Path: <linux-kernel+bounces-162126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6FD8B564C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F40A1C2221E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431224D583;
	Mon, 29 Apr 2024 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzhQRKr0"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E3E481C4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389349; cv=none; b=Ejzw238iEP6xNXTB8jfqYsgKFtgUYl28fhn+gEQ+Oz/jujyCl4qKvVDK31Yc9i6CWFRG9FUXLErh7hDchaYxbHq7kB8eqeO1dRxCt6MqaSEuZ+OUvozSxhsCUCn2XSJs1zPjqytAQLJK8K8fguGUoUy/ROnfF+K3LLphOWIEBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389349; c=relaxed/simple;
	bh=ZmIYYUt0QcbC0Veeq4Fmo5dE3JV8iq7sEVsLahwG0es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYsnpScV6fWtv5WlJosOLy+joxj1j6nUtpQuSzvm0CoDvkMAzTE7NoCga72ONiwQUG8pJwd1w9BTFvfOtk9m5l7/gQ29SuxfH7BEK6E7dShvWpa7gzniugJmUGDct+cPWBuhr9JkHLo2XzPjsXNKftLeNYlWIYqtJCwF4x1t+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jzhQRKr0; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2df83058d48so28284111fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714389346; x=1714994146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX1t+YE1cBl5MQLmH5bPrWGcz0Ebchp9QnAASzx5oG4=;
        b=jzhQRKr0W3vkcBEUXKhzxmksxq1ruYNJ4hMDbmhLyGm2ayYJg/Zrc63MTyi9KMfckz
         pHUAlOZpflsguaLZ+Zsjii8y7QMyTVv6NKToZ6y/xqb+ikf5eK47+i7vCjwN6y5/e7sc
         V80kQeKP5G0umKJciItEwishSNL+Q/KIdlVP7DdY4gHGvHMZUvjEonr9e2NF34bIvDlQ
         97AnLqjMXQFdLz8nxcHMr4BQVXrxun13wyFASeoYVCuBG2yqNy/XOWH0c4R4Gt5sookK
         NKHHkd7rCKUP/EvD6iJlFopQCh3g4Q33t2PC879531DHRt7LoeyxVYjTmxAj+vL3kLSG
         cJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714389346; x=1714994146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AX1t+YE1cBl5MQLmH5bPrWGcz0Ebchp9QnAASzx5oG4=;
        b=CNMZH49HY2AGFYylMpKTFkHr5WbmIsZSTP52GSrp7Kfdh6OAJRj85lEDZsszbA9X61
         rcUX5oZgh18jgTgd+ikFsD97BoXLNAdtOLK4JfIhCFKwr7HB2SCvreCogjlZ0x9SXIwF
         qVn8JLXEHuOMeWqLRVccu/yG3vpBWIhOXPr/BFR0wAGI5RV58043mcqSGZuJDCMkf/un
         dXLGyIWQnIm/ZzwsjcP3imRHQ6bff5KQAYz2+RkoNIJb25LJkju/CwO27Ci1bdP/hxmN
         pnNGFQeep7/GoaFjr/Va7wMAx3wtXSgBWQGwcd5annIHVogVL7A5BpGX4MPXV3Y2UMM3
         /u4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSfQw2HFOWBPupnWznXIBQdZ8CoYf3NGyV7+2Xp6kqpPFsZLVO0oN+4X+Fx57q+KdofmYkPDLXwYAHuRCTnha3cXwt34yvPxqgkCt6
X-Gm-Message-State: AOJu0YxJmExVu3bKaRFvYD+ZzMhAsXhBH1Qr/ggLYiqIcVPvyf/QW8G/
	rg+luUg92X5zPRt4QB3h6NOC6eVKs26BusL503BfhSrosU7Q6mdJdYRLNkPxRSU=
X-Google-Smtp-Source: AGHT+IESPtal/xgnWl8g9+lgMXOg/jVrb4GYZr0Fcd9/7y5Pf83tPpq4h5xqaYXN+/jqF10t6hdVbA==
X-Received: by 2002:a2e:960f:0:b0:2df:a8e1:c24 with SMTP id v15-20020a2e960f000000b002dfa8e10c24mr3999779ljh.34.1714389346058;
        Mon, 29 Apr 2024 04:15:46 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:550a:b373:6b8:63ab])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b0041b434e5869sm16005337wmq.43.2024.04.29.04.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:15:45 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v4 4/4] arm64: dts: exynos: gs101: enable ufs, phy on oriole & define ufs regulator
Date: Mon, 29 Apr 2024 12:15:37 +0100
Message-ID: <20240429111537.2369227-5-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240429111537.2369227-1-peter.griffin@linaro.org>
References: <20240429111537.2369227-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable ufs & ufs phy nodes for Oriole. Also define the ufs regulator node.

ufs regulator is a stub until full s2mpg11 slave pmic support is added.
The gpio defined is for the BOOTLD0 (gs101) signal connected to
UFS_EN(s2mpg11) gpio enabled voltage rail for UFS.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../boot/dts/exynos/google/gs101-oriole.dts    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 6be15e990b65..fb32f6ce2a4d 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -53,6 +53,15 @@ button-power {
 			wakeup-source;
 		};
 	};
+
+	/* TODO: Remove this once S2MPG11 slave PMIC is implemented  */
+	ufs_0_fixed_vcc_reg: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "ufs-vcc";
+		gpio = <&gpp0 1 GPIO_ACTIVE_HIGH>;
+		regulator-boot-on;
+		enable-active-high;
+	};
 };
 
 &ext_24_5m {
@@ -106,6 +115,15 @@ &serial_0 {
 	status = "okay";
 };
 
+&ufs_0 {
+	status = "okay";
+	vcc-supply = <&ufs_0_fixed_vcc_reg>;
+};
+
+&ufs_0_phy {
+	status = "okay";
+};
+
 &usi_uart {
 	samsung,clkreq-on; /* needed for UART mode */
 	status = "okay";
-- 
2.44.0.769.g3c40516874-goog


