Return-Path: <linux-kernel+bounces-95585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA73874FD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EFD1F21FC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2D812C7E6;
	Thu,  7 Mar 2024 13:20:36 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997EB12C52D;
	Thu,  7 Mar 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817636; cv=none; b=MFneFFAtwAxX3ryjrUTBcjY3VyZJGk0XGwJHqC3rJUele1zr7+EMWG7gV3CQ6mkeUqjbQnojRzlYvb+kEHayZbeXWkTW9bfDYplhfZQmcxKMoOR6WabTZ7w6LiEnOu3aZ6/7IV5dpON1mEK4m+qwEGOdQomT9uTyZjPDkSkba8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817636; c=relaxed/simple;
	bh=p0S6TKLtZr54QKpjwWO7mH2N9msbPcid8zVNvisldXE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j/QyVidGnbu/NAODMMrdPMtv461xBJB2Kkre7LhEcJGNSK9xmSutcdPyBsP3m0aiWgIgWyyZm+fy4q0EdMmNBuHlPDMpZGqssKrTW31jSE8A24QuiBWnDjx2iEeAXukkFmHNXRC2q0rZVqr2cc8Uo46/RFCEDlolQE/49z8PN5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Doug Berger <opendmb@gmail.com>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] net: phy: mdio-bcm-unimac: Cast denominator to unsigned long to avoid overflow
Date: Thu, 7 Mar 2024 16:19:47 +0300
Message-ID: <20240307131947.13133-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-01.aladdin.ru (192.168.1.101) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

The expression priv->clk_freq * 2 can lead to overflow that will cause
a division by zero. So, let's cast it to unsigned long to avoid it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b78ac6ecd1b6 ("net: phy: mdio-bcm-unimac: Allow configuring MDIO clock divider")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/net/mdio/mdio-bcm-unimac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index 68f8ee0ec8ba..055102e6bb6d 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -192,7 +192,7 @@ static void unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
 	else
 		rate = clk_get_rate(priv->clk);
 
-	div = (rate / (2 * priv->clk_freq)) - 1;
+	div = (rate / (2 * (unsigned long)priv->clk_freq)) - 1;
 	if (div & ~MDIO_CLK_DIV_MASK) {
 		pr_warn("Incorrect MDIO clock frequency, ignoring\n");
 		return;
-- 
2.25.1


