Return-Path: <linux-kernel+bounces-73581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 089EB85C477
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A431C2450C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F5E14A4C3;
	Tue, 20 Feb 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ux+UTVk7"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD714601B;
	Tue, 20 Feb 2024 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456537; cv=none; b=tl3FBFlY/Lb1xbRgAwCjUQheS/1Y8Cr1yL3JLtUVudOjd3+DF9ofDHmXJ/hVXeG8CCTM+vavu7X5J52FtiDG6dNm3hscsWZzDCgIU4PXBGD16UyEmC4eabsqy8riBr05tk8nCFkrlWKgZfPZkzqjpSl+EYdiLGH2EXTZyUWs0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456537; c=relaxed/simple;
	bh=dUB1UDXSY5z3r20NPmKrZdHjdk9LMwIBMzwlqax6N0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NErNpqJOAkONmvPdoOzK7rDzZf2aSC4dw47E0R7U9i8qP3/oADgMGUV0eskrg9/yPP2guihfsAq7qWKWyLRJn9tsrbxau4UHfnKLQ7wZKaVi4T/ALmg/b82fL19M0FzFaBGcly+CMbQTFwa2v1v3RqJ9eN9dhhBAswNmo45uxck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ux+UTVk7; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KJFFZ4060174;
	Tue, 20 Feb 2024 13:15:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708456515;
	bh=A9O7elDCRHdeS/qHgmyGZcRY0zsc0DhaO7nfioofgu4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ux+UTVk7FzC44OD9oaJOOmNq+HhwgbzZ1X6ANdCbiR5Ofut7WI/ekVBCBqQjlPueY
	 dwsrh6KczLbJuVLaviQCAIyvNe+WCTlAAk3SAABDod4BrXzXgLDRs709sXHIPONb91
	 kC2bJuCZANw3rxA5vHoa4qMNPZTUKKCzv8g11h3o=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KJFFhC023415
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 13:15:15 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 13:15:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 13:15:14 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KJEKoR051513;
	Tue, 20 Feb 2024 13:15:14 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert
 Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Darren Etheridge <detheridge@ti.com>
CC: Andrew Davis <afd@ti.com>, Brandon Brnich <b-brnich@ti.com>
Subject: [PATCH v5 4/4] arm64: defconfig: Enable Wave5 Video Encoder/Decoder
Date: Tue, 20 Feb 2024 13:14:13 -0600
Message-ID: <20240220191413.3355007-5-b-brnich@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220191413.3355007-1-b-brnich@ti.com>
References: <20240220191413.3355007-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Enable Wave521c video decoder/encoder driver on all TI K3 platforms that
contain the IP.

Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..6fe4f2da4aca 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -795,6 +795,7 @@ CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_CADENCE_CSI2RX=m
 CONFIG_VIDEO_MEDIATEK_JPEG=m
 CONFIG_VIDEO_MEDIATEK_VCODEC=m
+CONFIG_VIDEO_WAVE_VPU=m
 CONFIG_VIDEO_IMX7_CSI=m
 CONFIG_VIDEO_IMX_MIPI_CSIS=m
 CONFIG_VIDEO_IMX8_ISI=m
-- 
2.34.1


