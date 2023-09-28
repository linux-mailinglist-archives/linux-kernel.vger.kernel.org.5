Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642257B115A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjI1D4K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 23:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjI1D4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:56:05 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF88114;
        Wed, 27 Sep 2023 20:56:04 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-79fe87cd74eso136392239f.3;
        Wed, 27 Sep 2023 20:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695873364; x=1696478164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1awcH8GbI65VhOR4QezMpihuDaAOyYBPaOUcXT8DOQ=;
        b=PQcl133zvRgnxC12XUddAtEOnyfXcJFBjPxU/OglUJdBTC9JZ9uoJ5svtkvwja0WOs
         jV/Nf5BoQWZN1s2wvEUorffz/Byp6zbtZKlu6arLc1N8WsLTTPiMGiIchojvjg95lRqk
         oJtLb6Ti5KT9CtIpKRdjVaSgbFnt1Rt6HmbwsnwyCxXtfaasGyEQF7+ILQkTpLVNRORZ
         Z6M++lkwSmxWe4G63SU4RY0i3ay1WlLJdCfgCeOI0RFjP32E8P4JtU29FvkkMEPmDy6f
         ryOmGb5cxzRmx8JGrLcGdcGBXXR/ICrquiCxhee8f5lYkfX1UnvAirbk1L6PON82ZUSD
         GISQ==
X-Gm-Message-State: AOJu0YzuNTsmgRbcsT9drT+egVOWi1fKfow+UuzlzNQz66MJ7s2trxBQ
        Stk8pSybAwwmXZyRfl+00ahmCaKe2YHvBqGQ3WA=
X-Google-Smtp-Source: AGHT+IHago33rHQQtx98/NHeUgawaFXzjRnUzQ6yOTjvCloDy0RU925WzfS8lEsQf5BYR82jTxwhrUGYYhpO6Q6/1j8=
X-Received: by 2002:a05:6602:21d9:b0:780:c787:637b with SMTP id
 c25-20020a05660221d900b00780c787637bmr88139ioc.0.1695873363822; Wed, 27 Sep
 2023 20:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230922234444.3115821-1-namhyung@kernel.org> <CAPhsuW6mEWJcZdYbPbqt5ArBMznzQYwHBqTpKCcsB4B0o=PSGA@mail.gmail.com>
In-Reply-To: <CAPhsuW6mEWJcZdYbPbqt5ArBMznzQYwHBqTpKCcsB4B0o=PSGA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Sep 2023 20:55:52 -0700
Message-ID: <CAM9d7cjUiet5kNxk=opNrhGgZ2QeqB6J5Tzok5GaEwtgiM-FEA@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix BTF type checks in the off-cpu profiling
To:     Song Liu <song@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org
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

On Wed, Sep 27, 2023 at 9:09 AM Song Liu <song@kernel.org> wrote:
>
> On Fri, Sep 22, 2023 at 4:44 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The BTF func proto for a tracepoint has one more argument than the
> > actual tracepoint function since it has a context argument at the
> > begining.  So it should compare to 5 when the tracepoint has 4
> > arguments.
> >
> >   typedef void (*btf_trace_sched_switch)(void *, bool, struct task_struct *, struct task_struct *, unsigned int);
> >
> > Also, recent change in the perf tool would use a hand-written minimal
> > vmlinux.h to generate BTF in the skeleton.  So it won't have the info
> > of the tracepoint.  Anyway it should use the kernel's vmlinux BTF to
> > check the type in the kernel.
> >
> > Fixes: b36888f71c85 ("perf record: Handle argument change in sched_switch")
> > Cc: Song Liu <song@kernel.org>
> > Cc: Hao Luo <haoluo@google.com>
> > CC: bpf@vger.kernel.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Song Liu <song@kernel.org>

Applied to perf-tools-next, thanks!
