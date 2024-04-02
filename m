Return-Path: <linux-kernel+bounces-128607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1ED895D05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861662865CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828DD15CD59;
	Tue,  2 Apr 2024 19:52:18 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F415AAAA;
	Tue,  2 Apr 2024 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087538; cv=none; b=azoT5H8sA1Rq7l8C3Nt6auw4IP8tvoGWrKg2e335hEzT1Uz1XpWGrLVlVwAK17Qqfn4Q+QiG6jb7ak4NlAVCALE9V0DstB8LXIc9PXxFCbepCYnm2Vetalpi+gviK7cjST2wViponlA3dxjyqsJII2m3IlRf5pL2CzvlasAps2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087538; c=relaxed/simple;
	bh=zVrwAjUcGsk/Gvd0IQbWlkXCkBrhd705XLqPbvC6bLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W7Et+TADx9XYY3jKrTXrVgFyI796Qip4wrJKcVIygXImrQwzpvAMKOKthDs9lCvD2esZ5MngTqheNXE1sGsmCBpvkwUIZgUsy8Y309qOnaPYjRYdf8mgNPtSOg3vfUfsj6RuKk6eguzD9Oa8W3MznQzURZv9pJrLtF/Br9mne+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1rrjtR-000HwR-Jr;
	Tue, 02 Apr 2024 19:34:01 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Tim Harvey <tharvey@gateworks.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] arm64: dts: imx8m*-venice-gw7: Fix TPM schema violations
Date: Tue,  2 Apr 2024 12:33:55 -0700
Message-Id: <20240402193355.2333597-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 26c9d152ebf3 ("dt-bindings: tpm: Consolidate TCG TIS
bindings"), several issues are reported by "make dtbs_check" for arm64
devicetrees:

The compatible property needs to contain the chip's name in addition to
the generic "tcg,tpm_tis-spi".

tpm@1: compatible: ['tcg,tpm_tis-spi'] is too short
	from schema $id:
http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#

Fix these schema violations.

Gateworks Venice uses an Atmel ATTPM20P:
https://trac.gateworks.com/wiki/tpm

Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts  | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
index 41c966147b94..429be2bab8a2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
@@ -57,7 +57,7 @@ &ecspi2 {
 	status = "okay";
 
 	tpm@1 {
-		compatible = "tcg,tpm_tis-spi";
+		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x1>;
 		spi-max-frequency = <36000000>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index 5e2cbaf27e0f..35ae0faa815b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -297,7 +297,7 @@ flash@0 {
 	};
 
 	tpm@1 {
-		compatible = "tcg,tpm_tis-spi";
+		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x1>;
 		spi-max-frequency = <36000000>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
index e7bf032265e0..2f740d74707b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
@@ -68,7 +68,7 @@ &ecspi2 {
 	status = "okay";
 
 	tpm@1 {
-		compatible = "tcg,tpm_tis-spi";
+		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x1>;
 		spi-max-frequency = <36000000>;
 	};
-- 
2.25.1


