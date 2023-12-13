Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00B5810749
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378099AbjLMBGp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 20:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbjLMBGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:06:43 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A179AA5;
        Tue, 12 Dec 2023 17:06:49 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-58df5988172so4013153eaf.0;
        Tue, 12 Dec 2023 17:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702429609; x=1703034409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CURLE9aVy/LylBUfiOnMqulpgDjUBj54GEYP7CuHeA=;
        b=rOfDozuO8/M0yKAKnDqBteFGsumeaE55fKpVQAU1HrwtOB//BWgBajHNq+6FoHf9o/
         xBLLdV+cqAtsqN7+RGD5CMurLkkbOP99p1HjkXYQ3tqEz3RmUDiWcu82Afzz2SxrpNBz
         q7yfZE/Ec+b1SNiS9RakKfYcAd+a/HHcaF4l7YbqQlyHnqstJXmHU+67/+wsVSAd8BOt
         cNh+6nLAdJf3tG38MuibcWlm+y/Pnwl1R2fzbIdYNrUgAoF2g1F3EhIeHj5TJmeE+XI1
         lQC7LM58ugUFxew08Z8HxjbLikpGJuB0+IBaSwEP4fr3ceCgg85JXlr760ciE4G4wWjS
         cZvA==
X-Gm-Message-State: AOJu0YxXynK4uJR/DSO011+AuYC/jeTaWrM051MkKnGpIpy78A7Ib4K5
        78czXucGouQTQZVjIboRffN0N5Ny59SSufHE8G8=
X-Google-Smtp-Source: AGHT+IE7SBK+DZdO/+3cOIsJqAyd0WaC8xeeraYpk1X7WJLebVKqXZowSpA+uZTHSWFKZFr830tnYgr9ctNJZfyBR5s=
X-Received: by 2002:a05:6359:4c25:b0:170:c921:fed9 with SMTP id
 kj37-20020a0563594c2500b00170c921fed9mr8130076rwc.60.1702429608712; Tue, 12
 Dec 2023 17:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20231212193833.415110-1-kan.liang@linux.intel.com>
 <CAP-5=fWCgjCC-DHHx+HJCuYk6vNn9Lf9EKcnBBZQ+xmnyYnmPg@mail.gmail.com>
 <996ec30b-2bcf-4739-bec0-728c7f7af2ac@linux.intel.com> <CAP-5=fVnH0eTEvvNbKLF9xYye5Pu8hvDL4ruoxh5xG76+B8WFQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVnH0eTEvvNbKLF9xYye5Pu8hvDL4ruoxh5xG76+B8WFQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 12 Dec 2023 17:06:37 -0800
Message-ID: <CAM9d7chQ4NbbcmumQSMRaGm987nxxh6_QbbJr7+GYgL_WAmaNw@mail.gmail.com>
Subject: Re: [PATCH V2] perf top: Use evsel's cpus to replace user_requested_cpus
To:     Ian Rogers <irogers@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, acme@kernel.org,
        mark.rutland@arm.com, maz@kernel.org, marcan@marcan.st,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Tue, Dec 12, 2023 at 2:12 PM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Dec 12, 2023 at 1:25 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >
> >
> >
> > On 2023-12-12 3:37 p.m., Ian Rogers wrote:
> > > On Tue, Dec 12, 2023 at 11:39 AM <kan.liang@linux.intel.com> wrote:
> > >>
> > >> From: Kan Liang <kan.liang@linux.intel.com>
> > >>
> > >> perf top errors out on a hybrid machine
> > >>  $perf top
> > >>
> > >>  Error:
> > >>  The cycles:P event is not supported.
> > >>
> > >> The perf top expects that the "cycles" is collected on all CPUs in the
> > >> system. But for hybrid there is no single "cycles" event which can cover
> > >> all CPUs. Perf has to split it into two cycles events, e.g.,
> > >> cpu_core/cycles/ and cpu_atom/cycles/. Each event has its own CPU mask.
> > >> If a event is opened on the unsupported CPU. The open fails. That's the
> > >> reason of the above error out.
> > >>
> > >> Perf should only open the cycles event on the corresponding CPU. The
> > >> commit ef91871c960e ("perf evlist: Propagate user CPU maps intersecting
> > >> core PMU maps") intersect the requested CPU map with the CPU map of the
> > >> PMU. Use the evsel's cpus to replace user_requested_cpus.
> > >>
> > >> The evlist's threads are also propagated to the evsel's threads in
> > >> __perf_evlist__propagate_maps(). For a system-wide event, perf appends
> > >> a dummy event and assign it to the evsel's threads. For a per-thread
> > >> event, the evlist's thread_map is assigned to the evsel's threads. The
> > >> same as the other tools, e.g., perf record, using the evsel's threads
> > >> when opening an event.
> > >>
> > >> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > >> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.org/
> > >> Reviewed-by: Ian Rogers <irogers@google.com>
> > >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > >> ---
> > >>
> > >> Changes since V1:
> > >> - Update the description
> > >> - Add Reviewed-by from Ian
> > >
> > > Thanks Kan, quick question. Does "perf top" on hybrid ask the user to
> > > select between the cycles event on cpu_atom and cpu_core?
> >
> > Yes, but the event doesn't include the PMU information.
> > We probably need a follow up patch to append the PMU name.
> >
> > Available samples
> > 385 cycles:P
> >
> > 903 cycles:P
>
> Thanks and agreed, it isn't possible to tell which is which PMU/CPU
> type at the moment. I tried the patch with perf top --stdio, there
> wasn't a choice of event  and I can't tell what counter is being
> displayed. When I quit I also see:
> ```
> exiting.
> corrupted double-linked list
> Aborted (core dumped)
> ```
> but I wasn't able to repro this on a debuggable binary/system.
>
> If my memory serves there was a patch where perf top was showing >1
> event. It would be nice here to do some kind of hybrid merging rather
> than having to view each PMU's top separately.

Using event groups, but I noticed you removed the --group option.
Maybe perf top can just use `{ ... }` notation for explicit grouping,
but it might be implicit like in the hybrid case.

Thanks,
Namhyung
