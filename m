Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677027C74DD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347328AbjJLRga convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 13:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347407AbjJLRgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:36:16 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81519B;
        Thu, 12 Oct 2023 10:23:12 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so1060861b3a.0;
        Thu, 12 Oct 2023 10:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131392; x=1697736192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2huTdw8gv98PUVaCLOU6DBAj+aarMGXn0Df0CI62RjM=;
        b=Ta+HKXRcSd74lXModIUNcmzoJ2sIxzZcHFQ5mlOlZwy9M2K/1gyvRDMIGoleJW65zj
         5Jftra1mmlQwfWvuyqUruJMPdhqnAjnbg+dcADmygl9MUPX5Ho/pBT/GYuEewcGbC5qI
         cE7DrmnwuL7pEG5Z3+GHSvPUWwmKLx7O7iHelNg/FxJnbBuoqvtWyLgtd7WUc6ryS3HK
         1X/1ryJ0DwXCLBV+/KIvv5pFpXUeCj5B2uprAFR4IgEQAfF2NtmqsDBb45uXRNzsltvc
         pbha4o7+8U3ZQSfgkeUpxxlxjb7ohTjg2btD0XtFrWyCsU9WJfD5JKTwiPupXIZyTkqY
         ixmw==
X-Gm-Message-State: AOJu0YxsdQjJSQekg3G4FDZHkumLsLILIdXVuDfn5dS14H1jqvU2p9Wg
        WKUFJBt1rWMG0sRxwPmfXNdCmsmdgD5fON7+oNs=
X-Google-Smtp-Source: AGHT+IHtewc5TpplcEEAEnaPHRXHWJ0T7pd74csLwuQjugub3DppU6ULdyFpJWb7QI0YjD5qnRhOteXVwbzBrWaFH90=
X-Received: by 2002:a05:6a20:7f83:b0:15e:b8a1:57b9 with SMTP id
 d3-20020a056a207f8300b0015eb8a157b9mr30329596pzj.24.1697131391926; Thu, 12
 Oct 2023 10:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230928004431.1926969-1-irogers@google.com> <CAP-5=fW6dBQQ7XnDm+Ye7R2bksNrWWwZJ+X33QnDvcjqjgtU5Q@mail.gmail.com>
In-Reply-To: <CAP-5=fW6dBQQ7XnDm+Ye7R2bksNrWWwZJ+X33QnDvcjqjgtU5Q@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 12 Oct 2023 10:23:00 -0700
Message-ID: <CAM9d7cjMraYFyx4v6ahVJ56ys0Kq769yzzNeO+bQ2my0y2=Jsg@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Fix for term values that are raw events
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 3:13 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Sep 27, 2023 at 5:44 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Raw events can be strings like 'r0xead' but the 0x is optional so they
> > can also be 'read'. On IcelakeX uncore_imc_free_running has an event
> > called 'read' which may be programmed as:
> > ```
> > $ perf stat -e 'uncore_imc_free_running/event=read/' -a sleep 1
> > ```
> > However, the PE_RAW type isn't allowed on the right of a term, even
> > though in this case we just want to interpret it as a string. This
> > leads to the following error on IcelakeX:
> > ```
> > $ perf stat -e 'uncore_imc_free_running/event=read/' -a sleep 1
> > event syntax error: '..nning/event=read/'
> >                                   \___ parser error
> > Run 'perf list' for a list of valid events
> >
> >  Usage: perf stat [<options>] [<command>]
> >
> >     -e, --event <event> event selector. use 'perf list' to list available events
> > ```
> > Fix this by allowing raw types on the right of terms and treat them as
> > strings, just as is already done for PE_LEGACY_CACHE. Make this
> > consistent by just entirely removing name_or_legacy and always using
> > name_or_raw that covers all three cases.
> >
> > Fixes: 6fd1e5191591 ("perf parse-events: Support PMUs for legacy cache events")
> > Signed-off-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!
