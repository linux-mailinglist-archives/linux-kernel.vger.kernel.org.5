Return-Path: <linux-kernel+bounces-104912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C587D59D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2C41F25204
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E61B5DF30;
	Fri, 15 Mar 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th2Jescx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9FE5DF1B;
	Fri, 15 Mar 2024 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535728; cv=none; b=O8z+wCbIH9+PZGElEaXJ5ytJ2+kddvqALhJVeuiTyH3O3mb0YtccMCNq1QriGJP9WUIbOinDqYHzedJK68CHTjayKnYj49pc8s7TjyYJBJ8jUjYW0qzQhbK+edwp2QpfFMzPAvLlOvimu9h+332iFiyoEZseJhv50u+FKOQL4O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535728; c=relaxed/simple;
	bh=sGWDJZ0P89LGVOcIO9kQVxIBj15Yndvpht5SzGy8FWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNdCWufbFa/GJ6JWNhN/lzKttWxeRIMgI5TLaEzGG+kVfeP5aaCGE09ZBR09PyHDwybv2DWRiIXFvzY+UUq/ruwjrrxBAIXRCXwQnWD6X5RDInfZrh0WErgsiVbza2XicX65p3mryHq8Wp7gA2dKYlKI7q/Xx+ovZDeKa+jpwlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th2Jescx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE53AC43394;
	Fri, 15 Mar 2024 20:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535727;
	bh=sGWDJZ0P89LGVOcIO9kQVxIBj15Yndvpht5SzGy8FWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Th2JescxUC5rkugLTby6T+OAHZ50YGKM6lM9f0XtpYB0LEaLuFlVlMcsOD8ljayO9
	 NVakU+9CrmchQQrPF3Bf/iMLl7KPQ5gvizAxfVVZwtlxnPCOejEWKxciBNobMXHUq5
	 2eWbxMJS19aBFiQh/aZAjqoYy3YPHQSliDG4ZXMJooRwOxvFkHmJgGQUQ8P0vaj/US
	 /NXbbak2OFa646LdHl47sovbcjPnhFyWXnFvEPqWzWzIoNt/j6APqhJpDhwMGpinpH
	 hwWTGGoL2vN/beh50/yxnlSXSmfuyoPdyb2eAchKV+jgs58W4UyanylOhTXxz0m6Ik
	 +luRHV/BF26yg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/5] perf beauty: Move prctl.h files (uapi/linux and x86's) copy out of the directory used to build perf
Date: Fri, 15 Mar 2024 17:48:32 -0300
Message-ID: <20240315204835.748716-3-acme@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240315204835.748716-1-acme@kernel.org>
References: <20240315204835.748716-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It is used only to generate string tables, not to build perf, so move it
to the tools/perf/trace/beauty/{include,arch}/ hierarchies, that is used
just for scraping.

This is a something that should've have happened, as happened with the
linux/socket.h scrapper, do it now as Ian suggested while doing an
audit/refactor session in the headers used by perf.

No other tools/ living code uses it, just <linux/usbdevice_fs.h> coming
from either 'make install_headers' or from the system /usr/include/
directory.

Suggested-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/CAP-5=fWZVrpRufO4w-S4EcSi9STXcTAN2ERLwTSN7yrSSA-otQ@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                              | 11 +++++------
 tools/perf/check-headers.sh                           |  4 ++--
 .../trace/beauty}/arch/x86/include/uapi/asm/prctl.h   |  0
 .../trace/beauty}/include/uapi/linux/prctl.h          |  0
 tools/perf/trace/beauty/prctl_option.sh               |  6 +++---
 tools/perf/trace/beauty/x86_arch_prctl.sh             |  4 ++--
 6 files changed, 12 insertions(+), 13 deletions(-)
 rename tools/{ => perf/trace/beauty}/arch/x86/include/uapi/asm/prctl.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/prctl.h (100%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c75342b21089fc6f..b36c0c68c346d1ac 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -475,11 +475,11 @@ beauty_linux_dir := $(srctree)/tools/perf/trace/beauty/include/linux/
 beauty_uapi_linux_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/linux/
 beauty_uapi_sound_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/sound/
 beauty_arch_asm_dir := $(srctree)/tools/perf/trace/beauty/arch/x86/include/asm/
+beauty_x86_arch_asm_uapi_dir := $(srctree)/tools/perf/trace/beauty/arch/x86/include/uapi/asm/
 
 linux_uapi_dir := $(srctree)/tools/include/uapi/linux
 asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
 arch_asm_uapi_dir := $(srctree)/tools/arch/$(SRCARCH)/include/uapi/asm/
-x86_arch_asm_uapi_dir := $(srctree)/tools/arch/x86/include/uapi/asm/
 x86_arch_asm_dir := $(srctree)/tools/arch/x86/include/asm/
 
 beauty_outdir := $(OUTPUT)trace/beauty/generated
@@ -617,11 +617,10 @@ $(mmap_prot_array): $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-
 	$(Q)$(SHELL) '$(mmap_prot_tbl)' $(asm_generic_uapi_dir) $(arch_asm_uapi_dir) > $@
 
 prctl_option_array := $(beauty_outdir)/prctl_option_array.c
-prctl_hdr_dir := $(srctree)/tools/include/uapi/linux/
 prctl_option_tbl := $(srctree)/tools/perf/trace/beauty/prctl_option.sh
 
-$(prctl_option_array): $(prctl_hdr_dir)/prctl.h $(prctl_option_tbl)
-	$(Q)$(SHELL) '$(prctl_option_tbl)' $(prctl_hdr_dir) > $@
+$(prctl_option_array): $(beauty_uapi_linux_dir)/prctl.h $(prctl_option_tbl)
+	$(Q)$(SHELL) '$(prctl_option_tbl)' $(beauty_uapi_linux_dir) > $@
 
 usbdevfs_ioctl_array := $(beauty_ioctl_outdir)/usbdevfs_ioctl_array.c
 usbdevfs_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/usbdevfs_ioctl.sh
@@ -632,8 +631,8 @@ $(usbdevfs_ioctl_array): $(beauty_uapi_linux_dir)/usbdevice_fs.h $(usbdevfs_ioct
 x86_arch_prctl_code_array := $(beauty_outdir)/x86_arch_prctl_code_array.c
 x86_arch_prctl_code_tbl := $(srctree)/tools/perf/trace/beauty/x86_arch_prctl.sh
 
-$(x86_arch_prctl_code_array): $(x86_arch_asm_uapi_dir)/prctl.h $(x86_arch_prctl_code_tbl)
-	$(Q)$(SHELL) '$(x86_arch_prctl_code_tbl)' $(x86_arch_asm_uapi_dir) > $@
+$(x86_arch_prctl_code_array): $(beauty_x86_arch_asm_uapi_dir)/prctl.h $(x86_arch_prctl_code_tbl)
+	$(Q)$(SHELL) '$(x86_arch_prctl_code_tbl)' $(beauty_x86_arch_asm_uapi_dir) > $@
 
 x86_arch_irq_vectors_array := $(beauty_outdir)/x86_arch_irq_vectors_array.c
 x86_arch_irq_vectors_tbl := $(srctree)/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index b35eba5e99c8d91f..03d00110a48fcb9a 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -17,7 +17,6 @@ FILES=(
   "include/uapi/linux/in.h"
   "include/uapi/linux/openat2.h"
   "include/uapi/linux/perf_event.h"
-  "include/uapi/linux/prctl.h"
   "include/uapi/linux/sched.h"
   "include/uapi/linux/seccomp.h"
   "include/uapi/linux/stat.h"
@@ -35,7 +34,6 @@ FILES=(
   "arch/x86/include/asm/inat_types.h"
   "arch/x86/include/asm/emulate_prefix.h"
   "arch/x86/include/asm/msr-index.h"
-  "arch/x86/include/uapi/asm/prctl.h"
   "arch/x86/lib/x86-opcode-map.txt"
   "arch/x86/tools/gen-insn-attr-x86.awk"
   "arch/arm/include/uapi/asm/perf_regs.h"
@@ -93,9 +91,11 @@ SYNC_CHECK_FILES=(
 declare -a BEAUTY_FILES
 BEAUTY_FILES=(
   "arch/x86/include/asm/irq_vectors.h"
+  "arch/x86/include/uapi/asm/prctl.h"
   "include/linux/socket.h"
   "include/uapi/linux/fs.h"
   "include/uapi/linux/mount.h"
+  "include/uapi/linux/prctl.h"
   "include/uapi/linux/usbdevice_fs.h"
   "include/uapi/sound/asound.h"
 )
diff --git a/tools/arch/x86/include/uapi/asm/prctl.h b/tools/perf/trace/beauty/arch/x86/include/uapi/asm/prctl.h
similarity index 100%
rename from tools/arch/x86/include/uapi/asm/prctl.h
rename to tools/perf/trace/beauty/arch/x86/include/uapi/asm/prctl.h
diff --git a/tools/include/uapi/linux/prctl.h b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
similarity index 100%
rename from tools/include/uapi/linux/prctl.h
rename to tools/perf/trace/beauty/include/uapi/linux/prctl.h
diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
index 9455d9672f140d13..e049f5e9c01116fb 100755
--- a/tools/perf/trace/beauty/prctl_option.sh
+++ b/tools/perf/trace/beauty/prctl_option.sh
@@ -1,18 +1,18 @@
 #!/bin/sh
 # SPDX-License-Identifier: LGPL-2.1
 
-[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+[ $# -eq 1 ] && beauty_uapi_linux_dir=$1 || beauty_uapi_linux_dir=tools/perf/trace/beauty/include/uapi/linux/
 
 printf "static const char *prctl_options[] = {\n"
 regex='^#define[[:space:]]{1}PR_(\w+)[[:space:]]*([[:xdigit:]]+)([[:space:]]*/.*)?$'
-grep -E $regex ${header_dir}/prctl.h | grep -v PR_SET_PTRACER | \
+grep -E $regex ${beauty_uapi_linux_dir}/prctl.h | grep -v PR_SET_PTRACER | \
 	sed -E "s%$regex%\2 \1%g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
 
 printf "static const char *prctl_set_mm_options[] = {\n"
 regex='^#[[:space:]]+define[[:space:]]+PR_SET_MM_(\w+)[[:space:]]*([[:digit:]]+).*'
-grep -E $regex ${header_dir}/prctl.h | \
+grep -E $regex ${beauty_uapi_linux_dir}/prctl.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/x86_arch_prctl.sh b/tools/perf/trace/beauty/x86_arch_prctl.sh
index b1596df251f0aa9f..b714ffa3cb7a4ed8 100755
--- a/tools/perf/trace/beauty/x86_arch_prctl.sh
+++ b/tools/perf/trace/beauty/x86_arch_prctl.sh
@@ -2,9 +2,9 @@
 # Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 # SPDX-License-Identifier: LGPL-2.1
 
-[ $# -eq 1 ] && x86_header_dir=$1 || x86_header_dir=tools/arch/x86/include/uapi/asm/
+[ $# -eq 1 ] && beauty_x86_arch_asm_uapi_dir=$1 || beauty_x86_arch_asm_uapi_dir=tools/perf/trace/beauty/arch/x86/include/uapi/asm/
 
-prctl_arch_header=${x86_header_dir}/prctl.h
+prctl_arch_header=${beauty_x86_arch_asm_uapi_dir}/prctl.h
 
 print_range () {
 	idx=$1
-- 
2.43.2


