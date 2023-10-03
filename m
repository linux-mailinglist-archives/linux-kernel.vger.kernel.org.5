Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293FF7B5FAF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbjJCELB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 00:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjJCEK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:10:59 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E8FA1;
        Mon,  2 Oct 2023 21:10:55 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3ae65e8eb45so316000b6e.1;
        Mon, 02 Oct 2023 21:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696306255; x=1696911055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtulQHPAbaWeljs345WA/V0ckv6ygveCfUecnvBzx/Y=;
        b=G6Xvutkr8alX72OsnQHL28HiVVfJP4wC0+yRhYWixab/Sr9L9Z+AiOypAh2o5TuhX8
         27mYWQ83FdgFqJSt0C22Q0wpYnWT0MiGsq2D+jMaQUlynGEK2SNl5+6001lKMqyissvd
         rKsz8cMRpVd5ks7aqgh+k0MqTp73FlITwORr/4c9TeyuxkTUn78uiqnJrgkDnEFhGSkZ
         uET82NAFvTUMT6jrXoZ8JwsToK/1T7XHNcCnqqu7e2kbpqMe52ywuvemDAabsaP3uvP7
         3jKcI2LT1pPYz7ZmdCM+wNwbj+6GdXOaCTkgR463p7RNzFlpC40XWFpQkyFenrH32eP5
         R0hw==
X-Gm-Message-State: AOJu0Ywt9gTNvY0llfd4cwf0kXDeLknYQT8MZ36yIphn+XzzBiiyvG4X
        JXMXgPYRvPeKFHSBQGDx3VJpRG596z6++cIsPAo=
X-Google-Smtp-Source: AGHT+IFNfQWSTfwTDLDY10LA9umKMRMqQvq4o6bJBU7kUrBOugNYs+qfQCBwasfHDg92ArEi0lV7HC99vAap2dZhvRU=
X-Received: by 2002:a05:6808:f90:b0:3af:9fc4:26c6 with SMTP id
 o16-20020a0568080f9000b003af9fc426c6mr2718038oiw.20.1696306254776; Mon, 02
 Oct 2023 21:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230925062323.840799-1-irogers@google.com> <CAM9d7chaKGciJgDLyN1hhDXNuFuCHRFcYAjTHY0bEMKpfBDZBg@mail.gmail.com>
 <CAP-5=fUqVB7W+a3o72VrhccWbos_XDu=jc53TmEZC26h_hBacA@mail.gmail.com>
In-Reply-To: <CAP-5=fUqVB7W+a3o72VrhccWbos_XDu=jc53TmEZC26h_hBacA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 2 Oct 2023 21:10:43 -0700
Message-ID: <CAM9d7cieEnuVZ7S0Yab6c3N=qKqgNSP3DL2JNFje1HFA7dcTtA@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmus: Make PMU alias name loading lazy
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:19 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Sep 27, 2023 at 10:00 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Sun, Sep 24, 2023 at 11:24 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > PMU alias names were computed when the first perf_pmu is created,
> > > scanning all PMUs in event sources for a file called alias that
> > > generally doesn't exist. Switch to trying to load the file when all
> > > PMU related files are loaded in lookup. This would cause a PMU name
> > > lookup of an alias name to fail if no PMUs were loaded, so in that
> > > case all PMUs are loaded and the find repeated. The overhead is
> > > similar but in the (very) general case not all PMUs are scanned for
> > > the alias file.
> > >
> > > As the overhead occurs once per invocation it doesn't show in perf
> > > bench internals pmu-scan. On a tigerlake machine, the number of openat
> > > system calls for an event of cpu/cycles/ with perf stat reduces from
> > > 94 to 69 (ie 25 fewer openat calls).
> >
> > I think the pmu-scan bench could show the difference as it
> > calls perf_pmu__destroy() in the loop body.  So every call to
> > perf_pmu__scan() should start from nothing, right?
>
> The PMU alias name list was funny. It is/was maintained in the x86
> specific PMU code and the destroy didn't clear the list. This change
> adds an openat to loading a PMU for the alias, so pmu-scan shows a
> very small slow down. However, in the more normal cases we're reducing
> the number of openats by 25%.

I think that's ok.  Applied to perf-tools-next, thanks!
