Return-Path: <linux-kernel+bounces-161822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B07A8B51AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26C6281496
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084B211C94;
	Mon, 29 Apr 2024 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RbKjDzAy"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2DB6FCB;
	Mon, 29 Apr 2024 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714373022; cv=none; b=juN4RyDMO2L3vxay38aWM/vW4PGptWxcb6q0wSEizZI8hqlApbwOZjg0iLJBxRh9s7+AKGWPNOgd1AZrkNDSN1HIecUs2Uyols2U0EiP7EwMzg3wbbI8Djj4/kYLSrvl4ylQ15hKtS0N8s3iUMavdLn2Px3N/oiwpR7vexR/eNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714373022; c=relaxed/simple;
	bh=psJEy22jwq8Y18kYAIRWmDOUVlMgVgkTNZQ1GXlXfmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Qe10zdNAO79sMqLDh6CUQQCtkAfpAHgn6rmb3HQQJu9rE9riQEu2DmBaDFu0mgjcF0Kcwn883mxQ4NSgMkUTTeXjMgZHbhkY46gq2FulmXdRSCrmGIXumk8nsXqNpH0kOpag4bbpWnp+NZ7n+fr6tC8u9kPNG/ByBKZNR7eLHuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RbKjDzAy; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43T6hTpl086162;
	Mon, 29 Apr 2024 01:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714373009;
	bh=gPl/nvTiMdSBXoqhTZ3m0NHQYJor/Uk4933/zx9SBV4=;
	h=From:Date:Subject:To:CC;
	b=RbKjDzAyJ7yBcSIMMxTPimx3Vwe1gjMKEpzUZjmsN+fBo/CWmWWwP+20jU+LIxhrh
	 +wR76dVhtmiSd/3iTqBGn1M+kKZ+xXDaE6rx5EgbffbTCe32Tp/7z5CEqXbYE87vDL
	 pmt+b84e2yhAm6N6CXaPon7QV37E5A7RGSqEAIuk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43T6hSlp024736
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 01:43:29 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 01:43:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 01:43:28 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43T6hRWn064343;
	Mon, 29 Apr 2024 01:43:28 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Mon, 29 Apr 2024 12:13:24 +0530
Subject: [PATCH v2] arm64: dts: ti: Fix csi2-dual-imx219 dtb names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240429-dtb_name_fix-v2-1-414fb8b7262d@ti.com>
X-B4-Tracking: v=1; b=H4sIAItBL2YC/3WMQQ6DIBAAv2L2XBpAjLan/qMxBmStexAMENLG8
 PdS7z3OJDMHRAyEEe7NAQEzRfKugrw0MK/avZCRrQySS8WV7JhNZnJ6w2mhN2s7jtooawdtoCZ
 7wKrP3XOsvFJMPnzOexY/+2eUBRNsaS23fc9vBodHouvsNxhLKV8el/SbpQAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vaishnav
 Achath <vaishnav.a@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh
 Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=psJEy22jwq8Y18kYAIRWmDOUVlMgVgkTNZQ1GXlXfmA=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmL0GMOCPCcfmUI6lJxhezloH+8xJyOBpJKcGN8
 2tI4fzBntqJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZi9BjAAKCRBD3pH5JJpx
 RVWzEADSxv3Hh9Hw8BKn4OnYAiFX7yaVCTZNiGsakrbRcNUs/niL65qneLSZOPTnuONevHPfUPU
 qn9yLgVHqTvGvd+iYxCGvux/i5xEHz867m88x4mCncBZIqltYEdsMooJXwuQBKG0FvBjVZTneQ7
 eGvHzZIQFIeiRaUxfGb6hKFHRuqTY5mPjiWDIfiQfibq5jMvDApFDytXes1YojLRs7UyuCqgN5p
 UMUiUE3+VOQDLg0T/Qzi/HPtaNuPKJDOeMjKNviGFMSqTjlaei8U/uS06jeuCg7q6EOK3NNpNJK
 LzNESG3zF6hc8hIg9C6/lYEwYntWXvMdchGjhQM2l7RfWMUxpCju+wl9svMt25vh9JRGOWAooEl
 haobkmfFdUJMmgvQW6a01LPh09fkpAn2/u7vjT1ANiDiY/GR4e3K2HqTFoBHwBatRmmdpMyDVTY
 ebre3esuemi0bfdqAk/sHngxDPA4QWb5iYqJncS2ryvOvSaDJejQtF3gqsb2Mai8z6kl4yu9f7I
 JcqBHUFKg2PsSe5cWzTl0B6eylvwygLv2V3QVapR2GKqF2E8usDHcHi8UbSkg6AGDJNAflKiCnG
 0a6HsU4P+71JWywvbX4tXHlvxBQKykq3o7hUI8UuzzcAba1tknpphcWE1igqDEMuJdMHzZtktTl
 hHKD1PsEgPWeeLQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fix the output filenames of the combined device tree blobs generated by
applying *-csi2-dual-imx219-* overlays on the base dtbs during compile
test.

Fixes: f767eb918096 ("arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes in v2:
- Rebase to latest ti-k3-dts-next branch
- Link to v1: https://lore.kernel.org/r/20240425-dtb_name_fix-v1-1-f3d0d7709be8@ti.com
---
 arch/arm64/boot/dts/ti/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 48fb19a523bd..9c536d4902f4 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -170,10 +170,10 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am642-evm-icssg1-dualemac.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
-	k3-am68-sk-base-board-csi2-dual-imx219-dtbs \
-	k3-am69-sk-csi2-dual-imx219-dtbs \
+	k3-am68-sk-base-board-csi2-dual-imx219.dtb \
+	k3-am69-sk-csi2-dual-imx219.dtb \
 	k3-j721e-evm-pcie0-ep.dtb \
-	k3-j721e-sk-csi2-dual-imx219-dtbs \
+	k3-j721e-sk-csi2-dual-imx219.dtb \
 	k3-j721s2-evm-pcie1-ep.dtb \
 	k3-j784s4-evm-quad-port-eth-exp1.dtb \
 	k3-j784s4-evm-usxgmii-exp1-exp2.dtb

---
base-commit: 3454b58dd9d99e317871e9abd57f589ae7580642
change-id: 20240425-dtb_name_fix-350eab4dd8ab

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


