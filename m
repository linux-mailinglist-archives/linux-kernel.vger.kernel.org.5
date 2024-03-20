Return-Path: <linux-kernel+bounces-109347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8243F8817E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111CD285EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F9285C44;
	Wed, 20 Mar 2024 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxiqrRiq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0085950;
	Wed, 20 Mar 2024 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963087; cv=none; b=Mm72RmVBez+egw2pF9dr+2oGOEWrNyN3sJywrX6hK3SuNWB+tH5VhQtFM97YJh5zxdHkkrV6Sd2TYtSDdASWbCFRweYmwg/Y2OMJfir2Cwq18aJGOStNlpCbbsXA8ZySmpLlIW9HxFkddYuI7nGX4lrzjPMs/XMY3+d8QNCKeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963087; c=relaxed/simple;
	bh=ouhy4ZrWPGlt1lM2uzJYNGZ9IVtWJ9LBxEOjh5mHjXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbiY0VLjzbfXN1zSIRRb54Bn5Qg8GX6frLQS6SX3CEx47lgigFwugz2HMPzB85CPlwQbzxh/SVsujDeMjl1QdE22akvhVFPraZucIITttF7r9OYKl1gOvpJ1EW2s5Ybn9huLotd4Zzl8WSwzesF51FVcv1xMLIlGXtemkDxcQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxiqrRiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAD9C433C7;
	Wed, 20 Mar 2024 19:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710963087;
	bh=ouhy4ZrWPGlt1lM2uzJYNGZ9IVtWJ9LBxEOjh5mHjXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxiqrRiq/UpO+6/dEdp7kXh71yj6jGNvMxGES8Fye1w3n4c1nkZnbd+5XMfUi0bAD
	 tQ3RMeyJLCUP5ScSvKeDnRyNMm/Hfsb7gKWoj3Q9WQXE0TYmbHxr+G4L764uIbtu/0
	 cSUYp71DM3DsxiV1AcHtLcQI5LbETVMc4gCdnnyhf0tkciI6yMI6Mc6O19Uff51Fdr
	 a28wcgLNnQ8lqDqi4COFJZApCg6mhKuBVVs9AHeBfhfN9ZZD7dq108Pg4/uO9dZo9D
	 f0J/kpiRa546YOKMxKnVEKtE9RqIEeo9ukqNoFD+MIcF9XPzkK8nw3p/AF4L3OSljz
	 095yT0IUvLlMA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/5] perf beauty: Introduce faccessat2 flags scnprintf routine
Date: Wed, 20 Mar 2024 16:31:13 -0300
Message-ID: <20240320193115.811899-4-acme@kernel.org>
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

The fsaccessat and fsaccessat2 now have beautifiers for its arguments.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c            |  9 +++++++++
 tools/perf/trace/beauty/beauty.h      |  3 +++
 tools/perf/trace/beauty/fs_at_flags.c | 24 ++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8417387aafa8295d..58546e8af9fcf481 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -947,6 +947,15 @@ static const struct syscall_fmt syscall_fmts[] = {
 	  .arg = { [1] = STRARRAY(op, epoll_ctl_ops), }, },
 	{ .name	    = "eventfd2",
 	  .arg = { [1] = { .scnprintf = SCA_EFD_FLAGS, /* flags */ }, }, },
+	{ .name     = "faccessat",
+	  .arg = { [0] = { .scnprintf = SCA_FDAT,	  /* dirfd */ },
+		   [1] = { .scnprintf = SCA_FILENAME,	  /* pathname */ },
+		   [2] = { .scnprintf = SCA_ACCMODE,	  /* mode */ }, }, },
+	{ .name     = "faccessat2",
+	  .arg = { [0] = { .scnprintf = SCA_FDAT,	  /* dirfd */ },
+		   [1] = { .scnprintf = SCA_FILENAME,	  /* pathname */ },
+		   [2] = { .scnprintf = SCA_ACCMODE,	  /* mode */ },
+		   [3] = { .scnprintf = SCA_FACCESSAT2_FLAGS, /* flags */ }, }, },
 	{ .name	    = "fchmodat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
 	{ .name	    = "fchownat",
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index c94ae8701bc65a2f..78d10d92d351f8e2 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -237,6 +237,9 @@ size_t syscall_arg__scnprintf_socket_level(char *bf, size_t size, struct syscall
 size_t syscall_arg__scnprintf_fs_at_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FS_AT_FLAGS syscall_arg__scnprintf_fs_at_flags
 
+size_t syscall_arg__scnprintf_faccessat2_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_FACCESSAT2_FLAGS syscall_arg__scnprintf_faccessat2_flags
+
 size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STATX_MASK syscall_arg__scnprintf_statx_mask
 
diff --git a/tools/perf/trace/beauty/fs_at_flags.c b/tools/perf/trace/beauty/fs_at_flags.c
index 2a099953d9935782..c1365e8f0b96ef43 100644
--- a/tools/perf/trace/beauty/fs_at_flags.c
+++ b/tools/perf/trace/beauty/fs_at_flags.c
@@ -7,6 +7,7 @@
 
 #include "trace/beauty/beauty.h"
 #include <sys/types.h>
+#include <linux/fcntl.h>
 #include <linux/log2.h>
 
 #include "trace/beauty/generated/fs_at_flags_array.c"
@@ -24,3 +25,26 @@ size_t syscall_arg__scnprintf_fs_at_flags(char *bf, size_t size, struct syscall_
 
 	return fs_at__scnprintf_flags(flags, bf, size, show_prefix);
 }
+
+static size_t faccessat2__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
+{
+	int printed = 0;
+
+	// AT_EACCESS is the same as AT_REMOVEDIR, that is in fs_at_flags_array,
+	// special case it here.
+	if (flags & AT_EACCESS) {
+		flags &= ~AT_EACCESS;
+		printed += scnprintf(bf + printed, size - printed, "%sEACCESS%s",
+				     show_prefix ? strarray__fs_at_flags.prefix : "", flags ? "|" : "");
+	}
+
+	return strarray__scnprintf_flags(&strarray__fs_at_flags, bf + printed, size - printed, show_prefix, flags);
+}
+
+size_t syscall_arg__scnprintf_faccessat2_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	bool show_prefix = arg->show_string_prefix;
+	int flags = arg->val;
+
+	return faccessat2__scnprintf_flags(flags, bf, size, show_prefix);
+}
-- 
2.44.0


