Return-Path: <linux-kernel+bounces-113970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0862A8887AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216CA1C203D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3A621EB6B;
	Sun, 24 Mar 2024 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mli3KEUb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F812D1E3;
	Sun, 24 Mar 2024 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321091; cv=none; b=emyqmvrZzEfZf0dH9u4qR/XLaIAiagdmL6croO9Juj4i4gxGq+WfSssDq3UIewfZfkx0iIVSvSn7JJGYcxNrAwh0iTRK7jHp3pDydjtoCf4I23gZUWjpQa2/pVtYc9+BrV6GdELkx4ZfhjOJBY9r2Ub1lLdvEA9MrcxscZfgQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321091; c=relaxed/simple;
	bh=RH5xBxqj4zna3PlUXqAMUAdnATCX4ojjYcBm2UMLfC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7LEHL2h/F914Ujus6UYzE1qJo4EKK87AlqpS1IIgWFlfZbJ8phku5y0/etbLlxI26VTAF5Yh734cAqUllUVJAq7Do3umvGwuEcpsPZ3TZukL8VTDqqyTaLNgrSUeloueKxWqxkyyeIdH4RNwQElxETFTSve4Dd7UTTBu+HxWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mli3KEUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C572C433A6;
	Sun, 24 Mar 2024 22:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321091;
	bh=RH5xBxqj4zna3PlUXqAMUAdnATCX4ojjYcBm2UMLfC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mli3KEUbgC/r6TM+ilKSQ1WVPvCMvrVe/rs7hEa09MxduuY7YEc44kV1GqZGrraBo
	 0zjD2HUmFQT2wiMBnbTwLNM4YIETHBu3AiLK73ro1nbL5Ktk+sy4F0jBwR+byh2LUI
	 qYm/pUPWjwzuzG++K8G7KmiKc4V5ggfpX8LJkV3XOpB4qSozaWADJVFT58HX8KCuOR
	 5Bh1kKfVjLUvg/Q2CsX6o7fAK6zEeETO8VJg2PLKnk897J8Loc6ry0meY2TY+jqYpA
	 U4mKj0Z8zgv6+iUAiUXhaS7RtIFSGNI1jrqz5vogYoHW638Um3DLrtgkGUyj8hT6Er
	 uUm/MGOIDSRew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 654/713] devlink: Allow taking device lock in pre_doit operations
Date: Sun, 24 Mar 2024 18:46:20 -0400
Message-ID: <20240324224720.1345309-655-sashal@kernel.org>
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

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit d32c38256db30a2d55b849e2c77342bc70d58c6e ]

Introduce a new private flag ('DEVLINK_NL_FLAG_NEED_DEV_LOCK') to allow
netlink commands to specify that they need to acquire the device lock in
their pre_doit operation and release it in their post_doit operation.

The reload command will use this flag in the subsequent patch.

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: d7d75124965a ("devlink: Fix devlink parallel commands processing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/devl_internal.h |  3 ++-
 net/devlink/health.c        |  3 ++-
 net/devlink/netlink.c       | 19 ++++++++++++-------
 net/devlink/region.c        |  3 ++-
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 178abaf74a107..5ea2e2012e930 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -152,7 +152,8 @@ typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
 				       int flags);
 
 struct devlink *
-devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
+devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
+			    bool dev_lock);
 
 int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		      devlink_nl_dump_one_func_t *dump_one);
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 695df61f8ac2a..71ae121dc739d 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -1151,7 +1151,8 @@ devlink_health_reporter_get_from_cb_lock(struct netlink_callback *cb)
 	struct nlattr **attrs = info->attrs;
 	struct devlink *devlink;
 
-	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs);
+	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs,
+					      false);
 	if (IS_ERR(devlink))
 		return NULL;
 
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 5bb6624f3288e..86f12531bf998 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -11,6 +11,7 @@
 
 #define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
 #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
+#define DEVLINK_NL_FLAG_NEED_DEV_LOCK		BIT(2)
 
 static const struct genl_multicast_group devlink_nl_mcgrps[] = {
 	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
@@ -64,7 +65,8 @@ int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info)
 }
 
 struct devlink *
-devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
+devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
+			    bool dev_lock)
 {
 	struct devlink *devlink;
 	unsigned long index;
@@ -78,12 +80,12 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		devl_lock(devlink);
+		devl_dev_lock(devlink, dev_lock);
 		if (devl_is_registered(devlink) &&
 		    strcmp(devlink->dev->bus->name, busname) == 0 &&
 		    strcmp(dev_name(devlink->dev), devname) == 0)
 			return devlink;
-		devl_unlock(devlink);
+		devl_dev_unlock(devlink, dev_lock);
 		devlink_put(devlink);
 	}
 
@@ -93,11 +95,13 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 				 u8 flags)
 {
+	bool dev_lock = flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK;
 	struct devlink_port *devlink_port;
 	struct devlink *devlink;
 	int err;
 
-	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs);
+	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs,
+					      dev_lock);
 	if (IS_ERR(devlink))
 		return PTR_ERR(devlink);
 
@@ -117,7 +121,7 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 	return 0;
 
 unlock:
-	devl_unlock(devlink);
+	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
 	return err;
 }
@@ -144,10 +148,11 @@ int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 				   u8 flags)
 {
+	bool dev_lock = flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK;
 	struct devlink *devlink;
 
 	devlink = info->user_ptr[0];
-	devl_unlock(devlink);
+	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
 }
 
@@ -165,7 +170,7 @@ static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
 	struct devlink *devlink;
 	int err;
 
-	devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), attrs);
+	devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), attrs, false);
 	if (IS_ERR(devlink))
 		return PTR_ERR(devlink);
 	err = dump_one(msg, devlink, cb, flags | NLM_F_DUMP_FILTERED);
diff --git a/net/devlink/region.c b/net/devlink/region.c
index 0aab7b82d6780..e3bab458db940 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -883,7 +883,8 @@ int devlink_nl_region_read_dumpit(struct sk_buff *skb,
 
 	start_offset = state->start_offset;
 
-	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs);
+	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs,
+					      false);
 	if (IS_ERR(devlink))
 		return PTR_ERR(devlink);
 
-- 
2.43.0


