Return-Path: <linux-kernel+bounces-27841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B1182F6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5201F2772C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0CC4C60B;
	Tue, 16 Jan 2024 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1iSeUzw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF2482D4;
	Tue, 16 Jan 2024 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434348; cv=none; b=ug8+MlMUOS8+AZGZb87nDhAksA8SgGg+4l+RemCmk2Bk/Inb4+mJhTZao6xI5UmHy1bgyo8Hk9cI/Hhf9rpJLOLIeU0hVIhgywobbDGlPVmJHZ72aJCcIu9GHXyKUO/39oZRNs82gPyi/i1SsLGqJSdNWUmYlAp0AiBdPLeWfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434348; c=relaxed/simple;
	bh=p2Bpd+eQePwcnLDZX+lZkT68QS6ugjDsw3O1PKO7jXI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=qQT6Au2SmPtK0uYnwX7gNu8EdLmS5sXnLJv2WWEH3t6WhckB7O1SqKp936tyMagsk/MjZZCD/vRh498iadJ2i7ZpLVQmD+uz0/tfTRipKuDZrzFMELhirQP7P3HV+Pn6S+qIrUUUG1/2a9/SbMNrVXNTVZfhTuFCIyg97yHAg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1iSeUzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E667C43390;
	Tue, 16 Jan 2024 19:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434347;
	bh=p2Bpd+eQePwcnLDZX+lZkT68QS6ugjDsw3O1PKO7jXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1iSeUzwTYJv0DPxd0R/aXe3opYP5wuf021ulcz3a0l24ZPl39gNuOibywVOSisiS
	 f1u2AFCorLdTlApADD3/RxB690egh/joXsTMaPrcWbbCJhE3vlROjVaVH5Yz/Ftlkl
	 0Sk3+ud9VqvkcaiCLVEQe4kM4oIkpHsNYAXQqCF0uiCHz7/bG8bmYY2A8pK/5USx6r
	 fwnHSY0HGkElrndU6yqegS+fBAzwIWlXaIqITeMffS3J900RtXSTwneOTQSILb8JuQ
	 0kONdEVSQw8X3nS7MasYjJkqoFvk/nHb/h7oBz5L+hwHT+hELiO76cwoZYVDePz1Lu
	 CEPeevw0H0qYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 070/108] ARM: dts: imx23-sansa: Use preferred i2c-gpios properties
Date: Tue, 16 Jan 2024 14:39:36 -0500
Message-ID: <20240116194225.250921-70-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit e3aa1a82fb20ee97597022f6528823a8ab82bde6 ]

The 'gpios' property to describe the SDA and SCL GPIOs is considered
deprecated according to i2c-gpio.yaml.

Switch to the preferred 'sda-gpios' and 'scl-gpios' properties.

This fixes the following schema warnings:

imx23-sansa.dtb: i2c-0: 'sda-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
imx23-sansa.dtb: i2c-0: 'scl-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts b/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
index 636cf09a2b37..b23e7ada9c80 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
@@ -175,10 +175,8 @@ i2c-0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio1 24 0		/* SDA */
-			&gpio1 22 0		/* SCL */
-		>;
+		sda-gpios = <&gpio1 24 0>;
+		scl-gpios = <&gpio1 22 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 	};
 
@@ -186,10 +184,8 @@ i2c-1 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio0 31 0		/* SDA */
-			&gpio0 30 0		/* SCL */
-		>;
+		sda-gpios = <&gpio0 31 0>;
+		scl-gpios = <&gpio0 30 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 
 		touch: touch@20 {
-- 
2.43.0


