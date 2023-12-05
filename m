Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D16805E78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjLETRd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 14:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLETRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:17:33 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FFFB0;
        Tue,  5 Dec 2023 11:17:39 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28655c04da3so95679a91.0;
        Tue, 05 Dec 2023 11:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701803859; x=1702408659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXBiIXlKu8GW4mGSuIFbzqKH38JH4fDxyZeOxdEM3gU=;
        b=v8SzcUtejv7XChPD0YoMiC6YAknqr3jbdiBHjMb/obnzp3EfZDeoJOQuVMX8qT0Jgj
         mmve5RFhV2MR2oVgl1lz5cwAwEm3L7PQI8k+EDPHeFED0ttISlgMVKR2jyjNTLhaFuV0
         41aN7qpm4mZBiEPom0ShbTmUyf+vhv0C1dj5rwSWjSj4jFpxWv1ROmnMA0YKPoQqs8Ps
         LmEUvfTYR+10Gs1fSCVQkwy1rOKhFnBadgU8HMsmHs6Ghd/WQlzwZ8KXrkuPoPVZJYw3
         F2nl+wXmxlp/SI1kWTS/dosTms0IqhpBGhk8C5lpGrAXP9jmaOBS/ZoIWQiOknvEdQPA
         SI5A==
X-Gm-Message-State: AOJu0YyRdfMk635lUr1V/7rXelpU1l9e0Rp+uYCeUS4GX2zgmTdL+oQb
        dOCZULNd2DXoCT7XvVNp1cWjJ11cp6BA+H+kUHA=
X-Google-Smtp-Source: AGHT+IGa383Hsj5ouxkFRWPa61WPqMdJIgEOBkSdR25/Tn0rFxsEYe2V9LWeG1mtbiLY2/Y+YfDIf1Gj5/qi6TL2nOY=
X-Received: by 2002:a17:90b:4c12:b0:286:6cd8:ef18 with SMTP id
 na18-20020a17090b4c1200b002866cd8ef18mr1870386pjb.48.1701803858960; Tue, 05
 Dec 2023 11:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20231204182330.654255-1-irogers@google.com> <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
 <CAM9d7ci=Tk845H3x3KMDu-hTdP-u0O6a8D3iAa8EnFLLjOO6OQ@mail.gmail.com>
 <ZW9G8Clxwl6bd0H6@kernel.org> <CAM9d7ciOp_O5N1TDX0HyKavykirByAYrqzcmM-_6ZWjMv-47WQ@mail.gmail.com>
 <ZW9whqUEILWMdcmi@kernel.org> <CAM9d7ciqm2NLt5kxjVdOP2y-KV30_CRsSjHpcQgntvNGWukx9g@mail.gmail.com>
 <CAP-5=fXpsGNVfz+jyu7A=uhrJVQ2xeQ_Forq7CJ4YSjFp-UWnw@mail.gmail.com>
In-Reply-To: <CAP-5=fXpsGNVfz+jyu7A=uhrJVQ2xeQ_Forq7CJ4YSjFp-UWnw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 5 Dec 2023 11:17:27 -0800
Message-ID: <CAM9d7cgRvyCyNowzx15AakorV7-D4h28NqHAei_tLFFw9D3euA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup
 isn't set
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 11:15 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Dec 5, 2023 at 11:11 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Dec 5, 2023 at 10:48 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:

> > > "perf list: Fix JSON segfault by setting the used skip_fuplicate_pmus callback"
> > >
> > > The original description was vague, improving it a bit like that helps
> > > when just looking at the output of "git log --oneline".
> >
> > Done and pushed to tmp.perf-tools!
>
> Thanks Namhyung, there was a typo in Arnaldo's commit message
> "s/fuplicate/duplicate/" could you fix?

Oops, fixed now.  Thanks for checking.
Namhyung
