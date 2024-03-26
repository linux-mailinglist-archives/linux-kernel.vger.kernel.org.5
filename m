Return-Path: <linux-kernel+bounces-119519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787AB88C9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A441F82D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991DA1D556;
	Tue, 26 Mar 2024 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vxNBhGCZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415D41BF50;
	Tue, 26 Mar 2024 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471958; cv=none; b=YWTlisjjV2v0wY6yhU0pxUfyt29dvtqc86EEMp/FgG04GubyrhxipZcdGWMOHkPvr1uwwfvfuOL6SK0yubz7maNzvdLSgeCjuh+2AoVBvEEa3vCd23FhfE99XM8R7suI+E3vGM9ghbIkUovqxUncdxkvl4LVJ8BQM7QdRRdc8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471958; c=relaxed/simple;
	bh=bnU0rBb9ounSPduviQn9sL9EO0sU2ngM/C/AFvHMEVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzEas6A+zGPa8NCir81kaRxPkPjWuoB4aFblYglgZAGrcEGDlR5YNzf8l6X86nD+Q3Ig3i6SflIUVMVVFoK79z94blfMeWDgM1bnAHBIugh0ZHY+yNZd3ULkUWbsvBlAOh5pxRxQ+cYxc/UC2Eq9QYP+xPbuDikQlUoX+uwJipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vxNBhGCZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711471953;
	bh=bnU0rBb9ounSPduviQn9sL9EO0sU2ngM/C/AFvHMEVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vxNBhGCZXpjB9GTJKtO4QIbWJeutrVm5FOMLOmgmXxO07oQiqhlLGMbbTceJNnkJ2
	 3VWaqzBSn/Wda0VQ2KqyJ4espaZEfyfNRwxh8TrlC4imoxk1DxGdlJPwz9eE2UumE3
	 HOkt3UQKn5YTkKXatZ6nMR/yo6ppCsnQN0U0HjD1xvK9T80DsQ4jI2feYmo9z+f7jh
	 8bPE55Ir7buo4MDillgSiLXuz4RhFAoSURVseKrByaan56fe8wzX1xQhOln8BOAyUU
	 aHTJo7vFAp6MLdhHbcjf9zUG6cJqCmJJIVV9s1BXALdQMWdXRQkShX9q1MJM7Z+ME+
	 NQ72+wj4dh10A==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 80A3C37820E4;
	Tue, 26 Mar 2024 16:52:33 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 170D14800D1; Tue, 26 Mar 2024 17:52:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 4/4] arm64: dts: rockchip: rk3588-evb1: Enable GPU
Date: Tue, 26 Mar 2024 17:52:08 +0100
Message-ID: <20240326165232.73585-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326165232.73585-1-sebastian.reichel@collabora.com>
References: <20240326165232.73585-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boris Brezillon <boris.brezillon@collabora.com>

Enable the Mali GPU in the RK3588 EVB1.

This marks the GPU regulators as always-on, because the generic
coupler regulator logic from the kernel can only handle them
when they are marked as always-on. Technically it's okay to
disable the regulators, when the GPU is not used.

Considering the RK3588 EVB1 is not battery powered, the slightly
increased power consumption for keeping the regulator always
enabled is not a big deal. Thus it's better to enable GPU support
than wait for a better solution.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index de30c2632b8e..56c019b25fa8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -281,6 +281,12 @@ &gmac0_rgmii_clk
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu_s0>;
+	sram-supply = <&vdd_gpu_mem_s0>;
+	status = "okay";
+};
+
 &i2c2 {
 	status = "okay";
 
@@ -484,12 +490,16 @@ rk806_dvs3_null: dvs3-null-pins {
 
 		regulators {
 			vdd_gpu_s0: dcdc-reg1 {
+				/* regulator coupling requires always-on */
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;
 				regulator-name = "vdd_gpu_s0";
 				regulator-enable-ramp-delay = <400>;
+				regulator-coupled-with = <&vdd_gpu_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -534,12 +544,16 @@ regulator-state-mem {
 			};
 
 			vdd_gpu_mem_s0: dcdc-reg5 {
+				/* regulator coupling requires always-on */
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;
 				regulator-enable-ramp-delay = <400>;
 				regulator-name = "vdd_gpu_mem_s0";
+				regulator-coupled-with = <&vdd_gpu_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
-- 
2.43.0


