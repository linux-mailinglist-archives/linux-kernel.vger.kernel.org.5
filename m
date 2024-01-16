Return-Path: <linux-kernel+bounces-28054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B33682F99C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42A51F292A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9430146904;
	Tue, 16 Jan 2024 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6yjt0jw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20471468ED;
	Tue, 16 Jan 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434991; cv=none; b=uH8tQyYo+l6kQxnd6fXDtX9it5FFhovJ0Q5nfAhf7HwFLKEPDpXBntnW4oCB4UnuwAv6Hx3xA9I+jf9Md9YfmVdcdt5A5D/bGRUgBzWCIzbEV5Fi1NkyXf9CmAxz4vbluyAmtRDhWatkUfpit76FVOrVvc+4IJv5TdtZJ+W9/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434991; c=relaxed/simple;
	bh=DwpL6pZipovhtUWsr8X/KUOUjn6MSXk/EYtx5l6YpPo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=idoNJSsT9Ka3CMwMya/mITAgDniG3s6mPl6/vnpHfAO3TMOauMS/QmX67Tvu0blHUJ2ax3jPVr839ci2SXEau/HTRNroEub3OONJjISnPEoqX/QHmq2w2qWJdUWlDJkP0Tj9fvLhHl0eegaQNMBndL/S2P0xFMwS8n0NeaxDrKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6yjt0jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8B4C43399;
	Tue, 16 Jan 2024 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434990;
	bh=DwpL6pZipovhtUWsr8X/KUOUjn6MSXk/EYtx5l6YpPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6yjt0jwJXSiF9OfoejRQKNPJzv3pQ0HbVcaGK7mQ56cmb2qD/2JuROfFGyRmVmNR
	 aFfO1E6ixGMr3k5tsHU7uJqywUQUzDnr4Jjjrb1Z6TE5+McVCGsz5K0SSM8ooMZrYR
	 Gz+xzTy4+p5n1Bt2qzyuCyN7GsococbkMspjSwikNEGjRHu2gAy+6qZyZRixrmBBmS
	 /NzXjEFqUGf8FLgRMU/C1BNcz/KvtXAM8GwKBAwuY0DqDMuxm+acGPUrsPG9htJOO8
	 pp2P7xSmC5G7STQ6HftLP/b1QvE0ADvL2gDrnua/GkgFjRkfzj3YWaIFPQRi+nHxSL
	 Yb88J7sOMdPmA==
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
Subject: [PATCH AUTOSEL 6.1 36/68] net: phy: at803x: fix passing the wrong reference for config_intr
Date: Tue, 16 Jan 2024 14:53:35 -0500
Message-ID: <20240116195511.255854-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index edd4b1e58d96..75868e63b81b 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -2051,7 +2051,7 @@ static struct phy_driver at803x_driver[] = {
 	.write_page		= at803x_write_page,
 	.get_features		= at803x_get_features,
 	.read_status		= at803x_read_status,
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
@@ -2081,7 +2081,7 @@ static struct phy_driver at803x_driver[] = {
 	.resume			= at803x_resume,
 	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
 	.cable_test_get_status	= at803x_cable_test_get_status,
@@ -2097,7 +2097,7 @@ static struct phy_driver at803x_driver[] = {
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


