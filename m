Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7D7E6F8A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344682AbjKIQmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344471AbjKIQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:42:00 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD02F4C3D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:39:25 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a3b8b113so1333416e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 08:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1699547964; x=1700152764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atQyaUFkAqX5qmMmzzgQjx0K17zbIjjTNmAZ0V3dWZI=;
        b=BCr0qTzs7lEZCeYPrvWEmdMNGDKCYOZzFvqgIzgLOm3oEWJY12jajGzmUxDZtcwIPz
         ds368Qrtq8IscAcG3Lqms8l8uvxhznVzvo83XjigcU2rloXSAxB7UvwW6Vmr8Yonw5x4
         dFG3mhqhU8l+0k+NP0fQ3oJAxsbHLl3rGkEQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699547964; x=1700152764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atQyaUFkAqX5qmMmzzgQjx0K17zbIjjTNmAZ0V3dWZI=;
        b=G+IRLM3U0gk+cjlJx+QNHmPtY4Q561oxL0q40DXO6azwMsc98ID2PcsF/p6uAEBU0B
         kWWBgQj76QjDa24xY32M21DmRHL4oUOyBqYE7Qr4wjdDojA9Bk18/Z9+aA7KaP4taB3n
         XZPuVP9gxTnj1DDHraRq391xgK6+BZl+rqooEX22Av/nPWicSOGzhR3XX3JJw/kANshH
         XXB5tMZiHoQh/zWqlVM6MH7Z6wTL3OsNwfA60IsVX2txUmce9zfqxat6oYBW4GLZuc2E
         w6tkuxqslDV7K5/BB2i4uo0a+1axrJYl/m4RfS/aPPIaFKYu7b37EL4b0gBGzgFqYSaa
         p6BA==
X-Gm-Message-State: AOJu0YywqCGDmTjIWTwPatENvfruosFwcT5hJyeYWxUI+hRv4xxV/lUO
        sMt4tzKTIpSrhapH7NjJ0TrtV9iVk1Qin+AC37NY
X-Google-Smtp-Source: AGHT+IHBsz0PHZnxhlurVy6KslRTl6XJyaMy6lqOTIMhnZ9YrCBOsefCTGgSn/XDKAZSr88De4l0TgG/wgOCVtFwBdM=
X-Received: by 2002:a19:5215:0:b0:505:7371:ec83 with SMTP id
 m21-20020a195215000000b005057371ec83mr1970987lfb.48.1699547963798; Thu, 09
 Nov 2023 08:39:23 -0800 (PST)
MIME-Version: 1.0
References: <20231109082128.40777-1-alexghiti@rivosinc.com>
In-Reply-To: <20231109082128.40777-1-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 9 Nov 2023 08:39:13 -0800
Message-ID: <CAOnJCUK+guaWFsefnU80tfedkBU9hNWtOX9LqbXVT4JhEUf6Rw@mail.gmail.com>
Subject: Re: [PATCH] drivers: perf: Check find_first_bit() return value
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 12:21=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> We must check the return value of find_first_bit() before using the
> return value as an index array since it happens to overflow the array
> and then panic:
>
> [  107.318430] Kernel BUG [#1]
> [  107.319434] CPU: 3 PID: 1238 Comm: kill Tainted: G            E      6=
.6.0-rc6ubuntu-defconfig #2
> [  107.319465] Hardware name: riscv-virtio,qemu (DT)
> [  107.319551] epc : pmu_sbi_ovf_handler+0x3a4/0x3ae
> [  107.319840]  ra : pmu_sbi_ovf_handler+0x52/0x3ae
> [  107.319868] epc : ffffffff80a0a77c ra : ffffffff80a0a42a sp : ffffaf83=
fecda350
> [  107.319884]  gp : ffffffff823961a8 tp : ffffaf8083db1dc0 t0 : ffffaf83=
fecda480
> [  107.319899]  t1 : ffffffff80cafe62 t2 : 000000000000ff00 s0 : ffffaf83=
fecda520
> [  107.319921]  s1 : ffffaf83fecda380 a0 : 00000018fca29df0 a1 : ffffffff=
ffffffff
> [  107.319936]  a2 : 0000000001073734 a3 : 0000000000000004 a4 : 00000000=
00000000
> [  107.319951]  a5 : 0000000000000040 a6 : 000000001d1c8774 a7 : 00000000=
00504d55
> [  107.319965]  s2 : ffffffff82451f10 s3 : ffffffff82724e70 s4 : 00000000=
0000003f
> [  107.319980]  s5 : 0000000000000011 s6 : ffffaf8083db27c0 s7 : 00000000=
00000000
> [  107.319995]  s8 : 0000000000000001 s9 : 00007fffb45d6558 s10: 00007fff=
b45d81a0
> [  107.320009]  s11: ffffaf7ffff60000 t3 : 0000000000000004 t4 : 00000000=
00000000
> [  107.320023]  t5 : ffffaf7f80000000 t6 : ffffaf8000000000
> [  107.320037] status: 0000000200000100 badaddr: 0000000000000000 cause: =
0000000000000003
> [  107.320081] [<ffffffff80a0a77c>] pmu_sbi_ovf_handler+0x3a4/0x3ae
> [  107.320112] [<ffffffff800b42d0>] handle_percpu_devid_irq+0x9e/0x1a0
> [  107.320131] [<ffffffff800ad92c>] generic_handle_domain_irq+0x28/0x36
> [  107.320148] [<ffffffff8065f9f8>] riscv_intc_irq+0x36/0x4e
> [  107.320166] [<ffffffff80caf4a0>] handle_riscv_irq+0x54/0x86
> [  107.320189] [<ffffffff80cb0036>] do_irq+0x64/0x96
> [  107.320271] Code: 85a6 855e b097 ff7f 80e7 9220 b709 9002 4501 bbd9 (9=
002) 6097
> [  107.320585] ---[ end trace 0000000000000000 ]---
> [  107.320704] Kernel panic - not syncing: Fatal exception in interrupt
> [  107.320775] SMP: stopping secondary CPUs
> [  107.321219] Kernel Offset: 0x0 from 0xffffffff80000000
> [  107.333051] ---[ end Kernel panic - not syncing: Fatal exception in in=
terrupt ]---
>
> Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 439da49dd0a9..93d729213140 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -687,6 +687,11 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void=
 *dev)
>
>         /* Firmware counter don't support overflow yet */
>         fidx =3D find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNT=
ERS);
> +       if (fidx =3D=3D RISCV_MAX_COUNTERS) {
> +               csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> +               return IRQ_NONE;
> +       }
> +
>         event =3D cpu_hw_evt->events[fidx];
>         if (!event) {
>                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> --
> 2.39.2
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
