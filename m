Return-Path: <linux-kernel+bounces-103424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B6187BF32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8392828CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E904770CD9;
	Thu, 14 Mar 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UL8gJ98w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA970CC5;
	Thu, 14 Mar 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427410; cv=none; b=UzgpiADwmTamhKtxuU3HjkIwc934ULUHX4min2gjtX7Idrk3biUcyYlPo9gEoBmTXKo5aU5JE5mPrvf0Jf/DL6T7DBNuHvsQ+Rv+rVwdsWv1POInr+I+BsEXPfya/fCHpg16GZ4FpC8fbEMY5cpRDfRCgerFN1mOE5iYHAZAx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427410; c=relaxed/simple;
	bh=4/2Ns/Hq0Rs34aMNvef4R5Xss7mQNMjLMM4CeUMLvx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ2ipMKHasMRLnBBySLjlTHIL3VN01Zbzxi3nFgHd4uyL4i/Rc9VzTemTzgYz8ltjBodNUd+RYu/nKCG6VdPyP30kKcOLG8//sNtDHKr/tPCnlOx0JARAS0NxP4OPRjQ92DT9wfQ0869CTymhrGOWfJZiLf8hG4vI2uPMLh8HEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UL8gJ98w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE16C433A6;
	Thu, 14 Mar 2024 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427410;
	bh=4/2Ns/Hq0Rs34aMNvef4R5Xss7mQNMjLMM4CeUMLvx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UL8gJ98w0flwQfFABIjrdl5/TenDw20tyvagKuqPKNUnscVStyLfAq8OlvE/G2KYY
	 fAubKZDL/YKsQhr0oFQrjKoDxMRAhLwwS7GI09o975IfiSwwB6MMaBfzEx64wKUFMc
	 DN7vG60QGr71vhvIjmbozdNjBq8go6LDNb+cXLzf9Dd253Iuedqp9LfcCfhi8SGz7T
	 Xe0omP78UOp9+f4VE14VuEF5vcC4Yefo7rLChZ4L5pT2TABNkh3ydVhDFkJ5nzJseu
	 vInz41YVLvkiNf4SnPllNpT44lyq/oebkYpwuTs91dtHOEmRgLmk+2HkEJldXvS2uA
	 KK85xD+poaF1Q==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/3] perf beauty: Move uapi/linux/usbdevice_fs.h copy out of the directory used to build perf
Date: Thu, 14 Mar 2024 11:43:18 -0300
Message-ID: <20240314144320.743217-2-acme@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240314144320.743217-1-acme@kernel.org>
References: <20240314144320.743217-1-acme@kernel.org>
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
 tools/perf/Makefile.perf                                    | 4 ++--
 tools/perf/check-headers.sh                                 | 2 +-
 .../trace/beauty}/include/uapi/linux/usbdevice_fs.h         | 0
 tools/perf/trace/beauty/usbdevfs_ioctl.sh                   | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/usbdevice_fs.h (100%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 523c3b7d6c9d3f51..53ec3765b4b2bd1b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -623,8 +623,8 @@ $(prctl_option_array): $(prctl_hdr_dir)/prctl.h $(prctl_option_tbl)
 usbdevfs_ioctl_array := $(beauty_ioctl_outdir)/usbdevfs_ioctl_array.c
 usbdevfs_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/usbdevfs_ioctl.sh
 
-$(usbdevfs_ioctl_array): $(linux_uapi_dir)/usbdevice_fs.h $(usbdevfs_ioctl_tbl)
-	$(Q)$(SHELL) '$(usbdevfs_ioctl_tbl)' $(linux_uapi_dir) > $@
+$(usbdevfs_ioctl_array): $(beauty_uapi_linux_dir)/usbdevice_fs.h $(usbdevfs_ioctl_tbl)
+	$(Q)$(SHELL) '$(usbdevfs_ioctl_tbl)' $(beauty_uapi_linux_dir) > $@
 
 x86_arch_prctl_code_array := $(beauty_outdir)/x86_arch_prctl_code_array.c
 x86_arch_prctl_code_tbl := $(srctree)/tools/perf/trace/beauty/x86_arch_prctl.sh
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index c2c26d6b87ef52f9..356ddb76a9541018 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -21,7 +21,6 @@ FILES=(
   "include/uapi/linux/sched.h"
   "include/uapi/linux/seccomp.h"
   "include/uapi/linux/stat.h"
-  "include/uapi/linux/usbdevice_fs.h"
   "include/uapi/linux/vhost.h"
   "include/uapi/sound/asound.h"
   "include/linux/bits.h"
@@ -98,6 +97,7 @@ BEAUTY_FILES=(
   "include/linux/socket.h"
   "include/uapi/linux/fs.h"
   "include/uapi/linux/mount.h"
+  "include/uapi/linux/usbdevice_fs.h"
 )
 
 declare -a FAILURES
diff --git a/tools/include/uapi/linux/usbdevice_fs.h b/tools/perf/trace/beauty/include/uapi/linux/usbdevice_fs.h
similarity index 100%
rename from tools/include/uapi/linux/usbdevice_fs.h
rename to tools/perf/trace/beauty/include/uapi/linux/usbdevice_fs.h
diff --git a/tools/perf/trace/beauty/usbdevfs_ioctl.sh b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
index b39cfb3720b80624..12a30a9a8e0c8f44 100755
--- a/tools/perf/trace/beauty/usbdevfs_ioctl.sh
+++ b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
@@ -1,21 +1,21 @@
 #!/bin/sh
 # SPDX-License-Identifier: LGPL-2.1
 
-[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+[ $# -eq 1 ] && beauty_uapi_linux_dir=$1 || beauty_uapi_linux_dir=tools/perf/trace/beauty/include/uapi/linux/
 
 # also as:
 # #define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)
 
 printf "static const char *usbdevfs_ioctl_cmds[] = {\n"
 regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)(\(\w+\))?[[:space:]]+_IO[CWR]{0,2}\([[:space:]]*(_IOC_\w+,[[:space:]]*)?'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
-grep -E "$regex" ${header_dir}/usbdevice_fs.h | grep -E -v 'USBDEVFS_\w+32[[:space:]]' | \
+grep -E "$regex" ${beauty_uapi_linux_dir}/usbdevice_fs.h | grep -E -v 'USBDEVFS_\w+32[[:space:]]' | \
 	sed -r "s/$regex/\4 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n\n"
 printf "#if 0\n"
 printf "static const char *usbdevfs_ioctl_32_cmds[] = {\n"
 regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
-grep -E $regex ${header_dir}/usbdevice_fs.h | grep -E 'USBDEVFS_\w+32[[:space:]]' | \
+grep -E $regex ${beauty_uapi_linux_dir}/usbdevice_fs.h | grep -E 'USBDEVFS_\w+32[[:space:]]' | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
-- 
2.43.2


