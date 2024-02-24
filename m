Return-Path: <linux-kernel+bounces-79395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4178862191
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F7CB243EA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3B06116;
	Sat, 24 Feb 2024 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX16huxk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436E138A;
	Sat, 24 Feb 2024 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737084; cv=none; b=nue9XjGhufE1IK+LT/+G+zctbA+4U3+7DxgyeHdDje+na2De+46RGXmu6yq8wLLG7DU7ocri5aKI691lLPyjIdYzTC+053JUFg+3PNeMhfEje1uw700FIksbYz27JyAq3wFHgabA5okT59dKGkmj2gZl6RD2lEKTohiNYsdffIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737084; c=relaxed/simple;
	bh=5vqSyO6kFxrfTkTwaLz92086RbonJjdYMybkf/+eKWQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIMfLBZe08vkbGp6KTwAT2mDsyhERsI2YT7bSyHlEDulAMV1BmSRJgD9ygWcmPprWkk1Ejza5Nt2Of7RJPh+8pklx7/jbyfGYGtggxigPtFROMzVX5VAwmgkO2FjQVs/UMLYUvOvf3U/jSPftg7BBNmlhHDo3NxwL/eLEpMy1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX16huxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCEAC433C7;
	Sat, 24 Feb 2024 01:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737084;
	bh=5vqSyO6kFxrfTkTwaLz92086RbonJjdYMybkf/+eKWQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fX16huxkSBmeeN39raaLvkhSJLummWKhv0/sCeF62LoeLgPU6ROXoj2k3t+AphvVa
	 KJkxj4AzoKnj7dLFd+znC+3p/tu2jVfpNUywn44qRSCuivV7F65nOJYIR/1Ks/sZNc
	 3PqlfnIy19Om7qaPJFFzqaVEC8kTdwYjokK4cjbW3Fza/x2o4Z4PZZPCx0Hjhl9b+q
	 3mXsW7Ic/boXp2qremR3KwKbJd7AMgP5zQp4r+SMLMvXioQf2hBuWeEgU0TtENfeb3
	 ziLJnlNa5pltxcXirKijPtSiS0H/qcYfvtVuOu//m5XuS1LPy7FY7tANwol29I3nY6
	 SIaBb/p/cxj7g==
Date: Fri, 23 Feb 2024 17:11:23 -0800
Subject: [PATCH 05/10] time_stats: don't print any output if event count is
 zero
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873668021.1860949.13792887319624615306.stgit@frogsfrogsfrogs>
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

There's no point in printing an empty report for no data, so add a flag
that allows us to do that.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/time_stats.h |    4 +++-
 lib/time_stats.c           |   10 ++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)


diff --git a/include/linux/time_stats.h b/include/linux/time_stats.h
index 1c1ba8efa7bfe..994823c17bca9 100644
--- a/include/linux/time_stats.h
+++ b/include/linux/time_stats.h
@@ -148,8 +148,10 @@ static inline bool track_event_change(struct time_stats *stats, bool v)
 	return false;
 }
 
+#define TIME_STATS_PRINT_NO_ZEROES	(1U << 0)	/* print nothing if zero count */
 struct seq_buf;
-void time_stats_to_seq_buf(struct seq_buf *, struct time_stats *);
+void time_stats_to_seq_buf(struct seq_buf *, struct time_stats *,
+		unsigned int flags);
 
 void time_stats_exit(struct time_stats *);
 void time_stats_init(struct time_stats *);
diff --git a/lib/time_stats.c b/lib/time_stats.c
index 43106bda43a92..382935979f8f7 100644
--- a/lib/time_stats.c
+++ b/lib/time_stats.c
@@ -168,7 +168,8 @@ static inline u64 time_stats_lifetime(const struct time_stats *stats)
 	return local_clock() - (stats->start_time & ~TIME_STATS_HAVE_QUANTILES);
 }
 
-void time_stats_to_seq_buf(struct seq_buf *out, struct time_stats *stats)
+void time_stats_to_seq_buf(struct seq_buf *out, struct time_stats *stats,
+		unsigned int flags)
 {
 	struct quantiles *quantiles = time_stats_to_quantiles(stats);
 	s64 f_mean = 0, d_mean = 0;
@@ -184,14 +185,15 @@ void time_stats_to_seq_buf(struct seq_buf *out, struct time_stats *stats)
 		spin_unlock_irq(&stats->lock);
 	}
 
-	/*
-	 * avoid divide by zero
-	 */
 	if (stats->freq_stats.n) {
+		/* avoid divide by zero */
 		f_mean = mean_and_variance_get_mean(stats->freq_stats);
 		f_stddev = mean_and_variance_get_stddev(stats->freq_stats);
 		d_mean = mean_and_variance_get_mean(stats->duration_stats);
 		d_stddev = mean_and_variance_get_stddev(stats->duration_stats);
+	} else if (flags & TIME_STATS_PRINT_NO_ZEROES) {
+		/* unless we didn't want zeroes anyway */
+		return;
 	}
 
 	seq_buf_printf(out, "count: %llu\n", stats->duration_stats.n);


