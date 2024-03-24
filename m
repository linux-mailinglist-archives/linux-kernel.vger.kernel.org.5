Return-Path: <linux-kernel+bounces-115690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6668A889712
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2227029B63A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2A935ADC5;
	Mon, 25 Mar 2024 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4Ea0iFu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031341EC4A5;
	Sun, 24 Mar 2024 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321637; cv=none; b=jqlpHjGMzaLFSoeHZAhNUrgJU9nDbOhyvhh0oQX3Dbvydh7Pwkqb4S3DFhmiyZC7YOR7vCX21bhlfWUNp4THTgpXLs4U/xctdriDp+wvYPxGkm/jLN8ax/4Uy1F6r6NKNbZgV4BJ5wjczrOJ5KuR0Zq9z5GL/OEi9sz/7z3Tjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321637; c=relaxed/simple;
	bh=on5rA5lUDHzMSR8tAIoz2HkHMwVZeJD5y2m+BoZ5Ieo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkqXyTwujJZXq6nYioxp9F0MdsGu2oGBRXvTwCU3A/cIUpwJRrHrxvjKc2KZBV/5wF+9PNtYSz9+aBTbJgsLggSraJE87xhQJy8uhuIH57mJN0qpRP6lahnFvsXTgxR87IiALJ/DhpL0GbfZtDVwoljQFiUY4MKpDoD3x7Z/I24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4Ea0iFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4256EC433A6;
	Sun, 24 Mar 2024 23:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321636;
	bh=on5rA5lUDHzMSR8tAIoz2HkHMwVZeJD5y2m+BoZ5Ieo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4Ea0iFu1DcnSvHW3QWLYk49VqZ10bWwhIFgxIyfIi2G0oxHXYG9PYrWm4/IJvRpC
	 00U6NaQGEh8Sni9b95XUjiaIliaLZinEyUCBhV0Co7GU/5C/EsJajc6nWdtn7c8fYc
	 0JmRrnyVivGdBcI5aF+BLbtMzyEfywSCF3RBRwk0znELtkdUMzeVNXbvuYqjiZF/q1
	 Vw2fV7OZQMa4nPZ27KXkr1xjmm93iVoGyYlbmcH2sYthgIKbWoE4B525y5ix4gRK97
	 1xp2ljbJhk6uVuQ2yuhchm8s4ccz9LE65ivqQnfIg+aTl2lncWgSNrA91LSLPL2txR
	 DZaO5Ejsf6hYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 367/638] perf record: Check conflict between '--timestamp-filename' option and pipe mode before recording
Date: Sun, 24 Mar 2024 18:56:44 -0400
Message-ID: <20240324230116.1348576-368-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yang Jihong <yangjihong1@huawei.com>

[ Upstream commit 02f9b50e04812782fd006ed21c6da1c5e3e373da ]

In pipe mode, no need to switch perf data output, therefore,
'--timestamp-filename' option should not take effect.
Check the conflict before recording and output WARNING.
In this case, the check pipe mode in perf_data__switch() can be removed.

Before:

  # perf record --timestamp-filename -o- perf test -w noploop | perf report -i- --percent-limit=1
  # To display the perf.data header info, please use --header/--header-only options.
  #
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Dump -.2024011812110182 ]
  #
  # Total Lost Samples: 0
  #
  # Samples: 4K of event 'cycles:P'
  # Event count (approx.): 2176784359
  #
  # Overhead  Command  Shared Object         Symbol
  # ........  .......  ....................  ......................................
  #
      97.83%  perf     perf                  [.] noploop

  #
  # (Tip: Print event counts in CSV format with: perf stat -x,)
  #

After:

  # perf record --timestamp-filename -o- perf test -w noploop | perf report -i- --percent-limit=1
  WARNING: --timestamp-filename option is not available in pipe mode.
  # To display the perf.data header info, please use --header/--header-only options.
  #
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  #
  # Total Lost Samples: 0
  #
  # Samples: 4K of event 'cycles:P'
  # Event count (approx.): 2185575421
  #
  # Overhead  Command  Shared Object          Symbol
  # ........  .......  .....................  .............................................
  #
      97.75%  perf     perf                   [.] noploop

  #
  # (Tip: Profiling branch (mis)predictions with: perf record -b / perf report)
  #

Fixes: ecfd7a9c044e ("perf record: Add '--timestamp-filename' option to append timestamp to output file name")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240119040304.3708522-3-yangjihong1@huawei.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-record.c | 5 +++++
 tools/perf/util/data.c      | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 69d2d71e16ee8..c40460e936ccd 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2417,6 +2417,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (data->is_pipe && rec->evlist->core.nr_entries == 1)
 		rec->opts.sample_id = true;
 
+	if (rec->timestamp_filename && perf_data__is_pipe(data)) {
+		rec->timestamp_filename = false;
+		pr_warning("WARNING: --timestamp-filename option is not available in pipe mode.\n");
+	}
+
 	evlist__uniquify_name(rec->evlist);
 
 	/* Debug message used by test scripts */
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index fc16299c915f9..851a9cd32c4a2 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -418,8 +418,6 @@ int perf_data__switch(struct perf_data *data,
 {
 	int ret;
 
-	if (check_pipe(data))
-		return -EINVAL;
 	if (perf_data__is_read(data))
 		return -EINVAL;
 
-- 
2.43.0


