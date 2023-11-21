Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0C47F35DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjKUSVz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 13:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjKUSVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:21:51 -0500
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B127C97
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:21:47 -0800 (PST)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5bd5809f63aso3385688a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700590907; x=1701195707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjqukWY1TJRl2un3A3Zmwy+nQrqrkLFwF1K5Ugh7bto=;
        b=AGXn5FNnWLhuLPwtkk05tNpFkgtSGXwt/dc/2U7jsFtxiBOvONyVL73pMrYmPLu4w2
         CiPcy6V18MJkPzhei/YDW6btb70N/Z01eBqQbZ6yGwdABnE3Ma+ggIrbZZ6HJwPqTShy
         NpB5FUJpY4Ibq/dqKsDsNqEyWFEaYXajsbiLuMX+dRv0q2DHZLAKGvaexJ+oGVehFaWo
         6ILQ0Zcf/rmqo1TNrqpDCCeje5hOZ4eNgekm9EicmIAedQ+raqUO23qpf5i6k+ZG4uAH
         imABlMf62mlueoBukaCq7E7NcR0MlEvik0uA01fKbVmgXyFySBjIR8ZFh3pjmPEE6Sp/
         zy4Q==
X-Gm-Message-State: AOJu0YyULzANRcAj/PfJTSkhwkRvtb5Y1mNxa1xfgOoJGuAfpyTumdYS
        QE0mF+hSHoqI/JVReg6vr4WnJRqLn3BuOk9QUEo=
X-Google-Smtp-Source: AGHT+IGS8CF8o4jrtTN3gzjZVQq2KuBz1RFbrYXRMpN9bD3qC9J1yABAf1SAGSnPwY61X6+lJf+VHtyISNiR8k4q41Q=
X-Received: by 2002:a17:90b:3e85:b0:280:25ce:58f with SMTP id
 rj5-20020a17090b3e8500b0028025ce058fmr9353930pjb.43.1700590907025; Tue, 21
 Nov 2023 10:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20231120221932.213710-1-namhyung@kernel.org> <CAP-5=fWFeqEK4woCj2ngjxMi4B4EZ3y0gLN+qNu4oNfp4wG8xA@mail.gmail.com>
 <ZVvqj0pR2ZebBF3L@google.com>
In-Reply-To: <ZVvqj0pR2ZebBF3L@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 21 Nov 2023 10:21:36 -0800
Message-ID: <CAM9d7cgAPxyNxMTz-uoPExcg4e1h5iXCuR5ZOy7UUt5gjbd2VA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/core: Update perf_adjust_freq_unthr_context()
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
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

Hi Mingwei,

On Mon, Nov 20, 2023 at 3:24 PM Mingwei Zhang <mizhang@google.com> wrote:
>
> On Mon, Nov 20, 2023, Ian Rogers wrote:
> > On Mon, Nov 20, 2023 at 2:19 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > It was unnecessarily disabling and enabling PMUs for each event.  It
> > > should be done at PMU level.  Add pmu_ctx->nr_freq counter to check it
> > > at each PMU.  As pmu context has separate active lists for pinned group
> > > and flexible group, factor out a new function to do the job.
> > >
> > > Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
> > > even if it needs to unthrottle sampling events.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Series:
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Thanks,
> > Ian
> >
>
> Can we have "Cc: stable@vger.kernel.org" for the whole series? This
> series should have a great performance improvement for all VMs in which
> perf sampling events without specifying period.

I was not sure if it's ok to have this performance fix in the stable series.

Thanks,
Namhyung
