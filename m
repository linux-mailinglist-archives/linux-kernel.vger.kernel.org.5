Return-Path: <linux-kernel+bounces-48191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92247845871
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C85284F92
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4A253385;
	Thu,  1 Feb 2024 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r282Ms25"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847234D9EC;
	Thu,  1 Feb 2024 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792839; cv=none; b=m+ZdsXFiQrxTuG4nT9V5WtZ3HYOhChNSC2YMadMPHEDMWS5RR4rjaQ00IJoRHcseAATLSFXZP68kvs6Y0blTxBXslq2X3HW5cz0NkIUOO6X1AsTIdGyXy82UqNjf6V9OGzE7lTqTIGAKUDoaYf5TXhtOzYouNLKP0Ewga64kXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792839; c=relaxed/simple;
	bh=1CMmX3jd2pLUCqu+EFJBJO2nN+pqTZAQeqrdSBzj0jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nPucYto3Gj4FXV48FJ6w0LZRE6n6nDsTrAwVDCArKfd/H9uw3xujlSN6mm4yOy+aewAUa0CW/6d/WLGe0Z7n37vyLuTj+g4JwU7FRqvMKEWKW9speWYFly07lGtTl8Y/8h9b729/siSJskgJYvxCok0YvbpumuV/J4o1cRdKw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r282Ms25; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411D7AnU111374;
	Thu, 1 Feb 2024 07:07:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706792830;
	bh=jokkh7mm/vApO8cJ2IgO8lvQ0Jxmj4g+5elU4Bg1bf0=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=r282Ms255/nIRnj88+3M/JfpW/Pv/lJ3UZjPropVIF/Uc//UlXNURvkgy7E8wH4A3
	 xsaRKrvSyp04oXH9VTA8+xoyHofqCdizaGv2emVCDtVY+yF75/WEszViaGr0sSZQTM
	 VC6U/hagsRrhLB7wc2RQ0JL34rQyIaqlvQovafvQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411D7ALf121103
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 07:07:10 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 07:07:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 07:07:09 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411D78Sp012827;
	Thu, 1 Feb 2024 07:07:09 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 1 Feb 2024 18:37:00 +0530
Subject: [PATCH 1/4] arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240201-am62p_csi-v1-1-c83bb9eaeb49@ti.com>
References: <20240201-am62p_csi-v1-0-c83bb9eaeb49@ti.com>
In-Reply-To: <20240201-am62p_csi-v1-0-c83bb9eaeb49@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=1CMmX3jd2pLUCqu+EFJBJO2nN+pqTZAQeqrdSBzj0jg=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlu5d31SanWbJPLAw6IkCBDYpbCnLupNV7p50ky
 npr9EsviW6JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZbuXdwAKCRBD3pH5JJpx
 RWW3D/9brVgwvqumRvQwKdedaNFFpsPh1+tqTV2yhjv649jdQpJ0kOK8nN7BR2AVhFDdAwuZ7Ox
 HXASrP0FlJ5hmpPskOhdrs3ps82JerRhKy0r4t8uFaHsO4aOy1rB6s7rdI6QUJahxCkSSNX5Dii
 XQ0HiiQzcVmOwtDaDj1JS1SpGmLuLIr/sVEm/MLQzlZmOWEsWSMFXV3GqDt7CYtCqeyd6U/xw+2
 xZyX4vu9fkQsGVP+LeakRTdgpJMLPsEvkiH3AB90UL32zhWPd4TzKFq1NlRuNg4xlsZBdZhxATX
 fhMoooWjwuctgyLwrR9g7VvperRffDlCOiMfYiwTFqd485Dhi/X0+3KN+4bwWbLFp/ueWkErRsp
 o2mSdNKSpNNUBW+w0afHmt70md8BweShcStAu5GEydfn7RVkPryIQkk3SbQi7IXVVRBfuL6Z0uQ
 1YKBgVs/GqAI0ckp8qd9z8NcUIu5WBIM0rqoNj91a2rChPSe0ef5qlIewuYuv6phhM/YLWVNkwn
 DIzYPMW+lM4GGEXIp3LyB0KEVKuElGGa9Kf6I0GQ1d3yLQ26cfXa+4Wg3N+Qnj7ycycoglCIJSo
 zW2ey7ZIbyFlZiVdvnR8krRa8rpCZvnNe+9yLzUi/qz1rXmQPxGMYKnvXmeCAe7b33a4ljsZGwL
 YsIB3+/rTqcW7PQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The INTR module for DMASS1 (CSI specific DMASS) is outside the currently
available ranges, as it starts at 0x4e400000. So fix the ranges property
to enable programming the interrupts correctly.

Fixes: 29075cc09f43 ("arm64: dts: ti: Introduce AM62P5 family of SoCs")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 84ffe7b9dcaf..4f22b5d9fb9f 100644
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


