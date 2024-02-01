Return-Path: <linux-kernel+bounces-47755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A826845264
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5891F23488
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0343D15AAAA;
	Thu,  1 Feb 2024 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nd6Bqqhn"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665F15A4AE;
	Thu,  1 Feb 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774866; cv=none; b=tALqQQSlS+ENe6/KN0T9LwWbDsK4hU/lUqYpHpQoEZVyRDiJumw2NgQLf2nL215sxfW3IiRphfQV08TS/RuRCAlnM+NYYi6duMiblObRCcAiTtn74KPRvFR7mK/R3SPpy1MjAZBMYRgOP23e6pw7YzU7aRToD8GJuhUr69/Jok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774866; c=relaxed/simple;
	bh=jOkf1AWkSV8Uxnj1tVi/XYhyG/y1uz6jPDzFOy/ur/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EsN33VAJ8HcYr4d8yRmACQp5ThVFzGEMDSNZU8wZ9PzTJbvwxzir0IyFOcthK01yuwzSkzkbnB+CrxR/50chiCrmiHLmXfnz2adXOBXOqeNzCz5QcM8r6JAo64B9EL7HPq7QDXyFsbBriQfTpjaHsWQbi1uXOp6nmkoteQHLPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nd6Bqqhn; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41187YVs032547;
	Thu, 1 Feb 2024 02:07:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706774855;
	bh=KNulddle2A5tm5U9zs/rFg7SbsAOFBv2yBQmC2q39mI=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=nd6BqqhnqV1oVGfIDMVumFrkc+lf6HynUcAgg3ev8MeJAp6G12JPGT3l4SBSLGogB
	 hAnPgv3hFGFYUBi1O1eDqHcHHt3aPRwSMpbb2e5RtGfnX8piklH1BPo/p3+Nh7Qip4
	 AWZzVe8L6V1fyVXlV7oBKLEtqyuHTXh/FXeFx5SQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41187Y8t012264
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 02:07:34 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 02:07:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 02:07:34 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41187Qbw125056;
	Thu, 1 Feb 2024 02:07:31 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 1 Feb 2024 13:37:26 +0530
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j721s2: Fix power domain for VTM
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240201-b4-upstream-j721s2-fix-vtm-devid-v2-1-85fd568b77e3@ti.com>
References: <20240201-b4-upstream-j721s2-fix-vtm-devid-v2-0-85fd568b77e3@ti.com>
In-Reply-To: <20240201-b4-upstream-j721s2-fix-vtm-devid-v2-0-85fd568b77e3@ti.com>
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan Brattlof <bb@ti.com>,
        Keerthy <j-keerthy@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Manorit
 Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706774846; l=1004;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=jOkf1AWkSV8Uxnj1tVi/XYhyG/y1uz6jPDzFOy/ur/w=;
 b=MdBZScRf4uxEJqeoULKAACZLeXpMJMe7PjCxeun4MInbxfEfRJePMmJNUejTFJ9r6RQeBq3Sb
 B5ZnlkObAXyAeylGFnxSXm/FR3mUwhuWC10FLGrzp/SDfxZG2LGvA5u
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fix the power domain device ID for wkup_vtm0 node.

Link: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j721s2/devices.html
Fixes: d148e3fe52c8 ("arm64: dts: ti: j721s2: Add VTM node")
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 80aa33c58a45..a47cb557dd95 100644
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


