Return-Path: <linux-kernel+bounces-3661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B4E816F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679181F220C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA9584D57;
	Mon, 18 Dec 2023 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqddNTbs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8E83539;
	Mon, 18 Dec 2023 12:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B55C433C8;
	Mon, 18 Dec 2023 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903627;
	bh=+OVnW9vNlawrZz1istndX1LrRMdDvVBnU24JfXpxuPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqddNTbs5ghWquCMmYw2ajxJhifTnkKN1j92poqObsQ/JMsdHCZo2YUlh8Cvtj2m5
	 xBsXcYRPXaz03zKbbIlVf5qR9ahJNfaX0FcpOsV8ND91k/pSXdYyeIY8rsruNCsYGN
	 FEOlfp8qIjXwHZhcmzL4dwtPfbtvHXE1rfJHiD/2dIEv0GXQdQcdceNEH7TueU3GNC
	 2yHjFrhP061PvlvFVBQLawZhTZviEYjNoCiMhlaxxsUFVfgAwDh+tp8JKYqNsaQySN
	 6CRZHSxragdLBbF0o8EWQKS3jxLtaQcE/SD4o8SXiwe3vmcrAgtXhz3K6Ur64EYgQO
	 /qLa76TP9g+YA==
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
	martin.lau@kernel.org,
	ja@ssi.bg,
	joel.granados@gmail.com,
	leon@kernel.org,
	haleyb.dev@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/7] neighbour: Don't let neigh_forced_gc() disable preemption for long
Date: Mon, 18 Dec 2023 07:46:49 -0500
Message-ID: <20231218124656.1381949-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124656.1381949-1-sashal@kernel.org>
References: <20231218124656.1381949-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.264
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
index 9d631b7adb7bf..e571007d083cc 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -226,9 +226,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 {
 	int max_clean = atomic_read(&tbl->gc_entries) -
 			READ_ONCE(tbl->gc_thresh2);
+	u64 tmax = ktime_get_ns() + NSEC_PER_MSEC;
 	unsigned long tref = jiffies - 5 * HZ;
 	struct neighbour *n, *tmp;
 	int shrunk = 0;
+	int loop = 0;
 
 	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
 
@@ -251,11 +253,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
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


