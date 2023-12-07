Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B5C807FEE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjLGFEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjLGFEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:04:47 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DEDD44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:04:53 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3a1e5f8d6so3973157b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701925493; x=1702530293; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLfF4gdeUWNr8FF8ACObQvFWnydI6Js6QIkQSQodKEI=;
        b=16JKr/OAlmIySJ2uZLXZC4p70yZiecAN8EhnkomFKLRuI8/eJ+HXfBmc9iI1Cq67rv
         1T+ncKFZBzub0uuI67C/Rrf8+HL+kC1+1EqjdnqUxmJ3pi9L9/Rk2RPxBbsbizJ52Fkg
         11JhkT1Z12L1LsPQQielsZdIbFLpz+B5rV8wxCJ7BEomwakbQlHHrx+ZFVgY/akc2lNG
         dafpmPc5KgqTa9V9dx9FVoqVmKL+WvcmeyWJhwIfhmjUc07tO+YB+PbDQrLwND2A+HNR
         oYA0PxhpM3VYtNN19I+CY83SNFgJ6ep0KgUE3vrs2pFRS3r2YQyxym5EvW8sJNcj1I6J
         WxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701925493; x=1702530293;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLfF4gdeUWNr8FF8ACObQvFWnydI6Js6QIkQSQodKEI=;
        b=iEhRYRed2mT5NVF2wk98XY4NYHbb1aEdx088aizpD8EvgIMRDJgkAJlhF2xfLB/Uvf
         hXYUaqT2xGEJBLKzb41prVzORAFu9fNMTNnWEl7rTOLKiJjQHaUpzXKbeQYcW36U4cVE
         0KFiRQidsVRJqiGgG2nDpjr4joX+gNr3im7Jet09Rk3o//xNAKbDHz8zYeMTSuk3V2h8
         OqQ/LJPwTteFXKpUIYeWrjVeo/d0nTrJTkcvckycbFMRbexySW+JGndSwF1EqmegLWbw
         DNIVFHDnFjR6NAAEomClZ3FzZ5SLAjgDBb/UXNJFozjREwSgb6Jj/zvBuJp4gIAPCy8n
         HMDQ==
X-Gm-Message-State: AOJu0YwNce6hrN376jGGUQUkvO/EjI7Jq+IWqbDn+BbtSKX+D1yyYcvj
        Yh/dlHSM7oB0x6diEVLjH5igrTGRPypa
X-Google-Smtp-Source: AGHT+IFJ8VLzkhmv5lIHBwHao+8hbxbTzxh0PLIX/Y/8B0uG5Cn/P5rXMoDTUFtOLFwHal2ivb+PmHh5k+sj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:ad14:0:b0:5d5:6a4c:b0b3 with SMTP id
 l20-20020a81ad14000000b005d56a4cb0b3mr26965ywh.8.1701925492804; Wed, 06 Dec
 2023 21:04:52 -0800 (PST)
Date:   Wed,  6 Dec 2023 21:04:29 -0800
In-Reply-To: <20231207050433.1426834-1-irogers@google.com>
Message-Id: <20231207050433.1426834-3-irogers@google.com>
Mime-Version: 1.0
References: <20231207050433.1426834-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 2/6] tools lib api: Add io_dir an allocation free readdir alternative
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Fangrui Song <maskray@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

glibc's opendir allocates a minimum of 32kb, when called recursively
for a directory tree the memory consumption can add up - nearly 300kb
during perf start-up when processing modules. Add a stack allocated
variant of readdir sized a little more than 1kb.

As getdents64 may be missing from libc, add support using syscall.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile     |  2 +-
 tools/lib/api/io_dir.h     | 84 ++++++++++++++++++++++++++++++++++++++
 tools/perf/Makefile.config |  4 ++
 3 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/api/io_dir.h

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 044860ac1ed1..186aa407de8c 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -99,7 +99,7 @@ install_lib: $(LIBFILE)
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
-HDRS := cpu.h debug.h io.h
+HDRS := cpu.h debug.h io.h io_dir.h
 FD_HDRS := fd/array.h
 FS_HDRS := fs/fs.h fs/tracing_path.h
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/api
diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
new file mode 100644
index 000000000000..9b702497e05c
--- /dev/null
+++ b/tools/lib/api/io_dir.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/*
+ * Lightweight directory reading library.
+ */
+#ifndef __API_IO_DIR__
+#define __API_IO_DIR__
+
+#include <dirent.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/stat.h>
+
+#ifndef HAVE_GETDENTS64
+#include <sys/syscall.h>
+
+static inline ssize_t getdents64(int fd, void *dirp, size_t count)
+{
+	return syscall(SYS_getdents64, fd, dirp, count);
+}
+#endif
+
+struct io_dirent64 {
+	ino64_t        d_ino;    /* 64-bit inode number */
+	off64_t        d_off;    /* 64-bit offset to next structure */
+	unsigned short d_reclen; /* Size of this dirent */
+	unsigned char  d_type;   /* File type */
+	char           d_name[NAME_MAX + 1]; /* Filename (null-terminated) */
+};
+
+struct io_dir {
+	int dirfd;
+	ssize_t available_bytes;
+	struct io_dirent64 *next;
+	struct io_dirent64 buff[4];
+};
+
+static inline void io_dir__init(struct io_dir *iod, int dirfd)
+{
+	iod->dirfd = dirfd;
+	iod->available_bytes = 0;
+}
+
+static inline void io_dir__rewinddir(struct io_dir *iod)
+{
+	lseek(iod->dirfd, 0, SEEK_SET);
+	iod->available_bytes = 0;
+}
+
+static inline struct io_dirent64 *io_dir__readdir(struct io_dir *iod)
+{
+	struct io_dirent64 *entry;
+
+	if (iod->available_bytes <= 0) {
+		ssize_t rc = getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
+
+		if (rc <= 0)
+			return NULL;
+		iod->available_bytes = rc;
+		iod->next = iod->buff;
+	}
+	entry = iod->next;
+	iod->next = (struct io_dirent64 *)((char *)entry + entry->d_reclen);
+	iod->available_bytes -= entry->d_reclen;
+	return entry;
+}
+
+static inline bool io_dir__is_dir(const struct io_dir *iod, struct io_dirent64 *dent)
+{
+	if (dent->d_type == DT_UNKNOWN) {
+		struct stat st;
+
+		if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=*/0))
+			return false;
+
+		if (S_ISDIR(st.st_mode)) {
+			dent->d_type = DT_DIR;
+			return true;
+		}
+	}
+	return dent->d_type == DT_DIR;
+}
+
+#endif
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index aa55850fbc21..1cef1ab4ddb7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -357,6 +357,10 @@ ifeq ($(feature-stackprotector-all), 1)
   CORE_CFLAGS += -fstack-protector-all
 endif
 
+ifeq ($(feature-getdents64), 1)
+  CFLAGS += -DHAVE_GETDENTS64
+endif
+
 ifeq ($(DEBUG),0)
   ifeq ($(feature-fortify-source), 1)
     CORE_CFLAGS += -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
-- 
2.43.0.rc2.451.g8631bc7472-goog

