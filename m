Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6107D60C0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 06:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjJYEOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 00:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJYEOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 00:14:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FA2122
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 21:14:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso1143e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 21:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698207239; x=1698812039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRrGdq6DFD2VOzqL31MoSC4FSnbuEPDJ3WtOuo0gpgA=;
        b=G/3QN55J/sCS0J/SfGcnPJ8kUmqO1BxPImMnbO/CxkKpmC4g8Wip4k7ozpr9UFyFXG
         KWi+EmbI/v2GFbfIzNMwJtsh2Du6XqPiAZyTBx+O9GPkh8QsMVNiIExvfvIBj/M1D4HO
         Cva3Af2meEXpOZ1xUIc2SzXto+sjyz5Vh3d/jlfvzmqLgeJxeU3cBfwqZlieLMzOrnB1
         ec9Sey1XhOcYPQKNKSj7CACiqh+HC2LBrtf0c7UPwTWkG06kEQGi3hJB/gs/77XRd8sw
         QXIRdh/TLZf1wZ0zmNGahBBVWbAL5RTUOrbPjLynQ6lO+MHv+srdet+spYjaSxQxcTdz
         0scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698207239; x=1698812039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRrGdq6DFD2VOzqL31MoSC4FSnbuEPDJ3WtOuo0gpgA=;
        b=xEqIIwg3Gqn6+gDprCQF1ogCIxE5l/REEoirVHAKfcgVVKp8rApJEEd7ntyv+VSAFc
         cp8Xa48ffuRH2U+yJiXTrj8I+Si61o9oytU2jwSVPeUtkYE2hlnk7kBLrutVEw9zV/Ck
         QOuRj/lsyJSBfUMhWkq8FpcqPZ9H0RfUBW0c3mxKobGC57YlLDmGZg1a7GrnRlqrMq5H
         +a7Tt/WzMGEefh4tqzbsj336Al8cDmUDr2YCj41TueL+l8Iu+jbR2EoIvQUg+2QjWH6z
         LU5YHVkBzQwUJ5+AqquMWMwy8vkQCsJEs7Xq85kkKgOkn4Re/AvL9ecxXGtLBqrs4Emy
         8T8g==
X-Gm-Message-State: AOJu0YwKekrA0QF856pELtzL8vYqMccm7HKYHNjkz8Mx8cOe6xI5RXbU
        O4AOzoshO5JMvO/519w+U3W4iap8UjHZPN339Yli4g==
X-Google-Smtp-Source: AGHT+IHI+KWIQoLqEN1h1L4IB/gdLFWEebU7EccylLto5kbX9M/hG4CYZ7fflDxcW6w/DV6/Ld52DD+ocQQIAgEt7pI=
X-Received: by 2002:a05:6512:360e:b0:501:b029:1a47 with SMTP id
 f14-20020a056512360e00b00501b0291a47mr17427lfs.1.1698207238852; Tue, 24 Oct
 2023 21:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231020204741.1869520-1-namhyung@kernel.org> <20231020204741.1869520-2-namhyung@kernel.org>
In-Reply-To: <20231020204741.1869520-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 24 Oct 2023 21:13:47 -0700
Message-ID: <CAP-5=fXocfgq4+7foOVvh5uFFU2xnMJLLZ+Kr93Wh3hGCCMp_A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf lock contention: Check race in tstamp elem creation
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 1:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> When pelem is NULL, it'd create a new entry with zero data.  But it
> might be preempted by IRQ/NMI just before calling bpf_map_update_elem()
> then there's a chance to call it twice for the same pid.  So it'd be
> better to use BPF_NOEXIST flag and check the return value to prevent
> the race.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index b11179452e19..69d31fd77cd0 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -328,7 +328,11 @@ int contention_begin(u64 *ctx)
>         if (pelem =3D=3D NULL) {
>                 struct tstamp_data zero =3D {};
>
> -               bpf_map_update_elem(&tstamp, &pid, &zero, BPF_ANY);
> +               if (bpf_map_update_elem(&tstamp, &pid, &zero, BPF_NOEXIST=
) < 0) {
> +                       __sync_fetch_and_add(&task_fail, 1);
> +                       return 0;
> +               }
> +
>                 pelem =3D bpf_map_lookup_elem(&tstamp, &pid);
>                 if (pelem =3D=3D NULL) {
>                         __sync_fetch_and_add(&task_fail, 1);
> --
> 2.42.0.655.g421f12c284-goog
>
