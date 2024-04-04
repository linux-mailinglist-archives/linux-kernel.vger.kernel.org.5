Return-Path: <linux-kernel+bounces-131418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECAC898795
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55095286C9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F52D12CDB0;
	Thu,  4 Apr 2024 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpD0U80T"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE0012D75B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233607; cv=none; b=lzdgrcVa76NwUUVmDX6ftyP7OJ+Au/wBVr8ueB7TuYbT4MHgzZ2GVfi0uApTtCrB0lcdyzFWwSoSyBE33cExGGxZ6aJDJELzITlb2nPOB73ZpDAEQtYKUleERk8Pmn/dxwfpP0oFP3fcrpEtMXSJq01QKTmV1NK8PvWxr6L95OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233607; c=relaxed/simple;
	bh=2iMqsB7DjaDv1tdJXp6qd7zyM2tt1u3QD0+LtNhzesM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7lcQ7DAyj8vhIlUUK5qQeQ1TELCoND4J9Rxcyd+Q8Q9Lh7HVEVjKpqNoS/cK7XrQdl1erkTzobw7vO4Lhux7jme2pzXheEaUPdPxhtRvW9a2BKBJu9GozWn50s412XjDgDSGxrOMpCVBcGajOP26epkMnLiCnWbEyT5A/uh6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GpD0U80T; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34356f794a5so808924f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712233603; x=1712838403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds/JjfQ2TlKCtemWTNTPAMOOadxWRRjHRCXTNztqFqc=;
        b=GpD0U80Thdn+K86O7VaQ+vay5qFHr6oDMSq5rpVutDjzkSFrf0MuPLOBbI9SLNLssO
         mSIVHC4Ue/C81pVaNrMqDJHQu6U50mf/XQYFGLmQfAhKFrQ70qfjYM8VMRCzXAxcs+SK
         Uq5PH8B3MjwGyw67dL7vpjKjbPAYiUWg4Rp3lGwCdGX0xFsBnM7kXFRP+/Ur288bJdws
         0ZcoxRWEbPI/ot7X46RF4YfIXrH98lsXyiZoBrs2MZFhY5wH7TVYFYA3yXUkwkAOP47n
         D9LKoxHRnbAzJhesmVHfyt9Da8QXfkzrVFJxB44elRjtC3sxaNBDTsBJM3k/dzgcRyFX
         T41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233603; x=1712838403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds/JjfQ2TlKCtemWTNTPAMOOadxWRRjHRCXTNztqFqc=;
        b=FrENLjeaxbh2dV2zXle+o4v8myEMbiNXyeOoqEFTaFRUlDYYMq6rtu3EULr73ZWICT
         ozsNkkzqQvnsUlirNxsjYYGvWO9/wdlD1aTOb3EXrdpDjNXwt2p/8cV0e7LV01740Pzp
         57Ja7aW+/dTDZfjVxV0D9rxl+HxWj44Jk3PYCwHVEpGxw9g2kF/4PAdk0kLjPmeEBjw5
         DzjvS9xiAUQkx4CZUXn3/NiVudFolkrGThH8gBqDVYPeu7ELsZymtJoTKseLX/iFk/Hj
         30M8Ahx0/1im85/JwagnNcEJSe3/wf7jci6UYumoc/fIumuVXAKK9WDay3os3V4X+5rE
         mN1A==
X-Forwarded-Encrypted: i=1; AJvYcCWkfCqcScG2PVvPJaqUgLsgm9cK+Gc+jjb98GK4Ox8IPOrzedh+StunHZVCGVZOI8PI5qMM9BNnLD8XkO5LCxRV+GTBWnGD9XLOTSzL
X-Gm-Message-State: AOJu0YwA8yW1nizUiv53YBOWhH23GuSz0mZYC6UF065pB2wXKkrpJuaT
	V0iCP7vyrwkMT7GQFBwQjAnAmSAcI73tSQhZt0DyGjW+NYoepSFCeFd/6D/vAnY=
X-Google-Smtp-Source: AGHT+IE1KcSWtq0AtIR6tJqtMgKw1sNq7p9OsCBJVxmziFYXd9baY73voLcHuEo5/99B79vRXGQPWg==
X-Received: by 2002:a5d:4589:0:b0:33e:c528:c900 with SMTP id p9-20020a5d4589000000b0033ec528c900mr2144866wrq.55.1712233603079;
        Thu, 04 Apr 2024 05:26:43 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([148.252.128.204])
        by smtp.gmail.com with ESMTPSA id bu14-20020a056000078e00b003434b41c83fsm12106303wrb.81.2024.04.04.05.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:26:41 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	chanho61.park@samsung.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 05/17] arm64: dts: exynos: gs101: enable cmu-hsi2 clock controller
Date: Thu,  4 Apr 2024 13:25:47 +0100
Message-ID: <20240404122559.898930-6-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240404122559.898930-1-peter.griffin@linaro.org>
References: <20240404122559.898930-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the cmu_hsi2 clock management unit. It feeds some of
the high speed interfaces such as PCIe and UFS.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index eddb6b326fde..38ac4fb1397e 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1253,6 +1253,18 @@ pinctrl_hsi1: pinctrl@11840000 {
 			interrupts = <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		cmu_hsi2: clock-controller@14400000 {
+			compatible = "google,gs101-cmu-hsi2";
+			reg = <0x14400000 0x4000>;
+			#clock-cells = <1>;
+			clocks = <&ext_24_5m>,
+				 <&cmu_top CLK_DOUT_CMU_HSI2_BUS>,
+				 <&cmu_top CLK_DOUT_CMU_HSI2_PCIE>,
+				 <&cmu_top CLK_DOUT_CMU_HSI2_UFS_EMBD>,
+				 <&cmu_top CLK_DOUT_CMU_HSI2_MMC_CARD>;
+			clock-names = "oscclk", "bus", "pcie", "ufs_embd", "mmc_card";
+		};
+
 		pinctrl_hsi2: pinctrl@14440000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x14440000 0x00001000>;
-- 
2.44.0.478.gd926399ef9-goog


