Return-Path: <linux-kernel+bounces-163801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A94FF8B7121
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF2E2859BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B18912D209;
	Tue, 30 Apr 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FfjW7v5q"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5F417592;
	Tue, 30 Apr 2024 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474386; cv=none; b=fdde+QbrAzTqghokvZKGAjP/jAHgAARaTm8PnKVKqNdRwrgqf93hHnt3UeXtj95jPuO3az/xHRfqCuqp1EFN83MQH7HaU9oTGiIea2eIOTgWgNZfXGo48FxXRnzxpQYCOUerxFriBdjzgEGU7In4+3x0QmFyIk/qmjnp2l+zdGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474386; c=relaxed/simple;
	bh=oc5PXpqQttdmNo3rvLB5A+gMBNzjmREYCrVPYRN+OmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBRpupqV0oT+KEj/nS71iL+ZLSir8Gw6HmjOOhQgCwIUA0tlEGj2I6V1cHVchf2Bc+yGXGnR7tXKDHu8I/T8UbEh/cK8SDkjglk+wZjSFDUjLg4I2Xwr9msajExPVW4dC8wGYOzk8aPMD3a3N9Nbsi9AIt5Fxq4s/jdxfNR8jkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FfjW7v5q; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UAqu6S114670;
	Tue, 30 Apr 2024 05:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714474376;
	bh=bLyCuP9NMqmjrF4J4NnEqd5Ng7UExXTDYUhQx03zEhc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FfjW7v5qijitvpQSHSStW+ze2SpiMUws29BnN9Y7vq6NbmxUCNhFeDQxZI0JGh0FW
	 +1fnp4RaJzuBKFB6yt5GKWdowPBwvZiY89x9x9wV0YodXaqsnmyZjpsXeINHmsOvrJ
	 2HbOLTT0/z6dUrL3+RBKZcb6pBDIyT9q4Beet/Yo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UAquIJ031385
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 05:52:56 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 05:52:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 05:52:56 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.115])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UAqtAw055715;
	Tue, 30 Apr 2024 05:52:55 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>,
        <devicetree@vger.kernel.org>, <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 1/3] arm64: dts: ti: k3-am62-main: Fix the reg-range for main_pktdma
Date: Tue, 30 Apr 2024 16:22:51 +0530
Message-ID: <20240430105253.203750-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430105253.203750-1-j-choudhary@ti.com>
References: <20240430105253.203750-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

For main_pktdma node, the TX Channel Realtime Register region 'tchanrt'
is 128KB and Ring Realtime Register region 'ringrt' is 2MB as shown in
memory map in the TRM[0] (Table 2-1).
So fix ranges for those register regions.

[0]: <https://www.ti.com/lit/pdf/spruiv7>

Fixes: c37c58fdeb8a ("arm64: dts: ti: k3-am62: Add more peripheral nodes")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 448a59dc53a7..0f2722c4bcc3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -141,8 +141,8 @@ main_pktdma: dma-controller@485c0000 {
 			compatible = "ti,am64-dmss-pktdma";
 			reg = <0x00 0x485c0000 0x00 0x100>,
 			      <0x00 0x4a800000 0x00 0x20000>,
-			      <0x00 0x4aa00000 0x00 0x40000>,
-			      <0x00 0x4b800000 0x00 0x400000>,
+			      <0x00 0x4aa00000 0x00 0x20000>,
+			      <0x00 0x4b800000 0x00 0x200000>,
 			      <0x00 0x485e0000 0x00 0x10000>,
 			      <0x00 0x484a0000 0x00 0x2000>,
 			      <0x00 0x484c0000 0x00 0x2000>,
-- 
2.25.1


