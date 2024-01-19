Return-Path: <linux-kernel+bounces-30759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3828323FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021FF28659B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ED3A945;
	Fri, 19 Jan 2024 04:07:38 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664381871;
	Fri, 19 Jan 2024 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705637258; cv=none; b=rsxbQzlZ03drC0st5hFOACPWVwCYe3M4jECLV7FPKYFOpbP5uxSDSSkbayn8qsvcq+ZiSo6xTgaXXKW3ACt6R0U7KIk7QsXma9jwsE+hriV6wbnjQu4/Dcw5DCtw0Vgx5NHB62YaC3RdH8aygYkEIhgGh1FPEAw9xzjP0m1lSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705637258; c=relaxed/simple;
	bh=qFcJAeGQC/MUYwBQAJZbuMyx6H16t+7Cin7A5eBF4Bw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXkvqHRrnWHzJcWbMpHZE0dgRr+daxR64+6R3jIKgidn6y1z2BJYRYB7UWQXV1kqpWFkJfflOUlevCrThCT8A6Rhh+5OQTk5flA1AIM10NxCdFyLdGg6DQDXrTYh38uliVf1zYtWH/AHFO5/sz0nMkRLMKdulcZfU9F1lTAmPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TGR004HJkzGpqC;
	Fri, 19 Jan 2024 12:07:12 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 34C6818005B;
	Fri, 19 Jan 2024 12:07:33 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 12:07:32 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH 2/3] perf record: Check conflict between '--timestamp-filename' option and pipe mode before recording
Date: Fri, 19 Jan 2024 04:03:03 +0000
Message-ID: <20240119040304.3708522-3-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119040304.3708522-1-yangjihong1@huawei.com>
References: <20240119040304.3708522-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)

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
---
 tools/perf/builtin-record.c | 5 +++++
 tools/perf/util/data.c      | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index fb8d4067b76c..5e3ea5cf1429 100644
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
index c29d8a382b19..550675ce0b78 100644
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
2.34.1


