Return-Path: <linux-kernel+bounces-134464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4E889B1CF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD121F21231
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD4012EBFB;
	Sun,  7 Apr 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7Ym0JV7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E83F12EBD4;
	Sun,  7 Apr 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495607; cv=none; b=QgxhdL2JilJCF28bZP+4rwPwSmdWbHIP4QVP4zKt8TCsPFFuVo6H4Xnji/58OssoqwpKfrpc+vo92ZsaBPOvR8On9Ctihs9ndVR2fSkO4aHjQt23Wa+oFB//7MSrC5qeSk0HjWpKmgkuZJtkmhU28G8/xN7X+N3J+u8g6D+s0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495607; c=relaxed/simple;
	bh=GWLDa1uF55cdQb1ecNtNFSKFq+lJSnlzpJT7fuHUTQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qc9IJXNYWk3hS+cMqOefS4OBbTivoQxVZWHO5C//GT32xPftaNqYDbAZb6gQb2zB3aWZrmnqyojz8aPzrqNx5EfQ76kWYxRepUz2pW4DSzFpICqGkryNJWXUufZ1Oh9l8xGW4UTjIUYgdArfa158Br/7FUShBNVMTJs7pSpwFRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7Ym0JV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3642C433A6;
	Sun,  7 Apr 2024 13:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495607;
	bh=GWLDa1uF55cdQb1ecNtNFSKFq+lJSnlzpJT7fuHUTQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7Ym0JV7w4UX1cZ2Q0enAtOqfNVwjeRUuu9caJMIis8/3BtgjYTQlx6c2UXC5j26g
	 wh9dLdLS/lwqCVX7Yjua9+G/vzukvdUHLcBBVwVLz8k369Th7qWkMoUVNZJBQI0o2r
	 zIG1KO9/1VFTX2GSpyMhZhXMZihMHMkAeyP2YN5TBPvjqATtJmXikgnv3PmIBo97wa
	 tGwuSCWPI55eW1B8sn7j+f2DUEo/HpwfSs56nkxLr8iYXI4A8GvSFngQIL9Ziibm6F
	 dRq/Iea1SEl9Ip3s5f7hqzSnYC/W7euc5tBStHAsQ97VjwFqwljIFRbubsBklfo+xr
	 yIxCf4Uh/HOmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/13] wifi: cfg80211: fix rdev_dump_mpp() arguments order
Date: Sun,  7 Apr 2024 09:13:06 -0400
Message-ID: <20240407131316.1052393-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131316.1052393-1-sashal@kernel.org>
References: <20240407131316.1052393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit

From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>

[ Upstream commit ec50f3114e55406a1aad24b7dfaa1c3f4336d8eb ]

Fix the order of arguments in the TP_ARGS macro
for the rdev_dump_mpp tracepoint event.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Link: https://msgid.link/20240311164519.118398-1-Igor.A.Artemiev@mcst.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index a405c3edbc47e..cb5c3224e038a 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1018,7 +1018,7 @@ TRACE_EVENT(rdev_get_mpp,
 TRACE_EVENT(rdev_dump_mpp,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int _idx,
 		 u8 *dst, u8 *mpp),
-	TP_ARGS(wiphy, netdev, _idx, mpp, dst),
+	TP_ARGS(wiphy, netdev, _idx, dst, mpp),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
-- 
2.43.0


