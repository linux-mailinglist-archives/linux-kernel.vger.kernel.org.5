Return-Path: <linux-kernel+bounces-67072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C028565C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9711C2255A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD02131E39;
	Thu, 15 Feb 2024 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SJeGbuhm"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B1130ADA;
	Thu, 15 Feb 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006819; cv=none; b=VbyDRIfWDXP850LP9gooQloeam+dsXpOybHuC8wvQy0sKeSvFR4zx5hUuGZzl31RJEnXRx55MIzeS1W8Pa9oYBSYwpNnZFnQGBQVG+QgB1IHuwz+et0qA+JcXbpFeJNmiGFGI1g7HcBLlWp2LgRVBjWiB3cXBzDlOvoh3YI7IVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006819; c=relaxed/simple;
	bh=PullOvSOvstiiYMgcHnwd9VygvmFZsrOtFt1fJGokB8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nv2BCoS8e02/bxoWJ7AyVHsIgk17SiorGFPn5RumaSqs4NlQw9UYzxP42RgAyRjKV2jh1MzAtrIaaDbZXrLJGDnbLU/EWmlyGhzXaibtaf9DZ859ixqtQKbybdu+sohu/B4sacoWHVveyRSEYdfQLJmEnVOr11vwbVFpoBF4Pds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SJeGbuhm; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FEJxtx023347;
	Thu, 15 Feb 2024 08:19:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708006799;
	bh=u5Efv4NH6LtRrGCMOj0uLzoSpUJhq4ciZ4y37cudC9g=;
	h=From:To:CC:Subject:Date;
	b=SJeGbuhmmiKwNumDR9Ol4SGBOoTiuhxWP07VL++Zr7U2cnkukDtwhM+lOFmKYoHGL
	 3/Rcn8B2tZ32xNWzrK3qKctRM3pqfh2jFth+cD3QLLvQWvJ2IM3zgMcWBZNsCQPZLt
	 KVadkClvyklkmzKPA5WTrwxKaR8C32W2H3DPazDg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FEJxZb016848
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 08:19:59 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 08:19:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 08:19:58 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FEJwiL057677;
	Thu, 15 Feb 2024 08:19:58 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter
 Rosin <peda@axentia.se>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721e: Fix mux-reg-masks in hbmc_mux
Date: Thu, 15 Feb 2024 08:19:57 -0600
Message-ID: <20240215141957.13775-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Change offset in mux-reg-masks property for hbmc_mux node
since reg-mux property is used in compatible.

While here, update the reg region to include 4 bytes as this
is a 32bit register.

Fixes: 2765149273f4 ("mux: mmio: use reg property when parent device is not a syscon")
Suggested-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 40caa86e600fe..4618b697fbc47 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -353,9 +353,9 @@ fss: bus@47000000 {
 
 		hbmc_mux: mux-controller@47000004 {
 			compatible = "reg-mux";
-			reg = <0x00 0x47000004 0x00 0x2>;
+			reg = <0x00 0x47000004 0x00 0x4>;
 			#mux-control-cells = <1>;
-			mux-reg-masks = <0x4 0x2>; /* HBMC select */
+			mux-reg-masks = <0x0 0x2>; /* HBMC select */
 		};
 
 		hbmc: hyperbus@47034000 {
-- 
2.39.2


