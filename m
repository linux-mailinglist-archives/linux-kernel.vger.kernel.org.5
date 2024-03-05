Return-Path: <linux-kernel+bounces-92441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE36872039
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 776F9B26BC7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BCC86628;
	Tue,  5 Mar 2024 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy+Dkvs3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43D85920;
	Tue,  5 Mar 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645536; cv=none; b=augqiKaPLVXnIReK5UzpYDh8lVZOmwIDEkXpQFO/poUgo1+HMfdhOFPXMmfvUmrxW6Q72Bjbf67cT1exVldiuaVS5IH9Ov6sLCgcflpk6Q8QZuhpjujqqdJY6qs3U4KUls+WFIvSKyied6iYer0eq1g0tJwxYAjF1ktkCyaQzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645536; c=relaxed/simple;
	bh=esSfqR/EN2uGgQJhZInB3gQ5IgggyIpQkCwvAPI4KIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mloBNOaEVZ25ZX2rN4EHRnCBGZ6ywtnwq0UcyWtGbajJytRULQfFbe/33wZ1jAifCdgjL/N2sj9zFNWmoP/qLdznC6G+aWTpJU4dgqmJHqcV+YaeucJ5bmQg9BLFErk83HG46owE0Dq5o8+IhBbnS2kmYxjiKLrOu7L1mH7Ndms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cy+Dkvs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9702C433C7;
	Tue,  5 Mar 2024 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709645535;
	bh=esSfqR/EN2uGgQJhZInB3gQ5IgggyIpQkCwvAPI4KIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Cy+Dkvs3AUK003lAX1XA2Tm5K5lMTlK72LOSkm0x0mpV84Jip7Lgmv3wrTMKXjnlL
	 U0efQ8gUG3yCPVTc2Cxpx5pCrjg6fCk2KEDne9UhJ1Ovi/Gq75JXcTK2+GbOEuQRBi
	 yomYaiWuWq9utas1Ub2+L0RwzHqdoPRmazUGHs0hyTVacl87djBzrkPezmLbPisaEC
	 g/UHtJDpUksgTgdSyj8KO+wRUgZXJmSbDeR3qxmD2S/YHk4a2l2sHvrcLZ4AR9IF+Z
	 ygwXAwRshk+7KxbtgiDsrB1N+QKPVInSqt8cfNoBfYDVqGzqyMu5uxnsffvdPnTTW5
	 KPqL/5iZvmaNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AB1C54E49;
	Tue,  5 Mar 2024 13:32:15 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 05 Mar 2024 21:32:12 +0800
Subject: [PATCH v5 1/5] phy: hisilicon: hisi-inno-phy: enable clocks for
 every ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-inno-phy-v5-1-dc1cb130ea08@outlook.com>
References: <20240305-inno-phy-v5-0-dc1cb130ea08@outlook.com>
In-Reply-To: <20240305-inno-phy-v5-0-dc1cb130ea08@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709645533; l=971;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=jGUbESXsyAvU27nkXjLoTOKtwqcjOT068eM8RNJCWfs=;
 b=HPJ5ck0MlMZNGEmcLKzPz9CIqfO7rL3sKI59I3rFgOAsz0Fpfqj3r4qB5h9RDN5C7XGwYNkvH
 Y449p9GY2fVBevg2VPT9H4W2fjNMDrjPlZ8Qa5GMzekCMWRNOoJRL5i
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


