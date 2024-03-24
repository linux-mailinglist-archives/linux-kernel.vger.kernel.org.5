Return-Path: <linux-kernel+bounces-113031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5698880EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596931F231E8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F1513A88C;
	Sun, 24 Mar 2024 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXnVeoBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4428813AA38;
	Sun, 24 Mar 2024 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319841; cv=none; b=XOzoHAASzf26Z6QaOo2hvYPaAsAgaMDzAUYUlBfPIj6okA89AOhxb8M9MfxrcCNAHX3YsLMbwHo5rYJR0StSzNkbsuD1Rq7x9kwCxkoVpArepIJxh1MBiUj4Ms1jfbbX9HsREWoyktKg+dx4UlCqpmbhJ+Vt96uOLerGUFep1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319841; c=relaxed/simple;
	bh=Ss+KgOwG9QJQ+Pdfqn7/6z9VceW9yvJPmtKSu+GCfPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmkRAaasTv5UE1FuTjTaxiYE+zPmbMe7+tjhy4GvaivaGYdVPAS47f00G3m/kJs1KbxiJguXRb+MoevnkK4YF0bEdy3vDChW9khlP8orJHf9qqnsfKXthCSlDONjwGGS5XtYNIte+m0/aoOdGbDRDSCdHVb5zec+2wDRGrCT5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXnVeoBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBB6C433A6;
	Sun, 24 Mar 2024 22:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319841;
	bh=Ss+KgOwG9QJQ+Pdfqn7/6z9VceW9yvJPmtKSu+GCfPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mXnVeoBRCON9lHzjY4TPcBpWm/YHJRkdyQm96Oz61DgC9UQgN09tJoyaMDZh+RZ+D
	 QdCI2mArGnvIEJOK70v/kOETZuBcr33qlx7Ms+9R4QR1GxywGpPOAKxSDAmS60NwX8
	 taNQggKSx/BiVgIRKiQmTbuPuFax18e/EKyA0H5Rn9Hnnuq1tph8fqA+a2tKDCS2iw
	 9lCR+7Sui9oMn6W5t1UlCUhX/ZGzfm0YDAonC5kt4mwVDw2xww7tjkaW/dOKgqabH1
	 w/j50albfIlssHpVsxeIPfnJWjI4vxNMwN0Pi8yo9nsFdD18EdcsthYOVPXZJA5Vgn
	 BsLC940S12Qmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manorit Chawdhry <m-chawdhry@ti.com>,
	Andrew Davis <afd@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 144/715] arm64: dts: ti: k3-j721s2: Fix power domain for VTM node
Date: Sun, 24 Mar 2024 18:25:23 -0400
Message-ID: <20240324223455.1342824-145-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Manorit Chawdhry <m-chawdhry@ti.com>

[ Upstream commit 5ef196ed912e80a1e64936119ced8d7eb5635f0f ]

Fix the power domain device ID for wkup_vtm0 node.

Link: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j721s2/devices.html
Fixes: d148e3fe52c8 ("arm64: dts: ti: j721s2: Add VTM node")
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20240201-b4-upstream-j721s2-fix-vtm-devid-v2-1-85fd568b77e3@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 80aa33c58a452..a47cb557dd956 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -663,7 +663,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		compatible = "ti,j7200-vtm";
 		reg = <0x00 0x42040000 0x0 0x350>,
 		      <0x00 0x42050000 0x0 0x350>;
-		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
+		power-domains = <&k3_pds 180 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
 	};
 
-- 
2.43.0


