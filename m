Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6387FFD7C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376957AbjK3VZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376920AbjK3VZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:25:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5631A10D9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:25:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F729C433C7;
        Thu, 30 Nov 2023 21:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701379554;
        bh=9bgZgakLuV766x8vJhclEiCgo0lX4jxjBvFiXcY/WAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dCCQzcNa3LrH9RQYJpe5QMHN8s5MLHlHX2YGjl+QVdaf+2PliPWzsKjtqB2eUe2ho
         UFEEBqotv7GUXzfk4pUIMopX7xzEKPzNFSSu2r00ns1waRO9jlIE7ymn5Zf/Nqfu8K
         EjHNo2gFE8e4Fud86XuKoIGhtqYcIdUR4v+UpqN8djwnapnmdlnwljzsvXk6dAcONe
         laKtyOZymWfdkDt0FIXa06kOCYYigXp0m9EH5s8Zc3RMXkeA1kbZ4xGbmh7Svdr3dY
         P5JVvir8FAszz53zscQv/czSPkmLqjFONOYO0dSc1CsMC1dEI1ZRmPaiaPRmr2205L
         LMnSqZxUBuypg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9C98940094; Thu, 30 Nov 2023 18:25:50 -0300 (-03)
Date:   Thu, 30 Nov 2023 18:25:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
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
Subject: Re: [PATCH v5 06/50] tools lib api: Add io_dir an allocation free
 readdir alternative
Message-ID: <ZWj93nq9GBpga7nT@kernel.org>
References: <20231127220902.1315692-1-irogers@google.com>
 <20231127220902.1315692-7-irogers@google.com>
 <ZWjEqw1cAw/eIpQH@kernel.org>
 <CAP-5=fUj7ZCchuwBW7xLe0UK8eupQUH3n9t0vcXGg=F57g-eMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUj7ZCchuwBW7xLe0UK8eupQUH3n9t0vcXGg=F57g-eMQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 30, 2023 at 09:56:42AM -0800, Ian Rogers escreveu:
> On Thu, Nov 30, 2023 at 9:21 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Mon, Nov 27, 2023 at 02:08:18PM -0800, Ian Rogers escreveu:
> > > glibc's opendir allocates a minimum of 32kb, when called recursively
> > > for a directory tree the memory consumption can add up - nearly 300kb
> > > during perf start-up when processing modules. Add a stack allocated
> > > variant of readdir sized a little more than 1kb.
> >
> > Now, on some systems:
> >
> >   CC      /tmp/build/perf/pmu-events/pmu-events.o
> > In file included from util/machine.c:39:
> > /tmp/build/perf/libapi/include/api/io_dir.h: In function ‘io_dir__readdir’:
> > /tmp/build/perf/libapi/include/api/io_dir.h:46:16: error: implicit declaration of function ‘getdents64’; did you mean ‘getentropy’? [-Werror=implicit-function-declaration]
> >    ssize_t rc = getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
> >                 ^~~~~~~~~~
> >                 getentropy
> >   CC      /tmp/build/perf/tests/workloads/brstack.o
> >   CC      /tmp/build/perf/tests/workloads/datasym.o
> >   CC      /tmp/build/perf/util/maps.o
> 
> 
> Sorry for that. Is it a _GNU_SOURCE issue? I thought we generally had

Nope, some systems just don't have that function in its libc, for
instance, a Red Hat derivative with glibc 2.28:

glibc-2.28-189.5.el8_6.x86_64

[perfbuilder@56645cef2169 /]$ grep -r getdents64 /usr/include
/usr/include/bits/syscall.h:#ifdef __NR_getdents64
/usr/include/bits/syscall.h:# define SYS_getdents64 __NR_getdents64
/usr/include/asm-generic/unistd.h:#define __NR_getdents64 61
/usr/include/asm-generic/unistd.h:__SYSCALL(__NR_getdents64, sys_getdents64)
/usr/include/sanitizer/linux_syscall_hooks.h:#define __sanitizer_syscall_pre_getdents64(fd, dirent, count)         \
/usr/include/sanitizer/linux_syscall_hooks.h:  __sanitizer_syscall_pre_impl_getdents64((long)(fd), (long)(dirent), \
/usr/include/sanitizer/linux_syscall_hooks.h:#define __sanitizer_syscall_post_getdents64(res, fd, dirent, count)         \
/usr/include/sanitizer/linux_syscall_hooks.h:  __sanitizer_syscall_post_impl_getdents64(res, (long)(fd), (long)(dirent), \
/usr/include/sanitizer/linux_syscall_hooks.h:void __sanitizer_syscall_pre_impl_getdents64(long fd, long dirent, long count);
/usr/include/sanitizer/linux_syscall_hooks.h:void __sanitizer_syscall_post_impl_getdents64(long res, long fd, long dirent,
/usr/include/asm/unistd_64.h:#define __NR_getdents64 217
/usr/include/asm/unistd_x32.h:#define __NR_getdents64 (__X32_SYSCALL_BIT + 217)
/usr/include/asm/unistd_32.h:#define __NR_getdents64 220
[perfbuilder@56645cef2169 /]$

Systems with musl libc fail differently:

   6    19.51 alpine:3.18                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r10)
      CC      /tmp/build/perf/util/sample-raw.o
      CC      /tmp/build/perf/tests/kmod-path.o
      CC      /tmp/build/perf/tests/thread-map.o
      CC      /tmp/build/perf/tests/topology.o
    In file included from util/machine.c:39:
    /tmp/build/perf/libapi/include/api/io_dir.h: In function 'io_dir__readdir':
    /tmp/build/perf/libapi/include/api/io_dir.h:46:56: error: passing argument 2 of 'getdents' from incompatible pointer type [-Werror=incompatible-pointer-types]
       46 |                 ssize_t rc = getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
          |                                                     ~~~^~~~~~
          |                                                        |
          |                                                        struct io_dirent64 *
    In file included from util/machine.c:2:
    /usr/include/dirent.h:52:19: note: expected 'struct dirent *' but argument is of type 'struct io_dirent64 *'
       52 | int getdents(int, struct dirent *, size_t);
          |                   ^~~~~~~~~~~~~~~

Their devel distro also fails like that:

   7    20.49 alpine:edge                   : FAIL gcc version 13.1.1 20230722 (Alpine 13.1.1_git20230722)
      CC      /tmp/build/perf/tests/sdt.o
      CC      /tmp/build/perf/util/maps.o
      CC      /tmp/build/perf/tests/is_printable_array.o
      CC      /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
    In file included from util/machine.c:39:
    /tmp/build/perf/libapi/include/api/io_dir.h: In function 'io_dir__readdir':
    /tmp/build/perf/libapi/include/api/io_dir.h:46:56: error: passing argument 2 of 'getdents' from incompatible pointer type [-Werror=incompatible-pointer-types]
       46 |                 ssize_t rc = getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
          |                                                     ~~~^~~~~~
          |                                                        |
          |                                                        struct io_dirent64 *
    In file included from util/machine.c:2:
    /usr/include/dirent.h:52:19: note: expected 'struct dirent *' but argument is of type 'struct io_dirent64 *'
       52 | int getdents(int, struct dirent *, size_t);
          |                   ^~~~~~~~~~~~~~~
      CC      /tmp/build/perf/tests/bitmap.o

And then we have nolibc:

⬢[acme@toolbox perf-tools-next]$ find tools/ -name nolibc
tools/include/nolibc
tools/testing/selftests/nolibc
⬢[acme@toolbox perf-tools-next]$ grep getdents64 tools/include/nolibc/*
tools/include/nolibc/sys.h: * int getdents64(int fd, struct linux_dirent64 *dirp, int count);
tools/include/nolibc/sys.h:int sys_getdents64(int fd, struct linux_dirent64 *dirp, int count)
tools/include/nolibc/sys.h:	return my_syscall3(__NR_getdents64, fd, dirp, count);
tools/include/nolibc/sys.h:int getdents64(int fd, struct linux_dirent64 *dirp, int count)
tools/include/nolibc/sys.h:	return __sysret(sys_getdents64(fd, dirp, count));
tools/include/nolibc/types.h:/* for getdents64() */
⬢[acme@toolbox perf-tools-next]$

On musl libc systems:

/ $ grep -A1 -B20 getdents64 /usr/include/*.h
/usr/include/dirent.h-#define DT_SOCK 12
/usr/include/dirent.h-#define DT_WHT 14
/usr/include/dirent.h-#define IFTODT(x) ((x)>>12 & 017)
/usr/include/dirent.h-#define DTTOIF(x) ((x)<<12)
/usr/include/dirent.h-int getdents(int, struct dirent *, size_t);
/usr/include/dirent.h-#endif
/usr/include/dirent.h-
/usr/include/dirent.h-#ifdef _GNU_SOURCE
/usr/include/dirent.h-int versionsort(const struct dirent **, const struct dirent **);
/usr/include/dirent.h-#endif
/usr/include/dirent.h-
/usr/include/dirent.h-#if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
/usr/include/dirent.h-#define dirent64 dirent
/usr/include/dirent.h-#define readdir64 readdir
/usr/include/dirent.h-#define readdir64_r readdir_r
/usr/include/dirent.h-#define scandir64 scandir
/usr/include/dirent.h-#define alphasort64 alphasort
/usr/include/dirent.h-#define versionsort64 versionsort
/usr/include/dirent.h-#define off64_t off_t
/usr/include/dirent.h-#define ino64_t ino_t
/usr/include/dirent.h:#define getdents64 getdents
/usr/include/dirent.h-#endif
/ $

> _GNU_SOURCE defined on the command line for reallocarray. Maybe we
> shouldn't define this on the command line and do it immediately before
> the relevant include with:
> 
> #ifndef _GNU_SOURCE
> #define _GNU_SOURCE
> #endif
> 
> like in tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> 
> Thanks,
> Ian
> 
> >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/lib/api/Makefile |  2 +-
> > >  tools/lib/api/io_dir.h | 75 ++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 76 insertions(+), 1 deletion(-)
> > >  create mode 100644 tools/lib/api/io_dir.h
> > >
> > > diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> > > index 044860ac1ed1..186aa407de8c 100644
> > > --- a/tools/lib/api/Makefile
> > > +++ b/tools/lib/api/Makefile
> > > @@ -99,7 +99,7 @@ install_lib: $(LIBFILE)
> > >               $(call do_install_mkdir,$(libdir_SQ)); \
> > >               cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
> > >
> > > -HDRS := cpu.h debug.h io.h
> > > +HDRS := cpu.h debug.h io.h io_dir.h
> > >  FD_HDRS := fd/array.h
> > >  FS_HDRS := fs/fs.h fs/tracing_path.h
> > >  INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/api
> > > diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
> > > new file mode 100644
> > > index 000000000000..f3479006edb6
> > > --- /dev/null
> > > +++ b/tools/lib/api/io_dir.h
> > > @@ -0,0 +1,75 @@
> > > +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> > > +/*
> > > + * Lightweight directory reading library.
> > > + */
> > > +#ifndef __API_IO_DIR__
> > > +#define __API_IO_DIR__
> > > +
> > > +#include <dirent.h>
> > > +#include <fcntl.h>
> > > +#include <stdlib.h>
> > > +#include <unistd.h>
> > > +#include <sys/stat.h>
> > > +
> > > +struct io_dirent64 {
> > > +     ino64_t        d_ino;    /* 64-bit inode number */
> > > +     off64_t        d_off;    /* 64-bit offset to next structure */
> > > +     unsigned short d_reclen; /* Size of this dirent */
> > > +     unsigned char  d_type;   /* File type */
> > > +     char           d_name[NAME_MAX + 1]; /* Filename (null-terminated) */
> > > +};
> > > +
> > > +struct io_dir {
> > > +     int dirfd;
> > > +     ssize_t available_bytes;
> > > +     struct io_dirent64 *next;
> > > +     struct io_dirent64 buff[4];
> > > +};
> > > +
> > > +static inline void io_dir__init(struct io_dir *iod, int dirfd)
> > > +{
> > > +     iod->dirfd = dirfd;
> > > +     iod->available_bytes = 0;
> > > +}
> > > +
> > > +static inline void io_dir__rewinddir(struct io_dir *iod)
> > > +{
> > > +     lseek(iod->dirfd, 0, SEEK_SET);
> > > +     iod->available_bytes = 0;
> > > +}
> > > +
> > > +static inline struct io_dirent64 *io_dir__readdir(struct io_dir *iod)
> > > +{
> > > +     struct io_dirent64 *entry;
> > > +
> > > +     if (iod->available_bytes <= 0) {
> > > +             ssize_t rc = getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
> > > +
> > > +             if (rc <= 0)
> > > +                     return NULL;
> > > +             iod->available_bytes = rc;
> > > +             iod->next = iod->buff;
> > > +     }
> > > +     entry = iod->next;
> > > +     iod->next = (struct io_dirent64 *)((char *)entry + entry->d_reclen);
> > > +     iod->available_bytes -= entry->d_reclen;
> > > +     return entry;
> > > +}
> > > +
> > > +static inline bool io_dir__is_dir(const struct io_dir *iod, struct io_dirent64 *dent)
> > > +{
> > > +     if (dent->d_type == DT_UNKNOWN) {
> > > +             struct stat st;
> > > +
> > > +             if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=*/0))
> > > +                     return false;
> > > +
> > > +             if (S_ISDIR(st.st_mode)) {
> > > +                     dent->d_type = DT_DIR;
> > > +                     return true;
> > > +             }
> > > +     }
> > > +     return dent->d_type == DT_DIR;
> > > +}
> > > +
> > > +#endif
> > > --
> > > 2.43.0.rc1.413.gea7ed67945-goog
> > >
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
