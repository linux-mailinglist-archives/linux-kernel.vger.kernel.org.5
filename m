Return-Path: <linux-kernel+bounces-100776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4453A879D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEFD1B23412
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BC3143C48;
	Tue, 12 Mar 2024 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrPOuVw7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA61014374F;
	Tue, 12 Mar 2024 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710276692; cv=none; b=pVyaU8Q2RHEENFoRxoBWNPSnZ0xdi8cnPQy+/unnF9ALdjLN9L+XAhsVLZEcLPAagZg5BT5WEeyAuayhoPUOa1pPtahrmfUwhfl+aNEJhuk4AcnuCPqxsVUiFEwzDBC4wYdXkUmsVa/WQx0JaqroDt1aBYpIt+jBX/r9lcQyS0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710276692; c=relaxed/simple;
	bh=2TiUaR/zgBzTGSvXrzZw/55Fy772pQs7tRpaW5Bu84A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3bLrWw0tcEYE3Ea1yQ1D2VwFf6V+tMJATFen1ymUfpY66A8NZ6GEaiPatrKI8c54qnD9QlyQESLKYdPFe7cZNagdvbTPqn1plx4KmhgUgZAkfEkBDHzE5HxTUpxMaW7wwC6goRsBYVnF9v2S8YT+f8EpQA5PIQYonLl6nTkxBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrPOuVw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB84EC433F1;
	Tue, 12 Mar 2024 20:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710276692;
	bh=2TiUaR/zgBzTGSvXrzZw/55Fy772pQs7tRpaW5Bu84A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IrPOuVw7OIbxE4pqJbkd75rdxc4tGeU+qz6+wcQhPE2GbOv8efgxxvLi4/2njq8vd
	 kMoYEdXsjpaQ8BZ1K/yh03oq5UKf5SYMUyCWtby/2dfq6s8LaA6OElIw6JyUqZfIsk
	 OgXy9oCwwD4tkIfmzTuXlwkqN841lCESbauVIU/UTG69+U24NBGKRUppdxVt8HfKJ+
	 WCn+++6r+xZKRNfC73CtSXSEv+NAhnNQOEGTMy0ZQx+G6tzkyp5NH/SCKo12a8rqvk
	 vGwwYorBm3XZWXXcZibymrQnCaoUsXprT79Jkgtj5gKnJNAmUCBpO+SfTHq8dXic/E
	 wLUW+O2o/oZYg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/2] perf beauty: Move uapi/linux/mount.h copy out of the directory used to build perf
Date: Tue, 12 Mar 2024 17:51:12 -0300
Message-ID: <20240312205112.688776-3-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312205112.688776-1-acme@kernel.org>
References: <20240312205112.688776-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It is mostly used only to generate string tables, not to build perf, so
move it to the tools/perf/trace/beauty/include/ hierarchy, that is used
just for scrapping.

This is a something that should've have happened, as happened with the
linux/socket.h scrapper, do it now as Ian suggested while doing an
audit/refactor session in the headers used by perf.

No other tools/ living code uses it, just <linux/mount.h> coming from
either 'make install_headers' or from the system /usr/include/
directory.

Suggested-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/CAP-5=fWZVrpRufO4w-S4EcSi9STXcTAN2ERLwTSN7yrSSA-otQ@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                      | 21 +++++++++----------
 tools/perf/check-headers.sh                   |  2 +-
 tools/perf/trace/beauty/fsconfig.sh           |  6 +++---
 tools/perf/trace/beauty/fsmount.sh            |  6 +++---
 tools/perf/trace/beauty/fspick.sh             |  6 +++---
 .../trace/beauty}/include/uapi/linux/mount.h  |  0
 tools/perf/trace/beauty/mount_flags.sh        |  6 +++---
 tools/perf/trace/beauty/move_mount_flags.sh   |  6 +++---
 8 files changed, 26 insertions(+), 27 deletions(-)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/mount.h (100%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 643e9fa6ec89c58c..523c3b7d6c9d3f51 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -500,20 +500,20 @@ $(fadvise_advice_array): $(linux_uapi_dir)/in.h $(fadvise_advice_tbl)
 fsmount_arrays := $(beauty_outdir)/fsmount_arrays.c
 fsmount_tbls := $(srctree)/tools/perf/trace/beauty/fsmount.sh
 
-$(fsmount_arrays): $(linux_uapi_dir)/mount.h $(fsmount_tbls)
-	$(Q)$(SHELL) '$(fsmount_tbls)' $(linux_uapi_dir) > $@
+$(fsmount_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsmount_tbls)
+	$(Q)$(SHELL) '$(fsmount_tbls)' $(beauty_uapi_linux_dir) > $@
 
 fspick_arrays := $(beauty_outdir)/fspick_arrays.c
 fspick_tbls := $(srctree)/tools/perf/trace/beauty/fspick.sh
 
-$(fspick_arrays): $(linux_uapi_dir)/mount.h $(fspick_tbls)
-	$(Q)$(SHELL) '$(fspick_tbls)' $(linux_uapi_dir) > $@
+$(fspick_arrays): $(beauty_uapi_linux_dir)/mount.h $(fspick_tbls)
+	$(Q)$(SHELL) '$(fspick_tbls)' $(beauty_uapi_linux_dir) > $@
 
 fsconfig_arrays := $(beauty_outdir)/fsconfig_arrays.c
 fsconfig_tbls := $(srctree)/tools/perf/trace/beauty/fsconfig.sh
 
-$(fsconfig_arrays): $(linux_uapi_dir)/mount.h $(fsconfig_tbls)
-	$(Q)$(SHELL) '$(fsconfig_tbls)' $(linux_uapi_dir) > $@
+$(fsconfig_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsconfig_tbls)
+	$(Q)$(SHELL) '$(fsconfig_tbls)' $(beauty_uapi_linux_dir) > $@
 
 pkey_alloc_access_rights_array := $(beauty_outdir)/pkey_alloc_access_rights_array.c
 asm_generic_hdr_dir := $(srctree)/tools/include/uapi/asm-generic/
@@ -598,15 +598,14 @@ $(mremap_flags_array): $(linux_uapi_dir)/mman.h $(mremap_flags_tbl)
 mount_flags_array := $(beauty_outdir)/mount_flags_array.c
 mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/mount_flags.sh
 
-$(mount_flags_array): $(linux_uapi_dir)/mount.h $(mount_flags_tbl)
-	$(Q)$(SHELL) '$(mount_flags_tbl)' $(linux_uapi_dir) > $@
+$(mount_flags_array): $(beauty_uapi_linux_dir)/mount.h $(mount_flags_tbl)
+	$(Q)$(SHELL) '$(mount_flags_tbl)' $(beauty_uapi_linux_dir) > $@
 
 move_mount_flags_array := $(beauty_outdir)/move_mount_flags_array.c
 move_mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/move_mount_flags.sh
 
-$(move_mount_flags_array): $(linux_uapi_dir)/mount.h $(move_mount_flags_tbl)
-	$(Q)$(SHELL) '$(move_mount_flags_tbl)' $(linux_uapi_dir) > $@
-
+$(move_mount_flags_array): $(beauty_uapi_linux_dir)/mount.h $(move_mount_flags_tbl)
+	$(Q)$(SHELL) '$(move_mount_flags_tbl)' $(beauty_uapi_linux_dir) > $@
 
 mmap_prot_array := $(beauty_outdir)/mmap_prot_array.c
 mmap_prot_tbl := $(srctree)/tools/perf/trace/beauty/mmap_prot.sh
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 015f74137b755eaf..c2c26d6b87ef52f9 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -15,7 +15,6 @@ FILES=(
   "include/uapi/linux/kcmp.h"
   "include/uapi/linux/kvm.h"
   "include/uapi/linux/in.h"
-  "include/uapi/linux/mount.h"
   "include/uapi/linux/openat2.h"
   "include/uapi/linux/perf_event.h"
   "include/uapi/linux/prctl.h"
@@ -98,6 +97,7 @@ declare -a BEAUTY_FILES
 BEAUTY_FILES=(
   "include/linux/socket.h"
   "include/uapi/linux/fs.h"
+  "include/uapi/linux/mount.h"
 )
 
 declare -a FAILURES
diff --git a/tools/perf/trace/beauty/fsconfig.sh b/tools/perf/trace/beauty/fsconfig.sh
index bc6ef7bb7a5f93c2..09cee79de00ca35d 100755
--- a/tools/perf/trace/beauty/fsconfig.sh
+++ b/tools/perf/trace/beauty/fsconfig.sh
@@ -2,12 +2,12 @@
 # SPDX-License-Identifier: LGPL-2.1
 
 if [ $# -ne 1 ] ; then
-	linux_header_dir=tools/include/uapi/linux
+	beauty_uapi_linux_dir=tools/perf/trace/beauty/include/uapi/linux/
 else
-	linux_header_dir=$1
+	beauty_uapi_linux_dir=$1
 fi
 
-linux_mount=${linux_header_dir}/mount.h
+linux_mount=${beauty_uapi_linux_dir}/mount.h
 
 printf "static const char *fsconfig_cmds[] = {\n"
 ms='[[:space:]]*'
diff --git a/tools/perf/trace/beauty/fsmount.sh b/tools/perf/trace/beauty/fsmount.sh
index cba8897a751fd487..6b67a54cdeee64b3 100755
--- a/tools/perf/trace/beauty/fsmount.sh
+++ b/tools/perf/trace/beauty/fsmount.sh
@@ -2,12 +2,12 @@
 # SPDX-License-Identifier: LGPL-2.1
 
 if [ $# -ne 1 ] ; then
-	linux_header_dir=tools/include/uapi/linux
+	beauty_uapi_linux_dir=tools/perf/trace/beauty/include/uapi/linux/
 else
-	linux_header_dir=$1
+	beauty_uapi_linux_dir=$1
 fi
 
-linux_mount=${linux_header_dir}/mount.h
+linux_mount=${beauty_uapi_linux_dir}/mount.h
 
 # Remove MOUNT_ATTR_RELATIME as it is zeros, handle it a special way in the beautifier
 # Only handle MOUNT_ATTR_ followed by a capital letter/num as __ is special case
diff --git a/tools/perf/trace/beauty/fspick.sh b/tools/perf/trace/beauty/fspick.sh
index 1f088329b96ef0f2..0d9951c22b952ed1 100755
--- a/tools/perf/trace/beauty/fspick.sh
+++ b/tools/perf/trace/beauty/fspick.sh
@@ -2,12 +2,12 @@
 # SPDX-License-Identifier: LGPL-2.1
 
 if [ $# -ne 1 ] ; then
-	linux_header_dir=tools/include/uapi/linux
+	beauty_uapi_linux_dir=tools/perf/trace/beauty/include/uapi/linux/
 else
-	linux_header_dir=$1
+	beauty_uapi_linux_dir=$1
 fi
 
-linux_mount=${linux_header_dir}/mount.h
+linux_mount=${beauty_uapi_linux_dir}/mount.h
 
 printf "static const char *fspick_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+FSPICK_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
diff --git a/tools/include/uapi/linux/mount.h b/tools/perf/trace/beauty/include/uapi/linux/mount.h
similarity index 100%
rename from tools/include/uapi/linux/mount.h
rename to tools/perf/trace/beauty/include/uapi/linux/mount.h
diff --git a/tools/perf/trace/beauty/mount_flags.sh b/tools/perf/trace/beauty/mount_flags.sh
index 730099a9a67c1e57..ff578f7b451b5a1d 100755
--- a/tools/perf/trace/beauty/mount_flags.sh
+++ b/tools/perf/trace/beauty/mount_flags.sh
@@ -1,15 +1,15 @@
 #!/bin/sh
 # SPDX-License-Identifier: LGPL-2.1
 
-[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+[ $# -eq 1 ] && beauty_uapi_linux_dir=$1 || beauty_uapi_linux_dir=tools/perf/trace/beauty/include/uapi/linux/
 
 printf "static const char *mount_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+([[:digit:]]+)[[:space:]]*.*'
-grep -E $regex ${header_dir}/mount.h | grep -E -v '(MSK|VERBOSE|MGC_VAL)\>' | \
+grep -E $regex ${beauty_uapi_linux_dir}/mount.h | grep -E -v '(MSK|VERBOSE|MGC_VAL)\>' | \
 	sed -r "s/$regex/\2 \2 \1/g" | sort -n | \
 	xargs printf "\t[%s ? (ilog2(%s) + 1) : 0] = \"%s\",\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+\(1<<([[:digit:]]+)\)[[:space:]]*.*'
-grep -E $regex ${header_dir}/mount.h | \
+grep -E $regex ${beauty_uapi_linux_dir}/mount.h | \
 	sed -r "s/$regex/\2 \1/g" | \
 	xargs printf "\t[%s + 1] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/move_mount_flags.sh b/tools/perf/trace/beauty/move_mount_flags.sh
index ce5e632d14484bd2..c0dde9020bc38c21 100755
--- a/tools/perf/trace/beauty/move_mount_flags.sh
+++ b/tools/perf/trace/beauty/move_mount_flags.sh
@@ -2,12 +2,12 @@
 # SPDX-License-Identifier: LGPL-2.1
 
 if [ $# -ne 1 ] ; then
-	linux_header_dir=tools/include/uapi/linux
+	beauty_uapi_linux_dir=tools/perf/trace/beauty/include/uapi/linux/
 else
-	linux_header_dir=$1
+	beauty_uapi_linux_dir=$1
 fi
 
-linux_mount=${linux_header_dir}/mount.h
+linux_mount=${beauty_uapi_linux_dir}/mount.h
 
 printf "static const char *move_mount_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MOVE_MOUNT_([^_]+[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
-- 
2.43.0


