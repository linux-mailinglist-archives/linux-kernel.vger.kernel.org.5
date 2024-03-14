Return-Path: <linux-kernel+bounces-103425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8954087BF34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64971C20F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5EC7173C;
	Thu, 14 Mar 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpE60dsJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965227172A;
	Thu, 14 Mar 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427412; cv=none; b=cfBZahJnUbUV+uLtMhzQeEuWRYlt4BsX3ry5GLzU22xhncySqHLN3L4RCLnPeDICLmHYTpPtc3WoizZSrCfPJNxj/ckzfz1H4Ip5FqWACiUNj53Ii2Dp5K8U7Vry4l0Rr+r3UVeQw+0Ns6en/iU2kX+voaEPPuhbFbja7b2gJwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427412; c=relaxed/simple;
	bh=0CsKTVsV7I+F+KykRRbGJEPArCzk7FL+LI861CU65N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOLmK2DefqbfDQwachXDPR7EEnUu0llLLyE2cYec0Tz9V2YXnscCOiry1QO+g91KsvMnXh//GQmy2g54BuHWgyEXwhz0uhQ6DZLaqpff1LnxusZrg+JYZEMzh+tecawqd8f1309X7uwd3jImBOo5w0DUZuvU5F8eES7fjt8PQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpE60dsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70645C43399;
	Thu, 14 Mar 2024 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427412;
	bh=0CsKTVsV7I+F+KykRRbGJEPArCzk7FL+LI861CU65N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GpE60dsJ9Lx2kwlqP/6aen34iZ0dgQzlN111pLhGg/BfgNKCE/5Fqwn8BejvEc+x6
	 qG4KtFOOho4sycRcJ51odIluFOVjuogkAC4tlngSc63zZ3+W7qwS/aEt93W0eRDKzS
	 yBfOUy0vhL1SGfkf732/hpgr3fFsB8i0gOpatJloe4G1XxH3v2U3U4w5hMXChi1QGV
	 tnxWCfCayNHKbY+dmh8m8vi7HZ6hES1a/K7uCcrt9kELe5V2rwvwA31TODCEa+5x33
	 2lr47My4cmGbMFSqe9BNq7vDZopzfcbL2wPBrY6knXc//+j9+R83tyro4HEPH/Ov2K
	 h5py27EwFsHcQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/3] perf beauty: Move uapi/sound/asound.h copy out of the directory used to build perf
Date: Thu, 14 Mar 2024 11:43:19 -0300
Message-ID: <20240314144320.743217-3-acme@kernel.org>
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

It is used only to generate string tables, not to build perf, so move it
to the tools/perf/trace/beauty/include/ hierarchy, that is used just for
scrapping.

This is a something that should've have happened, as happened with the
linux/socket.h scrapper, do it now as Ian suggested while doing an
audit/refactor session in the headers used by perf.

Suggested-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/CAP-5=fWZVrpRufO4w-S4EcSi9STXcTAN2ERLwTSN7yrSSA-otQ@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                                 | 9 +++++----
 tools/perf/check-headers.sh                              | 2 +-
 .../{ => perf/trace/beauty}/include/uapi/sound/asound.h  | 0
 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh               | 4 ++--
 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh               | 4 ++--
 5 files changed, 10 insertions(+), 9 deletions(-)
 rename tools/{ => perf/trace/beauty}/include/uapi/sound/asound.h (100%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 53ec3765b4b2bd1b..757777d968602ded 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -473,6 +473,7 @@ arm64-sysreg-defs-clean:
 
 beauty_linux_dir := $(srctree)/tools/perf/trace/beauty/include/linux/
 beauty_uapi_linux_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/linux/
+beauty_uapi_sound_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/sound/
 linux_uapi_dir := $(srctree)/tools/include/uapi/linux
 asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
 arch_asm_uapi_dir := $(srctree)/tools/arch/$(SRCARCH)/include/uapi/asm/
@@ -526,15 +527,15 @@ sndrv_ctl_ioctl_array := $(beauty_ioctl_outdir)/sndrv_ctl_ioctl_array.c
 sndrv_ctl_hdr_dir := $(srctree)/tools/include/uapi/sound
 sndrv_ctl_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
 
-$(sndrv_ctl_ioctl_array): $(sndrv_ctl_hdr_dir)/asound.h $(sndrv_ctl_ioctl_tbl)
-	$(Q)$(SHELL) '$(sndrv_ctl_ioctl_tbl)' $(sndrv_ctl_hdr_dir) > $@
+$(sndrv_ctl_ioctl_array): $(beauty_uapi_sound_dir)/asound.h $(sndrv_ctl_ioctl_tbl)
+	$(Q)$(SHELL) '$(sndrv_ctl_ioctl_tbl)' $(beauty_uapi_sound_dir) > $@
 
 sndrv_pcm_ioctl_array := $(beauty_ioctl_outdir)/sndrv_pcm_ioctl_array.c
 sndrv_pcm_hdr_dir := $(srctree)/tools/include/uapi/sound
 sndrv_pcm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
 
-$(sndrv_pcm_ioctl_array): $(sndrv_pcm_hdr_dir)/asound.h $(sndrv_pcm_ioctl_tbl)
-	$(Q)$(SHELL) '$(sndrv_pcm_ioctl_tbl)' $(sndrv_pcm_hdr_dir) > $@
+$(sndrv_pcm_ioctl_array): $(beauty_uapi_sound_dir)/asound.h $(sndrv_pcm_ioctl_tbl)
+	$(Q)$(SHELL) '$(sndrv_pcm_ioctl_tbl)' $(beauty_uapi_sound_dir) > $@
 
 kcmp_type_array := $(beauty_outdir)/kcmp_type_array.c
 kcmp_hdr_dir := $(srctree)/tools/include/uapi/linux/
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 356ddb76a9541018..93ad7a787a19d550 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -22,7 +22,6 @@ FILES=(
   "include/uapi/linux/seccomp.h"
   "include/uapi/linux/stat.h"
   "include/uapi/linux/vhost.h"
-  "include/uapi/sound/asound.h"
   "include/linux/bits.h"
   "include/vdso/bits.h"
   "include/linux/const.h"
@@ -98,6 +97,7 @@ BEAUTY_FILES=(
   "include/uapi/linux/fs.h"
   "include/uapi/linux/mount.h"
   "include/uapi/linux/usbdevice_fs.h"
+  "include/uapi/sound/asound.h"
 )
 
 declare -a FAILURES
diff --git a/tools/include/uapi/sound/asound.h b/tools/perf/trace/beauty/include/uapi/sound/asound.h
similarity index 100%
rename from tools/include/uapi/sound/asound.h
rename to tools/perf/trace/beauty/include/uapi/sound/asound.h
diff --git a/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh b/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
index e0803b9575932420..572939a1288455a4 100755
--- a/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
+++ b/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
@@ -1,9 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: LGPL-2.1
 
-[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/sound/
+[ $# -eq 1 ] && beauty_uapi_sound_dir=$1 || beauty_uapi_sound_dir=tools/perf/trace/beauty/include/uapi/sound/
 
 printf "static const char *sndrv_ctl_ioctl_cmds[] = {\n"
-grep "^#define[\t ]\+SNDRV_CTL_IOCTL_" $header_dir/asound.h | \
+grep "^#define[\t ]\+SNDRV_CTL_IOCTL_" $beauty_uapi_sound_dir/asound.h | \
 	sed -r 's/^#define +SNDRV_CTL_IOCTL_([A-Z0-9_]+)[\t ]+_IO[RW]*\( *.U., *(0x[[:xdigit:]]+),?.*/\t[\2] = \"\1\",/g'
 printf "};\n"
diff --git a/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh b/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
index 7a464a7bf91399bf..33afae9a1c07ca5e 100755
--- a/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
+++ b/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
@@ -1,9 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: LGPL-2.1
 
-[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/sound/
+[ $# -eq 1 ] && beauty_uapi_sound_dir=$1 || beauty_uapi_sound_dir=tools/perf/trace/beauty/include/uapi/sound/
 
 printf "static const char *sndrv_pcm_ioctl_cmds[] = {\n"
-grep "^#define[\t ]\+SNDRV_PCM_IOCTL_" $header_dir/asound.h | \
+grep "^#define[\t ]\+SNDRV_PCM_IOCTL_" $beauty_uapi_sound_dir/asound.h | \
 	sed -r 's/^#define +SNDRV_PCM_IOCTL_([A-Z0-9_]+)[\t ]+_IO[RW]*\( *.A., *(0x[[:xdigit:]]+),?.*/\t[\2] = \"\1\",/g'
 printf "};\n"
-- 
2.43.2


