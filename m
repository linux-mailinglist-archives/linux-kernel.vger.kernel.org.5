Return-Path: <linux-kernel+bounces-76530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5733285F87C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A94282C82
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E9B132C23;
	Thu, 22 Feb 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZVO5Fte"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B75D12DD96;
	Thu, 22 Feb 2024 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605822; cv=none; b=I1Al92qMxDdFAqG7KFaueKGyU5rJBB+CA70y5VbtZ5QTt2/XpY/q6UsdzVlhfNDCYZsf9QD/OOaPyWUza+NZlw6RxidhUqRSRqcwk5tpAy18ffMu1ihiVg0UYQ5kx1aHIVue2awRAICTSRZj8WkNQT1WpZUv7zo+ijgynD9G4D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605822; c=relaxed/simple;
	bh=V1KomR4EYfJ5rWH5vbpqFhkkFyp2l4Yik0iVHegn1sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apMMy8djqxhy2h5P4R9VQvcD/78QL7R9UxWOi1Ea3RV4ktg2OaO+57022mcEtfe+/6O+rCIozVB//zATv4hoRSCjaKDUqiJE8tAL8gzgPnP+tRmUOwTNhhckq/q31tvmxUFOrAQEhfW4qWOXDzaYQTV1TmaBdXNCZqKz+ClkgfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZVO5Fte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE46AC433B1;
	Thu, 22 Feb 2024 12:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708605821;
	bh=V1KomR4EYfJ5rWH5vbpqFhkkFyp2l4Yik0iVHegn1sc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DZVO5FteyniSEsuQFid7EvprD5it4sZV7nS0TgN7Ss3ZtkgFK2yI/e9GP76Ad/Aja
	 S/uMbLeIm6JEc04UCzQEwRiEtGgsrntV+CVGeFWBNuzrvp20iGb1bF0OxWrKQy+2CB
	 VFhVTnzi6l6pR4mI8oUj0Wa4ILwCG1NhAmKhvWspmbkzQHUIjOKjqD5MxMv4JE1yVM
	 QGU4QLNdEH94NTkRAxzQO1qAIf6A5MuKLWggHi48FuAiONFmYsbzEgGioxgVaXM0au
	 eUVk4weMiYCqCkPQHSlnm+3sYgmxXuoK4c6RuQg20T3EGHq0549ULUbOmJm/KfrCJl
	 BbeoJzPax7CyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB88C54798;
	Thu, 22 Feb 2024 12:43:41 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 22 Feb 2024 20:43:22 +0800
Subject: [PATCH net-next v4 2/6] net: mdio: hisi-femac: make clock optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-net-v4-2-eea68f93f090@outlook.com>
References: <20240222-net-v4-0-eea68f93f090@outlook.com>
In-Reply-To: <20240222-net-v4-0-eea68f93f090@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708605802; l=720;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=RxVNNMcUcOL8zwGYeNVp22tshMMwMwhDPBBRMx/bOA4=;
 b=1c9dFQmaUoe8pYc+8UA7JNdtR9Upmnvh5R0mJamXsLrTU2F9PMlNqiN/8AASZ0TCUfB2qU/v7
 j5ea6kccwz4AWFpQwwgxagmjlSrEfvdLJNm83pqxOHOEnqqC2iUFLNU
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


