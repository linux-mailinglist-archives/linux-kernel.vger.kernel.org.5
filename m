Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA5F808EC3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443347AbjLGRdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjLGRdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:33:18 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2542310DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:33:24 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bed6c1716so29e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701970402; x=1702575202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWvwuPiuxUQVO7BNeeDLUjAMj48JOZs+v7lie10kAzI=;
        b=NKgI3tKakb4aMkrzwQiaSWgp+L7RjlHKIHIAmp4tKektL8EWkuxjAQghl9ah32HrwB
         sbnLDgEIebwwQ4E37BAxnoFA3BH/tpoXStMTkV5CkjnlF/xnN8lBve8BO2WFenSwq+rX
         dEwC6GF9szaUomVqgGEDNxlJXEihrV2VBXDqEpDXYO22ajgLz5TsQFWeerU+aK9eq3h2
         ++uj27YnIqZhyUYbVdTXTn/WMIhO7qG/h2Vwh58V1ri7QcvGy9yG+Uemhni+S06xhdEn
         SJuuk0js8bwb7BYRe8QUs2G4hvqc2azoz3iYiJj/jzDKFOnCEX72x/sGbPDm6c3n0dIK
         ZUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701970402; x=1702575202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWvwuPiuxUQVO7BNeeDLUjAMj48JOZs+v7lie10kAzI=;
        b=pOJBFG+eMlNxeSuVQ72uXE8yOuh/FsPRMJOSWVyR4La/NidG9EzOAfyGWJxHKnXHYV
         eY5FTJwYuKIvQZqrQclKMfygjt7jh7BOW0SY7wHh5pdlrMndOIekn51VnoYoDxoBMiDU
         QbqSfWkpS5BwOmsAkGhNXCFRyCDccs7kv5GclJbR3c/J7mNP/vxdhkxKIPGtgFckaDnj
         rLvPcjBW1i3eJ+GWq193Zzqd+qf9o5wJjoeIx+SzM+XFzFAIgtno04xB+JifNIac91Uq
         WSj8UBqS89cMcReao/Dq2ybpd5dpmM1pMp7nbGnWZVVsu0aPUxPZYqo0r34J+Z85EnJI
         Ow2w==
X-Gm-Message-State: AOJu0YyHmyNH8pAVYYv+EDWJ3/pftPxUKQEjvGV7NISjUQQ32WPNsXap
        5TtaJOxNXMDjiVtcNlLhl0ts/iX9Jhd/y/82JvzEKA==
X-Google-Smtp-Source: AGHT+IG86lhLOte31MJRo1RVauOPUItQYNe9SDrSLhX2ANv5CukXoO4oocdicuGr5OZ2LbUL3IzKp5kjXgmUqFVrCR8=
X-Received: by 2002:ac2:5f56:0:b0:50b:cdd5:b54a with SMTP id
 22-20020ac25f56000000b0050bcdd5b54amr101794lfz.3.1701970402185; Thu, 07 Dec
 2023 09:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20231207140911.3240408-1-ben.gainey@arm.com>
In-Reply-To: <20231207140911.3240408-1-ben.gainey@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 7 Dec 2023 09:33:10 -0800
Message-ID: <CAP-5=fVM7cdrcOKL1nRcusBZpg_6Sg5NZA6PKYWcMgeOwHjf3w@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix missing reference count get in call_path_from_sample
To:     Ben Gainey <ben.gainey@arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 6:09=E2=80=AFAM Ben Gainey <ben.gainey@arm.com> wrot=
e:
>
> The addr_location map and maps fields in the inner loop were missing
> calls to map__get/maps__get. The subsequent addr_location__exit call in
> each loop puts the map/maps fields causing use-after-free aborts.
>
> This issue reproduces on at least arm64 and x86_64 with something
> simple like `perf record -g ls` followed by `perf script -s script.py`
> with the following script:
>
>     perf_db_export_mode =3D True
>     perf_db_export_calls =3D False
>     perf_db_export_callchains =3D True
>
>     def sample_table(*args):
>         print(f'sample_table({args})')
>
>     def call_path_table(*args):
>         print(f'call_path_table({args}')

Thanks for this, I've had a go at turning this into a perf test and
will send it out shortly.

> Fixes: 0dd5041c9a0ea ("perf addr_location: Add init/exit/copy functions")
> Signed-off-by: Ben Gainey <ben.gainey@arm.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/db-export.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
> index b9fb71ab7a73..106429155c2e 100644
> --- a/tools/perf/util/db-export.c
> +++ b/tools/perf/util/db-export.c
> @@ -253,8 +253,8 @@ static struct call_path *call_path_from_sample(struct=
 db_export *dbe,
>                  */
>                 addr_location__init(&al);
>                 al.sym =3D node->ms.sym;
> -               al.map =3D node->ms.map;
> -               al.maps =3D thread__maps(thread);
> +               al.map =3D map__get(node->ms.map);
> +               al.maps =3D maps__get(thread__maps(thread));
>                 al.addr =3D node->ip;
>
>                 if (al.map && !al.sym)
> --
> 2.43.0
>
