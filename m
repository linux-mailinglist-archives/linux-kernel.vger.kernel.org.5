Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A1075FAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGXPY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjGXPY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:24:56 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1477912F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:24:55 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40550136e54so597161cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690212294; x=1690817094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ARRWNWh2Vmb25NjHP5oLpxafnyIHI4eaaf29F6UDI8=;
        b=7x0VllgkQZ5Lhm3lNOZYgbjqIZVMqawjLMvScJ3sLXCdq0pk0OVB6NpIUxJhgPFKP+
         35RLBrM73909fXim0ML2FaZmcXj0nHajLqvyQREYToX1EWZ6li0z07Z8B+tBjzCtBeiz
         z2Q3Fpw9grdmt9C9I6+9UVMuv6dkKHpyeDlk384H2i90VGjZMQnMVHPgECjogh8AWvuW
         pNcFvHLM5oB4Qe/qBdHljBEEJDr8a5FkSxxlbbRnxsV7yA3tmg9ydLZVSc9XJCqeTTmU
         X1NLWOMax2UtUGCpazbmOJajvXVxpRXq0fY3ff2dy1r//GxJ1NaRbrK7ZIJClO58ThCb
         GpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690212294; x=1690817094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ARRWNWh2Vmb25NjHP5oLpxafnyIHI4eaaf29F6UDI8=;
        b=YqrhUyUB5XnoZKLPzuZPw0eHM4Sd4rax4pgdCP9Ce7wTvaGp3lEYMKtIibAXjv6luT
         JDa5lSt4dacENKs4qkq5Cb468F+l46F20PK3l0dYw3kiBhIOLsDhn2pruh154X2BtK6k
         ddy99rH2gNncpK7xj0wJrqUtRDez+1M8linhRLzYfSY78Xrv5IMTEP2iE8zhFyaS7NYG
         VIECpRw3HEd/4eY4PLnbmvc+qs41SasoQjm4+Xo5kBXt/Hpq8MTGMd22jA9X9mfUoM3X
         UYagxwHiSeWk2qmeqZKljJTlxxnDA09sYW2MH6eG5w8wJgNCLDeFaf5ZVYi8ZITQg4YR
         1JhQ==
X-Gm-Message-State: ABy/qLaNY9wvIvWziRATBmJ3Lb2RYmuevKzDBX87bUUFQi0UtDOMAI7o
        lffTkUaEFcZ8ob24GvCc9eZqYHklKhr6bLTJ4igU5g==
X-Google-Smtp-Source: APBJJlEf6NqfF5oOXAsS8tbDsNEIs+dIB+DwL5BKxyMm1DmXo0JNX3tzw75Jk4jlazxsoVQ782TOxUrZveOVOxKy0Fg=
X-Received: by 2002:ac8:7d81:0:b0:403:f5b8:2bd2 with SMTP id
 c1-20020ac87d81000000b00403f5b82bd2mr447401qtd.9.1690212294090; Mon, 24 Jul
 2023 08:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230719001836.198363-1-irogers@google.com> <ZLf4C/+x2ZSpb1Uz@kernel.org>
In-Reply-To: <ZLf4C/+x2ZSpb1Uz@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 24 Jul 2023 08:24:42 -0700
Message-ID: <CAP-5=fWXd8KhvxnPjjFjtybNZ7BsN6n_55xFaEA_-Jda0g2+XQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Parse event sort/regroup fixes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 7:49=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jul 18, 2023 at 05:18:33PM -0700, Ian Rogers escreveu:
> > Patch 1, fix:
> > perf stat -e cycles,slots,topdown-fe-bound
> > so that cycles isn't made a group leader (failure caused by PMUs
> > matching). Previously this event list would fail so not necessarily a
> > regression over previous perf release.
> >
> > Patch 2, when regrouping events the leader needs to be updated due to
> > sorting. This fix causes larger event groups that then regress at
> > least the tigerlake metric test as the kernel PMU driver fails to
> > break the weak groups. This is a fix for a bug but the consequence of
> > fixing the bug is to make a passing test fail due to the kernel PMU
> > driver.
> >
> > Patch 3, don't alter the list position of events without a group if
> > they don't need forcing into a group. Analysis showed this was the
> > cause of the issue reported by Andi Kleen:
> > https://lore.kernel.org/linux-perf-users/ZLBgbHkbrfGygM%2Fu@tassilo/
>
> Andi,
>
>         Can you please check these patches and provide a Tested-by?

I think we should be aiming to get these fixes/changes into Linux 6.5
and it's a shame this didn't happen last week. Feedback appreciated.

Thanks,
Ian

> Thanks,
>
> - Arnaldo
>
> > Due to the test regression in patch 2, follow up patches may be
> > necessary for Icelake+ Intel vendor metrics to add METRIC_NO_GROUP to
> > avoid the kernel PMU driver issue.
> >
> > Ian Rogers (3):
> >   perf parse-events: Extra care around force grouped events
> >   perf parse-events: When fixing group leaders always set the leader
> >   perf parse-events: Only move force grouped evsels when sorting
> >
> >  tools/perf/util/parse-events.c | 58 +++++++++++++++++++++-------------
> >  1 file changed, 36 insertions(+), 22 deletions(-)
> >
> > --
> > 2.41.0.487.g6d72f3e995-goog
