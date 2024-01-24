Return-Path: <linux-kernel+bounces-37537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 320C383B163
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD89328867A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C83A131E2F;
	Wed, 24 Jan 2024 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fX2iWVL1"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516F5131733;
	Wed, 24 Jan 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122053; cv=none; b=Pta/OeeBw66HoP0zX17V5ZYyoJtOSWgvU8NvQ++KBu+tt9RhIGPpV+Z//4yTKwzAkTiZOvWimdqAURfahDaKTP9OqV+nR1Th+BEskRrZl0T49lhvtyZ7Lq/mAxaV56OT2kjEgY4TMNMsFhgDePizKz6SSmcKEurNEsXMuxnOd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122053; c=relaxed/simple;
	bh=uslfZhNjmmevu2mEJ9hTuNVIhJEpbIjkZjZsNdkFV7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDoayJu9NAMAUGFI8Xxq8JAJ3HW5XQcif2IPIiRwOxpaZ0A3vfV9moPLr6CkNh0netrfx/ZyENJ+PsQaKuIFl9otSzHMNhwGHokloAQySzQuLL6w54uYZnUTwEMTpr1vStbpLbJAj3PSfU1LVF0Z1ppGScoiknUGcc+T79LgXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fX2iWVL1; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlOJs074453;
	Wed, 24 Jan 2024 12:47:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706122044;
	bh=x/zGqgZv1rGt+8HAzqdCk/mN57obrKCAyUppmXTsYEc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fX2iWVL1E8j+9fIj3ivm8Di8wE4CQ5DXgfzLNni21rn3/HzLyeuRodLKCQeRNua5o
	 rvPvw0f1QLFR5IxX3LcMa6R277sWFgqto8nqJ7cqG8C0532JIkoZEKtskWkU9QyiQK
	 YcPxEvv2eg6R737LgwIfIk+oOPxqMu/IlyNxI8Uk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIlOrN052041
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 12:47:24 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:47:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:47:24 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlNaO119099;
	Wed, 24 Jan 2024 12:47:23 -0600
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
Subject: [PATCH 02/11] arm64: dts: ti: k3-am65: Convert serdes_mux node into reg-mux
Date: Wed, 24 Jan 2024 12:47:13 -0600
Message-ID: <20240124184722.150615-2-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index fcea544656360..a18edd34283c7 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -492,11 +492,12 @@ serdes1_clk: clock@4090 {
 			reg = <0x00004090 0x4>;
 		};
 
-		serdes_mux: mux-controller {
-			compatible = "mmio-mux";
+		serdes_mux: mux-controller@4080 {
+			compatible = "reg-mux";
+			reg = <0x4080 0x14>;
 			#mux-control-cells = <1>;
-			mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
-					<0x4090 0x3>; /* SERDES1 lane select */
+			mux-reg-masks = <0x0 0x3>, /* SERDES0 lane select */
+					<0x10 0x3>; /* SERDES1 lane select */
 		};
 
 		dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0 {
-- 
2.39.2


