Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A877B3EB7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 08:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjI3G42 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Sep 2023 02:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjI3G41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 02:56:27 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92C81A7;
        Fri, 29 Sep 2023 23:56:25 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-79fca042ec0so341583539f.3;
        Fri, 29 Sep 2023 23:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696056985; x=1696661785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLVnq7bpoB/DPNFDYFDqdcabpCoSce/kmj2cilxMHvw=;
        b=LQcUa7tWs5d5/gAuJ+3pHuRb3t8L6gvzNGOQTC2mwtKOmSKOyjbVesEIYiNbgaVQHJ
         5JAYvWNXIzlO/5qb2yYP5CaemxV/ioEJ4V++9v7BrjnipMNDio/h0ogCXD8yKMmNdfl2
         7bxl8YGS3fxp0WU/AI2pLp3NqFpepPV+M5gVJA0i2e15cE0iqkEa3zcMEnuJWynPJhjp
         W9TgRqh4bZr/I/0fWVo3S6vqDDMbMWZqwWGIZ3QodLkRbll9/1NqltEfp/MrnZlX23sj
         6/6rPkimTxYUYIMuk4prwAX8dPgHSewQfHElpD+c4DWu4CGbUqcBUlg4TKUkNPiAWyFm
         eqBQ==
X-Gm-Message-State: AOJu0YwVir4PRcDMKl7Af50xTUJlg6Fp5UJwk8EGH755mOslvMPrEto3
        P/FQXgb8rXEqYh5X0K2Ff5YC4mqt4AyYAWmIDLM=
X-Google-Smtp-Source: AGHT+IEn2wK5Rt7ylWgoipTL/Rk8CN9PcAPurGV3WUfgdnOOQX0Wym6AbQUM+GDhPRaHPe/PVyF5iuCWm9KCZoz2F4g=
X-Received: by 2002:a5e:c74d:0:b0:79f:96db:f33d with SMTP id
 g13-20020a5ec74d000000b0079f96dbf33dmr6498919iop.9.1696056984951; Fri, 29 Sep
 2023 23:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230920122349.418673-1-wyes.karny@amd.com> <CAP-5=fUe-972h3+Cwegb6u8ZOxo2k_jHQ3i5gNPoUq_TR_AWDQ@mail.gmail.com>
 <CAM9d7cjH_YR9W_Ab-AuJR983GYn3s+ScwexCWid3Q6a+GzWDVg@mail.gmail.com>
 <CAP-5=fW7dsMw0i7N-oQ7dcz9sFx1hAtZCpsxuH=NqMz+h+i3ZQ@mail.gmail.com> <CAM9d7cgC8qZ=rN-0qAg0mNOV-XKCLzgJ1E530aexUnsytmrjfw@mail.gmail.com>
In-Reply-To: <CAM9d7cgC8qZ=rN-0qAg0mNOV-XKCLzgJ1E530aexUnsytmrjfw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 29 Sep 2023 23:56:13 -0700
Message-ID: <CAM9d7cj-JATZ2JryJ7__vX6RES+jiY0PceM7f6hGA6_D7ztmiA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 9:39 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Tue, Sep 26, 2023 at 9:07 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Sep 26, 2023 at 3:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Wed, Sep 20, 2023 at 9:02 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Wed, Sep 20, 2023 at 5:24 AM Wyes Karny <wyes.karny@amd.com> wrote:
> > > > >
> > > > > The perf_pmu__parse_* functions for the sysfs files of pmu event’s
> > > > > scale, unit, per-pkg and snapshot were updated in commit 7b723dbb96e8
> > > > > ("perf pmu: Be lazy about loading event info files from sysfs").
> > > > > However, the paths for these sysfs files were incorrect. This resulted
> > > > > in perf stat reporting values with wrong scaling and missing units. This
> > > > > is fixed by correcting the paths for these sysfs files.
> > > > >
> > > > > Before this fix:
> > > > >
> > > > >  $sudo perf stat -e power/energy-pkg/ -- sleep 2
> > > > >
> > > > >  Performance counter stats for 'system wide':
> > > > >
> > > > >    351,217,188,864      power/energy-pkg/
> > > > >
> > > > >           2.004127961 seconds time elapsed
> > > > >
> > > > > After this fix:
> > > > >
> > > > >  $sudo perf stat -e power/energy-pkg/ -- sleep 2
> > > > >
> > > > >  Performance counter stats for 'system wide':
> > > > >
> > > > >              80.58 Joules power/energy-pkg/
> > > > >
> > > > >              2.004009749 seconds time elapsed
> > > > >
> > > > > Fixes: 7b723dbb96e8 ("perf pmu: Be lazy about loading event info files from sysfs")
> > > > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > > >
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> > > Applied to perf-tools-next, thanks!
> >
> > Thanks Namhyung, I think this should be a candidate for perf-tools so
> > that 6.6 doesn't regress for sysfs events.
>
> I see, I overlooked that it's for the current cycle.
> I'll move it to perf-tools.

Applied to perf-tools, thanks!
