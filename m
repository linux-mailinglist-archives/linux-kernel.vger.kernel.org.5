Return-Path: <linux-kernel+bounces-113234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE3D888286
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEDB28A33E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1F6184303;
	Sun, 24 Mar 2024 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW4SElaF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C98183BAA;
	Sun, 24 Mar 2024 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320035; cv=none; b=ip0V8uy1Gsmo6c/c+fGPaxds+GRtJHwuEVR46H3fw51lUVNd1MS4gyQA0pCECamxDmcwmmJD/5SeXfiR3dwkPAph/6n7UMLZvsMPHPlMBWNUYAPlIklC8HNnuNYCmPd6sCGQ3OBAvMXuELD6MKcDvnMsO0Zv+eq6BR+Rj9LxFxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320035; c=relaxed/simple;
	bh=Vgkzwo37Keltrl0Mwke7Q+1JmJcXEaRiYrJXXdkBbTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEX1X1jiYKy7TwBLWTfTPi1Wmng/0WTxIwrVSkMJvl9UqNteUabsa05PGi5LwOs3tPx11Y7onx/6lZ/GfLObKmfmC+Q9Z/rhPGOSsB4KaGxzYKu8260NCNQXFyJdE0TaexYFNmzWFf5gjpDVfT4nH7zKxGkkennEEc28Bk4RvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW4SElaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25220C43394;
	Sun, 24 Mar 2024 22:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320034;
	bh=Vgkzwo37Keltrl0Mwke7Q+1JmJcXEaRiYrJXXdkBbTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WW4SElaFAdy2NuDNEqJvuJ+bs1k7du0NmT7Tbx6SFRQXjZk68iNJF/EGF/umQfDbB
	 9UaV0oiJ7ssS2FVvWDB+Wbb8AVwMSdO55ps2JCWgMaXMhm8e9B1JBmRiVHCszRlpBF
	 ETO2N7DPAPKuIQNbnWYfWOzy1hknku1LNgifU3484VE3ZfONRVRfP6PJORdOOUdQXV
	 6lHCKRbH5kcL4i/beCMlTkVCV439Tu9RfuidXz+q+9wf4DhtfwDkr3S3MeqMgvUQ9D
	 zAEIUnlTL7ZSw3ppY2RQTMykDi2tvLpr8d8LBkHMv74R3e4h25r54xvivS8x5PISMi
	 s84CFHuxd7Vfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: William Tu <witu@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 343/715] devlink: Fix length of eswitch inline-mode
Date: Sun, 24 Mar 2024 18:28:42 -0400
Message-ID: <20240324223455.1342824-344-sashal@kernel.org>
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

From: William Tu <witu@nvidia.com>

[ Upstream commit 8f4cd89bf10607de08231d6d91a73dd63336808e ]

Set eswitch inline-mode to be u8, not u16. Otherwise, errors below

$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
  inline-mode network
    Error: Attribute failed policy validation.
    kernel answers: Numerical result out of rang
    netlink: 'devlink': attribute type 26 has an invalid length.

Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")
Signed-off-by: William Tu <witu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240310164547.35219-1-witu@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/devlink.yaml | 2 +-
 net/devlink/netlink_gen.c                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index cf6eaa0da821b..09fbb4c03fc8d 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -290,7 +290,7 @@ attribute-sets:
         enum: eswitch-mode
       -
         name: eswitch-inline-mode
-        type: u16
+        type: u8
         enum: eswitch-inline-mode
       -
         name: dpipe-tables
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index c81cf2dd154f3..f9786d51f68f9 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -198,7 +198,7 @@ static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITC
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 1),
-	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U16, 3),
+	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U8, 3),
 	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
 };
 
-- 
2.43.0


