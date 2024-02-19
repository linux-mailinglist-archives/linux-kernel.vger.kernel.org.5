Return-Path: <linux-kernel+bounces-72000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7641F85ADAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CBD282980
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7010D54F90;
	Mon, 19 Feb 2024 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbPciEzK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E85025C;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378079; cv=none; b=hX22QpZFU8siKAt94sCvv0P+1TXCThkTTZ2BpnOBQqH7U14x6Dqs7ys6I0lar0UZUTwhNFijBSQUETH1D5HrrLvdZnwJgfc4MMwSebGPQ30U4v5gPDmivJL17Hwqp6YWXCV4WcSbFaC1PNx2rsKn1Hto6bbg7K3WWq1C8492EGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378079; c=relaxed/simple;
	bh=esSfqR/EN2uGgQJhZInB3gQ5IgggyIpQkCwvAPI4KIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OnW/p7JuEVI3mR15eT728RqoiR95af8/oOD/mVcqQFIWs2nPYaokRSQw+jLfIhUCYC5cse+8T9FB+usHqnAdCInPdaYx2rKyhP68D6QoiWOoO+bAQKJQfrjO0jRVVj1tPqYdgbL7+iuuDXa6khJ0NiyediDRyIwgfLij2+1z228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbPciEzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58CAFC433A6;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708378079;
	bh=esSfqR/EN2uGgQJhZInB3gQ5IgggyIpQkCwvAPI4KIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YbPciEzKQMYE7noRsTetjNj3S9+k7Ik1GeacWOOuS+ThMtoaO1ZkflWACao+7rYih
	 gCHfwLLmHNN/b/6Ycu7whZhRHunuj5/m+hk0VxA6ClSAsqb9hwclvPSlBly+QPqG38
	 72KrvgDKyBiBzzbiUSeeaErXXsllCTohfyAq4+oW+JbAw+LmZlVvDe4aHvyVZn/QV4
	 sVsocx6VN0a+cYLAA4RfUOm6eu6f1QhMUSrTVRjLZDnTnn95k2+89H9npeFfBydnzY
	 xmqvx0EC4HkrIEiFdQOpBe39nsrMEI/tbY97N4j0XKAhqMlxOfOwIDtxhxNFsscDyv
	 87YumtHsIvzxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3594DC5478A;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Feb 2024 05:28:00 +0800
Subject: [PATCH RFC v3 3/5] phy: hisilicon: hisi-inno-phy: enable clocks
 for every ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-inno-phy-v3-3-893cdf8633b4@outlook.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
In-Reply-To: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708378078; l=971;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=jGUbESXsyAvU27nkXjLoTOKtwqcjOT068eM8RNJCWfs=;
 b=zs3Pye2H9yxnBHI/KFOaUXuqr2aivy0VIlFkP7na/Xbw3rIoaMubBcpeDNsVhE3207LPYz72J
 c2VRW0Hg+5MCQr8XwdaAjcx1MiDv9f2A/+Fv+yagKFNF/ujcU467b1S
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


