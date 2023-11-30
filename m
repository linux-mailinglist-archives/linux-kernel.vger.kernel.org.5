Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40E47FE522
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjK3Az6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 19:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjK3Az5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:55:57 -0500
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE894D66;
        Wed, 29 Nov 2023 16:56:03 -0800 (PST)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c6263fce87so86548a12.0;
        Wed, 29 Nov 2023 16:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701305763; x=1701910563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmiAKCI1fSv/7HCnkC6OaMmQ8+p+YKtjiHGASgJDn84=;
        b=s/EE4uc3SQcyZYfgKlUNJSNAhJMH3sZWMO6uut7RMCmJrwvkFlDDlxaMAgWzENNu4H
         +AnxguUCeTN48ljQLyQirjiXRYpkbHpjHBFlbBMw46JMQa2vrONajY+BRNtYKmNU6qoG
         oK74Fdp8FiSNKBFdiQ1DNlkGrFR/em0Yf/jQBxAxJB5pOX4QUXB/Zi6ERWlKIzcqzsUm
         6+HBJz7GD9u4RzukzvfnSLC32X8sxuY30edBkLKEF6Wu55HxVRiDUZT98uUocNcadDpb
         QlcLQo7mWQ+j199iv7KuI0ADqnVVdmQylojc5uUz4MqW33uBpKYczDdVGtmZveFtpyc0
         YWCw==
X-Gm-Message-State: AOJu0YwVbnMit9cOpcE7PyBtxoO8CkfwqvTg+KpUjpXa3SMnJsJdw/Oy
        U2c+4WFpy6N1fWo2SDGU8W9zraThMQZqnabuyeQ=
X-Google-Smtp-Source: AGHT+IHza8dNTvmjlkCVaw8H+Dj7D7xGV1OOxGXgTsQ18HrQy5bBI0i6eDlyG37Doh8ih/q3/oM43lBtWeKlyhTqIl4=
X-Received: by 2002:a17:90b:310d:b0:286:1809:1517 with SMTP id
 gc13-20020a17090b310d00b0028618091517mr6586512pjb.7.1701305763212; Wed, 29
 Nov 2023 16:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-2-irogers@google.com>
In-Reply-To: <20231127220902.1315692-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 16:55:52 -0800
Message-ID: <CAM9d7cjCO8e7nbrtrcy4rsbexemQ94=XK+b5byMFFTDDgoJ2eg@mail.gmail.com>
Subject: Re: [PATCH v5 01/50] perf comm: Use regular mutex
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
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
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

On Mon, Nov 27, 2023 at 2:09 PM Ian Rogers <irogers@google.com> wrote:
>
> The rwsem is only after used for writing so switch to a mutex that has
> better error checking.
>
> Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mutex")

I think we talked about fixing this separately, no?


> Signed-off-by: Ian Rogers <irogers@google.com>
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

IIUC it has a problem with musl libc.  Actually I think it's better to
hide the field and the pthread initializer under some macro like
MUTEX_INITIALIZER or DEFINE_MUTEX() like in the kernel.

Thanks,
Namhyung

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
> 2.43.0.rc1.413.gea7ed67945-goog
>
