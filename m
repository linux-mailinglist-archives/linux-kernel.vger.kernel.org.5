Return-Path: <linux-kernel+bounces-124557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536408919E6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0889B1F23258
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1851509AA;
	Fri, 29 Mar 2024 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P684yqp7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3549F9E5;
	Fri, 29 Mar 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715408; cv=none; b=TrBZazCQbidz+VCvd9eZlg14ejzGyEdSZ6vU/IE/a/a3mSu20+2GaKKB4Ehm+1fmcoc6EwakRNLml3nXBCFDceag9b0m5pdQnvFUpNs3sILfToiCj76rIovkQ5hmLwFHbDS3wVXdF2t2dRfAwiZG6mtf/Vo9WfJZXBYOCf/yUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715408; c=relaxed/simple;
	bh=0xMwJ9TvgJBDEoufIBeFLKxqxfdrL1JbYItPbCYjdNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8+XJCibOpwFiipUxm2zEylm/800AUva9/3DDJkICJTSwVUl39lcc+gj3PyfDCvU2kJg7KsO7EeIbzGDuGmNbbcFynFLGtzSefPuCdv9jczaeU7GmV9tE8JFH6mvD01ySmJuvHiQS0rg9VUcYBuysieSZUsR7gTLtzrLy2YVYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P684yqp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98443C43399;
	Fri, 29 Mar 2024 12:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715407;
	bh=0xMwJ9TvgJBDEoufIBeFLKxqxfdrL1JbYItPbCYjdNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P684yqp7C9IPRpW9hjCvauTTmQbJet/J7YywsD8rkmmijHF2zUr5FcCxHvgKmRgBM
	 RNdyNpbnQ7ywmw8tKyQ0se860xDSmGvpk40nzdfy+IqydYCd9eGWChEu+atJhKsXDS
	 VXGhxLgfbZ+0ESN5rDpBkLHAjLz7AXXwe7Opm1kq7KTLZNl0XXe8D4m4xDpmA1ISuK
	 79pTNNvNz17BBuqiYLB9DZI4GgL2DurDLs3MYbA6IbmyRelhRobb5Lz03QxvIADtyA
	 08IFs/WU9RmOmaPIANXWD7PD/1yjh+9TMkSvDw5xAOC+WX7BAztpMydgs0A54j+t/B
	 m4CSvQT7acDaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andre Werner <andre.werner@systec-electronic.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/52] net: phy: phy_device: Prevent nullptr exceptions on ISR
Date: Fri, 29 Mar 2024 08:28:37 -0400
Message-ID: <20240329122956.3083859-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Andre Werner <andre.werner@systec-electronic.com>

[ Upstream commit 61c81872815f46006982bb80460c0c80a949b35b ]

If phydev->irq is set unconditionally, check
for valid interrupt handler or fall back to polling mode to prevent
nullptr exceptions in interrupt service routine.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20240129135734.18975-2-andre.werner@systec-electronic.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index a42df2c1bd043..c544d3576c2f9 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1411,6 +1411,11 @@ int phy_sfp_probe(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_sfp_probe);
 
+static bool phy_drv_supports_irq(struct phy_driver *phydrv)
+{
+	return phydrv->config_intr && phydrv->handle_interrupt;
+}
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device pointer
  * @dev: network device to attach
@@ -1525,6 +1530,9 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	if (phydev->dev_flags & PHY_F_NO_IRQ)
 		phydev->irq = PHY_POLL;
 
+	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))
+		phydev->irq = PHY_POLL;
+
 	/* Port is set to PORT_TP by default and the actual PHY driver will set
 	 * it to different value depending on the PHY configuration. If we have
 	 * the generic PHY driver we can't figure it out, thus set the old
@@ -2987,11 +2995,6 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 }
 EXPORT_SYMBOL(phy_get_internal_delay);
 
-static bool phy_drv_supports_irq(struct phy_driver *phydrv)
-{
-	return phydrv->config_intr && phydrv->handle_interrupt;
-}
-
 static int phy_led_set_brightness(struct led_classdev *led_cdev,
 				  enum led_brightness value)
 {
-- 
2.43.0


