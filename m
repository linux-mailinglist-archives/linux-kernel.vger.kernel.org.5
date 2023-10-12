Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B087C78C5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442959AbjJLVnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442956AbjJLVnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:43:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F16AC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:43:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4053f24c900so10675e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697146989; x=1697751789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoYUWazhTuq3/OyQ48ktFaTXNncGid8TDSUHkaGg0J0=;
        b=CL1lcV2NpYAQX/WvkFSMN07r+t5NIgOZJUDWOacYzAmnPJtox+3UxioFw9RHsxg3cD
         LpE0vHKE49VIO8EUEadxKKyGrMGY6PFz1KrnWyAOUThF3DRrc5fUxAJGDQ9TjxGMSUU1
         2juHTjrdltoOITTP3cYQVRrFwMvBOPGeHkQxflKw11PSC3g5PjMjOrsdPZjcH+5V45AS
         hGEWzH3D4q+tV1pmdz4egorvsM7E5Na/gfMdg8A0u7sABxdfJr466qk0PLPz/CYf5hME
         ++tjjbIRG+7XJGYaRVhFhNbruXq9tw77FveSgN+d0wtK+zeClXhFiCKr31or0nBSIgsM
         OhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697146989; x=1697751789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoYUWazhTuq3/OyQ48ktFaTXNncGid8TDSUHkaGg0J0=;
        b=tOxd4uSTjNzNsCI13LWHchIzm/MDileNmLfa6NW3WBjh1SJzKjKcCg2k50nVbO61PS
         n0mtRDGTLB5BaqPdmnqOiYQNQUEkCzDXApJf9xk7y6syccYrcxIVTMGJO59sEJYvPjUL
         w2evb45sPZBO8RItNfkppr1sq9D7UBebyrPrnX2AFapJ44lSbbTwF1GFimUPTg8dip/V
         3k+2h4xnZ54BJvptCl8Sk43XotqRHxgYo06epdr4U9mT+T1CQL8vxOjWPJo/B5zzwMvO
         mK07T4okClPPzCv5tOyqqJDee1ymo2cY/QPl/BuxOoUR6M3MhAk1b/l61saUtRmh+CTr
         T5aQ==
X-Gm-Message-State: AOJu0Yxgfhz2CrBeUJuK1Gg2PoLH/Z/qCMpIDEvOYWVVpeWVdSPCknqu
        cNG7pWM50smvW2D4yo/36uMRZyAz2FSZpkXHmXsxZb2TgyZp+8z5D1ADKw==
X-Google-Smtp-Source: AGHT+IGPZxxRRadk+VBxng1fsHuF3phTS4uk8S+jKMOOrqACa6DpWamVfnu3eOUxyXpJ/hFgQ0rrBwvb/fxVLQUICG8=
X-Received: by 2002:a05:600c:4583:b0:3f6:f4b:d4a6 with SMTP id
 r3-20020a05600c458300b003f60f4bd4a6mr14076wmo.7.1697146989416; Thu, 12 Oct
 2023 14:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230928091033.33998-1-adrian.hunter@intel.com>
In-Reply-To: <20230928091033.33998-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 12 Oct 2023 14:42:57 -0700
Message-ID: <CAP-5=fVVDRU_NLHvTCaFYwGvvN4v+1Z=TXoy27Hhi9HkOVZ76g@mail.gmail.com>
Subject: Re: [PATCH] perf dlfilter: Add a test for object_code()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Thu, Sep 28, 2023 at 2:10=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> Extend the "dlfilter C API" test to test
> perf_dlfilter_fns.object_code().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/dlfilters/dlfilter-test-api-v0.c | 12 +++++++++++-
>  tools/perf/dlfilters/dlfilter-test-api-v2.c | 12 +++++++++++-
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/dlf=
ilters/dlfilter-test-api-v0.c
> index 72f263d49121..4083b1abeaab 100644
> --- a/tools/perf/dlfilters/dlfilter-test-api-v0.c
> +++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
> @@ -289,6 +289,15 @@ static int check_attr(void *ctx)
>         return 0;
>  }
>
> +static int check_object_code(void *ctx, const struct perf_dlfilter_sampl=
e *sample)
> +{
> +       __u8 buf[15];
> +
> +       CHECK(perf_dlfilter_fns.object_code(ctx, sample->ip, buf, sizeof(=
buf)) > 0);
> +
> +       return 0;
> +}
> +
>  static int do_checks(void *data, const struct perf_dlfilter_sample *samp=
le, void *ctx, bool early)
>  {
>         struct filter_data *d =3D data;
> @@ -314,7 +323,8 @@ static int do_checks(void *data, const struct perf_dl=
filter_sample *sample, void
>         if (early && !d->do_early)
>                 return 0;
>
> -       if (check_al(ctx) || check_addr_al(ctx) || check_address_al(ctx, =
sample))
> +       if (check_al(ctx) || check_addr_al(ctx) || check_address_al(ctx, =
sample) ||
> +           check_object_code(ctx, sample))
>                 return -1;
>
>         if (early)
> diff --git a/tools/perf/dlfilters/dlfilter-test-api-v2.c b/tools/perf/dlf=
ilters/dlfilter-test-api-v2.c
> index 38e593d92920..32ff619e881c 100644
> --- a/tools/perf/dlfilters/dlfilter-test-api-v2.c
> +++ b/tools/perf/dlfilters/dlfilter-test-api-v2.c
> @@ -308,6 +308,15 @@ static int check_attr(void *ctx)
>         return 0;
>  }
>
> +static int check_object_code(void *ctx, const struct perf_dlfilter_sampl=
e *sample)
> +{
> +       __u8 buf[15];
> +
> +       CHECK(perf_dlfilter_fns.object_code(ctx, sample->ip, buf, sizeof(=
buf)) > 0);
> +
> +       return 0;
> +}
> +
>  static int do_checks(void *data, const struct perf_dlfilter_sample *samp=
le, void *ctx, bool early)
>  {
>         struct filter_data *d =3D data;
> @@ -333,7 +342,8 @@ static int do_checks(void *data, const struct perf_dl=
filter_sample *sample, void
>         if (early && !d->do_early)
>                 return 0;
>
> -       if (check_al(ctx) || check_addr_al(ctx) || check_address_al(ctx, =
sample))
> +       if (check_al(ctx) || check_addr_al(ctx) || check_address_al(ctx, =
sample) ||
> +           check_object_code(ctx, sample))
>                 return -1;
>
>         if (early)
> --
> 2.34.1
>
