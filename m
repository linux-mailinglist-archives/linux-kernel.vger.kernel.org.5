Return-Path: <linux-kernel+bounces-68863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C87858115
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2921C203B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D626130E2C;
	Fri, 16 Feb 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksU4hZnh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310712F58A;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096887; cv=none; b=l7aB08gyjgzYt/iNkLRnKmSdlQvb28P6EjxehXcMJ5uaRW7lP8uenA85a46wZuAAL/oFKw9DeVLB/5m2tHTs8f/J/oY/GkBg5hfbjaqyFmB4rYT+OvwCTHHikWy8wlI8BWnBcGvW0/PwtFfAmR4RXUzQmUwIn1Ppnzy7UQFv0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096887; c=relaxed/simple;
	bh=esSfqR/EN2uGgQJhZInB3gQ5IgggyIpQkCwvAPI4KIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFZLKt+OhgSGpVuokKlv0NR3wjiUpW4At2WiCfL7DsQB8mHhnfU8lMV5rV7rL8a8/4d1pAP22YGzP++F1vV9O5LQiHq1GQ9IZ32NuT7cKzLz5xEGADToCVXCXYdCyaS+O72JtB5Ui0q7zujmjQPknavwK6tzueXA0MT/Sa6Hzdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksU4hZnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D19AC43390;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708096887;
	bh=esSfqR/EN2uGgQJhZInB3gQ5IgggyIpQkCwvAPI4KIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ksU4hZnhGFY/DpaonfNqIcpv7UidugyR75F1sQOQNhkbyxnTCEOUOW5eq1CVXstPf
	 /bhZwdJThzwPWzyi6uwkEDiuo8SLUwUSDaGJ2x+1xQZcpLGndGox8zoRP6TZCJcmDq
	 oPwaSW5cElsGXj+mrWIuJYSBFBjia+XFr3IUHlSgmF/VezNJKNKiwHbczxKQjeOqKZ
	 /9k2DDFKD0/1W/3DFd/KuF/udubvA+GUrl+f9lMw7xvxZrIaTFU4dlmhjhHzsVGlvM
	 d7KCKu/bnu1VGvn4lu93z2NlumZQyvsRhFxkFv9EiigvME5tVYNu1erdAx4PiQqU9M
	 YL6+KZPvu8mHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453B0C48BEF;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 23:21:02 +0800
Subject: [PATCH RFC 2/4] phy: hisilicon: enable clocks for every ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-inno-phy-v1-2-1ab912f0533f@outlook.com>
References: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
In-Reply-To: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708096886; l=971;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=jGUbESXsyAvU27nkXjLoTOKtwqcjOT068eM8RNJCWfs=;
 b=ITanD2VY3jqLkr3V4AaluZ6h9nWHCdy3Na9jDZgUch40We/Y5Xqui1gOxijFrPIN7OP9s0KLu
 y967I7P63k6BFsOonwkTg3pWZVrf4mwUOvGffTMiP+h2VMI1SMATgVs
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


