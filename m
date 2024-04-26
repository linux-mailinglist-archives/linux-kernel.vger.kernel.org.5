Return-Path: <linux-kernel+bounces-160065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592CD8B389E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B591F236D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088F21487CC;
	Fri, 26 Apr 2024 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHbXizwF"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C1E147C72
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138715; cv=none; b=X+jdmhMTH+wfnvovgMNYqzp+za+Mtv7WOKSzsWvplZ0d6kgH6ZOVKSOSBsehSrdro0T+XgBDL931BvGCD1Hc7QZ5guXyH1dRALHRPWUli+7PI9hqwQfEBcFwWN4ON2aFb6FQOKsHBjgq6oyW6b4SJyt6MbhTGWrZ1SUC5aLnWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138715; c=relaxed/simple;
	bh=2bBWeKw/Y+4Mjf1rMVzvCAaya5L2mkp9pQ+MhRjpvLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPt+RDNA+yqGe/UwUgeoY7tJWBTXKUEPZfddgfYYWDq9W432YptAmh8IiUnrJ8mMwIhc9NE51NbZvkp4xyoAOGp5EWs5YW9em03nJ+OhSfDSfue6laK3hTv9u2qzNdSCYgR+sx9Y5ctG1Xrnii1p6aaFc8zdQa1tDK28X32Gmxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rHbXizwF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34b3374ae22so2318652f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714138712; x=1714743512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHjJbBAINE/uHYfzybf0SNljSNHWl/yKpH52w4l4aoE=;
        b=rHbXizwFJNXoiT6EQj3Wf9ab1ublslqxcSthFtP0XE61KhzpN53CNN42Mx0+5jRrwY
         ULoG3NSR7TyaYOrjtHnX8xn9mks8WWoHvZjASHicn4Rd7zlBy4bQYvSOlnrEKNiLtlPE
         basCkUGOUO6FXQ1eKNO3oNDcWamu+TM9T9ShhwHfSA5J6jjOzdC+bWo3rTEbzm/SLllS
         klVtqkSOYQxUG6dnpXIxZOzkTVrUcnkTG6vGNc5E1Ke2jbVRI4yN5JRRs7k/z24dMC52
         n9unypqZTAmL83srDq9X4Wk52R2hrHwLbGElWZdgClT4XCI8RilrV/8PBHbiweXFhLV8
         uVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138712; x=1714743512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHjJbBAINE/uHYfzybf0SNljSNHWl/yKpH52w4l4aoE=;
        b=iKMxLgWWx1+AUmNvQ3UDkJZG+Y8UFUZZ4oXggOfJzhxt02ix7n7+eVVHzMPilh4Nro
         NfLBgMJm5RT7GJGDEmZC292G/Tc286lqVx/kMBv2fIblPB+8h33m2W45UfFvOJZWsPzY
         x2LQfJepgA7/YNcBN62hGJmwox1v2YjNirHKrlzgqVg3dBe6qAM5vQUMu/6fehP1vzj/
         Noz7mSAF/we5xS7RQczEuOCImIwqn0aUN+mM13CQNWB5eUr1ONkH8oaSfYNj7G5q1MQ7
         dBha8fU7VhFET89qpk3qpJxRrhR1ftKXyogyLlQfJZ1GdNeBveoIQZNxHEwv9JjXO6lZ
         4BQg==
X-Forwarded-Encrypted: i=1; AJvYcCX0U3yJRoQYWZC2mGWFo0aIXZd6LiFOnfJRay78HTFFrGL4WwSK9/epJeZIVtvYdq1hujLzuk822BQNl9+T9pUXJ1dP0xcMMBBVR+zZ
X-Gm-Message-State: AOJu0YxhPB/y619HESBJukRwL/6xNP2T48SG0/WYQmrhoEK9oEzW8M36
	JtCTg8OjGHqZDil6AILg6cnsRw0W4i06QsokyF/lIuuSO2YJzUOQErKqOp2qcpzYDxZ7T5X1dUa
	MPKc=
X-Google-Smtp-Source: AGHT+IHeX/VVaDgecegUcpaWA/skSWOBVt/xVSoqnnYvRfOPU4y3ogz98bAHizNk9TNynIFmoDyEog==
X-Received: by 2002:a5d:6306:0:b0:34c:7410:d6c8 with SMTP id i6-20020a5d6306000000b0034c7410d6c8mr942894wru.49.1714138712119;
        Fri, 26 Apr 2024 06:38:32 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:63cc:9bae:f542:50e4])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d6383000000b00341b451a31asm22327689wru.36.2024.04.26.06.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:38:31 -0700 (PDT)
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
Subject: [PATCH v3 2/4] arm64: dts: exynos: gs101: Add the hsi2 sysreg node
Date: Fri, 26 Apr 2024 14:38:22 +0100
Message-ID: <20240426133824.2283144-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240426133824.2283144-1-peter.griffin@linaro.org>
References: <20240426133824.2283144-1-peter.griffin@linaro.org>
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


