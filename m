Return-Path: <linux-kernel+bounces-162124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7378B5645
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4131C21F49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FFB3DB8E;
	Mon, 29 Apr 2024 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/zGqOmK"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FB93FBBD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389346; cv=none; b=UWaByQjpVaM1EnQP9ajf1tMwOXJy7CGzJFEvATU6BYDwqqTWUzTtEn9XRftWDFVpTXcs54RGr+6kdzMcILyuhvySpP96hFFTRWE+kPva5yA/f1mG39cOtaQ+UavP1i2S7qsOUUkuVCm7EX0RReI3NNZu+xWL1Kt1X8yeN3SJzjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389346; c=relaxed/simple;
	bh=2bBWeKw/Y+4Mjf1rMVzvCAaya5L2mkp9pQ+MhRjpvLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzZk+3lQQkx1Uc0/u+YhFi1l7pmiGQuYJiOYDJnKa0cpeL9R2qjwVbq90KhJ9NjQ77tvl9hr85WHRseTIgxJ612nYWl1OihwVwv/zxu9VuZyTZEHkZTKyzIVeHE4e5YsujEn4hruqeI6bpwegIUb1WwnLjsBzZYHnmGXT09vnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/zGqOmK; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2df848f9325so27929041fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714389343; x=1714994143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHjJbBAINE/uHYfzybf0SNljSNHWl/yKpH52w4l4aoE=;
        b=W/zGqOmK0Fe8UVaPP3aTXX/g2+G1zzDf6IHY006cGhXUjUbI2RX4TubyWQjMp1yOEY
         ykS8m6I/Jty0H+3t4QOKq/nauQTlDTg8XcfXXn+7kMtfv44V9FFFYzBiIu2rglczIhx1
         mAKnkzmIk7DBkpOUkUSncw9OGIcY5DyBfAGrk9omPz1X7hQv8zqgFFmeXtescOszHBfH
         ZZTBOJ05aTLWaNfOZtrpyman7rSCSih/2/ZiORoAoPUmDZVkDvDBVx33WMrNsG8eeAPF
         RDfRJIyHRNGkvl6ueCbyVSvl/ptfPkUJIiAm+GiN4esMlgIUHwOW+aBqcZof/RJxlUce
         /xMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714389343; x=1714994143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHjJbBAINE/uHYfzybf0SNljSNHWl/yKpH52w4l4aoE=;
        b=A3+oiayeTxJ9jKVqUupwvnZLFczDbhJBdBpzbfR2mQz1bZ8Q8YoLCnw9xiVwTlfYx9
         SD8WDWHiXxhcVt/jLzRd42F+h3ECt+LNLpA9gm83l8slgbhtDOiDFfnMFdrJhSCPZgPe
         g6hquhXFFbXHSIoH3tykk8iKwbkdU57FH2i5ZJ5g4OmqGP64Ah4bquPf1Ez/+UaDdaxq
         CyQjaLgV6DYu049j1B/gEYORFJZX4ly1DSK0vSxpMYRPtyf0tab2rwnN1DU160UEWKFl
         /EJh3DfUhdE3JfsZgYh3xAt1hz0tzPhNb2Ebs4p3U2nXNinQDIQxSdKP9O6PG5RN50tl
         9ePA==
X-Forwarded-Encrypted: i=1; AJvYcCUqBWoWY69YyzaKH4ncMGmWFDvGMQo2ZFcpAR7u2i3YR/DZvGxOwR8fdHfJuFofI6ch408ynM8j/Uv6crlyQu4ewSxyCKLr3Mma8mOb
X-Gm-Message-State: AOJu0YxPHVGDt3Appr9qM4Dy5b3KEHI9/G1OW+a8B5tv5tyXZuQkAy5K
	F6Csqf3hTtBpwgnfbZLfeIHIsYSXeTN1ImtDaFkGh87pi7EjP5WfjB2nkmKHxFs=
X-Google-Smtp-Source: AGHT+IFv7qguIVE7775W4L3dzsBVXBiC/Y3AMssuKVMJHdRZlaNoXrE4DcONgklKCs0h2HeB4A7w1g==
X-Received: by 2002:a2e:a70e:0:b0:2e0:c689:f8cd with SMTP id s14-20020a2ea70e000000b002e0c689f8cdmr76395lje.29.1714389343208;
        Mon, 29 Apr 2024 04:15:43 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:550a:b373:6b8:63ab])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b0041b434e5869sm16005337wmq.43.2024.04.29.04.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:15:42 -0700 (PDT)
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
Subject: [PATCH v4 2/4] arm64: dts: exynos: gs101: Add the hsi2 sysreg node
Date: Mon, 29 Apr 2024 12:15:35 +0100
Message-ID: <20240429111537.2369227-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240429111537.2369227-1-peter.griffin@linaro.org>
References: <20240429111537.2369227-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This has some configuration bits such as sharability that
are required by UFS.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 38ac4fb1397e..09044deede63 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1265,6 +1265,12 @@ cmu_hsi2: clock-controller@14400000 {
 			clock-names = "oscclk", "bus", "pcie", "ufs_embd", "mmc_card";
 		};
 
+		sysreg_hsi2: syscon@14420000 {
+			compatible = "google,gs101-hsi2-sysreg", "syscon";
+			reg = <0x14420000 0x10000>;
+			clocks = <&cmu_hsi2 CLK_GOUT_HSI2_SYSREG_HSI2_PCLK>;
+		};
+
 		pinctrl_hsi2: pinctrl@14440000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x14440000 0x00001000>;
-- 
2.44.0.769.g3c40516874-goog


