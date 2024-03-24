Return-Path: <linux-kernel+bounces-114923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2B5888BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11761F28929
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3572F2D5D45;
	Mon, 25 Mar 2024 00:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPP9qTv+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD727F08A;
	Sun, 24 Mar 2024 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323598; cv=none; b=JFTqaSpOuxPaSaERkPiSzpq6rGVu9hj7RgzCpZLTMrtpSgA4KQ+5HhYVK3fbHM9UZFgUprJzweamJCkRC6kSbigpk4PE/6MybB3WyeXKc6VaY3dVRRwXKvEmWBiDWpQ70OQL/E1OZly0mjTNXZqi0yh5Ie/jqTb0sBrK11jMYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323598; c=relaxed/simple;
	bh=etXXV4qNNutSWaDORYaLYIuQPxSlpzv4WX/vG6Vg7ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWKSoDp77Q949XXKKtMlcgBL3ME8RkubmO6J5DQtX6UjsG3N1c7yaHQ6J6D59GZyjzOH+Wk3L4YaZLPvKGZVQ/rfhS4/1I1cCa7MzMEt6aZw0egWewaUTC5MRk9Qjx455ErzGAYLfbMEVzmKhktgXpIcWtsu9cM9+6yH0WkcFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPP9qTv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E35C433C7;
	Sun, 24 Mar 2024 23:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323597;
	bh=etXXV4qNNutSWaDORYaLYIuQPxSlpzv4WX/vG6Vg7ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPP9qTv+GF5/FPYgt6GzkyGdGtXO+t1duGuNjKs84GkHAZWLmqmPZBwFxkTSTgzpu
	 S59FWTiQXowhZuCH9TshP0ECz7VNLhGK3aCs9ANFCWCK2bYq5ex72gOx6bkwsTzb7S
	 /rny5/JMf/phuxY+S6vVL/lSGYU4dPufITopr/p4OL1iqro8M6dacKZHFJ0kScgJaf
	 eWglMPPmnbPwolH8/AJlJTZ5rHYWGfbsUwC0WIGcf8CCzWeDASIC28XYdk2aw0TXRl
	 w5WyVPwCh+poZn80h6EL0TrKPuC04Bmnnr7oTwhP2h79YAGS1W9kWxGV8OkhRaoHeR
	 mVp6VhucUsGzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 303/317] net: phy: fix phy_read_poll_timeout argument type in genphy_loopback
Date: Sun, 24 Mar 2024 19:34:43 -0400
Message-ID: <20240324233458.1352854-304-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nikita Kiryushin <kiryushin@ancud.ru>

[ Upstream commit 32fa4366cc4da1c97b725a0066adf43c6b298f37 ]

read_poll_timeout inside phy_read_poll_timeout can set val negative
in some cases (for example, __mdiobus_read inside phy_read can return
-EOPNOTSUPP).

Supposedly, commit 4ec732951702 ("net: phylib: fix phy_read*_poll_timeout()")
should fix problems with wrong-signed vals, but I do not see how
as val is sent to phy_read as is and __val = phy_read (not val)
is checked for sign.

Change val type for signed to allow better error handling as done in other
phy_read_poll_timeout callers. This will not fix any error handling
by itself, but allows, for example, to modify cond with appropriate
sign check or check resulting val separately.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 014068dcb5b1 ("net: phy: genphy_loopback: add link speed configuration")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://lore.kernel.org/r/20240315175052.8049-1-kiryushin@ancud.ru
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c1d6ebf12ec74..523436690adef 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2645,8 +2645,8 @@ EXPORT_SYMBOL(genphy_resume);
 int genphy_loopback(struct phy_device *phydev, bool enable)
 {
 	if (enable) {
-		u16 val, ctl = BMCR_LOOPBACK;
-		int ret;
+		u16 ctl = BMCR_LOOPBACK;
+		int ret, val;
 
 		if (phydev->speed == SPEED_1000)
 			ctl |= BMCR_SPEED1000;
-- 
2.43.0


