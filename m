Return-Path: <linux-kernel+bounces-84722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D49386AABE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0706C289445
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0FF37143;
	Wed, 28 Feb 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhDwBDjq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4392D610;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110947; cv=none; b=W+LkQb25yEDNy/24PkqQ2VREV7k910/FrAffT4sl81DSAf/z5mRC2pSAh1QGb9GYR3U6CgJKBR4UoDDiWy3B+YwRJJnkl9a7zP1lIoSapjvVRAOA1OxO4eq8JwUf9Eo2l2/DPOr02RIwDNELpl/8Ejar2OsrdkHqHWR0tl7IZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110947; c=relaxed/simple;
	bh=vu47BKfN+xFcRDfbkn3C1v8zrm2ugq1RBZELrpt63GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s1PIG+i4Nao85xZoZI7bKsxzR5TTVoMXu4DlVAFKD1hF6bdVSMdfrXw1a0D8/VV8vQqAZbpvBozCoYijVtLH5Zks6JmnwI8NB5jHaM2lDHgR2DCw/X27AEtSGf0v+FS0W1UvGNNFp0M06PJnRFXdHh6P6S1D/rBqKa/On2IGwvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhDwBDjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B923DC43399;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709110946;
	bh=vu47BKfN+xFcRDfbkn3C1v8zrm2ugq1RBZELrpt63GU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YhDwBDjqPHjjmCBz+Pz6TXhKQ/v34FOjQ5G47iqDwww8/Dux63x/aN2naYaW8uX9l
	 6xBluAY86MiAun8IZWRhaS6DTt22bJcRSSP9O+PXSmFSKQcfKxoTWCBGFSMl1vBHpa
	 +cXP9/JA2mUgFCCcE4D4bzKw7HbVbpuGSZiooPDLi61QCojookTLYqh8/KUzdK2Hle
	 aBOYB2kf6MALwoEXZbzNLSuDVEf3ri3Pp8dnyodqSitDzFetXt3vf4egKHRWMycDhX
	 skGfSWH18152bDEQNVBvIzkrriMU7S0zXcDp2LWRQkTyzHdVZmT/EPHf4E3+yaeW5O
	 g1L+gH3F+DJBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A084CC54E55;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 28 Feb 2024 17:02:27 +0800
Subject: [PATCH net-next v6 03/11] net: mdio: hisi-femac: remove clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-net-v6-3-6d78d3d598c1@outlook.com>
References: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
In-Reply-To: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709110945; l=1802;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=kdWAr70dNlF5sryokQxZlrJGOk8Z9nw7ekwi0I/9miA=;
 b=4KDFlw8uRnWDCV0oL9YwdDB9rRXWJ5tNkYoGPZ0DDnSRRRi3doo95m4UkX3SRAuBbGy/HHmez
 A+8fIjxCDaZBfMWknwmofXIO+9PHMm/C/wMcqNclcXurcoFqgHK5OZy
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This integrated MDIO bus does not have a dedicated clock, remove it.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/mdio/mdio-hisi-femac.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/mdio/mdio-hisi-femac.c b/drivers/net/mdio/mdio-hisi-femac.c
index 6703f626ee83..faf4688eb1ab 100644
--- a/drivers/net/mdio/mdio-hisi-femac.c
+++ b/drivers/net/mdio/mdio-hisi-femac.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
  */
 
-#include <linux/clk.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -21,7 +20,6 @@
 #define BIT_WR_DATA_OFFSET	16
 
 struct hisi_femac_mdio_data {
-	struct clk *clk;
 	void __iomem *membase;
 };
 
@@ -93,26 +91,14 @@ static int hisi_femac_mdio_probe(struct platform_device *pdev)
 		goto err_out_free_mdiobus;
 	}
 
-	data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(data->clk)) {
-		ret = PTR_ERR(data->clk);
-		goto err_out_free_mdiobus;
-	}
-
-	ret = clk_prepare_enable(data->clk);
-	if (ret)
-		goto err_out_free_mdiobus;
-
 	ret = of_mdiobus_register(bus, np);
 	if (ret)
-		goto err_out_disable_clk;
+		goto err_out_free_mdiobus;
 
 	platform_set_drvdata(pdev, bus);
 
 	return 0;
 
-err_out_disable_clk:
-	clk_disable_unprepare(data->clk);
 err_out_free_mdiobus:
 	mdiobus_free(bus);
 	return ret;
@@ -121,10 +107,8 @@ static int hisi_femac_mdio_probe(struct platform_device *pdev)
 static void hisi_femac_mdio_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = platform_get_drvdata(pdev);
-	struct hisi_femac_mdio_data *data = bus->priv;
 
 	mdiobus_unregister(bus);
-	clk_disable_unprepare(data->clk);
 	mdiobus_free(bus);
 }
 

-- 
2.43.0


