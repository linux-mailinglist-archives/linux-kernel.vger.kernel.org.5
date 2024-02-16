Return-Path: <linux-kernel+bounces-69397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD2685886D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96032894E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CF013957E;
	Fri, 16 Feb 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orfjmu27"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09078146007;
	Fri, 16 Feb 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122028; cv=none; b=f+R51lvo7AtBfv9aA12STH0V2XrsakpKoPlHvCmgb95d7JD/2hUC89A+fM08Gbt3F3vPrdHVQp3cEdtuVYTQRSCprEwTRsSRHFrftY3JXR+sJnhyxfqUBdQzEaxt5JSK/9MmaIX3kBzOzbhbtLNZ0VyUDNe+orcmhltbSmPVvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122028; c=relaxed/simple;
	bh=2Xx8Z5pTwI2JW5qD969uln16RftePq1Ha6Tf8/kMnL4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=THNZ13up/mkRyxymdEvF8vH8cXb2x++jnZI5rG0rf9OAz0jLm0/nfw9X5DN2esU2tFVUYsW9GzhUk9HJIDzRfr60EKt9I+5fyND3q7EnoGf1cYtL7CrdSRn2qsBWjHO0KfXE+427joJg6Iit6Y8K1jVRE2IHKrPbnVSDKbr5x6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orfjmu27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1984C433C7;
	Fri, 16 Feb 2024 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708122027;
	bh=2Xx8Z5pTwI2JW5qD969uln16RftePq1Ha6Tf8/kMnL4=;
	h=Date:From:To:Cc:Subject:From;
	b=orfjmu27b7csWhaDNboaStMb/nFRea8q/SSJhSGYaj4d78xi192uOHccp9i9RyYUN
	 zml5QwcrVnM80FLSzzUT4a21P4+mRk1DvteGM7mwKL/k5U9r48ndZYLFg0ZU5RSl4a
	 T/3Wwua1Vwo2XJE8rczRjRl2vRPn1uY+iJd3CHKSDPKetJOILiuDGDSrOdGDvabzJ7
	 6N8V+2AfFNyG6j77GM4OXMVVNJRiWZNf/VorhXQ+9GNMOcRE0E58QMQAwUVxZ0wloU
	 Ptf9R7IpGvHKXgAiOgmQd1MncFjSQspDmQEuKBthtzQs7aIEIHsN39HdOggHP4o+Dd
	 68LN31jyF0Omw==
Date: Fri, 16 Feb 2024 19:20:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 v2] perf augmented_raw_syscalls.bpf: Move 'struct
 timespec64' to vmlinux.h
Message-ID: <Zc_fp6CgDClPhS_O@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If we instead decide to generate vmlinux.h from BTF info, it will be
there:

  $ pahole timespec64
  struct timespec64 {
  	time64_t                   tv_sec;               /*     0     8 */
  	long int                   tv_nsec;              /*     8     8 */

  	/* size: 16, cachelines: 1, members: 2 */
  	/* last cacheline: 16 bytes */
  };

  $

pahole manages to find it from /sys/kernel/btf/vmlinux, that is
generated from the kernel types.

With this linux/bpf.h doesn't need to be included, as its already in the
minimalistic tools/perf/util/bpf_skel/vmlinux/vmlinux.h file or what we
need comes when generating a vmlinux.h file from BTF info, i.e. when
using GEN_VMLINUX_H=1, as noticed by Namyung in a build break before
removing linux/bpf.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/Zc-gAKByhLBV_X59@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---

v2: Remove linux/bpf.h as explained in the commit log message.

---
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c    | 15 +--------------
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h        |  7 +++++++
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index baecffbece14fb68..0acbd74e8c760956 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -6,7 +6,7 @@
  * payload expected by the 'perf trace' beautifiers.
  */
 
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <linux/limits.h>
 
@@ -22,19 +22,6 @@
 
 #define MAX_CPUS  4096
 
-// FIXME: These should come from system headers
-#ifndef bool
-typedef char bool;
-#endif
-typedef int pid_t;
-typedef long long int __s64;
-typedef __s64 time64_t;
-
-struct timespec64 {
-	time64_t	tv_sec;
-	long int	tv_nsec;
-};
-
 /* bpf-output associated map */
 struct __augmented_syscalls__ {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index ab84a6e1da5eedb3..e9028235d7717b59 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -20,6 +20,13 @@ typedef __s64 s64;
 
 typedef int pid_t;
 
+typedef __s64 time64_t;
+
+struct timespec64 {
+        time64_t        tv_sec;
+        long int        tv_nsec;
+};
+
 enum cgroup_subsys_id {
 	perf_event_cgrp_id  = 8,
 };
-- 
2.43.0


