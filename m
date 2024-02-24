Return-Path: <linux-kernel+bounces-79399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0A8862199
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B3A2827FB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE636FD9;
	Sat, 24 Feb 2024 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMPxm1hy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D56116;
	Sat, 24 Feb 2024 01:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737147; cv=none; b=QFbbNtwLrLqiErX+NiD6OtwJWbUtwJvkAYbSgxEcEtPXN+32046VwLEt9ttDjuSzjTzR/q+HVGh3faIB5j8jMxT0wd0JDk3JsXAjogNv2F9MGQKhYrUzChZnSwTDlXL+w7ZzWx3PvO9XhKpiCEzaSMyA6PKEfTBj0yDbACkQmmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737147; c=relaxed/simple;
	bh=stCMDrWvmAsbsnRhDg01PkUkNRNpdLqZpFOiKHjm3Do=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsjUaXUVknWWrD+pkMlLVbmtEddBhIk9uzL/Qvv7pPuBiBdZrcZ0+pMQLZkrOIaAQFEsW3WICVJVHCLtm2NFQAegUmPSW+aV8N0d318/0wKNoV8VgkURRdUMcrUh0Q4cK50LlR7d2QPGT6lEwjrzVw+ED/OvUpaDukdNXF/wnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMPxm1hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F48C433C7;
	Sat, 24 Feb 2024 01:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737146;
	bh=stCMDrWvmAsbsnRhDg01PkUkNRNpdLqZpFOiKHjm3Do=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oMPxm1hyVNVOKZmazZDYU7hrTHAPU1VeOJgzDSHxKgfcl0U9Suj6X4/hpwtdqhJ+o
	 AuMh/hJC2EmUhLQS+kyvjIPMvs2VwQKZoFE4lML/V/qDpyw9sBf762Yfpy2GImdCGL
	 cuhR+IBIb8gZGb0AqSx+EcfOQlyUbI+YH0Mog/kQTp4STdIcbg8Oye5AoaSlKQe08m
	 dvZ+N9NAX0t4N9PYfnezGNCylK9AKLOD9jBerabtH1YsBNNAavrCAhvaQH6EoHwLEc
	 R4j6QKRtdFtTs4PuguZYGMlPCG5xElKqI8ulJo4CBZRvb0xGpOwGcCLM4ZUyMzY0sE
	 kj2tQ62lJxQ5w==
Date: Fri, 23 Feb 2024 17:12:26 -0800
Subject: [PATCH 09/10] time_stats: report information in json format
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873668085.1860949.11659237532415596101.stgit@frogsfrogsfrogs>
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

Export json versions of time statistics information.  Given the tabular
nature of the numbers exposed, this will make it a lot easier for higher
(than C) level languages (e.g. python) to import information without
needing to write yet another clumsy string parser.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/time_stats.h |    2 +
 lib/time_stats.c           |   87 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)


diff --git a/include/linux/time_stats.h b/include/linux/time_stats.h
index b3c810fff963a..4e1f5485ed039 100644
--- a/include/linux/time_stats.h
+++ b/include/linux/time_stats.h
@@ -156,6 +156,8 @@ static inline bool track_event_change(struct time_stats *stats, bool v)
 struct seq_buf;
 void time_stats_to_seq_buf(struct seq_buf *, struct time_stats *,
 		const char *epoch_name, unsigned int flags);
+void time_stats_to_json(struct seq_buf *, struct time_stats *,
+		const char *epoch_name, unsigned int flags);
 
 void time_stats_exit(struct time_stats *);
 void time_stats_init(struct time_stats *);
diff --git a/lib/time_stats.c b/lib/time_stats.c
index 0fb3d854e503b..c0f209dd9f6dd 100644
--- a/lib/time_stats.c
+++ b/lib/time_stats.c
@@ -266,6 +266,93 @@ void time_stats_to_seq_buf(struct seq_buf *out, struct time_stats *stats,
 }
 EXPORT_SYMBOL_GPL(time_stats_to_seq_buf);
 
+void time_stats_to_json(struct seq_buf *out, struct time_stats *stats,
+		const char *epoch_name, unsigned int flags)
+{
+	struct quantiles *quantiles = time_stats_to_quantiles(stats);
+	s64 f_mean = 0, d_mean = 0;
+	u64 f_stddev = 0, d_stddev = 0;
+
+	if (stats->buffer) {
+		int cpu;
+
+		spin_lock_irq(&stats->lock);
+		for_each_possible_cpu(cpu)
+			__time_stats_clear_buffer(stats, per_cpu_ptr(stats->buffer, cpu));
+		spin_unlock_irq(&stats->lock);
+	}
+
+	if (stats->freq_stats.n) {
+		/* avoid divide by zero */
+		f_mean = mean_and_variance_get_mean(stats->freq_stats);
+		f_stddev = mean_and_variance_get_stddev(stats->freq_stats);
+		d_mean = mean_and_variance_get_mean(stats->duration_stats);
+		d_stddev = mean_and_variance_get_stddev(stats->duration_stats);
+	} else if (flags & TIME_STATS_PRINT_NO_ZEROES) {
+		/* unless we didn't want zeroes anyway */
+		return;
+	}
+
+	seq_buf_printf(out, "{\n");
+	seq_buf_printf(out, "  \"epoch\":       \"%s\",\n", epoch_name);
+	seq_buf_printf(out, "  \"count\":       %llu,\n", stats->duration_stats.n);
+
+	seq_buf_printf(out, "  \"duration_ns\": {\n");
+	seq_buf_printf(out, "    \"min\":       %llu,\n", stats->min_duration);
+	seq_buf_printf(out, "    \"max\":       %llu,\n", stats->max_duration);
+	seq_buf_printf(out, "    \"total\":     %llu,\n", stats->total_duration);
+	seq_buf_printf(out, "    \"mean\":      %llu,\n", d_mean);
+	seq_buf_printf(out, "    \"stddev\":    %llu\n", d_stddev);
+	seq_buf_printf(out, "  },\n");
+
+	d_mean = mean_and_variance_weighted_get_mean(stats->duration_stats_weighted, TIME_STATS_MV_WEIGHT);
+	d_stddev = mean_and_variance_weighted_get_stddev(stats->duration_stats_weighted, TIME_STATS_MV_WEIGHT);
+
+	seq_buf_printf(out, "  \"duration_ewma_ns\": {\n");
+	seq_buf_printf(out, "    \"mean\":      %llu,\n", d_mean);
+	seq_buf_printf(out, "    \"stddev\":    %llu\n", d_stddev);
+	seq_buf_printf(out, "  },\n");
+
+	seq_buf_printf(out, "  \"frequency_ns\": {\n");
+	seq_buf_printf(out, "    \"min\":       %llu,\n", stats->min_freq);
+	seq_buf_printf(out, "    \"max\":       %llu,\n", stats->max_freq);
+	seq_buf_printf(out, "    \"mean\":      %llu,\n", f_mean);
+	seq_buf_printf(out, "    \"stddev\":    %llu\n", f_stddev);
+	seq_buf_printf(out, "  },\n");
+
+	f_mean = mean_and_variance_weighted_get_mean(stats->freq_stats_weighted, TIME_STATS_MV_WEIGHT);
+	f_stddev = mean_and_variance_weighted_get_stddev(stats->freq_stats_weighted, TIME_STATS_MV_WEIGHT);
+
+	seq_buf_printf(out, "  \"frequency_ewma_ns\": {\n");
+	seq_buf_printf(out, "    \"mean\":      %llu,\n", f_mean);
+	seq_buf_printf(out, "    \"stddev\":    %llu\n", f_stddev);
+
+	if (quantiles) {
+		u64 last_q = 0;
+
+		/* close frequency_ewma_ns but signal more items */
+		seq_buf_printf(out, "  },\n");
+
+		seq_buf_printf(out, "  \"quantiles_ns\": [\n");
+		eytzinger0_for_each(i, NR_QUANTILES) {
+			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
+
+			u64 q = max(quantiles->entries[i].m, last_q);
+			seq_buf_printf(out, "    %llu", q);
+			if (!is_last)
+				seq_buf_printf(out, ", ");
+			last_q = q;
+		}
+		seq_buf_printf(out, "  ]\n");
+	} else {
+		/* close frequency_ewma_ns without dumping further */
+		seq_buf_printf(out, "  }\n");
+	}
+
+	seq_buf_printf(out, "}\n");
+}
+EXPORT_SYMBOL_GPL(time_stats_to_json);
+
 void time_stats_exit(struct time_stats *stats)
 {
 	free_percpu(stats->buffer);


