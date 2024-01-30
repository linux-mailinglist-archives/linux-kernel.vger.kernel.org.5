Return-Path: <linux-kernel+bounces-44751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4489D8426F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D856E1F25511
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF546E2AE;
	Tue, 30 Jan 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3B9X272"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6254F94
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625069; cv=none; b=CQN4QrnSTRoAXVypB5gauu4ljiza7UIIz+apAwARxJe0eDNjS2Ia22vRLPwyINJZ17DLRIqpudyvfpDcewj1mEC+oCLWyIzrMsQYcy+n47Ebkb6lVFy2HS5Kl/RY9ZQZ2WZ5bRMjMcWUdiMl4BzuPZNIIxcUCFDLKP/ENcSEFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625069; c=relaxed/simple;
	bh=goKGDmqmVPKlqXB4S62+LaT1lrjL5vNzL0WYpX6Rlyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mrJajfcfp7t86+Xa3LI7lDVpCsZJPUP0dat2Qr1uhOWcmNH5YIZ7zxSQ/kZzDHqWCkp4ZEDeEzEco0igqBB6qBgEYApU7JZnel5T4CqdPXzXftcyZ4DvXh6766z0Ja0REAeiYwprMkciF2WP7mrLkNiBGEg4vq92Jpxna0Ee8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3B9X272; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0976AC433F1;
	Tue, 30 Jan 2024 14:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706625069;
	bh=goKGDmqmVPKlqXB4S62+LaT1lrjL5vNzL0WYpX6Rlyk=;
	h=Date:From:To:Cc:Subject:From;
	b=P3B9X272OjEYEFanPsmcXo/WM2zzjsXjopvMZTritP85EbbGdewMiVgt3VVFwvDsg
	 HUkIOZhv9GFQ4RlQC04J7pbMKJofJZMdf7NVj/DC8ZpqLUOkV1fX6+xd6PSNLaDfn9
	 OBOZjSBhF9JbzODRKrPYGldeww4kY2CLNHhlYBx/lZVIsMDinsU5UsV77r6AbdEATd
	 4s1jFNTv8ws5DxoILclXfHFklb3Q0hfM0ZujR8+XNMravx91rSv+NqyMLGSNXWLdqk
	 F/0mjEjiGHWxtEduCkO1Oi7SAZ+x10zOnWVEA0TBygtfi4lYW/hilwKmWVlIpb263c
	 YvAOa6khUatxw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 4A62440441; Tue, 30 Jan 2024 11:31:06 -0300 (-03)
Date: Tue, 30 Jan 2024 11:31:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 1/1 fyi] tools headers: Update the copy of x86's
 mem{cpy,set}_64.S used in 'perf bench'
Message-ID: <ZbkIKpKdNqOFdMwJ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

This is to get the changes from:

  94ea9c05219518ef ("x86/headers: Replace #include <asm/export.h> with #include <linux/export.h>")
  10f4c9b9a33b7df0 ("x86/asm: Fix build of UML with KASAN")

That addresses these perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
    diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/lib/memcpy_64.S          | 4 ++--
 tools/arch/x86/lib/memset_64.S          | 4 ++--
 tools/perf/util/include/linux/linkage.h | 4 ++++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index d055b82d22ccd083..59cf6f9065aa84d8 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright 2002 Andi Kleen */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
-#include <asm/export.h>
 
 .section .noinstr.text, "ax"
 
@@ -39,7 +39,7 @@ SYM_TYPED_FUNC_START(__memcpy)
 SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
-SYM_FUNC_ALIAS(memcpy, __memcpy)
+SYM_FUNC_ALIAS_MEMFUNC(memcpy, __memcpy)
 EXPORT_SYMBOL(memcpy)
 
 SYM_FUNC_START_LOCAL(memcpy_orig)
diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
index 7c59a704c4584bf7..0199d56cb479d88c 100644
--- a/tools/arch/x86/lib/memset_64.S
+++ b/tools/arch/x86/lib/memset_64.S
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright 2002 Andi Kleen, SuSE Labs */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
-#include <asm/export.h>
 
 .section .noinstr.text, "ax"
 
@@ -40,7 +40,7 @@ SYM_FUNC_START(__memset)
 SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)
 
-SYM_FUNC_ALIAS(memset, __memset)
+SYM_FUNC_ALIAS_MEMFUNC(memset, __memset)
 EXPORT_SYMBOL(memset)
 
 SYM_FUNC_START_LOCAL(memset_orig)
diff --git a/tools/perf/util/include/linux/linkage.h b/tools/perf/util/include/linux/linkage.h
index 75e2248416f55f67..178b00205fe6a7b2 100644
--- a/tools/perf/util/include/linux/linkage.h
+++ b/tools/perf/util/include/linux/linkage.h
@@ -115,6 +115,10 @@
 	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_WEAK)
 #endif
 
+#ifndef SYM_FUNC_ALIAS_MEMFUNC
+#define SYM_FUNC_ALIAS_MEMFUNC SYM_FUNC_ALIAS
+#endif
+
 // In the kernel sources (include/linux/cfi_types.h), this has a different
 // definition when CONFIG_CFI_CLANG is used, for tools/ just use the !clang
 // definition:
-- 
2.43.0


