Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D687EA083
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjKMPuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKMPuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:50:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03713D71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:50:12 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so9778a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699890610; x=1700495410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yuk3UTwDW/yoy9m5RFJx2zCUvzj2frFN4dnCSnzxK50=;
        b=rb45NIwHw64eYtT6BBC47TRDxFOyVDNn5ysCVfRaRC3GFAsCseVdCSpAN0CUlGJuw7
         PMxfBefKjHxDM8T8D1ctGOSEMGl6rHbx7M3EIs7+Wh4W3hrOlufzRnQxku336UImwmU2
         mtIEUu+/hbLHGkpzrx299YYhMMa6dylqZ9BTpaxWmjCRUlhfyliEPsFszfk+E1Nj7cO9
         NEUjb8sDPctgL6Q5DSVt/ZHdY2oPLLJ7ubNMLy8IF/nXvEGuYb91jrS9XWU4y1v6yUHY
         hQNSRpg5QfoV5vFhSzSpcoJpV3+CJ8Tm9g8LEwDccXob05v0a8TPprEWU9ygCTTW1mtF
         5kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699890610; x=1700495410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yuk3UTwDW/yoy9m5RFJx2zCUvzj2frFN4dnCSnzxK50=;
        b=pUedN6VuwbDrjBXV3xl14qfp/JcITFgf82wU50NHGqnZuNWSsJl8S5mJtkzyMy3cPV
         X9133yezUuTcHSbgIztkA0hZZW51CkW50Bf3TUZ86a/TR7vs82m5wW43s+rKkHZtj3T+
         yRi9x5RgarmML3newcg9HT6K5z6TvCKzgc8iiPWWDiTv5z1awSBFxDNu+7ICnXD7fpoK
         cXhgkBRcG4cPyWW/icSExHtEIiAVFCt0+A9dja99PWBo7wNOR7n0F9oRj0dIfwKRwbB0
         m2pqKA04E88wk2+Pyu/1V+jRDdhLr7rR1a08trvbxqdvqWlXMQsz2VtIBdW8DXRpiZ9r
         HEFA==
X-Gm-Message-State: AOJu0YxKzw+M2pADgEsDLH4BYZAgzZeujgJDB9Z2csYOAtrfeSfLCFQy
        MTU+ZfU/ppIXclwDSLuXqtqXCTjvLufOsolXutqiYQ==
X-Google-Smtp-Source: AGHT+IHCqeGgKNsciaP/v0NjPqyimy8DoFYlasks4ATIasY1CXD7O1EuquDbi006FB2VbJf/GuDiCeeCGphgS0Jh1c4=
X-Received: by 2002:a05:6402:b90:b0:544:e2b8:ba6a with SMTP id
 cf16-20020a0564020b9000b00544e2b8ba6amr125391edb.3.1699890610302; Mon, 13 Nov
 2023 07:50:10 -0800 (PST)
MIME-Version: 1.0
References: <20231109164007.2037721-1-kan.liang@linux.intel.com>
In-Reply-To: <20231109164007.2037721-1-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Nov 2023 07:49:56 -0800
Message-ID: <CAP-5=fXGavfHvSPs5dRWmS93gspj4uUE6ftd855xFyN-hKRTzg@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Ignore the non-group case for branch counters
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, tinghao.zhang@intel.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 8:41=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The perf test 27: Sample parsing fails with the branch counters support
> introduced.
>
> The branch counters feature requires all the events to belong to a
> group. There is no problem with the normal perf usage which usually
> initializes an evlist even for a single evsel.
> But the perf test is special, which may not initialize an evlist. The
> Sample parsing test case is one of the examples. The existing code
> crashes with the !evsel->evlist.
>
> Non-group means the evsel doesn't have branch counters support.

Thanks Kan, do we need to add this condition to
parse_events__sort_events_and_fix_groups?
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c#n2174

Ian

> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Closes: https://lore.kernel.org/lkml/ZUv+G+w5EvJgQS45@kernel.org/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/evsel.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 58a9b8c82790..7a6a2d1f96db 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2355,6 +2355,10 @@ static inline bool evsel__has_branch_counters(cons=
t struct evsel *evsel)
>  {
>         struct evsel *cur, *leader =3D evsel__leader(evsel);
>
> +       /* The branch counters feature only supports group */
> +       if (!leader || !evsel->evlist)
> +               return false;
> +
>         evlist__for_each_entry(evsel->evlist, cur) {
>                 if ((leader =3D=3D evsel__leader(cur)) &&
>                     (cur->core.attr.branch_sample_type & PERF_SAMPLE_BRAN=
CH_COUNTERS))
> --
> 2.35.1
>
