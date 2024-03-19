Return-Path: <linux-kernel+bounces-107977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05919880458
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CD21C228A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F9528E09;
	Tue, 19 Mar 2024 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfQJjsbC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03E925632
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871601; cv=none; b=LCM3BWGDpk2lwyUQyzDsLlHwB2b/u4AN/r9cldI6kCobNE4MCx8S22tdho86N65HNcnS4noeKCV3XSeAkgV9LNi0P9DOMVDTwJkaZcztXWXuK8jb6dlg9NsfIST4q/8JFWSzgfVx1HuB2Y5gXnXHbFAKIMu3PyATIilcQK0PfoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871601; c=relaxed/simple;
	bh=8ClaxzuJhKL2tfFR1+qlGoeYh7wNl34CYL9gNfr/p8I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jNnjSIGWOX6+MylqGJ58YM8N9rKIv8mZSulFeeIDPNO3t8Q7Arsmupd1w3xfltOpJkQqvD7VPRK24D+npyZ2Q+ClgKf52ylTGNQ3A0Gw/t1H13JC9lRtZ2oAVZXeMZBf6fB6BGSFrpqiFFmnvBkVugMMfpfJFxLpfkf07TJO+3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfQJjsbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF40C433C7;
	Tue, 19 Mar 2024 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710871600;
	bh=8ClaxzuJhKL2tfFR1+qlGoeYh7wNl34CYL9gNfr/p8I=;
	h=Date:From:To:Cc:Subject:From;
	b=DfQJjsbCqDkTnluRObx9olK4dg3mm1+UyWGtNOSBhFntruJG9//e9QysBgVtwzjYB
	 DQTt/3QFX/xyuAn7/1fcdRY43U0UYtvrQPeWh8JtQj4InLDjodAi42Dj/9AaOcWZH5
	 biWdBJf7XnrjMcyzvQ60TtmRgeDT2y3K8e7IBrIoDCkPo+YZM+zFzX3GCFh6VSom+c
	 RunPAjyyigGZd8cSJM7xOUhvi+fW9b5EU7XsPj1sKo6OnGjPUfhGMNnwK/PwayGeQx
	 AQR7zXjN2tVRNRSVUqkZZPn5XzBDx/SVxwawB/8lkRAY3nLvw4G/tLY7ysIVT9W0kl
	 xIO5PVF0stcrA==
Date: Tue, 19 Mar 2024 15:06:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf beauty: Introduce scraper script for 'clone'
 syscall 'flags' argument
Message-ID: <ZfnULIn3XKDq0bpc@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It was using the first variation on producing a string representation
for a binary flag, one that used the copy of uapi/linux/sched.h with
preprocessor tricks that had to be updated everytime a new flag was
introduced.

Use the more recent scraper script + strarray + strarray__scnprintf_flags() combo.

  $ tools/perf/trace/beauty/clone.sh | head -5
  static const char *clone_flags[] = {
  	[ilog2(0x00000100) + 1] = "VM",
  	[ilog2(0x00000200) + 1] = "FS",
  	[ilog2(0x00000400) + 1] = "FILES",
  	[ilog2(0x00000800) + 1] = "SIGHAND",
  $

Now we can move uapi/linux/sched.h from tools/include/, that is used for
building perf to the scrap only directory tools/perf/trace/beauty/include.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                      | 14 ++++--
 tools/perf/check-headers.sh                   |  2 +-
 tools/perf/trace/beauty/clone.c               | 46 ++-----------------
 tools/perf/trace/beauty/clone.sh              | 17 +++++++
 .../trace/beauty}/include/uapi/linux/sched.h  |  0
 5 files changed, 34 insertions(+), 45 deletions(-)
 create mode 100755 tools/perf/trace/beauty/clone.sh
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/sched.h (100%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f5654d06e31385b7..ccd2dcbc64f720d2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -485,13 +485,20 @@ x86_arch_asm_dir := $(srctree)/tools/arch/x86/include/asm/
 
 beauty_outdir := $(OUTPUT)trace/beauty/generated
 beauty_ioctl_outdir := $(beauty_outdir)/ioctl
-drm_ioctl_array := $(beauty_ioctl_outdir)/drm_ioctl_array.c
-drm_hdr_dir := $(srctree)/tools/include/uapi/drm
-drm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
 
 # Create output directory if not already present
 $(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_outdir)')
 
+clone_flags_array := $(beauty_outdir)/clone_flags_array.c
+clone_flags_tbl := $(srctree)/tools/perf/trace/beauty/clone.sh
+
+$(clone_flags_array): $(beauty_uapi_linux_dir)/sched.h $(clone_flags_tbl)
+	$(Q)$(SHELL) '$(clone_flags_tbl)' $(beauty_uapi_linux_dir) > $@
+
+drm_ioctl_array := $(beauty_ioctl_outdir)/drm_ioctl_array.c
+drm_hdr_dir := $(srctree)/tools/include/uapi/drm
+drm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
+
 $(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm_ioctl_tbl)
 	$(Q)$(SHELL) '$(drm_ioctl_tbl)' $(drm_hdr_dir) > $@
 
@@ -765,6 +772,7 @@ build-dir   = $(or $(__build-dir),.)
 
 prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders \
 	arm64-sysreg-defs \
+	$(clone_flags_array) \
 	$(drm_ioctl_array) \
 	$(fadvise_advice_array) \
 	$(fsconfig_arrays) \
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 859cd6f35b0ac9b1..413c9b747216020f 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -15,7 +15,6 @@ FILES=(
   "include/uapi/linux/kvm.h"
   "include/uapi/linux/in.h"
   "include/uapi/linux/perf_event.h"
-  "include/uapi/linux/sched.h"
   "include/uapi/linux/seccomp.h"
   "include/uapi/linux/vhost.h"
   "include/linux/bits.h"
@@ -93,6 +92,7 @@ BEAUTY_FILES=(
   "include/uapi/linux/fs.h"
   "include/uapi/linux/mount.h"
   "include/uapi/linux/prctl.h"
+  "include/uapi/linux/sched.h"
   "include/uapi/linux/usbdevice_fs.h"
   "include/uapi/sound/asound.h"
 )
diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/clone.c
index f4db894e0af6d14b..c9fa8f7e82b909fb 100644
--- a/tools/perf/trace/beauty/clone.c
+++ b/tools/perf/trace/beauty/clone.c
@@ -7,52 +7,16 @@
 
 #include "trace/beauty/beauty.h"
 #include <linux/kernel.h>
+#include <linux/log2.h>
 #include <sys/types.h>
-#include <uapi/linux/sched.h>
+#include <sched.h>
 
 static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
 {
-	const char *prefix = "CLONE_";
-	int printed = 0;
+#include "trace/beauty/generated/clone_flags_array.c"
+	static DEFINE_STRARRAY(clone_flags, "CLONE_");
 
-#define	P_FLAG(n) \
-	if (flags & CLONE_##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
-		flags &= ~CLONE_##n; \
-	}
-
-	P_FLAG(VM);
-	P_FLAG(FS);
-	P_FLAG(FILES);
-	P_FLAG(SIGHAND);
-	P_FLAG(PIDFD);
-	P_FLAG(PTRACE);
-	P_FLAG(VFORK);
-	P_FLAG(PARENT);
-	P_FLAG(THREAD);
-	P_FLAG(NEWNS);
-	P_FLAG(SYSVSEM);
-	P_FLAG(SETTLS);
-	P_FLAG(PARENT_SETTID);
-	P_FLAG(CHILD_CLEARTID);
-	P_FLAG(DETACHED);
-	P_FLAG(UNTRACED);
-	P_FLAG(CHILD_SETTID);
-	P_FLAG(NEWCGROUP);
-	P_FLAG(NEWUTS);
-	P_FLAG(NEWIPC);
-	P_FLAG(NEWUSER);
-	P_FLAG(NEWPID);
-	P_FLAG(NEWNET);
-	P_FLAG(IO);
-	P_FLAG(CLEAR_SIGHAND);
-	P_FLAG(INTO_CGROUP);
-#undef P_FLAG
-
-	if (flags)
-		printed += scnprintf(bf + printed, size - printed, "%s%#x", printed ? "|" : "", flags);
-
-	return printed;
+	return strarray__scnprintf_flags(&strarray__clone_flags, bf, size, show_prefix, flags);
 }
 
 size_t syscall_arg__scnprintf_clone_flags(char *bf, size_t size, struct syscall_arg *arg)
diff --git a/tools/perf/trace/beauty/clone.sh b/tools/perf/trace/beauty/clone.sh
new file mode 100755
index 0000000000000000..18b6c0d75693721d
--- /dev/null
+++ b/tools/perf/trace/beauty/clone.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+if [ $# -ne 1 ] ; then
+	beauty_uapi_linux_dir=tools/perf/trace/beauty/include/uapi/linux/
+else
+	beauty_uapi_linux_dir=$1
+fi
+
+linux_sched=${beauty_uapi_linux_dir}/sched.h
+
+printf "static const char *clone_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+CLONE_([^_]+[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+grep -E $regex ${linux_sched} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
diff --git a/tools/include/uapi/linux/sched.h b/tools/perf/trace/beauty/include/uapi/linux/sched.h
similarity index 100%
rename from tools/include/uapi/linux/sched.h
rename to tools/perf/trace/beauty/include/uapi/linux/sched.h
-- 
2.44.0


