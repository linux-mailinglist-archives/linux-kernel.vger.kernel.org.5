Return-Path: <linux-kernel+bounces-121421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4171288E7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B2C292FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D325145FE4;
	Wed, 27 Mar 2024 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kRfupJzc"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2949145353
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549401; cv=none; b=gVdQUxJjdGP/g9T8RaiZhTbNftd6NgZ9nVuIxrvR/oT/dW+pivtRS9O8AMWU34OwYDUCzF01ozJtLERNLxaP2gkbWhpUoZlFVie7j29dvrpDlPYheRDPk710ib6ImD9QsMFb6+ISnmvyxMIe1QDk+S+fWgo1096aSuXOHJ3g9gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549401; c=relaxed/simple;
	bh=TzGy4Nl10hTAM+7MIbRlkwoszFQuQWnX5BlJd7Ogg8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByxWsOETIJ8IbPIWaCMHNrFJb9wdpOu/TwxVRRsPxi0JQQDDCK7nk78wTHDCfaenF5TRQkn89TLnK/SYPLCpMBpwn1Okjcn1qrem1AV1svCVI7WZsWC6f2XEDai6azSE3zzyX/DDtldKHcyCcX2hqu5dg6mjFsm6U/SJ2N2OGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kRfupJzc; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso6261676276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711549399; x=1712154199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRFvGQGfmRLMn0TkT6BKRAVaaKQN9JenEnS46fWKpus=;
        b=kRfupJzcZI3m1CplUeO63CC/YZihfvZrHkoZchKtYj4KZWqgSIaTSL9ydMUaAO9LHh
         Dh//7AEKDxWeK2jtENF8c2Zh+n4r7n3XZg89877MLzN/Vsk7IymUXG4vPXOrsZVeNM2G
         C2MGBfJFNIG4/htTSd85PgQvDxbbM7GJNdlf/rQ0oeeHgWyIxipKSonKhxX1pYacMCRr
         HcooN6Fz9B+hK8+bvfJIes46/728t17aC87ztrR315hI3tElOBP78VTrZvZcf5G4Z4ix
         95FzU121ovcl7pyUCipSqSEgfz+0Dy2/DjPMIKCdFr9hxa8unlqegqstwX5A554fexCN
         p3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711549399; x=1712154199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRFvGQGfmRLMn0TkT6BKRAVaaKQN9JenEnS46fWKpus=;
        b=nQj1oJVSEvSnPegWb2x2ZaQ6DUejQD8syIzLwvcrxPF6e5lkRb6o5fZOu1ychIzU0Y
         f7Jcf8wwDGkkdTYY7HjYsxMX8CM8zsQuR3qOj7Qe3Pu2Fe8m+AlpQBOW+/+3wpbGkP30
         zL4Y1D2RX9F3BEiDnYdzAgQjeRw/Zbfwnz3FQvYNcgJHQg6rg3abpxFQqkwUxjMZDH7s
         VWHw1SaKWhbtFZiVifrQ1zgy/1UKA+eSAgyhRCnXEEDzPPSzFwc3JBcC4GNzb9pG5zHM
         m5AtSm2nZhUqeh/gsrr2J0bigK3LTSEh0jFi8JNUpfkbfQOOIdxVqcxj35YTcV1yQ37q
         v4Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVFnRE/mT499sB4O8lFowewAVJnalmVU0wCbULOBevg5S0kR+AquLasOjO0Ec8FUftihotz3C/XPgukOIQF9XP1P+mLQ3T6k6mgXRxm
X-Gm-Message-State: AOJu0YxAUuK9LDde6UIU7dzi6+Uoi1qSESK+ueGxCHgvE5xYy0TctWYU
	gvJdbvBnsvoIrS77YaH6myZtIy6j7bsTmsoc43EGrex+DvNWXg7TqETlbdh8NxSPZpUXd2v5q3r
	LgGI1bExSg+VB2jRbIeoqpLeKT2DtWnljIcOBbw==
X-Google-Smtp-Source: AGHT+IGYxBizN2LWi9Q0EujC00wGP+OXjEg8ECCcaoV2+WotPGFiM/+Sna09HESRfbDarEimOdKSDh0zNwdww7Nkw9M=
X-Received: by 2002:a25:7284:0:b0:dcb:e462:6e10 with SMTP id
 n126-20020a257284000000b00dcbe4626e10mr1148689ybc.58.1711549398808; Wed, 27
 Mar 2024 07:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326203017.310422-1-alexghiti@rivosinc.com> <20240326203017.310422-2-alexghiti@rivosinc.com>
In-Reply-To: <20240326203017.310422-2-alexghiti@rivosinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Wed, 27 Mar 2024 22:23:08 +0800
Message-ID: <CABgGipV1SaAxX6vL6CFdb-ctQtV2oA1=dE0zGZrrh2qbxDgkwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Fix warning by declaring arch_cpu_idle() as noinstr
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Puranjay Mohan <puranjay12@gmail.com>, Zong Li <zong.li@sifive.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Evgenii Shatokhin <e.shatokhin@yadro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 4:33=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
com> wrote:
>
> The following warning appears when using ftrace:
>
> [89855.443413] RCU not on for: arch_cpu_idle+0x0/0x1c
> [89855.445640] WARNING: CPU: 5 PID: 0 at include/linux/trace_recursion.h:=
162 arch_ftrace_ops_list_func+0x208/0x228
> [89855.445824] Modules linked in: xt_conntrack(E) nft_chain_nat(E) xt_MAS=
QUERADE(E) nf_conntrack_netlink(E) xt_addrtype(E) nft_compat(E) nf_tables(E=
) nfnetlink(E) br_netfilter(E) cfg80211(E) nls_iso8859_1(E) ofpart(E) redbo=
ot(E) cmdlinepart(E) cfi_cmdset_0001(E) virtio_net(E) cfi_probe(E) cfi_util=
(E) 9pnet_virtio(E) gen_probe(E) net_failover(E) virtio_rng(E) failover(E) =
9pnet(E) physmap(E) map_funcs(E) chipreg(E) mtd(E) uio_pdrv_genirq(E) uio(E=
) dm_multipath(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) drm(E) efi=
_pstore(E) backlight(E) ip_tables(E) x_tables(E) raid10(E) raid456(E) async=
_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) xor(E) async_tx(E)=
 raid6_pq(E) raid1(E) raid0(E) virtio_blk(E)
> [89855.451563] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G            E     =
 6.8.0-rc6ubuntu-defconfig #2
> [89855.451726] Hardware name: riscv-virtio,qemu (DT)
> [89855.451899] epc : arch_ftrace_ops_list_func+0x208/0x228
> [89855.452016]  ra : arch_ftrace_ops_list_func+0x208/0x228
> [89855.452119] epc : ffffffff8016b216 ra : ffffffff8016b216 sp : ffffaf80=
8090fdb0
> [89855.452171]  gp : ffffffff827c7680 tp : ffffaf808089ad40 t0 : ffffffff=
800c0dd8
> [89855.452216]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffffaf80=
8090fe30
> [89855.452306]  s1 : 0000000000000000 a0 : 0000000000000026 a1 : ffffffff=
82cd6ac8
> [89855.452423]  a2 : ffffffff800458c8 a3 : ffffaf80b1870640 a4 : 00000000=
00000000
> [89855.452646]  a5 : 0000000000000000 a6 : 00000000ffffffff a7 : ffffffff=
ffffffff
> [89855.452698]  s2 : ffffffff82766872 s3 : ffffffff80004caa s4 : ffffffff=
80ebea90
> [89855.452743]  s5 : ffffaf808089bd40 s6 : 8000000a00006e00 s7 : 00000000=
00000008
> [89855.452787]  s8 : 0000000000002000 s9 : 0000000080043700 s10: 00000000=
00000000
> [89855.452831]  s11: 0000000000000000 t3 : 0000000000100000 t4 : 00000000=
00000064
> [89855.452874]  t5 : 000000000000000c t6 : ffffaf80b182dbfc
> [89855.452929] status: 0000000200000100 badaddr: 0000000000000000 cause: =
0000000000000003
> [89855.453053] [<ffffffff8016b216>] arch_ftrace_ops_list_func+0x208/0x228
> [89855.453191] [<ffffffff8000e082>] ftrace_call+0x8/0x22
> [89855.453265] [<ffffffff800a149c>] do_idle+0x24c/0x2ca
> [89855.453357] [<ffffffff8000da54>] return_to_handler+0x0/0x26
> [89855.453429] [<ffffffff8000b716>] smp_callin+0x92/0xb6
> [89855.453785] ---[ end trace 0000000000000000 ]---
>
> To fix this, mark arch_cpu_idle() as noinstr, like it is done in commit
> a9cbc1b471d2 ("s390/idle: mark arch_cpu_idle() noinstr").
>
> Reported-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> Closes: https://lore.kernel.org/linux-riscv/51f21b87-ebed-4411-afbc-c00d3=
dea2bab@yadro.com/
> Fixes: cfbc4f81c9d0 ("riscv: Select ARCH_WANTS_NO_INSTR")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
Tested-by: Andy Chiu <andy.chiu@sifive.com>

> ---
>  arch/riscv/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 92922dbd5b5c..6abeecbfc51d 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -37,7 +37,7 @@ EXPORT_SYMBOL(__stack_chk_guard);
>
>  extern asmlinkage void ret_from_fork(void);
>
> -void arch_cpu_idle(void)
> +void noinstr arch_cpu_idle(void)
>  {
>         cpu_do_idle();
>  }
> --
> 2.39.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

