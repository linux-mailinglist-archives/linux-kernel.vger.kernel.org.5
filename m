Return-Path: <linux-kernel+bounces-124547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A508919B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0DC1F228E9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF4714B074;
	Fri, 29 Mar 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg+qY2xN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B4F14A4D8;
	Fri, 29 Mar 2024 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715354; cv=none; b=KcEjP9WGbsMoIbq77mdvx8E10Ks/TbxLHW2G6ZYj1tOkQEHZu+Y491sZatJMs5KiyNVoZ5D2io6mSKz/hvjnFLabQpk0hZ4dXLO+ojtbY87Nx7BFzZ9Sq6C/k1tV2ZKTJnyHtv/QhNh7QiH8rNmGry+ywfR7Z/7icc2LtSeRPMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715354; c=relaxed/simple;
	bh=06rqdolv3yUMdKib4jZopsk2V8vRPwGkiWy2dVGwoyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7DO75ETK7NxkN8ACDSVIqNyHw7W9SDOSgxylcdKFpzXApYDpw8dJ8fBRkn57+gsH2C4huQVAWixUiuZVXdwSbKRBp+ZaNDjDDdwA9t45JGDdhGjeA6lCL7Ms9QVpmHefd/cDql9v2a7I75Fba0hxx1mbUJ+0ChkeVIfmyVRAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg+qY2xN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CD9C43399;
	Fri, 29 Mar 2024 12:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715354;
	bh=06rqdolv3yUMdKib4jZopsk2V8vRPwGkiWy2dVGwoyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sg+qY2xNWs7SIYUPYIQwQ+OQcEjgszYtqSS8arAC1OrcTGsswmXSoZ0O1HdyAeQh5
	 VGvnNtaneAQW2MZmB4rJygSankc8hSk8D/TLCUyUQffumM3urjxiuXhebNFRj1mWfN
	 OeOsemIsyStS8ewDszj75bXYxGkQKA/LBfqrtDOU5EkaKeq0Y4Xk9rf5KdrEn8fN/j
	 sV3DHPh8lkrqxXVR75oE5U4fLCQWeqfZ+nKxIwtCV4YNO76W1mJQrHRr2P5SrVDEhV
	 ZzCYaBzrPgEY9SRIZ12HjRNfCLZv06P1GJNwkhbSoUSFdxTuoqEMvY9CsP0alqaCsR
	 Ip2UowIOtf6fA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	pabeni@redhat.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@google.com,
	ast@kernel.org,
	maciej.fijalkowski@intel.com,
	hawk@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 65/68] netdev: let netlink core handle -EMSGSIZE errors
Date: Fri, 29 Mar 2024 08:26:01 -0400
Message-ID: <20240329122652.3082296-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 0b11b1c5c320555483e8a94c44549db24c289987 ]

Previous change added -EMSGSIZE handling to af_netlink, we don't
have to hide these errors any longer.

Theoretically the error handling changes from:
 if (err == -EMSGSIZE)
to
 if (err == -EMSGSIZE && skb->len)

everywhere, but in practice it doesn't matter.
All messages fit into NLMSG_GOODSIZE, so overflow of an empty
skb cannot happen.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netdev-genl.c    | 15 +++------------
 net/core/page_pool_user.c |  2 --
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fd98936da3aec..918b109e0cf40 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -152,10 +152,7 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 	rtnl_unlock();
 
-	if (err != -EMSGSIZE)
-		return err;
-
-	return skb->len;
+	return err;
 }
 
 static int
@@ -287,10 +284,7 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 	rtnl_unlock();
 
-	if (err != -EMSGSIZE)
-		return err;
-
-	return skb->len;
+	return err;
 }
 
 static int
@@ -463,10 +457,7 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 	rtnl_unlock();
 
-	if (err != -EMSGSIZE)
-		return err;
-
-	return skb->len;
+	return err;
 }
 
 static int netdev_genl_netdevice_event(struct notifier_block *nb,
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 278294aca66ab..3a3277ba167b1 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -103,8 +103,6 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	mutex_unlock(&page_pools_lock);
 	rtnl_unlock();
 
-	if (skb->len && err == -EMSGSIZE)
-		return skb->len;
 	return err;
 }
 
-- 
2.43.0


