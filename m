Return-Path: <linux-kernel+bounces-104913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4C87D59E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A1F1F254C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150635E08B;
	Fri, 15 Mar 2024 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfrMjTN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575065E06E;
	Fri, 15 Mar 2024 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535730; cv=none; b=Jtihab+6x+rQRPW0Xd3G9p1TllWnkRbKJ/ZhmFzx7OZzQZVE6q0gV752hQOWrP8B13dklH+rmhEaecdTnwFqB2HwupM86w+QBrGR3Pn0J1rELAXBkjMLN8Xj2w6Ncvn89gS7lTTdxFlbfAPzgq0S9fIYdikm3bzj2udJGHlZE3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535730; c=relaxed/simple;
	bh=fTuRY+Wcu5iLvw/FqEChUB9CamTV7xWqgGviHXDV6Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riFNKfGL0wRWIaSIpmmWeSn78wglutBJmBxDXdJgiBx7kzsloGCljfNCRVRonjj5LR4jpS0msLlUb83mA8sxLciF5g+WIwf02I5wHjrW8GK7licCNeyI+Fth084JEudkE1nOxuKuydOfEje1fPHoWtt2TnDS09iFsTaTjRs4+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfrMjTN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24288C433F1;
	Fri, 15 Mar 2024 20:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535729;
	bh=fTuRY+Wcu5iLvw/FqEChUB9CamTV7xWqgGviHXDV6Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nfrMjTN0z92wl2NXyAhPYmscd/SvELlG+9vWiRSdaMd+KxmgV6fIaUyYp1EMPxBUp
	 CuPwdURYOWbxmci+0+7xVc7n1c9kE7OrHg82OQvGUy5KJAmAiRMH3i6qbSrax7P/i3
	 3/ryfPkKRKnCI2GXkN+f5X6dXXswVNFJb+kwSJ7w0DOEXiPWD6712hx9R6xlFDSf8C
	 EiZ3nwsuvnf/Muz/CVFVQzv+6DgmaUXUhpMQEjbn8dqr3OoceSv6d/oujATUtItsnF
	 WZsy+LBoboYclm+TYocJ+Bx4GwQvwCIsrZWN9QAzJfdOfzTc9PMreizIthrMo09ing
	 xpJ6nOLeP4O4w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/5] perf beauty: Use the system linux/fcntl.h instead of a copy from the kernel
Date: Fri, 15 Mar 2024 17:48:33 -0300
Message-ID: <20240315204835.748716-4-acme@kernel.org>
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

Builds ok all the way back to these older distros:

   1  almalinux:8    : Ok  gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-20) , clang version 16.0.6 (Red Hat 16.0.6-2.module_el8.9.0+3621+df7f7146) flex 2.6.1
   3  alpine:3.15    : Ok  gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1 flex 2.6.4
  15  debian:10      : Ok  gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1 flex 2.6.4
  32  opensuse:15.4  : Ok  gcc (SUSE Linux) 7.5.0 , clang version 15.0.7 flex 2.6.4
  23  fedora:35      : Ok  gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-3) , clang version 13.0.1 (Fedora 13.0.1-1.fc35) flex 2.6.4
  38  ubuntu:18.04   : Ok  gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fcntl.c | 2 +-
 tools/perf/trace/beauty/flock.c | 2 +-
 tools/perf/trace/beauty/statx.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index 56ef83b3d130b5c6..d075904dcccedc86 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -7,7 +7,7 @@
 
 #include "trace/beauty/beauty.h"
 #include <linux/kernel.h>
-#include <uapi/linux/fcntl.h>
+#include <linux/fcntl.h>
 
 static size_t fcntl__scnprintf_getfd(unsigned long val, char *bf, size_t size, bool show_prefix)
 {
diff --git a/tools/perf/trace/beauty/flock.c b/tools/perf/trace/beauty/flock.c
index c14274edd6d9de4f..a6514a6f07cfa066 100644
--- a/tools/perf/trace/beauty/flock.c
+++ b/tools/perf/trace/beauty/flock.c
@@ -2,7 +2,7 @@
 
 #include "trace/beauty/beauty.h"
 #include <linux/kernel.h>
-#include <uapi/linux/fcntl.h>
+#include <linux/fcntl.h>
 
 #ifndef LOCK_MAND
 #define LOCK_MAND	 32
diff --git a/tools/perf/trace/beauty/statx.c b/tools/perf/trace/beauty/statx.c
index dc5943a6352d91dc..d1ccc93316bd9ac6 100644
--- a/tools/perf/trace/beauty/statx.c
+++ b/tools/perf/trace/beauty/statx.c
@@ -8,7 +8,7 @@
 #include "trace/beauty/beauty.h"
 #include <linux/kernel.h>
 #include <sys/types.h>
-#include <uapi/linux/fcntl.h>
+#include <linux/fcntl.h>
 #include <uapi/linux/stat.h>
 
 size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_arg *arg)
-- 
2.43.2


