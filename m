Return-Path: <linux-kernel+bounces-72399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAF185B2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DFB1F254C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0058ACF;
	Tue, 20 Feb 2024 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="clRpCC4y"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390B5822E;
	Tue, 20 Feb 2024 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409907; cv=none; b=pt6wwr0+JC/4tFwgSwCDwnAjUgt5vhpIkUHe7dbaeG+VVNZgGIyIBywhJhlSDly8SOdnWWeQ9ci3xxsknvuXCyZITWwTxRH9C1Lyql/N5wBWrhrAEOryszzYJhy5NeS7mMH7mHhj9Bm38/tdLYS7T0C35+0ufhsUmzOXAJeK8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409907; c=relaxed/simple;
	bh=KAReUPQx9gvzzba47vWWOb5Oekj/PePm9BhH+eG3XlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lMVJkMqG12Typl95tzrFWGZEvy9sp370FG9u4Uspt+UCZ2wngkpyxE4WpTZdr4eL7yv940ZfF7VD2BDoYOqYjGv5C96UKWnlVNU+20qsrz8sfasCmzK25L6QsJgjGup6KMyA8CI5QO5cna+C0XZ9Ihoj7Lyb/mzl++ROQpIMN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=clRpCC4y; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K6IDqO128521;
	Tue, 20 Feb 2024 00:18:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708409893;
	bh=wjIFXi26a8elJBZ1+oTQlZXDKgmfrz906nvtBMqRczE=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=clRpCC4yj257w4WI6mVvTtY+Rl3jkmfXH4ITmjuZpn0a/FBr2GVjlH2gCOKxki7ot
	 +wcsb9NhXmX0MzFFaIApndmgD49xa0VDdCIuwSREsj/tJh4bgNCUD8R6gLmDYwtBws
	 geU+MTKzlpph2AlXv8XWBeqGiq9zRDpTFRS2Rvf8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K6ID7n048009
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 00:18:13 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 00:18:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 00:18:13 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K6ICk7120873;
	Tue, 20 Feb 2024 00:18:12 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 20 Feb 2024 11:48:02 +0530
Subject: [PATCH v2 1/4] arm64: dts: ti: k3-am62p: Fix memory ranges for
 DMSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240220-am62p_csi-v2-1-3e71d9945571@ti.com>
References: <20240220-am62p_csi-v2-0-3e71d9945571@ti.com>
In-Reply-To: <20240220-am62p_csi-v2-0-3e71d9945571@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
        Devarsh
 Thakkar <devarsht@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
        Jai Luthra
	<j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1338; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=KAReUPQx9gvzzba47vWWOb5Oekj/PePm9BhH+eG3XlQ=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1EQe/ATjXPVYP4orc1Clk5F32f+sFPV2jgia0
 Tcj9gDbT5OJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdREHgAKCRBD3pH5JJpx
 Rf64EADLqMiQyJqkDRSyqQnnu9j0mVc9kq1MLa7jJCtJqo5fMPjsb9Uh9E9iGj3niqaA1OMZGJQ
 HY82Ts4C39y+9qmW7ktWjs44NduqQEjpNgIl+8qOolFboOlmChh1H7ibHgdo7nCNfE52BSsuhT2
 c2cbcLATqWp9rLmrgd6NxgD1n+F9GodVuzmHCXaYJMVDikiCcFCuu6ZkBABsmIDMUPj+/3cf5jU
 Ot3lAB8zJCeE6JE0gbkxqFHfweEJX52luMXCxWpvZSwPTs3Dy4/sUY01lKKjh32K2s9sruXGhNm
 gCNXKRUod/xmKa4AurGPwX+Mk+blfoVjP1uwNxgV1IhduHZ4gjvZVi+3DWevG+4/zjP2UmOkZvD
 7WKRMID5pLSlVeIaNnQ0OsjG65cBVLtgeQiltoRStavUXtWOnDjXLyOFsqfKNPixfus4t2EcXE0
 TI5YWXW5zcp/3JN7hlFkPPRkSLgGVPX57YZ+qfccJq7bFIrJfDIw5u136szYJUaC6PI9UuNdsoo
 oP24PAVcGr1+UhVF5hmauDNebOyDNQ0FBZHgpO0UU2P83+BoEbVtxuhgjrafsGPpJU18q8gYu6m
 ycOh5oN+kCa1CwA/z3fIDFM5zNuH5nazw4rcg6tzkyOk0w8w4KZEmVl23hGUKd7kOrz+RlI2Kl3
 x8GD+UI5nDNhFiQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The INTR module for DMASS1 (CSI specific DMASS) is outside the currently
available ranges, as it starts at 0x4e400000. So fix the ranges property
to enable programming the interrupts correctly.

Fixes: 29075cc09f43 ("arm64: dts: ti: Introduce AM62P5 family of SoCs")
Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index d111e044bfdf..94babc412575 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -71,7 +71,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* SA3 sproxy data */
 			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
 			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* SA3 sproxy config */
-			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMSS */
+			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06408000>, /* DMSS */
 			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
 			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
 			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */

-- 
2.43.0


