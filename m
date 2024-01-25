Return-Path: <linux-kernel+bounces-38704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B3E83C454
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9211F24522
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA763407;
	Thu, 25 Jan 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVE5IbWv"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858A6313C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191630; cv=none; b=NaCwqT+H0AO8txEm0Wpa/KZLuWsgjkLXKyWOmLdziUAEjW1/CZ1Ix/EGuxZYq9ji1Xvnp+GeS0uMyqlvN04pCAdqhwVtdt0J4B7lVgBOSuoWz9BVoPKmG+Tnk1Ek9URhJ0ahtYpgVupqpNNkpfU8OChsfaEWa3JbgJxnWX71Z9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191630; c=relaxed/simple;
	bh=JQ0+STV9AqGXR93rvqvT/Fhpuw2Ch/BDzNv9b9Rs614=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B92LtWLXCc78O5C6lymD0Omca5T5Y4plwNCIp3MAPNUddaSOgWr4LHZ7CvkcXMEgYn21rLkHFd8SIuE6a6+gzTiZmR4C/ePuS8PbY3K3PkxeJSKTFyvIZUqWhgyl7JGZQ68BAeWgNPJdwcCGAWen+Y9TenmmwudXVLD09h8ul6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XVE5IbWv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5100409e31eso5466741e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706191627; x=1706796427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwJ9LZ2cw3a5KQSrNOlRxJLZjD3460dcBT/9JVrzxHs=;
        b=XVE5IbWv2QfgawA46rNxRLnw5FbD4geYvqIM9vP/7JgyvfPXFhIHnPPoU1zbxgVCsA
         kMMwi9gRqn389wSxxOG++77SVKR4ZOPlNQC23zd3jlpeEfaaQLv/Q5qL9S4ztfUHSkmh
         CwdBIt9MNNzbtP+AdeEhwe6BgZ0GchWruphTCrD4YTtAFyGXO4m4eflPQuk39cLyL6Ro
         uT90tVObiFQWCdEnLBYGWTkbwFea2b4o7gfi9zDwpLWDYk7aVUyGMPxi7FuM8YdBy6qp
         6Qtk/vlmzwNxDtjgBAPIjPsnuAFch8Awh+mwE0B4h6EfSJKWr4PhUVeuvzl9llFCq4sf
         60jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706191627; x=1706796427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwJ9LZ2cw3a5KQSrNOlRxJLZjD3460dcBT/9JVrzxHs=;
        b=PoESWOJ1tgtCwERr6jfuKWGs0EWMRak+cz51Vv7ucqVSttcozGDNeeqZgYHnNOVS51
         kOXyaGtL+c3QoL9SwnvFmX85emYudjcMtuKPtAZbzxNJI5iVPVAchqlN8Fe3RA4GiXsC
         PiTDebQs8ySFLh3mv0a01d8inV07McKJTLLBChDA/nTA8kLRjtgTVhip4MPFNqzibtQ0
         NKL6Aktm9MfV0E8Ubceocl6QVsRmnrVuIG6I5ONXfenGE1Fw0wlwPSepqTS5/BcwIqcL
         3kOow+owyWvU82uQQi0adMvys496Cz3R0Rw5bwVZG1ifem5nBbaJRpf15P3bX6FsKUhJ
         0zcg==
X-Gm-Message-State: AOJu0Yy5Tbu35oG8vV0r1Yhqq4WRSSWmHSRhLfwz/6EMQYqPPt9uk7ov
	DE6/DujbKsdFhnGn8fqhasYnpJ0hanOOVzvcr+6zEyGBcS9Yxsl1KHOUvloLhdDQph2nUwIbw9L
	hNgGH1Q==
X-Google-Smtp-Source: AGHT+IHDLdWAqT+26X6zklelfsY1utLIeysKoCEK/sUCxbZZqTR4mecGOTUthh4jQmkqePF94oQcKg==
X-Received: by 2002:a19:ae13:0:b0:50e:9eaf:98ec with SMTP id f19-20020a19ae13000000b0050e9eaf98ecmr516026lfc.54.1706191626763;
        Thu, 25 Jan 2024 06:07:06 -0800 (PST)
Received: from puffmais.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id tj3-20020a170907c24300b00a2fde3a8097sm366740ejc.74.2024.01.25.06.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:06:52 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	peter.griffin@linaro.org
Cc: kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2] arm64: dts: exynos: gs101: sysreg_peric0 needs a clock
Date: Thu, 25 Jan 2024 14:06:44 +0000
Message-ID: <20240125140644.3617587-1-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125140139.3616119-2-andre.draszik@linaro.org>
References: <20240125140139.3616119-2-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Without the clock running, we can not access its registers, and now
that we have it, we should add it here so that it gets enabled as
and when needed.

Update the DTSI accordingly.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 412d2866dca7..aaac04df5e65 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -364,6 +364,7 @@ cmu_peric0: clock-controller@10800000 {
 		sysreg_peric0: syscon@10820000 {
 			compatible = "google,gs101-peric0-sysreg", "syscon";
 			reg = <0x10820000 0x10000>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK>;
 		};
 
 		pinctrl_peric0: pinctrl@10840000 {
-- 
2.43.0.429.g432eaa2c6b-goog


