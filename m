Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547067925FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjIEQDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344657AbjIEDvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 23:51:53 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01597CCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 20:51:49 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-414b35e686cso496261cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 20:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693885909; x=1694490709; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6VnFp2w38t+lTwvTo9FRvp7pdyPYPmvBjyfCDIbzSs=;
        b=oYZCw2gBnpPPXzfbFllLMhQq1iNRFT3ZlstprvXB+4KPFKOyr3so4Q+8AcA9rRj0F8
         +YwK6lHIBy8OqlzBwhji29veCZEkHWyzYbR/ob2eJBp1dUu9U73tVIPqFt1Cr4QsNxI6
         Fudz7sbVzSyvGl+bKvhIsolUpPEGVwgQ9rvMfTVjoAkHctUTBoXTPbpU2QATiXb61JlM
         4rv2rHhY89xZ72MPQ+hOvVVIKWdsovAdaFE/84Z4G69F9jKWFGWP9OzNtxWl1kZqmje9
         EEAMRxVpyuX/0KIh9dF+dZMqbA/+M9u/J69zSDp727FAp2fP0eaW9ywylWlNp46/9x6z
         7iIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693885909; x=1694490709;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6VnFp2w38t+lTwvTo9FRvp7pdyPYPmvBjyfCDIbzSs=;
        b=BZgkKadKS+FmUVIIlPRFCezzb6zxuifOMwJK3JUKdPaMzMCauwunMQYeNUVMWdDszh
         wYNhlyo9ul2SX/DfdV4g88A7BB/zq2hP3C2x+YyYT0hwEBl3ax/7UJYLUXljPg3LVZ7Q
         l5WDuUian47proajGWYUCJHr/0HXGOnSQPNGvYywWN/Nk9p2kFiJdjQj8TkZMGxlNhEl
         tyIEI9oD9prfpbudi00uZiLPUq555BpNN9zChFrV0LkgOk1MM8djS20xVburUsvjNcNQ
         bx2VbHdOxZ1qMm0p07pcTLA9HRmDRR25/ex6xIhCNV2/tHWkAOvIyvludf0B5pz+gNeW
         B6jA==
X-Gm-Message-State: AOJu0YyDx0TSU76ucbUBGQMgfRKtaVsZ89W7kv8DTWFp59aAWU++b7LI
        1tMtuMsvfeElBMe5VC/LFKop3is8s06r8xSZ58PFtQ==
X-Google-Smtp-Source: AGHT+IEoRpdPrK1rssMloz4P1QqjG0UeoXvATFiUR1V5b46a2HZbQSp7hEuWJrm+3mnoDmptq7PejawLZSSEkK46RP4=
X-Received: by 2002:a05:622a:347:b0:410:88dc:21b with SMTP id
 r7-20020a05622a034700b0041088dc021bmr404582qtw.26.1693885908895; Mon, 04 Sep
 2023 20:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230905033805.3094293-1-irogers@google.com>
In-Reply-To: <20230905033805.3094293-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 4 Sep 2023 20:51:37 -0700
Message-ID: <CAP-5=fVWNnV792eVDiiMMF0gs88Ao7o1=VLeGBZOWm6MjO3kng@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Fix driver config term
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 4, 2023 at 8:38=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Inadvertently deleted in commit 30f4ade33d64 ("perf tools: Revert
> enable indices setting syntax for BPF map").
>

Sorry, should also have:
Fixes: 30f4ade33d64 ("perf tools: Revert enable indices setting syntax
for BPF map")

Thanks,
Ian

> Reported-by: James Clark <james.clark@arm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.y | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-event=
s.y
> index 4a305df61f74..21bfe7e0d944 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -839,6 +839,23 @@ PE_TERM
>
>         $$ =3D term;
>  }
> +|
> +PE_DRV_CFG_TERM
> +{
> +       struct parse_events_term *term;
> +       char *config =3D strdup($1);
> +       int err;
> +
> +       if (!config)
> +               YYNOMEM;
> +       err =3D parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV=
_CFG, config, $1, &@1, NULL);
> +       if (err) {
> +               free($1);
> +               free(config);
> +               PE_ABORT(err);
> +       }
> +       $$ =3D term;
> +}
>
>  sep_dc: ':' |
>
> --
> 2.42.0.283.g2d96d420d3-goog
>
