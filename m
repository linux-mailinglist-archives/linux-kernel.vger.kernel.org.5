Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553CB7E1584
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjKERe1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Nov 2023 12:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKEReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:34:25 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7832BF2;
        Sun,  5 Nov 2023 09:34:21 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28019b66ad5so3408388a91.3;
        Sun, 05 Nov 2023 09:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699205661; x=1699810461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5DlY0OWp3eH+oUYPI/NdOdSEBvIxZyXVYOIYudsQzE=;
        b=UDehniYnqwU0sfsKSHv+LwM8kPMD/4omaCHD7hGZJcS87E2N0aS1mkxBnC9IKbCKSW
         af07hlUGhezAxWoHsI2M0E3ioEZ1B2t6qSWISY2ydjTqinNEMpmGtKN5MuRJUJWx29AZ
         TwPjkZUKbQhImMlG+i5+TMyhWvcQnBtlE0WA4p15E8WQkTZ+usfXH1JdYWeeBj8N+dSU
         PezmqVBOnFtw5Ke9qhGOupuj9QRDsCUw/9oxs2mo8n2DEbPFpuQJNW2eLNp/nr3/F9Tb
         x4gJwTloQBDZuEHDBMPY/UDIwqFBW7Isa2OjPBBrLdxrzi6ElaJpvyGhUvIdRKO/dtFA
         oBOA==
X-Gm-Message-State: AOJu0YxQ0HeJRPaaaousnQ8OXh0nxvLVWPXVdGvSpSifVLrERcyKk0I4
        RbY9y5UwTXMKvuuF6O1V/V2KU0vahQsrw+FsC54VZXkp
X-Google-Smtp-Source: AGHT+IH3TyyrWP0T71U6bbIBMd1wrTaw5zI48OBr7U0Iztbkn71weTXTgRlxPZhH5TAPVzQqjQYB7fHqdxE3xW3nHRA=
X-Received: by 2002:a17:90a:7563:b0:27d:853:9109 with SMTP id
 q90-20020a17090a756300b0027d08539109mr25068732pjk.20.1699205660840; Sun, 05
 Nov 2023 09:34:20 -0800 (PST)
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-3-irogers@google.com>
In-Reply-To: <20231102175735.2272696-3-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 5 Nov 2023 09:34:09 -0800
Message-ID: <CAM9d7cir-tbinOQ8MFG7+TwuQubSWNwEz_8uqoiB=uWoHc59hQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/53] perf record: Lazy load kernel symbols
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

On Thu, Nov 2, 2023 at 10:58 AM Ian Rogers <irogers@google.com> wrote:
>
> Commit 5b7ba82a7591 ("perf symbols: Load kernel maps before using")
> changed it so that loading a kernel dso would cause the symbols for
> the dso to be eagerly loaded. For perf record this is overhead as the
> symbols won't be used. Add a symbol_conf to control the behavior and
> disable it for perf record and perf inject.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-inject.c   | 6 ++++++
>  tools/perf/builtin-record.c   | 2 ++
>  tools/perf/util/event.c       | 4 ++--
>  tools/perf/util/symbol_conf.h | 3 ++-
>  4 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index c8cf2fdd9cff..eb3ef5c24b66 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2265,6 +2265,12 @@ int cmd_inject(int argc, const char **argv)
>                 "perf inject [<options>]",
>                 NULL
>         };
> +
> +       if (!inject.itrace_synth_opts.set) {
> +               /* Disable eager loading of kernel symbols that adds overhead to perf inject. */
> +               symbol_conf.lazy_load_kernel_maps = true;
> +       }
> +
>  #ifndef HAVE_JITDUMP
>         set_option_nobuild(options, 'j', "jit", "NO_LIBELF=1", true);
>  #endif
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index dcf288a4fb9a..8ec818568662 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3989,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
>  # undef set_nobuild
>  #endif
>
> +       /* Disable eager loading of kernel symbols that adds overhead to perf record. */
> +       symbol_conf.lazy_load_kernel_maps = true;
>         rec->opts.affinity = PERF_AFFINITY_SYS;
>
>         rec->evlist = evlist__new();
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 923c0fb15122..68f45e9e63b6 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -617,13 +617,13 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>         if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
>                 al->level = 'k';
>                 maps = machine__kernel_maps(machine);
> -               load_map = true;
> +               load_map = !symbol_conf.lazy_load_kernel_maps;
>         } else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
>                 al->level = '.';
>         } else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
>                 al->level = 'g';
>                 maps = machine__kernel_maps(machine);
> -               load_map = true;
> +               load_map = !symbol_conf.lazy_load_kernel_maps;
>         } else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
>                 al->level = 'u';
>         } else {
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index 0b589570d1d0..2b2fb9e224b0 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -42,7 +42,8 @@ struct symbol_conf {
>                         inline_name,
>                         disable_add2line_warn,
>                         buildid_mmap2,
> -                       guest_code;
> +                       guest_code,
> +                       lazy_load_kernel_maps;
>         const char      *vmlinux_name,
>                         *kallsyms_name,
>                         *source_prefix,
> --
> 2.42.0.869.gea05f2083d-goog
>
