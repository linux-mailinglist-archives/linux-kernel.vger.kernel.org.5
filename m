Return-Path: <linux-kernel+bounces-8200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB0481B38D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A20C286FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65295275A;
	Thu, 21 Dec 2023 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GP0l4ope"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB079524BA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLAUDlJ112064;
	Thu, 21 Dec 2023 04:30:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703154613;
	bh=FV2RhUD9SV7SdTWfY8qp4/5H5gSClJNwlc4iyQYL4y8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GP0l4opeE0TY7YZxiMxyUovZ7rJ5at0Qfb4HhLnC3wvEFzvANT4afVo2ziCiQamuD
	 m5QMhAniQh5SzAKvLWp4nFs7/pbY73UlYYqrvS1JpYrqDbmnpSKlTGRBYU+oENDf/O
	 l+xXYczOuK+aVlwZi/UM9IkqTcebMDrVkdrJjvbQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLAUDaR030054
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 Dec 2023 04:30:13 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 04:30:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 04:30:13 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLAUCqW087744;
	Thu, 21 Dec 2023 04:30:12 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>,
        Sinthu Raja <sinthu.raja@ti.com>, Chintan
 Vankar <c-vankar@ti.com>,
        Andrew Davis <afd@ti.com>, Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Kishon Vijay Abraham
 I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [RFC PATCH 2/2] phy: ti: j721e-wiz: Add SGMII support in WIZ driver for J784S4
Date: Thu, 21 Dec 2023 15:59:56 +0530
Message-ID: <20231221102956.754617-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221102956.754617-1-c-vankar@ti.com>
References: <20231221102956.754617-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Enable full rate divider configuration support for J784S4_WIZ_10G
for SGMII.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index fc3cd98c60ff..00d7e6a6de03 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1240,6 +1240,7 @@ static int wiz_phy_fullrt_div(struct wiz *wiz, int lane)
 	case J721E_WIZ_10G:
 	case J7200_WIZ_10G:
 	case J721S2_WIZ_10G:
+	case J784S4_WIZ_10G:
 		if (wiz->lane_phy_type[lane] == PHY_TYPE_SGMII)
 			return regmap_field_write(wiz->p0_fullrt_div[lane], 0x2);
 		break;
-- 
2.34.1


