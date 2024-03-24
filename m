Return-Path: <linux-kernel+bounces-113579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656F888573
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41C6281B45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA2F1C9EA5;
	Sun, 24 Mar 2024 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtHuS9SE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7DE1C987B;
	Sun, 24 Mar 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320382; cv=none; b=eDQhcRBdq8OD8jeiSe2VyhTz6CXh6F/tohSl/cmfaz/WFeUQFbLac4O339spWpVhn7NE8Sp1i1rMYV+PhV6HxaVlv+a+aUwnOgNyPVYQjO+b+s931wehvHNoaPXqgvkQDZNxs6VMUkEgSrnxZYGj5M28EEBG+g+PiUS9UF5sxkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320382; c=relaxed/simple;
	bh=/kJ+pL9TYq+r6hMSprRXe861dYBO4v98N/ell1FcD9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIwFUWx9k1pB/x2kPbiTuW1m/pfJTWEzwqB3BudwoDkRg/apH31h5MMkWfzx9ltoXYLRG5FTKJLjVEjOzITeOQyn5CHVaka3IDVnsFjTsqlz0pf6emil98QvCdA4pvkL7jrxtvX4u0Rb+m/DQp97hhUdUYkvIidopWRvDJmoDpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtHuS9SE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B28C433C7;
	Sun, 24 Mar 2024 22:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320382;
	bh=/kJ+pL9TYq+r6hMSprRXe861dYBO4v98N/ell1FcD9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtHuS9SEQ8U0DorYuYEDE7YKVnEgGs7JoqDF7Z+9NN5GuHvX8H/DnO0lK/bn+OpiW
	 LPuZ9bj90qTNsAO+ikp5dXo9s7yamjaX4Z5FUfl1ZB1FwNhCSKisqqc5M3fz87ofoG
	 k2NHoIibdzrW4Lsv1nsQhp+nncxzJ1BYM0gItDvbZOVqYw4zJCTucV3d0RYPsAHj2T
	 UzJxXLqlqUeYomBrwwYQgUFbE66WTc2A/2SA/NRFUcb/JmNFCd+dvJlPffgfV4JORJ
	 quIN2tjAJdwoaEGdvOrabGQcijoxQulFDJADqQi5qCiyf4r8s9B9Y607p/hz/9C1vf
	 8t2GQxjRMxdrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 688/715] net: phy: fix phy_read_poll_timeout argument type in genphy_loopback
Date: Sun, 24 Mar 2024 18:34:27 -0400
Message-ID: <20240324223455.1342824-689-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 3ad9bbf65cbeb..6125418ca93f3 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2706,8 +2706,8 @@ EXPORT_SYMBOL(genphy_resume);
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


