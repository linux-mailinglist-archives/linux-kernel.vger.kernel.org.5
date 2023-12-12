Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B7B80DFDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345300AbjLLACq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLACo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:02:44 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82889B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:02:50 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bf09be81bso692e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702339369; x=1702944169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCwQNpqZrXvaI88937wdWL6JeEYRSB0xftnhNA8w9QY=;
        b=rppBubB+vlXIEBJ/2FSZ6guPqgsw/qF/wohWUFDkAFMDRVvam5Y5CDyY9n6H6LaC+K
         gln4lgDa5S1vPDVtb+FBTGK1xEfceR6v2TkgEOtxFmsRvz+bjQfOTvXzdfe/s/3fJqVt
         nBTjuX4Q03GD8gimwR3flcox1Ckm2Eiqdh7RBtchmFlRZTizHprOrf/VmXWCbxzAgpXj
         y0skzmS4Hh2NhQm5DuYS7FtFDqwRCIcfiEoRNgjvKvdqgXKh8CqyqieZdyex8m4zF8Yr
         F7jv0B6WzJIduZU7smQbz56gxFGD/XbcjSTz2hTrdO+X7ceWTzBTO02ZASSgwv8NGJxh
         rKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702339369; x=1702944169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCwQNpqZrXvaI88937wdWL6JeEYRSB0xftnhNA8w9QY=;
        b=qCSYQbYQ8411kmA1LfAjNksMxqi5XYNLm4zLPHF4ikHxPF7ZskkApHSgjYvRneArOg
         S2eQ3GePOjzYC3Yyjmjjc/r6XB5TJA9MNNnMtq/7GDk20PNkNvZH9o55iOjKRbDNDEgq
         cFKSn6ly30KdD9ZyLObnT/2rFGrpVtopgIyCqdrZf/yeljodHbutpTU96uRk/T6zNCMT
         cfJeaI2qOulHb2o5A7jz1Bol8YbnHx0k3PBZm9jLcDnFhRiQdKNc87TIclSKe5IqAEaa
         oQCROH541iUNn8UGNUCq1FavgAfXpk1b9ZTRJUzCt8M9CgL0FvtY3h8GRsAt004WgkYF
         X+tA==
X-Gm-Message-State: AOJu0YzAUobLU4lRYjz4Y4ECLY4wQupALoLSp0e43JbSymP58VkjfbVv
        1rdcMktxqvZ6Z+1hqQFUAjOIc2UN94hcD1wkjgeQDL4H/cTn23vXRNYBy4ku/Fc=
X-Google-Smtp-Source: AGHT+IEFPi/YPXkyOUwUvNngrnFwm/fy1efsJXMtqz89IJ4IFpU1HMqaGwOahPUhLCrAmspv2/LYPzyvqtjpieaeNbY=
X-Received: by 2002:a05:6512:539:b0:50c:e19:b658 with SMTP id
 o25-20020a056512053900b0050c0e19b658mr220203lfc.1.1702339368975; Mon, 11 Dec
 2023 16:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
In-Reply-To: <20231208210855.407580-1-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 Dec 2023 16:02:37 -0800
Message-ID: <CAP-5=fWmy7+iNRpMAZ_So0ki8oOD_4RSn9Mx+gGroWZH6_7Sdw@mail.gmail.com>
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 1:09=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> perf top errors out on a hybrid machine
>  $perf top
>
>  Error:
>  The cycles:P event is not supported.
>
> The user_requested_cpus may contain CPUs that are invalid for a hybrid
> PMU. It causes perf_event_open to fail.
>
> The commit ef91871c960e ("perf evlist: Propagate user CPU maps
> intersecting core PMU maps") already intersect the requested CPU map
> with the CPU map of the PMU. Use the evsel's cpus to replace
> user_requested_cpus.
>
> The evlist's threads is also propagated to evsel's threads in
> __perf_evlist__propagate_maps(). Replace it as well.
>
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.=
org/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Sorry I missed top doing the evlist__create_maps calls:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-top.c?h=3Dperf-tools-next#n1761
so it is right that the only divergence from record:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-record.c?h=3Dperf-tools-next#n1362
and stat:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/stat.c?h=3Dperf-tools-next#n797
So this is the right fix I believe.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-top.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index ea8c7eca5eee..cce9350177e2 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_top=
 *top)
>
>         evlist__for_each_entry(evlist, counter) {
>  try_again:
> -               if (evsel__open(counter, top->evlist->core.user_requested=
_cpus,
> -                                    top->evlist->core.threads) < 0) {
> +               if (evsel__open(counter, counter->core.cpus,
> +                               counter->core.threads) < 0) {
>
>                         /*
>                          * Specially handle overwrite fall back.
> --
> 2.35.1
>
