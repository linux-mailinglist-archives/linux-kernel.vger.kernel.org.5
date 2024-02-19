Return-Path: <linux-kernel+bounces-71927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDCF85ACA3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11CE1F21988
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBBA53819;
	Mon, 19 Feb 2024 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIYYv6fO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E5151C47;
	Mon, 19 Feb 2024 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372657; cv=none; b=kXVhJ5yuM3IAEef6kz2IRymzqDHA7AHYBQIvObpFCadGm68WQPtKb0upLZxXoSRFNPbfnvKV5IwtKvFqa5LXnWgAA75X7/CJ7iFKfQNqAvF9CRbr7JiOWqxRpUMdfSW6cIzq+ucOKSK2nWDw1Qw7ZqWmtU3BCCD8pOJdtJueeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372657; c=relaxed/simple;
	bh=V1KomR4EYfJ5rWH5vbpqFhkkFyp2l4Yik0iVHegn1sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mHaF6TVNAIzo3SNgmoZHipgvAHUQde841jDfr7VpQqnuEjMPe8h1IF2HKBk3/3unMvRDHyva78dYSBl6gPn0FaPc//kxBAAdBEV8jscGVC3s0vyVFF+fvUyJs27pjKSRf44TQKT5Pq02UEeCZkqAPXGuSqT9RxzsyJlaI27QyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIYYv6fO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7386C433C7;
	Mon, 19 Feb 2024 19:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708372656;
	bh=V1KomR4EYfJ5rWH5vbpqFhkkFyp2l4Yik0iVHegn1sc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NIYYv6fOX7C78iccCoMfSOyFTYYaY9v8MlsvSNNCjF61+D57pLTMNJenR5Wlzz+oh
	 xX0KjmmRcpzkZs41qVidP2qfTilYN+/gr4wDBJ3QdpMF0B8pc27pqhO7yOxj4bnznv
	 ZzG3QfW6yf8CjLBSHjFhJBr4wexskuJTxfBLiihPtTp/kx3eTJQJXqe5Cbua9jEd46
	 b8c7Ug3a+S66cePO3Fvpyt+FkqOQcR+2OtmjMDTAuzT0sr/AnQP/4ypl9XN1nWCSNA
	 vhwchxxyOSntWskNEWsLEV0DX8ucMdcWep3Y9kWeUX34JB5jSSDtlYm5q5KXfx3cyC
	 8BIYovOBuDRBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1C0C54788;
	Mon, 19 Feb 2024 19:57:36 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Feb 2024 03:57:36 +0800
Subject: [PATCH net-next v3 1/6] net: mdio: hisi-femac: make clock optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-net-v3-1-b68e5b75e765@outlook.com>
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
In-Reply-To: <20240220-net-v3-0-b68e5b75e765@outlook.com>
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708372656; l=720;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=RxVNNMcUcOL8zwGYeNVp22tshMMwMwhDPBBRMx/bOA4=;
 b=QWnp8vXIvEWNQsFkYpybTyS4CueV5P2ocmQp+rpM8gO/MOJ7eUrbcJ7WOKB/E6zOZoJRTGhvC
 k7ZhNuV9xxjAdXlEfVk9tD3gFbUtvtZSwi27S8xqJ2cgUP0CKSYT57b
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


