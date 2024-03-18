Return-Path: <linux-kernel+bounces-106575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E001B87F084
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574A41F2247E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D7556B65;
	Mon, 18 Mar 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="Cy7me06J"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66656454
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791076; cv=none; b=a8eEQnb18KgCyknmgnaPpZKG2/HbbvgPplh+bMTXmqrO/Qj77D69+0SeO1cD45TFv/e/IB7rcM08/w2zQ9iA6xVVfSu9UgzqKxT269tlx/0JFsxU/m0reHw8fvDxd9mFtp3zWLZU7GQUmWwbxLIH1RMCRZO211FiZd1T1IaGJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791076; c=relaxed/simple;
	bh=cAQ9WrTqkLpyvRl2HHwei3B0+LO/SKYWgIRsl8YLCHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BltEjWkyglOr+6E+e5vy33d7P2q5cSfmIW/jsUDAkhRlczQ1zRFyty0xx2E3cQsp/58c6gOULjOAFfQAYsi4s6E9y9EOzJOqlzngktX0XDXXrL4WCATuIegbbIO9wwsPcSn5OaHh1P3/RuQbe3+RCPF+Pe78rCOcnCAHmtM00Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=Cy7me06J; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513d212f818so5611861e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1710791072; x=1711395872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wng27roXh+1Oz6FjoTjsXspNwWV7X61+R2eoOFtPKaY=;
        b=Cy7me06JDdtM+T7I1g2Tik1mChlKHkmn3He0kSBKgcCtbIl0+mr+iexm3AD2mx+dp3
         tPptMeqLI3Ffi/j7UU6W3Y/RcBjpnrXefAf0Gcwn9tDth6k98ueVh3xAttPtC6XKjQYb
         pifK/guhMeQC+IQrJB/tUkYaRNCCnO0T2V/o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710791072; x=1711395872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wng27roXh+1Oz6FjoTjsXspNwWV7X61+R2eoOFtPKaY=;
        b=HeNh7tDlUFachJP+6BUsvBm6GVuN4FCktcbZzDOL/Orl/fGaw0Xm9wjee//uu7d3EU
         2/+i2/GuBIJcvVO944E06l0PXBfC/QM7i0VhJWT3eSGz65wm5S4FFxVYKg44ksOi4t7g
         qUMr/wWx1sKCMgKejicOR4SKUK3emLbxKFKTM24+Nuvpyj0450LVrv+BoH0gxk45bttT
         woYeESeNa5Ld+MXxnoLWsQ+6eX94EVBn1IaXnLKkEmDLiCFSrwMQiBAoO0YyVHENGa8U
         TjwoKQJiizC1hdsZx+Xj/YXyHFbGSGk73TH5VTma4Feu6LjxF5lfGFUMx13fai7FZ0Np
         jpPA==
X-Forwarded-Encrypted: i=1; AJvYcCUz7hYJ2pFEvdA3T72O6VVzJz0kt5UJ1l//032Vh7JaE+TbfikqzxV/nPqvhWWaV6yH/f46FM7lo0ljcx5bOJ6FR7tlkMFt/cd58gbs
X-Gm-Message-State: AOJu0YzHCCy8QR28bc31OOrqqGEfKJ68gvmtfQzhDjLlfyOTteGTtFCD
	GdoS/D4HsAaTc+x0fkTEPw1f8ni0XMg9yCuXxCKdXU7CV3rPVONdfwzzwJuOmwM2m1dxH6KPT7m
	8G4Mq5/hwLOwgY2NNsE2aLI5VxZvNWHH1QYY0
X-Google-Smtp-Source: AGHT+IFC+n2bFbyiMarJ9LqD0wduWXrQYT/qjE6We5ijlhy4Fj/TvbBK1djkRdCHgzav6P/ENwNhq4hG6vjZDNXg+QE=
X-Received: by 2002:a19:5f56:0:b0:513:ce5f:2a2a with SMTP id
 a22-20020a195f56000000b00513ce5f2a2amr7809396lfj.21.1710791071501; Mon, 18
 Mar 2024 12:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103165438.633054-1-samuel.holland@sifive.com>
In-Reply-To: <20240103165438.633054-1-samuel.holland@sifive.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 18 Mar 2024 12:44:19 -0700
Message-ID: <CAOnJCUJ4rC+Rrs6GV4t+=NWA=LtTZix5Nk1VzgP9CK-3+5-jAg@mail.gmail.com>
Subject: Re: [PATCH] perf: RISC-V: Check standard event availability
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 8:54=E2=80=AFAM Samuel Holland <samuel.holland@sifiv=
e.com> wrote:
>
> The RISC-V SBI PMU specification defines several standard hardware and
> cache events. Currently, all of these events appear in the `perf list`
> output, even if they are not actually implemented. Add logic to check
> which events are supported by the hardware (i.e. can be mapped to some
> counter), so only usable events are reported to userspace.
>

Thanks for the patch.
This adds tons of SBI calls at every boot for a use case which is at
best confusing for a subset of users who actually wants to run perf.
This probing can be done at runtime by invoking the
pmu_sbi_check_event from pmu_sbi_event_map.
We can update the event map after that so that it doesn't need to
invoke pmu_sbi_check_event next time.

> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> Before this patch:
> $ perf list hw
>
> List of pre-defined events (to be used in -e or -M):
>
>   branch-instructions OR branches                    [Hardware event]
>   branch-misses                                      [Hardware event]
>   bus-cycles                                         [Hardware event]
>   cache-misses                                       [Hardware event]
>   cache-references                                   [Hardware event]
>   cpu-cycles OR cycles                               [Hardware event]
>   instructions                                       [Hardware event]
>   ref-cycles                                         [Hardware event]
>   stalled-cycles-backend OR idle-cycles-backend      [Hardware event]
>   stalled-cycles-frontend OR idle-cycles-frontend    [Hardware event]
>
> $ perf stat -ddd true
>
>  Performance counter stats for 'true':
>
>               4.36 msec task-clock                       #    0.744 CPUs =
utilized
>                  1      context-switches                 #  229.325 /sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 38      page-faults                      #    8.714 K/sec
>          4,375,694      cycles                           #    1.003 GHz  =
                       (60.64%)
>            728,945      instructions                     #    0.17  insn =
per cycle
>             79,199      branches                         #   18.162 M/sec
>             17,709      branch-misses                    #   22.36% of al=
l branches
>            181,734      L1-dcache-loads                  #   41.676 M/sec
>              5,547      L1-dcache-load-misses            #    3.05% of al=
l L1-dcache accesses
>      <not counted>      LLC-loads                                        =
                       (0.00%)
>      <not counted>      LLC-load-misses                                  =
                       (0.00%)
>      <not counted>      L1-icache-loads                                  =
                       (0.00%)
>      <not counted>      L1-icache-load-misses                            =
                       (0.00%)
>      <not counted>      dTLB-loads                                       =
                       (0.00%)
>      <not counted>      dTLB-load-misses                                 =
                       (0.00%)
>      <not counted>      iTLB-loads                                       =
                       (0.00%)
>      <not counted>      iTLB-load-misses                                 =
                       (0.00%)
>      <not counted>      L1-dcache-prefetches                             =
                       (0.00%)
>      <not counted>      L1-dcache-prefetch-misses                        =
                       (0.00%)
>
>        0.005860375 seconds time elapsed
>
>        0.000000000 seconds user
>        0.010383000 seconds sys
>
> After this patch:
> $ perf list hw
>
> List of pre-defined events (to be used in -e or -M):
>
>   branch-instructions OR branches                    [Hardware event]
>   branch-misses                                      [Hardware event]
>   cache-misses                                       [Hardware event]
>   cache-references                                   [Hardware event]
>   cpu-cycles OR cycles                               [Hardware event]
>   instructions                                       [Hardware event]
>
> $ perf stat -ddd true
>
>  Performance counter stats for 'true':
>
>               5.16 msec task-clock                       #    0.848 CPUs =
utilized
>                  1      context-switches                 #  193.817 /sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 37      page-faults                      #    7.171 K/sec
>          5,183,625      cycles                           #    1.005 GHz
>            961,696      instructions                     #    0.19  insn =
per cycle
>             85,853      branches                         #   16.640 M/sec
>             20,462      branch-misses                    #   23.83% of al=
l branches
>            243,545      L1-dcache-loads                  #   47.203 M/sec
>              5,974      L1-dcache-load-misses            #    2.45% of al=
l L1-dcache accesses
>    <not supported>      LLC-loads
>    <not supported>      LLC-load-misses
>    <not supported>      L1-icache-loads
>    <not supported>      L1-icache-load-misses
>    <not supported>      dTLB-loads
>             19,619      dTLB-load-misses
>    <not supported>      iTLB-loads
>              6,831      iTLB-load-misses
>    <not supported>      L1-dcache-prefetches
>    <not supported>      L1-dcache-prefetch-misses
>
>        0.006085625 seconds time elapsed
>
>        0.000000000 seconds user
>        0.013022000 seconds sys
>
>
>  drivers/perf/riscv_pmu_sbi.c | 37 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 16acd4dcdb96..b58a70ee8317 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -86,7 +86,7 @@ struct sbi_pmu_event_data {
>         };
>  };
>
> -static const struct sbi_pmu_event_data pmu_hw_event_map[] =3D {
> +static struct sbi_pmu_event_data pmu_hw_event_map[] =3D {
>         [PERF_COUNT_HW_CPU_CYCLES]              =3D {.hw_gen_event =3D {
>                                                         SBI_PMU_HW_CPU_CY=
CLES,
>                                                         SBI_PMU_EVENT_TYP=
E_HW, 0}},
> @@ -120,7 +120,7 @@ static const struct sbi_pmu_event_data pmu_hw_event_m=
ap[] =3D {
>  };
>
>  #define C(x) PERF_COUNT_HW_CACHE_##x
> -static const struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW=
_CACHE_MAX]
> +static struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE=
_MAX]
>  [PERF_COUNT_HW_CACHE_OP_MAX]
>  [PERF_COUNT_HW_CACHE_RESULT_MAX] =3D {
>         [C(L1D)] =3D {
> @@ -265,6 +265,36 @@ static const struct sbi_pmu_event_data pmu_cache_eve=
nt_map[PERF_COUNT_HW_CACHE_M
>         },
>  };
>
> +static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
> +{
> +       struct sbiret ret;
> +
> +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
> +                       0, cmask, 0, edata->event_idx, 0, 0);
> +       if (!ret.error) {
> +               sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> +                         ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, 0, 0, =
0);
> +       } else if (ret.error =3D=3D SBI_ERR_NOT_SUPPORTED) {
> +               /* This event cannot be monitored by any counter */
> +               edata->event_idx =3D -EINVAL;
> +       }
> +}
> +
> +static void pmu_sbi_update_events(void)
> +{
> +       /* Ensure events are not already mapped to a counter */
> +       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> +                 0, cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
> +
> +       for (int i =3D 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
> +               pmu_sbi_check_event(&pmu_hw_event_map[i]);
> +
> +       for (int i =3D 0; i < ARRAY_SIZE(pmu_cache_event_map); i++)
> +               for (int j =3D 0; j < ARRAY_SIZE(pmu_cache_event_map[i]);=
 j++)
> +                       for (int k =3D 0; k < ARRAY_SIZE(pmu_cache_event_=
map[i][j]); k++)
> +                               pmu_sbi_check_event(&pmu_cache_event_map[=
i][j][k]);
> +}
> +
>  static int pmu_sbi_ctr_get_width(int idx)
>  {
>         return pmu_ctr_list[idx].width;
> @@ -1046,6 +1076,9 @@ static int pmu_sbi_device_probe(struct platform_dev=
ice *pdev)
>         if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
>                 goto out_free;
>
> +       /* Check which standard events are available */
> +       pmu_sbi_update_events();
> +
>         ret =3D pmu_sbi_setup_irqs(pmu, pdev);
>         if (ret < 0) {
>                 pr_info("Perf sampling/filtering is not supported as ssco=
f extension is not available\n");
> --
> 2.42.0
>


--
Regards,
Atish

