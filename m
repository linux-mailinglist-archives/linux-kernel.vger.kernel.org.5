Return-Path: <linux-kernel+bounces-79396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486F7862193
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3574283F1D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0486C539A;
	Sat, 24 Feb 2024 01:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhJOiylr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299CA4416;
	Sat, 24 Feb 2024 01:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737100; cv=none; b=We/zSoOlB4ErjHrUD8OCZkHpGiSQ9uWhpPsZo40Xg5sS60Q1ehTNM8j5ntfiCERGNE24iedNDpeYpCRgVdGEYe5s4ek4slmNrpNG7l3znMYwd0yGhrrqRcRgsGLnruTuwT1k8FKX3ZPtQSdB7/elrFpYSfc8aywWGy4CJG3QtHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737100; c=relaxed/simple;
	bh=YpmqV9X3OHUUtHw2bB58KIEaUKBC08TNG+/xCl014u8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVGzawvgki7Yna3zHyW9GkqW5Ms/KcxWI0j/LG3GpWWJLK3jgyHBeB1Y2FjeZ+hZltpwkL3shfEWb03orF3hRFNJJZwn6HCJD83+BSzeyDZNfnz5Txy/SvQsG48bfxhUJkziDRPSB429HauIEwZunMcSWqh5gexF5yJLRQa/r9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhJOiylr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F307AC433C7;
	Sat, 24 Feb 2024 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737100;
	bh=YpmqV9X3OHUUtHw2bB58KIEaUKBC08TNG+/xCl014u8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GhJOiylrR1qtCUM2vC0LFagGq0u/JFyJUWKEUDw5mTBm3cfF4jr1A5ekxHSHEpakl
	 XUcFs0uve3HvKkbTRVF2H62PHVeMpoGY3gA3QsiThMxmiFkXtb9mwvZ8XqqSbn+Byf
	 5OElv2U95g7FvZOFVuL9kvMQZgQCSXALRPwRMMavObEc9OdnoKup71iAlriSurz+fv
	 5mNmNA9yPYDRALXnsX1Urw3BSLS8NwV3uJq3VzFjTQW1HfyDiVzdzDEmWKuoSW5pbF
	 XVzAge44d337VQOR2111vklFrcdCvHvk9K27AO1qRLAnnZxkinELDn3TwZXS10SiRd
	 PXO/zCwO+1OJw==
Date: Fri, 23 Feb 2024 17:11:39 -0800
Subject: [PATCH 06/10] time_stats: allow custom epoch names
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873668037.1860949.12345616435891382226.stgit@frogsfrogsfrogs>
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

Let callers of time_stats_to_seq_buf define the epoch name; "mount"
doesn't make sense generally.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/time_stats.h |    2 +-
 lib/time_stats.c           |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/include/linux/time_stats.h b/include/linux/time_stats.h
index 994823c17bca9..b2f71e3862c0f 100644
--- a/include/linux/time_stats.h
+++ b/include/linux/time_stats.h
@@ -151,7 +151,7 @@ static inline bool track_event_change(struct time_stats *stats, bool v)
 #define TIME_STATS_PRINT_NO_ZEROES	(1U << 0)	/* print nothing if zero count */
 struct seq_buf;
 void time_stats_to_seq_buf(struct seq_buf *, struct time_stats *,
-		unsigned int flags);
+		const char *epoch_name, unsigned int flags);
 
 void time_stats_exit(struct time_stats *);
 void time_stats_init(struct time_stats *);
diff --git a/lib/time_stats.c b/lib/time_stats.c
index 382935979f8f7..f4a21409006bd 100644
--- a/lib/time_stats.c
+++ b/lib/time_stats.c
@@ -169,7 +169,7 @@ static inline u64 time_stats_lifetime(const struct time_stats *stats)
 }
 
 void time_stats_to_seq_buf(struct seq_buf *out, struct time_stats *stats,
-		unsigned int flags)
+		const char *epoch_name, unsigned int flags)
 {
 	struct quantiles *quantiles = time_stats_to_quantiles(stats);
 	s64 f_mean = 0, d_mean = 0;
@@ -201,7 +201,7 @@ void time_stats_to_seq_buf(struct seq_buf *out, struct time_stats *stats,
 	seq_buf_time_units_aligned(out, lifetime);
 	seq_buf_printf(out, "\n");
 
-	seq_buf_printf(out, "                       since mount        recent\n");
+	seq_buf_printf(out, "                       since %-12s recent\n", epoch_name);
 
 	seq_buf_printf(out, "duration of events\n");
 


