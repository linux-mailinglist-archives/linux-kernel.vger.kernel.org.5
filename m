Return-Path: <linux-kernel+bounces-62541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D01F852294
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7952842D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913A44F8AB;
	Mon, 12 Feb 2024 23:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np8KwOMt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10B84F5FE;
	Mon, 12 Feb 2024 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780804; cv=none; b=qmXZAtfZnJBI8UySkwDoUodco4/jh19gYd7P+HNlzjbSCSLZnI97MC9xjak5Q++K99p9fOyuKvA8mP1D6vIFjdWKn6a338kaKMvOxj5DClLC40vg7Oh681sg39qHW4LX7TvtsxzQdf2fLRP3fhDzF6j7MK/9VZWQlf0hvcXrMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780804; c=relaxed/simple;
	bh=f+WQOpFf8Q6j7gyAcUMEvgt2grnf1Lmgn20YVuov3JI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Azys0bxMgl7JBqeLIyvd3YtjbzEv4tZh3eV8F0AaWGCecJNLuoiHqGUbiBMHORROAMPcnuYpK4U8g8QPPQxxkVjas5xrpfvG1Neqs06gR4gv+lj0mubv3q6Us7OHi+rJgBLZrkj2PtsZHhOGyp2Q3UDedlq++QdOUyG2nqjppEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np8KwOMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8032C433F1;
	Mon, 12 Feb 2024 23:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707780804;
	bh=f+WQOpFf8Q6j7gyAcUMEvgt2grnf1Lmgn20YVuov3JI=;
	h=From:To:Cc:Subject:Date:From;
	b=np8KwOMtCy2fO+orYiTn3Ep1+jt5Bv2nJ58MKS4wd/+XvniMf2x6InAWrwKv3kcPf
	 fA+e42TZXRLYYd16MifLWB9lfoJCuufMCUOn48Agy++a2zT/5yiJrTetG6BOJU+4Op
	 k1LV0bxFSaG6YvJvF0XqG8ms1DEbjqg8R2vKofiXuOS0iljhplswKMRtGd5aZwguzh
	 FMhAENPKcE4rRDHmxZVjYZqdTREcB7aC/vnbFpODSgFOTx8XMijy2hc2FoYPZnkr0a
	 PwzO1/wx0B7oYnX37+lFfq9IJUaZhwpuHBJzAKBp2ctmSfTBN3jRgmDaONJ9P3RrWd
	 rVTYejPs5+dZA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Leo Yan <leo.yan@linux.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] perf tools: Fixup module symbol end address properly
Date: Mon, 12 Feb 2024 15:33:22 -0800
Message-ID: <20240212233322.1855161-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I got a strange error on ARM to fail on processing FINISHED_ROUND
record.  It turned out that it was failing in symbol__alloc_hist()
because the symbol size is too big.

When a sample is captured on a specific BPF program, it failed.  I've
added a debug code and found the end address of the symbol is from
the next module which is placed far way.

  ffff800008795778-ffff80000879d6d8: bpf_prog_1bac53b8aac4bc58_netcg_sock    [bpf]
  ffff80000879d6d8-ffff80000ad656b4: bpf_prog_76867454b5944e15_netcg_getsockopt      [bpf]
  ffff80000ad656b4-ffffd69b7af74048: bpf_prog_1d50286d2eb1be85_hn_egress     [bpf]   <---------- here
  ffffd69b7af74048-ffffd69b7af74048: $x.5    [sha3_generic]
  ffffd69b7af74048-ffffd69b7af740b8: crypto_sha3_init        [sha3_generic]
  ffffd69b7af740b8-ffffd69b7af741e0: crypto_sha3_update      [sha3_generic]

The logic in symbols__fixup_end() just uses curr->start to update the
prev->end.  But in this case, it won't work as it's too different.

I think ARM has a different kernel memory layout for modules and BPF
than on x86.  Actually there's a logic to handle kernel and module
boundary.  Let's do the same for symbols between different modules.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 35975189999b..9ebdb8e13c0b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -248,14 +248,31 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
 		 * segment is very big.  Therefore do not fill this gap and do
 		 * not assign it to the kernel dso map (kallsyms).
 		 *
+		 * Also BPF code can be allocated separately from text segments
+		 * and modules.  So the last entry in a module should not fill
+		 * the gap too.
+		 *
 		 * In kallsyms, it determines module symbols using '[' character
 		 * like in:
 		 *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_hdmi]
 		 */
 		if (prev->end == prev->start) {
+			const char *prev_mod;
+			const char *curr_mod;
+
+			if (!is_kallsyms) {
+				prev->end = curr->start;
+				continue;
+			}
+
+			prev_mod = strchr(prev->name, '[');
+			curr_mod = strchr(curr->name, '[');
+
 			/* Last kernel/module symbol mapped to end of page */
-			if (is_kallsyms && (!strchr(prev->name, '[') !=
-					    !strchr(curr->name, '[')))
+			if (!prev_mod != !curr_mod)
+				prev->end = roundup(prev->end + 4096, 4096);
+			/* Last symbol in the previous module */
+			else if (prev_mod && strcmp(prev_mod, curr_mod))
 				prev->end = roundup(prev->end + 4096, 4096);
 			else
 				prev->end = curr->start;
-- 
2.43.0.687.g38aa6559b0-goog


