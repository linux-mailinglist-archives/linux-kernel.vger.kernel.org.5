Return-Path: <linux-kernel+bounces-31080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8CC83288B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6C91C22A34
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DAC4D5BD;
	Fri, 19 Jan 2024 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxBqbEPN"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25FA4D10C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662716; cv=none; b=P5Dr/DVU8t0mW+s6WaCvCa4bMr03YT1MXIM7RfHCTj9rf1h4IElu4POc9HW7azDJLuyeFGhpPNBQVWNChbnl80ryoISf0vzM0904h8W963Y2VSajrSP5xgRs9YjY14uwm7cEYaDtqf09DF7p91blp8jHr82VQhLL3at6LePaw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662716; c=relaxed/simple;
	bh=Kv/qgN5wdHjnG8VF1fPyW8eUb5V4sWqohtBHYU2gKCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HD8ZtZFjGlHSDVWhluCQI/jj5FqGFp4q0+ixOPVwhp7Lu31fp937oS7s2rM5FXqcGDdN6o65eFulrsL4JO/OlNLV5SKuzywXrLEqyi+L+5RVLXzcRTSp0WZClf/OvxF0aiav52jX0K+F3EcPGKMyJSY9J6vnmkyMFogzYh5aK2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NxBqbEPN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3368abe1093so487166f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705662713; x=1706267513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1HT8eUHAUE1J0rcUA9FGL6+fb4DKBSfdgo51wbL26s=;
        b=NxBqbEPNsSra+DDi35B+rjysLGKL2Nc3YF6bCAQvDGokze3KftWC8HyktsAZmOik4A
         4Ck4IAkNgkaFRYjj+xUNGz/2uPc+mb0XajqRPKa0z6Wt6c8OoH7jaNDbV21kL6WMYUrp
         sC0DE+O9tLnwLIl3nXt/CoCFFVEIAxpw5adklD8kQIHSn/BkI5EOU489cjINxzENk59P
         B4efuCQgvZ20VuvaRNvUv0m3uXT5ndghpMgpDe9Iouap5KP0Ue26EBhj2f6zD1VCBIgO
         InopM1SuAgIUI8Cu5fBOeOXAoB34ceOLrDLYFP9NXYb81vHG1boWhjBWHO8LltxdvPUW
         +7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705662713; x=1706267513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1HT8eUHAUE1J0rcUA9FGL6+fb4DKBSfdgo51wbL26s=;
        b=ve87ot3+Z35cWC5q66EVI7Rfj445D+rbS0/44bR64qJ3kMLXKJbwHGQu9kA25lQ4ow
         EbHOi/NyFqHvrfjaqxi+6qeJ6L8xKxT5XiTp8AHxPv9G/jkDewd0xj0Aoin+Ejzzh6FQ
         giGvZZIXI9DqQFCr6msryuEkzuAT+xQgs1kcRdYiFeGPFaZ4LdfoRnFOSkP1vL8PtzSd
         k8lb4OESlpLZa0pVQzbYWw6EFYIxzNgIO7dyMYS+hXhdqxJSzKziWPHQXvA/OPy3tlUq
         WiERu4evPK3hOlmyH6YOC4hT1pubVgCEJ4FnoFgfIU0zob4nen0gi5woX9SEUHjktT0o
         aP+A==
X-Gm-Message-State: AOJu0YxVKF4gtsGrlvN3OaWcZexBraWNwY/AMRWCnyYTp9dJlhRHwjBk
	CU/3trpk/2se4TGjXVYibzGrheyAoHflca8Q+9HdCfDN1qeMoxtYVlX08eziUXU=
X-Google-Smtp-Source: AGHT+IHaBc6eJWWwfsyXPpEBpMT+qK4nQa/Ck3+GDDBnNhmmA3Miv7rIcU2p6oIK13S23wdfYvCWEA==
X-Received: by 2002:a5d:456c:0:b0:337:be12:3261 with SMTP id a12-20020a5d456c000000b00337be123261mr1308033wrc.68.1705662713261;
        Fri, 19 Jan 2024 03:11:53 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d62ca000000b00337d4ce6ab4sm3341868wrv.20.2024.01.19.03.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:11:52 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: andi.shyti@kernel.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	andre.draszik@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 5/8] arm64: dts: exynos: gs101: enable cmu-peric0 clock controller
Date: Fri, 19 Jan 2024 11:11:29 +0000
Message-ID: <20240119111132.1290455-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119111132.1290455-1-tudor.ambarus@linaro.org>
References: <20240119111132.1290455-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the cmu-peric0 clock controller. It feeds USI and I3c.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 4e5f4c748906..2d1344a202a9 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -339,6 +339,16 @@ ppi_cluster2: interrupt-partition-2 {
 			};
 		};
 
+		cmu_peric0: clock-controller@10800000 {
+			compatible = "google,gs101-cmu-peric0";
+			reg = <0x10800000 0x4000>;
+			#clock-cells = <1>;
+			clocks = <&ext_24_5m>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC0_BUS>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC0_IP>;
+			clock-names = "oscclk", "bus", "ip";
+		};
+
 		sysreg_peric0: syscon@10820000 {
 			compatible = "google,gs101-peric0-sysreg", "syscon";
 			reg = <0x10820000 0x10000>;
-- 
2.43.0.429.g432eaa2c6b-goog


