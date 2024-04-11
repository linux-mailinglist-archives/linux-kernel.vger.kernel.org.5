Return-Path: <linux-kernel+bounces-141680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D860A8A21F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66BC4B23AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58AC481B7;
	Thu, 11 Apr 2024 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IHMcDpS3"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C812E6C;
	Thu, 11 Apr 2024 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875989; cv=none; b=pX54eseZciQgaZGWAsUiTqD6nnl6LyocyOiZssySX1E0lPiN9CcqLshkm4O6+0NVNmFML2nYGPf8CPS1NcCHXQQp968s81OyESa6/CDY5y41S+CgrbGHDxkwgy6lSe+SVY5b498ZLU8POs1f/7gQonFEj5JOBn6GkB5ihZKi2ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875989; c=relaxed/simple;
	bh=P/bZqmi5tX/lltQL5h2nrT0q+Hpv7eCt+l1QnEB2mJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e32zQAWrs6UM0Drdf/tbJxV/FgMxAyzvvQ/yJ+YQn+o+lLd50g+pU3bfSq5+thYRdzUeu7U8iuvN3lb2CO4SB7bPM8HGsz9Xp7IWvbi57ifScut5i72nfT7euJ3ngr/9NcHbgNQF9kqXxc1N2xS+68wB0Iqe2MmB//2g2ZFmVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IHMcDpS3; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43BMqwXU106819;
	Thu, 11 Apr 2024 17:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712875978;
	bh=u6vHxsop2dc7G8tz56tmeLvsOTidrw9pFmeRN0x2ua4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=IHMcDpS3fW3buueDLD6uV71ScK6RovtUKYr7IKodb/pg6O+GZDnK0uUzwdLLFa7cR
	 6FahIO5WaLUnGl4RYLTHx9QutJXW4Xba40/6Lh20kdZ6aCLWnzhTM7xVK6W+p0ur7Q
	 mpq4kgjT/Rd4TdZ36hpp1+Uoc8FaT7Oz5owPEpUw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43BMqwL2083771
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 17:52:58 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 17:52:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 17:52:57 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43BMqv7b002381;
	Thu, 11 Apr 2024 17:52:57 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 5/7] arm64: dts: ti: k3-j784s4-main: Enable support for UHS mode
Date: Thu, 11 Apr 2024 17:52:55 -0500
Message-ID: <20240411225257.383889-6-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240411225257.383889-1-jm@ti.com>
References: <20240411225257.383889-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Dasnavis Sabiya <sabiya.d@ti.com>

Remove sdhci-caps-mask to enable support for SDR104 speed mode for
SD card and remove no-1-8-v property so that SD card can work in
any UHS-1 high speed mode it can support.

Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[Judith: Add fixes tag]
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index d42f25cacf23d..6a4554c6c9c13 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -904,8 +904,6 @@ main_sdhci1: mmc@4fb0000 {
 		ti,clkbuf-sel = <0x7>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
-		sdhci-caps-mask = <0x00000003 0x00000000>;
-		no-1-8-v;
 		status = "disabled";
 	};
 
-- 
2.43.2


