Return-Path: <linux-kernel+bounces-134492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D210F89B226
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601F81F21596
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F408139D16;
	Sun,  7 Apr 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BF5yNQ1k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FCD44362;
	Sun,  7 Apr 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495660; cv=none; b=ezK2x6QzL5+qMVmmkiurw9j4Xvf1MTb+NyLXllS+uA0MN3lz9k/XXHMpvOrqOXXlauhKpHlViToNXpgNPYJVVvlCO/gaKVQL2CXVOrh7/gvO8v+hzYt5ewLE46CJeaZ18aTPF6UvrvvjkKgaNYdMtdsWXgDENjniE1qzZEpXpcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495660; c=relaxed/simple;
	bh=1NzUqIhQUw0pUe7nLFQssgf7KbYhzzTGgnIhREc4e5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMfqWhTKWJKq8Ws8YSpuU+B+0CBZ5prwSCwHkcdq6/mo1PjRqmNEZBxccDGbUieZEXw8S8ZFqv9f2AK9Nl2lETMyjQNhqc9aKSZqopEZG4rx4L4gxWzIaYVnk03Aa4QfATbIv6jcXJtphcg17hTzQF3smu9A9UhrBhsRI4/v7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BF5yNQ1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA008C433A6;
	Sun,  7 Apr 2024 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495660;
	bh=1NzUqIhQUw0pUe7nLFQssgf7KbYhzzTGgnIhREc4e5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BF5yNQ1k62rOFvuTQ+6cNgOe7atGshTegcxhVDRgtGmL0jYDH3vw1vhPgh8OrZ3I5
	 6r58NaTBVmFRwjsp/PA8pHmx/rduTiYJjHXxFTFE1rSZbdOYvcJAihMI8ASLAK9qjR
	 Lh+kTKORyQV2dHlor/Tj+/1BgSjSDWoVuRtdeSn1ZzlbkyLOc+IY0xEdPxskhGeXxx
	 n/jpucPsUMcGD/eV5R8dblMh8CV7mN0utosfAZriBYpDT8YInivHSFuKuL72P6Hlzm
	 olfbAqVHeLpG7dbcxNM3NKbDo901atO6vJ6Jg8uvFXdZzZX1pHxhBRMZhAls936CzH
	 rgBMlbQB7Ethg==
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
Subject: [PATCH AUTOSEL 5.4 4/6] wifi: cfg80211: fix rdev_dump_mpp() arguments order
Date: Sun,  7 Apr 2024 09:14:10 -0400
Message-ID: <20240407131414.1053600-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131414.1053600-1-sashal@kernel.org>
References: <20240407131414.1053600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 8677d7ab7d692..630b72355ebb5 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -938,7 +938,7 @@ TRACE_EVENT(rdev_get_mpp,
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


