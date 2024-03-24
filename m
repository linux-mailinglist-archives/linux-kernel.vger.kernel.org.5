Return-Path: <linux-kernel+bounces-113066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E6D888131
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4591CB22961
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DBE1487D9;
	Sun, 24 Mar 2024 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKJy8KXS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9AA1487F8;
	Sun, 24 Mar 2024 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319874; cv=none; b=K+k38jpZcRJhnsxDO09mSQBy+9UYTtk9T03EjeQFhHmOskglGDUvE5FkbIUDOQkgH1C8l/k6k2yOgHsexRZ7u2RsLbfNNpeh1ysryTaz4BuK4oAxQlqHODu1B9rb5DO2GwqXIvYHXIjJsJ+nDO58zhZ6dchgeTO/bHr4LDqdgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319874; c=relaxed/simple;
	bh=PixZTdAIXb+apt1+3VrFpubrgiRaiLYdNla0aHXf+/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2WSqW5YGXHjKTccizDtQoqnJ3jOKZcjldBfVnDX/Rss38nbXLORnZV+Ov93xjXfu/3Z9vAXUizUS68LXXj0wZX/y9ygYJGdXRRR2n3Vfx+nrf16PkNDHwRumzPOKQ3od1018xfbhzfQhRJHb/sIxNdTjWjhFVamlYCHCAEN6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKJy8KXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4A2C433F1;
	Sun, 24 Mar 2024 22:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319874;
	bh=PixZTdAIXb+apt1+3VrFpubrgiRaiLYdNla0aHXf+/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKJy8KXS6g8NwWxJfYCq3AqkcVWjmBfCSARm7Lk4HCw3urdpu9cIUKUJHoHn7LRNU
	 5DU2xvxWPyz1pANRz4DljkKmnhoD9PeaF3HdmqS9Djd5WStaWXoDWRbFs+eB0rYXJL
	 49B2VbY85IcgbTneTAyQ762eqOlFnJphpyz1xqW38p1mIHPBgAXwt+5jnyBQWpDFL7
	 ZgbciDmuhBosGSLnkfOQurl6r4Qyv+/MzRgRl4DkHLbGIP+Npk8QBXBd5VQaitHGxz
	 fEtov+CaLea7/Bekc3c8frhrl7FVLScGVdyNIsjLP9GDt8WIrT7+mdzJANxg036+LG
	 dfSaFBuOlAI1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 179/715] selftests: forwarding: Add missing multicast routing config entries
Date: Sun, 24 Mar 2024 18:25:58 -0400
Message-ID: <20240324223455.1342824-180-sashal@kernel.org>
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


