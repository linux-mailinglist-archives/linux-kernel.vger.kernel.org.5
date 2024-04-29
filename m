Return-Path: <linux-kernel+bounces-161823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAA68B51B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A595281470
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F67D11C85;
	Mon, 29 Apr 2024 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qfzt0Y9z"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CBD530;
	Mon, 29 Apr 2024 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714373104; cv=none; b=RMLrNEmreCBAeaeVqDQXYGqnyqd4zbETLY6bilmCjXVm6txuQqIfSgv0nKUZVHacO/MHTNDJFU+9FCNd6P6fnoZK46e/F7MvZt4g2rG/v9hIKdUW+GBf8+J5s/+2AUIMNDvq6PfgPYSIP9VrsJIaHlf0/u2jBRHWA0ug56ce/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714373104; c=relaxed/simple;
	bh=kf0Sp5Dag35+XC7rii10LELvFF8T9FtBCw/5i9WRxNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=q/55Wn24oWaqK3/GMieec2kX7petuxP2FhcLTNEiofnTrjXpH+XzPYs3RD7OaTAgJLsZ49GvlaCJsiWdiWqUxRpML5mVMLZMNeBOeGO5fTKP0OA9WxRkPFPc0KdMKT/mWJ87hWh3uOTJH4LIYxOQ9R4lXEDMfRLI+4vF5cJjEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qfzt0Y9z; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43T6isNS126903;
	Mon, 29 Apr 2024 01:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714373094;
	bh=aXfTQ3gdHYzn2quXzyz9Q/IIQTkniyIjZGbNelRlR7c=;
	h=From:Date:Subject:To:CC;
	b=Qfzt0Y9zzil6T+jQdZtcA09RpPoqjZXYDiV1NEjNyVwTlDilSX/zrztoWUAQlDMk4
	 ltO2jqlKAGXPZlm5x63jJJW1+sqQUPtlMjUTAqfFFimTuroPFPpxid3niMBV6PS7Du
	 r2h7CgJhwaaEVJwjusTKxWd4k34p5owGcJvLAFo4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43T6isve018071
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 01:44:54 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 01:44:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 01:44:54 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43T6irXU115567;
	Mon, 29 Apr 2024 01:44:53 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Mon, 29 Apr 2024 12:14:50 +0530
Subject: [PATCH v3] arm64: dts: ti: Fix csi2-dual-imx219 dtb names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240429-dtb_name_fix-v3-1-e13d58e744ef@ti.com>
X-B4-Tracking: v=1; b=H4sIAOFBL2YC/3WMQQ6CMBAAv0J6tqZdioAn/2EMadlF9gCYljQaw
 t8tHIwx8TiTzCwikGcK4pwtwlPkwNOYID9kou3teCfJmFiAAqMMFBJn14x2oKbjp8wLRdYZxMo
 6kZKHp6T33fWWuOcwT/6136Pe7J9R1FLLLkeFZalqR9Vl5mM7DWK7RPgu658SUmm06VzlSjgBf
 sp1Xd+SRN2L3wAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=kf0Sp5Dag35+XC7rii10LELvFF8T9FtBCw/5i9WRxNI=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmL0HjjsfLhxa8RRr9w6q9zGdqaT5WPhL8lOIdP
 PhbHdpw8V+JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZi9B4wAKCRBD3pH5JJpx
 RQ9mEACkC5MsQ33MYRr5pbcGnj+skj/PWFriGPqKIyGIGIb8Lj19tyzLZf5mQEB6lY3QOffshjw
 FZZpIQwMypuXwSxQZaYRwwe2o5ajbPQeDLXVyiiT4uXSbr2oY90KTXeLZQTZsmfWzPI5i/e3Lm/
 Wqr5I3MB5gYMlXduS3m23/cEz3nf5t0p5oe5hqgJp61L1lrILYc1lurSQGODy/0BcR6vvzx0ePJ
 DU020+n6cJGpUTl7PcjS6dYGBzFEl7M2yZ44ekpzrp7/UltPvZsVPHu/bqED12m2UOkslutbBIe
 YILS3yRYFCuvfsH9cYoQHVp9anVWVHLe0tBYjOAUq4+vvSaT76nmter/qf4/3evxJaKHTWJ+IRg
 SmZ+gx78Gx6jtObYOfo2jHoXZaXDExh4Q7qGemJPr1beTXctgwB1sqB4ncAF+kCbEp1QzADGI5T
 N7GUwxY3RfdUjSMLrN/k+7+L53pj7jsKeer0Q70RUhzCvRuTDMz4tanQ6hSM3+CGjb1XJhCWJZP
 BvxztQa8XhbglvZR59ncwO7MNJFZGcY6lRyhM+0ENQlf6Q11yXDQ0ZTnOBa341t2NK3wolq55t4
 FlJvxdeUkx9OGYbHBaW76nsutyJxb6rEWeFYRAnR9yJfOIZuDj/Y311c3AlCbE7Kwkuv4D6b9am
 fXSYxacpmjgs3FA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fix the output filenames of the combined device tree blobs generated by
applying *-csi2-dual-imx219-* overlays on the base dtbs during compile
test.

Fixes: f767eb918096 ("arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219")
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes in v3:
- Add missed R-by tag from Aradhya (apologies for the spam)
- Link to v2: https://lore.kernel.org/r/20240429-dtb_name_fix-v2-1-414fb8b7262d@ti.com

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


