Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9257D732A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjJYSZ7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 14:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJYSZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:25:58 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4030AB;
        Wed, 25 Oct 2023 11:25:55 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so84461a12.1;
        Wed, 25 Oct 2023 11:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698258355; x=1698863155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJAKpnqddCDWndjCGlgQHJV2XSPFHdKSadNoAg1lWyE=;
        b=Tu2uzjQST82b/x5Uo0QC1cwz3vfcxo8UYq96MU3AIf2YlCOZ/qpXoFXPHQzcHzZP/z
         yTrj1YqnDTQ0PLceNVqKmVyuDYxwuHyC0XZECnrNTyxaw8TzPCllo40JUlY26DIlIYYc
         uA/9Ja61pyKt/EIo53yqTL2d2tqUpPkGZp/hB3c+iMSdLTf8LkjQAGR5FtNWCcoRIhoM
         pHtm5y2mxEZSJWymc6cCPrJX9jEq17Fdxyjw4f4I6f6Duwz9wCGPyi0uyDudG8a5QdVF
         7JxIEI/+hdY43KFVGczpCJ6bytxpR+etZ/jc3YrmBPVaE4rvR4/yPC0vq/DEOfRKrBod
         Uitw==
X-Gm-Message-State: AOJu0YzQlubwt9uBA2XWLXpmJTFuBGSLZZHZ6guPAtM1HRP7B7+Cl747
        uIHCtzhgOELFcartdW7P3MEZUysVAq1EK32qv6c=
X-Google-Smtp-Source: AGHT+IHJl9pymaNhSNcYRv2DAsEDNddUbZBvz07Ph18QQz0O8YZ8KSpy04NUH9oEykuBhOmrJGaOQVsN53Qct+5CCzQ=
X-Received: by 2002:a17:90b:f10:b0:27d:12e1:7e20 with SMTP id
 br16-20020a17090b0f1000b0027d12e17e20mr15200810pjb.12.1698258355242; Wed, 25
 Oct 2023 11:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com> <20231024222353.3024098-13-irogers@google.com>
In-Reply-To: <20231024222353.3024098-13-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 25 Oct 2023 11:25:44 -0700
Message-ID: <CAM9d7cjsnEQ5Ns45HbFfDbOtFerAhFnzasyRP2Qow-=vOAJTwQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/50] perf record: Lazy load kernel symbols
To:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Nick Terrell <terrelln@fb.com>,
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Tue, Oct 24, 2023 at 3:24 PM Ian Rogers <irogers@google.com> wrote:
>
> Commit 5b7ba82a7591 ("perf symbols: Load kernel maps before using")
> changed it so that loading a kernel dso would cause the symbols for
> the dso to be eagerly loaded. For perf record this is overhead as the
> symbols won't be used. Add a symbol_conf to control the behavior and
> disable it for perf record and perf inject.

I'm curious if it can simply move to lazy loading unconditionally.
In most cases, the code calls machine__resolve() which calls
thread__find_map() and map__find_symbol() to load symbols.

So I think it's unnecessary to do it in the thread__find_map().
If it needs a symbol, it should call map__find_symbol() first
and it'll load the symbol table.

Adrian, what's special in inject or Intel-PT on this?

Thanks,
Namhyung


>
> Signed-off-by: Ian Rogers <irogers@google.com>
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
> 2.42.0.758.gaed0368e0e-goog
>
