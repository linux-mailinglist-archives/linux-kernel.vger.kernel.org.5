Return-Path: <linux-kernel+bounces-79389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3610B862180
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F201F2640A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDC14C85;
	Sat, 24 Feb 2024 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBNB9jVX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94D4688;
	Sat, 24 Feb 2024 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708736991; cv=none; b=mX1vOBP9a8v37ySYQ2eLHLFNT95diNzOdXPyvr543YilHT809aY18cqHmnVP/z0UJN0bais4WpzwDxW/mcwfDan3jCU3HP7INbBFZAqOV1f+jR8J0H0TmBCRprKbRxCKxN1iH6NstsPEwnXT3tyTd/0q1d6PwPppfZNK3W1EPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708736991; c=relaxed/simple;
	bh=tF9SS+JmqlkwJ1Y/iR+OPAOLG4h+F9rL1sNHHIen+9o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdJ7ca9FnamG8oJDJNww4Pu766Ncrame6auW7G6ieuA63ePe92z8PFOxLesqyaR7AX6Q4/xL3Y9n0GegRAvXrLSN6mweWExZYPu6GPlMwRoBsbXHIbljC3gpU2AuHXF3jQzZBvsu26y+LDTXcS1/YA25P9Y11QSZLPfR4eVRReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBNB9jVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B74C433C7;
	Sat, 24 Feb 2024 01:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708736990;
	bh=tF9SS+JmqlkwJ1Y/iR+OPAOLG4h+F9rL1sNHHIen+9o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MBNB9jVXENWv1mgIVbGIBX/zunK/LTBsF54DbX35KNQ7/ZvRsrN0kmMPI0gpXx3+M
	 mcqA3LuSr6bbEytWruXP21elVDz415QDLBv+V3yD0StRLmAPhQqoxLc1tAgz0/2F4+
	 1eIWfisHWN5W39iSfpbU8UpbtSbG/8g9UpL5GHlvvmHJtwkT0CmRYRXC7BJNqu80GY
	 F8bOr9N3h+7Yx/SQgnEFTPOmnT51rMjw5E9UQLBtohwrdFuu3zpei8lYaoxIwFMjvR
	 +B4d7fcwzudTbdCYSbhVhrYhTCKPWZB/gLfHSxuHo2bp4AYG15MQ12lINQ8kA+SVO9
	 RgIRNMq931nKg==
Date: Fri, 23 Feb 2024 17:09:49 -0800
Subject: [PATCH 3/4] bcachefs: bch2_time_stats_to_seq_buf()
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873667547.1860799.14052301166913996641.stgit@frogsfrogsfrogs>
In-Reply-To: <170873667479.1860799.16660964083961996807.stgit@frogsfrogsfrogs>
References: <170873667479.1860799.16660964083961996807.stgit@frogsfrogsfrogs>
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

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/bcachefs/super.c |    2 +
 fs/bcachefs/util.c  |  133 +++++++++++++++++++++++++++++++++++++++++++++------
 fs/bcachefs/util.h  |    4 ++
 3 files changed, 123 insertions(+), 16 deletions(-)


diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 6b23e11825e6d..b9e2c1032b920 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -1262,6 +1262,8 @@ static struct bch_dev *__bch2_dev_alloc(struct bch_fs *c,
 
 	bch2_time_stats_init(&ca->io_latency[READ]);
 	bch2_time_stats_init(&ca->io_latency[WRITE]);
+	ca->io_latency[READ].quantiles_enabled = true;
+	ca->io_latency[WRITE].quantiles_enabled = true;
 
 	ca->mi = bch2_mi_to_cpu(member);
 
diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index 902f6b1a8a142..4c63f81e18bc4 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -506,10 +506,8 @@ static inline void pr_name_and_units(struct printbuf *out, const char *name, u64
 
 void bch2_time_stats_to_text(struct printbuf *out, struct bch2_time_stats *stats)
 {
-	const struct time_unit *u;
 	s64 f_mean = 0, d_mean = 0;
-	u64 q, last_q = 0, f_stddev = 0, d_stddev = 0;
-	int i;
+	u64 f_stddev = 0, d_stddev = 0;
 
 	if (stats->buffer) {
 		int cpu;
@@ -608,19 +606,122 @@ void bch2_time_stats_to_text(struct printbuf *out, struct bch2_time_stats *stats
 
 	printbuf_tabstops_reset(out);
 
-	i = eytzinger0_first(NR_QUANTILES);
-	u = pick_time_units(stats->quantiles.entries[i].m);
-
-	prt_printf(out, "quantiles (%s):\t", u->name);
-	eytzinger0_for_each(i, NR_QUANTILES) {
-		bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
-
-		q = max(stats->quantiles.entries[i].m, last_q);
-		prt_printf(out, "%llu ",
-		       div_u64(q, u->nsecs));
-		if (is_last)
-			prt_newline(out);
-		last_q = q;
+	if (stats->quantiles_enabled) {
+		int i = eytzinger0_first(NR_QUANTILES);
+		const struct time_unit *u =
+			pick_time_units(stats->quantiles.entries[i].m);
+		u64 last_q = 0;
+
+		prt_printf(out, "quantiles (%s):\t", u->name);
+		eytzinger0_for_each(i, NR_QUANTILES) {
+			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
+
+			u64 q = max(stats->quantiles.entries[i].m, last_q);
+			prt_printf(out, "%llu ", div_u64(q, u->nsecs));
+			if (is_last)
+				prt_newline(out);
+			last_q = q;
+		}
+	}
+}
+
+#include <linux/seq_buf.h>
+
+static void seq_buf_time_units_aligned(struct seq_buf *out, u64 ns)
+{
+	const struct time_unit *u = pick_time_units(ns);
+
+	seq_buf_printf(out, "%8llu %s", div64_u64(ns, u->nsecs), u->name);
+}
+
+void bch2_time_stats_to_seq_buf(struct seq_buf *out, struct bch2_time_stats *stats)
+{
+	s64 f_mean = 0, d_mean = 0;
+	u64 f_stddev = 0, d_stddev = 0;
+
+	if (stats->buffer) {
+		int cpu;
+
+		spin_lock_irq(&stats->lock);
+		for_each_possible_cpu(cpu)
+			__bch2_time_stats_clear_buffer(stats, per_cpu_ptr(stats->buffer, cpu));
+		spin_unlock_irq(&stats->lock);
+	}
+
+	/*
+	 * avoid divide by zero
+	 */
+	if (stats->freq_stats.n) {
+		f_mean = mean_and_variance_get_mean(stats->freq_stats);
+		f_stddev = mean_and_variance_get_stddev(stats->freq_stats);
+		d_mean = mean_and_variance_get_mean(stats->duration_stats);
+		d_stddev = mean_and_variance_get_stddev(stats->duration_stats);
+	}
+
+	seq_buf_printf(out, "count: %llu\n", stats->duration_stats.n);
+
+	seq_buf_printf(out, "                       since mount        recent\n");
+
+	seq_buf_printf(out, "duration of events\n");
+
+	seq_buf_printf(out, "  min:                     ");
+	seq_buf_time_units_aligned(out, stats->min_duration);
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  max:                     ");
+	seq_buf_time_units_aligned(out, stats->max_duration);
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  total:                   ");
+	seq_buf_time_units_aligned(out, stats->total_duration);
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  mean:                    ");
+	seq_buf_time_units_aligned(out, d_mean);
+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->duration_stats_weighted));
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  stddev:                  ");
+	seq_buf_time_units_aligned(out, d_stddev);
+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->duration_stats_weighted));
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "time between events\n");
+
+	seq_buf_printf(out, "  min:                     ");
+	seq_buf_time_units_aligned(out, stats->min_freq);
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  max:                     ");
+	seq_buf_time_units_aligned(out, stats->max_freq);
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  mean:                    ");
+	seq_buf_time_units_aligned(out, f_mean);
+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->freq_stats_weighted));
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  stddev:                  ");
+	seq_buf_time_units_aligned(out, f_stddev);
+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->freq_stats_weighted));
+	seq_buf_printf(out, "\n");
+
+	if (stats->quantiles_enabled) {
+		int i = eytzinger0_first(NR_QUANTILES);
+		const struct time_unit *u =
+			pick_time_units(stats->quantiles.entries[i].m);
+		u64 last_q = 0;
+
+		prt_printf(out, "quantiles (%s):\t", u->name);
+		eytzinger0_for_each(i, NR_QUANTILES) {
+			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
+
+			u64 q = max(stats->quantiles.entries[i].m, last_q);
+			seq_buf_printf(out, "%llu ", div_u64(q, u->nsecs));
+			if (is_last)
+				seq_buf_printf(out, "\n");
+			last_q = q;
+		}
 	}
 }
 #else
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index c3b11c3d24ea9..7ff2d4fe26f68 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -382,6 +382,7 @@ struct bch2_time_stat_buffer {
 
 struct bch2_time_stats {
 	spinlock_t	lock;
+	bool		quantiles_enabled;
 	/* all fields are in nanoseconds */
 	u64             min_duration;
 	u64		max_duration;
@@ -435,6 +436,9 @@ static inline bool track_event_change(struct bch2_time_stats *stats,
 
 void bch2_time_stats_to_text(struct printbuf *, struct bch2_time_stats *);
 
+struct seq_buf;
+void bch2_time_stats_to_seq_buf(struct seq_buf *, struct bch2_time_stats *);
+
 void bch2_time_stats_exit(struct bch2_time_stats *);
 void bch2_time_stats_init(struct bch2_time_stats *);
 


