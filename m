Return-Path: <linux-kernel+bounces-157584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 773B98B1334
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177681F24A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36EC20DC8;
	Wed, 24 Apr 2024 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K++cTgAJ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F461D53F;
	Wed, 24 Apr 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985598; cv=none; b=BTE/bZUarkX0aXhBBbCAmOKKPqHQiYW8Fn9gWe6Btzi5LC9IagddJ5mkmJX6NeaGpxjyXduP9Yve0XeiWj/HGhnVercOZM+tX8barAbTzHy+TTIN9awxTRsweUL4coQ9Vzs1EJMabpFjJjT2Z/fwmCgbw0b/UJFnvgw2xaQ23mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985598; c=relaxed/simple;
	bh=LjOOh654N028PKm9hKjjINIwDhnYd4OGHM8FU+b5J68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kP2wCUmQLyl7RJvgQYDTIAd3kdAiOjZx+gcTKdEfveyImc1ril1W6MIPrGvO2k16ddn2ay+Inzpl6tB7Yo1TB3gogOlzIfMLfaeTdVyME6/vF4DFccvmE5qJ0lWFONs3q1F71/wWYrphZCmv9dB3zv2Ml9wDtEvGM+Za1YV9d0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K++cTgAJ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43OJ6EED006916;
	Wed, 24 Apr 2024 14:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713985574;
	bh=EeEnTqm3oLoWS+b5dZcuC693obg0Ef8ytBl/uzoDfOk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=K++cTgAJCuktoxq3tg5QILZHcOAC7IrxcJ8MH1cBfRkewQn2tO+KZYQNP8Y02/HGw
	 Wc/vlO9dJqrRSzdmiMev4NaJuobMPLJQtXbyhojyQbFdut7DhxrKb6EzeIM46leK1u
	 WsTLRRRu4GCHK0pWmOd/iwAG0SU8OpcX+7E31MOA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43OJ6Etm017963
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Apr 2024 14:06:14 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 14:06:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 14:06:14 -0500
Received: from ula0226330.dhcp.ti.com (ula0226330.dhcp.ti.com [10.219.51.241])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43OJ6DqQ067070;
	Wed, 24 Apr 2024 14:06:14 -0500
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth
 Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hari Nagalla
	<hnagalla@ti.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v8 3/4] arm64: defconfig: Enable TI K3 M4 remoteproc driver
Date: Wed, 24 Apr 2024 14:06:11 -0500
Message-ID: <20240424190612.17349-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424190612.17349-1-afd@ti.com>
References: <20240424190612.17349-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Hari Nagalla <hnagalla@ti.com>

Some K3 platform devices (AM64x, AM62x) have a Cortex M4 core. Build
the M4 remote proc driver as a module for these platforms.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e1802..04e8e2ca4aa10 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1352,6 +1352,7 @@ CONFIG_QCOM_Q6V5_PAS=m
 CONFIG_QCOM_SYSMON=m
 CONFIG_QCOM_WCNSS_PIL=m
 CONFIG_TI_K3_DSP_REMOTEPROC=m
+CONFIG_TI_K3_M4_REMOTEPROC=m
 CONFIG_TI_K3_R5_REMOTEPROC=m
 CONFIG_RPMSG_CHAR=m
 CONFIG_RPMSG_CTRL=m
-- 
2.39.2


