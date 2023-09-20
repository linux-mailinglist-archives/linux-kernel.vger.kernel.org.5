Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE907A892E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbjITQCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjITQCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:02:42 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369BAD9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:02:36 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41761e9181eso392781cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695225755; x=1695830555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hKvz7XvoFisXebVKsC7UUKF/hpZhzRWhPwp6F41w0w=;
        b=i9hONhm7zfnHV/aTzhGs4cQSXGMT2yUc7CjaGBaa6WKeeCP05+3V7isaAv6aJYaEkM
         YcArR8d8c3S26ZrCOgaN69Dv2lLdu+CfT5iqHbDrPhQBZZm9kB5McPVKGhwpjwRLIYmq
         tdc+0waZ7rUMVZg4xlQo2UDYKGeAmpJOQHHsW7+C8hOiEGwQ5BGwFMNEliprJzJn1Y0G
         LhJKf+yjNicp2acodGhD6Ks/C20jtrqSS7htOeQNtRJplpXMhl1ePqw+SywVDXuQFIfw
         /pnWsEVOBtF2UmKRKkoiqhQclzB1VQIs8B/1RUR8oexIp9XQJdEne1m1dq0PI4U8T1Gh
         VQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225755; x=1695830555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hKvz7XvoFisXebVKsC7UUKF/hpZhzRWhPwp6F41w0w=;
        b=F5zrmqW4bSyS/6PGT2c7vz6kh6JJ1KrTzJ5zgzhmofmT2kKxiy3trV/L6FaeKNsc7T
         WYZDegRts0rHWG3XvR+xEwKM6j7NkF2fmigN+F9JT1zw8h4Xw2t5yN9ykV6HTgbxZ1pd
         IbkpWVxOeAyCBI31ssR3GDVDIV8VD+hRq+U/jZ2AKL9IzjK8faytRUBjz5CrfRxiHjlK
         nsXhIKqWLsyQy+EZy++g6rEqaLdkEn5zdI8C9h0fLL1cNzYZSnehNUjWKMlzXriGw6Th
         1MjDmT+wz5rcY6oukknTX6gIlYcIqXFNg8UOhC3s63Hdoq3IoLkR91ySxLoO2iByunRx
         fJig==
X-Gm-Message-State: AOJu0Yw41EnR9e8OZxDhoqBOI3p08ULKJu7Zn0RLK0d1vfxCkUohcdU7
        brtgKLjaA/iUM1Mj2qpQNnJqLddVVxlXQQNv8rUMDg==
X-Google-Smtp-Source: AGHT+IEeygjqdTL+fm/PeEDoTS9pTf2SbY8SX+R5KBsEK7F7uoR1L27ypheY/jIq1T1yQsVEmEKNyXVQ5afJuA/vQ1E=
X-Received: by 2002:a05:622a:4e:b0:410:9d31:68cd with SMTP id
 y14-20020a05622a004e00b004109d3168cdmr226058qtw.27.1695225755151; Wed, 20 Sep
 2023 09:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230920122349.418673-1-wyes.karny@amd.com>
In-Reply-To: <20230920122349.418673-1-wyes.karny@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Sep 2023 09:02:23 -0700
Message-ID: <CAP-5=fUe-972h3+Cwegb6u8ZOxo2k_jHQ3i5gNPoUq_TR_AWDQ@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: Fix perf stat output with correct scale and unit
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ravi.bangoria@amd.com
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

On Wed, Sep 20, 2023 at 5:24=E2=80=AFAM Wyes Karny <wyes.karny@amd.com> wro=
te:
>
> The perf_pmu__parse_* functions for the sysfs files of pmu event=E2=80=99=
s
> scale, unit, per-pkg and snapshot were updated in commit 7b723dbb96e8
> ("perf pmu: Be lazy about loading event info files from sysfs").
> However, the paths for these sysfs files were incorrect. This resulted
> in perf stat reporting values with wrong scaling and missing units. This
> is fixed by correcting the paths for these sysfs files.
>
> Before this fix:
>
>  $sudo perf stat -e power/energy-pkg/ -- sleep 2
>
>  Performance counter stats for 'system wide':
>
>    351,217,188,864      power/energy-pkg/
>
>           2.004127961 seconds time elapsed
>
> After this fix:
>
>  $sudo perf stat -e power/energy-pkg/ -- sleep 2
>
>  Performance counter stats for 'system wide':
>
>              80.58 Joules power/energy-pkg/
>
>              2.004009749 seconds time elapsed
>
> Fixes: 7b723dbb96e8 ("perf pmu: Be lazy about loading event info files fr=
om sysfs")
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/pmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 0d81c059c91c..93feee29d054 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -295,7 +295,7 @@ static int perf_pmu__parse_scale(struct perf_pmu *pmu=
, struct perf_pmu_alias *al
>         len =3D perf_pmu__event_source_devices_scnprintf(path, sizeof(pat=
h));
>         if (!len)
>                 return 0;
> -       scnprintf(path + len, sizeof(path) - len, "%s/%s.scale", pmu->nam=
e, alias->name);
> +       scnprintf(path + len, sizeof(path) - len, "%s/events/%s.scale", p=
mu->name, alias->name);
>
>         fd =3D open(path, O_RDONLY);
>         if (fd =3D=3D -1)
> @@ -330,7 +330,7 @@ static int perf_pmu__parse_unit(struct perf_pmu *pmu,=
 struct perf_pmu_alias *ali
>         len =3D perf_pmu__event_source_devices_scnprintf(path, sizeof(pat=
h));
>         if (!len)
>                 return 0;
> -       scnprintf(path + len, sizeof(path) - len, "%s/%s.unit", pmu->name=
, alias->name);
> +       scnprintf(path + len, sizeof(path) - len, "%s/events/%s.unit", pm=
u->name, alias->name);
>
>         fd =3D open(path, O_RDONLY);
>         if (fd =3D=3D -1)
> @@ -364,7 +364,7 @@ perf_pmu__parse_per_pkg(struct perf_pmu *pmu, struct =
perf_pmu_alias *alias)
>         len =3D perf_pmu__event_source_devices_scnprintf(path, sizeof(pat=
h));
>         if (!len)
>                 return 0;
> -       scnprintf(path + len, sizeof(path) - len, "%s/%s.per-pkg", pmu->n=
ame, alias->name);
> +       scnprintf(path + len, sizeof(path) - len, "%s/events/%s.per-pkg",=
 pmu->name, alias->name);
>
>         fd =3D open(path, O_RDONLY);
>         if (fd =3D=3D -1)
> @@ -385,7 +385,7 @@ static int perf_pmu__parse_snapshot(struct perf_pmu *=
pmu, struct perf_pmu_alias
>         len =3D perf_pmu__event_source_devices_scnprintf(path, sizeof(pat=
h));
>         if (!len)
>                 return 0;
> -       scnprintf(path + len, sizeof(path) - len, "%s/%s.snapshot", pmu->=
name, alias->name);
> +       scnprintf(path + len, sizeof(path) - len, "%s/events/%s.snapshot"=
, pmu->name, alias->name);
>
>         fd =3D open(path, O_RDONLY);
>         if (fd =3D=3D -1)
> --
> 2.34.1
>
