Return-Path: <linux-kernel+bounces-124489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2948918D1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F931F24BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355D12FB01;
	Fri, 29 Mar 2024 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfdTHl3C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7013B784;
	Fri, 29 Mar 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715227; cv=none; b=cyQ6Odf0HNhNFv6iiKhcOOWTAlGEj+mAo5BpboiNYm09L9DDPpMpqG/sdV2kkumLoZKO1T7TL/8zEYemzmzRGWhy7ssncbjQWCwb+t6cRDufRBdgH/Az6oVW/2h4m8tiYAHsAoO8tneOe9ipcZgfGrdMaTuNrHRpQR69dFRhtnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715227; c=relaxed/simple;
	bh=dVINm3VnBIrxRzB+EW/13EQxYkrkKAXHJkeyxzTokgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsFyCbzXEm9Ii7UQekG3/CRjiwW7OSCtXqFjaUHG1Ez4+eLUACCR3wvi+KmALB3rLW/p0sawX6Or+3HmIUsZqWYj+irfCHjQN4dvuQPpZl4KWP63r5Lz8/hpP7KSgotjMvz1VU1w75nf29D1Cz0qroFyHZzBjLy/A7nN20n+5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfdTHl3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FE5C43390;
	Fri, 29 Mar 2024 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715226;
	bh=dVINm3VnBIrxRzB+EW/13EQxYkrkKAXHJkeyxzTokgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfdTHl3CVFBu9HGViuL08JGJbnivoJaA5CBsw/zTzobRBVO2w7Res8KCNxaZXYMMJ
	 e7MI/gjVyAP2ULZ6cCvOkuWzsixC5ovUYML8xGgGBoNM9EoZjjEDUiH6ZezQrzV1rr
	 CGOgITmcpBZ3U2qR/vzTaVLZp2kDKjGSnynvTmkW+VC6pfFCBYXFTFXCrJpwvZeJoB
	 V+so4pn8W4sSXznTb6FTKn6Rv4/tshERanlRPvKhoXzyHA5Sa8KQZx6GA09dCyoZff
	 FhRuacEFL4XTKN6IhLAsvUIMQo7JgrU5N3g/9U/pc8UGQIjUD8t023KEyL2N4QgMav
	 CfpwcjfELQfwQ==
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
Subject: [PATCH AUTOSEL 6.8 08/68] net: phy: phy_device: Prevent nullptr exceptions on ISR
Date: Fri, 29 Mar 2024 08:25:04 -0400
Message-ID: <20240329122652.3082296-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 3611ea64875ef..7cbe7c7141773 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1413,6 +1413,11 @@ int phy_sfp_probe(struct phy_device *phydev,
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
@@ -1527,6 +1532,9 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	if (phydev->dev_flags & PHY_F_NO_IRQ)
 		phydev->irq = PHY_POLL;
 
+	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))
+		phydev->irq = PHY_POLL;
+
 	/* Port is set to PORT_TP by default and the actual PHY driver will set
 	 * it to different value depending on the PHY configuration. If we have
 	 * the generic PHY driver we can't figure it out, thus set the old
@@ -2992,11 +3000,6 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
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


