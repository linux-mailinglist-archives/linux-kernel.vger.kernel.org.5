Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7375349A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjGNIGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbjGNIFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:05:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C483ABD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:03:43 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso24771711fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1689321821; x=1691913821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjGLAxee+6Ys9A4CymyGT7r3XR+DwzfZMVxRgHoxE5Q=;
        b=CjrJSFwQHNriZicyQY+/qEHwW+RTQYr4SNIG047YQMIYg0SDkOYGzcHkruU4HmdQx9
         jbtscSpbmpGVYMjHVaxk3IB3OeT8otxO2C8i0F3xLjBHUcMg1WuQW7ENtOZsfYVzNRFI
         3BUW0it+1aYPguLEVgD5Sjj70w/JS4oI0XbZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321821; x=1691913821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjGLAxee+6Ys9A4CymyGT7r3XR+DwzfZMVxRgHoxE5Q=;
        b=kprllneTo+3jhqu32dLkPBxxjakB7EDo1eYnBMM0m2H/EFim05ckzN9aVFxU7wYmZm
         SSWeWGN5V4rPU18GFgsX03mD2f0hHZeWW3W/l+bO93DbquHW+wyh0z8+c4xt9PDfBttx
         qZlUIPykxymfiwViZvoeIulq8J94/d6TpYBky+ZdcXPge82wwqV5lg4+cf3bXn9Z9FSa
         R7dNQCQkNeZg9Kut7RvBb3MnlmVH4BjAyJQlBEsOsBUfuBC3v+jUsGe2/P3HXyGrLGSl
         MrnqKLX9Y318owlk7PPmLpUPJWTaacbySx1BCVvZmuHTRU6YNI9OtUTJDxi4l5TXrHgE
         ocDw==
X-Gm-Message-State: ABy/qLa7bYeQIQ+K1POoPaS6ysRY9ZWXa5dS40WSg7xJ2YySAEiCektX
        Aclw5JVXzeX7/3qm6LdnRkdrF2BwVkAFCCr89Xve
X-Google-Smtp-Source: APBJJlFMUlhWa9Bc5+g9g+JYTmYYF2lCTHnWmApqUVwFo+Nv3dexs2cSKLqHSfAq2guIwBhHZgSIhFGHf3AueKs0GvA=
X-Received: by 2002:a05:651c:104e:b0:2b6:c790:150a with SMTP id
 x14-20020a05651c104e00b002b6c790150amr3565106ljm.22.1689321821152; Fri, 14
 Jul 2023 01:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124647.215952-1-alexghiti@rivosinc.com> <20230703124647.215952-7-alexghiti@rivosinc.com>
In-Reply-To: <20230703124647.215952-7-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 14 Jul 2023 01:03:29 -0700
Message-ID: <CAOnJCULYD_Z32dupvTZZm7E6GnXaOy+R3yf7wqSy3ZMdd6eOFw@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] drivers: perf: Implement perf event mmap support
 in the legacy backend
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 5:52=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> Implement the needed callbacks in the legacy driver so that we can
> directly access the counters through perf in userspace.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/perf/riscv_pmu_legacy.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_leg=
acy.c
> index 6a000abc28bb..79fdd667922e 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -71,6 +71,29 @@ static void pmu_legacy_ctr_start(struct perf_event *ev=
ent, u64 ival)
>         local64_set(&hwc->prev_count, initial_val);
>  }
>
> +static uint8_t pmu_legacy_csr_index(struct perf_event *event)
> +{
> +       return event->hw.idx;
> +}
> +
> +static void pmu_legacy_event_mapped(struct perf_event *event, struct mm_=
struct *mm)
> +{
> +       if (event->attr.config !=3D PERF_COUNT_HW_CPU_CYCLES &&
> +           event->attr.config !=3D PERF_COUNT_HW_INSTRUCTIONS)
> +               return;
> +
> +       event->hw.flags |=3D PERF_EVENT_FLAG_USER_READ_CNT;
> +}
> +
> +static void pmu_legacy_event_unmapped(struct perf_event *event, struct m=
m_struct *mm)
> +{
> +       if (event->attr.config !=3D PERF_COUNT_HW_CPU_CYCLES &&
> +           event->attr.config !=3D PERF_COUNT_HW_INSTRUCTIONS)
> +               return;
> +
> +       event->hw.flags &=3D ~PERF_EVENT_FLAG_USER_READ_CNT;
> +}
> +
>  /*
>   * This is just a simple implementation to allow legacy implementations
>   * compatible with new RISC-V PMU driver framework.
> @@ -91,6 +114,9 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>         pmu->ctr_get_width =3D NULL;
>         pmu->ctr_clear_idx =3D NULL;
>         pmu->ctr_read =3D pmu_legacy_read_ctr;
> +       pmu->event_mapped =3D pmu_legacy_event_mapped;
> +       pmu->event_unmapped =3D pmu_legacy_event_unmapped;
> +       pmu->csr_index =3D pmu_legacy_csr_index;
>
>         perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
>  }
> --
> 2.39.2
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
