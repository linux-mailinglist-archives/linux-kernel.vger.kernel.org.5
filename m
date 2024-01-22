Return-Path: <linux-kernel+bounces-33208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DAD836615
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA131F2110C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6113FB0B;
	Mon, 22 Jan 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="heJLfhud"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21773E47B;
	Mon, 22 Jan 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935369; cv=none; b=fw4h4RBsfpUVTgGx8O+szk4bGbZ8HCC28K6onT3V3DzHDxEQOuB4kHjAyKhXGlYAOaqu9uRQYnDPpo/ivKPBgjEpAKCTnl7Hl5/1623nrFQrGRIsVOUmoRiRaZIomXVAWYozPjv/9pMplc29ce4XxqDOamNGeVN0pEdKPKAgbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935369; c=relaxed/simple;
	bh=reC+aHAsId78ew5YTgifxyRYNjmpr2q25i2bNq00z68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqsGxYxNviTfOK9cT36BZ3ywGDV5dxl6vdI3aAn5zYksFrmcr6rpkwCTFuo0+F1DUCJ07VNY+1r7uW/fbKW4RvK29/ND7nzAr71PKfl/iIHcLBDGx4GuRkZI/w9pi1Y/VBlOFlRh1oJFEaFflpJWUdlty/XvTCe0IJLXf68NhS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=heJLfhud; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MEti5f060831;
	Mon, 22 Jan 2024 08:55:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705935344;
	bh=byNe4h8h59vd/FMV4Pu9YfnBwt+dMv2K5Op/bJlqDOc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=heJLfhudkC318YMFeGazU3KFapAx98now8sfl3dkzabnbnH6oUjVi0LleAiWt9blQ
	 inPJuerG3/dLdiA3NoE9QLUFz1FE4P2AMKEm0Dh+dfYVZ9ZwFLRyOtx/aiXOsJzxXq
	 rwWrejobXfNPEnXBW0GMCu6hAMHMtADy7nVuBzjQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MEti6s126218
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 08:55:44 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 08:55:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 08:55:44 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MEtiYW022016;
	Mon, 22 Jan 2024 08:55:44 -0600
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 16/16] arm64: dts: ti: Makefile: Clarify GPL-2.0 as GPL-2.0-only
Date: Mon, 22 Jan 2024 08:55:39 -0600
Message-ID: <20240122145539.194512-17-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145539.194512-1-nm@ti.com>
References: <20240122145539.194512-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

SPDX identifier GPL-2.0 has been deprecated since license list version
3.0. Use GPL-2.0-only to be specific.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes Since v1:
* No Change.

V1: https://lore.kernel.org/r/20240110140903.4090946-17-nm@ti.com

 arch/arm64/boot/dts/ti/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 52c1dc910308..40724017de89 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 #
 # Make file to build device tree binaries for boards based on
 # Texas Instruments Inc processors
-- 
2.43.0


