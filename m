Return-Path: <linux-kernel+bounces-27831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD60E82F680
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B2C1F25A58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35643D564;
	Tue, 16 Jan 2024 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGycoGdh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8D3D393;
	Tue, 16 Jan 2024 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434303; cv=none; b=kkNoRWFfx5r0D72QNeXh43/vjeX2EM7qyo2VJrCoewS55Mtns+FU/E043Bz8B7bBU9Ciogt9V5digNKsv8W6gPcXrfNGoSgq02rNqPT5fSRir53ELU70y3jPTS51ih8SodIln0B0VfUUzw0nF/cdKGwIDJCO934jBLF8TMiOVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434303; c=relaxed/simple;
	bh=Z+Z8WhzbRfBIX4GvAy/TPFGGNpBKFgKWsD0zKv/YjBU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=fJnf4ac8nSLKA//QIGMahgghnBYePt/SW4WNZ/s+WInVXUdq0v2GnzqVjbe/gbFRS53KT2fjwXrpbwH32ueUEIVA3Zuz9cnhyeyrOxY+MHiBkkYWWsRLgNAzpzm22bQiFg11K6OCFpMp5iOaDMw+hgpZN0APOFstKAaPTeUM088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGycoGdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F7AC43399;
	Tue, 16 Jan 2024 19:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434302;
	bh=Z+Z8WhzbRfBIX4GvAy/TPFGGNpBKFgKWsD0zKv/YjBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGycoGdhr7vzSxyoAwSmcaZdn1wGlGNjczspl7OML/gehPMGVQAbEsBvYfTS7wAGV
	 Rvn6v2wHpLyAsUf460H80/RNePeicyBauZSqU/y4OOxd6D65x98xDWdccISbY2FBeH
	 2CrTmzaKev0X7SvGrVVqY3ZxTxS9KWBcoDM2gb091XxCqrW2f2m7MQI2wkvD6UQDgs
	 ubOFEzATeQhcK7wtA5htKVfpk5vcJpGbDw0RqklsctckjMgX2aPvSn6bP4dvMLqp8H
	 N7TyfP6F638plaVLzM7U3dJJL6aDW8+eC2otUJ4UgBYfs6DsIaK8pOCBGLC9BOUaf/
	 uyBPUXWEV0HsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	hkallweit1@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 060/108] net: phy: at803x: fix passing the wrong reference for config_intr
Date: Tue, 16 Jan 2024 14:39:26 -0500
Message-ID: <20240116194225.250921-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Christian Marangi <ansuelsmth@gmail.com>

[ Upstream commit f8fdbf3389f44c7026f16e36cb1f2ff017f7f5b2 ]

Fix passing the wrong reference for config_initr on passing the function
pointer, drop the wrong & from at803x_config_intr in the PHY struct.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/at803x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 37fb033e1c29..ef203b0807e5 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -2104,7 +2104,7 @@ static struct phy_driver at803x_driver[] = {
 	.write_page		= at803x_write_page,
 	.get_features		= at803x_get_features,
 	.read_status		= at803x_read_status,
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
@@ -2134,7 +2134,7 @@ static struct phy_driver at803x_driver[] = {
 	.resume			= at803x_resume,
 	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
 	.cable_test_get_status	= at803x_cable_test_get_status,
@@ -2150,7 +2150,7 @@ static struct phy_driver at803x_driver[] = {
 	.resume			= at803x_resume,
 	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
 	.cable_test_get_status	= at803x_cable_test_get_status,
-- 
2.43.0


