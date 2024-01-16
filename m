Return-Path: <linux-kernel+bounces-27792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60E382F5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFE71C24156
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765DA22EF2;
	Tue, 16 Jan 2024 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upzAbFEN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3B22EE2;
	Tue, 16 Jan 2024 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434206; cv=none; b=H807LXFVGjaDy3IklVO6mJ/KZdbx1Xh2T8rfb/CBsiN3QL52sumoYq752WXIXxiGpvoaJ1k7lz+7cGwC/ZCtvdHehc+LYSfq9MbV/SJZv9NcsaVkN2Fj5XBbdG3i9UcVHJ174aMbqTb4wNHR2V5mJ5If4IZn5TFlXXu/DZs6e1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434206; c=relaxed/simple;
	bh=ChkW/m9ukbCox7xWcOwHlLqbHiYr7W6P0zsx2aBFoio=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=mh9v+be/IKyg7ikkoJSYuZoTNBullD3JfIQAeYnQigEyUc3oxAK5HWUEFhs+ws/Hs5a5Bi5akDklARBYxWS9WzrF7kSHNDgVH1SGkngvRh+8eX2lZRAV1xu3XMmd6Cvn4hHMPWOH7qNqZVr8YY6rS+lH+tp8aBnoNLc9MLu8m0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upzAbFEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CE0C433F1;
	Tue, 16 Jan 2024 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434206;
	bh=ChkW/m9ukbCox7xWcOwHlLqbHiYr7W6P0zsx2aBFoio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=upzAbFENYxOdpWZO+Aum0m0yZIQ55zBdBSlz7B2nXXd4zofxOpzgrlXjpa8K/TiQS
	 Ygbe21F/tF73SXEFZ7J6fAm8mMvwZGunP2IwpsVbeYcqwDBhN6xg8WkjW11YUcnNLL
	 b1U/c+pi630xqU2NFlYbYfWHRAlQUgpKla8zqmLkHlRu5ywi9EmlJHEtghwPkVOhMF
	 FyvIsTkY5ukuvJChJ+pZgX/bRPt5DXWBy30r2aw4ici94PIn9emUCU3slvHnNc97Ux
	 sulFST3d45EM+hAcWAYuq2gfqWLi0AI8qv4R+0xxCkUP91irkQI4AYV5qHCfRC7ElG
	 dBuMLGWAoxBMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhengchao Shao <shaozhengchao@huawei.com>,
	Jay Vosburgh <jay.vosburgh@canonical.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	j.vosburgh@gmail.com,
	andy@greyhouse.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 022/108] bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk
Date: Tue, 16 Jan 2024 14:38:48 -0500
Message-ID: <20240116194225.250921-22-sashal@kernel.org>
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

From: Zhengchao Shao <shaozhengchao@huawei.com>

[ Upstream commit d6b83f1e3707c4d60acfa58afd3515e17e5d5384 ]

If failed to allocate "tags" or could not find the final upper device from
start_dev's upper list in bond_verify_device_path(), only the loopback
detection of the current upper device should be affected, and the system is
no need to be panic.
So return -ENOMEM in alb_upper_dev_walk to stop walking, print some warn
information when failed to allocate memory for vlan tags in
bond_verify_device_path.

I also think that the following function calls
netdev_walk_all_upper_dev_rcu
---->>>alb_upper_dev_walk
---------->>>bond_verify_device_path
From this way, "end device" can eventually be obtained from "start device"
in bond_verify_device_path, IS_ERR(tags) could be instead of
IS_ERR_OR_NULL(tags) in alb_upper_dev_walk.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Link: https://lore.kernel.org/r/20231118081653.1481260-1-shaozhengchao@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_alb.c  | 3 ++-
 drivers/net/bonding/bond_main.c | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index dc2c7b979656..7edf0fd58c34 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -985,7 +985,8 @@ static int alb_upper_dev_walk(struct net_device *upper,
 	if (netif_is_macvlan(upper) && !strict_match) {
 		tags = bond_verify_device_path(bond->dev, upper, 0);
 		if (IS_ERR_OR_NULL(tags))
-			BUG();
+			return -ENOMEM;
+
 		alb_send_lp_vid(slave, upper->dev_addr,
 				tags[0].vlan_proto, tags[0].vlan_id);
 		kfree(tags);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 8e6cc0e133b7..9c1652886f4e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2973,8 +2973,11 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 
 	if (start_dev == end_dev) {
 		tags = kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
-		if (!tags)
+		if (!tags) {
+			net_err_ratelimited("%s: %s: Failed to allocate tags\n",
+					    __func__, start_dev->name);
 			return ERR_PTR(-ENOMEM);
+		}
 		tags[level].vlan_proto = BOND_VLAN_PROTO_NONE;
 		return tags;
 	}
-- 
2.43.0


