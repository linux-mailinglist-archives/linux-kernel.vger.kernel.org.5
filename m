Return-Path: <linux-kernel+bounces-113267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505FA8882F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A261F23071
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C8E136E28;
	Sun, 24 Mar 2024 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjDTLIK5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6868136E0D;
	Sun, 24 Mar 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320066; cv=none; b=ZyMrxIb1aGvPL4cJJFM+eqwCSYD8CaFFkp486AxeXH5BBtMZqnwD+DtGztKhxwXZNZcjDkmWHnMfYaJX/bJuC8HBhXJm0zt8QhqDfuWe4fOdoXngrwSyTzCJ0yVVM7nBmVlz+2nGKoWhF9sr/Y1uDA1AY/3lrAEP0dww4VL4QMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320066; c=relaxed/simple;
	bh=SfnGMASuO5Dvr2j3Q1CmvC8pIQdpk9kbiq/gwKfVvQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ra+bZlXuINeOXNC4KcHr86xSwOGlxDP52s2RQJ2x2FmVIlHwYm3LKTqYZBIMjr9MPCkVJGzSayNt/Kndx1jK+Co4zT0BPS37HNv2qMKgIRMv7tjuMTWXXm9EaaDMYv21lIY4wYHQG9Gv6J6yPD3zzrk1HJHhJ2DLseqbkNCuXuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjDTLIK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EC0C43390;
	Sun, 24 Mar 2024 22:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320066;
	bh=SfnGMASuO5Dvr2j3Q1CmvC8pIQdpk9kbiq/gwKfVvQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjDTLIK5feKATZ0DQkkYf+9TFwG5VONRq4pGMsyNGntwaxA3Y3cb7CjYA+wU5yafC
	 tY/hNtPFMEqN7ZAXKrD7J/EnYKDhO2EuF9QDrAq2+sl2y8vujBKgSBV41QOq639Tez
	 rOdiZ23XLUgRFGYJu06HrCqKYt9jhh0WUf7OaFmkMXxbGzLbxvn9MucR0AW/aKv0IU
	 7vxyif3nhmOzAkXqBAv+25fej0X2qqZtrjxfw+MgEZBxf5TdSzn5fRVJkUIMF3oaUP
	 UEfBIT+YtbImutFBMyiHXS8GwEnjpYnyk8gQOMyRKbBM1MSikZQ7RS3FAzL2Gc9N9k
	 YinPx/Txzfz9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 376/715] perf record: Check conflict between '--timestamp-filename' option and pipe mode before recording
Date: Sun, 24 Mar 2024 18:29:15 -0400
Message-ID: <20240324223455.1342824-377-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index a8dfa533c1663..3ddd4381aebd2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2472,6 +2472,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
index c29d8a382b196..550675ce0b787 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -430,8 +430,6 @@ int perf_data__switch(struct perf_data *data,
 {
 	int ret;
 
-	if (check_pipe(data))
-		return -EINVAL;
 	if (perf_data__is_read(data))
 		return -EINVAL;
 
-- 
2.43.0


