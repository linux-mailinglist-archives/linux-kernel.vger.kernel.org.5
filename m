Return-Path: <linux-kernel+bounces-101949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3B287ACFD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0937E282549
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A547137769;
	Wed, 13 Mar 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijlko+Zn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AB513774E;
	Wed, 13 Mar 2024 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348157; cv=none; b=GHk80/YxjAv3VRLqj6nNzd0LIPlJTfX2K3gQ+UcIqJdhVPMkMRI5A1n6jfP8oX52VassADza3hHqJKiy67YXcwE7r3DQ/HVQwRJW1McDPEAfsyzVaN15no6TBEl5d91WUKXREdL6BMTrMDJO0qxYP1lOS/y4RowaqiOBDu0M4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348157; c=relaxed/simple;
	bh=4FrnG+R/9EakgivZSNNtZb5j+1oO4df+JTS9AuAuvMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SN6DMe1LRbvbpKqpWBsj/VX1ok7mLJfM4WmRRgTD2WbFZQpWRsL1w8p1lIdptJxlJra7dLFhiwiAtY46nvdkNwj7p1IAv2p/g7+qxMZCG/ydz6jMoF7uIAGrXftyMj9CsNklSCjDkb2WvIkFSMYoyxQqiv9yQfvbKMZBwhclgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijlko+Zn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70620C4160D;
	Wed, 13 Mar 2024 16:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348157;
	bh=4FrnG+R/9EakgivZSNNtZb5j+1oO4df+JTS9AuAuvMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijlko+Zn8Oc0sPe4Isu8fhKfx6RqixVDkSeb4fnKvVypjIbM0nRjQgsobZCHscwAH
	 NyVbDKH6M4UmQP37qxo9RhMd9Fgjkd4B3EAnEDdeUW0+W+crJTvQrs5LpoZfe5kpm4
	 PsUQJJPcXOOnx5wsE2akN+9PVrKhyN0oggLpAm/c+2cPY6BvW9YEWZJqCYntshXMNV
	 BpkMZKWwVqJs4ojzmg9H/v8UIyurbzXTI0mfmlLYEaAZ2tWrOUlw61CKpsTWMq6mo9
	 szEcWliT1c7+XAZYuc8x5GQS39LKcSL2PN9rq7GbV8rCdUYmzC3wZxKSXbTDgn8xuA
	 mSarRwCQuoXzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 09/76] net: ice: Fix potential NULL pointer dereference in ice_bridge_setlink()
Date: Wed, 13 Mar 2024 12:41:16 -0400
Message-ID: <20240313164223.615640-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Rand Deeb <rand.sec96@gmail.com>

[ Upstream commit 06e456a05d669ca30b224b8ed962421770c1496c ]

The function ice_bridge_setlink() may encounter a NULL pointer dereference
if nlmsg_find_attr() returns NULL and br_spec is dereferenced subsequently
in nla_for_each_nested(). To address this issue, add a check to ensure that
br_spec is not NULL before proceeding with the nested attribute iteration.

Fixes: b1edc14a3fbf ("ice: Implement ice_bridge_getlink and ice_bridge_setlink")
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d4c29e2562a1c..3cc344d5228b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6987,6 +6987,8 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	pf_sw = pf->first_sw;
 	/* find the attribute in the netlink message */
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
+	if (!br_spec)
+		return -EINVAL;
 
 	nla_for_each_nested(attr, br_spec, rem) {
 		__u16 mode;
-- 
2.43.0


