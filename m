Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10797D737E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjJYSng convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 14:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjJYSnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:43:35 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46528115;
        Wed, 25 Oct 2023 11:43:33 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-564b6276941so91238a12.3;
        Wed, 25 Oct 2023 11:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259413; x=1698864213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYCMWJw47/vXzt/AlomWVuji6mKZPa8r5u3HJinoFCY=;
        b=d2Onxy2EozszoSpIDrM2uMymBDIriyd5lHN3PyHFK2dBTU4uAVOtTtjnZ0r/AQ3Sn+
         ehAzMf/6vGcbhP9epyLQn2/Bwb/2/pUnIpmhU9U5VdmtaPS4h28VC6laHI87m3h9RRaR
         Ni1OrF97/7n5I5cv5QRRfezYA7W5NABdIwSb0lqcPTkvcnTWSwOwKEHOwBzPgpGpvHwY
         +dXJs0OVlPSesund135Fy00cJZHUySNPtQfI3r8APy1zgc4U6NFx5IZIUvct4ao9DO+J
         IpJoa7IwleqPMR+gzcxzWq8TU9HvulWnw5iUXZA885CIiJHqymgccpPZLaVtacmhEHT3
         Uz8w==
X-Gm-Message-State: AOJu0YzN8322uASLFrOiJpTrt2ZFC+zuSnXOqA8ssdqDp+StiW1aFf+q
        CLPbeN/i2r0dbZf+w4qnHKlejHI/7MvgBOs9QB8=
X-Google-Smtp-Source: AGHT+IHlN5LcLU2+3wZ6yuUT607ZoDFdjK4WqiQH9Qt47ljhPX9spEdT5497fBdr48jj+4G+nD0cASMpEgp9LhbQRwQ=
X-Received: by 2002:a17:90a:5993:b0:27d:1b04:d69d with SMTP id
 l19-20020a17090a599300b0027d1b04d69dmr14521597pji.35.1698259412590; Wed, 25
 Oct 2023 11:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com> <20231024222353.3024098-19-irogers@google.com>
In-Reply-To: <20231024222353.3024098-19-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 25 Oct 2023 11:43:21 -0700
Message-ID: <CAM9d7chKwxnCe=FDCxyuui5S8yp4=3xYytShCi9QTGzjK1yqZw@mail.gmail.com>
Subject: Re: [PATCH v3 18/50] tools lib api: Add io_dir an allocation free
 readdir alternative
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 3:24 PM Ian Rogers <irogers@google.com> wrote:
>
> glibc's opendir allocates a minimum of 32kb, when called recursively
> for a directory tree the memory consumption can add up - nearly 300kb
> during perf start-up when processing modules. Add a stack allocated
> variant of readdir sized a little more than 1kb.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/Makefile |  2 +-
>  tools/lib/api/io_dir.h | 72 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 1 deletion(-)
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
> index 000000000000..8a70c0718df5
> --- /dev/null
> +++ b/tools/lib/api/io_dir.h
> @@ -0,0 +1,72 @@
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

Any chance of unaligned access?


> +       iod->available_bytes -= entry->d_reclen;
> +       return entry;
> +}
> +
> +static inline bool io_dir__is_dir(const struct io_dir *iod, const struct io_dirent64 *dent)
> +{
> +       if (dent->d_type == DT_UNKNOWN) {
> +               struct stat st;
> +
> +               if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=*/0))
> +                       return false;
> +
> +               return S_ISDIR(st.st_mode);

You may want to save the type if it's a DIR.

Thanks,
Namhyung


> +       }
> +       return dent->d_type == DT_DIR;
> +}
> +
> +#endif
> --
> 2.42.0.758.gaed0368e0e-goog
>
