Return-Path: <linux-kernel+bounces-50486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DA08479C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B32D1C22C05
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5815E5DF;
	Fri,  2 Feb 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWwGOR/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BFF15E5D6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902539; cv=none; b=P2V61PFsUPF5XQ9UGeqZOgJRmAFYia0M9FWyNggFo9TJGYXC2jYgrn4wzYgQCdyvPSLqk3XbmsYzMZ1EDUXnMdae0m7H16jdAVLsbjFcZdpZ+nKs9/w8f6NsUvNQG8JjU7vvIWPLOd4yEWZRCQInZyZOp6g6FvI8aNvgnI1ee8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902539; c=relaxed/simple;
	bh=U0zfGUMFO4K2m1luVI9jAWwNldzXk9o9jhSpjNh1xo4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kprRwjv/U0UZLL85ts+CrdOqhIJlE2fZiK1XxMRIGL3ma813rmWevfajUG0RjaKD4M3M+5OLSafihnA5Ojz8ZTif64vOtX6FM7bs8U4lwCebicXjnEP9hdKSb4X8ehJ1Xk65R+mvhu1iKQcIhdDeBId2B0GNXAKaf1FdICFagZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWwGOR/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3856CC433F1;
	Fri,  2 Feb 2024 19:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706902538;
	bh=U0zfGUMFO4K2m1luVI9jAWwNldzXk9o9jhSpjNh1xo4=;
	h=Date:From:To:Cc:Subject:From;
	b=kWwGOR/FeQWTnU2aXMjWm+NS9P7nlvduLR/k8z5W2nmBun11QfN3xFQGcAaNE92P+
	 E2tgoX8/ls7KaD6vlb7kxKXBFyAX7/9HT5r6UqaZvZGJTJimXwx3fjSB6hZ0fO1HET
	 fiq4O+oEss5Upl9O7SuEoygN1YWmZU5yuyPFKuP+FHJfwDhkXvZ6bIVbFF8Ix2PklC
	 LdA+pzeBgPCRzvqRd1Jy9ip5mxKaX5hlLyh8dmG8q+VKaRLucYrLN6xK1OvFsPQ/T5
	 CxeQ7FfksXR2NBozbztkVenz73DIFSMJAfHkDSgvS6ld+RyKeB8mpVlFzAxCL51Qh3
	 WT9D8W8aeWlnQ==
Date: Fri, 2 Feb 2024 16:35:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf augmented_raw_syscalls.bpf: Move 'struct
 timespec64' to vmlinux.h
Message-ID: <Zb1EBzpBn4s-mIa8@x1>
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

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c     | 14 +-------------
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h         |  7 +++++++
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index baecffbece14fb68..d3b672593c540259 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -6,6 +6,7 @@
  * payload expected by the 'perf trace' beautifiers.
  */
 
+#include "vmlinux.h"
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <linux/limits.h>
@@ -22,19 +23,6 @@
 
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


