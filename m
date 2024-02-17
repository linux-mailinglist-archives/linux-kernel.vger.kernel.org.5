Return-Path: <linux-kernel+bounces-69894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FB4858FEA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F6B1C20E4E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156EC7B3F8;
	Sat, 17 Feb 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT9Ie+1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D77AE67;
	Sat, 17 Feb 2024 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178572; cv=none; b=e7BXx/XlYmeMyBXiBd3eH8DGa1Zoi7CFl+G27PDK9o7mSEDnagGrhWthKLcMVWx5IirgTNTBenW89WFC5XI7vz7N2iEnYBGubeAZ9qPEbcp9ZraGmuPM0LtGWTMF+IdRe7Hhxrxr9kVbIafgpU3jFxA9rNGHeRl1zxcJIgzDykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178572; c=relaxed/simple;
	bh=esSfqR/EN2uGgQJhZInB3gQ5IgggyIpQkCwvAPI4KIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=anAfbsWuO/rwzOs1Uo8eLXURK2Yfnee/O6otb7zpezie784HVB0E1OSSFq9NKbaGDfV1hBhIXlEbEZgLbbgfRCtizgdK4mZJN+R9tGf4BGZDARjhzFjQm/kcQT6mJpXprsz1q1FX5GZeQFYpofIwqh1QDX/AH8sSNNfiOJQQksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT9Ie+1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E80FCC43394;
	Sat, 17 Feb 2024 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708178572;
	bh=esSfqR/EN2uGgQJhZInB3gQ5IgggyIpQkCwvAPI4KIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NT9Ie+1HH/Cgr/s1+RKuwi4xdU2skqzHG2qBu26n9RRbxJKVD0GbkXXWj02Q9Cufm
	 2rsDWa+ojQLiL++Wx4LVU8C0hsecTcFqnvfDl0xvfhUeK+Osf+uzlhMVMwA40chvoT
	 sjv7KVCWoqkOP4Io61j86460ohdsiKBV8twoMs7q8NjiU+nGXUcf7UvrdIQXr0999K
	 1T0VRlHtb0N/QtFCuQyAQ+VpiT3Q6unh5/DEzfH+y3A6BDB42ORWOBxIZ/Sq5/r8D/
	 1lz1augVyMGu1BYxj5M/46fKU6TmVJyBIqwsdpInRG1qwCw1HTWupQjkmzCbfQFW4U
	 ro2+byNGaLs2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF9EC48BC4;
	Sat, 17 Feb 2024 14:02:51 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 17 Feb 2024 22:02:46 +0800
Subject: [PATCH RFC v2 2/4] phy: hisilicon: hisi-inno-phy: enable clocks
 for every ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-inno-phy-v2-2-3bf7e87b0e9e@outlook.com>
References: <20240217-inno-phy-v2-0-3bf7e87b0e9e@outlook.com>
In-Reply-To: <20240217-inno-phy-v2-0-3bf7e87b0e9e@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Shawn Guo <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708178566; l=971;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=jGUbESXsyAvU27nkXjLoTOKtwqcjOT068eM8RNJCWfs=;
 b=UHXOSwwODhww8EbGOJMLYpPN9XmbFpLtbnFuU8Z5k/lZVtDRxNc8n70BZnZEw2b+WB9jx8etr
 bHvTFAnMpBTAaslzLl5OHfnpTvZcXqAT/TkBUYPvHBe5bCC3fvCPJwM
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This is needed for port1 to work.

Fixes: ba8b0ee81fbb ("phy: add inno-usb2-phy driver for hi3798cv200 SoC")
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index c138cd4807d6..b7e740eb4752 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -86,8 +86,10 @@ static void hisi_inno_phy_write_reg(struct hisi_inno_phy_priv *priv,
 
 static void hisi_inno_phy_setup(struct hisi_inno_phy_priv *priv)
 {
+	int i;
 	/* The phy clk is controlled by the port0 register 0x06. */
-	hisi_inno_phy_write_reg(priv, 0, 0x06, PHY_CLK_ENABLE);
+	for (i = 0; i < INNO_PHY_PORT_NUM; i++)
+		hisi_inno_phy_write_reg(priv, i, 0x06, PHY_CLK_ENABLE);
 	msleep(PHY_CLK_STABLE_TIME);
 }
 

-- 
2.43.0


