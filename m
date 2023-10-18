Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5BC7CEBA9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJRXQ1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 19:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJRXQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:16:24 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC43113;
        Wed, 18 Oct 2023 16:16:23 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-27d4b280e4eso155072a91.1;
        Wed, 18 Oct 2023 16:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670983; x=1698275783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIqkHqDOHQuBjbbW3lZ0aMJK1GXnPfSHH5+VnCKa+5E=;
        b=PryT3oDclSMTVDDg6fYZn8mkmOYWiwHOVa+kxvOv3kkZ0TfNV/te79BmguKR66ut1H
         Rt5kndlH+ufb97DwvBSlgPGG8BX2M5SHzgQAnjgy5DlFicaZeWIwP1idTVuiGzcdToH5
         DyDYSylfWfh91NH7ycwOcCabWAu7didEqdPJndcC24KYLfOBgLTQJDUtMsPgJqOpA0MC
         KBtvngeHpFd0KRZWQhmUtVIMOlu8JTn+cZ12pnOALreMkkvAlR4RYisEZe6Y8JEQH9Ej
         M7DBtiUPpws5vqnEfzsOQNxDZQsnpsdbfGI2k08GphGUwd0K7cLCajCQ8Yw2KpgD+zf4
         4nxA==
X-Gm-Message-State: AOJu0YxnlRPCN0AjubabwH7TF4+NA8GYLPB6E8f35pFI2d5V7BsjzExa
        yDLRBh1fSTn2f+Pswi64EIaqN3t/u3VCwtLur0Y=
X-Google-Smtp-Source: AGHT+IH3cHfMHMkPW0wf8wXkGXDRsCuzcrZXEfuHGBDHr1Lk29UAyILehq8JUCWlTMiaJCfnLyY53kRk1Q2H/Oveqmk=
X-Received: by 2002:a17:90a:11:b0:27d:df04:d109 with SMTP id
 17-20020a17090a001100b0027ddf04d109mr409283pja.2.1697670982818; Wed, 18 Oct
 2023 16:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com> <20231012062359.1616786-4-irogers@google.com>
In-Reply-To: <20231012062359.1616786-4-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 18 Oct 2023 16:16:11 -0700
Message-ID: <CAM9d7cg=v9rnPz4cy2yeNZNSCoZ3VReC895gHPTO-emn6XdLXg@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] perf hist: Add missing puts to hist__account_cycles
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
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Wed, Oct 11, 2023 at 11:24 PM Ian Rogers <irogers@google.com> wrote:
>
> Caught using reference count checking on perf top with
> "--call-graph=lbr". After this no memory leaks were detected.
>
> Fixes: 57849998e2cd ("perf report: Add processing for cycle histograms")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/hist.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 3dc8a4968beb..ac8c0ef48a7f 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -2676,8 +2676,6 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
>
>         /* If we have branch cycles always annotate them. */
>         if (bs && bs->nr && entries[0].flags.cycles) {
> -               int i;
> -

Seems not necessary.

>                 bi = sample__resolve_bstack(sample, al);

It looks like this increases the refcount for each bi entry and
it didn't put the refcounts.


>                 if (bi) {
>                         struct addr_map_symbol *prev = NULL;
> @@ -2692,7 +2690,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
>                          * Note that perf stores branches reversed from
>                          * program order!
>                          */
> -                       for (i = bs->nr - 1; i >= 0; i--) {
> +                       for (int i = bs->nr - 1; i >= 0; i--) {
>                                 addr_map_symbol__account_cycles(&bi[i].from,
>                                         nonany_branch_mode ? NULL : prev,
>                                         bi[i].flags.cycles);
> @@ -2701,6 +2699,12 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
>                                 if (total_cycles)
>                                         *total_cycles += bi[i].flags.cycles;
>                         }
> +                       for (unsigned int i = 0; i < bs->nr; i++) {

Can we just reuse the int i above?

Thanks,
Namhyung


> +                               map__put(bi[i].to.ms.map);
> +                               maps__put(bi[i].to.ms.maps);
> +                               map__put(bi[i].from.ms.map);
> +                               maps__put(bi[i].from.ms.maps);
> +                       }
>                         free(bi);
>                 }
>         }
> --
> 2.42.0.609.gbb76f46606-goog
>
