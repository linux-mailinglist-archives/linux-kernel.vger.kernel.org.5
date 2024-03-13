Return-Path: <linux-kernel+bounces-101829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 186F487ABF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80E6B24A99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CC66CDDF;
	Wed, 13 Mar 2024 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpQkgpt9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1A6CDCA;
	Wed, 13 Mar 2024 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347863; cv=none; b=rN/6cVAmpL7YteqkHwzObTdf+rhZv6tneQ3ZOBh1r9oO7TuBtmLYpuWDJKJLtCnLj+tlI4zQxj/y+kzEBFAuD82b570tDMElDkEAvzXotxvnL1OFOETIxQgTBwrYFL5g8IHZGhVQTWBfqTPym+69nyFjjpRBWwo7q/v4ppzGCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347863; c=relaxed/simple;
	bh=8o1ZOebRTS6KxGyRL3P369CkvJplrXXspwfA5lVfTA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjWaecuRArerUNXhOULCUkoRQNQo9s3G3AtX/kDweKqXkz6R9oGb3d8s3QHh5S2GlXoq0vwLZTQ0TOYCNVYVymoyS31Xx7SBR+EABUNK70zKPhRjg8jiIWkaLNJWIkWr6HKmJxYbWyX4sI6aSidb48iv8zX74zJcbJMsbgzdNWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpQkgpt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28795C433C7;
	Wed, 13 Mar 2024 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347863;
	bh=8o1ZOebRTS6KxGyRL3P369CkvJplrXXspwfA5lVfTA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JpQkgpt98wK6n7p/KLoJ7Aap1hqkcPgr0fnyuMBbntt2cqxWVUGtpYwRGOW8gK9or
	 9crjrAQg4ioelGm7PMQ55gJLL2GsRaJxPZZyP8mLf8PeVFHITNREnaB9ojifPMuRX0
	 o4dYl9JaN7KtgD5jEHeP21DbpFncbB6h3de7erIvKNsYgDUKw8Zw20DCzV+aQfPRTr
	 vSqb6VRzDii8cgXVAUkQ0uZLijaINC/GUbtbs+PEcG6PXWOFyHFkrIaxqpT4/rng+x
	 44gl5fp3k94a15rfRCK1RmXIt/k7LdRSODhu6u1hsIw0eLCARo7cZoRxu/glZ+SB1V
	 225fntV7mizug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 26/60] net: ice: Fix potential NULL pointer dereference in ice_bridge_setlink()
Date: Wed, 13 Mar 2024 12:36:33 -0400
Message-ID: <20240313163707.615000-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
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
index d8d2aa4c0216a..d23f2ebddeb45 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7786,6 +7786,8 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	pf_sw = pf->first_sw;
 	/* find the attribute in the netlink message */
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
+	if (!br_spec)
+		return -EINVAL;
 
 	nla_for_each_nested(attr, br_spec, rem) {
 		__u16 mode;
-- 
2.43.0


