Return-Path: <linux-kernel+bounces-87895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E3186DAD1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7FD1F24C62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038D5026C;
	Fri,  1 Mar 2024 04:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ZkMfrrtp"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D11DFCF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 04:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709268226; cv=none; b=og94vuSoJlEUhcIq2tRA+Vg5ZfxwkxT6h5Q8BrfI+6poonHuIUjdygtnB8/lS0tkGbE/7IM4u0mMXJ8XR4/bAQWCRE6aoEEIw/T5opB+5/RLr5LAMQXfp06Rbcdum9+8DCljukKIctRWFdLGrHVgHMzwnm82gSLfW5KZnfHLWAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709268226; c=relaxed/simple;
	bh=xyHAs22Xo3Cq+1aeu1IEMp8xwYTqfcFhrG7ehR+YQQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSP04AIHlQzuW1bkYR8/LHWmbzlXOEUfVLUvVmWPpzQIiC9lxOLBTKcy23Z5QfrB43EQ3oWYU+HvA9f7Kcpmdusem50HkA1oTvtO/OVJTlGQoDoM6KrbJiWdu1LkSA4d2mBlUAgcpI+Nx6Xonh6LRsx2sg4B0cBOtZNAvLeB6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=ZkMfrrtp; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-365138d9635so6198915ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1709268223; x=1709873023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyczRoc8zwOC9hsxzaj2db9K2Y/ZvntkudwAJJn92Yc=;
        b=ZkMfrrtp3CcwJrFf0CALYH3z7bn8xMOznlip5vnSJ1HbhqWzR5hbzOB0QmN2t4OP40
         gc4Mz8XpgL+pfuIXH7/nn2DmTuToawrwa8lhdCEt8/BRniFf/YcZ/TTsK90dEbzCeZs2
         86YHjOfOI5G3w0TrqE1NuUoATRYItFeLb1wemnmfoV514sDTGRKGgJ8PnOJ0eoIIkAt5
         zPzdqyFLUl+MQjzhjNqlEDAQihf3KsY5qDtyX0TN44WFIrrsvJRjGMb1BrgE1nWOr90k
         /d2luxTSE5XriolOlMRYKBr5KmFfNhbbUhLsdIJE/o1VP/IA0qPZItUbaW1H88bwIUkB
         l8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709268223; x=1709873023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyczRoc8zwOC9hsxzaj2db9K2Y/ZvntkudwAJJn92Yc=;
        b=K6XOkxC2KstGmteB5eVEbUzmLpKmEiMjU9QC8BHrG7Q7S2l6r7pLdBBNxeUQJaKsap
         z6dAYmbehIIAOIsvohwwglf/GNDEbG8AZy13sZ0V/Cv2s35Wm6ApZXmvhfXc1vsZ6iQI
         tM6nQULdVuZaQZHEHCTqaF0LwMDVmsuR1hrji3+ArLZn/sf8foaoSn40nRlBYap857tj
         Wt8jAzXb9UJQPJffj5EJQsV/sjPzOzeEyn4VvhfkctE3/W9jcThQ/W2oXOHGThOzqITJ
         hH7t4ipBXu1tIVkHkvIfO7sYYadMMISNjDnQh8DqgASiYb6S88d/RRnsAxpgX1r8eakI
         7RnA==
X-Gm-Message-State: AOJu0Yw9XYrQV4i4vqEdZv/7vPMeleeIb3CKIJazNyep80sr5VPxt6jV
	MGy694R3MmDDTFZGmQH14VV1ZayYbtQKcHH79I8/XEiqX3Evusoz9RG5uayfndzw8bk3YNVLnWT
	a4zRMUMK6YYpwtvR+TxKJLj0wMw1T63NFLaEGPR+YIpP/M+CvAwk=
X-Google-Smtp-Source: AGHT+IG5k0AX4t9auWvUQGZiAPhOmG+SFKwOcgiizsw7rn22vzkIfMNNM5wDrv0r5mB1hHq5kIOCmv2BDDZ7Ocf6jq8=
X-Received: by 2002:a05:6e02:190f:b0:365:10dd:d1aa with SMTP id
 w15-20020a056e02190f00b0036510ddd1aamr868808ilu.16.1709268223495; Thu, 29 Feb
 2024 20:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229010130.1380926-1-atishp@rivosinc.com> <20240229010130.1380926-13-atishp@rivosinc.com>
In-Reply-To: <20240229010130.1380926-13-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 1 Mar 2024 10:13:33 +0530
Message-ID: <CAAhSdy3U7Ut5yhth0nArsSaBNT2SHdUE8mgAyRdtkzsYqF7cXw@mail.gmail.com>
Subject: Re: [PATCH v4 12/15] KVM: riscv: selftests: Add SBI PMU extension definitions
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:32=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> The SBI PMU extension definition is required for upcoming SBI PMU
> selftests.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  .../selftests/kvm/include/riscv/processor.h   | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tool=
s/testing/selftests/kvm/include/riscv/processor.h
> index f75c381fa35a..a49a39c8e8d4 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -169,17 +169,84 @@ void vm_install_exception_handler(struct kvm_vm *vm=
, int vector, exception_handl
>  enum sbi_ext_id {
>         SBI_EXT_BASE =3D 0x10,
>         SBI_EXT_STA =3D 0x535441,
> +       SBI_EXT_PMU =3D 0x504D55,
>  };
>
>  enum sbi_ext_base_fid {
>         SBI_EXT_BASE_PROBE_EXT =3D 3,
>  };
>
> +enum sbi_ext_pmu_fid {
> +       SBI_EXT_PMU_NUM_COUNTERS =3D 0,
> +       SBI_EXT_PMU_COUNTER_GET_INFO,
> +       SBI_EXT_PMU_COUNTER_CFG_MATCH,
> +       SBI_EXT_PMU_COUNTER_START,
> +       SBI_EXT_PMU_COUNTER_STOP,
> +       SBI_EXT_PMU_COUNTER_FW_READ,
> +       SBI_EXT_PMU_COUNTER_FW_READ_HI,
> +       SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
> +};
> +
> +union sbi_pmu_ctr_info {
> +       unsigned long value;
> +       struct {
> +               unsigned long csr:12;
> +               unsigned long width:6;
> +#if __riscv_xlen =3D=3D 32
> +               unsigned long reserved:13;
> +#else
> +               unsigned long reserved:45;
> +#endif
> +               unsigned long type:1;
> +       };
> +};
> +
>  struct sbiret {
>         long error;
>         long value;
>  };
>
> +/** General pmu event codes specified in SBI PMU extension */
> +enum sbi_pmu_hw_generic_events_t {
> +       SBI_PMU_HW_NO_EVENT                     =3D 0,
> +       SBI_PMU_HW_CPU_CYCLES                   =3D 1,
> +       SBI_PMU_HW_INSTRUCTIONS                 =3D 2,
> +       SBI_PMU_HW_CACHE_REFERENCES             =3D 3,
> +       SBI_PMU_HW_CACHE_MISSES                 =3D 4,
> +       SBI_PMU_HW_BRANCH_INSTRUCTIONS          =3D 5,
> +       SBI_PMU_HW_BRANCH_MISSES                =3D 6,
> +       SBI_PMU_HW_BUS_CYCLES                   =3D 7,
> +       SBI_PMU_HW_STALLED_CYCLES_FRONTEND      =3D 8,
> +       SBI_PMU_HW_STALLED_CYCLES_BACKEND       =3D 9,
> +       SBI_PMU_HW_REF_CPU_CYCLES               =3D 10,
> +
> +       SBI_PMU_HW_GENERAL_MAX,
> +};
> +
> +/* SBI PMU counter types */
> +enum sbi_pmu_ctr_type {
> +       SBI_PMU_CTR_TYPE_HW =3D 0x0,
> +       SBI_PMU_CTR_TYPE_FW,
> +};
> +
> +/* Flags defined for config matching function */
> +#define SBI_PMU_CFG_FLAG_SKIP_MATCH    (1 << 0)
> +#define SBI_PMU_CFG_FLAG_CLEAR_VALUE   (1 << 1)
> +#define SBI_PMU_CFG_FLAG_AUTO_START    (1 << 2)
> +#define SBI_PMU_CFG_FLAG_SET_VUINH     (1 << 3)
> +#define SBI_PMU_CFG_FLAG_SET_VSINH     (1 << 4)
> +#define SBI_PMU_CFG_FLAG_SET_UINH      (1 << 5)
> +#define SBI_PMU_CFG_FLAG_SET_SINH      (1 << 6)
> +#define SBI_PMU_CFG_FLAG_SET_MINH      (1 << 7)
> +
> +/* Flags defined for counter start function */
> +#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
> +#define SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT BIT(1)
> +
> +/* Flags defined for counter stop function */
> +#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> +#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
> +
>  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>                         unsigned long arg1, unsigned long arg2,
>                         unsigned long arg3, unsigned long arg4,
> --
> 2.34.1
>

