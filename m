Return-Path: <linux-kernel+bounces-37539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8120A83B169
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358FB289310
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3E5132C17;
	Wed, 24 Jan 2024 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g9rq3Ru8"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A8131757;
	Wed, 24 Jan 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122055; cv=none; b=lSFem1BZh48xpvmfnBYDyzg/dVOX8S++mGTM9gpIT7NvROvRF0ouVa6H6UikLHY+hdoXmOiWDlSUGgtpwwkFq2GUfzgL0X57XEzSPBagknD1GegN03qsuz92ZWi9gORsFeQwES+Z+yu4xw16xBle5MpYz0MpIPh973MTISp/d6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122055; c=relaxed/simple;
	bh=v/JXUqIDsjsDEKt1F1Q/SZjgRGT6H9Fn657zVe2ARP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtRcG48D1VuovGBrch9IR/CezLSAICE3qm7LXkxxN9gjPu1dIIvG++v0YmQRwkb3P8mU/48Zbg39iALb71gW2AGRKXxW3j+pyXrr5Y4tN4kgf56DtNmpAoQ2K3FuUJ8eLnfRIfXwQotVq4KfkQY4j6fBaKXTP4MdqRdUryxeJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g9rq3Ru8; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlQGX093968;
	Wed, 24 Jan 2024 12:47:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706122046;
	bh=zOS0P3QPtHjlgIzqfd9HI1Lple5XlJqllrKD3PGT/wY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=g9rq3Ru8+95u7QggKz32kp+Qh0DuDAnGMUEXtj5hey13icKZHU80UmLGu/v3UE4mH
	 3HV/TzOLuOLvVNQS0n1zMoMNIz1B5dR9NQoKsDaIVWUo4JaPKv8dotCOIRXGAX7Maz
	 OBGoYA+rJBS8Eyus2/v3vf97//VgPl8oivBU5xRI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIlQ48052086
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 12:47:26 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:47:26 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:47:26 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlNaT119099;
	Wed, 24 Jan 2024 12:47:26 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 07/11] arm64: dts: ti: k3-j721s2: Convert usb_serdes_mux node into reg-mux
Date: Wed, 24 Jan 2024 12:47:18 -0600
Message-ID: <20240124184722.150615-7-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124184722.150615-1-afd@ti.com>
References: <20240124184722.150615-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This removes a dependency on the parent node being a syscon node.
Convert from mmio-mux to reg-mux adjusting node name and properties
as needed.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index ea7f2b2ab165d..d985250d7caf4 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -45,7 +45,7 @@ scm_conf: syscon@104000 {
 		ranges = <0x00 0x00 0x00104000 0x18000>;
 
 		usb_serdes_mux: mux-controller@0 {
-			compatible = "mmio-mux";
+			compatible = "reg-mux";
 			reg = <0x0 0x4>;
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
-- 
2.39.2


