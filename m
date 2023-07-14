Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E06E75361A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbjGNJIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjGNJH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:07:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090F330C8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:07:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so2867292e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1689325668; x=1691917668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzynI4WLtBuw1d8m4j6WgZRv2EJK5DJSgflNEDgPfAc=;
        b=IeC4T67kCP+pYnmAmWKq3ZdRuzCxPc8oq3BWChG25r6bWYHzuDoyfrRi9GHWV4EuNv
         cse/ph6ey17vHs/Oht8kGJb1u140M0biadKuB6R+b6tTZzd4eCLeh4M3XHMaNQqQ/tvZ
         5hH1xkdWhGE/JMhxT4YxkiL4kTRihb5q62bv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689325668; x=1691917668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzynI4WLtBuw1d8m4j6WgZRv2EJK5DJSgflNEDgPfAc=;
        b=STLHazHfsjg/7MhgonGP7ifAqQFPVNMmDrXhKeqAoIL8JsSey0n6HM3f0xhxDy7XD8
         PV83anI3XT3faWbNJEwetgFe/Htn/ZD32y4lecFXVTZWDRhcE1R5IoSUjBSh1Gr1o1Gm
         ikCqeo+5+bn4/VVL7w7jEyXGg5iCE2wi1sJoLAJyF80ihq9XEj+RVcQhIKmrq7y042rz
         IoeTb8HQ5yMAIMtbjUrmPiDf5fkaTGDGW3XB+OLuxJpbjdbubktONVfztIATlQoF3U9v
         NbYrT2X348KbMeKde6Hja3zQxGboeaWqxegcDeBiZ7qEJeLkvjmsiJmUNL4Ir5MEH9jc
         3SfQ==
X-Gm-Message-State: ABy/qLaNGa+aOxJrvBdLGpxf7StJzlxjzYP+Ya+ucSXAaup6SMvMrMXZ
        1qMx6zsbCRaewoQGAFKAiqWU5otmFSnrHkhZrv2Y
X-Google-Smtp-Source: APBJJlEwvR3ie1wgajxu0LrxjHcnSgGyVfqq6Q7CDLHhh5oOZ5yoIAJ4eMMXji8exSySAnAz+ADwVtTO01lfq+BCC5k=
X-Received: by 2002:a2e:9f0c:0:b0:2b6:d9dd:f65f with SMTP id
 u12-20020a2e9f0c000000b002b6d9ddf65fmr3737244ljk.17.1689325668135; Fri, 14
 Jul 2023 02:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
In-Reply-To: <20230703124647.215952-1-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 14 Jul 2023 02:07:36 -0700
Message-ID: <CAOnJCUKCwnOXGWKiwQQxZ92t4138JAOqzkkqtwApHRy6YuS0Kw@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] riscv: Allow userspace to directly access perf counters
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

On Mon, Jul 3, 2023 at 5:46=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> riscv used to allow direct access to cycle/time/instret counters,
> bypassing the perf framework, this patchset intends to allow the user to
> mmap any counter when accessed through perf. But we can't break the
> existing behaviour so we introduce a sysctl perf_user_access like arm64
> does, which defaults to the legacy mode described above.
>
> This version needs openSBI v1.3 *and* a kernel fix that went upstream lat=
ely
> (https://lore.kernel.org/lkml/20230616114831.3186980-1-maz@kernel.org/T/)=
.
>
> **Important**: In this version, the default mode is now user access, not
> the legacy so some applications will break.
>
Maybe providing a little more context to the issue will help
understanding why breaking those legacy
applications is necessary due to security reasons.

Here was the previous discussion around this[1].
Most of the legacy user applications using rdcycle should use rdtime
instead as they just want to record the time
elapsed. Allowing rdcycle/rdinstret to be read from user space can
lead to very deterministic attacks[2].

[1] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/REWcwYnzsKE?pli=
=3D1
[2] https://www.youtube.com/watch?v=3D3-c4C_L2PRQ&ab_channel=3DIEEESymposiu=
monSecurityandPrivacy

Any user application that really requires to read rdcycle directly can
use this new perf interface to do that without any latency.

> base-commit-tag: v6.4-rc6
>
> Changes in v4:
> - Fixed some nits in riscv_pmu_sbi.c thanks to Andrew
> - Fixed the documentation thanks to Andrew
> - Added RB from Andrew \o/
>
> Changes in v3:
> - patch 1 now contains the ref to the faulty commit (no Fixes tag as it i=
s only a comment), as Andrew suggested
> - Removed RISCV_PMU_LEGACY_TIME from patch 3, as Andrew suggested
> - Rename RISCV_PMU_PDEV_NAME to "riscv-pmu-sbi", patch4 is just cosmetic =
now, as Andrew suggested
> - Removed a few useless (and wrong) comments, as Andrew suggested
> - Simplify arch_perf_update_userpage code, as Andrew suggested
> - Documentation now mentions that time CSR is *always* accessible, whatev=
er the mode, as suggested by Andrew
> - Removed CYCLEH reference and add TODO for rv32 support, as suggested by=
 Atish
> - Do not rename the pmu instance as Atish suggested
> - Set pmc_width only if rdpmc is enabled and CONFIG_RISCV_PMU is set and =
the event is a hw event
> - Move arch_perf_update_userpage https://lore.kernel.org/lkml/20230616114=
831.3186980-1-maz@kernel.org/T/
> - **Switch to user mode access by default**
>
> Changes in v2:
> - Split into smaller patches, way better!
> - Add RB from Conor
> - Simplify the way we checked riscv architecture
> - Fix race mmap and other thread running on other cpus
> - Use hwc when available
> - Set all userspace access flags in event_init, too cumbersome to handle =
sysctl changes
> - Fix arch_perf_update_userpage for pmu other than riscv-pmu by renaming =
pmu driver
> - Fixed kernel test robot build error
> - Fixed documentation (Andrew and Bagas)
> - perf testsuite passes mmap tests in all 3 modes
>
> Alexandre Ghiti (10):
>   perf: Fix wrong comment about default event_idx
>   include: riscv: Fix wrong include guard in riscv_pmu.h
>   riscv: Make legacy counter enum match the HW numbering
>   drivers: perf: Rename riscv pmu sbi driver
>   riscv: Prepare for user-space perf event mmap support
>   drivers: perf: Implement perf event mmap support in the legacy backend
>   drivers: perf: Implement perf event mmap support in the SBI backend
>   Documentation: admin-guide: Add riscv sysctl_perf_user_access
>   tools: lib: perf: Implement riscv mmap support
>   perf: tests: Adapt mmap-basic.c for riscv
>
>  Documentation/admin-guide/sysctl/kernel.rst |  27 ++-
>  drivers/perf/riscv_pmu.c                    | 113 +++++++++++
>  drivers/perf/riscv_pmu_legacy.c             |  28 ++-
>  drivers/perf/riscv_pmu_sbi.c                | 196 +++++++++++++++++++-
>  include/linux/perf/riscv_pmu.h              |  12 +-
>  include/linux/perf_event.h                  |   3 +-
>  tools/lib/perf/mmap.c                       |  65 +++++++
>  tools/perf/tests/mmap-basic.c               |   4 +-
>  8 files changed, 428 insertions(+), 20 deletions(-)
>
> --
> 2.39.2
>


--=20
Regards,
Atish
