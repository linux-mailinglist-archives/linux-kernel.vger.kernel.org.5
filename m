Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87287BD3EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbjJIG5u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 02:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbjJIG5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:57:48 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0D8A3;
        Sun,  8 Oct 2023 23:57:47 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-278fde50024so3911362a91.1;
        Sun, 08 Oct 2023 23:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696834666; x=1697439466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJS+WW4cuCDjk8wiGEOmjzB/AsEq+gw5dUopoJp/L9I=;
        b=c5KdHC57ymKVGQSvaHr1YeXcqqwZeLOx2JNE1wbTmU7zzdLR82U7mrfeTZ7ZLiDGb5
         7AFyMk48B0YLzMJuAwPQl1RzQ8THEKhWZrt1h7c4UQ2qdilYnD/yvE/XPteWHVrYRkC0
         ZPLdxcn8vc2Kb2lcsWm6nk1wgmkMic6I6vvP+0MhVDCRWoHqQEbhXSuvC/X5p6CSR2W7
         VK1mnnCPtqrK/RNE+N4pg4+F1J6rikL8A0Cnil00TEQJjjqx5EYJdNoo8UqnLCDrLw3k
         RnK1Xrl0+j6mdYWtX348Wu1T2I3NfWM0jCpE4gBO2yY/gCEKGi6C24ZlHosHUKdAokAI
         NOmg==
X-Gm-Message-State: AOJu0Yzw+4va2iPfCrfKKmussav6IZVIUWAylU1Zc5LZgFavqxTxBlkw
        7y6Ede+GqxDF3Dag/5qRxP0kN9uBfA4u08BB0PM=
X-Google-Smtp-Source: AGHT+IHXDstWDIhlW/S4bsymJirCqCBInGZVRXyjHfslyOtLbNqbOvsSRor3/F2SZ3hUb4HZKk1bXdnh057wT6n2BHw=
X-Received: by 2002:a17:90a:e557:b0:277:3379:ce04 with SMTP id
 ei23-20020a17090ae55700b002773379ce04mr16019603pjb.18.1696834666501; Sun, 08
 Oct 2023 23:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-18-irogers@google.com>
In-Reply-To: <20231005230851.3666908-18-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 8 Oct 2023 23:57:35 -0700
Message-ID: <CAM9d7cj=au3DVNqA0OYU_9eu=R9kTz6SQrtfKuSGnrm=FAY=CA@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] perf header: Fix various error path memory leaks
To:     Ian Rogers <irogers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 4:09 PM Ian Rogers <irogers@google.com> wrote:
>
> Memory leaks were detected by clang-tidy.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/header.c | 63 ++++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 25 deletions(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index d812e1e371a7..41b78e40b22b 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2598,8 +2598,10 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
>                         goto error;
>
>                 /* include a NULL character at the end */
> -               if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
> +               if (strbuf_add(&sb, str, strlen(str) + 1) < 0) {
> +                       free(str);
>                         goto error;
> +               }
>                 size += string_size(str);
>                 free(str);
>         }
> @@ -2617,8 +2619,10 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
>                         goto error;
>
>                 /* include a NULL character at the end */
> -               if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
> +               if (strbuf_add(&sb, str, strlen(str) + 1) < 0) {
> +                       free(str);
>                         goto error;
> +               }
>                 size += string_size(str);
>                 free(str);
>         }
> @@ -2681,8 +2685,10 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
>                         goto error;
>
>                 /* include a NULL character at the end */
> -               if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
> +               if (strbuf_add(&sb, str, strlen(str) + 1) < 0) {
> +                       free(str);
>                         goto error;
> +               }
>                 size += string_size(str);
>                 free(str);
>         }

For these cases, it'd be simpler to free it in the error path.


> @@ -2736,10 +2742,9 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
>                         goto error;
>
>                 n->map = perf_cpu_map__new(str);
> +               free(str);
>                 if (!n->map)
>                         goto error;
> -
> -               free(str);
>         }
>         ff->ph->env.nr_numa_nodes = nr;
>         ff->ph->env.numa_nodes = nodes;
> @@ -2913,10 +2918,10 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
>                 return -1;
>
>         for (i = 0; i < cnt; i++) {
> -               struct cpu_cache_level c;
> +               struct cpu_cache_level *c = &caches[i];
>
>                 #define _R(v)                                           \
> -                       if (do_read_u32(ff, &c.v))\
> +                       if (do_read_u32(ff, &c->v))                     \
>                                 goto out_free_caches;                   \
>
>                 _R(level)
> @@ -2926,22 +2931,25 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
>                 #undef _R
>
>                 #define _R(v)                                   \
> -                       c.v = do_read_string(ff);               \
> -                       if (!c.v)                               \
> -                               goto out_free_caches;
> +                       c->v = do_read_string(ff);              \
> +                       if (!c->v)                              \
> +                               goto out_free_caches;           \
>
>                 _R(type)
>                 _R(size)
>                 _R(map)
>                 #undef _R
> -
> -               caches[i] = c;
>         }
>
>         ff->ph->env.caches = caches;
>         ff->ph->env.caches_cnt = cnt;
>         return 0;
>  out_free_caches:
> +       for (i = 0; i < cnt; i++) {
> +               free(caches[i].type);
> +               free(caches[i].size);
> +               free(caches[i].map);
> +       }
>         free(caches);
>         return -1;
>  }

Looks ok.


> @@ -3585,18 +3593,16 @@ static int perf_header__adds_write(struct perf_header *header,
>                                    struct feat_copier *fc)
>  {
>         int nr_sections;
> -       struct feat_fd ff;
> +       struct feat_fd ff = {
> +               .fd  = fd,
> +               .ph = header,
> +       };

I'm fine with this change.


>         struct perf_file_section *feat_sec, *p;
>         int sec_size;
>         u64 sec_start;
>         int feat;
>         int err;
>
> -       ff = (struct feat_fd){
> -               .fd  = fd,
> -               .ph = header,
> -       };
> -
>         nr_sections = bitmap_weight(header->adds_features, HEADER_FEAT_BITS);
>         if (!nr_sections)
>                 return 0;
> @@ -3623,6 +3629,7 @@ static int perf_header__adds_write(struct perf_header *header,
>         err = do_write(&ff, feat_sec, sec_size);
>         if (err < 0)
>                 pr_debug("failed to write feature section\n");
> +       free(ff.buf);

But it looks like false alarams.  Since the feat_fd has fd
and no buf, it won't allocate the buffer in do_write() and
just use __do_write_fd().  So no need to free the buf.

Thanks,
Namhyung


>         free(feat_sec);
>         return err;
>  }
> @@ -3630,11 +3637,11 @@ static int perf_header__adds_write(struct perf_header *header,
>  int perf_header__write_pipe(int fd)
>  {
>         struct perf_pipe_file_header f_header;
> -       struct feat_fd ff;
> +       struct feat_fd ff = {
> +               .fd = fd,
> +       };
>         int err;
>
> -       ff = (struct feat_fd){ .fd = fd };
> -
>         f_header = (struct perf_pipe_file_header){
>                 .magic     = PERF_MAGIC,
>                 .size      = sizeof(f_header),
> @@ -3645,7 +3652,7 @@ int perf_header__write_pipe(int fd)
>                 pr_debug("failed to write perf pipe header\n");
>                 return err;
>         }
> -
> +       free(ff.buf);
>         return 0;
>  }
>
> @@ -3658,11 +3665,12 @@ static int perf_session__do_write_header(struct perf_session *session,
>         struct perf_file_attr   f_attr;
>         struct perf_header *header = &session->header;
>         struct evsel *evsel;
> -       struct feat_fd ff;
> +       struct feat_fd ff = {
> +               .fd = fd,
> +       };
>         u64 attr_offset;
>         int err;
>
> -       ff = (struct feat_fd){ .fd = fd};
>         lseek(fd, sizeof(f_header), SEEK_SET);
>
>         evlist__for_each_entry(session->evlist, evsel) {
> @@ -3670,6 +3678,7 @@ static int perf_session__do_write_header(struct perf_session *session,
>                 err = do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64));
>                 if (err < 0) {
>                         pr_debug("failed to write perf header\n");
> +                       free(ff.buf);
>                         return err;
>                 }
>         }
> @@ -3695,6 +3704,7 @@ static int perf_session__do_write_header(struct perf_session *session,
>                 err = do_write(&ff, &f_attr, sizeof(f_attr));
>                 if (err < 0) {
>                         pr_debug("failed to write perf header attribute\n");
> +                       free(ff.buf);
>                         return err;
>                 }
>         }
> @@ -3705,8 +3715,10 @@ static int perf_session__do_write_header(struct perf_session *session,
>
>         if (at_exit) {
>                 err = perf_header__adds_write(header, evlist, fd, fc);
> -               if (err < 0)
> +               if (err < 0) {
> +                       free(ff.buf);
>                         return err;
> +               }
>         }
>
>         f_header = (struct perf_file_header){
> @@ -3728,6 +3740,7 @@ static int perf_session__do_write_header(struct perf_session *session,
>
>         lseek(fd, 0, SEEK_SET);
>         err = do_write(&ff, &f_header, sizeof(f_header));
> +       free(ff.buf);
>         if (err < 0) {
>                 pr_debug("failed to write perf header\n");
>                 return err;
> --
> 2.42.0.609.gbb76f46606-goog
>
