Return-Path: <linux-kernel+bounces-117389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B18588AAC5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3A71F3B7A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0E113119D;
	Mon, 25 Mar 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fWCbp4Iy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C37317F;
	Mon, 25 Mar 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381152; cv=none; b=EV5UfW990zmDIAU8USqqQk1z+tx9fhvcMrcuxqi8EZGPWAWhoYUwl70NqevLgExikRAJcMVAnrbP1QWHk9P+cGV/AmIHum7GliKzz+byj8KFaYrHzClftyq3k8YmTkrh4Ij/gOAyxErT9nPxV2tFP5PLxxlVkePR2Wt7/N6QKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381152; c=relaxed/simple;
	bh=3v5iUw5gs5zUBSvUjIKafb/MEF4mCCtd8Xpd9HFcly8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeYDa74/KqKtYFq5HseG0GJpjMHj/2Nl82F2XwM+4XzMpK14tVle3cLtHbPXXQifjytRWwehmlzQ5PUlqeY1yzFTxjUMzE9NXJheR3mkf4m2fkQ6cezOEfdJJDVh2dmwMO6tapw5JFYSHFI0WC8j5u/OUEUoSUxUrBQoF1xyMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fWCbp4Iy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711381148;
	bh=3v5iUw5gs5zUBSvUjIKafb/MEF4mCCtd8Xpd9HFcly8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWCbp4IyGLzPOFMJJg+VSbS+HT7L1NzmN6dZqo2/wbtZlhKq39kskWcyQrnFtW8b6
	 +0k2/tsnUHdYS6TeqAzU6ChOATtBpTizePaVHfm9OJ0CP7nCn2DTxdQDTStsE+RsOv
	 KjwXiZGyXz4K/SdBdLUoj4JSZuuURhKrJpxIBy53aD0gzrniU4EBvCf8bHwaWQgYZB
	 TH7u2XWrFTkpObziBn0Ww19yAW1GBTg294N6OYHdGAQQLn7OlN6/822tXnjofJqI0f
	 83GnkCu0Q0ObPqfonpGcGYQriHRQrhiwy9zsXgpif3+55Ung38KNK8B1LKfYBzUFhG
	 aadvHD++IKngw==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EE66E37820E4;
	Mon, 25 Mar 2024 15:39:07 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 748AE4800D1; Mon, 25 Mar 2024 16:39:07 +0100 (CET)
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
Subject: [PATCH v1 4/4] arm64: dts: rockchip: rk3588-evb1: Enable GPU
Date: Mon, 25 Mar 2024 16:37:21 +0100
Message-ID: <20240325153850.189128-5-sebastian.reichel@collabora.com>
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

Enable the Mali GPU in the RK3588 EVB1.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index de30c2632b8e..b51a17b404f3 100644
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
 
@@ -484,12 +490,15 @@ rk806_dvs3_null: dvs3-null-pins {
 
 		regulators {
 			vdd_gpu_s0: dcdc-reg1 {
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
@@ -534,12 +543,15 @@ regulator-state-mem {
 			};
 
 			vdd_gpu_mem_s0: dcdc-reg5 {
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


