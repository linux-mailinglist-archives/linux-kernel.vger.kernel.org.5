Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497607FF8E4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjK3R4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjK3R4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:56:51 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B91110F1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:56:56 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bc4eeeadaso50e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701367014; x=1701971814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSbGF5t6T+9UlC48SI7S6PeC5mxJiIPR6wB9iBHA1fQ=;
        b=wmlleAvw2aLYGVOMkvpQBOqUhtgYLqtTvJPGpDqpglBHXuAEkA7iCd7RwtczQyEXc6
         5+fSR+uJft1CMDWqBlUNV+LZmvHUqJ9uMEJxi+P3Hls42BtVItRqowbNQsNqsaGMzX8P
         EBj+kKQdSW7wX96+N7FSlG0Efx+ESf2sc799YSeQlf0nuVqMLYcMD+c+C91g6nc6ADk0
         Wm3V6JxawawidbnMkJpFMtVCaaK3PmdWSIUF1kymKkvKW0qNE4gJ58VcpFlaUftXbu88
         vQaWAowcTDvkerNAbKqmHdQLuFNCd7ugAEs+P3+igeYJKmhqhfG3wBTydy184mkihwQf
         pm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701367014; x=1701971814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSbGF5t6T+9UlC48SI7S6PeC5mxJiIPR6wB9iBHA1fQ=;
        b=utxtySX6eLCKFrZvwPFHuGe4HtMXzmLYcbKmJheOht8SuN9DGG/bCtBabkqGH6kbfd
         W5KvgtpluIb3Ub9kjdQFM3oaXLWLmlzOOxKuZQsDnWaFkN5CeD3WS4chcTtQCNlEfUWS
         NwBICyzAqt4Ui+0BwPrmmdgBm4KED4ziaw1YNsfDAPPe2/J0rg/GTMVM/Rm94coAGnbr
         +EtoiD6OcWnnfIt450vukg/ruZ1DtLrzpSFYh9o98X5A9DYNKaD9YTURqdKVdarIZ1+/
         ZAJEaDWJTZ7dlNN0eTAdkCKa2E5vqnE1rbuY0ACygpE6nXJM/J/lJgHCBSM0GG3N3OPj
         GVwQ==
X-Gm-Message-State: AOJu0YzYahSaFcWYER9YjI8lxjH4iQqUHmLTAue72c/PZ1u3VPPpqBuD
        63bJFjqsROEoy+yy79GTmAlzQ1tsPkzfkMbGHGervw==
X-Google-Smtp-Source: AGHT+IFmf00GZEF0WkytTlhiJpWOU0N28CHWo0KQFKLeG/+tsP7UTFr+oZ+N6ohgKjjF0maheTscfXTHgvwITI9CXQ0=
X-Received: by 2002:a19:5f57:0:b0:505:7c88:9e45 with SMTP id
 a23-20020a195f57000000b005057c889e45mr127635lfj.0.1701367013906; Thu, 30 Nov
 2023 09:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-7-irogers@google.com>
 <ZWjEqw1cAw/eIpQH@kernel.org>
In-Reply-To: <ZWjEqw1cAw/eIpQH@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Nov 2023 09:56:42 -0800
Message-ID: <CAP-5=fUj7ZCchuwBW7xLe0UK8eupQUH3n9t0vcXGg=F57g-eMQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/50] tools lib api: Add io_dir an allocation free
 readdir alternative
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 9:21=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Nov 27, 2023 at 02:08:18PM -0800, Ian Rogers escreveu:
> > glibc's opendir allocates a minimum of 32kb, when called recursively
> > for a directory tree the memory consumption can add up - nearly 300kb
> > during perf start-up when processing modules. Add a stack allocated
> > variant of readdir sized a little more than 1kb.
>
> Now, on some systems:
>
>   CC      /tmp/build/perf/pmu-events/pmu-events.o
> In file included from util/machine.c:39:
> /tmp/build/perf/libapi/include/api/io_dir.h: In function =E2=80=98io_dir_=
_readdir=E2=80=99:
> /tmp/build/perf/libapi/include/api/io_dir.h:46:16: error: implicit declar=
ation of function =E2=80=98getdents64=E2=80=99; did you mean =E2=80=98geten=
tropy=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>    ssize_t rc =3D getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
>                 ^~~~~~~~~~
>                 getentropy
>   CC      /tmp/build/perf/tests/workloads/brstack.o
>   CC      /tmp/build/perf/tests/workloads/datasym.o
>   CC      /tmp/build/perf/util/maps.o


Sorry for that. Is it a _GNU_SOURCE issue? I thought we generally had
_GNU_SOURCE defined on the command line for reallocarray. Maybe we
shouldn't define this on the command line and do it immediately before
the relevant include with:

#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

like in tools/perf/util/intel-pt-decoder/intel-pt-decoder.c

Thanks,
Ian

>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/api/Makefile |  2 +-
> >  tools/lib/api/io_dir.h | 75 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 76 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/lib/api/io_dir.h
> >
> > diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> > index 044860ac1ed1..186aa407de8c 100644
> > --- a/tools/lib/api/Makefile
> > +++ b/tools/lib/api/Makefile
> > @@ -99,7 +99,7 @@ install_lib: $(LIBFILE)
> >               $(call do_install_mkdir,$(libdir_SQ)); \
> >               cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
> >
> > -HDRS :=3D cpu.h debug.h io.h
> > +HDRS :=3D cpu.h debug.h io.h io_dir.h
> >  FD_HDRS :=3D fd/array.h
> >  FS_HDRS :=3D fs/fs.h fs/tracing_path.h
> >  INSTALL_HDRS_PFX :=3D $(DESTDIR)$(prefix)/include/api
> > diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
> > new file mode 100644
> > index 000000000000..f3479006edb6
> > --- /dev/null
> > +++ b/tools/lib/api/io_dir.h
> > @@ -0,0 +1,75 @@
> > +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> > +/*
> > + * Lightweight directory reading library.
> > + */
> > +#ifndef __API_IO_DIR__
> > +#define __API_IO_DIR__
> > +
> > +#include <dirent.h>
> > +#include <fcntl.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <sys/stat.h>
> > +
> > +struct io_dirent64 {
> > +     ino64_t        d_ino;    /* 64-bit inode number */
> > +     off64_t        d_off;    /* 64-bit offset to next structure */
> > +     unsigned short d_reclen; /* Size of this dirent */
> > +     unsigned char  d_type;   /* File type */
> > +     char           d_name[NAME_MAX + 1]; /* Filename (null-terminated=
) */
> > +};
> > +
> > +struct io_dir {
> > +     int dirfd;
> > +     ssize_t available_bytes;
> > +     struct io_dirent64 *next;
> > +     struct io_dirent64 buff[4];
> > +};
> > +
> > +static inline void io_dir__init(struct io_dir *iod, int dirfd)
> > +{
> > +     iod->dirfd =3D dirfd;
> > +     iod->available_bytes =3D 0;
> > +}
> > +
> > +static inline void io_dir__rewinddir(struct io_dir *iod)
> > +{
> > +     lseek(iod->dirfd, 0, SEEK_SET);
> > +     iod->available_bytes =3D 0;
> > +}
> > +
> > +static inline struct io_dirent64 *io_dir__readdir(struct io_dir *iod)
> > +{
> > +     struct io_dirent64 *entry;
> > +
> > +     if (iod->available_bytes <=3D 0) {
> > +             ssize_t rc =3D getdents64(iod->dirfd, iod->buff, sizeof(i=
od->buff));
> > +
> > +             if (rc <=3D 0)
> > +                     return NULL;
> > +             iod->available_bytes =3D rc;
> > +             iod->next =3D iod->buff;
> > +     }
> > +     entry =3D iod->next;
> > +     iod->next =3D (struct io_dirent64 *)((char *)entry + entry->d_rec=
len);
> > +     iod->available_bytes -=3D entry->d_reclen;
> > +     return entry;
> > +}
> > +
> > +static inline bool io_dir__is_dir(const struct io_dir *iod, struct io_=
dirent64 *dent)
> > +{
> > +     if (dent->d_type =3D=3D DT_UNKNOWN) {
> > +             struct stat st;
> > +
> > +             if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=3D*/0)=
)
> > +                     return false;
> > +
> > +             if (S_ISDIR(st.st_mode)) {
> > +                     dent->d_type =3D DT_DIR;
> > +                     return true;
> > +             }
> > +     }
> > +     return dent->d_type =3D=3D DT_DIR;
> > +}
> > +
> > +#endif
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
>
> --
>
> - Arnaldo
