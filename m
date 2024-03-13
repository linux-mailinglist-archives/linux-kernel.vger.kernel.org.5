Return-Path: <linux-kernel+bounces-101769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CDB87AB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408FB28DBDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0160DEA;
	Wed, 13 Mar 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFPzA4Fz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0160DD6;
	Wed, 13 Mar 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347596; cv=none; b=hUKCiuNIpEzfveXJ8+V8pxBKf5HjApRPYTB+YaxaL7WbTf6M1N66p2LJ1ZpNK3hMwaxSwXmGjmPvbpwhUxiNphNrFB2tN/dt511bShMFRgLo6hEB+Fzv2dvcRuk7P4nFv4VPAuHSclQ8k3x2arC5n13TDeiKGUyi9RDp1kLBi0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347596; c=relaxed/simple;
	bh=VQ7lua7WzcnMrXcBFn4KATcpoXmgnrHjWM09UbvwGTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F15KFco0Ydhxe8ZkGN+5dpxiV1pgxRUHciKhKTw5oV53uasbzjK0EB45LTGCGx+TJJkF9fANowJI9YYAr45sSXHlxCem7cjQdZZM5MmPyuk7qfbaDKgZX6xZjOCPKX5kaIptbrGFqGqLAuXggNa3dPmFut8Hr9eyKab/cYf6P6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFPzA4Fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CB5C43390;
	Wed, 13 Mar 2024 16:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347595;
	bh=VQ7lua7WzcnMrXcBFn4KATcpoXmgnrHjWM09UbvwGTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pFPzA4FzCPPxwO1u2gfbejxOHYu0fW4z6rkxNVGD7xe3s3sfYOMs+EU17X4qBjwmc
	 EqzPmgLR/NvrTYwYlD1v3AJ9ItmbwImxPJxf7KZylMH2zRTxGP7e564v2vjqikcLbR
	 Ef0GOHvBIV6mFN8qgixHSn004GRbtP5vpL0q44aYGUVZulG79/4Qt9FQscBqO05iD+
	 SuhVrdrFRqnh27NAWOusVLl4Sg1PyO8+nbCapTwCsn2DAdJQyY5TfYBIeGdftovFbn
	 VmwDnx8xwh0N1esAdEru6eIKvs5mGHraFQLe4GifNvhDIPDBZPPrSvHa6uiEwynHLV
	 pT6p4zv5Hy+aA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 30/61] net: ice: Fix potential NULL pointer dereference in ice_bridge_setlink()
Date: Wed, 13 Mar 2024 12:32:05 -0400
Message-ID: <20240313163236.613880-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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
index adfdea1e2805a..a9cca2d24120a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7800,6 +7800,8 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	pf_sw = pf->first_sw;
 	/* find the attribute in the netlink message */
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
+	if (!br_spec)
+		return -EINVAL;
 
 	nla_for_each_nested(attr, br_spec, rem) {
 		__u16 mode;
-- 
2.43.0


