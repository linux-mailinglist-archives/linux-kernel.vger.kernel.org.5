Return-Path: <linux-kernel+bounces-117393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABCA88AAD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1101C2E675
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4390913793C;
	Mon, 25 Mar 2024 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KuxxvBjY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1045A0F9;
	Mon, 25 Mar 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381153; cv=none; b=Bl6YWXhVdBZoANiINknRRXtbYofWjOQe+YB70v9VZar4UMZvuf/hhmKIyZ7Z0whJonH9Is3L+W+kYG25kYG+3cnOQROmbZEuZvwPqz3T77NGe1nCRQhB8Ay5F3Y4U2qQy2QT7h3MkXEibrelizjUEmHnQUB6Vv6fITTCKo8ZDrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381153; c=relaxed/simple;
	bh=/Nxs6FstrASPGXaLg5JYRLWZbQzXEV2qtmeifS1oC4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7AYUyLqjG77TV+ej4qLlsyq5EPmxE5qkUsiiJ61y60d+9zV9zY1zOdpaZGGZr4lxHNtQ1nf2vJMwWjHCxXJIA1zoBvYONGxGvXpYmfTOKyNlrP6LQSntj0onX0QgbWUvlHm95Acj71pHP9E2mAdGSHJ5SO+6qvsXFzDgq5iXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KuxxvBjY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711381147;
	bh=/Nxs6FstrASPGXaLg5JYRLWZbQzXEV2qtmeifS1oC4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KuxxvBjY/VL9GvrsKl94GyItaw4fp7KEaQoKAYxA0loCP3BpEZADWDMzWi6SYqIhR
	 JgRpOZDTX7IgtUvOEdsAXNYVaolBK6k0Ea9xOqFt09YnCZNI0rAnqXQIPiphUeD1me
	 Wno6O442U9mF1jx3XJ3+6knlbwkkssTyeFoiR/llDw+ykaR0U7n1XRzsALjuCR51sA
	 ivYrR2dtLhVuFkkZIBAqq0DyYZNAJflSVaO2f82CEtKi1UI1GYOwYw/6vy97KL+l8q
	 fFK2BScpau+xVhPj0ZOA4Y37aMZPL8SyzR+j5WgYo9SUWdQwSsPQXyNMr4o8482UeL
	 scny7TgeMKTcA==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CA40137820BB;
	Mon, 25 Mar 2024 15:39:07 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 7121B4800CF; Mon, 25 Mar 2024 16:39:07 +0100 (CET)
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
Subject: [PATCH v1 2/4] arm64: dts: rockchip: rk3588: Add GPU nodes
Date: Mon, 25 Mar 2024 16:37:19 +0100
Message-ID: <20240325153850.189128-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325153850.189128-1-sebastian.reichel@collabora.com>
References: <20240325153850.189128-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boris Brezillon <boris.brezillon@collabora.com>

Add Mali GPU Node to the RK3588 SoC DT including GPU clock
operating points

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 56 +++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 87b83c87bd55..89d40cff635f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -501,6 +501,62 @@ usb_host2_xhci: usb@fcd00000 {
 		status = "disabled";
 	};
 
+	gpu: gpu@fb000000 {
+		compatible = "rockchip,rk3588-mali", "arm,mali-valhall-csf";
+		reg = <0x0 0xfb000000 0x0 0x200000>;
+		#cooling-cells = <2>;
+		assigned-clocks = <&scmi_clk SCMI_CLK_GPU>;
+		assigned-clock-rates = <200000000>;
+		clocks = <&cru CLK_GPU>, <&cru CLK_GPU_COREGROUP>,
+			 <&cru CLK_GPU_STACKS>;
+		clock-names = "core", "coregroup", "stacks";
+		dynamic-power-coefficient = <2982>;
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "job", "mmu", "gpu";
+		operating-points-v2 = <&gpu_opp_table>;
+		power-domains = <&power RK3588_PD_GPU>;
+		status = "disabled";
+
+		gpu_opp_table: opp-table {
+			compatible = "operating-points-v2";
+
+			opp-300000000 {
+				opp-hz = /bits/ 64 <300000000>;
+				opp-microvolt = <675000 675000 850000>;
+			};
+			opp-400000000 {
+				opp-hz = /bits/ 64 <400000000>;
+				opp-microvolt = <675000 675000 850000>;
+			};
+			opp-500000000 {
+				opp-hz = /bits/ 64 <500000000>;
+				opp-microvolt = <675000 675000 850000>;
+			};
+			opp-600000000 {
+				opp-hz = /bits/ 64 <600000000>;
+				opp-microvolt = <675000 675000 850000>;
+			};
+			opp-700000000 {
+				opp-hz = /bits/ 64 <700000000>;
+				opp-microvolt = <700000 700000 850000>;
+			};
+			opp-800000000 {
+				opp-hz = /bits/ 64 <800000000>;
+				opp-microvolt = <750000 750000 850000>;
+			};
+			opp-900000000 {
+				opp-hz = /bits/ 64 <900000000>;
+				opp-microvolt = <800000 800000 850000>;
+			};
+			opp-1000000000 {
+				opp-hz = /bits/ 64 <1000000000>;
+				opp-microvolt = <850000 850000 850000>;
+			};
+		};
+	};
+
 	pmu1grf: syscon@fd58a000 {
 		compatible = "rockchip,rk3588-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xfd58a000 0x0 0x10000>;
-- 
2.43.0


