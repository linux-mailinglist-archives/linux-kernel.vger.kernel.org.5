Return-Path: <linux-kernel+bounces-113540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B95888525
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B801F22F04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF111C1BE4;
	Sun, 24 Mar 2024 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSw4XSsp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F11C133B;
	Sun, 24 Mar 2024 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320342; cv=none; b=a2yDAqOt23pCLkzNTRUDOSZ403VXeecl8lb8jdCLOlzfVUG2cCzhfAzptlH5NHZNOgd+u1xHLY3+jOZr3Ph7GYzlptSY0MHMH49kZdpbfyc2wTKe0opxoylMk2AyvP191w1A3WGXJ1ZEDCaCOxRWFIHhy51M9Q64zCFjAEZl+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320342; c=relaxed/simple;
	bh=x5AIzp5pRdirbY3SVQfZZp+FdEWGqXBMpSCwWGurQY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4kB1EAG5foxAthMZM1h1s6hiAFjjjP1iXCyLrb5ZK4zD2rEU3yPVDCXOU5jifHXiaSVbtEHSeHJ/aQDeuQq9VuVX4KR/6qkRgTSSUoJ58DPyFejPf/odICrDaRvLp5yjvza6meVBSNhhF+JgwelRrSfDyL0D1KLNB6xYofLmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSw4XSsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFFBC43390;
	Sun, 24 Mar 2024 22:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320341;
	bh=x5AIzp5pRdirbY3SVQfZZp+FdEWGqXBMpSCwWGurQY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aSw4XSsp0NXt6uJIvJJAz5DNbT5sk37NT7w9yOtwL37174Uro20eo962GBgdJMx2J
	 7wFQ+F/7KM6qi/n3rzsDkciwMBPSv1Bd7w/VWqMWe4ZqRYEDGnlX+1vXiU20atdVBi
	 N9+Gyt4CLclB6n271jQvrBnbSLAxCIQoEDEo4IO1k7zzfX+feaDsCXoD7pYa0twrjo
	 frAdzpOHyvJTSw1aon4CetfmhwmBokcB1B8hjwq3T2m5MSNcn99xt3dBZBLufok98C
	 b5o8Wc3WCbr3KxTgjjU/Zy/xWXTbSoFAo2qQIAILpd+KlOBIg79LuQRMCZNh8GQYoV
	 x4r7ItfvhljuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shay Drory <shayd@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 649/715] devlink: Fix devlink parallel commands processing
Date: Sun, 24 Mar 2024 18:33:48 -0400
Message-ID: <20240324223455.1342824-650-sashal@kernel.org>
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

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit d7d75124965aee23e5e4421d78376545cf070b0a ]

Commit 870c7ad4a52b ("devlink: protect devlink->dev by the instance
lock") added devlink instance locking inside a loop that iterates over
all the registered devlink instances on the machine in the pre-doit
phase. This can lead to serialization of devlink commands over
different devlink instances.

For example: While the first devlink instance is executing firmware
flash, all commands to other devlink instances on the machine are
forced to wait until the first devlink finishes.

Therefore, in the pre-doit phase, take the devlink instance lock only
for the devlink instance the command is targeting. Devlink layer is
taking a reference on the devlink instance, ensuring the devlink->dev
pointer is valid. This reference taking was introduced by commit
a380687200e0 ("devlink: take device reference for devlink object").
Without this commit, it would not be safe to access devlink->dev
lockless.

Fixes: 870c7ad4a52b ("devlink: protect devlink->dev by the instance lock")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/netlink.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 499885c8b9cae..593605c1b1ef4 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -193,12 +193,13 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		devl_dev_lock(devlink, dev_lock);
-		if (devl_is_registered(devlink) &&
-		    strcmp(devlink->dev->bus->name, busname) == 0 &&
-		    strcmp(dev_name(devlink->dev), devname) == 0)
-			return devlink;
-		devl_dev_unlock(devlink, dev_lock);
+		if (strcmp(devlink->dev->bus->name, busname) == 0 &&
+		    strcmp(dev_name(devlink->dev), devname) == 0) {
+			devl_dev_lock(devlink, dev_lock);
+			if (devl_is_registered(devlink))
+				return devlink;
+			devl_dev_unlock(devlink, dev_lock);
+		}
 		devlink_put(devlink);
 	}
 
-- 
2.43.0


