Return-Path: <linux-kernel+bounces-113966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997C68887A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BAB287120
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9DD21E322;
	Sun, 24 Mar 2024 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbE+IXMS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469641F1AFF;
	Sun, 24 Mar 2024 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321090; cv=none; b=XdK9vqt8MnuVlXs1ZfBXE3gIrX/+ccfczWcOGvpAFBNx8i39o4h/Fn0tww6owwh9e+MBWD9lxEQfxc87oRzG5RGvqowL4Gz+PI250Gl/x0dxph66Sj1d55NXx3W/XEN9iSm9TFahcdmr2usdJ0DaEdt7r9hNDkp860P6FsQXgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321090; c=relaxed/simple;
	bh=vy7UsS1PrW8icE6oUS1QRfi8u0CM63LE02Vv4zxirYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knXQoYuLfrsIHKTLlzRZVpWYlgnOdYBu0wTZMfi5ZQ26au1wux/r63wMET+ZLYFV/rnHRSt8h7++nlYtfoNFp9Wvj9arxBFT5to/tCBoRUc9OUdQoG7/jdNa8L6ug1MhIKpfq0cjdYiw4nUF/dhoJRJe3NEuL30hpWIZzHEKRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbE+IXMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F22BC433F1;
	Sun, 24 Mar 2024 22:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321090;
	bh=vy7UsS1PrW8icE6oUS1QRfi8u0CM63LE02Vv4zxirYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbE+IXMSEsax2fD3tN6C2UmMyAQ4bD8/ELS3dz2lipKAQlBLEOPnJobSzP0ire9aN
	 5Iw+kr8BVyRsJy/tAHJ42RtzDEZa2qrbSTFO5qdnhCuRPtEg6vWQM8Ojf29dR/CYKQ
	 bMVNynq2KDvisEbXKvvbFuE/S4wUe34a1y06yjW8jsGDHdjRSRwm76WFaEXqeRwTo9
	 bQ536P0uwuc+rdKHUZN/+uakb6znIS+awR0NIcT3bjVdN3P6BuYqqFJp/d02tF+/SP
	 sjb2KJ5dShN5s/VqndiRkPB4YhvQEW1Lho0Wi7V2hXDIsUOpXyuiqFEKXo/MhPXYuR
	 ryd2mtb1p/JQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 653/713] devlink: Enable the use of private flags in post_doit operations
Date: Sun, 24 Mar 2024 18:46:19 -0400
Message-ID: <20240324224720.1345309-654-sashal@kernel.org>
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

[ Upstream commit c8d0a7d6152bec970552786b77626f4b4c562f4d ]

Currently, private flags (e.g., 'DEVLINK_NL_FLAG_NEED_PORT') are only
used in pre_doit operations, but a subsequent patch will need to
conditionally lock and unlock the device lock in pre and post doit
operations, respectively.

As a preparation, enable the use of private flags in post_doit
operations in a similar fashion to how it is done for pre_doit
operations.

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: d7d75124965a ("devlink: Fix devlink parallel commands processing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/netlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 7350138c8bb44..5bb6624f3288e 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -141,8 +141,8 @@ int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT);
 }
 
-void devlink_nl_post_doit(const struct genl_split_ops *ops,
-			  struct sk_buff *skb, struct genl_info *info)
+static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
+				   u8 flags)
 {
 	struct devlink *devlink;
 
@@ -151,6 +151,12 @@ void devlink_nl_post_doit(const struct genl_split_ops *ops,
 	devlink_put(devlink);
 }
 
+void devlink_nl_post_doit(const struct genl_split_ops *ops,
+			  struct sk_buff *skb, struct genl_info *info)
+{
+	__devlink_nl_post_doit(skb, info, 0);
+}
+
 static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
 					 struct netlink_callback *cb, int flags,
 					 devlink_nl_dump_one_func_t *dump_one,
-- 
2.43.0


