Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1197E157F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjKERcD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Nov 2023 12:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjKERcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:32:01 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D558C5;
        Sun,  5 Nov 2023 09:31:59 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1cc3388621cso36816325ad.1;
        Sun, 05 Nov 2023 09:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699205519; x=1699810319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGzs0eC+XvZNsqZVAhz8siBL0+Ri4tF6SqjDCp2N3rM=;
        b=Cmz7xRbjbchBmjj7Upg1vdh+9FSLvNyZE0rB32fYtQsM6iWBwN+iipVJNC1GG2ORA9
         ytSktphaFsnyv5E+xre/7BkNs8tNJShzbQvx87W66RsO8ES6RpT6Yo97U46xgt1Rg5rW
         SLjQVI6wHbNLbTnh+6VReaI1LZOdgfOrLsnk7xjbBHGcYUa3+P3AGj4V27YpsQq4DpLQ
         xfn1mJMKRkP9Gh4wUZPZ05adXi3jleX2qn29iLenz1SWQG4/++cQMPuwLlKrbr91VAMP
         O53uvR+lSQYbSzTrFqqTUcnfye3ePHiUCX2NOv/MywNBcVCo9g2wX2nVS6vrft0hTs60
         +txA==
X-Gm-Message-State: AOJu0YwvTZLwIE9xvaNe9iZTPGZmM4N2J7YpTaQpXitvSG4DTAQtZ7D0
        7LpZocMCXpexHqToP6LBqsd+s8eeZPjAEAvTt4Y=
X-Google-Smtp-Source: AGHT+IHvqsvGkOnAIvltd/Mlz/Cn9JypaVvK40EvlqW6lBxh4IGootFGJhVblyhSbf9QRWHax/Zf0N9I6yn4K3OV2wM=
X-Received: by 2002:a17:903:120e:b0:1cc:2518:ef02 with SMTP id
 l14-20020a170903120e00b001cc2518ef02mr11191699plh.14.1699205518672; Sun, 05
 Nov 2023 09:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-2-irogers@google.com>
In-Reply-To: <20231102175735.2272696-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 5 Nov 2023 09:31:47 -0800
Message-ID: <CAM9d7cgbPGzgc=QG8dStvq1iX8snGyeKTJDrg2XBjX0pCX9Qtg@mail.gmail.com>
Subject: Re: [PATCH v4 01/53] perf comm: Use regular mutex
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

Hi Ian,

On Thu, Nov 2, 2023 at 10:58 AM Ian Rogers <irogers@google.com> wrote:
>
> The rwsem is only after used for writing so switch to a mutex that has
> better error checking.

Hmm.. ok.  It doesn't make sense to use rwsem without readers.

>
> Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mutex")

But I'm not sure this is a fix.  Other than that,

> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/comm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> index afb8d4fd2644..4ae7bc2aa9a6 100644
> --- a/tools/perf/util/comm.c
> +++ b/tools/perf/util/comm.c
> @@ -17,7 +17,7 @@ struct comm_str {
>
>  /* Should perhaps be moved to struct machine */
>  static struct rb_root comm_str_root;
> -static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,};
> +static struct mutex comm_str_lock = {.lock = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP,};
>
>  static struct comm_str *comm_str__get(struct comm_str *cs)
>  {
> @@ -30,9 +30,9 @@ static struct comm_str *comm_str__get(struct comm_str *cs)
>  static void comm_str__put(struct comm_str *cs)
>  {
>         if (cs && refcount_dec_and_test(&cs->refcnt)) {
> -               down_write(&comm_str_lock);
> +               mutex_lock(&comm_str_lock);
>                 rb_erase(&cs->rb_node, &comm_str_root);
> -               up_write(&comm_str_lock);
> +               mutex_unlock(&comm_str_lock);
>                 zfree(&cs->str);
>                 free(cs);
>         }
> @@ -98,9 +98,9 @@ static struct comm_str *comm_str__findnew(const char *str, struct rb_root *root)
>  {
>         struct comm_str *cs;
>
> -       down_write(&comm_str_lock);
> +       mutex_lock(&comm_str_lock);
>         cs = __comm_str__findnew(str, root);
> -       up_write(&comm_str_lock);
> +       mutex_unlock(&comm_str_lock);
>
>         return cs;
>  }
> --
> 2.42.0.869.gea05f2083d-goog
>
