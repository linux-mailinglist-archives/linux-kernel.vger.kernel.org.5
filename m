Return-Path: <linux-kernel+bounces-10971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A7E81DF6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842E12817CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B084C7D;
	Mon, 25 Dec 2023 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJdyYzgm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5646E3D74
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BADC433CB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703495969;
	bh=WG1sEWmjow0+wzQWO8sC1Bb4aBpDgDRtvCU7WFHYPis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SJdyYzgmH4uDLkmiZXlZaKzEE+pSwQIF18BhlsssXRgOhr3SV6iUAhj0dAH1MJ5ns
	 QLxMpAAHDR4/hbq+u5MtpeNwiZnazyLIVnV2TVy5/s2V+UYDafL+AD7yDtLQAoSn8O
	 hQhh9JGzAc7wPKu1dSksPlB7DBjwilxrWYNpt8AOqAaSsrtMl8OU/Ikmr4uljubou3
	 u44nTQajYTZej/4wjyALU3qrW+YcHw+Cb91gv4wNBvJh3K7LidW8Pve1phe9lsz5hB
	 j2l33DI94fDLHq+52eILdJQxfp8dyB1CqG7ZxoJ+8rJTbZD7iv/sDskrkURTxvvYYb
	 FknR9aRf8wPGw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a235eb41251so417396366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 01:19:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yzzez71pUVJjAyRj2s3MXoCS7lTO3J0BTPPS58Lk43UDd4PMQD6
	e55UFfy29R5IdEZAXWIpsdQELa5ngCPbpRjQbQw=
X-Google-Smtp-Source: AGHT+IE9M++PnvplzZ1Xf7PbU8w+/QtILR/53UtmVidnO4ITb5zRDK494EwW5mpqgvdoLmZ5+g7r+Rja7OMs/yxK5TM=
X-Received: by 2002:a17:906:1dd:b0:a26:9924:cb1f with SMTP id
 29-20020a17090601dd00b00a269924cb1fmr1479093ejj.141.1703495968305; Mon, 25
 Dec 2023 01:19:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225070002.1350705-1-chenhuacai@loongson.cn> <3db5c086-db9b-cb3a-5521-44f18cb55c4a@loongson.cn>
In-Reply-To: <3db5c086-db9b-cb3a-5521-44f18cb55c4a@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 25 Dec 2023 17:19:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Rs4BGKHZrA5bxSh0=4uhPx7vbVwBXtdtfU4hemN2QjA@mail.gmail.com>
Message-ID: <CAAhV-H5Rs4BGKHZrA5bxSh0=4uhPx7vbVwBXtdtfU4hemN2QjA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Let cores_io_master cover the largest NR_CPUS
To: maobibo <maobibo@loongson.cn>
Cc: loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev, 
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 5:13=E2=80=AFPM maobibo <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2023/12/25 =E4=B8=8B=E5=8D=883:00, Huacai Chen wrote:
> > Now loongson_system_configuration::cores_io_master only covers 64 cpus,
> > if NR_CPUS > 64 there will be memory corruption. So let cores_io_master
> > cover the largest NR_CPUS (256).
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/bootinfo.h | 4 ++--
> >   arch/loongarch/kernel/acpi.c          | 2 +-
> >   arch/loongarch/kernel/smp.c           | 2 +-
> >   3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/inc=
lude/asm/bootinfo.h
> > index c60796869b2b..32fd0319594a 100644
> > --- a/arch/loongarch/include/asm/bootinfo.h
> > +++ b/arch/loongarch/include/asm/bootinfo.h
> > @@ -30,7 +30,7 @@ struct loongson_system_configuration {
> >       int boot_cpu_id;
> >       int cores_per_node;
> >       int cores_per_package;
> > -     unsigned long cores_io_master;
> > +     unsigned long cores_io_master[4];
> Can the hardcoded 4 be defined something like this?
>     DIV_ROUND_UP(CONFIG_NR_CPUS, sizeof(long))
Can this be used to define arrays?

Huacai

>
> the others LGTM.
>
> Regards
> Bibo Mao
> >       unsigned long suspend_addr;
> >       const char *cpuname;
> >   };
> > @@ -42,7 +42,7 @@ extern struct loongson_system_configuration loongson_=
sysconf;
> >
> >   static inline bool io_master(int cpu)
> >   {
> > -     return test_bit(cpu, &loongson_sysconf.cores_io_master);
> > +     return test_bit(cpu, loongson_sysconf.cores_io_master);
> >   }
> >
> >   #endif /* _ASM_BOOTINFO_H */
> > diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.=
c
> > index 8e00a754e548..b6b097bbf866 100644
> > --- a/arch/loongarch/kernel/acpi.c
> > +++ b/arch/loongarch/kernel/acpi.c
> > @@ -119,7 +119,7 @@ acpi_parse_eio_master(union acpi_subtable_headers *=
header, const unsigned long e
> >               return -EINVAL;
> >
> >       core =3D eiointc->node * CORES_PER_EIO_NODE;
> > -     set_bit(core, &(loongson_sysconf.cores_io_master));
> > +     set_bit(core, loongson_sysconf.cores_io_master);
> >
> >       return 0;
> >   }
> > diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> > index 9e33b5e36122..a16e3dbe9f09 100644
> > --- a/arch/loongarch/kernel/smp.c
> > +++ b/arch/loongarch/kernel/smp.c
> > @@ -208,7 +208,7 @@ static void __init fdt_smp_setup(void)
> >       }
> >
> >       loongson_sysconf.nr_cpus =3D num_processors;
> > -     set_bit(0, &(loongson_sysconf.cores_io_master));
> > +     set_bit(0, loongson_sysconf.cores_io_master);
> >   #endif
> >   }
> >
> >
>

