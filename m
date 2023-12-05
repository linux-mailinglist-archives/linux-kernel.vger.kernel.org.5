Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51090805B95
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346051AbjLERYu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 12:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLERYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:24:48 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE9A196;
        Tue,  5 Dec 2023 09:24:55 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-286bba96e94so1786604a91.1;
        Tue, 05 Dec 2023 09:24:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701797094; x=1702401894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFVQTC1s169ecyWHJH7Eki7EkWCVJgaihSXzOtW52Qk=;
        b=IQ6QW81W+btWJ4CuWapgToo8617vyESK+A3kffvwmtCme1Ib9gpGgpC7P/KHskyodr
         fmDoAWlVoqROFvHr979T2n8eI0hK/+w+Yk4a7qi2NYbzJHOwk4t/A90wPFOCq0jAquTX
         LDLt3QnR08oTzWpIpI5nN+biT58si5WjtIYNcDendnwBCvhzXzsxBmRAGabWy5Mo51rX
         S3hijp098Q2nNqNYWgSiVmmCLwrBlYog4f+1J0c3mxyN0TdDEwkv0S27OUNM1GnWOu+v
         aR4wsuPeN5y7/wG0SaBP1NxXPT5z1UKSXryO/D4SqzhllCzJE18V4qtaCow1WxxDTkTt
         8JsA==
X-Gm-Message-State: AOJu0Yyxbd4JQknhvqQkXtDM1Lq8Ly0xO/yqyRhd7bKQ07asgB+atz50
        nyQvyetRZciegzu7yVIC/KTbN968zlZVQD2qv1g=
X-Google-Smtp-Source: AGHT+IEZpTYw7fSgKbd9dYpxAUnuXkfHH2ctd+T9rSy9hSil2VcNkkGUakgj/GtS6xBfGjTynW4UXwkLl4UxUY1w2pY=
X-Received: by 2002:a17:90a:f00a:b0:286:6cc1:8653 with SMTP id
 bt10-20020a17090af00a00b002866cc18653mr1371402pjb.56.1701797094150; Tue, 05
 Dec 2023 09:24:54 -0800 (PST)
MIME-Version: 1.0
References: <20231204182330.654255-1-irogers@google.com> <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
 <CAM9d7ci=Tk845H3x3KMDu-hTdP-u0O6a8D3iAa8EnFLLjOO6OQ@mail.gmail.com> <ZW9G8Clxwl6bd0H6@kernel.org>
In-Reply-To: <ZW9G8Clxwl6bd0H6@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 5 Dec 2023 09:24:42 -0800
Message-ID: <CAM9d7ciOp_O5N1TDX0HyKavykirByAYrqzcmM-_6ZWjMv-47WQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup
 isn't set
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Arnaldo,

On Tue, Dec 5, 2023 at 7:51 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Mon, Dec 04, 2023 at 07:33:18PM -0800, Namhyung Kim escreveu:
> > On Mon, Dec 4, 2023 at 2:45 PM Ilkka Koskinen <ilkka@os.amperecomputing.com> wrote:
> > > On Mon, 4 Dec 2023, Ian Rogers wrote:
> > > > A metric is default by having "Default" within its groups. The default
> > > > metricgroup name needn't be set and this can result in segv in
> > > > default_metricgroup_cmp and perf_stat__print_shadow_stats_metricgroup
> > > > that assume it has a value when there is a Default metric group. To
> > > > avoid the segv initialize the value to "".
>
> > > > Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgroup")
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
>
> > > Thanks! I was going to look for the bug but got pulled to other
> > > tasks. The patch looks good to me and I tested it successfully on
> > > AmpereOne.
>
> > >    Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>
> > Looks like it needs to go through perf-tools for v6.7.
> > Ian, do you think this one is enough?
>
> So I had this on my local perf-tools-next, removed now, I also have some
> other fixes by Ian on the tmp.perf-tools-next, please let me know what
> you guys decide to have in perf-tools for v6.7 so that I can remove it
> from there.

I think we need this one and the Ampere default-metric-group fix.

https://lore.kernel.org/r/20231201021550.1109196-2-ilkka@os.amperecomputing.com/

Also perf list JSON fix can go to v6.7.

https://lore.kernel.org/r/20231129213428.2227448-2-irogers@google.com/

Thanks,
Namhyung
