Return-Path: <linux-kernel+bounces-28274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05782FC67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E112B1C27D71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131C9288CF;
	Tue, 16 Jan 2024 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="f6jxmEtM"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4FB2577F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438557; cv=none; b=Pj3CBeEj1JGXK0BzjJ6JwtEpyOTDLESMj+bqO7yZs3JyxApot0cak01653Q81Th+y/6X6/W053WAo4ThIN791hGqv4ecL0Iog4pNvRdhFFxB49UWNXNPlCLcOvJcmf0g56pT+bGVeSBdUNVX8ISDQvroHizgoblFqU6vXXpUuDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438557; c=relaxed/simple;
	bh=EDcdzIOhXQ/52ms8gzeDSrTpan3bCbvz3619AOQ1tBU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Isw3Lyg64W1CbT0nPike75PZlYuIFu/DaMcyv4ggYbTn42J81LZlid/s3X+3UAoNzbR5qumxA44rAXDPx9f/aClA9r51A+ELZmYkY3xkeXMoqq+G7tM1bpd4mG+r9nvR8x4tqT3BsOhwUbT+zQb0/heTBvcKtGUNGklN17UDaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=f6jxmEtM; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ccbc328744so124445411fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1705438553; x=1706043353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7aeoNCGecPYipNdateEPrHUR8jipxighb0wJVc74QM=;
        b=f6jxmEtM54r8oDuQFOwdHbMg+z9y4Mx2xlj8j/f4tae/HrtpLQA3PhPnK9GU28CEim
         V1Mect/gAQQ3fP38vycuywdeUFP4qCMVZJk925B0u2KNYqP2IotPH1TI0DcZGSZBXKHv
         YJSJZy64DlAjbK5pqL6xN+Ie69TxMzx4tx9pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705438553; x=1706043353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7aeoNCGecPYipNdateEPrHUR8jipxighb0wJVc74QM=;
        b=n3hsLQcwz0YzsM1JibpEy2wHvvdp3ZLclQGY6i8Y6BLZBHYVnkQgK/OoeFRCYQsh3O
         s0K/oNACfT4EyI2WySs1eMWSlVTEibWwKSQmosRIHqWsgBxYQO/j1M0kX2ffyiGWuTh1
         Q2Sgb9ysfVp2ApbGQR1XO7DpFjMSWgGnzx/OxXumO23rExYjgWzOsHYKr1nNBxdK4p/U
         t9JuiicE5eWapj1bRKcmulATpOecyNg4uVXKpiIexiobBXGcZhOQDJg9Hx7WtAOCr9Lm
         qTuTfdjhfLmAEb1OxizTdH+Qe+7NGkZ5+edLK0n5sB3N+YHgxN5KRiXmEoNB0wT5I5zP
         /+1w==
X-Gm-Message-State: AOJu0YyeC0F4BwXZ4qqvbQBiGDvIdfcgsjvcV0EDLTmSN3DcjSBcq5z8
	8nyDHnjZfNuxUgGpFfIu/PiQv3AGD6ISTqlWtkzSnaN3e9r0
X-Google-Smtp-Source: AGHT+IG3hQqwOEAuQIEe26wVuEJZ0hqaSYghTTXqBTohi8bagHfjNbU3GhlWTUQwbqnDsE5lrjQe3fr3XFikPueYIHg=
X-Received: by 2002:a2e:b0f2:0:b0:2cd:2ac6:9685 with SMTP id
 h18-20020a2eb0f2000000b002cd2ac69685mr3760083ljl.92.1705438552740; Tue, 16
 Jan 2024 12:55:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110073917.2398826-1-peterlin@andestech.com> <20240110073917.2398826-8-peterlin@andestech.com>
In-Reply-To: <20240110073917.2398826-8-peterlin@andestech.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Tue, 16 Jan 2024 12:55:41 -0800
Message-ID: <CAOnJCUKY8H+pvgTWW5zkfm8O4WR-OWOKmyPTcMjUZBCC5RaLWQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/16] RISC-V: Move T-Head PMU to CPU feature
 alternative framework
To: Yu Chien Peter Lin <peterlin@andestech.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	alexander.shishkin@linux.intel.com, andre.przywara@arm.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, conor+dt@kernel.org, 
	conor.dooley@microchip.com, conor@kernel.org, devicetree@vger.kernel.org, 
	dminus@andestech.com, evan@rivosinc.com, geert+renesas@glider.be, 
	guoren@kernel.org, heiko@sntech.de, irogers@google.com, 
	jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, locus84@andestech.com, magnus.damm@gmail.com, 
	mark.rutland@arm.com, mingo@redhat.com, n.shubin@yadro.com, 
	namhyung@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	peterz@infradead.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org, 
	sunilvl@ventanamicro.com, tglx@linutronix.de, tim609@andestech.com, 
	uwu@icenowy.me, wens@csie.org, will@kernel.org, ycliang@andestech.com, 
	inochiama@outlook.com, chao.wei@sophgo.com, unicorn_wang@outlook.com, 
	wefu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 11:40=E2=80=AFPM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> The custom PMU extension aims to support perf event sampling prior
> to the ratification of Sscofpmf. Instead of diverting the bits and
> register reserved for future standard, a set of custom registers is
> added.  Hence, we may consider it as a CPU feature rather than an
> erratum.
>

I don't think we should do that. Any custom implementation that
violates the standard RISC-V spec should
be an errata not a feature.
As per my understanding, a vendor can call an extension custom ISA
extension if the same feature is not available
in the standard ISA extensions or the mechanism is completely
different. It must also not violate any standard spec as well.

In this case, a standard sscofpmf is already available. Moreover, both
Andes and T-head extensions violate the standard
spec by reusing local interrupt numbers (17(Thead) & 18(Andes)) which
are clearly specified as reserved for standard local interrupts
in the AIA specification.

Please implementation Andes PMU support as an errata as well similar to T-h=
ead


> T-Head cores need to append "xtheadpmu" to the riscv,isa-extensions
> for each cpu node in device tree, and enable CONFIG_THEAD_CUSTOM_PMU
> for proper functioning as of this commit.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes v1 -> v2:
>   - New patch
> Changes v2 -> v3:
>   - Removed m{vendor/arch/imp}id checks in pmu_sbi_setup_irqs()
> Changes v3 -> v4:
>   - No change
> Changes v4 -> v5:
>   - Include Guo's Reviewed-by
>   - Let THEAD_CUSTOM_PMU depend on ARCH_THEAD
> Changes v5 -> v6:
>   - Include Conor's Reviewed-by
> Changes v6 -> v7:
>   - No change
> ---
>  arch/riscv/Kconfig.errata            | 13 -------------
>  arch/riscv/errata/thead/errata.c     | 19 -------------------
>  arch/riscv/include/asm/errata_list.h | 15 +--------------
>  arch/riscv/include/asm/hwcap.h       |  1 +
>  arch/riscv/kernel/cpufeature.c       |  1 +
>  drivers/perf/Kconfig                 | 13 +++++++++++++
>  drivers/perf/riscv_pmu_sbi.c         | 19 ++++++++++++++-----
>  7 files changed, 30 insertions(+), 51 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index e2c731cfed8c..0d19f47d1018 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -86,17 +86,4 @@ config ERRATA_THEAD_CMO
>
>           If you don't know what to do here, say "Y".
>
> -config ERRATA_THEAD_PMU
> -       bool "Apply T-Head PMU errata"
> -       depends on ERRATA_THEAD && RISCV_PMU_SBI
> -       default y
> -       help
> -         The T-Head C9xx cores implement a PMU overflow extension very
> -         similar to the core SSCOFPMF extension.
> -
> -         This will apply the overflow errata to handle the non-standard
> -         behaviour via the regular SBI PMU driver and interface.
> -
> -         If you don't know what to do here, say "Y".
> -
>  endmenu # "CPU errata selection"
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index 0554ed4bf087..5de5f7209132 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -53,22 +53,6 @@ static bool errata_probe_cmo(unsigned int stage,
>         return true;
>  }
>
> -static bool errata_probe_pmu(unsigned int stage,
> -                            unsigned long arch_id, unsigned long impid)
> -{
> -       if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PMU))
> -               return false;
> -
> -       /* target-c9xx cores report arch_id and impid as 0 */
> -       if (arch_id !=3D 0 || impid !=3D 0)
> -               return false;
> -
> -       if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
> -               return false;
> -
> -       return true;
> -}
> -
>  static u32 thead_errata_probe(unsigned int stage,
>                               unsigned long archid, unsigned long impid)
>  {
> @@ -80,9 +64,6 @@ static u32 thead_errata_probe(unsigned int stage,
>         if (errata_probe_cmo(stage, archid, impid))
>                 cpu_req_errata |=3D BIT(ERRATA_THEAD_CMO);
>
> -       if (errata_probe_pmu(stage, archid, impid))
> -               cpu_req_errata |=3D BIT(ERRATA_THEAD_PMU);
> -
>         return cpu_req_errata;
>  }
>
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index 4ed21a62158c..9bccc2ba0eb5 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -25,8 +25,7 @@
>  #ifdef CONFIG_ERRATA_THEAD
>  #define        ERRATA_THEAD_PBMT 0
>  #define        ERRATA_THEAD_CMO 1
> -#define        ERRATA_THEAD_PMU 2
> -#define        ERRATA_THEAD_NUMBER 3
> +#define        ERRATA_THEAD_NUMBER 2
>  #endif
>
>  #ifdef __ASSEMBLY__
> @@ -147,18 +146,6 @@ asm volatile(ALTERNATIVE_2(                         =
                       \
>             "r"((unsigned long)(_start) + (_size))                      \
>         : "a0")
>
> -#define THEAD_C9XX_RV_IRQ_PMU                  17
> -#define THEAD_C9XX_CSR_SCOUNTEROF              0x5c5
> -
> -#define ALT_SBI_PMU_OVERFLOW(__ovl)                                    \
> -asm volatile(ALTERNATIVE(                                              \
> -       "csrr %0, " __stringify(CSR_SSCOUNTOVF),                        \
> -       "csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),             \
> -               THEAD_VENDOR_ID, ERRATA_THEAD_PMU,                      \
> -               CONFIG_ERRATA_THEAD_PMU)                                \
> -       : "=3Dr" (__ovl) :                                               =
 \
> -       : "memory")
> -
>  #endif /* __ASSEMBLY__ */
>
>  #endif
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index 5340f818746b..480f9da7fba7 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -80,6 +80,7 @@
>  #define RISCV_ISA_EXT_ZFA              71
>  #define RISCV_ISA_EXT_ZTSO             72
>  #define RISCV_ISA_EXT_ZACAS            73
> +#define RISCV_ISA_EXT_XTHEADPMU                74
>
>  #define RISCV_ISA_EXT_MAX              128
>  #define RISCV_ISA_EXT_INVALID          U32_MAX
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index e32591e9da90..4aded5bf8fc3 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -303,6 +303,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>         __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>         __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>         __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> +       __RISCV_ISA_EXT_DATA(xtheadpmu, RISCV_ISA_EXT_XTHEADPMU),
>  };
>
>  const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 273d67ecf6d2..6cef15ec7c25 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -86,6 +86,19 @@ config RISCV_PMU_SBI
>           full perf feature support i.e. counter overflow, privilege mode
>           filtering, counter configuration.
>
> +config THEAD_CUSTOM_PMU
> +       bool "T-Head custom PMU support"
> +       depends on ARCH_THEAD && RISCV_ALTERNATIVE && RISCV_PMU_SBI
> +       default y
> +       help
> +         The T-Head C9xx cores implement a PMU overflow extension very
> +         similar to the core SSCOFPMF extension.
> +
> +         This will patch the overflow CSR and handle the non-standard
> +         behaviour via the regular SBI PMU driver and interface.
> +
> +         If you don't know what to do here, say "Y".
> +
>  config ARM_PMU_ACPI
>         depends on ARM_PMU && ACPI
>         def_bool y
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 2edbc37abadf..31ca79846399 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -20,10 +20,21 @@
>  #include <linux/cpu_pm.h>
>  #include <linux/sched/clock.h>
>
> -#include <asm/errata_list.h>
>  #include <asm/sbi.h>
>  #include <asm/cpufeature.h>
>
> +#define THEAD_C9XX_RV_IRQ_PMU          17
> +#define THEAD_C9XX_CSR_SCOUNTEROF      0x5c5
> +
> +#define ALT_SBI_PMU_OVERFLOW(__ovl)                                    \
> +asm volatile(ALTERNATIVE(                                              \
> +       "csrr %0, " __stringify(CSR_SSCOUNTOVF),                        \
> +       "csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),             \
> +               0, RISCV_ISA_EXT_XTHEADPMU,                             \
> +               CONFIG_THEAD_CUSTOM_PMU)                                \
> +       : "=3Dr" (__ovl) :                                               =
 \
> +       : "memory")
> +
>  #define SYSCTL_NO_USER_ACCESS  0
>  #define SYSCTL_USER_ACCESS     1
>  #define SYSCTL_LEGACY          2
> @@ -808,10 +819,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu,=
 struct platform_device *pde
>         if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
>                 riscv_pmu_irq_num =3D RV_IRQ_PMU;
>                 riscv_pmu_use_irq =3D true;
> -       } else if (IS_ENABLED(CONFIG_ERRATA_THEAD_PMU) &&
> -                  riscv_cached_mvendorid(0) =3D=3D THEAD_VENDOR_ID &&
> -                  riscv_cached_marchid(0) =3D=3D 0 &&
> -                  riscv_cached_mimpid(0) =3D=3D 0) {
> +       } else if (riscv_isa_extension_available(NULL, XTHEADPMU) &&
> +                  IS_ENABLED(CONFIG_THEAD_CUSTOM_PMU)) {
>                 riscv_pmu_irq_num =3D THEAD_C9XX_RV_IRQ_PMU;
>                 riscv_pmu_use_irq =3D true;
>         }
> --
> 2.34.1
>


--
Regards,
Atish

