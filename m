Return-Path: <linux-kernel+bounces-113695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16A3888613
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706C21F2490D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D905C128381;
	Sun, 24 Mar 2024 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiFGIXcE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622C1DA14B;
	Sun, 24 Mar 2024 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320672; cv=none; b=i5H8AtXAIKi5L5qlHqH9psOFv4wbHs8h2gfNkL/o4qsPebHIp6m2CxrUQKKC/ryeZOnzESmJfJKDOwud0ak4gG1XcvpuU95mMO4e4FSyunaJ3zutjcJFGrPe8D0q+U0e523iOPr+lDRwY9Y7ByBNWHanAceQEU239UrSZKQq5ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320672; c=relaxed/simple;
	bh=PixZTdAIXb+apt1+3VrFpubrgiRaiLYdNla0aHXf+/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EURAH6kIKEarO07pYi+BT+63t0UHi9H4h2Gxz4cVhNz9eOKdSr9c2bzJDaYpnf98muGbVnXoWmqgpFVeSrKd4fztGd5UNVLROxXMcUcYGuEtiT0Eshj+shzja1p8E9SwNtCGC4eZnn1NbI+BhdeJYgna7M+zzqVun1dzuWj/vPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiFGIXcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AEEC433C7;
	Sun, 24 Mar 2024 22:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320671;
	bh=PixZTdAIXb+apt1+3VrFpubrgiRaiLYdNla0aHXf+/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiFGIXcEE76B2RYEH4rM3usAbm/fbBJoL3Xcn7Uj9+gHIgCHPxBisJPOhP1qQpNcw
	 mS9hAfcllMq+BpLDgOhOnzXOMtrHi3dYq3yesg5KKVyds/3Zv61nD75aoBRJmLJTvE
	 mQDuiYp4MtdNuxUS1oFaZXOSJ7Mf1XHuMj6UTe2PTGZW4hL6STXPf+sCwNe2aD4ZFJ
	 yvMkxQ07Ldz+K6xB3fp94iFgKTH7ELm9ylUV0JIeCtOJtFLFsIKWu+b/6lKxnht/kl
	 HWgawzvssseAA+qPtLM61jaajUEhG2TJMMa6hu5On6VuN06PdJ6XybMRv+XrTIhfmf
	 MXrK6L77TpjAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 234/713] selftests: forwarding: Add missing multicast routing config entries
Date: Sun, 24 Mar 2024 18:39:20 -0400
Message-ID: <20240324224720.1345309-235-sashal@kernel.org>
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


