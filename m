Return-Path: <linux-kernel+bounces-109349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA128817EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1C4285BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878588565F;
	Wed, 20 Mar 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZY1ZrA5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19158613F;
	Wed, 20 Mar 2024 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963091; cv=none; b=RdjIGERs2oh8RD6W+Y9DHnxQhDJ5Zfs3LaDOsGEpXy/l4VebePIDNIYnrT5jojizcYE2iEL2uI8WD68vZVFq0OJ7JAZliSVTJUsmBtRqq2DskVuUCh9uJgMoNUPpm7TEMCYIjRoBfXEN2N70on2UI54MjSue31Q7N/NV/bynoBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963091; c=relaxed/simple;
	bh=eUsuge4+k2kINM17oy2Ter3CncLnZySKltBWMB5vbbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTOYs3knViQxNzb6y/noPk+tBMyxQfYxeOAeeruNBXEkdV1pk+rDe0EEJpeSenxP3/xWpDOcAaEsosGPj78EbslG5qj/EnBoLKdQ5RKfmBlnuAibXbYBHedi/vNTpSb+rlq45rwk4cVbkNd4gBhg4HVhfpv2Sna9JRFJcGNJYTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZY1ZrA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB80C43390;
	Wed, 20 Mar 2024 19:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710963091;
	bh=eUsuge4+k2kINM17oy2Ter3CncLnZySKltBWMB5vbbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZY1ZrA5S0DC73gt5+EmLLLY7vwtrq0eJygxt9XgK77vnYr9sMbj2Df0hZ3Mtu/5l
	 mSiXeAOIUeKfow22tazsZSrRKEx0D+yPhZH1Hs96ey9NJEVtWS9jlYt7ode1tstaeY
	 mAyrXS6z5udHAPBrR2GCWY7COT1/06cODxB5/AWpz7+vYeTn8rMO4h/uF8EevAc04l
	 6xsTzVTPpXFHqKYq8DMtgJPgALpyH2J66oTQUX+5I6wChSr7MVgrO7tGu4RuSmgxwd
	 /ap8binKOZrO7qMbYDt7pA7MTNBEwnXkVLQciDUCNEUkLqB199a1oPf6v+BpDDZ4Jl
	 L2WSkqHExIM0g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/5] perf trace: Fix 'newfstatat'/'fstatat' argument pretty printing
Date: Wed, 20 Mar 2024 16:31:15 -0300
Message-ID: <20240320193115.811899-6-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320193115.811899-1-acme@kernel.org>
References: <20240320193115.811899-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There were needless two entries, one for 'newfstatat' and another for
'fstatat', keep just one and pretty print its 'flags' argument using the
fs_at_flags scnprintf that is also used by other FS syscalls such as
'stat', now:

  root@number:~# perf trace -e newfstatat --max-events=5
       0.000 ( 0.010 ms): abrt-dump-jour/1400 newfstatat(dfd: 7, filename: "", statbuf: 0x7fff0d127000, flag: EMPTY_PATH) = 0
       0.020 ( 0.003 ms): abrt-dump-jour/1400 newfstatat(dfd: 9, filename: "", statbuf: 0x55752507b0e8, flag: EMPTY_PATH) = 0
       0.039 ( 0.004 ms): abrt-dump-jour/1400 newfstatat(dfd: 19, filename: "", statbuf: 0x557525061378, flag: EMPTY_PATH) = 0
       0.047 ( 0.003 ms): abrt-dump-jour/1400 newfstatat(dfd: 20, filename: "", statbuf: 0x5575250b8cc8, flag: EMPTY_PATH) = 0
       0.053 ( 0.003 ms): abrt-dump-jour/1400 newfstatat(dfd: 22, filename: "", statbuf: 0x5575250535d8, flag: EMPTY_PATH) = 0
  root@number:~#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ef0dfffd99fdf3cc..d3ec244e692a415e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -978,7 +978,6 @@ static const struct syscall_fmt syscall_fmts[] = {
 		   [1] = { .scnprintf = SCA_FILENAME,	  /* path */ },
 		   [2] = { .scnprintf = SCA_FSPICK_FLAGS, /* flags */ }, }, },
 	{ .name	    = "fstat", .alias = "newfstat", },
-	{ .name	    = "fstatat", .alias = "newfstatat", },
 	{ .name	    = "futex",
 	  .arg = { [1] = { .scnprintf = SCA_FUTEX_OP, /* op */ },
 		   [5] = { .scnprintf = SCA_FUTEX_VAL3, /* val3 */ }, }, },
@@ -1060,8 +1059,10 @@ static const struct syscall_fmt syscall_fmts[] = {
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "nanosleep",
 	  .arg = { [0] = { .scnprintf = SCA_TIMESPEC,  /* req */ }, }, },
-	{ .name	    = "newfstatat",
-	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
+	{ .name	    = "newfstatat", .alias = "fstatat",
+	  .arg = { [0] = { .scnprintf = SCA_FDAT,	  /* dirfd */ },
+		   [1] = { .scnprintf = SCA_FILENAME,	  /* pathname */ },
+		   [3] = { .scnprintf = SCA_FS_AT_FLAGS, /* flags */ }, }, },
 	{ .name	    = "open",
 	  .arg = { [1] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "open_by_handle_at",
-- 
2.44.0


