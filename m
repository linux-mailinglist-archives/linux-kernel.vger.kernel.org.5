Return-Path: <linux-kernel+bounces-40925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D79283E836
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC871C24B45
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687F4443D;
	Sat, 27 Jan 2024 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlwdHLJu"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA2819
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314786; cv=none; b=uPX3yL45Iqsh6F7mDLr7E2gLCHjlI0d5dKTasvXqPLLzRKyENjMSJRGqxxTl1lf5MEnm+PYJpxO5nHlFM/aRYpmLwFa3vN0XM3okSI481UIqV/IX/x/m+zgARMHQYxsjAZxYGfVtTyIoVH8LygINhXyRTKXAJzLfQCxM52b0jrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314786; c=relaxed/simple;
	bh=oHe1P3OQNz5Kyak0RXMz0P0blzBvlld7fBoMdalKmm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbkMDTxGO0cYCLLvcK3OiOjuiqEFPObOXruG4mGqRNz2HExONtdTxS7uKve7Z2EL/iiMeTeI1Z0WW8v8gnF1R5Hjpuh+WoNX4MaxqCel345kDEib/0JNOMkioXPoxaCq9G1Wd0Rs4Qwp6pYIiMZr9BlFxiQgOCZVK9CGjgyxNmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QlwdHLJu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3122b70439so131595166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706314781; x=1706919581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgztKy6IjfIdLYQOLtbP0Yalc6UauVSOPo0zIgakd70=;
        b=QlwdHLJu57ij5Ei5g0HPNEMXO26V+5RvEpZEl/jTr3gKtsg8Ik1egW7C+a5VdpIJ+v
         54aY9T4ATXfyFWQiXw9vApWstiB05RJGhvm6GrEAmcvuOsA6tZoIeBI5HXFb57J2Bu9H
         FyEXm9BVLU7YisOP8bH/2mg0MpTr7x/evtD7Qs24pklrzBK+73eCxcGH6wqOswO4MpQT
         tDqr7Sv/c/v/w/wuGbofOfom7P7q/+8J4c6tr7+X4veYxgvlIi+HvOgy1adBaP2LLy1M
         s8H89tKL4UE/O5BvbxIkGr1M71bT+vkqHEIf/h5WJ/hziIuvgT90T6l3hr9OcdUp9+6e
         pKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706314781; x=1706919581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgztKy6IjfIdLYQOLtbP0Yalc6UauVSOPo0zIgakd70=;
        b=OBT0b21p/WM9Jq+c0g5+pZmJOv1Pv3hAz/G1nI/OTRINEoDp0eppS8Bx+CZOwP+Ypl
         rRPiwzs3bFc4g9luOo4AlIH5nJGBBj2st8W2Q2VR1UuRm4YwyP8BB4cDTy0HjVH7YZnu
         D7qbJFXI0kyCxt0QdbeoyN75sBfsN5NYpwSOZ1oq8iklIepoKe6ZwsMNFsGsUY/ct+Xa
         oJ7vIZ9Kftb+vi1GA8tpDqBqamXwP2PoydcWtWn2Jl8hZElTNZQeKrxQUW4jndnAHMsW
         mcVxlAx3a9h8bQ5ooxKEsSYawwvTaki10o6UXN51jVwYJqaSxPCFsnNudVIr1IuGqilw
         FYCA==
X-Gm-Message-State: AOJu0YyoACMN2W687g2EvgU68/djhb6V/pc8nukygrGaE9LLxSeFrLCH
	IM1PlPz4rTaS3cXXT6jAZ6pqVhCEW7ZPc3DFBBUObWIEsO2sfayBP6ayqRgzWlY=
X-Google-Smtp-Source: AGHT+IFb1j6MKOZ4vLQycT441SftALLz5tOLgiqWIOZFebrye4gBKKmrHvrbkPOptuEpa1l5/etD2w==
X-Received: by 2002:a17:906:dfe3:b0:a34:aa8b:6cb2 with SMTP id lc3-20020a170906dfe300b00a34aa8b6cb2mr533145ejc.18.1706314781676;
        Fri, 26 Jan 2024 16:19:41 -0800 (PST)
Received: from puffmais.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b00a339d705a10sm1141359ejb.80.2024.01.26.16.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:19:41 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: peter.griffin@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 4/9] arm64: dts: exynos: gs101: enable cmu-peric1 clock controller
Date: Sat, 27 Jan 2024 00:19:08 +0000
Message-ID: <20240127001926.495769-5-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240127001926.495769-1-andre.draszik@linaro.org>
References: <20240127001926.495769-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable the cmu-peric1 clock controller. It feeds additional USI, I3C
and PWM interfaces / busses.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index aaac04df5e65..5088c81fd6aa 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -429,6 +429,16 @@ serial_0: serial@10a00000 {
 			};
 		};
 
+		cmu_peric1: clock-controller@10c00000 {
+			compatible = "google,gs101-cmu-peric1";
+			reg = <0x10c00000 0x4000>;
+			#clock-cells = <1>;
+			clocks = <&ext_24_5m>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_BUS>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_IP>;
+			clock-names = "oscclk", "bus", "ip";
+		};
+
 		sysreg_peric1: syscon@10c20000 {
 			compatible = "google,gs101-peric1-sysreg", "syscon";
 			reg = <0x10c20000 0x10000>;
-- 
2.43.0.429.g432eaa2c6b-goog


