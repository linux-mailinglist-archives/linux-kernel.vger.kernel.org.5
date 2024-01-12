Return-Path: <linux-kernel+bounces-25092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DD382C7DD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DA92822B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5C718E35;
	Fri, 12 Jan 2024 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hcko2455"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576215E94;
	Fri, 12 Jan 2024 23:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BD9C433F1;
	Fri, 12 Jan 2024 23:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705101221;
	bh=7GMP78E4NMNKdOfNqFB86WG7sun6VlpU0NIMPtc+prQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Hcko2455G9v58pCVQ3YQlJgYmvSrayyEAoyZ5hPnJw2L9f5D6+txRUFLqX8cklv5C
	 CJ07chwf8w78jv+1bu/FJT2reJIEuhaDS9XJAc2gpNhnnI98oT8+waRy/NQxkhwks0
	 p4MLbkT8Z47NJ/VXy9LvzEFJbWhI8X0lKl7YGHLi3h8d4YXH2dZW8ybZytzlsH6cmk
	 kQhaOm76LZOPYIALPuiVUvO0+bOMonhYqZfKZGsuepWL5ZHgm+d2UCR1VjjDLNWuN1
	 8H7jhSEnowr/d4bygYXQTwyxIv6nFnKDem3lMVgwpQsjwRMYlb/wz4+lL5ubJl8Y5v
	 pdAMgZzW/lCxg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf record: Display data size on pipe mode
Date: Fri, 12 Jan 2024 15:13:40 -0800
Message-ID: <20240112231340.779469-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently pipe mode doesn't set the file size and it results in a
misleading message of 0 data size at the end.  Although it might miss
some accounting for pipe header or more, just displaying the data size
would reduce the possible confusion.

Before:
  $ perf record -o- perf test -w noploop | perf report -i- -q --percent-limit=1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]    <======  (here)
      99.58%  perf     perf                  [.] noploop

After:
  $ perf record -o- perf test -w noploop | perf report -i- -q --percent-limit=1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.229 MB - ]
      99.46%  perf     perf                  [.] noploop

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 91e6828c38cc..21ebcb04f1d8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1773,8 +1773,11 @@ record__finish_output(struct record *rec)
 	struct perf_data *data = &rec->data;
 	int fd = perf_data__fd(data);
 
-	if (data->is_pipe)
+	if (data->is_pipe) {
+		/* Just to display approx. size */
+		data->file.size = rec->bytes_written;
 		return;
+	}
 
 	rec->session->header.data_size += rec->bytes_written;
 	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
-- 
2.43.0.275.g3460e3d667-goog


