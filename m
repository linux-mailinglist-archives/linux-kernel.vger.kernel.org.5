Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FFC80DF71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbjLKXZD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 18:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLKXZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:25:01 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF3ECB;
        Mon, 11 Dec 2023 15:25:08 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28abb389323so46025a91.2;
        Mon, 11 Dec 2023 15:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702337107; x=1702941907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ho6u7NxirxlqwmCKHqrmmg+mYP2l9JT9kgSjmqZWLw=;
        b=sd1UACZypw4oVt1q66MjSPPSfYyZPHjSP+bn4z4/d+sxZutu/PH9Xl7gzX90AeV4rt
         UGhqO4DJRIAsQ6G/zTF7x6z8Ne72rL0JeemEUvp8h95nkEL/mivvZ3HrnJACpIXpRXtT
         ej/zkC6OIiFyiQELnmP3SjvSDeFrBM1qZBPoO0DUftplrPgO0YROcR4LdBKRhoAlT1LS
         Fr08SKWqmamrsB2P7kG/W9CLPlcarSHxSFFq+3z3xUcGXuPjjx2uSdWRRt4ybqUQEy7O
         +BZCF3Xk56h82izluZ5xT/Rvg6pb++zv19WywvYQ89/RfXzUwxujkGX13ATn+Lf3iHa3
         +8fA==
X-Gm-Message-State: AOJu0Yzj5tVD2MpoMrffUdeO/ypZxVnggxSncYxzYYpK68BetK+lHy4g
        4M1WGYUU6ZFiPXeJvIMk3/wSHMz8Kr1rqH8A/Fw=
X-Google-Smtp-Source: AGHT+IGfbVWVShsxeV+kZarUAHAg135tUUyWMOGsbLnbSDBAOq1jtb3sSQdDSfOGYmMeLBKTfja5tiqgI9f+EaroVo4=
X-Received: by 2002:a17:90a:d994:b0:286:6cc1:5fd0 with SMTP id
 d20-20020a17090ad99400b002866cc15fd0mr2387175pjv.83.1702337107352; Mon, 11
 Dec 2023 15:25:07 -0800 (PST)
MIME-Version: 1.0
References: <20231207050433.1426834-1-irogers@google.com> <20231207050433.1426834-3-irogers@google.com>
In-Reply-To: <20231207050433.1426834-3-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 11 Dec 2023 15:24:56 -0800
Message-ID: <CAM9d7cgRZp3PieHDvsdFXG+pNG0TTKoAaH6ZxC1XAnrvRLE1Pw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] tools lib api: Add io_dir an allocation free
 readdir alternative
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 9:04 PM Ian Rogers <irogers@google.com> wrote:
>
> glibc's opendir allocates a minimum of 32kb, when called recursively
> for a directory tree the memory consumption can add up - nearly 300kb
> during perf start-up when processing modules. Add a stack allocated
> variant of readdir sized a little more than 1kb.
>
> As getdents64 may be missing from libc, add support using syscall.

Unfortunately my alpine build has:

In file included from util/machine.c:2:
/build/libapi/include/api/io_dir.h:17:23: error: conflicting types for
'getdents'; have 'ssize_t(int,  void *, size_t)' {aka 'long int(int,
void *, long unsigned int)'}
   17 | static inline ssize_t getdents64(int fd, void *dirp, size_t count)
      |                       ^~~~~~~~~~
/usr/include/dirent.h:52:5: note: previous declaration of 'getdents'
with type 'int(int,  struct dirent *, size_t)' {aka 'int(int,  struct
dirent *, long unsigned int)'}
   52 | int getdents(int, struct dirent *, size_t);
      |     ^~~~~~~~

Thanks,
Namhyung

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/Makefile     |  2 +-
>  tools/lib/api/io_dir.h     | 84 ++++++++++++++++++++++++++++++++++++++
>  tools/perf/Makefile.config |  4 ++
>  3 files changed, 89 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/api/io_dir.h
>
> diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> index 044860ac1ed1..186aa407de8c 100644
> --- a/tools/lib/api/Makefile
> +++ b/tools/lib/api/Makefile
> @@ -99,7 +99,7 @@ install_lib: $(LIBFILE)
>                 $(call do_install_mkdir,$(libdir_SQ)); \
>                 cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
>
> -HDRS := cpu.h debug.h io.h
> +HDRS := cpu.h debug.h io.h io_dir.h
>  FD_HDRS := fd/array.h
>  FS_HDRS := fs/fs.h fs/tracing_path.h
>  INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/api
> diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
> new file mode 100644
> index 000000000000..9b702497e05c
> --- /dev/null
> +++ b/tools/lib/api/io_dir.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +/*
> + * Lightweight directory reading library.
> + */
> +#ifndef __API_IO_DIR__
> +#define __API_IO_DIR__
> +
> +#include <dirent.h>
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +
> +#ifndef HAVE_GETDENTS64
> +#include <sys/syscall.h>
> +
> +static inline ssize_t getdents64(int fd, void *dirp, size_t count)
> +{
> +       return syscall(SYS_getdents64, fd, dirp, count);
> +}
> +#endif
> +
> +struct io_dirent64 {
> +       ino64_t        d_ino;    /* 64-bit inode number */
> +       off64_t        d_off;    /* 64-bit offset to next structure */
> +       unsigned short d_reclen; /* Size of this dirent */
> +       unsigned char  d_type;   /* File type */
> +       char           d_name[NAME_MAX + 1]; /* Filename (null-terminated) */
> +};
> +
> +struct io_dir {
> +       int dirfd;
> +       ssize_t available_bytes;
> +       struct io_dirent64 *next;
> +       struct io_dirent64 buff[4];
> +};
> +
> +static inline void io_dir__init(struct io_dir *iod, int dirfd)
> +{
> +       iod->dirfd = dirfd;
> +       iod->available_bytes = 0;
> +}
> +
> +static inline void io_dir__rewinddir(struct io_dir *iod)
> +{
> +       lseek(iod->dirfd, 0, SEEK_SET);
> +       iod->available_bytes = 0;
> +}
> +
> +static inline struct io_dirent64 *io_dir__readdir(struct io_dir *iod)
> +{
> +       struct io_dirent64 *entry;
> +
> +       if (iod->available_bytes <= 0) {
> +               ssize_t rc = getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
> +
> +               if (rc <= 0)
> +                       return NULL;
> +               iod->available_bytes = rc;
> +               iod->next = iod->buff;
> +       }
> +       entry = iod->next;
> +       iod->next = (struct io_dirent64 *)((char *)entry + entry->d_reclen);
> +       iod->available_bytes -= entry->d_reclen;
> +       return entry;
> +}
> +
> +static inline bool io_dir__is_dir(const struct io_dir *iod, struct io_dirent64 *dent)
> +{
> +       if (dent->d_type == DT_UNKNOWN) {
> +               struct stat st;
> +
> +               if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=*/0))
> +                       return false;
> +
> +               if (S_ISDIR(st.st_mode)) {
> +                       dent->d_type = DT_DIR;
> +                       return true;
> +               }
> +       }
> +       return dent->d_type == DT_DIR;
> +}
> +
> +#endif
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index aa55850fbc21..1cef1ab4ddb7 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -357,6 +357,10 @@ ifeq ($(feature-stackprotector-all), 1)
>    CORE_CFLAGS += -fstack-protector-all
>  endif
>
> +ifeq ($(feature-getdents64), 1)
> +  CFLAGS += -DHAVE_GETDENTS64
> +endif
> +
>  ifeq ($(DEBUG),0)
>    ifeq ($(feature-fortify-source), 1)
>      CORE_CFLAGS += -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
