Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1838801FD6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 00:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjLBX4z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Dec 2023 18:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBX4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 18:56:54 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842CDC8;
        Sat,  2 Dec 2023 15:57:00 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58e30de3933so161782eaf.3;
        Sat, 02 Dec 2023 15:57:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701561420; x=1702166220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyAFX5VXBNLiHxSUJrFaDK1h2Fd8kYr2nkmMBD96klk=;
        b=nyLE8eGts8o1gZtnxXDKop+gHfI9GfKD5FVATuhA5ovkRXyJdsbviah2rCwgLytfJI
         Tcen5yRkuQUG9g334YrPAPuFumU6BU12zJl2Xl4sEHe0iy3v7cNO6DVFRUQRGLpOBkZL
         EThsFcuDbgM/Vlf95ykrOGx4FNFslZEabS0yuZFxPfFViRL/+8xaDYVEwbzE+HHPEqoO
         /8Jw+4jChcFoKyXwUB4p6X0i3BwTVd4nziXfHmXMZE7/AX0rlreexS5Ed6+nbe9Q6XQB
         uLkRzNbM5tm+z3MQELeD0m2iP+oIYJCM3LNt+OZwiWiOPFxfMkXi5ES/uelJFhNSTdHf
         ZhDg==
X-Gm-Message-State: AOJu0YzXTkJNsyvDFvor7cQ0+0SpNNEMTC2kUPItAzVkmy2Q3fFuU6YF
        iZ4qvTqghlJN613RxKb6LL7n0CctAC/aAej52wk=
X-Google-Smtp-Source: AGHT+IHvzJ/yen72Iq8iWvF0CMtoAph2WUTrNZS2EDd04xg31B8EzlS/DS+gvHK+cUyAQ9O0zdwCNzqeBe/vXF4cNFo=
X-Received: by 2002:a05:6358:5e14:b0:16f:ffd6:7cd3 with SMTP id
 q20-20020a0563585e1400b0016fffd67cd3mr2207633rwn.6.1701561419684; Sat, 02 Dec
 2023 15:56:59 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-9-irogers@google.com>
 <CAM9d7cjpYHN_Q63sW70vTCisdW=-SzjsrryUUJjgtZ3+9jdxfA@mail.gmail.com> <CAP-5=fXjReF38T_GKohtWd7_7fZjYVnKBj-Fwt+agi1vSWAEdQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXjReF38T_GKohtWd7_7fZjYVnKBj-Fwt+agi1vSWAEdQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 2 Dec 2023 15:56:48 -0800
Message-ID: <CAM9d7chU1Jyurb6bmZOSmeuFky9eN+2Ty7kMrQxyUXN=r0FKvg@mail.gmail.com>
Subject: Re: [PATCH v5 08/50] perf record: Be lazier in allocating lost
 samples buffer
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

On Thu, Nov 30, 2023 at 10:29 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Nov 29, 2023 at 6:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Nov 27, 2023 at 2:09 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Wait until a lost sample occurs to allocate the lost samples buffer,
> > > often the buffer isn't necessary. This saves a 64kb allocation and
> > > 5.3kb of peak memory consumption.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-record.c | 29 +++++++++++++++++++----------
> > >  1 file changed, 19 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > index 9b4f3805ca92..b6c8c1371b39 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -1924,21 +1924,13 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
> > >  static void record__read_lost_samples(struct record *rec)
> > >  {
> > >         struct perf_session *session = rec->session;
> > > -       struct perf_record_lost_samples *lost;
> > > +       struct perf_record_lost_samples *lost = NULL;
> > >         struct evsel *evsel;
> > >
> > >         /* there was an error during record__open */
> > >         if (session->evlist == NULL)
> > >                 return;
> > >
> > > -       lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> >
> > To minimize the allocation size, this can be
> > sizeof(*lost) + session->machines.host.id_hdr_size
> > instead of PERF_SAMPLE_MAX_SIZE.
>
> Sounds good, should probably be a follow up. The current size is
> PERF_SAMPLE_MAX_SIZE.

Yep, I'm ok with having it as a follow-up.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
