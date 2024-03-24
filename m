Return-Path: <linux-kernel+bounces-114465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D374C888AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737811F25D14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7FC17C1B3;
	Sun, 24 Mar 2024 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpFfa/oW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742CC22098E;
	Sun, 24 Mar 2024 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321887; cv=none; b=he29EZwClR48Hv8+wZpdHXpXB9uFYT4zyqc4xrN9gSm+EpXMVxS7crL9nmC5m0U4AEooxInPH/ufg1yR9D70EjwsGXdijgZhwijomJbN/HtodzPLGiZO/RhnZ7YT/yEzyJ38IKs6iKAuO8U4DE+yyV/fiiVJScR68jJNyubDI3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321887; c=relaxed/simple;
	bh=u4ufuJkyupCrutFxJsNV8Mzjv+4OTdE4ZWbYzCHnvzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwRLLh9/x6UNXWLXRSD/nnQ+G1dPcGIVAy5iXmQ1otmx1y/2zcdNtm4zEM+hCYjGTU4T3F0pbzjn1mOywSrD9z4DT06/5daN5zLYQ+KmitIObPT3ovPsGhPi/5CzZ1U1ItHYxTeu2SE3V5F6AADuiv2Td8MWfHECTlFPEml/SbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpFfa/oW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B04EC43394;
	Sun, 24 Mar 2024 23:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321886;
	bh=u4ufuJkyupCrutFxJsNV8Mzjv+4OTdE4ZWbYzCHnvzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XpFfa/oWuzvcxJ4nV3pt4YMyQ9Ce6a8AdL+JrsvU+V+u8m6fXjnKW8FKLFW3gUIF5
	 F3A3fkxUUUkAfEv0i/SFM9KLdcvLOsHKHjzWmhfDC7P86AKkB68kBQzI3pzIABrIzd
	 zZGGMlzj9OZ50ea1BVF9bFYKiT/9wGY4LuQY/tQcC7NmcfGxaG3dvDPynzXIDjfHVR
	 No3EYW0g4Er4FDV/nWJpdkNB5ktrVAhKaLV2CxdAtW4EGzkq8NqJId5jFrRljBQaiV
	 w5HdWuIVkAchzY3XZOubsqwCSc/V6UsrwNaR42ftFQ8DtYxhPxbfE+WyG9odKRe1C5
	 nzHKwppLq01Bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 614/638] net: phy: fix phy_read_poll_timeout argument type in genphy_loopback
Date: Sun, 24 Mar 2024 19:00:51 -0400
Message-ID: <20240324230116.1348576-615-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index bbc459f97b7b0..813b753e21dec 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2701,8 +2701,8 @@ EXPORT_SYMBOL(genphy_resume);
 int genphy_loopback(struct phy_device *phydev, bool enable)
 {
 	if (enable) {
-		u16 val, ctl = BMCR_LOOPBACK;
-		int ret;
+		u16 ctl = BMCR_LOOPBACK;
+		int ret, val;
 
 		ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
 
-- 
2.43.0


