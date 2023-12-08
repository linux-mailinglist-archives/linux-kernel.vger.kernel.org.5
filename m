Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3467D80AE92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574775AbjLHVGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHVGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:06:18 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154A21994
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:06:23 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bf82f4409so2408660e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1702069581; x=1702674381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrp32oGF9B6zd6d7F/t+NH4/lgimMxpo/jAtAKpsnVQ=;
        b=dsUhYMNFERcN7dXV//Tt4Pt93zeF4+nKy/ERnNwZ1wInfSoDieYc51Bu8wcZ5JokSY
         9jRdyPYQHxACX7wM3kNp7RIGr7JkxKAShkvCZ5ed2zqfGD4Mm+cH4n0fX+9IENCNosS4
         uCWqnfq/FIpHL4zKGhxL4wmvMrBlOvDO8gUrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069581; x=1702674381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrp32oGF9B6zd6d7F/t+NH4/lgimMxpo/jAtAKpsnVQ=;
        b=pIEsuqhk7AHpSy/8JmuFPiH2uVDZhkbpiBI5lUQuCHawtw1zrTcjZV+4pm10mQV9oT
         cb4xBibjS7NbI56wp6FmJcY8qho9MR5dDH/s63poA9QEMTA81k+W9JpoiNWMij62aIHm
         HW9Nz0Nx5HbiJxIyOoH3lt8PyA+Qzlwzzn2Yhx47mmxCr3bV7VxlKuhW5g1utf78C0s0
         mcpx2VmZpdLDuoR61a2NxBhwfe3KQcJaJsnFgXYfWbjtdTHfEdu2C8wTKKomvYxj4m8f
         bGyXvOtvuzPlHUjziqg/QpHifTOL1FqApRNu61hLTeC4W1Xjnl5AIb7W5FSMYHVHrsA0
         I12w==
X-Gm-Message-State: AOJu0YyRnCzuGTZ7awSDVKBxcruxBbYZ1Bcws5Vm4r32QjFCIsV1Ynhj
        hy4FMCLotAOso3kRP0w+41BfK1fS3zK5bPwDDcKN
X-Google-Smtp-Source: AGHT+IFhPILMJ4QDzhpQJCTlw9rlSnIXE6QXzWmm26t/m85O2RhVhFv9eS9o0wVtDTKz+lKwUAL/6UXBL7uiOmmSRiI=
X-Received: by 2002:a05:6512:3d08:b0:50b:fe40:ada5 with SMTP id
 d8-20020a0565123d0800b0050bfe40ada5mr1114591lfv.2.1702069581145; Fri, 08 Dec
 2023 13:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20231205092555.35617-1-vadim.shakirov@syntacore.com> <20231205092555.35617-2-vadim.shakirov@syntacore.com>
In-Reply-To: <20231205092555.35617-2-vadim.shakirov@syntacore.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 8 Dec 2023 13:06:10 -0800
Message-ID: <CAOnJCUJ-eE+zbXH0yBX_QBK2ep779q=wNCSrc+BJfzUb+zBCaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: perf: added capabilities for legacy PMU
To:     Vadim Shakirov <vadim.shakirov@syntacore.com>
Cc:     Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 1:26=E2=80=AFAM Vadim Shakirov
<vadim.shakirov@syntacore.com> wrote:
>
> Added the PERF_PMU_CAP_NO_INTERRUPT flag because the legacy pmu driver
> does not provide sampling capabilities
>
> Added the PERF_PMU_CAP_NO_EXCLUDE flag because the legacy pmu driver
> does not provide the ability to disable counter incrementation in
> different privilege modes
>
> Suggested-by: Atish Patra <atishp@atishpatra.org>
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
> ---
>  drivers/perf/riscv_pmu_legacy.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_leg=
acy.c
> index a179ed6ac980..fa0bccf4edf2 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -123,6 +123,8 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>         pmu->event_mapped =3D pmu_legacy_event_mapped;
>         pmu->event_unmapped =3D pmu_legacy_event_unmapped;
>         pmu->csr_index =3D pmu_legacy_csr_index;
> +       pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_INTERRUPT;
> +       pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_EXCLUDE;
>
>         perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
>  }
> --
> 2.34.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
