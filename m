Return-Path: <linux-kernel+bounces-50273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24558476BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E6E5B25D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E797A14D42B;
	Fri,  2 Feb 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U8jnhR+1"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE514AD1E;
	Fri,  2 Feb 2024 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896563; cv=none; b=CLYjcGKfkanB0yh/mNGeY31aAJ8XlaIsn/PRbG45UeNfVwKtPnWoQY6vQOqopycCg+nslLDI26OdtVGwhdKNO1J/iOU1jgu8RZ3TOYjrxVQlCLyDraTiOPw2OiCoFUo7N5ng/iAEDknaPy89mokaO9PUbdD2IoLYwrzGSSbiwU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896563; c=relaxed/simple;
	bh=l/pTjE7Dm+7qNZe2BpwBGLX7xAHZFp9x7yL+rwnG6p8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdENd4k/WAL/SFfMxtIUnTRuQDazBvmlh/iQbgEuRlIdwwZlPB5rp8CvNOeO+DbBTHVCbCgM0duyS3UsYJvty6LRWh+EygmxGYr2e8aTW1eexwGLXQIDlf04e3ynVBdOP6xU3WXOadFgi7vl3Xs2lVuB2txB7pKJ3sPQxOWKy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=U8jnhR+1; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412Htmos035414;
	Fri, 2 Feb 2024 11:55:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706896548;
	bh=xdsEx+SGVHwMBAgK2DAZjHFN5EaH0cTNU37ll71WUHY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=U8jnhR+1Sx3J71WuHvzH+oY5gJ6qEIjh1xmd8SRXdDdoR9COnMRlaPG8SeYgi0A0u
	 hOyNzVgxpJMxVvRB3FFh2d10xDPze50h2wW1Z/gorhOmAJoTks+ZoN7LKfv9TRx6Kj
	 geKi7HQ1EvaPqeMPHrHnq4cwvTEM+m6RwWjO9tSE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412Htmh9110417
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Feb 2024 11:55:48 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 11:55:48 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 11:55:48 -0600
Received: from localhost ([10.249.48.175])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412HtmR7114713;
	Fri, 2 Feb 2024 11:55:48 -0600
From: Hari Nagalla <hnagalla@ti.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <martyn.welch@collabora.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v7 5/5] arm64: defconfig: Enable TI K3 M4 remote proc driver
Date: Fri, 2 Feb 2024 11:55:38 -0600
Message-ID: <20240202175538.1705-6-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240202175538.1705-1-hnagalla@ti.com>
References: <20240202175538.1705-1-hnagalla@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Enable CONFIG_TI_K3_M4_REMOTEPROC

Some K3 platform devices (AM64x, AM62x) have a Cortex M4 core. Build
the M4 remote proc driver as a module for these platforms.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2064e7bc529e..c3941821e812 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1337,6 +1337,7 @@ CONFIG_QCOM_Q6V5_PAS=m
 CONFIG_QCOM_SYSMON=m
 CONFIG_QCOM_WCNSS_PIL=m
 CONFIG_TI_K3_DSP_REMOTEPROC=m
+CONFIG_TI_K3_M4_REMOTEPROC=m
 CONFIG_TI_K3_R5_REMOTEPROC=m
 CONFIG_RPMSG_CHAR=m
 CONFIG_RPMSG_CTRL=m
-- 
2.34.1


