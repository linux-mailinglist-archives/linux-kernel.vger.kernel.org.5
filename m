Return-Path: <linux-kernel+bounces-79400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CC086219B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7E4282372
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38234A3C;
	Sat, 24 Feb 2024 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2oEJ8za"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F35C4688;
	Sat, 24 Feb 2024 01:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737163; cv=none; b=UyEUYoMm43u+huc7Kb8zZ6HEuYYNQbG2YeJSRRiDXQmWlb51PGcgTzXpXrlo6j49SH8WmVb7T9hLqKAdMCkiUQZiBP5sRie/7UlI6k4tH6jO7Dduu8sc4j+NgZeU3y1dDR9o39VMHtRow9FGPYKQ4qKN/iR27/Q0Wyxdhrjtqpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737163; c=relaxed/simple;
	bh=RhYBozOR/vT83f2iUyIcPaS4H6kLQSPsmlviIcctaow=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiEHz9yL5BkPbgMpgTgSmNEB6tdGm+28tg8unXNHEJU8x8uEtMmNP5h2jwXxhptQf4C/0koHHFdS05PePeAnYfSsXBTrZVeZK2G9mzh6869iCmqqCvA3noLk6Vw0PxxoEQnUFUdEmsqIE22kSNWXKFm97w+MoNelW9A/+E+A4os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2oEJ8za; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8701CC433C7;
	Sat, 24 Feb 2024 01:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737162;
	bh=RhYBozOR/vT83f2iUyIcPaS4H6kLQSPsmlviIcctaow=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=h2oEJ8zaC+YKy5CgRKbFQx0lMXQlGzNEjspfXJR6hq5ulRxPCZ6SckWUKHw6+0eTO
	 TtGIYKBjDtv6qQV4e/GBHql5tt9/6pXJP/T3M1TmU6oVHWdrG9fwNxWXTLDOoEM3US
	 7ipzqEFeTVBXDJCemRPIZoiZk4/QVrLZTuWy3wNWQzgyVtWatnF6Wq/E0XXLYv9jy1
	 pTMAOWwG6hpZXMlrHsUTJGTE/xozmleLVQag3ZMpcnvasAJFL+wNUsJItR6TgOX/cL
	 ugrbPGr+/8HQjpsYmEjxR2IjeXZAnVi2cD33BBV0tOOnYTs/HRjwASugskt0oLT54T
	 Il7reyJ6cB68A==
Date: Fri, 23 Feb 2024 17:12:42 -0800
Subject: [PATCH 10/10] time_stats: Kill TIME_STATS_HAVE_QUANTILES
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873668101.1860949.4100731238233533238.stgit@frogsfrogsfrogs>
In-Reply-To: <170873667916.1860949.11027844260383646446.stgit@frogsfrogsfrogs>
References: <170873667916.1860949.11027844260383646446.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Kent Overstreet <kent.overstreet@linux.dev>

We have 4 spare bytes next to the spinlock, no need for bit stuffing

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 include/linux/time_stats.h |   19 +++++--------------
 lib/time_stats.c           |    4 ++--
 2 files changed, 7 insertions(+), 16 deletions(-)


diff --git a/include/linux/time_stats.h b/include/linux/time_stats.h
index 4e1f5485ed039..6df2b34aa274b 100644
--- a/include/linux/time_stats.h
+++ b/include/linux/time_stats.h
@@ -68,6 +68,7 @@ struct time_stat_buffer {
 
 struct time_stats {
 	spinlock_t	lock;
+	bool		have_quantiles;
 	/* all fields are in nanoseconds */
 	u64             min_duration;
 	u64		max_duration;
@@ -87,12 +88,6 @@ struct time_stats {
 	struct mean_and_variance_weighted freq_stats_weighted;
 	struct time_stat_buffer __percpu *buffer;
 
-/*
- * Is this really a struct time_stats_quantiled?  Hide this flag in the least
- * significant bit of the start time to avoid blowing up the structure size.
- */
-#define TIME_STATS_HAVE_QUANTILES	(1ULL << 0)
-
 	u64		start_time;
 };
 
@@ -103,13 +98,9 @@ struct time_stats_quantiles {
 
 static inline struct quantiles *time_stats_to_quantiles(struct time_stats *stats)
 {
-	struct time_stats_quantiles *statq;
-
-	if (!(stats->start_time & TIME_STATS_HAVE_QUANTILES))
-		return NULL;
-
-	statq = container_of(stats, struct time_stats_quantiles, stats);
-	return &statq->quantiles;
+	return stats->have_quantiles
+		? &container_of(stats, struct time_stats_quantiles, stats)->quantiles
+		: NULL;
 }
 
 void __time_stats_clear_buffer(struct time_stats *, struct time_stat_buffer *);
@@ -169,7 +160,7 @@ static inline void time_stats_quantiles_exit(struct time_stats_quantiles *statq)
 static inline void time_stats_quantiles_init(struct time_stats_quantiles *statq)
 {
 	time_stats_init(&statq->stats);
-	statq->stats.start_time |= TIME_STATS_HAVE_QUANTILES;
+	statq->stats.have_quantiles = true;
 	memset(&statq->quantiles, 0, sizeof(statq->quantiles));
 }
 
diff --git a/lib/time_stats.c b/lib/time_stats.c
index c0f209dd9f6dd..0b90c80cba9f1 100644
--- a/lib/time_stats.c
+++ b/lib/time_stats.c
@@ -164,7 +164,7 @@ static void seq_buf_time_units_aligned(struct seq_buf *out, u64 ns)
 
 static inline u64 time_stats_lifetime(const struct time_stats *stats)
 {
-	return local_clock() - (stats->start_time & ~TIME_STATS_HAVE_QUANTILES);
+	return local_clock() - stats->start_time;
 }
 
 void time_stats_to_seq_buf(struct seq_buf *out, struct time_stats *stats,
@@ -364,7 +364,7 @@ void time_stats_init(struct time_stats *stats)
 	memset(stats, 0, sizeof(*stats));
 	stats->min_duration = U64_MAX;
 	stats->min_freq = U64_MAX;
-	stats->start_time = local_clock() & ~TIME_STATS_HAVE_QUANTILES;
+	stats->start_time = local_clock();
 	spin_lock_init(&stats->lock);
 }
 EXPORT_SYMBOL_GPL(time_stats_init);


