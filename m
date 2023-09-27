Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D07AFA30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjI0FlG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 01:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjI0Fk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:40:26 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2433C1FFC;
        Tue, 26 Sep 2023 21:39:24 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-79fa891b645so283373939f.0;
        Tue, 26 Sep 2023 21:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695789563; x=1696394363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45TovMKJ+2sZ/qf9Tf9B5Lm13NVNzRdDeG0tap29jvY=;
        b=b1kPI8ib0kqNQUNsS+v/08wbeeuQsdzrscg9u0QdL0SWNyheTzlAEfqeJh3pXcXW6S
         w67oOio8RwzkyuqLRIgKGfnRNGg5L00FKEfu2hI8Mczi22hzJIorCTMa2UWc2969bd7s
         0xujBc0vLRTx2a3nBmMiN/+K6Ch/VpbIO2xyxByEJE9XC9T2HC9/xMmgadHwwid8x07v
         0XSUOS17oF5v9Qcptkqm5Lt9mtTk/cPlexBo502vf8u4W+2O6BoM5ibh6Q+Vxd7I8c+S
         c7vB+q6dv6Fg+pWxyGRs79bbbU3U5u+P/+XSnaJyAMKDpTPSm+0PZXcQrYZWPFQEi1f7
         OV6Q==
X-Gm-Message-State: AOJu0Yxn9nvbrLp8Cz64IlRqJf9R0UBjrHV5H+64++d4l52f5KAOty/P
        Q+Xs3M3nOOzAmKxpW1r8DpwSMCw8wmmvLx83LLu7eScP
X-Google-Smtp-Source: AGHT+IESJPGH4c1MijpOR3/7FVfPcaAnzWVHrEYn2jQP1Nka5jrAX0XhSMO48c92F3PxAh7AYyWYzLAVdeBfasNA688=
X-Received: by 2002:a05:6602:39a:b0:791:1b1c:b758 with SMTP id
 f26-20020a056602039a00b007911b1cb758mr1142220iov.19.1695789563357; Tue, 26
 Sep 2023 21:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230920122349.418673-1-wyes.karny@amd.com> <CAP-5=fUe-972h3+Cwegb6u8ZOxo2k_jHQ3i5gNPoUq_TR_AWDQ@mail.gmail.com>
 <CAM9d7cjH_YR9W_Ab-AuJR983GYn3s+ScwexCWid3Q6a+GzWDVg@mail.gmail.com> <CAP-5=fW7dsMw0i7N-oQ7dcz9sFx1hAtZCpsxuH=NqMz+h+i3ZQ@mail.gmail.com>
In-Reply-To: <CAP-5=fW7dsMw0i7N-oQ7dcz9sFx1hAtZCpsxuH=NqMz+h+i3ZQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 26 Sep 2023 21:39:11 -0700
Message-ID: <CAM9d7cgC8qZ=rN-0qAg0mNOV-XKCLzgJ1E530aexUnsytmrjfw@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: Fix perf stat output with correct scale and unit
To:     Ian Rogers <irogers@google.com>
Cc:     Wyes Karny <wyes.karny@amd.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ravi.bangoria@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Tue, Sep 26, 2023 at 9:07 PM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Sep 26, 2023 at 3:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Sep 20, 2023 at 9:02 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Wed, Sep 20, 2023 at 5:24 AM Wyes Karny <wyes.karny@amd.com> wrote:
> > > >
> > > > The perf_pmu__parse_* functions for the sysfs files of pmu event’s
> > > > scale, unit, per-pkg and snapshot were updated in commit 7b723dbb96e8
> > > > ("perf pmu: Be lazy about loading event info files from sysfs").
> > > > However, the paths for these sysfs files were incorrect. This resulted
> > > > in perf stat reporting values with wrong scaling and missing units. This
> > > > is fixed by correcting the paths for these sysfs files.
> > > >
> > > > Before this fix:
> > > >
> > > >  $sudo perf stat -e power/energy-pkg/ -- sleep 2
> > > >
> > > >  Performance counter stats for 'system wide':
> > > >
> > > >    351,217,188,864      power/energy-pkg/
> > > >
> > > >           2.004127961 seconds time elapsed
> > > >
> > > > After this fix:
> > > >
> > > >  $sudo perf stat -e power/energy-pkg/ -- sleep 2
> > > >
> > > >  Performance counter stats for 'system wide':
> > > >
> > > >              80.58 Joules power/energy-pkg/
> > > >
> > > >              2.004009749 seconds time elapsed
> > > >
> > > > Fixes: 7b723dbb96e8 ("perf pmu: Be lazy about loading event info files from sysfs")
> > > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Applied to perf-tools-next, thanks!
>
> Thanks Namhyung, I think this should be a candidate for perf-tools so
> that 6.6 doesn't regress for sysfs events.

I see, I overlooked that it's for the current cycle.
I'll move it to perf-tools.

Thanks,
Namhyung
