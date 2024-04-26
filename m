Return-Path: <linux-kernel+bounces-160609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BA18B400A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20583B2422F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E416623758;
	Fri, 26 Apr 2024 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u7guXwcG"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55AA208D6;
	Fri, 26 Apr 2024 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159120; cv=none; b=HoGgpzF+drTpAsDZ5Zwj2vx40cbQgVJyP2U6UvspG/VvEW+Gh9VjEsxVNYytzgPsXW1Zby0SkCBc7/rv80hE8fVDvUy6WilXfFre2A3nNSeZf5cXAkM2tqpnPEAlq/uCRlObA87cjHc2yZYrp9VQeyxPNmXZH6oOE588RYFeVTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159120; c=relaxed/simple;
	bh=LjOOh654N028PKm9hKjjINIwDhnYd4OGHM8FU+b5J68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3C5JdsdJNZ0yn8O6lDR9bOCymFztCYsREKBXIFxJX73OMUDgQFPottHr/rJgT64OrsOrW90TM4Qv2jGkILVJl1xHzSB+3QbhozzB6MfGaPdUDaqSsL5As6vZJgJymOvF86rLHpjoWZlRvecEiaGxhcbeFxi9H1WoBqG/EMOpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u7guXwcG; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QJICTW099384;
	Fri, 26 Apr 2024 14:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714159092;
	bh=EeEnTqm3oLoWS+b5dZcuC693obg0Ef8ytBl/uzoDfOk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=u7guXwcGuzEUdmIcJoD4OGP2xPPre4gy/A53rrjjC1D21VJC4b/HaVTkXACnY0i91
	 4Zgy1B9IsUDt1c9+FCg+BnOz9hPYi1V/VKk8huCjmArWis6AmsiZrAxpvgVlLa4OR5
	 vI4JVqkPP4ipji1TivS6kq4dTgPHf6g7APbEaET8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QJICLE040924
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 14:18:12 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 14:18:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 14:18:12 -0500
Received: from ula0226330.dhcp.ti.com (ula0226330.dhcp.ti.com [128.247.81.8])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QJIB7O028593;
	Fri, 26 Apr 2024 14:18:12 -0500
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
Subject: [PATCH v9 5/5] arm64: defconfig: Enable TI K3 M4 remoteproc driver
Date: Fri, 26 Apr 2024 14:18:11 -0500
Message-ID: <20240426191811.32414-6-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426191811.32414-1-afd@ti.com>
References: <20240426191811.32414-1-afd@ti.com>
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


