Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCBF801FD3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 00:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjLBXzG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Dec 2023 18:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBXzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 18:55:04 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6343BC8;
        Sat,  2 Dec 2023 15:55:11 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58d956c8c38so2217451eaf.2;
        Sat, 02 Dec 2023 15:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701561310; x=1702166110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvPGCQtpM8COGZWcKiIG7o+AKmKAg3mE1nqD/jJyBKM=;
        b=TeTEtjpggNXJQqNW60aYkthEfkil+xaZ3ZXzEUBz2QoX1cBOCa7w4hnq9YSnDxzPcP
         Nf0UDjWX8QqHvD4GmwmuPAGNvGYjNwCmWIx4rXB9av2z+/4bKvA0A6fVj6A7jieHPP3O
         Ky2IU219HNQUdPMoRkeTgXXj98iAPTM0fit7swU92qzM25+nYCG0GW6htDR73EB7F5sv
         ejKK6IjZ/EJY/x06n1cBIuKPfSfrpR5Z/CPLiylqCVPDAtT9fWdmqmm6Gc9QkbbwH+Zv
         oGd6UmwPzLMC4KnzaWev6e9m8jQahqAlK9V0Fcgou2OewkWfrjjMboeA/9BMNSkW6Q0j
         QezA==
X-Gm-Message-State: AOJu0Yzia/HL/Wl6PWuktYg6UD6bIymJTTSTrqTkv3Vw4PRBA6sQPgf8
        /tLBjQeGahSWrM7BegnouIyHc9IeM9tYYWr87LA=
X-Google-Smtp-Source: AGHT+IGurGlqmnhod4tK8Jb8JdU1RIuFoNdl9Di3c9eU9P3CQz3pjxz7wUt6N6oWAtWaOt8bhYyoUuQn1/D6sql+euw=
X-Received: by 2002:a05:6358:7e98:b0:16e:283:665d with SMTP id
 o24-20020a0563587e9800b0016e0283665dmr2591404rwn.15.1701561310428; Sat, 02
 Dec 2023 15:55:10 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-2-irogers@google.com>
 <CAM9d7cjCO8e7nbrtrcy4rsbexemQ94=XK+b5byMFFTDDgoJ2eg@mail.gmail.com> <CAP-5=fUBr60o22P4Op-J=TPkdfnby9vLetHQZ4UqjuX+nvbG9w@mail.gmail.com>
In-Reply-To: <CAP-5=fUBr60o22P4Op-J=TPkdfnby9vLetHQZ4UqjuX+nvbG9w@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 2 Dec 2023 15:54:59 -0800
Message-ID: <CAM9d7cjO2vxa_bvKFrVpX2PViHqZy_dtyf28EaSACwKv6BEHiw@mail.gmail.com>
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

On Thu, Nov 30, 2023 at 10:28 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Nov 29, 2023 at 4:56 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Nov 27, 2023 at 2:09 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > The rwsem is only after used for writing so switch to a mutex that has
> > > better error checking.
> > >
> > > Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mutex")
> >
> > I think we talked about fixing this separately, no?
>
> Sorry, I'm unclear on an action to do. Currently changing the
> RWS_ERRORCHECK in tools/perf/util/rwsem.h will break the build without
> this change.

Can it be like this?

#ifdef RWS_ERRORCHECK
#define RWSEM_INITIALIZER  { .lock = PTHREAD_MUTEX_INITIALIZER, }
#else
#define RWSEM_INITIALIZER  { .lock = PTHREAD_RWLOCK_INITIALIZER, }
#endif

>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/comm.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> > > index afb8d4fd2644..4ae7bc2aa9a6 100644
> > > --- a/tools/perf/util/comm.c
> > > +++ b/tools/perf/util/comm.c
> > > @@ -17,7 +17,7 @@ struct comm_str {
> > >
> > >  /* Should perhaps be moved to struct machine */
> > >  static struct rb_root comm_str_root;
> > > -static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,};
> > > +static struct mutex comm_str_lock = {.lock = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP,};
> >
> > IIUC it has a problem with musl libc.  Actually I think it's better to
> > hide the field and the pthread initializer under some macro like
> > MUTEX_INITIALIZER or DEFINE_MUTEX() like in the kernel.
>
> Will there be enough use to justify this? I think ideally we'd not be
> having global locks needing global initializers as we run into
> problems like we see in metrics needing to mix counting and sampling.

I don't know but there might be a reason to use global locks.
Then we need to support the initialization and it'd be better
to make it easier to handle internal changes like this.

Thanks,
Namhyung
