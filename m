Return-Path: <linux-kernel+bounces-113993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF748887D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BB41F26561
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0332A156F54;
	Sun, 24 Mar 2024 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeyzM+ES"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFDD1F30D1;
	Sun, 24 Mar 2024 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321126; cv=none; b=I7868QzKcFH4/wuLXk11JTMwM5Yg0N0l9YT6IQkri2e4xAMAuNsYBu1RI42+P7MAGY7+TVXuFYpGAedot2+bVSIiq7VGMkLYtHbfuEkFKM0y/A+hWPfQ/83E9v37YQyhHCNa2nPzPTkLBWCQZPw/53yUpM3fdpApLrIB4xyoqT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321126; c=relaxed/simple;
	bh=u4ufuJkyupCrutFxJsNV8Mzjv+4OTdE4ZWbYzCHnvzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyfKIRfKrD8y4rvue4EiX4GWkraWNVQLPBA/1N7WUm5+RpoQqNOdXjk5s13mUhQ2Jz2tXrySZX/01X/DFCQ1iNPxeX3zhhItXmuDiVy3plAszYxTqdJt+xneg5TDF4Xp+vxCrV2UDYCyFkSIy1vpDNQ43E8hrbY0JNU3s3GG2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeyzM+ES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80566C433C7;
	Sun, 24 Mar 2024 22:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321125;
	bh=u4ufuJkyupCrutFxJsNV8Mzjv+4OTdE4ZWbYzCHnvzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OeyzM+ESbOrcdgzDLSKPuwOWvXQawP6V16SvjP6mqiebc+NIUp8Pt5afRMAPN6UfL
	 +lHJrwfw5tdBj+6FhI/wDXFY3bW4lm8xVY1KHTDppWLPgszLuhaR798dLMUYzvXBGY
	 EjoiplHy3TMb3XSRwoj11uW9ZuqH8WpM+M+ZOA3FBQhy/lxOvyzsWlp61ObX0v1L2t
	 ckSWxVfABa/7+nJKjQq87vZZHi35xzO37SaLmaQBYxZHu6fUqD7OoMQ3zTn+TgLNKL
	 wFM058xs8WfuSZDwxPqnCetX/ErEehulhsGePSFciaxVS8ZPz4lkplfPbh+QurtAF5
	 7pNM7NrGqtOJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 686/713] net: phy: fix phy_read_poll_timeout argument type in genphy_loopback
Date: Sun, 24 Mar 2024 18:46:52 -0400
Message-ID: <20240324224720.1345309-687-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


