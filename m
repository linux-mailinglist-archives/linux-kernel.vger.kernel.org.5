Return-Path: <linux-kernel+bounces-158396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5B18B1F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF0A281787
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411CF1D556;
	Thu, 25 Apr 2024 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YTqUAK2D"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E891BF40;
	Thu, 25 Apr 2024 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041119; cv=none; b=X0Lwx1memHpbuZdKTnAMGppeDJk6bT1Ny5ETekf8hjo+YcptkZmgMPZzU7wGsB6KBBU9S45BkFydmX+xnx7AxT5gMbsIqUPGUtgtAsxRMMUJzHvh1DIfwN7a9Zpnwk/Wm8l8guq0WjuT4dTONQrguZsby4+5O6v79f0fJOyBsus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041119; c=relaxed/simple;
	bh=/PEPjvBzGdLlpyz/rkekusnGeI/h/0jlZciXQO1y1yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=r7uv/FH5O8ynaxd5wfkS/U4vI2kuT8MuOpWX/rbmEhFajDaqcc5PWS4CvBIB8EljaRup+wI5ZDFdHgjJvwAqRULYUdeGm8Sh1MDfxNjcdZg6Nz0IQhjLRFvTmfQ0VCsFE3TcT5w2X5OebvMdLpqzVp0EpGzOAYB1L6p+zoMzkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YTqUAK2D; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PAVIgr123760;
	Thu, 25 Apr 2024 05:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714041078;
	bh=VgYPUQ2eU+7hFmjj3InblJSe7TPdyr+4nnphSpxxSJg=;
	h=From:Date:Subject:To:CC;
	b=YTqUAK2DGu4m3IO8Kj8VSIjravNzlh3/8SYa1JBm7z2TDcAKY3G0ZVEqY06OAnRhl
	 jL1vu7KSYMxqz7yE0GUMn5+VwswrB0vnktR60ZVOLVvA7Vwc/NP+0hYPRdCBirMvNo
	 dhaPq/RWWiUW4nKH+ewpWEEt2Z6gmqHbTZ2xN6X4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PAVIeZ031727
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 05:31:18 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 05:31:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 05:31:18 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PAVHJr023351;
	Thu, 25 Apr 2024 05:31:17 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 25 Apr 2024 16:00:59 +0530
Subject: [PATCH] arm64: dts: ti: Fix csi2-dual-imx219 dtb names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240425-dtb_name_fix-v1-1-f3d0d7709be8@ti.com>
X-B4-Tracking: v=1; b=H4sIAOIwKmYC/x2MQQqAIBAAvyJ7TjBTiL4SEZpb7SELjQjEv7d0n
 IGZAhkTYYZBFEj4UKYzMrSNgGV3cUNJgRm00kYZbWW4/RzdgfNKr+ysQudNCL3zwMmVkPW/G6d
 aPxUFWQleAAAA
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vaishnav
 Achath <vaishnav.a@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh
 Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=/PEPjvBzGdLlpyz/rkekusnGeI/h/0jlZciXQO1y1yg=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmKjDwy18QD+rao22hFm0AsN4VgVmS2xq0L/uX/
 n7ZFJJPXV+JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZiow8AAKCRBD3pH5JJpx
 RTQpD/95enPWGFgka7cmmuetEFMvfcDPzErB8SnFPfa0F6L+IRIwqe3RHuVl2G8rlX0qLd7Obw7
 +TYHsIM0EYorlRzZIjHqmtFp7WIkpmi41+QsEZJo7OouanQjZiRVUbFuRAO1eDOwkMDdFCvrPFN
 Pc5xdmQJrGIU3Y5xBfwNOvmZQG4u8zy2ZgmfqbBkFta4vH+DU4+7mW3bocbgp9wkE+qPjbFZ6Dw
 zkk76GhRXtzZ7kNrryPPLm2elcNlZHdRw3EcRHMOHTYY7Nw0m7dbp88cdvA/hvFv+XgsH4WLXze
 7saRjk0MV/3CbPfbiatZ13uGHl23MubrKeuZVtcZ7t4/WytJ6sYkWUQxeA1efyKZ1KjVURI6RMw
 WPssyX+58wgpgxouTrW5dj6SDCOzY3R0r4CWUscd6LnLqEeRwk92d1AKs/NgEf8c7JGWe5D+E7e
 fmMWiQLpoOtbQNWLL4bmxv40a0k4rHF6MOu4eZ/rOn1vqQHQCmSzjsese2/lvoqKidFO3txm3yZ
 umkGtEujOgdTZBDilorfzU6LbVqBR1IYnAAsJ+VZdUJ5OAvJBaJ5qxTNW0bl1scUWHMll+g/yaw
 LUtCBNakQImTy6+sE9bUjjm//VmwOIyByZ2MTw8o8i9PiUWtj1MV9zgA9czEKe1Js/O7oBKYAEY
 j3Nr9r9p5Kk4fwQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fix the output filenames of the combined device tree blobs generated by
applying *-csi2-dual-imx219-* overlays on the base dtbs during compile
test.

Fixes: f767eb918096 ("arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index c76b41f86527..8cb0f50198ac 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -162,10 +162,10 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am642-evm-icssg1-dualemac.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
-	k3-am68-sk-base-board-csi2-dual-imx219-dtbs \
-	k3-am69-sk-csi2-dual-imx219-dtbs \
+	k3-am68-sk-base-board-csi2-dual-imx219.dtb \
+	k3-am69-sk-csi2-dual-imx219.dtb \
 	k3-j721e-evm-pcie0-ep.dtb \
-	k3-j721e-sk-csi2-dual-imx219-dtbs \
+	k3-j721e-sk-csi2-dual-imx219.dtb \
 	k3-j721s2-evm-pcie1-ep.dtb
 
 # Enable support for device-tree overlays

---
base-commit: 6bd343537461b57f3efe5dfc5fc193a232dfef1e
change-id: 20240425-dtb_name_fix-350eab4dd8ab

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


