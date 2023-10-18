Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC447CEBEA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjJRXWX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 19:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjJRXWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:22:08 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA924FA;
        Wed, 18 Oct 2023 16:21:46 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-27d3ede72f6so4960826a91.1;
        Wed, 18 Oct 2023 16:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697671306; x=1698276106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+MnyqdGOW+LaDHHZi0yZ9sA5rUx+a72yUI6ipYzhNw=;
        b=nq+KtMQY6lRQdd7B4vMj8AKOpk0OuB69xg/wM9E8TG3p3XRahEfYCQw6CVl7jMSk9x
         S0i/Z8JBOmLqhsR9AFzBe9gjfM+U13rrJGpyZ0zrX0EY0LBT8yg84nGBfAaMSN1HqqZK
         hZLDVRjhciYTUCHokhJfFfsFiaw+SKKCRwTpODq9qYkk5JjfzN5hFQO+dFqzI3Of6IP1
         ZiRdg4dKH2AmpJyHm9IP8MHklCiJYe8T1Jzni6yoZtT7OGUSoGZsSkzF5G7T2MbDru9G
         Ku4OEX3tU38SA3aD1kQiENbsjkmvoXNlv+t4YY5Wwp0PPfSdgCaas9FCuoVJ8r9U0i4R
         NsVQ==
X-Gm-Message-State: AOJu0YzDWHPjWmN0JmdC+hTHSySo2jDZun84AvFL1NERCpsWEngo2nkZ
        ZcqITKClKLmnVN2UoLtaDHYsbgxm4PosyPMcM5U=
X-Google-Smtp-Source: AGHT+IEZImdR6ohBfsBK+1L39JSo2rPbwIl5scSef7p8prKstHceM8tIFE4+DZL1UENOTLz7GZoX2OumOamx997KYRE=
X-Received: by 2002:a17:90a:6f23:b0:27d:51c4:1679 with SMTP id
 d32-20020a17090a6f2300b0027d51c41679mr592353pjk.27.1697671306069; Wed, 18 Oct
 2023 16:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com> <20231012062359.1616786-13-irogers@google.com>
In-Reply-To: <20231012062359.1616786-13-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 18 Oct 2023 16:21:35 -0700
Message-ID: <CAM9d7cgehgF0pXm_7VME0jUo=8dHwRH7_EruGqP7D-CVaj5sEw@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] perf mmap: Lazily initialize zstd streams
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
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
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

On Wed, Oct 11, 2023 at 11:24 PM Ian Rogers <irogers@google.com> wrote:
>
> Zstd streams create dictionaries that can require significant RAM,
> especially when there is one per-CPU. Tools like perf record won't use
> the streams without the -z option, and so the creation of the streams
> is pure overhead. Switch to creating the streams on first use.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/compress.h |  1 +
>  tools/perf/util/mmap.c     |  5 ++--
>  tools/perf/util/mmap.h     |  1 -
>  tools/perf/util/zstd.c     | 61 ++++++++++++++++++++------------------
>  4 files changed, 35 insertions(+), 33 deletions(-)
>
> diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
> index 0cd3369af2a4..9391850f1a7e 100644
> --- a/tools/perf/util/compress.h
> +++ b/tools/perf/util/compress.h
> @@ -21,6 +21,7 @@ struct zstd_data {
>  #ifdef HAVE_ZSTD_SUPPORT
>         ZSTD_CStream    *cstream;
>         ZSTD_DStream    *dstream;
> +       int comp_level;
>  #endif
>  };
>
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 49093b21ee2d..122ee198a86e 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -295,15 +295,14 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu
>
>         map->core.flush = mp->flush;
>
> -       map->comp_level = mp->comp_level;
>  #ifndef PYTHON_PERF
> -       if (zstd_init(&map->zstd_data, map->comp_level)) {
> +       if (zstd_init(&map->zstd_data, mp->comp_level)) {
>                 pr_debug2("failed to init mmap compressor, error %d\n", errno);
>                 return -1;
>         }
>  #endif
>
> -       if (map->comp_level && !perf_mmap__aio_enabled(map)) {
> +       if (mp->comp_level && !perf_mmap__aio_enabled(map)) {
>                 map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
>                                  MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
>                 if (map->data == MAP_FAILED) {
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index f944c3cd5efa..0df6e1621c7e 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -39,7 +39,6 @@ struct mmap {
>  #endif
>         struct mmap_cpu_mask    affinity_mask;
>         void            *data;
> -       int             comp_level;
>         struct perf_data_file *file;
>         struct zstd_data      zstd_data;
>  };
> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index 48dd2b018c47..60f2d749b1c0 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
> @@ -7,35 +7,9 @@
>
>  int zstd_init(struct zstd_data *data, int level)
>  {
> -       size_t ret;
> -
> -       data->dstream = ZSTD_createDStream();
> -       if (data->dstream == NULL) {
> -               pr_err("Couldn't create decompression stream.\n");
> -               return -1;
> -       }
> -
> -       ret = ZSTD_initDStream(data->dstream);
> -       if (ZSTD_isError(ret)) {
> -               pr_err("Failed to initialize decompression stream: %s\n", ZSTD_getErrorName(ret));
> -               return -1;
> -       }
> -
> -       if (!level)
> -               return 0;
> -
> -       data->cstream = ZSTD_createCStream();
> -       if (data->cstream == NULL) {
> -               pr_err("Couldn't create compression stream.\n");
> -               return -1;
> -       }
> -
> -       ret = ZSTD_initCStream(data->cstream, level);
> -       if (ZSTD_isError(ret)) {
> -               pr_err("Failed to initialize compression stream: %s\n", ZSTD_getErrorName(ret));
> -               return -1;
> -       }
> -
> +       data->comp_level = level;
> +       data->dstream = NULL;
> +       data->cstream = NULL;
>         return 0;
>  }
>
> @@ -63,6 +37,21 @@ size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t
>         ZSTD_outBuffer output;
>         void *record;
>
> +       if (!data->cstream) {
> +               data->cstream = ZSTD_createCStream();
> +               if (data->cstream == NULL) {
> +                       pr_err("Couldn't create compression stream.\n");
> +                       return -1;
> +               }
> +
> +               ret = ZSTD_initCStream(data->cstream, data->comp_level);
> +               if (ZSTD_isError(ret)) {
> +                       pr_err("Failed to initialize compression stream: %s\n",
> +                               ZSTD_getErrorName(ret));
> +                       return -1;

I'm not sure if the callers are ready to handle the failure.

Thanks,
Namhyung


> +               }
> +       }
> +
>         while (input.pos < input.size) {
>                 record = dst;
>                 size = process_header(record, 0);
> @@ -96,6 +85,20 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
>         ZSTD_inBuffer input = { src, src_size, 0 };
>         ZSTD_outBuffer output = { dst, dst_size, 0 };
>
> +       if (!data->dstream) {
> +               data->dstream = ZSTD_createDStream();
> +               if (data->dstream == NULL) {
> +                       pr_err("Couldn't create decompression stream.\n");
> +                       return -1;
> +               }
> +
> +               ret = ZSTD_initDStream(data->dstream);
> +               if (ZSTD_isError(ret)) {
> +                       pr_err("Failed to initialize decompression stream: %s\n",
> +                               ZSTD_getErrorName(ret));
> +                       return -1;
> +               }
> +       }
>         while (input.pos < input.size) {
>                 ret = ZSTD_decompressStream(data->dstream, &output, &input);
>                 if (ZSTD_isError(ret)) {
> --
> 2.42.0.609.gbb76f46606-goog
>
