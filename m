Return-Path: <linux-kernel+bounces-3608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5DC816E60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A037288F17
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BD883B10;
	Mon, 18 Dec 2023 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0/SfnBg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4AC1D15F;
	Mon, 18 Dec 2023 12:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6C3C433C8;
	Mon, 18 Dec 2023 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903475;
	bh=BO9AvPr/z4kybGkExUeBUTRhD5PbszGbBwKdcjCEF7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0/SfnBg+iVA0jIyJI1PrU2ZwsEcCcl5wd1l8w84bQ29yNApTGywK7EheqzFLh+qY
	 f5YTo08e7XOaRpjsOUMXyZ7kGet3nznwv7VbFb7eYEfvesLkeIQTpWkkCt+iEkPSui
	 eWthGveF+oqXRZn+ulc40lOUCBh3y2RpefCQwoI9kl0H5oDWAL0aEDJxMTYVZejIM3
	 MUnnAizm/Y5jYU61xGLfsslzh+w1Z2xSA/q0HGW6+dz2VBdwCFsfw+lCrG5Hxe21gx
	 J8SafW6aVpF2QVl673bWJlqW+I8dQ5IELfkx2pGE0D3FyTwJO+NJBdmUUzJl1L1PPo
	 ghXRJMBmBvQXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Judy Hsiao <judyhsiao@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	kuba@kernel.org,
	pabeni@redhat.com,
	joel.granados@gmail.com,
	haleyb.dev@gmail.com,
	ja@ssi.bg,
	leon@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/18] neighbour: Don't let neigh_forced_gc() disable preemption for long
Date: Mon, 18 Dec 2023 07:43:42 -0500
Message-ID: <20231218124415.1379060-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124415.1379060-1-sashal@kernel.org>
References: <20231218124415.1379060-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.7
Content-Transfer-Encoding: 8bit

From: Judy Hsiao <judyhsiao@chromium.org>

[ Upstream commit e5dc5afff62f3e97e86c3643ec9fcad23de4f2d3 ]

We are seeing cases where neigh_cleanup_and_release() is called by
neigh_forced_gc() many times in a row with preemption turned off.
When running on a low powered CPU at a low CPU frequency, this has
been measured to keep preemption off for ~10 ms. That's not great on a
system with HZ=1000 which expects tasks to be able to schedule in
with ~1ms latency.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/neighbour.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index df81c1f0a5704..552719c3bbc3d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 {
 	int max_clean = atomic_read(&tbl->gc_entries) -
 			READ_ONCE(tbl->gc_thresh2);
+	u64 tmax = ktime_get_ns() + NSEC_PER_MSEC;
 	unsigned long tref = jiffies - 5 * HZ;
 	struct neighbour *n, *tmp;
 	int shrunk = 0;
+	int loop = 0;
 
 	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
 
@@ -278,11 +280,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 				shrunk++;
 			if (shrunk >= max_clean)
 				break;
+			if (++loop == 16) {
+				if (ktime_get_ns() > tmax)
+					goto unlock;
+				loop = 0;
+			}
 		}
 	}
 
 	WRITE_ONCE(tbl->last_flush, jiffies);
-
+unlock:
 	write_unlock_bh(&tbl->lock);
 
 	return shrunk;
-- 
2.43.0


