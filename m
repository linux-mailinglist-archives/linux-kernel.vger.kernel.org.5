Return-Path: <linux-kernel+bounces-117390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F5288AAC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E681F36884
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3481311A1;
	Mon, 25 Mar 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uL9pcOHC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1385B202;
	Mon, 25 Mar 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381152; cv=none; b=oD4Ecf7TAAX+1vZsMymIdToBrcUcq52r+8jRKbMsuJ391e/51P9qm0aiucAKJA1VzAgeHOZxtDCTuQ/NZUKP/yXj6Y/OPZm1nbnOattRGyQNyVXge2UmGMLExMcEM/d/vdlb3q1G0sUvR5ooDVhN3ndBbsRZZJeyaHG4gp82Abs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381152; c=relaxed/simple;
	bh=V6CI1OPaZQ5Q/0TuYhGO0XSg1bgvwZJfaU9l9hRSx7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1G6mKB2NzzvrLlg8K3yu3GGeASvK7XofPK3hPhHrwu1NOfEhbPueBAPoDlv7PsWnWeRUpalZnaC933WVFAnhcT/id3VOidqJeR6KCh+EV5vKWWC9lbJ3+9jYYP6HkauOIg9bTX2FW5FJXGOGGQmPoROy/FW5PTBM0P0Lzz46QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uL9pcOHC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711381148;
	bh=V6CI1OPaZQ5Q/0TuYhGO0XSg1bgvwZJfaU9l9hRSx7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uL9pcOHCR1riL8gQwJrUPgkShaPJGuKqyTUZg/ZcDxdkk0Cyk1O+P4jgAmsYdCXlP
	 3A/N47aW5x0+ZUFIfLKrctM9rIhTfekHyh928MBgvajKw32fEoH5HlXFpxeWQ0UCiD
	 sMS2KX95kXPtKjK+dS5ZOZv6eadRkU7K6+rJGpgdf3zmWfSynwvGcSMpsGzpH8x0pQ
	 WQSKRoVpPA3wx0SHv/PjzXBJTJcTimMvoxyOoBY5gROTRRJ+bYey5cwtk+nIOluJSo
	 HTSzXUfKEwYpROA+tM7N5wrTeLeknrNUf8nYF0kiLYq9sYFdX1JaREK3ZYQNY+fSCG
	 sHdeBuol0AUnA==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E085237820E1;
	Mon, 25 Mar 2024 15:39:07 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 72D464800D0; Mon, 25 Mar 2024 16:39:07 +0100 (CET)
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
Subject: [PATCH v1 3/4] arm64: dts: rockchip: rk3588-rock5b: Enable GPU
Date: Mon, 25 Mar 2024 16:37:20 +0100
Message-ID: <20240325153850.189128-4-sebastian.reichel@collabora.com>
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

Enable the Mali GPU in the Rock 5B.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 1fe8b2a0ed75..096ee7a98b89 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -180,6 +180,11 @@ &cpu_l3 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu_s0>;
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0m2_xfer>;
@@ -470,6 +475,7 @@ rk806_dvs3_null: dvs3-null-pins {
 
 		regulators {
 			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <950000>;
-- 
2.43.0


