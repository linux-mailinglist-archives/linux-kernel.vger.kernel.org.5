Return-Path: <linux-kernel+bounces-43051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28AB840ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073BB1C228F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5289155312;
	Mon, 29 Jan 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K82rzX/p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082211552FE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544316; cv=none; b=GCgaUiUtHNVb9HwHw9+dfyom3OPSVAmelIhtgcaTq7j6yyGvde6NW+HFS+EVJG9QPSQQ6DQjfRm/VQrzCw/4JUO7ubzkknnDEtLjZGcnXZNp1YmnMQsoiw+lqGm9ZCRBzffZ9HpIg8WKtrvWUywb6mZ59zKc1EheGSxTmM6pRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544316; c=relaxed/simple;
	bh=u3fDGUEBpCS6+m427D+VgxX1MSplev1LxWdiYDMvUFw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K8/G+Oni+119EDys4kn25n4eIe7wFmZgiQarBEYaXSSfW3qwc2tmKh887XW0RWPnLxMxH1yOf0oDkojIva9Lg31wY8C2AFRfE6ym83WOZtD2sLGDoZQtL0lOWmVVtHaTkzLf5PeC1NL0sqaFvNUWRnqFWFc6dyVrRZp4xFY466Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K82rzX/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7043C433F1;
	Mon, 29 Jan 2024 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706544315;
	bh=u3fDGUEBpCS6+m427D+VgxX1MSplev1LxWdiYDMvUFw=;
	h=Date:From:To:Cc:Subject:From;
	b=K82rzX/pMmmPA29vpdB7mRKjdRYKhbue0D9hYq8NW8+rbjTBIVggb86JQdMe0PQ52
	 D5UJGF+szSFbYpzHur16zLYT4p1Kyqm/mCbL0QcYTTUGhMWexX+F/UClmKJrjHuzwX
	 PzzHyDbSsbi8l8Z92JMnUvOYHJ/Kg1zMk0qwvoVEdNC/g/wgz3xYJSn3Q3sm+ZH3tT
	 pPzlFGyEZJAIw6+MxoZLmP3cH26rBdq3UEQjmFCi2M2WNKCAqFzpDzRpOt6apPsTqC
	 Y0Ch+eE4gYMtUyKLIeZ3zMAaeM9ksCBV6KY04d6I0JUkJjs62ZbHog73jdgGBEO1ve
	 /GNnb9459ekIA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id D548F40441; Mon, 29 Jan 2024 13:05:12 -0300 (-03)
Date: Mon, 29 Jan 2024 13:05:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Casey Schaufler <casey@schaufler-ca.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync unistd.h to pick
 {list,stat}mount, lsm_{[gs]et_self_attr,list_modules} syscall numbers
Message-ID: <ZbfMuAlUMRO9Hqa6@kernel.org>
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

To pick the changes in these csets:

  d8b0f5465012538c ("wire up syscalls for statmount/listmount")
  5f42375904b08890 ("LSM: wireup Linux Security Module syscalls")

Used in some architectures to create syscall tables.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 756b013fb8324bd7..75f00965ab1586cd 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -829,8 +829,21 @@ __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_requeue 456
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 
+#define __NR_statmount   457
+__SYSCALL(__NR_statmount, sys_statmount)
+
+#define __NR_listmount   458
+__SYSCALL(__NR_listmount, sys_listmount)
+
+#define __NR_lsm_get_self_attr 459
+__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
+#define __NR_lsm_set_self_attr 460
+__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
+#define __NR_lsm_list_modules 461
+__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
+
 #undef __NR_syscalls
-#define __NR_syscalls 457
+#define __NR_syscalls 462
 
 /*
  * 32 bit systems traditionally used different
-- 
2.43.0


