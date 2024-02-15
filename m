Return-Path: <linux-kernel+bounces-67856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238458571E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5527E1C21056
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419A81487FE;
	Thu, 15 Feb 2024 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjV5lrI+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C7145FF7;
	Thu, 15 Feb 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040933; cv=none; b=SODQ+330RXP8SqpC+HvLxJ4XUQW7GGWJZOAMg8eoZ3e/iwlSQUxqfrDwD42K5sSdsd/efBsbZWw4HUvMf8o8IYikFLac/FCVUhLA83oEdWdGthA1QRnxtgGsI9O8HxG37nj/V65v0oTdwM3/NQFMpkREGcCgPrP088VVkXCVuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040933; c=relaxed/simple;
	bh=7qpxZXKNb+gP/tnwm1MPhxnNC2V6cxuGt+MDwFekHBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MfPpamaMVmOGNijzsi1ZVpEv5s3iMQ3e1Z9iTEazgayzoBUGgFDvrsKPlnr2DZyd1UCpTdRH9q6p/00a8ff56J/GQGzYS3BzO07aLB6V9HgMITt5hPY/aKKjO/wR8yAgOv7IDWHJyHLbzMov4I9gKmNb2+6Aitdjz5tU8DT877w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjV5lrI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F225DC43143;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708040933;
	bh=7qpxZXKNb+gP/tnwm1MPhxnNC2V6cxuGt+MDwFekHBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EjV5lrI+Nbo8KQHsgSYFmIm919LPAnRjnY/Lb7bl9Sm4i5kCpANSQMqQKKhiLklag
	 6oGFCUd+x0IoSzrlo7VsZnCd2NiArO5q0tj+RqsKDBb4OFBlYfl6Cbk1Oxyu+GBEQx
	 q9Y5jyLoRw9p+CdLx749kikZxpQ4MxQH9ZK0QSmTTp7NZwna+/VKoIjrb7WStoEW6k
	 ReLMP4nNUSjS69MeHe6Kk0r+eqRk58+0Tq61qWXL5Wp9yXU9MDgOPwLiWk1m3kKPyz
	 24UMPvaGdzN/N7cJebc03jSvUQrNNQDsAGvmtXCwsBaRMGQ+ab0NHJf7ExYeqRd2rX
	 UvmtHG3MSPe+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF464C48BF3;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 07:48:57 +0800
Subject: [PATCH 5/6] net: mdio: hisi-femac: make clock optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-net-v1-5-e0ad972cda99@outlook.com>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
In-Reply-To: <20240216-net-v1-0-e0ad972cda99@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708040932; l=720;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=CtG+9hi3qtkcoLBxP9QyjEY1uFXvU0ZodPoAkWSo5gY=;
 b=QYzvW4P72cPyxM2AbyfFSJt2FcuisIbXKazfDqJmZjikuu0+PGGVfGoZIQp9ItG0BfwcVzdZi
 zTb/uLSG2FlAsq98RLH7FSW6dh0A+HZLyd1VlGAeE4umBRxqA2QYOY+
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@foxmail.com>

The clocks are optional.

Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
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


