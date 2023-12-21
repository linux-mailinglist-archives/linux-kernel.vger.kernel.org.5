Return-Path: <linux-kernel+bounces-8265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 422FE81B4B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC47F1F251AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1776ABBA;
	Thu, 21 Dec 2023 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dbb3N+HA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B56A02F;
	Thu, 21 Dec 2023 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLBAq1v122527;
	Thu, 21 Dec 2023 05:10:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703157052;
	bh=QmXACMYRAncvaes6ymYI0iABfyRzCf/v2jYHx0VjiXg=;
	h=From:To:CC:Subject:Date;
	b=Dbb3N+HAhf8TWCggogCK90QFBYwAIM7OvHkJ8UA01C+Y6LjjDgLKkYnsPzU1VhTi+
	 GP29/yHzIKYjyw6i73gGes6dbeRjlZbAjRo5vSetr8SfV8mEikD28+TlbkqOVWdBvx
	 djCgLf5r+L1uiRiCMIDafH+CIBcrhS3um4EsRYec=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLBAqQr049082
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 Dec 2023 05:10:52 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 05:10:52 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 05:10:52 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLBAp7d113056;
	Thu, 21 Dec 2023 05:10:52 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Grygorii Strashko
	<grygorii.strashko@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        "Siddharth
 Vadapalli" <s-vadapalli@ti.com>,
        Paolo Abeni <pabeni@redhat.com>, "Jakub
 Kicinski" <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Chintan Vankar
	<c-vankar@ti.com>
Subject: [RFC PATCH net-next] net: ethernet: ti: am65-cpsw-nuss: Enable SGMII mode for J784S4 CPSW9G
Date: Thu, 21 Dec 2023 16:40:46 +0530
Message-ID: <20231221111046.761843-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI's J784S4 SoC supports SGMII mode with CPSW9G instance of the CPSW
Ethernet Switch. Thus, enable it by adding SGMII mode to the
extra_modes member of the "j784s4_cpswxg_pdata" SoC data.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 7651f90f51f2..9aa5a6108521 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2855,7 +2855,8 @@ static const struct am65_cpsw_pdata j784s4_cpswxg_pdata = {
 	.quirks = 0,
 	.ale_dev_id = "am64-cpswxg",
 	.fdqring_mode = K3_RINGACC_RING_MODE_MESSAGE,
-	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_USXGMII),
+	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII) |
+		       BIT(PHY_INTERFACE_MODE_USXGMII),
 };
 
 static const struct of_device_id am65_cpsw_nuss_of_mtable[] = {
-- 
2.34.1


