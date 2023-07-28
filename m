Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD93767158
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbjG1QB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjG1QBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:01:25 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B80C3C34
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:01:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40550136e54so352631cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690560083; x=1691164883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZH6nQn01C8Sr35XvItongnJrzthU2bVlvOmhLP0Vz4=;
        b=efVlqDVSjL6hA7pH00Obl7K/hepyTwEAmwJ9S77NzwRdLZhvsACfpPSV/UEEDWueDO
         WqpN1pZSCukYdKhuENE81FkCJ41Or7iSNohh3brPPiPR/EJcdFWXy3CxD1/Ezu2LfaMJ
         dDIqc7PSfthEwCbT4aH/hWJxzMmziJXj074F6WkoQ0jMqgjGNCTFB8lMxYCoB6mxTa6v
         TFXANH5T2OzmoPWaxtENtjUldT8CS6rV6cyAGsqj4i7z0uhCJVJK++r+84cErubxBpJS
         THtb+DI/cGVHK6IKxTtJHZVYVM+A/wShTe8cBebMKoPDyvb8rij1DmDWRBAMYmW4tR3S
         hVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690560083; x=1691164883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZH6nQn01C8Sr35XvItongnJrzthU2bVlvOmhLP0Vz4=;
        b=l0b/3G7a6QLsLZzFZTVfhJLQB5qIO3EEmB0jW2ifVDse4rU1+2N7iZcia7eUwP2YzY
         8BEey3n6abn8Uw3+aVaGISNBrxQMHIrD2HHfsbwKOAdZmwcUD1gfEgNb36XEneT0QeSv
         etjhvKbb7obDCfQa+SwGgUT/7xDvg7rYJi+H37L1XVj9v4AVVGrtVJ9CjLwFTzrXNe6Z
         rJGtdHy/z8tRXmZiv2gT7BG1P1rJ6YIfr4jEzOiXqv94ABRg1SKGPJv757UzWi2103m7
         MBDnFOkheDHTGzaW4BKetZqPGoLbxGauIApFJ8aeI0zMrXR2FJOX15e7ilSq2C4lJ3z4
         9S7g==
X-Gm-Message-State: ABy/qLZwRKd3jzuEsgrTZ8GCwol2/HfPZuttEY34njCXbBGUjvHhOO4m
        5R7pyfBcbtQtO9g6HlG6VumF3g1IcScL6jtdqcAivhucRxIeffthzrYhUw==
X-Google-Smtp-Source: APBJJlGz8xBM5B0JACXOlDeDiPzvNUvs8ZfSUITEkeaXWUnL/b+pJDlsmnUkdUfhBNfddso1uEi2UhmOVMqQozMD6zs=
X-Received: by 2002:a05:622a:15d2:b0:3f5:2006:50f1 with SMTP id
 d18-20020a05622a15d200b003f5200650f1mr318937qty.12.1690560083088; Fri, 28 Jul
 2023 09:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230725061649.34937-1-adityag@linux.ibm.com> <ZMPWk5K63tadmDlU@kernel.org>
In-Reply-To: <ZMPWk5K63tadmDlU@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 28 Jul 2023 09:01:11 -0700
Message-ID: <CAP-5=fW1zkpJ4zr4ngz=6bZQuE6hOHo4AtXwUsVJK9oiDSc_mg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tests task_analyzer: Check perf build options
 for libtraceevent support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Aditya Gupta <adityag@linux.ibm.com>, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 7:54=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jul 25, 2023 at 11:46:49AM +0530, Aditya Gupta escreveu:
> > Currently we depend on output of 'perf record -e "sched:sched_switch"',=
 to
> > check whether perf was built with libtraceevent support.
> >
> > Instead, a more straightforward approach can be to check the build opti=
ons,
> > using 'perf version --build-options', to check for libtraceevent suppor=
t.
> >
> > When perf is compiled WITHOUT libtraceevent ('make NO_LIBTRACEEVENT=3D1=
'),
> > 'perf version --build-options' outputs (output trimmed):
> >
> >        ...
> >          libtraceevent: [ OFF ]  # HAVE_LIBTRACEEVENT
> >        ...
> >
> > While, when perf is compiled WITH libtraceevent,
> >
> > 'perf version --build-options' outputs:
> >
> > ...
> >          libtraceevent: [ on ]  # HAVE_LIBTRACEEVENT
> >        ...
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >
> >  tools/perf/tests/shell/test_task_analyzer.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/=
tests/shell/test_task_analyzer.sh
> > index 0095abbe20ca..a28d784987b4 100755
> > --- a/tools/perf/tests/shell/test_task_analyzer.sh
> > +++ b/tools/perf/tests/shell/test_task_analyzer.sh
> > @@ -52,7 +52,7 @@ find_str_or_fail() {
> >
> >  # check if perf is compiled with libtraceevent support
> >  skip_no_probe_record_support() {
> > -     perf record -e "sched:sched_switch" -a -- sleep 1 2>&1 | grep "li=
btraceevent is necessary for tracepoint support" && return 2
> > +     perf version --build-options | grep HAVE_LIBTRACEEVENT | grep -q =
OFF && return 2
> >       return 0
>
> I'll apply this, but please consider adding a:
>
>         perf build --has libtraceevent

That's a nice idea. You mean add a script like perf-archive.sh?
Perhaps this flag should be supported by perf version instead.

Thanks,
Ian

> subcommand to have that query made more compact and to avoid the two
> extra grep.
>
> BTW, I'll change that to:
>
> [acme@quaco perf-tools-next]$ perf version --build-options | grep " on .*=
 HAVE_LIBTRACEEVENT"
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> [acme@quaco perf-tools-next]$
>
> replacing "on" with OFF, so that we have just one grep.
>
> Thanks,
>
> - Arnaldo
>
> >  }
> >
> > --
> > 2.41.0
> >
>
> --
>
> - Arnaldo
