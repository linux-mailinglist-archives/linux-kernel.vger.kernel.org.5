Return-Path: <linux-kernel+bounces-115868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2411889854
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F02C1C31A87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023411591ED;
	Mon, 25 Mar 2024 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLxDbmf7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03F146009;
	Sun, 24 Mar 2024 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322066; cv=none; b=E4sKo6z+bV9oVCMIHRTeUYtAZf7nk1D8QxB5A8Qq9lhkQmsPyvetMCIzo4CvSqG74BQnQH14A8h2aPmY4+IYxYtoxU5NXrmoG1yfS3ztmoP9ANG6hGd2WbFD9TpkZUYq3oS6/gOLKvTkzXQS8cUvtYGkzrVwbKu9Fq3HCTPLsj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322066; c=relaxed/simple;
	bh=PixZTdAIXb+apt1+3VrFpubrgiRaiLYdNla0aHXf+/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqCST4TG29BArSe3tXQSPEskZpy1K3HJpel2i4ZSzntmAfRaeWMPq4X7QJrT61sFTskThqGDgAkfXmX6zNjxmSnAz396WlNTcuwcx2pHY+CiUzT6S7AD6SWB/WFSDI3QChRgLx9CfFnDNmMjMojed8LbbeDxZ2Fzfhvk/Ktue6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLxDbmf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9246AC43390;
	Sun, 24 Mar 2024 23:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322066;
	bh=PixZTdAIXb+apt1+3VrFpubrgiRaiLYdNla0aHXf+/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLxDbmf7rZZqUN+y2NnT6BF+inK0yldbC9w8Q+U8ZSniNCJZtoFQuxNOpe56e0b3q
	 OqKMaXYUMjlpN/2/h8Lx5Mr59MZcAT2fo/h+yp102zfOGr5IQMCUY14UJIIPiWyIOU
	 s1A5nIu+sv5RPycVxuoTQUqAmxkBVKtiEcasSLdzg0qa9o0rOYlrQdgUuxHwFxvkFF
	 0sRfsQAi3c46y+oA8wPuZCnO7vtkGQIiykgX1NA+vk0iZ7FApo/4PV7YbS9fLCWoqn
	 M1gNLlos0qH/0SPexVjVR+sLcLbt4H8nbs8dWRCFKDTjBme3SyKda2r3s3caW184gb
	 tplqNKL2zXjpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 139/451] selftests: forwarding: Add missing multicast routing config entries
Date: Sun, 24 Mar 2024 19:06:55 -0400
Message-ID: <20240324231207.1351418-140-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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

[ Upstream commit f0ddf15f0a74c27eb4b2271a90e69948acc3fa2c ]

The two tests that make use of multicast routig (router.sh and
router_multicast.sh) are currently failing in the netdev CI because the
kernel is missing multicast routing support.

Fix by adding the required config entries.

Fixes: 6d4efada3b82 ("selftests: forwarding: Add multicast routing test")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240208165538.1303021-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/forwarding/config | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index ba23435145827..8d7a1a004b7c3 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -9,6 +9,13 @@ CONFIG_CGROUP_BPF=y
 CONFIG_DUMMY=m
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=m
+CONFIG_IPV6_MROUTE=y
+CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
+CONFIG_IPV6_PIMSM_V2=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
 CONFIG_MACVLAN=m
 CONFIG_NET_ACT_CT=m
 CONFIG_NET_ACT_MIRRED=m
-- 
2.43.0


