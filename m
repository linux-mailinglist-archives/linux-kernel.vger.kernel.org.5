Return-Path: <linux-kernel+bounces-102036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D0A87ADCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B9F1F275F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7279A151747;
	Wed, 13 Mar 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv6dvlTI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A21509BC;
	Wed, 13 Mar 2024 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348416; cv=none; b=Kty7SsTPFuT/Xz4AfTJYbVXX0QXnVkpfSTYEEsjF85YSiblc9+cpRHB2rcQNNKcqH6HQ6mm3s5nJocoIcwJfwY3o39x3F6X7A2oAiLpQz/vXf44uoFtOpg5vY4s5HiEqge8Ga4JMTTrDqk+80bw51yaBo4cDX5GAZhmrpu1e+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348416; c=relaxed/simple;
	bh=6sZaOpEhDxBzFfUd2Ul0Ib1mehc6KTxJzYSZUj8BI3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3m4VEjTKWzTTZmNTjkzwoSHg04lWXH2DLKrCoHQywaskrnW9Y3aqMLxGaYwe6Z57/JGZDlWUn/8rn/SQwA109r2HzYxoohL7Ukt7cAaRcr7//EoTvAynqL//bVo4b8utqsnubqmAlXzAIFpC87V21m/tjd4ETZH2815BHvExfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv6dvlTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54B1C43399;
	Wed, 13 Mar 2024 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348416;
	bh=6sZaOpEhDxBzFfUd2Ul0Ib1mehc6KTxJzYSZUj8BI3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yv6dvlTIroQLPCICfz6s8KE0veEWIqZH6jiXVWk16y3Mwn+T4HpDdiouWl9RKXfUF
	 FLZq/yCl3apsYsLN9PjJLqEP/yL9QAYf+G7JdgQQp66Oy9y+jxO+mrPVTQpeKvd6OK
	 OBBb68j2j24XZ7kYvYEg2c4B8TO4pi8BvfbkudzZ2DinLk9JVGrm89XjfUr+ssa5fF
	 rN0cByhf27uMqCZvrHZBLhk6BovG4ViEfny9zJ4est1f0g0qT28GTQp0HGdSXoYDpL
	 wdVM68bkL5ryUeyEhU6GkqE5H7RN2jWdTlR6d1xwL24VeswkHl5TdaQisyKFp9/RJ4
	 D4ElN9ovpqMPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 12/73] net: ice: Fix potential NULL pointer dereference in ice_bridge_setlink()
Date: Wed, 13 Mar 2024 12:45:39 -0400
Message-ID: <20240313164640.616049-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index 02f72fbec1042..035bc90c81246 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6546,6 +6546,8 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	pf_sw = pf->first_sw;
 	/* find the attribute in the netlink message */
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
+	if (!br_spec)
+		return -EINVAL;
 
 	nla_for_each_nested(attr, br_spec, rem) {
 		__u16 mode;
-- 
2.43.0


