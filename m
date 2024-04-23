Return-Path: <linux-kernel+bounces-154411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E62428ADBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741B8B2143A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9B41757E;
	Tue, 23 Apr 2024 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlIRpWs8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB718032;
	Tue, 23 Apr 2024 02:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713838005; cv=none; b=EcpFhBTBRqywlTRJwDd8yufQPQGWxXRG9owZNX5jmKcT0V7wI+XmF2R+vCDsQBDhlB2Xm6IL0mL8t+6BWX1XU6w+Tczi1BZz3bk7P+mDrKFm5CXcpn6M5U9JgWEtTPwqnFD2PRI1wDhsFcY6GAgBp+/1ZoLu8Gqw+bsmDRp2I4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713838005; c=relaxed/simple;
	bh=ogXRlyQDF48jL0NCQeA7zQfgTa3D/mdWfZ5ATMLTBV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1XrwHKT9VE7mzmggSIGAGLG50FKs3Hxbl9Q5d9XXQUAzFfgw1cn6tePjG2rQOkYV6ch1a71WSpLIZR50x5VBz+yxtgLaOaLhqx+DVPyPrSuSCAuYKG2zWfG6uAmZyuJ2ROPY0BaSPhaQUOpxBF9Jc1l+qbq+85FATvihtRrjwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlIRpWs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B436C113CC;
	Tue, 23 Apr 2024 02:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713838004;
	bh=ogXRlyQDF48jL0NCQeA7zQfgTa3D/mdWfZ5ATMLTBV8=;
	h=From:To:Cc:Subject:Date:From;
	b=KlIRpWs8HMZS1zu3PjcrT0eMLFS54U3HXCKasC8tEnk/ifQWO/WMGkCYnf+XyyL7R
	 xALt7J9HQxbco4yBtwciRG13nKFTTtPps5ga4LUaanYdcv30YnmtVS7SBjk01eLuYY
	 KShj4vtgGUHwkvszqRqcuQ6Y88y0I1v+EJsYj0Elg+fjHpa/ffEegmunv+Pb4YXmX+
	 1X0oEi2sbVc8yjILA9zD+lvHZtA2A8LPHh5wPwI+RRFH6CvUvrBuqaNjXWMGxngLbh
	 TxOcz4+4QTes6FTkJWRQ9FVuyi1euvFQpQGNmGZcYSV7mrT0RIIK6uUkz2OjjJoM6T
	 AnkYwakdvlkfA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf annotate: Fix data type profiling on stdio
Date: Mon, 22 Apr 2024 19:06:43 -0700
Message-ID: <20240423020643.740029-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop in hists__find_annotations() never set the 'nd' pointer to NULL
and it makes stdio output repeating the last element forever.  I think
it doesn't set to NULL for TUI to prevent it from exiting unexpectedly.
But it should just set on stdio mode.

Fixes: d001c7a7f473 ("perf annotate-data: Add hist_entry__annotate_data_tui()")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6f7104f06c42..83812b9d5363 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -491,7 +491,7 @@ static void hists__find_annotations(struct hists *hists,
 				return;
 			}
 
-			if (next != NULL)
+			if (use_browser == 0 || next != NULL)
 				nd = next;
 
 			continue;
-- 
2.44.0.769.g3c40516874-goog


