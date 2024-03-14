Return-Path: <linux-kernel+bounces-103426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C8587BF35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A661D1F21971
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E07171759;
	Thu, 14 Mar 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIOenNHV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9071746;
	Thu, 14 Mar 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427414; cv=none; b=o5h1970uGtVyLCp9TKxKKiUyv81ly7Y3T9cb6zHNw05hsZudnTt6v9rTzUVbk+BbHebT1zQfd6YnZqRwqnGujuWcKQYE0O+mxYc/v8/LTcm8MSBeQlVqnMlIMAMUQKxWtNzfjlk3k35Ed/RaXNY5ULcKzOwAbiELy4P2ZM3Nh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427414; c=relaxed/simple;
	bh=FeH9KIAieASP7N2t5QySoaSYptggQ1Z30dxYLQNICXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k98wGHBo0+0Yk6qJte4D6QHlSmOHb/yMeO4XDohTID9XEbVdkAqYksSdCv2bgS6v++3qxHVmAr6uxJhOXc/k8rK3knQthiHg5/wST2zKQOggGHkZwMxYGlhWVlvm0WOa3UoEOJs7QdfB74vQT89/pdpCdKxE0+KAeU4cx/+PWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIOenNHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EA7C433F1;
	Thu, 14 Mar 2024 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427414;
	bh=FeH9KIAieASP7N2t5QySoaSYptggQ1Z30dxYLQNICXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIOenNHVZpNt3pfknt2SSY2kcFbS/Kr/6DCda5U8iT/UfA5s7nl8GqQHmxaIB8ReR
	 6pdimDvMf4YFbg0OCQuViRiGrIK9aTuJuYuwOrGwk4W87+WPWoJAbQjOB9HWUHhrb+
	 1voaqPoE9I44L+MiXZRmUg0TYmdNTQiO33eR8tp5yLoxb6JnOs3bOSk/ZiV0DSrkMy
	 wFeJTRX1H3mUiwHKsRXNcyyk75Mzayaw3XDs97Lgpn6nh39MBbUKGavShnoKVa/rWh
	 KUOKFZ1PgZWMhRoGHVkfbmj6ZrD4BtltLW9FIM4UsRh4wvAE9opB1+YiTBrfLz4vOR
	 3ApvnVqClY8yQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/3] perf beauty: Move arch/x86/include/asm/irq_vectors.h copy out of the directory used to build perf
Date: Thu, 14 Mar 2024 11:43:20 -0300
Message-ID: <20240314144320.743217-4-acme@kernel.org>
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

No other tools/ living code uses it.

Suggested-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/CAP-5=fWZVrpRufO4w-S4EcSi9STXcTAN2ERLwTSN7yrSSA-otQ@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                                    | 6 ++++--
 tools/perf/check-headers.sh                                 | 2 +-
 .../trace/beauty}/arch/x86/include/asm/irq_vectors.h        | 0
 tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh      | 6 +++---
 4 files changed, 8 insertions(+), 6 deletions(-)
 rename tools/{ => perf/trace/beauty}/arch/x86/include/asm/irq_vectors.h (100%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 757777d968602ded..c75342b21089fc6f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -474,6 +474,8 @@ arm64-sysreg-defs-clean:
 beauty_linux_dir := $(srctree)/tools/perf/trace/beauty/include/linux/
 beauty_uapi_linux_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/linux/
 beauty_uapi_sound_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/sound/
+beauty_arch_asm_dir := $(srctree)/tools/perf/trace/beauty/arch/x86/include/asm/
+
 linux_uapi_dir := $(srctree)/tools/include/uapi/linux
 asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
 arch_asm_uapi_dir := $(srctree)/tools/arch/$(SRCARCH)/include/uapi/asm/
@@ -636,8 +638,8 @@ $(x86_arch_prctl_code_array): $(x86_arch_asm_uapi_dir)/prctl.h $(x86_arch_prctl_
 x86_arch_irq_vectors_array := $(beauty_outdir)/x86_arch_irq_vectors_array.c
 x86_arch_irq_vectors_tbl := $(srctree)/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
 
-$(x86_arch_irq_vectors_array): $(x86_arch_asm_dir)/irq_vectors.h $(x86_arch_irq_vectors_tbl)
-	$(Q)$(SHELL) '$(x86_arch_irq_vectors_tbl)' $(x86_arch_asm_dir) > $@
+$(x86_arch_irq_vectors_array): $(beauty_arch_asm_dir)/irq_vectors.h $(x86_arch_irq_vectors_tbl)
+	$(Q)$(SHELL) '$(x86_arch_irq_vectors_tbl)' $(beauty_arch_asm_dir) > $@
 
 x86_arch_MSRs_array := $(beauty_outdir)/x86_arch_MSRs_array.c
 x86_arch_MSRs_tbl := $(srctree)/tools/perf/trace/beauty/tracepoints/x86_msr.sh
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 93ad7a787a19d550..b35eba5e99c8d91f 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -34,7 +34,6 @@ FILES=(
   "arch/x86/include/asm/cpufeatures.h"
   "arch/x86/include/asm/inat_types.h"
   "arch/x86/include/asm/emulate_prefix.h"
-  "arch/x86/include/asm/irq_vectors.h"
   "arch/x86/include/asm/msr-index.h"
   "arch/x86/include/uapi/asm/prctl.h"
   "arch/x86/lib/x86-opcode-map.txt"
@@ -93,6 +92,7 @@ SYNC_CHECK_FILES=(
 
 declare -a BEAUTY_FILES
 BEAUTY_FILES=(
+  "arch/x86/include/asm/irq_vectors.h"
   "include/linux/socket.h"
   "include/uapi/linux/fs.h"
   "include/uapi/linux/mount.h"
diff --git a/tools/arch/x86/include/asm/irq_vectors.h b/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
similarity index 100%
rename from tools/arch/x86/include/asm/irq_vectors.h
rename to tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
diff --git a/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
index 87dc68c7de0c297e..d8e927dd2bb75c41 100755
--- a/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
+++ b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
@@ -3,12 +3,12 @@
 # (C) 2019, Arnaldo Carvalho de Melo <acme@redhat.com>
 
 if [ $# -ne 1 ] ; then
-	arch_x86_header_dir=tools/arch/x86/include/asm/
+	beauty_arch_asm_dir=tools/perf/trace/beauty/arch/x86/include/asm/
 else
-	arch_x86_header_dir=$1
+	beauty_arch_asm_dir=$1
 fi
 
-x86_irq_vectors=${arch_x86_header_dir}/irq_vectors.h
+x86_irq_vectors=${beauty_arch_asm_dir}/irq_vectors.h
 
 # FIRST_EXTERNAL_VECTOR is not that useful, find what is its number
 # and then replace whatever is using it and that is useful, which at
-- 
2.43.2


