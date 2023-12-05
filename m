Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F1180431D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbjLEAGp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 19:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343594AbjLEAGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:06:39 -0500
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116C2119;
        Mon,  4 Dec 2023 16:06:46 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c2b7ec93bbso2766440a12.2;
        Mon, 04 Dec 2023 16:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701734805; x=1702339605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JcpNF/47E6R5fVAJEjKqFUfdaQxK8rB5P+pDp4ewSo=;
        b=KNiwj4vAXfiP9hUaNz6SvCUELMKs/mMNyf40yv/xEE6LQJENVQ1+WtMW4I9EWYq3KD
         Yic71LwTXfWG7v+7PKwhuZxUZAxO9hIqN1ZlmyLrLA6+I6uq+1NaaerAkH7sTX/k4QSe
         +MyHjbnSdNfzxg2FD1vRLhG9LBwYCfhj5yQt1sG91+ofOZcO6OTAxiXvYvhvbo6sOkpA
         cqL7kjSikE3XPIkV2+MlUAVh8kC2SKGWO0E2TSadF2zLrZz7+iPwuEy0Ok50v8r6Pf1v
         6QSVbhGf0bFTc4JBtQ/BjU6pzCCcZYRPl5SNQ7MoZNXKcyR4FCoe2irg7Z9iQ9pirW2h
         Iriw==
X-Gm-Message-State: AOJu0YwWyG2i6Nxb+4tr2eyqHLVzP2ZdATrT3rUBKRGsRF2omiSufNEu
        3bRQPQ+xfwYmDGNjhwrlgYkk5BsqcLzlp628HHA=
X-Google-Smtp-Source: AGHT+IEKoxwq6A2/JicMDbM8aGodtHdUOuaUjdgyG7o7AHTJ4AAxIoojnOEyPkQS1Q7G8mOlw/GuW4y+dVRQsOx5Q3A=
X-Received: by 2002:a17:90b:180b:b0:286:d42d:e6a with SMTP id
 lw11-20020a17090b180b00b00286d42d0e6amr413358pjb.28.1701734805437; Mon, 04
 Dec 2023 16:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-20-irogers@google.com>
In-Reply-To: <20231127220902.1315692-20-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 4 Dec 2023 16:06:34 -0800
Message-ID: <CAM9d7chpynqmnGpi+wpn0f3XvEtDNSisgdQcXQu_2LuHcLNuVA@mail.gmail.com>
Subject: Re: [PATCH v5 19/50] perf maps: Do simple merge if given map doesn't overlap
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
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

On Mon, Nov 27, 2023 at 2:10 PM Ian Rogers <irogers@google.com> wrote:
>
> Simplify merge in for the simple case of a non-overlapping map.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

A nitpick below.

> ---
>  tools/perf/util/maps.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 40df08dd9bf3..14e1a169433d 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -696,9 +696,20 @@ void maps__fixup_end(struct maps *maps)
>  int maps__merge_in(struct maps *kmaps, struct map *new_map)
>  {
>         struct map_rb_node *rb_node;
> +       struct rb_node *first;
> +       bool overlaps;
>         LIST_HEAD(merged);
>         int err = 0;
>
> +       down_read(maps__lock(kmaps));
> +       first = first_ending_after(kmaps, new_map);
> +       overlaps = first &&
> +               map__start(rb_entry(first, struct map_rb_node, rb_node)->map) < map__end(new_map);

Can you please break this like below?

    rb_node = first ? rb_entry(first, struct map_rb_node, rb_node) : NULL;
    overlap = rb_node && map__start(rb_node->map) < map_end(new_map);

Thanks,
Namhyung


> +       up_read(maps__lock(kmaps));
> +
> +       if (!overlaps)
> +               return maps__insert(kmaps, new_map);
> +
>         maps__for_each_entry(kmaps, rb_node) {
>                 struct map *old_map = rb_node->map;
>
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
