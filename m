Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A327D6091
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjJYDnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJYDnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:43:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29C9B4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:42:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a085efa7so1575e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698205377; x=1698810177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXAzKvkf49LfpHocgTsA1yczF93G8HBB7kCYq64Or4M=;
        b=ElsKR7XA3nVm9Ly+MeOdLL+ijvu82n+x1Dfjth4BBMTB4zAB2wFI56Z/wodh5tSqJp
         2djBEn0I7NKaS054dssYhV074q12LVChvo0rgn0KcQuFIIbA82m+4SWNDTJUC8r7Fah8
         8VFTkoEyuP7Y+NPCUA9h3Z8FPDFpmOzAzRm+pOEvVvWzwV0z19Pq/RnrkUbJ5+/n7yga
         L1uF94iX0XoY7mAfHsKbjcBPfU8n44R8OsYDzS/6xzYYNCswLkR9FPR2xCdTQJwtabHr
         C35DwW11C1Oab8xUvAQWdBYFMLXLJHh33HKObcr6RS6GBxn4yYD15moVmgvIjgcUMRvE
         baDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698205377; x=1698810177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXAzKvkf49LfpHocgTsA1yczF93G8HBB7kCYq64Or4M=;
        b=cRFtfILa2sZ+qdgoYLufoWYoFfbxlrNQAsi+mgb4GUzBQA95CnJWT2IKTdhbbrqmDt
         4CnP2DBz8rcz0mANDP+8pKMtuF2rVInT0z+AHpcSGRAORZYTLr9KPULurld13bvZZe+o
         0iUGEHVV4l6u9CePwHk9NsCfy/vZCChdZhKHw3AqBtgyhCe72XQY7Zsxk5pLdM9pPddy
         fazOgsMIYlua1qvllIbi9/UmrEudgvE8m8xDtNhtQ2vL2FfAVdBpvRrbGxJ2GpNb8NJ3
         uhbI2Y5yzcrGhco420CPmbIJDeDVFATeY/fq209rqUmtlXYLGzMbKd2TwaG2/eG2y20S
         bfRg==
X-Gm-Message-State: AOJu0YxroJx18k8RclBgxaXAVSDgYvxSvfzUuzEB8U/hakgcZJaN6xKc
        zCYgbGFRX6Q9RSss3G/xGvPjCrwn0a7eUOhCSry/EQ==
X-Google-Smtp-Source: AGHT+IEFMNrtwoxhkIe+lYAjwXLdHAlBdDt6Lt6R23HObFxvKkIQyZ0SLUIDTj7EuektCSsnZ6B3IWNAv2gbzu9fHR0=
X-Received: by 2002:a05:6512:3582:b0:502:932e:2e36 with SMTP id
 m2-20020a056512358200b00502932e2e36mr25286lfr.2.1698205376825; Tue, 24 Oct
 2023 20:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231025003121.2811738-1-namhyung@kernel.org>
In-Reply-To: <20231025003121.2811738-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 24 Oct 2023 20:42:45 -0700
Message-ID: <CAP-5=fWnD_Ov+rf6sUxrSqu3MSy_TW+xFdD8gXOkz7nn=fUHkg@mail.gmail.com>
Subject: Re: [PATCH] perf report: Fix hierarchy mode on pipe input
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 5:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The hierarchy mode needs to setup output formats for each evsel.
> Normally setup_sorting() handles this at the beginning, but it cannot
> do that if data comes from a pipe since there's no evsel info before
> reading the data.  And then perf report cannot process the samples
> in hierarchy mode and think as if there's no sample.
>
> Let's check the condition and setup the output formats after reading
> data so that it can find evsels.
>
> Before:
>
>   $ ./perf record -o- true | ./perf report -i- --hierarchy -q
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB - ]
>   Error:
>   The - data has no samples!
>
> After:
>
>   $ ./perf record -o- true | ./perf report -i- --hierarchy -q
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB - ]
>       94.76%        true
>          94.76%        [kernel.kallsyms]
>             94.76%        [k] filemap_fault
>        5.24%        perf-ex
>           5.24%        [kernel.kallsyms]
>              5.06%        [k] __memset
>              0.18%        [k] native_write_msr
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-report.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index dcedfe00f04d..ca8f2331795c 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -691,10 +691,25 @@ static int report__browse_hists(struct report *rep)
>
>  static int report__collapse_hists(struct report *rep)
>  {
> +       struct perf_session *session =3D rep->session;
> +       struct evlist *evlist =3D session->evlist;
>         struct ui_progress prog;
>         struct evsel *pos;
>         int ret =3D 0;
>
> +       /*
> +        * The pipe data needs to setup hierarchy hpp formats now, becaus=
e it
> +        * cannot know about evsels in the data before reading the data. =
 The
> +        * normal file data saves the event (attribute) info in the heade=
r
> +        * section, but pipe does not have the luxury.
> +        */
> +       if (perf_data__is_pipe(session->data)) {
> +               if (perf_hpp__setup_hists_formats(&perf_hpp_list, evlist)=
 < 0) {
> +                       ui__error("Failed to setup hierachy output format=
s\n");
> +                       return -1;
> +               }
> +       }
> +
>         ui_progress__init(&prog, rep->nr_entries, "Merging related events=
...");
>
>         evlist__for_each_entry(rep->session->evlist, pos) {
> --
> 2.42.0.758.gaed0368e0e-goog
>
