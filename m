Return-Path: <linux-kernel+bounces-3651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60990816F11
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE301C23D03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D7C7AE9B;
	Mon, 18 Dec 2023 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVuxmojH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560CD7BF19;
	Mon, 18 Dec 2023 12:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59125C433C7;
	Mon, 18 Dec 2023 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903605;
	bh=x696ipv4HxFzYbI7HG2uz3GmrymnQNpwwBf/5I4SA0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVuxmojHEQcaytcf3k+TZjceGWcdocPOauUZdleYLKqumuTNVSe+Nnovwfi4DNRlO
	 ncggASzw3uecKVnG9oz3HgJcgguWVimBf4RUTCmofX6js/afRdcfHolgJi8COogYcX
	 ECw1iuoT4vyFByXOMjsh3pLhDZAlOIzDw0ufKqh+1Y51LMTfyn3NCR415NzS/BU3e/
	 ErmwryLf4cni0mjYYspoXqdODKGRzaME3GQHvxfy6h9l2CtqEXEmarueeunSng8KKk
	 u1IrYCbk9wEjQedFuOwv43ESs3u+BlpZgk0vg/ATD2Pe1aweIHX1dGNA27RNFnxIIJ
	 LQfGhc8mMkfrw==
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
	leon@kernel.org,
	joel.granados@gmail.com,
	ja@ssi.bg,
	haleyb.dev@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 4/8] neighbour: Don't let neigh_forced_gc() disable preemption for long
Date: Mon, 18 Dec 2023 07:46:25 -0500
Message-ID: <20231218124635.1381482-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124635.1381482-1-sashal@kernel.org>
References: <20231218124635.1381482-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.204
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
index 4c43183a8d93a..432e3a64dc4a5 100644
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


