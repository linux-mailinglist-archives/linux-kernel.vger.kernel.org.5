Return-Path: <linux-kernel+bounces-115563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D56F889C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC931C2E738
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0134D2B1695;
	Mon, 25 Mar 2024 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igKg23+t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3612D1EA;
	Sun, 24 Mar 2024 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321092; cv=none; b=UwD5AWzCEUec7ioPrWgtiVZGbemP4Ehuq+zSLrbmgrhCBsqVj37a4K9iflnIeKobll3lGn/74eAvyyGvwjX4zXMq/hDmEIllDM/q+aLUwSlszWUjBHFcPjluHXYPL62z5aHvWSZR48UuImSiTyJFgiX0MqAinSbEKO+rkMoMPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321092; c=relaxed/simple;
	bh=OFz3rgG/onaMQNrx3aFTgv7GqQgKkbhaPyQhmTu14o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7xOCictZhXs9maZZywZ/tRe96B4miXWqnVYYr0E1q0y7DFUHzYbnEU8L7VX8+r9R/nCdJHbKkwUt2Ml6ZrsgaJ46Ho+US/Nf2MQDwUdqDqDxQqza2oIOLI4KoqtrndDdf4/YHebitJ0EQz7DIy8ckVtXCPcpi59QwS2i2c9SyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igKg23+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F4DC43394;
	Sun, 24 Mar 2024 22:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321092;
	bh=OFz3rgG/onaMQNrx3aFTgv7GqQgKkbhaPyQhmTu14o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igKg23+tbZ35ziy6nQ+gdCT4XgVj4FbYZWkJdbGFRGm1QFBvIGEsQycVmCBhu9UMP
	 13mTVCfoHhgJEV/x6FBllvzoIvpKSK+vKm9+XGk5BKsYvnzdF4q9JN+/4/cDpN5PKm
	 yivvvAlIFf2V066mejkjGvYZNJQqvKvPSWzQ/oZQMOEJgg7bvymulPViyZ0LQS33CV
	 SVw05LDRzeIQz+2D6RxphDqkpqkViwA07dv0DoJgrqrX352tf2SCcIgh/1ZZa+Xz4W
	 rYNkK+dm8rr/KOPkV+DEzkjqYFrILvB3BVoIfXVjrCOj9NDqanAg9TTEZ12hefuCdU
	 KCDARP459O6xA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shay Drory <shayd@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 655/713] devlink: Fix devlink parallel commands processing
Date: Sun, 24 Mar 2024 18:46:21 -0400
Message-ID: <20240324224720.1345309-656-sashal@kernel.org>
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
index 86f12531bf998..0f41fded6a6d7 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -80,12 +80,13 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
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


