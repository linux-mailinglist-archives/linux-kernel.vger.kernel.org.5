Return-Path: <linux-kernel+bounces-79392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB54862186
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60929B2156F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADA446A2;
	Sat, 24 Feb 2024 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkL76DTz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF374A04;
	Sat, 24 Feb 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737037; cv=none; b=m/AAgGdj5KzWDPs33RLXck70+dKnANejoxq/xRFdHl4Nkh5jIAuGHCxWPcpuQedDBAxA15/MxEPF/aE0/bHyLJ8ls+wsT9uOmEhgHVzesDb6mq2S+hH2vwvB+wh6Dry6+/ZbxSQN8SHeKJXwlNixjO6e5vgtnqD5mOjnZmkTX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737037; c=relaxed/simple;
	bh=msKREk70q3ImqTUICukC5SdxHULI8AGb91OrJny9Oqw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZSolXQ3UBUA3rCWE0tQJ2adwHGo+jjHjNCSFDB5FcPa0dETS7dOV0pj6CvNiePwGO38TxFehG0vJRw0TAVynV252hOwb7eYNooGj86StQ0NQZy9XYKp4gUBtIv15iD05k6lbZtVgWekw9DBgvWekP7GkP1Peyg/r5Dxt/UBXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkL76DTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF9BC433F1;
	Sat, 24 Feb 2024 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737037;
	bh=msKREk70q3ImqTUICukC5SdxHULI8AGb91OrJny9Oqw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kkL76DTzKcDSTjQSwB4C+ysgvOdvQkmyW1Sqj5/8ldjh/t2gAxF4QM8+KjTp/FMai
	 14hEgTJFsvRdedSplR0NSp5AeWtJ52axfGdOR/34A5uG04/0MqE57GPOw4CiusIuLD
	 QT2wOhFSGIGhhVr3riwpU5MUfQBmC2t0GC6SbZ37XmHbVii6B9FEYIG/R4JMpooFuo
	 1GSXmwAIhaYxAjG1L4WJ4CCJh7GSP6FjYLUDydkRT0J5f9ozp922wTinWZFAs9J9+t
	 a4ywM60luStALdGRxsjkl5MvMmH5LquqDO8yvUCMdTWc6bDMuwMEl6SX6R+MYNMbFb
	 ICgpzBuqfkO8Q==
Date: Fri, 23 Feb 2024 17:10:36 -0800
Subject: [PATCH 02/10] time_stats: split stats-with-quantiles into a separate
 structure
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873667973.1860949.13781519053507360563.stgit@frogsfrogsfrogs>
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

From: Darrick J. Wong <djwong@kernel.org>

Currently, struct time_stats has the optional ability to quantize the
information that it collects.  This is /probably/ useful for callers who
want to see quantized information, but it more than doubles the size of
the structure from 224 bytes to 464.  For users who don't care about
that (e.g. upcoming xfs patches) and want to avoid wasting 240 bytes per
counter, split the two into separate pieces.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/bcachefs.h     |    2 +-
 fs/bcachefs/io_write.c     |    2 +-
 fs/bcachefs/super.c        |   10 ++++------
 fs/bcachefs/sysfs.c        |    4 ++--
 fs/bcachefs/util.c         |    7 ++++---
 include/linux/time_stats.h |   36 ++++++++++++++++++++++++++++++++++--
 lib/time_stats.c           |   17 ++++++++++-------
 7 files changed, 56 insertions(+), 22 deletions(-)


diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 92547d6fd2d95..04e4a65909a4f 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -594,7 +594,7 @@ struct bch_dev {
 
 	/* The rest of this all shows up in sysfs */
 	atomic64_t		cur_latency[2];
-	struct time_stats	io_latency[2];
+	struct time_stats_quantiles	io_latency[2];
 
 #define CONGESTED_MAX		1024
 	atomic_t		congested;
diff --git a/fs/bcachefs/io_write.c b/fs/bcachefs/io_write.c
index 8123a84320e3f..3fa2cb1d5b13a 100644
--- a/fs/bcachefs/io_write.c
+++ b/fs/bcachefs/io_write.c
@@ -88,7 +88,7 @@ void bch2_latency_acct(struct bch_dev *ca, u64 submit_time, int rw)
 
 	bch2_congested_acct(ca, io_latency, now, rw);
 
-	__time_stats_update(&ca->io_latency[rw], submit_time, now);
+	__time_stats_update(&ca->io_latency[rw].stats, submit_time, now);
 }
 
 #endif
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index c491c5e102287..2c238030fb5d7 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -1168,8 +1168,8 @@ static void bch2_dev_free(struct bch_dev *ca)
 	bch2_dev_buckets_free(ca);
 	free_page((unsigned long) ca->sb_read_scratch);
 
-	time_stats_exit(&ca->io_latency[WRITE]);
-	time_stats_exit(&ca->io_latency[READ]);
+	time_stats_quantiles_exit(&ca->io_latency[WRITE]);
+	time_stats_quantiles_exit(&ca->io_latency[READ]);
 
 	percpu_ref_exit(&ca->io_ref);
 	percpu_ref_exit(&ca->ref);
@@ -1260,10 +1260,8 @@ static struct bch_dev *__bch2_dev_alloc(struct bch_fs *c,
 
 	INIT_WORK(&ca->io_error_work, bch2_io_error_work);
 
-	time_stats_init(&ca->io_latency[READ]);
-	time_stats_init(&ca->io_latency[WRITE]);
-	ca->io_latency[READ].quantiles_enabled = true;
-	ca->io_latency[WRITE].quantiles_enabled = true;
+	time_stats_quantiles_init(&ca->io_latency[READ]);
+	time_stats_quantiles_init(&ca->io_latency[WRITE]);
 
 	ca->mi = bch2_mi_to_cpu(member);
 
diff --git a/fs/bcachefs/sysfs.c b/fs/bcachefs/sysfs.c
index cee80c47feea2..c86a93a8d8fc8 100644
--- a/fs/bcachefs/sysfs.c
+++ b/fs/bcachefs/sysfs.c
@@ -930,10 +930,10 @@ SHOW(bch2_dev)
 	sysfs_print(io_latency_write,		atomic64_read(&ca->cur_latency[WRITE]));
 
 	if (attr == &sysfs_io_latency_stats_read)
-		bch2_time_stats_to_text(out, &ca->io_latency[READ]);
+		bch2_time_stats_to_text(out, &ca->io_latency[READ].stats);
 
 	if (attr == &sysfs_io_latency_stats_write)
-		bch2_time_stats_to_text(out, &ca->io_latency[WRITE]);
+		bch2_time_stats_to_text(out, &ca->io_latency[WRITE].stats);
 
 	sysfs_printf(congested,			"%u%%",
 		     clamp(atomic_read(&ca->congested), 0, CONGESTED_MAX)
diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index 88853513a15fa..ef620bfe76cd2 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -365,6 +365,7 @@ static inline void pr_name_and_units(struct printbuf *out, const char *name, u64
 
 void bch2_time_stats_to_text(struct printbuf *out, struct time_stats *stats)
 {
+	struct quantiles *quantiles = time_stats_to_quantiles(stats);
 	s64 f_mean = 0, d_mean = 0;
 	u64 f_stddev = 0, d_stddev = 0;
 
@@ -465,17 +466,17 @@ void bch2_time_stats_to_text(struct printbuf *out, struct time_stats *stats)
 
 	printbuf_tabstops_reset(out);
 
-	if (stats->quantiles_enabled) {
+	if (quantiles) {
 		int i = eytzinger0_first(NR_QUANTILES);
 		const struct time_unit *u =
-			pick_time_units(stats->quantiles.entries[i].m);
+			pick_time_units(quantiles->entries[i].m);
 		u64 last_q = 0;
 
 		prt_printf(out, "quantiles (%s):\t", u->name);
 		eytzinger0_for_each(i, NR_QUANTILES) {
 			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
 
-			u64 q = max(stats->quantiles.entries[i].m, last_q);
+			u64 q = max(quantiles->entries[i].m, last_q);
 			prt_printf(out, "%llu ", div_u64(q, u->nsecs));
 			if (is_last)
 				prt_newline(out);
diff --git a/include/linux/time_stats.h b/include/linux/time_stats.h
index eb1957cb77c0d..c05490101d197 100644
--- a/include/linux/time_stats.h
+++ b/include/linux/time_stats.h
@@ -27,6 +27,7 @@
 #include <linux/mean_and_variance.h>
 #include <linux/sched/clock.h>
 #include <linux/spinlock_types.h>
+#include <linux/string.h>
 
 struct time_unit {
 	const char	*name;
@@ -67,7 +68,6 @@ struct time_stat_buffer {
 
 struct time_stats {
 	spinlock_t	lock;
-	bool		quantiles_enabled;
 	/* all fields are in nanoseconds */
 	u64             min_duration;
 	u64		max_duration;
@@ -76,7 +76,12 @@ struct time_stats {
 	u64             min_freq;
 	u64		last_event;
 	u64		last_event_start;
-	struct quantiles quantiles;
+
+/*
+ * Is this really a struct time_stats_quantiled?  Hide this flag in the least
+ * significant bit of the start time to avoid blowing up the structure size.
+ */
+#define TIME_STATS_HAVE_QUANTILES	(1ULL << 0)
 
 	u64		start_time;
 
@@ -87,6 +92,22 @@ struct time_stats {
 	struct time_stat_buffer __percpu *buffer;
 };
 
+struct time_stats_quantiles {
+	struct time_stats	stats;
+	struct quantiles	quantiles;
+};
+
+static inline struct quantiles *time_stats_to_quantiles(struct time_stats *stats)
+{
+	struct time_stats_quantiles *statq;
+
+	if (!(stats->start_time & TIME_STATS_HAVE_QUANTILES))
+		return NULL;
+
+	statq = container_of(stats, struct time_stats_quantiles, stats);
+	return &statq->quantiles;
+}
+
 void __time_stats_clear_buffer(struct time_stats *, struct time_stat_buffer *);
 void __time_stats_update(struct time_stats *stats, u64, u64);
 
@@ -133,4 +154,15 @@ void time_stats_to_seq_buf(struct seq_buf *, struct time_stats *);
 void time_stats_exit(struct time_stats *);
 void time_stats_init(struct time_stats *);
 
+static inline void time_stats_quantiles_exit(struct time_stats_quantiles *statq)
+{
+	time_stats_exit(&statq->stats);
+}
+static inline void time_stats_quantiles_init(struct time_stats_quantiles *statq)
+{
+	time_stats_init(&statq->stats);
+	statq->stats.start_time |= TIME_STATS_HAVE_QUANTILES;
+	memset(&statq->quantiles, 0, sizeof(statq->quantiles));
+}
+
 #endif /* _LINUX_TIME_STATS_H */
diff --git a/lib/time_stats.c b/lib/time_stats.c
index 8df4b55fc6337..767b1a340e805 100644
--- a/lib/time_stats.c
+++ b/lib/time_stats.c
@@ -69,6 +69,8 @@ static inline void time_stats_update_one(struct time_stats *stats,
 	u64 duration, freq;
 
 	if (time_after64(end, start)) {
+		struct quantiles *quantiles = time_stats_to_quantiles(stats);
+
 		duration = end - start;
 		mean_and_variance_update(&stats->duration_stats, duration);
 		mean_and_variance_weighted_update(&stats->duration_stats_weighted, duration);
@@ -76,8 +78,8 @@ static inline void time_stats_update_one(struct time_stats *stats,
 		stats->min_duration = min(stats->min_duration, duration);
 		stats->total_duration += duration;
 
-		if (stats->quantiles_enabled)
-			quantiles_update(&stats->quantiles, duration);
+		if (quantiles)
+			quantiles_update(quantiles, duration);
 	}
 
 	if (stats->last_event && time_after64(end, stats->last_event)) {
@@ -160,11 +162,12 @@ static void seq_buf_time_units_aligned(struct seq_buf *out, u64 ns)
 
 static inline u64 time_stats_lifetime(const struct time_stats *stats)
 {
-	return local_clock() - stats->start_time;
+	return local_clock() - (stats->start_time & ~TIME_STATS_HAVE_QUANTILES);
 }
 
 void time_stats_to_seq_buf(struct seq_buf *out, struct time_stats *stats)
 {
+	struct quantiles *quantiles = time_stats_to_quantiles(stats);
 	s64 f_mean = 0, d_mean = 0;
 	u64 f_stddev = 0, d_stddev = 0;
 	u64 lifetime = time_stats_lifetime(stats);
@@ -239,17 +242,17 @@ void time_stats_to_seq_buf(struct seq_buf *out, struct time_stats *stats)
 	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->freq_stats_weighted));
 	seq_buf_printf(out, "\n");
 
-	if (stats->quantiles_enabled) {
+	if (quantiles) {
 		int i = eytzinger0_first(NR_QUANTILES);
 		const struct time_unit *u =
-			pick_time_units(stats->quantiles.entries[i].m);
+			pick_time_units(quantiles->entries[i].m);
 		u64 last_q = 0;
 
 		seq_buf_printf(out, "quantiles (%s):\t", u->name);
 		eytzinger0_for_each(i, NR_QUANTILES) {
 			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
 
-			u64 q = max(stats->quantiles.entries[i].m, last_q);
+			u64 q = max(quantiles->entries[i].m, last_q);
 			seq_buf_printf(out, "%llu ", div_u64(q, u->nsecs));
 			if (is_last)
 				seq_buf_printf(out, "\n");
@@ -272,7 +275,7 @@ void time_stats_init(struct time_stats *stats)
 	stats->freq_stats_weighted.weight = 8;
 	stats->min_duration = U64_MAX;
 	stats->min_freq = U64_MAX;
-	stats->start_time = local_clock();
+	stats->start_time = local_clock() & ~TIME_STATS_HAVE_QUANTILES;
 	spin_lock_init(&stats->lock);
 }
 EXPORT_SYMBOL_GPL(time_stats_init);


