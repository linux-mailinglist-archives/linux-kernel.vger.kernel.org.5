Return-Path: <linux-kernel+bounces-44274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A93A9841FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4962F1F2300F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B9360869;
	Tue, 30 Jan 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWH0ienA"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C04605B6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607513; cv=none; b=cpiBvlNsC39pG9sj2SXuuT+YdFbH4z0ZoHeScvyr3+nUPm9Y768l7ONzK8z7nS47uWrC5D1V/IV8T7z8W/8kVkiVRgSbrhDvg00Ke4lpMn+fRGSM6jK/tEEkrGKudQiOi1geu9AF9O2d+d0jOBfP0CCZBMsqOb1/6UpxPtBmCCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607513; c=relaxed/simple;
	bh=+PdrbMb3VEyfuAhjEG6S+1bYE+VDRiwzt7WqpFTpyeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ze+HP5Z7IxLkTLtNiGCyOco4qDND7d3ODyA4MCPo+594518SM3mVYpXkrpbGBRTRwFltQAovLpqudbB5HYxjVm3szK0MXinEIMTMV7I/vjW2uZfL78xzamet+/RD/xKCIkjIxaL8yuquak2PGGymPFQh7xtsIN055EVHcMGl8BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oWH0ienA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55eee4a042eso2685737a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706607508; x=1707212308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QlyL8STz7vLqr76PxDM7CwYVIS28ulp926LAaYNGGI=;
        b=oWH0ienAbSZPF8j6egCgHebdu82CBMbJM7/CNn6Ia3Dtw3yC17Sypa+UC54O1Lff4f
         J1DibKsROzmsFIlx79vnsCKUGZtCYPlNLaQPqIMcHK180uh1BOmGfV9P7CY9F8w2WNCs
         kFQfZy5I3Sj1GLs8JbXw0C4V6PdyYPkj1am9xfxMWl73mfwuRjp7uENns7LCn5ovA6AO
         vzAKnrW5pXSKTq1Q1G4dHI8D9KovKMQkH63QCWNfkLBTnsbvF8lJHC/DqkyjoUqSnCRn
         KD7nq1ZZXHKVeHNVK9b/GypSs/7tZyrjT8CCcY7Hmm4ZTOqS+rE6Lp9u85B8J5lpxtZA
         lPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706607508; x=1707212308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QlyL8STz7vLqr76PxDM7CwYVIS28ulp926LAaYNGGI=;
        b=M3Sg7carqPgCg/CHtNNAMbQzNBNzkRFmpfTNyIF5MbcsmdDUiKmSP3nb6hwMSvtGFL
         gFR/TSytyWUlcARGC6lgosHa0ARYtYcXcm///Zye/XsIfHKcDTfsKUVnF9Du26SwQepV
         EHPim1NDT9NMw8xdjW1L4KB5U3lp2l0KHQGOkPJ9/1q2if5E1CKdu1meR6mm1xeR3Gq3
         faPgmXaZfpH3e9dXYs0TaRyntmFxQI9EP91JlgMc6sPxE1+aNO4L7jRFIZ6ZY8C+R4iv
         bnvjvEhGQ4o6wthnnt+AoVRZUpKx8Vk1nO9CVZ1llcCNSOuFkqpNpXgLeHfyWjjMXijc
         XuUw==
X-Gm-Message-State: AOJu0YxybpHTCre0R7aGn7T8CrMrmJQi0BylRor06hXO/38MbYH9Yref
	aoXOfTlBBZ9DsPAEdBgjNR5gcPtzTXMp0amUww2KRPZeOsVVNGkOmYGi0gXaobs=
X-Google-Smtp-Source: AGHT+IHfaN7UvY/vSPQqkfKgFdNu53zzkQ0W0rJtAiN/x0drxl5i2SZ2RU5QbIL/iyWQ+R2WTvXWvw==
X-Received: by 2002:a05:6402:3590:b0:55d:1592:8323 with SMTP id y16-20020a056402359000b0055d15928323mr5771063edc.3.1706607508001;
        Tue, 30 Jan 2024 01:38:28 -0800 (PST)
Received: from puffmais.c.googlers.com.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7cc0a000000b0055ef56f4575sm2281225edt.39.2024.01.30.01.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:38:27 -0800 (PST)
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
	devicetree@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 2/6] arm64: dts: exynos: gs101: fix usi8 default mode
Date: Tue, 30 Jan 2024 09:36:41 +0000
Message-ID: <20240130093812.1746512-3-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130093812.1746512-1-andre.draszik@linaro.org>
References: <20240130093812.1746512-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While commit 6d44d1a1fb62 ("arm64: dts: exynos: gs101: define USI8 with
I2C configuration") states that the USI8 CONFIG is 0 at reset, the boot
loader has configured it by the time Linux runs and it has a different
value at this stage.

Since we want board DTS files to explicitly select the mode, we should
set it to none here so as to ensure things don't work by accident and
to make it clear that board DTS actually need to set the mode based on
the configuration.

Fixes: 6d44d1a1fb62 ("arm64: dts: exynos: gs101: define USI8 with I2C configuration")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

---
v2: collect Reviewed-by: tags
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index aaac04df5e65..bc251e565be6 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -384,6 +384,7 @@ usi8: usi@109700c0 {
 				 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_7>;
 			clock-names = "pclk", "ipclk";
 			samsung,sysreg = <&sysreg_peric0 0x101c>;
+			samsung,mode = <USI_V2_NONE>;
 			status = "disabled";
 
 			hsi2c_8: i2c@10970000 {
-- 
2.43.0.429.g432eaa2c6b-goog


