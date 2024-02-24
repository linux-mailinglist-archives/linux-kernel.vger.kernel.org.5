Return-Path: <linux-kernel+bounces-79397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C67862195
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D3C281112
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A78539A;
	Sat, 24 Feb 2024 01:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JM4y8pZv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA94A05;
	Sat, 24 Feb 2024 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737116; cv=none; b=ZKILXviPGvyyPL4851hFFaTFZKyCbGgwAveMmwC0bfVKSKupAr6wXBjZ8dqCJFWnXqbOt5qMLy6p6WRnuuM+69npwl7c1cCRqamio5dYtuarIzvKKBh/+3M8x0iBAYxu1p2jhfyQw9WSfyXnazZFG4lgbp/0a1SPSIHO9bCIRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737116; c=relaxed/simple;
	bh=2pup8be+b59a8UwXcZHhWDG/xYDa2uYcVmcAamFutSE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PduLK8tpm6QidEm92suq/qnhufCdr/+ZJWCkU5lucbrhqqAQenyTU749WFoJzz0hROMM6LfiSUwxPz4rR0kkXs0+1zQQZca0wR0RGuuTsOEJDkthdoKyDTg7TuTa1K/TxunktBKBgg2MiXxnTNN6L1HodvG72spoWih6/AD7nY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JM4y8pZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5FFC433F1;
	Sat, 24 Feb 2024 01:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737115;
	bh=2pup8be+b59a8UwXcZHhWDG/xYDa2uYcVmcAamFutSE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JM4y8pZvbjWfoCmqVRe6JsBIqsMUHdE2ik15RdBFGd+vw/a/FdPnP0HACr2vrsbqn
	 eCdjH5r8ONLR4IsDypOAlOWdlRm69nxFj2l6bk0e3hr4pzTNdFmJfSDfMTzjgpVS/Y
	 4XZUsc39nz5bkT+MLnZ3pAIdNLfY/vuoVcDTsgimuIEESmPjEgrA2QRu5pcQ250lre
	 9P5y8cYElXQ4Y6pgnIqLJl9xyeJQ+PWKfSS2Ws0rAkBDpcMLwaYmNxSvohjP3TceJQ
	 Om8Fg1bG7amBXT3+BPp/0JdDHZT9nNVCE1tlDdCiz8itrqof74DJMd33Od2IVcdPcg
	 EDtiBA8U79jEw==
Date: Fri, 23 Feb 2024 17:11:55 -0800
Subject: [PATCH 07/10] mean_and_variance: put struct
 mean_and_variance_weighted on a diet
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873668053.1860949.14729710277150920793.stgit@frogsfrogsfrogs>
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

The only caller of this code (time_stats) always knows the weights and
whether or not any information has been collected.  Pass this
information into the mean and variance code so that it doesn't have to
store that information.  This reduces the structure size from 24 to 16
bytes, which shrinks each time_stats counter to 192 bytes from 208.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/util.c                |    8 ++--
 include/linux/mean_and_variance.h |   14 ++++--
 include/linux/time_stats.h        |    4 ++
 lib/math/mean_and_variance.c      |   28 ++++++++-----
 lib/math/mean_and_variance_test.c |   80 ++++++++++++++++++++-----------------
 lib/time_stats.c                  |   23 +++++------
 6 files changed, 87 insertions(+), 70 deletions(-)


diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index ef620bfe76cd2..4c3e19d562852 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -429,14 +429,14 @@ void bch2_time_stats_to_text(struct printbuf *out, struct time_stats *stats)
 	prt_tab(out);
 	bch2_pr_time_units_aligned(out, d_mean);
 	prt_tab(out);
-	bch2_pr_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->duration_stats_weighted));
+	bch2_pr_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->duration_stats_weighted, TIME_STATS_MV_WEIGHT));
 	prt_newline(out);
 
 	prt_printf(out, "stddev:");
 	prt_tab(out);
 	bch2_pr_time_units_aligned(out, d_stddev);
 	prt_tab(out);
-	bch2_pr_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->duration_stats_weighted));
+	bch2_pr_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->duration_stats_weighted, TIME_STATS_MV_WEIGHT));
 
 	printbuf_indent_sub(out, 2);
 	prt_newline(out);
@@ -452,14 +452,14 @@ void bch2_time_stats_to_text(struct printbuf *out, struct time_stats *stats)
 	prt_tab(out);
 	bch2_pr_time_units_aligned(out, f_mean);
 	prt_tab(out);
-	bch2_pr_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->freq_stats_weighted));
+	bch2_pr_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->freq_stats_weighted, TIME_STATS_MV_WEIGHT));
 	prt_newline(out);
 
 	prt_printf(out, "stddev:");
 	prt_tab(out);
 	bch2_pr_time_units_aligned(out, f_stddev);
 	prt_tab(out);
-	bch2_pr_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->freq_stats_weighted));
+	bch2_pr_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->freq_stats_weighted, TIME_STATS_MV_WEIGHT));
 
 	printbuf_indent_sub(out, 2);
 	prt_newline(out);
diff --git a/include/linux/mean_and_variance.h b/include/linux/mean_and_variance.h
index 64df11ab422bf..4fcf062dd22c7 100644
--- a/include/linux/mean_and_variance.h
+++ b/include/linux/mean_and_variance.h
@@ -154,8 +154,6 @@ struct mean_and_variance {
 
 /* expontentially weighted variant */
 struct mean_and_variance_weighted {
-	bool	init;
-	u8	weight;	/* base 2 logarithim */
 	s64	mean;
 	u64	variance;
 };
@@ -192,10 +190,14 @@ s64 mean_and_variance_get_mean(struct mean_and_variance s);
 u64 mean_and_variance_get_variance(struct mean_and_variance s1);
 u32 mean_and_variance_get_stddev(struct mean_and_variance s);
 
-void mean_and_variance_weighted_update(struct mean_and_variance_weighted *s, s64 v);
+void mean_and_variance_weighted_update(struct mean_and_variance_weighted *s,
+		s64 v, bool initted, u8 weight);
 
-s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_weighted s);
-u64 mean_and_variance_weighted_get_variance(struct mean_and_variance_weighted s);
-u32 mean_and_variance_weighted_get_stddev(struct mean_and_variance_weighted s);
+s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_weighted s,
+		u8 weight);
+u64 mean_and_variance_weighted_get_variance(struct mean_and_variance_weighted s,
+		u8 weight);
+u32 mean_and_variance_weighted_get_stddev(struct mean_and_variance_weighted s,
+		u8 weight);
 
 #endif // MEAN_AND_VAIRANCE_H_
diff --git a/include/linux/time_stats.h b/include/linux/time_stats.h
index b2f71e3862c0f..dc539123f7997 100644
--- a/include/linux/time_stats.h
+++ b/include/linux/time_stats.h
@@ -79,6 +79,10 @@ struct time_stats {
 
 	struct mean_and_variance	  duration_stats;
 	struct mean_and_variance	  freq_stats;
+
+/* default weight for weighted mean and variance calculations */
+#define TIME_STATS_MV_WEIGHT	8
+
 	struct mean_and_variance_weighted duration_stats_weighted;
 	struct mean_and_variance_weighted freq_stats_weighted;
 	struct time_stat_buffer __percpu *buffer;
diff --git a/lib/math/mean_and_variance.c b/lib/math/mean_and_variance.c
index ba90293204bae..21ec6afc67884 100644
--- a/lib/math/mean_and_variance.c
+++ b/lib/math/mean_and_variance.c
@@ -102,14 +102,17 @@ EXPORT_SYMBOL_GPL(mean_and_variance_get_stddev);
  * mean_and_variance_weighted_update() - exponentially weighted variant of mean_and_variance_update()
  * @s: mean and variance number of samples and their sums
  * @x: new value to include in the &mean_and_variance_weighted
+ * @initted: caller must track whether this is the first use or not
+ * @weight: ewma weight
  *
  * see linked pdf: function derived from equations 140-143 where alpha = 2^w.
  * values are stored bitshifted for performance and added precision.
  */
-void mean_and_variance_weighted_update(struct mean_and_variance_weighted *s, s64 x)
+void mean_and_variance_weighted_update(struct mean_and_variance_weighted *s,
+		s64 x, bool initted, u8 weight)
 {
 	// previous weighted variance.
-	u8 w		= s->weight;
+	u8 w		= weight;
 	u64 var_w0	= s->variance;
 	// new value weighted.
 	s64 x_w		= x << w;
@@ -118,45 +121,50 @@ void mean_and_variance_weighted_update(struct mean_and_variance_weighted *s, s64
 	// new mean weighted.
 	s64 u_w1	= s->mean + diff;
 
-	if (!s->init) {
+	if (!initted) {
 		s->mean = x_w;
 		s->variance = 0;
 	} else {
 		s->mean = u_w1;
 		s->variance = ((var_w0 << w) - var_w0 + ((diff_w * (x_w - u_w1)) >> w)) >> w;
 	}
-	s->init = true;
 }
 EXPORT_SYMBOL_GPL(mean_and_variance_weighted_update);
 
 /**
  * mean_and_variance_weighted_get_mean() - get mean from @s
  * @s: mean and variance number of samples and their sums
+ * @weight: ewma weight
  */
-s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_weighted s)
+s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_weighted s,
+		u8 weight)
 {
-	return fast_divpow2(s.mean, s.weight);
+	return fast_divpow2(s.mean, weight);
 }
 EXPORT_SYMBOL_GPL(mean_and_variance_weighted_get_mean);
 
 /**
  * mean_and_variance_weighted_get_variance() -- get variance from @s
  * @s: mean and variance number of samples and their sums
+ * @weight: ewma weight
  */
-u64 mean_and_variance_weighted_get_variance(struct mean_and_variance_weighted s)
+u64 mean_and_variance_weighted_get_variance(struct mean_and_variance_weighted s,
+		u8 weight)
 {
 	// always positive don't need fast divpow2
-	return s.variance >> s.weight;
+	return s.variance >> weight;
 }
 EXPORT_SYMBOL_GPL(mean_and_variance_weighted_get_variance);
 
 /**
  * mean_and_variance_weighted_get_stddev() - get standard deviation from @s
  * @s: mean and variance number of samples and their sums
+ * @weight: ewma weight
  */
-u32 mean_and_variance_weighted_get_stddev(struct mean_and_variance_weighted s)
+u32 mean_and_variance_weighted_get_stddev(struct mean_and_variance_weighted s,
+		u8 weight)
 {
-	return int_sqrt64(mean_and_variance_weighted_get_variance(s));
+	return int_sqrt64(mean_and_variance_weighted_get_variance(s, weight));
 }
 EXPORT_SYMBOL_GPL(mean_and_variance_weighted_get_stddev);
 
diff --git a/lib/math/mean_and_variance_test.c b/lib/math/mean_and_variance_test.c
index f45591a169d87..0d8c2451a8588 100644
--- a/lib/math/mean_and_variance_test.c
+++ b/lib/math/mean_and_variance_test.c
@@ -30,53 +30,59 @@ static void mean_and_variance_basic_test(struct kunit *test)
 
 static void mean_and_variance_weighted_test(struct kunit *test)
 {
-	struct mean_and_variance_weighted s = { .weight = 2 };
+	struct mean_and_variance_weighted s = { };
 
-	mean_and_variance_weighted_update(&s, 10);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), 10);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 0);
+	mean_and_variance_weighted_update(&s, 10, false, 2);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s, 2), 10);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s, 2), 0);
 
-	mean_and_variance_weighted_update(&s, 20);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), 12);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 18);
+	mean_and_variance_weighted_update(&s, 20, true, 2);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s, 2), 12);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s, 2), 18);
 
-	mean_and_variance_weighted_update(&s, 30);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), 16);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 72);
+	mean_and_variance_weighted_update(&s, 30, true, 2);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s, 2), 16);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s, 2), 72);
 
-	s = (struct mean_and_variance_weighted) { .weight = 2 };
+	s = (struct mean_and_variance_weighted) { };
 
-	mean_and_variance_weighted_update(&s, -10);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), -10);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 0);
+	mean_and_variance_weighted_update(&s, -10, false, 2);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s, 2), -10);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s, 2), 0);
 
-	mean_and_variance_weighted_update(&s, -20);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), -12);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 18);
+	mean_and_variance_weighted_update(&s, -20, true, 2);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s, 2), -12);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s, 2), 18);
 
-	mean_and_variance_weighted_update(&s, -30);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), -16);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 72);
+	mean_and_variance_weighted_update(&s, -30, true, 2);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s, 2), -16);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s, 2), 72);
 }
 
 static void mean_and_variance_weighted_advanced_test(struct kunit *test)
 {
-	struct mean_and_variance_weighted s = { .weight = 8 };
+	struct mean_and_variance_weighted s = { };
+	bool initted = false;
 	s64 i;
 
-	for (i = 10; i <= 100; i += 10)
-		mean_and_variance_weighted_update(&s, i);
+	for (i = 10; i <= 100; i += 10) {
+		mean_and_variance_weighted_update(&s, i, initted, 8);
+		initted = true;
+	}
 
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), 11);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 107);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s, 8), 11);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s, 8), 107);
 
-	s = (struct mean_and_variance_weighted) { .weight = 8 };
+	s = (struct mean_and_variance_weighted) { };
+	initted = false;
 
-	for (i = -10; i >= -100; i -= 10)
-		mean_and_variance_weighted_update(&s, i);
+	for (i = -10; i >= -100; i -= 10) {
+		mean_and_variance_weighted_update(&s, i, initted, 8);
+		initted = true;
+	}
 
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s), -11);
-	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s), 107);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(s, 8), -11);
+	KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_variance(s, 8), 107);
 }
 
 static void do_mean_and_variance_test(struct kunit *test,
@@ -91,26 +97,26 @@ static void do_mean_and_variance_test(struct kunit *test,
 				      s64 *weighted_stddev)
 {
 	struct mean_and_variance mv = {};
-	struct mean_and_variance_weighted vw = { .weight = weight };
+	struct mean_and_variance_weighted vw = { };
 
 	for (unsigned i = 0; i < initial_n; i++) {
 		mean_and_variance_update(&mv, initial_value);
-		mean_and_variance_weighted_update(&vw, initial_value);
+		mean_and_variance_weighted_update(&vw, initial_value, false, weight);
 
 		KUNIT_EXPECT_EQ(test, mean_and_variance_get_mean(mv),		initial_value);
 		KUNIT_EXPECT_EQ(test, mean_and_variance_get_stddev(mv),		0);
-		KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(vw),	initial_value);
-		KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_stddev(vw),0);
+		KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(vw, weight),	initial_value);
+		KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_stddev(vw, weight),0);
 	}
 
 	for (unsigned i = 0; i < n; i++) {
 		mean_and_variance_update(&mv, data[i]);
-		mean_and_variance_weighted_update(&vw, data[i]);
+		mean_and_variance_weighted_update(&vw, data[i], true, weight);
 
 		KUNIT_EXPECT_EQ(test, mean_and_variance_get_mean(mv),		mean[i]);
 		KUNIT_EXPECT_EQ(test, mean_and_variance_get_stddev(mv),		stddev[i]);
-		KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(vw),	weighted_mean[i]);
-		KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_stddev(vw),weighted_stddev[i]);
+		KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_mean(vw, weight),	weighted_mean[i]);
+		KUNIT_EXPECT_EQ(test, mean_and_variance_weighted_get_stddev(vw, weight),weighted_stddev[i]);
 	}
 
 	KUNIT_EXPECT_EQ(test, mv.n, initial_n + n);
diff --git a/lib/time_stats.c b/lib/time_stats.c
index f4a21409006bd..0fb3d854e503b 100644
--- a/lib/time_stats.c
+++ b/lib/time_stats.c
@@ -70,13 +70,15 @@ static inline void time_stats_update_one(struct time_stats *stats,
 					      u64 start, u64 end)
 {
 	u64 duration, freq;
+	bool initted = stats->last_event != 0;
 
 	if (time_after64(end, start)) {
 		struct quantiles *quantiles = time_stats_to_quantiles(stats);
 
 		duration = end - start;
 		mean_and_variance_update(&stats->duration_stats, duration);
-		mean_and_variance_weighted_update(&stats->duration_stats_weighted, duration);
+		mean_and_variance_weighted_update(&stats->duration_stats_weighted,
+				duration, initted, TIME_STATS_MV_WEIGHT);
 		stats->max_duration = max(stats->max_duration, duration);
 		stats->min_duration = min(stats->min_duration, duration);
 		stats->total_duration += duration;
@@ -88,7 +90,8 @@ static inline void time_stats_update_one(struct time_stats *stats,
 	if (stats->last_event && time_after64(end, stats->last_event)) {
 		freq = end - stats->last_event;
 		mean_and_variance_update(&stats->freq_stats, freq);
-		mean_and_variance_weighted_update(&stats->freq_stats_weighted, freq);
+		mean_and_variance_weighted_update(&stats->freq_stats_weighted,
+				freq, initted, TIME_STATS_MV_WEIGHT);
 		stats->max_freq = max(stats->max_freq, freq);
 		stats->min_freq = min(stats->min_freq, freq);
 	}
@@ -121,15 +124,11 @@ void __time_stats_update(struct time_stats *stats, u64 start, u64 end)
 {
 	unsigned long flags;
 
-	WARN_ONCE(!stats->duration_stats_weighted.weight ||
-		  !stats->freq_stats_weighted.weight,
-		  "uninitialized time_stats");
-
 	if (!stats->buffer) {
 		spin_lock_irqsave(&stats->lock, flags);
 		time_stats_update_one(stats, start, end);
 
-		if (mean_and_variance_weighted_get_mean(stats->freq_stats_weighted) < 32 &&
+		if (mean_and_variance_weighted_get_mean(stats->freq_stats_weighted, TIME_STATS_MV_WEIGHT) < 32 &&
 		    stats->duration_stats.n > 1024)
 			stats->buffer =
 				alloc_percpu_gfp(struct time_stat_buffer,
@@ -219,12 +218,12 @@ void time_stats_to_seq_buf(struct seq_buf *out, struct time_stats *stats,
 
 	seq_buf_printf(out, "  mean:                    ");
 	seq_buf_time_units_aligned(out, d_mean);
-	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->duration_stats_weighted));
+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->duration_stats_weighted, TIME_STATS_MV_WEIGHT));
 	seq_buf_printf(out, "\n");
 
 	seq_buf_printf(out, "  stddev:                  ");
 	seq_buf_time_units_aligned(out, d_stddev);
-	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->duration_stats_weighted));
+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->duration_stats_weighted, TIME_STATS_MV_WEIGHT));
 	seq_buf_printf(out, "\n");
 
 	seq_buf_printf(out, "time between events\n");
@@ -239,12 +238,12 @@ void time_stats_to_seq_buf(struct seq_buf *out, struct time_stats *stats,
 
 	seq_buf_printf(out, "  mean:                    ");
 	seq_buf_time_units_aligned(out, f_mean);
-	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->freq_stats_weighted));
+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->freq_stats_weighted, TIME_STATS_MV_WEIGHT));
 	seq_buf_printf(out, "\n");
 
 	seq_buf_printf(out, "  stddev:                  ");
 	seq_buf_time_units_aligned(out, f_stddev);
-	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->freq_stats_weighted));
+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->freq_stats_weighted, TIME_STATS_MV_WEIGHT));
 	seq_buf_printf(out, "\n");
 
 	if (quantiles) {
@@ -276,8 +275,6 @@ EXPORT_SYMBOL_GPL(time_stats_exit);
 void time_stats_init(struct time_stats *stats)
 {
 	memset(stats, 0, sizeof(*stats));
-	stats->duration_stats_weighted.weight = 8;
-	stats->freq_stats_weighted.weight = 8;
 	stats->min_duration = U64_MAX;
 	stats->min_freq = U64_MAX;
 	stats->start_time = local_clock() & ~TIME_STATS_HAVE_QUANTILES;


