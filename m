Return-Path: <linux-kernel+bounces-114694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF0B888BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD9B1F27DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AFF2B92E0;
	Mon, 25 Mar 2024 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvEmv0mX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA79C15F418;
	Sun, 24 Mar 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322343; cv=none; b=aTeH7peN10bV8MTJcRNVbUZ2Pr4ypFfkvRoy6HJEj5vM+UjF9lt290v1S11Yp691UNtvo2ui/hE2JPsYSm7kM4xseT3+HgzceYLfcIGj1c7O2b5Rg0sk5DxEfILd3sx2oXSj7mDStOA1XqziqkMY7M6xZHQd9yXm1hQFAZzW6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322343; c=relaxed/simple;
	bh=jlEAspSQ5hbXwQe80k66wh6DemfEAphhDgRnHGqwfKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VS6hE7RqzjYpFIq8KgZsfU9TGGttCfO7PtJpfb1cHdkwUXIYgNUyS+giS+osfbc0hNPzq53nMWEluHwbPB0Amjm5GKmp85aTfLWn6CHAJhYB74RWVYqMTsNsPaGZoPpkln5sFLFhlfZV3twHvv85LBtrDOJY4n63FZikXGzvCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvEmv0mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D54C433A6;
	Sun, 24 Mar 2024 23:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322343;
	bh=jlEAspSQ5hbXwQe80k66wh6DemfEAphhDgRnHGqwfKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mvEmv0mXlB2P+LIo/jNEHZCWzwkH/bKH/1Ld7leZlSOvl5+pMkbEE3bKs0vrlbi2b
	 lVF/AGT7tEqFZW+Q5XtWC/9dZCYKHd5hh4Sx3sTk7QSvk96VjE+A96+fKxcyM4z14w
	 YVoewJe5Wwj3wj1TYGYCztqjLiClBXS5Y5ylVxkSSdagiTI6wfFkTHYjw2sHYguv27
	 CRENtBgLZvzlMy+tb5p4Iiy7stBEbINb5SIOT/4RUnsBoKw/S1g0oNtMFRRpM4qpdY
	 tDT51cZsrerC+raZyPokyO7GgWP9jfjP+A49ZuZv4Km3h8E67Yx+kLvL20IYIOAjv7
	 Nl/Z8JIhdonKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 425/451] net: phy: fix phy_read_poll_timeout argument type in genphy_loopback
Date: Sun, 24 Mar 2024 19:11:41 -0400
Message-ID: <20240324231207.1351418-426-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 45b07004669d6..f25b0d338ca8d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2640,8 +2640,8 @@ EXPORT_SYMBOL(genphy_resume);
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


