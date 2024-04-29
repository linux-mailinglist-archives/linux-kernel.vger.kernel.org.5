Return-Path: <linux-kernel+bounces-162125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7C8B5648
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6ED4285C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549954AECE;
	Mon, 29 Apr 2024 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AgKXX2Vl"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4E44C87
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389347; cv=none; b=reVHHVe/wX9fz76Z+881J9TQKH6n0Tz2iJniHdFFvJU/FVIy7Q35x/tuXVAM/9I3OTg4npRTtU/jsYJ+4xw94+xECPviQqURt04Z/j6jossFAof1mX7iZXfO2Pv6QZmlZXR8OefpGeUH6hJOrBShkz59dXhop+tk9VDUssX9GPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389347; c=relaxed/simple;
	bh=R8u9gOpaZoz3b/0A4Dz6h+enHqnL9gWvIJpc2lmJbIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2/rbfoFJmszwq1Gz0J+p5E2pSg9s0ngC65pPI0J/5RKXxOacDhxqdVFUL5sN9ufj3NhpssmrxEbEkgIhtIMP6PtZb7mE3+yvoSNi9L6Bnx3GXp9iF8CouG09b/se4b6JluJgpfdgQiH8OnCUbZs0Rp2n5ASExgaWlGABY9uNws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AgKXX2Vl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ba1ba5592so17607445e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714389344; x=1714994144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1WAKwxpulo/9a7288mxakZp0oX6XNI0y7Pv/KuppyE=;
        b=AgKXX2Vlwx/zAGCM/dt48ybHFHHEf0hNZBdpzDjGbL5N11DINeQL6LDBi/3fvuWkHd
         ARN62iP0ZPnzYoX6nRVnitImri3c6tSPoCfuUAt38U5QtiYOQEA1r6Fkshk2cQIhOYm1
         mS1JszmB07+R9eimar25jDaX/AaZcQC5GGGo3WNINuFlWikZYzKbxwEK0XmUKbm0K2AK
         V0YmvNf2bSu5ZBqQy/BWPegdI4BgKbQEAgz8KbaLsUsO6sYPMhGxtXwPIu5mwFvA/xz+
         duiWovSvv+1+HC+t9qQfZspeJQ/I+aJtbiMgcR5VeiVooQvybJpsSJu6IezidZq0HnjU
         3iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714389344; x=1714994144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1WAKwxpulo/9a7288mxakZp0oX6XNI0y7Pv/KuppyE=;
        b=IoejX58SO4AfeOC1nW/YxyP69CVKlzDnbPU+NYBeniO/ym8G0bUE6kbkdjwaT7RG2r
         ZsYTCYIfQckX2KwBRtounVaZ7M8ISTGoCRfQ8rmKZ8ViqqTd5dSAXsoGwc39EhrVQ0hU
         u0HVBvxj/RYwa13eitYmiU4DR8ISiWhDjlODO9qHOT1IUmB7/ZKm4PuPuhyh7K5ticvI
         ivZe3lPmx6UZ2OkKT3g7SP7aMfOF07L9MRIoVluI9zp6dHTR8yTXlTpMierVNbZ/XFQ+
         ZEY/BxDi/pla7byac9UX7lhTsxfbJm9UO/2c20gn510Jo5G+B2ynL0UjkhOomrjiqHQI
         1ncw==
X-Forwarded-Encrypted: i=1; AJvYcCXfwssb2wfqj4DFTq25uq2ETu4ZmGgbW8KqXbgu9XvTikIbIoNFmLeQdyzmbqWBMZ8uty5P+vAi1WpRK/mK9F/PdHwOC3lphGhoyfpS
X-Gm-Message-State: AOJu0Yw9bifS63lgkefTh6z4UXr1afDHa6+w8/Q2tcv6GdfeUM7E4JvG
	DF5pSWPjayeXpZk+WEalWKDkrE4WU9rpVs6pvR3JCZpYi+DSTajlCrFIu4ucX4k=
X-Google-Smtp-Source: AGHT+IEvJzhyspUyvZgekf+7N7FA03+ayXrlvlx7rF9PZ8VspjfLv75wdp9S/1Wy5cZLFnU+IA0obQ==
X-Received: by 2002:a05:600c:3acb:b0:41b:e55c:8ddd with SMTP id d11-20020a05600c3acb00b0041be55c8dddmr4741849wms.27.1714389344510;
        Mon, 29 Apr 2024 04:15:44 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:550a:b373:6b8:63ab])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b0041b434e5869sm16005337wmq.43.2024.04.29.04.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:15:44 -0700 (PDT)
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
Subject: [PATCH v4 3/4] arm64: dts: exynos: gs101: Add ufs and ufs-phy dt nodes
Date: Mon, 29 Apr 2024 12:15:36 +0100
Message-ID: <20240429111537.2369227-4-peter.griffin@linaro.org>
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

Add the ufs controller node and phy node for gs101.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 09044deede63..9330d99e12df 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1277,6 +1277,42 @@ pinctrl_hsi2: pinctrl@14440000 {
 			interrupts = <GIC_SPI 503 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		ufs_0: ufs@14700000 {
+			compatible = "google,gs101-ufs";
+			reg = <0x14700000 0x200>,
+			      <0x14701100 0x200>,
+			      <0x14780000 0xa000>,
+			      <0x14600000 0x100>;
+			reg-names = "hci", "vs_hci", "unipro", "ufsp";
+			interrupts = <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_ACLK>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_CLK_UNIPRO>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_FMP_CLK>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_ACLK>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_PCLK>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_SYSREG_HSI2_PCLK>;
+			clock-names = "core_clk", "sclk_unipro_main", "fmp",
+				      "aclk", "pclk", "sysreg";
+			freq-table-hz = <0 0>, <0 0>, <0 0>, <0 0>, <0 0>, <0 0>;
+			pinctrl-0 = <&ufs_rst_n &ufs_refclk_out>;
+			pinctrl-names = "default";
+			phys = <&ufs_0_phy>;
+			phy-names = "ufs-phy";
+			samsung,sysreg = <&sysreg_hsi2 0x710>;
+			status = "disabled";
+		};
+
+		ufs_0_phy: phy@0x14704000 {
+			compatible = "google,gs101-ufs-phy";
+			reg = <0x14704000 0x3000>;
+			reg-names = "phy-pma";
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			#phy-cells = <0>;
+			clocks = <&ext_24_5m>;
+			clock-names = "ref_clk";
+			status = "disabled";
+		};
+
 		cmu_apm: clock-controller@17400000 {
 			compatible = "google,gs101-cmu-apm";
 			reg = <0x17400000 0x8000>;
-- 
2.44.0.769.g3c40516874-goog


