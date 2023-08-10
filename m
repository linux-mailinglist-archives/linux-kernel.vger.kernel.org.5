Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1962B778276
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjHJU5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjHJU5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:57:05 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9242738
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:57:01 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4036bd4fff1so28651cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691701020; x=1692305820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5qqUgL0dg2T9pVrYjXURmFg8YuxFP4dO5mEOfYEO2M=;
        b=W+akMieWAswlIfuFRrrY9q9KbV2f+v4USW7AzAMFlE54Xwx282y4eK6XnXSpP7ITSn
         zbzkEsQbPQ+azI07ouAc1GbojF3XyX6pUw6r+IImIy/ZmEtcq7kbDg8jRgOmgzzwM2qc
         BvQNTtVCH/v4bOKolbtHdA61dAgbZNf1Qk0PXsvHQGYFuTRjsVetA6FB6RekHp6LHmi1
         4uVzbreIqZFTsuqUZAwEAY+8DRjC5TrJGttTjXyda2HxdAqUIgVCgnNm+GjnA4i3rev9
         /68b0mRMYuu/3nezr/X2j2GZ2h2eP1dvLhPoWFihE4PHP/lWb9m94PvU9+5tmDlMq9su
         Z90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691701020; x=1692305820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5qqUgL0dg2T9pVrYjXURmFg8YuxFP4dO5mEOfYEO2M=;
        b=Wmzn86MmyLV6T1/nnub1oYqj7vMYcIOGmiDsJvnoQA7HK4fazciPwVqwRxG0PXRd9y
         shxOHjkL/7ciq/weWKN3Xd5foatFixRYI5aRoo0cKshcd9mmxqFd6qy2bbaI4hvMef7V
         3Wg45l6eAOKRZNjkrUiS66xMJWiLD8YqXAfcEZ0B7otivff6wenXaUqHXcbDWD+iiGqW
         2mZiNXoS56/0W4FoMIfi7RpI4+S3u+cLyXgpCoiWDEf9L/je5N393aZXQWMD92trSiZ8
         DFvrJ7x5JVHUWMYdtBVfBuk8TyW46RpSMCTm9SDlI/hDav+AhRPbsmAxmIEk+4u3bBjY
         TRqw==
X-Gm-Message-State: AOJu0YyieKRXvbchQZX2VAjNwTXhedXdhA9EK/lYV8uQFNrr7WSZ+5Ga
        rcsFiwkQzpHAsm5EvrPlJcP2YkEYACA+tlnBDOLCsG8qJINfunNdCVzFGg==
X-Google-Smtp-Source: AGHT+IFOGVrSscMtD1MpQ9ahMigqLBeatqurMF3bm5EZL0ZY2ZFI3yw7P+EW6G4iqJT+TAd0lU5WmbpthXdUKnKCRPI=
X-Received: by 2002:a05:622a:18a1:b0:403:b242:3e30 with SMTP id
 v33-20020a05622a18a100b00403b2423e30mr32095qtc.1.1691701020484; Thu, 10 Aug
 2023 13:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230807061652.2492167-1-namhyung@kernel.org>
In-Reply-To: <20230807061652.2492167-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 10 Aug 2023 13:56:48 -0700
Message-ID: <CAP-5=fXOjBUkxEPutpcNpe+V1+ADz2U9B3K8fjJy_L_6_nbxpQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Handle old data in PERF_RECORD_ATTR
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 6, 2023 at 11:16=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The PERF_RECORD_ATTR is used for a pipe mode to describe an event with
> attribute and IDs.  The ID table comes after the attr and it calculate
> size of the table using the total record size and the attr size.
>
>   n_ids =3D (total_record_size - end_of_the_attr_field) / sizeof(u64)
>
> This is fine for most use cases, but sometimes it saves the pipe output
> in a file and then process it later.  And it becomes a problem if there
> is a change in attr size between the record and report.
>
>   $ perf record -o- > perf-pipe.data  # old version
>   $ perf report -i- < perf-pipe.data  # new version
>
> For example, if the attr size is 128 and it has 4 IDs, then it would
> save them in 168 byte like below:
>
>    8 byte: perf event header { .type =3D PERF_RECORD_ATTR, .size =3D 168 =
},
>  128 byte: perf event attr { .size =3D 128, ... },
>   32 byte: event IDs [] =3D { 1234, 1235, 1236, 1237 },
>
> But when report later, it thinks the attr size is 136 then it only read
> the last 3 entries as ID.
>
>    8 byte: perf event header { .type =3D PERF_RECORD_ATTR, .size =3D 168 =
},
>  136 byte: perf event attr { .size =3D 136, ... },
>   24 byte: event IDs [] =3D { 1235, 1236, 1237 },  // 1234 is missing
>
> So it should use the recorded version of the attr.  The attr has the
> size field already then it should honor the size when reading data.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/header.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 52fbf526fe74..f89321cbfdee 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -4381,7 +4381,8 @@ int perf_event__process_attr(struct perf_tool *tool=
 __maybe_unused,
>                              union perf_event *event,
>                              struct evlist **pevlist)
>  {
> -       u32 i, ids, n_ids;
> +       u32 i, n_ids;
> +       u64 *ids;
>         struct evsel *evsel;
>         struct evlist *evlist =3D *pevlist;
>
> @@ -4397,9 +4398,8 @@ int perf_event__process_attr(struct perf_tool *tool=
 __maybe_unused,
>
>         evlist__add(evlist, evsel);
>
> -       ids =3D event->header.size;
> -       ids -=3D (void *)&event->attr.id - (void *)event;
> -       n_ids =3D ids / sizeof(u64);
> +       n_ids =3D event->header.size - sizeof(event->header) - event->att=
r.attr.size;
> +       n_ids =3D n_ids / sizeof(u64);
>         /*
>          * We don't have the cpu and thread maps on the header, so
>          * for allocating the perf_sample_id table we fake 1 cpu and
> @@ -4408,8 +4408,9 @@ int perf_event__process_attr(struct perf_tool *tool=
 __maybe_unused,
>         if (perf_evsel__alloc_id(&evsel->core, 1, n_ids))
>                 return -ENOMEM;
>
> +       ids =3D (void *)&event->attr.attr + event->attr.attr.size;
>         for (i =3D 0; i < n_ids; i++) {
> -               perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, ev=
ent->attr.id[i]);
> +               perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, id=
s[i]);
>         }
>
>         return 0;
> --
> 2.41.0.640.ga95def55d0-goog
>
