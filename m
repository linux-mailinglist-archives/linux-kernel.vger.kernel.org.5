Return-Path: <linux-kernel+bounces-101878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A43AE87AC5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448171F2A7FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E24677654;
	Wed, 13 Mar 2024 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucixwqT4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6BF7763B;
	Wed, 13 Mar 2024 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348012; cv=none; b=Ej2R+RGnQqBaDNyhsgz7IPnzMFDzrNCUaxdeg8F8YMETlriSQ3QIxYSLI1QB2PrqE9MJHwFCRWAfgEWtRWLYZlf0z8/g7B3spge+BF5yvp4x5yjc2CLEQdUjaMxYgCovUWGaQfcaurZZA7nAVgGn/CU731ttFUDXp6gFVkMHGIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348012; c=relaxed/simple;
	bh=2V2Bq/MN+rP82veBxozgfmRQQZwAkbRMpZsbmWuJCLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TagUhyl76cKRAyXKIzvbhZX4DGrurUTies5BVK2iOS3c3Mf9ojBlCnvdw8Rq9F50+pYaMqwNiranZhoDAJepqlkBNdccaxm6Q3Iuj5x8i3LtiOyWyotQwRAzup9Oh+KoqDuXta51oFV4LlKTfAP0b/kI/a9ln/lOFlSnErxFUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucixwqT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB31C433C7;
	Wed, 13 Mar 2024 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348012;
	bh=2V2Bq/MN+rP82veBxozgfmRQQZwAkbRMpZsbmWuJCLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucixwqT4EG/BKqxRLSboO3CaosWWCK8JSLA1SCIUoq7NS552mjm0TJ8eKWxBoxqFk
	 RPcK3t+BaFIeMnPTpr+rrVeHLK+Q/iYCziA0jYqiHNKqgGEcXYX9Qij3LwT3lVxaFg
	 5uIQTP60FEO49eMGJ8lC4LD3hdt8wpjviGNmgnup3T6/PFOYVvZ1INcc142qHnwUCD
	 23z9YKy3uHuN/39mMuGxzhzhZgSeODAVb+SZYxIoGTeTChr76zljQUhwvbqWtX0kEJ
	 qp3UVDuX7g4Xd5DqzFYxbSMIVJERPuE5tscA8Zd1l8obnT1RYh18VE2U4RrGzaL7pu
	 3+4KuCdTtLMPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 10/71] net: ice: Fix potential NULL pointer dereference in ice_bridge_setlink()
Date: Wed, 13 Mar 2024 12:38:56 -0400
Message-ID: <20240313163957.615276-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
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
index ab46cfca4028d..3117f65253b37 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7681,6 +7681,8 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	pf_sw = pf->first_sw;
 	/* find the attribute in the netlink message */
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
+	if (!br_spec)
+		return -EINVAL;
 
 	nla_for_each_nested(attr, br_spec, rem) {
 		__u16 mode;
-- 
2.43.0


