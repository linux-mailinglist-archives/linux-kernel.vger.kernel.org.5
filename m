Return-Path: <linux-kernel+bounces-153367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C038ACD32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1D71C20A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC7C14F9F5;
	Mon, 22 Apr 2024 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HuLAXIjL"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3637A14F9DF;
	Mon, 22 Apr 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789937; cv=none; b=OZy91iGdIKnd2voNLQSbazYVjmOpD48cOYVV0/TfcwETrM/oli9N2sc6zwOqRJYos/r+3YimxvU1JCnaXGH4Tlh5ypU3WUKozxAuj4sEo20Cxq7p2hJleYuUi2n9FXMLt3NpqB+1D4p6p/Z21Nqkvxx7N3wMGEfR+Pv2SScEBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789937; c=relaxed/simple;
	bh=tEH78XBPBsQYvQQOOnNYvIjBBy52gko0P2Kv0tpiHZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pyGf2lDM4paijiNQIgO+soeBk5T/wppLt9AJr+r4jOdeca1oDZ8JxRWKn1czlynY6OXWZZmjXm97tRGr00vbxyi9Doiap8N9BsW4MKx/UsUyYK9bFdLm/gVEhpvtxvZNck4Ka1D7cZRxA6PopI4lW/2km/78N+umJlNSf1AjOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HuLAXIjL; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43MCjIXN026642;
	Mon, 22 Apr 2024 07:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713789918;
	bh=0QmxLrkimtptQPll3jysQXKo8ee+qL2NGBb1Scl3kBg=;
	h=From:To:CC:Subject:Date;
	b=HuLAXIjLaWauusSRGgJtwmeq0rhYmy/7LdRibVgEru4t42L8tm8PafTQdi0k8f6ER
	 QGMUrh57ktrxKBJ2p+HenYmho9ZGvXsuh4YbK4f1sDWnfo5/89ZzN5+GLYX5dUcInl
	 fFYGrhYTTjm2PU9+zBFQQG0SF9+7tXUQeh0WP7Ew=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43MCjIAK065786
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Apr 2024 07:45:18 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Apr 2024 07:45:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Apr 2024 07:45:17 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43MCjHhE009598;
	Mon, 22 Apr 2024 07:45:17 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Ronald Wahl <ronald.wahl@raritan.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <s-vadapalli@ti.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Chintan Vankar
	<c-vankar@ti.com>
Subject: [PATCH net-next v2] net: ethernet: ti: am65-cpsw-nuss: Enable SGMII mode for J784S4 CPSW9G
Date: Mon, 22 Apr 2024 18:15:15 +0530
Message-ID: <20240422124515.887511-1-c-vankar@ti.com>
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

Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on net-next tagged v6.9-rc4.

Link to v1:
https://lore.kernel.org/all/20231221111046.761843-1-c-vankar@ti.com/

Changes from v1 to v2:
- Removed RFC from subject prefix as suggested by Roger.
- Collected Reviewed-by tag from Roger Quadros.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 2939a21ca74f..766abb571267 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2904,7 +2904,8 @@ static const struct am65_cpsw_pdata j784s4_cpswxg_pdata = {
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


