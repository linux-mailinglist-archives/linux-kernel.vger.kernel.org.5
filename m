Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C307DF95C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344936AbjKBR6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345976AbjKBR6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:58:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512A21B2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a839b31a0dso25720637b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947894; x=1699552694; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4r7y9MOXsh407EhsJdGITBkFTfyZ936gV5mdQjMIxA=;
        b=ZRgHTA/eu4ys7AM6MXpx9LsFZhdGa51b5IKLnDgQGyPBKiDM/SKKkOqnPoKK1RXiFs
         P4p87txLhBh5mE0E+YdMFmH11eLdiOJ+WWivExdWnZiXYKmTNALEjoqAPi2wZttN3loA
         fxlHC381VBuiqBgqUQo+2+3wR4uIdtwC0BghkfrtsLpvMZlBQKIGVZac1SWVQTrZp9Lu
         DEaRy9NPo2heuO+vj6L7QvMz3G5HEolvKngn+JCTLMYJIbA5u9IkrQpGvKATXWibvpie
         +GHtX6QNR0vbrROdGCCZhwoJKpiAiruY/NAjjBc8zQgCs9O5jh4luE1EHpxSi1pEpR8m
         OOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947894; x=1699552694;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4r7y9MOXsh407EhsJdGITBkFTfyZ936gV5mdQjMIxA=;
        b=lExEfQ/DQRMdDDLDoJQmOSR5GsrO71Ns+eouVXdCQtotPq2aU5EVZGD021gMkbswiB
         YcyU9/BQeroKbzFkXIkvA1BSWfseewg4Izx4qFQT5ADXNi986PenGzWpHObjb2ilF2c1
         rSJ2TnqQG1l1i3e1nytTLJhlYDAOIUfZZhFnO6fQdsyvc7zRPBU5uvuv5MXzaynqq2kM
         TKPJ3JyoMlUZ92LbjroDpH5h4NodiKinOrCyKzAwc07y+cpDw5SG+LjutMKMdYxt04vW
         3RNIEOTF5Ai2GCpRNmiPXrhe6BIkhV5xNekxfM/B2003yubWuzkNeQv9C9pfkoVOX+zC
         uyEA==
X-Gm-Message-State: AOJu0YwWPkeL9mNjg1z2ZsQnGAe294ozd1eArFKG6eK/ash5cnaXbxPj
        9+cveHcMHKkfoKgFx2TcxO2f9hbiwNKT
X-Google-Smtp-Source: AGHT+IF5d1Rum3nPhLiKGdhRVJpI+mRe0a7ZxpjhwzzC35o8oKZtLX6NzZAGqqjNRbJGV0kka9rVURqPOEss
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:ce94:0:b0:da0:3bea:cdc7 with SMTP id
 x142-20020a25ce94000000b00da03beacdc7mr345780ybe.2.1698947894354; Thu, 02 Nov
 2023 10:58:14 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:56:50 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-9-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 08/53] tools lib api: Add io_dir an allocation free readdir alternative
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
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

glibc's opendir allocates a minimum of 32kb, when called recursively
for a directory tree the memory consumption can add up - nearly 300kb
during perf start-up when processing modules. Add a stack allocated
variant of readdir sized a little more than 1kb.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile |  2 +-
 tools/lib/api/io_dir.h | 75 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)
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
index 000000000000..f3479006edb6
--- /dev/null
+++ b/tools/lib/api/io_dir.h
@@ -0,0 +1,75 @@
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
-- 
2.42.0.869.gea05f2083d-goog

