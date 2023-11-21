Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFACC7F39FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjKUXCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbjKUXCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:02:02 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37F7DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:01:58 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-28396793876so3993721a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700607718; x=1701212518; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q274GXv74+m8N7WixAqPtztHuSezd+UPyNtaPdOC9ws=;
        b=bYvJCVoxA0rNkHGpfPGECOPagqBCKIl/2G6uLxM4zE+g99RdmXdzjSmfO9z8f73Nyk
         4jHwIr7oWUWPpir+xc1NXaNz1COCzDYL+21RdNMxJQmdJ/takOyPfCvN0oEsWQ81x7s9
         g4WWFduBxgndAkS8f8TYh3+eRhCNT7wG77IGLpKJlhVoztA4YFOdjSVrvCcLXhVW8GN/
         tm5To+QGGWvXGjjmZJH0z617qwpqalHb/fv8tfM9JiJUdP1J93zHfLNbSE99x8W2pzIX
         9RxogWNBu6M311iJEv/u7bPqKPhkmLUzFkDrebThA0rKvxlyal2l3FIVVJPg2hpheqvg
         DuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700607718; x=1701212518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q274GXv74+m8N7WixAqPtztHuSezd+UPyNtaPdOC9ws=;
        b=Kv+0AP6IhWzvc2wHdQF+OpDQFFbBBxH1yVua5/0VEASqQhhAMp8v9StvWBIZNYRYlY
         uPdsGFpsBs06bm9Cb5/fbVQl4zdhLNzmM2FTN1HwXIpN1IFvMvP+BhFDQ6miAe9wV8J1
         Zx3j9xkGoGwvOIaooUI2456T9uISm4qz0ODIHS0rIB7jDzb40I2fL9jF6jTTGmcxFyhW
         CJW/hZOcXuEyXWs4na7zxhAhXNC7cIgNgF2VC7/TVtwVcQKwxHBOzkTpyOkc1wtRetQA
         LF92JSAOKmdbKSme/fTGVuk/p5BKlFCoLGNaOz3g5J506BlqXZ8ZozYHRoiuQed7Y3YK
         FESA==
X-Gm-Message-State: AOJu0YxY7GMw8i+aFneV+6TsC6f2zhMF/t+aklaMXMD0Ycltn7o/C8Hn
        GFAy1zae1FnHEZm9keEOGOs2KQ==
X-Google-Smtp-Source: AGHT+IF4uzhe1PzbxwaRnrKdideD6jqUSRCFck+9VbyO0iaOVvG1KziLM3y7sB3tdsbSvhW8QV4jXw==
X-Received: by 2002:a17:90a:eb8a:b0:280:5e8:58be with SMTP id o10-20020a17090aeb8a00b0028005e858bemr571458pjy.48.1700607717789;
        Tue, 21 Nov 2023 15:01:57 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id h1-20020a17090acf0100b002791d5a3e29sm55269pju.6.2023.11.21.15.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 15:01:57 -0800 (PST)
Date:   Tue, 21 Nov 2023 23:01:53 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH 1/3] perf/core: Update perf_adjust_freq_unthr_context()
Message-ID: <ZV024X0VKUwExQio@google.com>
References: <20231120221932.213710-1-namhyung@kernel.org>
 <CAP-5=fWFeqEK4woCj2ngjxMi4B4EZ3y0gLN+qNu4oNfp4wG8xA@mail.gmail.com>
 <ZVvqj0pR2ZebBF3L@google.com>
 <CAM9d7cgAPxyNxMTz-uoPExcg4e1h5iXCuR5ZOy7UUt5gjbd2VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgAPxyNxMTz-uoPExcg4e1h5iXCuR5ZOy7UUt5gjbd2VA@mail.gmail.com>
X-Spam-Status: No, score=-16.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023, Namhyung Kim wrote:


Hi Namhyung,

> Hi Mingwei,
> 
> On Mon, Nov 20, 2023 at 3:24 PM Mingwei Zhang <mizhang@google.com> wrote:
> >
> > On Mon, Nov 20, 2023, Ian Rogers wrote:
> > > On Mon, Nov 20, 2023 at 2:19 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > It was unnecessarily disabling and enabling PMUs for each event.  It
> > > > should be done at PMU level.  Add pmu_ctx->nr_freq counter to check it
> > > > at each PMU.  As pmu context has separate active lists for pinned group
> > > > and flexible group, factor out a new function to do the job.
> > > >
> > > > Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
> > > > even if it needs to unthrottle sampling events.
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > > Series:
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> > > Thanks,
> > > Ian
> > >
> >
> > Can we have "Cc: stable@vger.kernel.org" for the whole series? This
> > series should have a great performance improvement for all VMs in which
> > perf sampling events without specifying period.
> 
> I was not sure if it's ok to have this performance fix in the stable series.
> 

Critical performance bug fix is ok to be added to stable tree, as the
requirements are mentioned here:

https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst

In particular, this patch satisfies the 2nd sub-bullet of the forth
bullet.

But let me step back. Only this patch is needed with stable tag instead
of the whole series. This patch impact 69 lines of code. It satisfies
the rule of within 100 lines (bullet 3).

I will give a try and test it today or tomorrow and make sure we satisfy
bullet 2.

Once it gets in, bullet 1 will be satisfied as well.

Overall, the intention is to improve PMU performance in VM as early as
we can since we don't control the schedule of distro kernel upgrade and
we don't control when end customers upgrade their running kernel. So I
presume even adding to the stable tree may take years to see the result
change. But if we don't do it, it may take way longer (since it does not
contain a "Fixes" tag as well).

Thanks.
-Mingwei

> Thanks,
> Namhyung

