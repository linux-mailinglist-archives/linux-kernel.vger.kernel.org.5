Return-Path: <linux-kernel+bounces-99567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E99A5878A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613EAB213FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EA756B81;
	Mon, 11 Mar 2024 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cpj4CVs8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5566A56B63
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192472; cv=none; b=KNF4KhuwiZeNjMKIEfYlKDdwu1lKOSfVKK7OK5ClILuOr17qq6OzppAZwt1yz0hOcRGX4kVDn/yVWEJM/1kYdJEg+hOGfDzsRm5ROWP2jge5rtNqkVJSEEtubT8VfEIpq+NFHBtFSz1rH99XsyKINJWJD9oM+XPS8ME4NOCy+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192472; c=relaxed/simple;
	bh=ZmdP1tSm+qb+nNPO2UUjNu7uMmVk4E96vMUzvsP8Lc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT6Ela21nJHdyreC6mdlWgU5vr3wxxLk9a9tUjaaOgLy+1lezdw7lRskZ9eiy/QsSjS6fxv8UISlph42c7boa+wnuXXY8806t1f3uQdHeick5a8L3N9dLZUDKPwpYbk30g/NnLxhpwYZsHBhT2zRoxT/yVHmjn0gpUBEQA1z6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cpj4CVs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F24C433F1;
	Mon, 11 Mar 2024 21:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710192471;
	bh=ZmdP1tSm+qb+nNPO2UUjNu7uMmVk4E96vMUzvsP8Lc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cpj4CVs8QxtXolkOfXKSPGD7cdQcOzYl+xjVIt7s4maGcs5drai0fkAaSU37k4Dzs
	 9hVcZ0CO7z1z2Y9KBQmoQ+ox8UIFFkKW0CetC+zd9ymx1BgXmjVdPtZTLMlIrOHnsF
	 +Hu/IS4/4Y9xIoj0OsSNIesVnXuJRM2M/e1TrtC2/olA8lgSJb/NGR0FHfpeoNugMg
	 u2r7U1a+1NGoueqUIvOHQtSp8jcb54pZoONIf5vMp8td/qnUp4JjT7mbNvLx3QSiL1
	 sIllTR+ssAGSno54ZJzboDDOP71/h3QgXNqGIGN+ZCh0hqVExHavgzZzGcad/J3uXK
	 zeAu1Qg04/Rfw==
Date: Mon, 11 Mar 2024 18:27:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf beauty: Move uapi/linux/fs.h copy out of the
 directory used to build perf
Message-ID: <Ze93VPYpegMMt5kk@x1>
References: <Ze9vjxv42PN_QGZv@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze9vjxv42PN_QGZv@x1>

It is mostly used only to generate string tables, not to build perf, so
move it to the tools/perf/trace/beauty/include/ hierarchy, that is used
just for scrapping.

The only case where it was being used to build was in
tools/perf/trace/beauty/sync_file_range.c, because some older systems
doesn't have the SYNC_FILE_RANGE_WRITE_AND_WAIT define, just use the
system's linux/fs.h header instead, defining it if not available.

This is something that should've have been done already, as happened
with the linux/socket.h scrapper, do it now as Ian suggested while doing
an audit/refactor session in the headers used by perf.

No other tools/ living code uses it, just <linux/fs.h> coming from
either 'make install_headers' or from the system /usr/include/
directory.

Suggested-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/CAP-5=fWZVrpRufO4w-S4EcSi9STXcTAN2ERLwTSN7yrSSA-otQ@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                              |  9 +++++----
 tools/perf/check-headers.sh                           |  2 +-
 tools/{ => perf/trace/beauty}/include/uapi/linux/fs.h |  0
 tools/perf/trace/beauty/rename_flags.sh               |  2 +-
 tools/perf/trace/beauty/sync_file_range.c             | 11 ++++++++++-
 tools/perf/trace/beauty/sync_file_range.sh            |  2 +-
 6 files changed, 18 insertions(+), 8 deletions(-)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/fs.h (100%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d3a568abc38919e8..643e9fa6ec89c58c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -472,6 +472,7 @@ arm64-sysreg-defs-clean:
 		clean > /dev/null
 
 beauty_linux_dir := $(srctree)/tools/perf/trace/beauty/include/linux/
+beauty_uapi_linux_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/linux/
 linux_uapi_dir := $(srctree)/tools/include/uapi/linux
 asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
 arch_asm_uapi_dir := $(srctree)/tools/arch/$(SRCARCH)/include/uapi/asm/
@@ -647,8 +648,8 @@ $(x86_arch_MSRs_array): $(x86_arch_asm_dir)/msr-index.h $(x86_arch_MSRs_tbl)
 rename_flags_array := $(beauty_outdir)/rename_flags_array.c
 rename_flags_tbl := $(srctree)/tools/perf/trace/beauty/rename_flags.sh
 
-$(rename_flags_array): $(linux_uapi_dir)/fs.h $(rename_flags_tbl)
-	$(Q)$(SHELL) '$(rename_flags_tbl)' $(linux_uapi_dir) > $@
+$(rename_flags_array): $(beauty_uapi_linux_dir)/fs.h $(rename_flags_tbl)
+	$(Q)$(SHELL) '$(rename_flags_tbl)' $(beauty_uapi_linux_dir) > $@
 
 arch_errno_name_array := $(beauty_outdir)/arch_errno_name_array.c
 arch_errno_hdr_dir := $(srctree)/tools
@@ -660,8 +661,8 @@ $(arch_errno_name_array): $(arch_errno_tbl)
 sync_file_range_arrays := $(beauty_outdir)/sync_file_range_arrays.c
 sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
 
-$(sync_file_range_arrays): $(linux_uapi_dir)/fs.h $(sync_file_range_tbls)
-	$(Q)$(SHELL) '$(sync_file_range_tbls)' $(linux_uapi_dir) > $@
+$(sync_file_range_arrays): $(beauty_uapi_linux_dir)/fs.h $(sync_file_range_tbls)
+	$(Q)$(SHELL) '$(sync_file_range_tbls)' $(beauty_uapi_linux_dir) > $@
 
 TESTS_CORESIGHT_DIR := $(srctree)/tools/perf/tests/shell/coresight
 
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 66ba33dbcef22b23..015f74137b755eaf 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -11,7 +11,6 @@ FILES=(
   "include/uapi/drm/i915_drm.h"
   "include/uapi/linux/fadvise.h"
   "include/uapi/linux/fcntl.h"
-  "include/uapi/linux/fs.h"
   "include/uapi/linux/fscrypt.h"
   "include/uapi/linux/kcmp.h"
   "include/uapi/linux/kvm.h"
@@ -98,6 +97,7 @@ SYNC_CHECK_FILES=(
 declare -a BEAUTY_FILES
 BEAUTY_FILES=(
   "include/linux/socket.h"
+  "include/uapi/linux/fs.h"
 )
 
 declare -a FAILURES
diff --git a/tools/include/uapi/linux/fs.h b/tools/perf/trace/beauty/include/uapi/linux/fs.h
similarity index 100%
rename from tools/include/uapi/linux/fs.h
rename to tools/perf/trace/beauty/include/uapi/linux/fs.h
diff --git a/tools/perf/trace/beauty/rename_flags.sh b/tools/perf/trace/beauty/rename_flags.sh
index 94bf7f45d28e6be6..702411dd7a1c2fc2 100755
--- a/tools/perf/trace/beauty/rename_flags.sh
+++ b/tools/perf/trace/beauty/rename_flags.sh
@@ -2,7 +2,7 @@
 # Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 # SPDX-License-Identifier: LGPL-2.1
 
-[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/perf/trace/beauty/include/uapi/linux/
 
 fs_header=${header_dir}/fs.h
 
diff --git a/tools/perf/trace/beauty/sync_file_range.c b/tools/perf/trace/beauty/sync_file_range.c
index 1c425f04047dbb24..3e8f50ff4fc701f9 100644
--- a/tools/perf/trace/beauty/sync_file_range.c
+++ b/tools/perf/trace/beauty/sync_file_range.c
@@ -7,7 +7,16 @@
 
 #include "trace/beauty/beauty.h"
 #include <linux/log2.h>
-#include <uapi/linux/fs.h>
+#include <linux/fs.h>
+
+#ifndef SYNC_FILE_RANGE_WRITE_AND_WAIT
+#define SYNC_FILE_RANGE_WAIT_BEFORE     1
+#define SYNC_FILE_RANGE_WRITE           2
+#define SYNC_FILE_RANGE_WAIT_AFTER      4
+#define SYNC_FILE_RANGE_WRITE_AND_WAIT  (SYNC_FILE_RANGE_WRITE | \
+                                         SYNC_FILE_RANGE_WAIT_BEFORE | \
+                                         SYNC_FILE_RANGE_WAIT_AFTER)
+#endif
 
 static size_t sync_file_range__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
 {
diff --git a/tools/perf/trace/beauty/sync_file_range.sh b/tools/perf/trace/beauty/sync_file_range.sh
index 90bf633be879909a..b1084c4cab636b52 100755
--- a/tools/perf/trace/beauty/sync_file_range.sh
+++ b/tools/perf/trace/beauty/sync_file_range.sh
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: LGPL-2.1
 
 if [ $# -ne 1 ] ; then
-	linux_header_dir=tools/include/uapi/linux
+	linux_header_dir=tools/perf/trace/beauty/include/uapi/linux/
 else
 	linux_header_dir=$1
 fi
-- 
2.44.0



