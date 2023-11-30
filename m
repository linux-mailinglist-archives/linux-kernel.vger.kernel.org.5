Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AF27FF815
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345925AbjK3RVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjK3RVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:21:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688CB133
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:21:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B70C433C8;
        Thu, 30 Nov 2023 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701364910;
        bh=x9i+R2gnAISZ3MbRdG7KjomQ/TK5UTSEfFADFc18L4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xd708dHy2rBdgSCMF2N+HSUxxgo+wUeY9Eo9W7y3aQbIiG0MgXeH2XXzg6uH57Wq+
         eLHQsBp/oDVUDmvolD3hgEK1Mklc2ixUaXHNz7s6y7v0a3LyK1DYjp8XkjWpQVNA+z
         jAdDPCsVDW9hnUKcxqeCkW6r8xM621b1vRJ4LXWrPuN/1i6/v2xUvu+q+MoGFPGLt5
         ROMcKhyg9hii68SgEZjuFLB+zhnUQ/BKmhTxOvZDCz91NW/9j5VX1PhaDmrnHcsvmv
         eqTjhIo14sRxiOeolAVOwfu5PdgIzFUr4grj/EvYDBcsldEgeAeHqw5rmECIP44iO0
         LiL4AluRbe9Og==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E80640094; Thu, 30 Nov 2023 14:21:47 -0300 (-03)
Date:   Thu, 30 Nov 2023 14:21:47 -0300
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
Message-ID: <ZWjEqw1cAw/eIpQH@kernel.org>
References: <20231127220902.1315692-1-irogers@google.com>
 <20231127220902.1315692-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127220902.1315692-7-irogers@google.com>
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

Em Mon, Nov 27, 2023 at 02:08:18PM -0800, Ian Rogers escreveu:
> glibc's opendir allocates a minimum of 32kb, when called recursively
> for a directory tree the memory consumption can add up - nearly 300kb
> during perf start-up when processing modules. Add a stack allocated
> variant of readdir sized a little more than 1kb.

Now, on some systems:

  CC      /tmp/build/perf/pmu-events/pmu-events.o
In file included from util/machine.c:39:
/tmp/build/perf/libapi/include/api/io_dir.h: In function ‘io_dir__readdir’:
/tmp/build/perf/libapi/include/api/io_dir.h:46:16: error: implicit declaration of function ‘getdents64’; did you mean ‘getentropy’? [-Werror=implicit-function-declaration]
   ssize_t rc = getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
                ^~~~~~~~~~
                getentropy
  CC      /tmp/build/perf/tests/workloads/brstack.o
  CC      /tmp/build/perf/tests/workloads/datasym.o
  CC      /tmp/build/perf/util/maps.o

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/Makefile |  2 +-
>  tools/lib/api/io_dir.h | 75 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/api/io_dir.h
> 
> diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> index 044860ac1ed1..186aa407de8c 100644
> --- a/tools/lib/api/Makefile
> +++ b/tools/lib/api/Makefile
> @@ -99,7 +99,7 @@ install_lib: $(LIBFILE)
>  		$(call do_install_mkdir,$(libdir_SQ)); \
>  		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
>  
> -HDRS := cpu.h debug.h io.h
> +HDRS := cpu.h debug.h io.h io_dir.h
>  FD_HDRS := fd/array.h
>  FS_HDRS := fs/fs.h fs/tracing_path.h
>  INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/api
> diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
> new file mode 100644
> index 000000000000..f3479006edb6
> --- /dev/null
> +++ b/tools/lib/api/io_dir.h
> @@ -0,0 +1,75 @@
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
> +struct io_dirent64 {
> +	ino64_t        d_ino;    /* 64-bit inode number */
> +	off64_t        d_off;    /* 64-bit offset to next structure */
> +	unsigned short d_reclen; /* Size of this dirent */
> +	unsigned char  d_type;   /* File type */
> +	char           d_name[NAME_MAX + 1]; /* Filename (null-terminated) */
> +};
> +
> +struct io_dir {
> +	int dirfd;
> +	ssize_t available_bytes;
> +	struct io_dirent64 *next;
> +	struct io_dirent64 buff[4];
> +};
> +
> +static inline void io_dir__init(struct io_dir *iod, int dirfd)
> +{
> +	iod->dirfd = dirfd;
> +	iod->available_bytes = 0;
> +}
> +
> +static inline void io_dir__rewinddir(struct io_dir *iod)
> +{
> +	lseek(iod->dirfd, 0, SEEK_SET);
> +	iod->available_bytes = 0;
> +}
> +
> +static inline struct io_dirent64 *io_dir__readdir(struct io_dir *iod)
> +{
> +	struct io_dirent64 *entry;
> +
> +	if (iod->available_bytes <= 0) {
> +		ssize_t rc = getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
> +
> +		if (rc <= 0)
> +			return NULL;
> +		iod->available_bytes = rc;
> +		iod->next = iod->buff;
> +	}
> +	entry = iod->next;
> +	iod->next = (struct io_dirent64 *)((char *)entry + entry->d_reclen);
> +	iod->available_bytes -= entry->d_reclen;
> +	return entry;
> +}
> +
> +static inline bool io_dir__is_dir(const struct io_dir *iod, struct io_dirent64 *dent)
> +{
> +	if (dent->d_type == DT_UNKNOWN) {
> +		struct stat st;
> +
> +		if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=*/0))
> +			return false;
> +
> +		if (S_ISDIR(st.st_mode)) {
> +			dent->d_type = DT_DIR;
> +			return true;
> +		}
> +	}
> +	return dent->d_type == DT_DIR;
> +}
> +
> +#endif
> -- 
> 2.43.0.rc1.413.gea7ed67945-goog
> 

-- 

- Arnaldo
