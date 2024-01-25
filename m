Return-Path: <linux-kernel+bounces-38701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A0883C44D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4AA286A53
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299363114;
	Thu, 25 Jan 2024 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSRZD0iL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D062A1A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191575; cv=none; b=h+LOliIuGs6f81MSGCuyVPPfHo9uHFQjhb/V7OrerujT6sQ2/kLe+rWms2m98T7myXqLO9vxGYRfH+D2kbNFA3JoBu+HAwFzqWYHUpF4eRln0mzXmKa9zK5S/tDfjLT5mQIIZ8GXbpJc8B9U17CX7/ATIa/YkgA5C4n/zrBdSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191575; c=relaxed/simple;
	bh=pF9eMAEsaNVu4u9UZfIsGZ92b3kYhUox8LYXXuff8CM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DG2GdM4rVQNI7qjQGm87hkn/0IOfCo5PBMXK2EDj2uO/DoaJSvOzLX+pFHuIVqaoJZdu7MGWRg+3O+77fhVABha63thz+/Peu1+TZLp/P4NdgE7ClTAw4E2NFXlIPGBSVZ38sUnf2zQ37TqrR4554+62cfMT3xRpD+IjLpR8gno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSRZD0iL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1C8C43390;
	Thu, 25 Jan 2024 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706191574;
	bh=pF9eMAEsaNVu4u9UZfIsGZ92b3kYhUox8LYXXuff8CM=;
	h=Date:From:To:Cc:Subject:From;
	b=iSRZD0iLzupqOaXeh8HrSqyQk9pbAjt/gNyuOfbAjFDzaDE7aP1w6jYApGmckzvdY
	 6qkV6tbJcMTwc6ZFRiB+MAOPN1VD6jhqxNihiNj6x+fx0ZmCy6vPGy/UNVpvIrH3H+
	 YBfQl+bx5A14eqRtOwRVeEGvuuRMBbdJsjCJTnmLcQSqBuuMvyPddWmj6sfM2eBnKS
	 kxgJk2DDWX/OpukuesmQn75suZLYGhkiTetwZwEhvI4JOBCK4qzwLg9FxPIQ+tL38I
	 ht38fnEB1UegAL2So2mOrjSu3Btmo1mH65oB2uMW4MNcOgOrNxpxrg3HLpkx821c+y
	 iXsiLnSdVuxSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 7EA91405B2; Thu, 25 Jan 2024 11:06:11 -0300 (-03)
Date: Thu, 25 Jan 2024 11:06:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 FYI] tools headers uapi: Sync linux/stat.h with the
 kernel sources to pick STATX_MNT_ID_UNIQUE
Message-ID: <ZbJq08s19890WDo-@kernel.org>
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

To pick the changes from:

  98d2b43081972abe ("add unique mount ID")

That add STATX_MNT_ID_UNIQUE that was manually added to
tools/perf/trace/beauty/statx.c, at some point this should move to the
shell based automated way.

This silences this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/stat.h include/uapi/linux/stat.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/stat.h | 1 +
 tools/perf/trace/beauty/statx.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index 7cab2c65d3d7fce9..2f2ee82d55175d05 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -154,6 +154,7 @@ struct statx {
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
+#define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
diff --git a/tools/perf/trace/beauty/statx.c b/tools/perf/trace/beauty/statx.c
index 5f5320f7c6e27d17..dc5943a6352d91dc 100644
--- a/tools/perf/trace/beauty/statx.c
+++ b/tools/perf/trace/beauty/statx.c
@@ -67,6 +67,7 @@ size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct syscall_a
 	P_FLAG(BTIME);
 	P_FLAG(MNT_ID);
 	P_FLAG(DIOALIGN);
+	P_FLAG(MNT_ID_UNIQUE);
 
 #undef P_FLAG
 
-- 
2.43.0


