Return-Path: <linux-kernel+bounces-68406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE668579CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82AB1F22E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6643C208D7;
	Fri, 16 Feb 2024 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vnf2FYTp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB21CA9F;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077722; cv=none; b=XA6LUS2aKKXEdEv0c5CDx7KnrjCtqbi9aEBbAvHMqn3HdGavqQoRu/YAEnSSmOoNjBXoEP3FinrP3k7nwpuY3a0m6GnuQ30CiYr24yKT4s12Xu2sbF2HL0+yIIjlrcLtO5G5D4PxvY7o/Je6FMO5l4z5fflrdayv96mJnb4sd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077722; c=relaxed/simple;
	bh=V1KomR4EYfJ5rWH5vbpqFhkkFyp2l4Yik0iVHegn1sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4IaawE+irG1gob9Xrc37NEP4apl8MO7gUJnluUtgyho/mlvCC9I88JMHnbAbw32WxOtXPhY/inyjYkb1DWrJAAbf1S4LuJkbqxOXGwp/26SN17X+9K2Fe0LKmpYp5JtbO9wJmEzbsW/iqdmqF/8Z3yjlkG9mxtBuImvD4gyarg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vnf2FYTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B385C43143;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077722;
	bh=V1KomR4EYfJ5rWH5vbpqFhkkFyp2l4Yik0iVHegn1sc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Vnf2FYTppXare9qZW9Fa7N2FkHqUy5VMiaVAIGUR5Ap5YC9kIegHbuYvF9fdgnNWW
	 h2455fIN9XqdNVtYLpx3pMdgMs+FRDvMlJqgKWiLv4eq6hT06IO4Ww8u0qanMgDRcp
	 bWwLgalJoR73943FM49Ra3bQLFNmxbwiUfr58bTuEVsmxd/lZbJ7LX1nj3pdlv4E+m
	 LMD0mHTT8KMNo1qHwqVRetzA3Sd8qCQBLR1Pi+X7NN0W7PMYWKBly/L+q92diUamB5
	 bAHyXKATxv8jNtZb8KNb28dqr1yJ2WUE4xnkw7qT+PkgzWY32Sr93ORSqsTsjPT8I5
	 me4DiL6Rfmpsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E22CC48BF6;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 18:02:04 +0800
Subject: [PATCH v2 5/6] net: mdio: hisi-femac: make clock optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-net-v2-5-89bd4b7065c2@outlook.com>
References: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
In-Reply-To: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708077720; l=720;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=RxVNNMcUcOL8zwGYeNVp22tshMMwMwhDPBBRMx/bOA4=;
 b=9eCC9W//0cVI7pQh1Qd1bqXLtsJJgDIAuLm9kVPr8VDZ00nacm6U5wPONG3hgSRXy4dgDqyFx
 Oqq9x9oJN5OCT7FqpW5ViVbi/3jxG5xRmR2FTALIoIHuPY91E1sa1Tt
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The clocks are optional.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/mdio/mdio-hisi-femac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-hisi-femac.c b/drivers/net/mdio/mdio-hisi-femac.c
index 6703f626ee83..a2620b200381 100644
--- a/drivers/net/mdio/mdio-hisi-femac.c
+++ b/drivers/net/mdio/mdio-hisi-femac.c
@@ -93,7 +93,7 @@ static int hisi_femac_mdio_probe(struct platform_device *pdev)
 		goto err_out_free_mdiobus;
 	}
 
-	data->clk = devm_clk_get(&pdev->dev, NULL);
+	data->clk = devm_clk_get_optional(&pdev->dev, NULL);
 	if (IS_ERR(data->clk)) {
 		ret = PTR_ERR(data->clk);
 		goto err_out_free_mdiobus;

-- 
2.43.0


