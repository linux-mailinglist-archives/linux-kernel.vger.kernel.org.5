Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9287C58E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjJKQKG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 12:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJKQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:10:05 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395529D;
        Wed, 11 Oct 2023 09:10:04 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-58907163519so5286778a12.1;
        Wed, 11 Oct 2023 09:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697040603; x=1697645403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZ+VIPsKS+z6FGqu1gSOMc5oXv3t+KffR0mpRHqGu2k=;
        b=Qnt7cxb2+eM6qJMUL016LqFSXptG2Bhc10IkBoSkIvA0rBgbQeju1cWpAjAOmjrDIC
         IpkapYAM3PsCniNBB2Bj/b4JJZfU68AxrgdlzHBSDmCIo1QReWXjr3oIhUqWcfhUo3Q/
         xk8IwzB3adxgtfWLjb+p64S8DW0VnSPbUDk/vWV9va/ZL02QL9SiKGIhhskmUt1INn9H
         Zs84ctjkeucnb82tt7FKaNM/ZLb5hdevIpIxMWhXhfp+cwPK8fLCaRXKUjzcjc28pCxT
         coZJczebIVxz7My3c1byKN2QYYeciOG862///+FQN0vOJdb0xD7caXHSlzVIoL1NaRSc
         blhA==
X-Gm-Message-State: AOJu0Yxwxb9BeyQWRiDNYbEWd32jpJxv8lPb2RQ2VPqsFhXkuEtzN8yi
        4OZYSoiNVhxXSAlb3AXrrGNta7abSGFGlAJo9Ds=
X-Google-Smtp-Source: AGHT+IHnjfzk1SghAsiF23/gGQQawTqA4BpkDSmSW28ox1CFLYnmzEXivE6eYPQlyskK5f+u1Eo/7e7ICRMkd0hM8rU=
X-Received: by 2002:a17:90b:ecc:b0:27d:a59:ebae with SMTP id
 gz12-20020a17090b0ecc00b0027d0a59ebaemr1571538pjb.46.1697040603539; Wed, 11
 Oct 2023 09:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <CAL715WJxmMbXkZSE3p_+ODGxabgrXREsBo9aFu9G9=qkYZeH9A@mail.gmail.com>
 <CAP-5=fUjNiDv=KQ7t8jqfOfOt5i8HGvt8Vv1hn2-hLxX_Kqucg@mail.gmail.com>
 <CAL715W+GQuCJm-1SEsNN2qnHghNL1SrzwH9Km5K8UxubEFfYVw@mail.gmail.com>
 <CAM9d7cgKWi0fafwTxSrKLrVZxcwnhwMGz=oNkAsNdOjDwF6pEA@mail.gmail.com>
 <CAP-5=fWXXi7Y=6Q0k8oLOZmYon+vvg-k4dNUSex_ijcL8ti9sQ@mail.gmail.com> <CAL715WJ8w+q_=0_NVZJ=rs0GLs=pYqDiRLcCxxO0gDcGdcvZnw@mail.gmail.com>
In-Reply-To: <CAL715WJ8w+q_=0_NVZJ=rs0GLs=pYqDiRLcCxxO0gDcGdcvZnw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 11 Oct 2023 09:09:51 -0700
Message-ID: <CAM9d7ci-G-+FFPsKbMzzSzCr2kS75axYHFDm2=f6TxUk=dM_CA@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To:     Ian Rogers <irogers@google.com>, Mingwei Zhang <mizhang@google.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Jihong <yangjihong1@huawei.com>,
        Stephane Eranian <eranian@google.com>
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

On Tue, Oct 3, 2023 at 4:20 PM Mingwei Zhang <mizhang@google.com> wrote:
>
> On Tue, Oct 3, 2023 at 3:36 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Oct 3, 2023 at 1:08 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > On Wed, Sep 20, 2023 at 10:05 PM Mingwei Zhang <mizhang@google.com> wrote:
> > > >
> > > > On Mon, Sep 18, 2023 at 3:43 PM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > On Sat, Sep 16, 2023 at 5:46 PM Mingwei Zhang <mizhang@google.com> wrote:
> > > > > > Thank you very much for the change. I have one quick question about
> > > > > > the PMU unthrottling logic. When I am looking into the function
> > > > > > perf_adjust_freq_unthr_context(), I see the loop with PMU stop and
> > > > > > start in each iteration. Is there a good way to avoid this PMU reset
> > > > > > operation while quickly figuring out the event in frequency mode?
> > > > >
> > > > > Agreed. I think before the pmu_disable could be avoided for this condition:
> > > > > ```
> > > > > if (event->hw.interrupts != MAX_INTERRUPTS &&
> > > > >     (!event->attr.freq || !event->attr.sample_freq))
> > > > >         continue;
> > > > > ```
> > > > > Fixing up the event stop/start looks harder.
> > > > >
> > > >
> > > > Right, I think putting the check early before pmu_disable() is already
> > > > a great optimization. The only concern I initially had was whether
> > > > event->hw.interrupts can be accessed before we disable the pmu. But
> > > > after checking this field in other locations, I don't see any problem
> > > > at all.
> > >
> > > The event->hw.interrupts would be increased in the NMI handler
> > > so there is a race between the check and the NMI.  That's why
> > > I think it checks that after disabling the PMU.
> > >
> > > But I think we can skip non-sampling events for sure.  Then it
> > > would be better to set attr.sample_period = 0 rather than attr.freq.
> > >
> > >     if (!is_sampling_event(event))
> > >         continue;
> > >
> > >     perf_pmu_disable(event->pmu);
> > >     ...
> > >
> > > Thanks,
> > > Namhyung
> >
> > With the PMU disabled, isn't there still a risk of an interrupt still
> > being in flight? In other words the disable doesn't prevent a race and
> > we'll catch this on the next timer call to
> > perf_adjust_freq_unthr_context. I think we can also improve the code
> > by just disabling a PMU once, we can take advantage of the
> > perf_event_pmu_context and disable that PMU, iterate its events and
> > then re-enable the PMU - i.e. no need for an enable and disable per
> > event. I'll put a patch together.
> >
> > Thanks,
> > Ian
>
> +Jim Mattson
>
> I initially thought this idea was just an alternative, or a more
> professional fix in the perf subsystem. I was wrong...
>
> This would be way better than just skipping frequency events in the
> loop. Since if we just skip by event, we may still suffer from huge
> overhead if the event list contains many sampling events in frequency
> mode. Unfortunately, that is the general case when we do perf record
> -e 'eventlist' (IIUC all events in eventlist are in frequency mode if
> we don't specify period=). So the problem actually remains whenever we
> do perf sampling unless we use something like Intel vtune.
>
> On the other hand, since all of the events are presumably CPU core
> events, with the fix we pay only once for the PMU reset per hrtimer
> regardless of how many events are in frequency mode.
>
> Looking forward to the patch! Please keep us posted if possible.

Any updates?

Thanks,
Namhyung
