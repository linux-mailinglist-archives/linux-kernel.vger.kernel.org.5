Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32C77ECC0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346764AbjHPWKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346825AbjHPWKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:10:14 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DD726AD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:10:13 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40a47e8e38dso53211cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692223812; x=1692828612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFjB2tLQIoSeAgU5IVsLBX1N7i27DDlVtUelL66J7Zc=;
        b=nmWPyeOAAxC0artxP5WclYBb/QHjLfhpVy5u3AQjYt5138vxBvKZgPinLsXh/Kf9IO
         lgBKTfuzFCYmS2PjU69kZy6UvlLs+VPhElTcxwGg1fKCnGViHqYPVARPYmuHw6NBIegV
         /EpEXDfy69XTd9S29+HdUFEdEkmYbLwubeWBvPA4Kw/AxOj/P1MTmxZgh1lrya/WK8V1
         PWKvFcHibJplRjDCFzzwCl1e1B5pK/KsUYY4riXl6GaiAcsas+DTbM+aKEugsRIyQslL
         db5wp6vwKeA9cz3VSjCCILHkY4UN1WPo+t8n5CoOzZDHkWLAgO862YvhfDslbmDklGDv
         MccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692223812; x=1692828612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFjB2tLQIoSeAgU5IVsLBX1N7i27DDlVtUelL66J7Zc=;
        b=gqRJpoN7z1EYG91Y6vFI5B7cTm8H5wXG5DSFeCcodQ8DNPjFFcldnMEL6m/upua8/Q
         y2PZDv+FIgB4RhqEVgMRbry7LG1V+FSmDjHlxlPLk0w6VQ0Q8CYp9qwDqkTOM6RxCwDf
         Om1mvud5u0tKScpNUWx6VB/LjZgubJrx2iZ200GcjRILDp2I5v+0tmQ8/NnFcCUSElg9
         cRdi0CF2x4bH103YfwviaJw9TFQMS5Y2W7Ne3FZKpIj7UzPB2MlBzh4TyAfpIO+uoDsZ
         h4mkCj8NMav0RNmU+pJWklgzqMk/8/Qi1hwgZ5sOelZLPvvqGvk2eVRefv0w42xA9byW
         u8VQ==
X-Gm-Message-State: AOJu0YwLTcEDBAXpDR513icksUB9MIMWVMqGxGJ2j7KKwgGiPs19qa+H
        CFdFqYQD4ye6etqhK7DqL9IUyl63p6wOgi0gIb+t8Q==
X-Google-Smtp-Source: AGHT+IGOauo1lTRA1jBKb7+Ni+dPfId9cr9MgoJ2mEt37FOpIvgTUxVmW3ZENT9ywO8zxCY6lYHK2hYMp9TEjWlC1KI=
X-Received: by 2002:a05:622a:1887:b0:403:b6ff:c0b with SMTP id
 v7-20020a05622a188700b00403b6ff0c0bmr119146qtc.6.1692223812100; Wed, 16 Aug
 2023 15:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <ZN1ELw41wQE5zDrK@kernel.org>
In-Reply-To: <ZN1ELw41wQE5zDrK@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Aug 2023 15:10:00 -0700
Message-ID: <CAP-5=fVU07VHcQE6r9k7aEV+xM3_HFcgY+5Y8N7qVvsZD3V9vg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf bpf_skel augmented_raw_syscalls: Cap the socklen
 parameter using &= sizeof(saddr)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 2:48=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> This works with:
>
>   $ clang -v
>   clang version 14.0.5 (Fedora 14.0.5-2.fc36)
>   $
>
> But not with:
>
>   $ clang -v
>   clang version 16.0.6 (Fedora 16.0.6-2.fc38)
>   $
>
>   [root@quaco ~]# perf trace -e connect*,sendto* ping -c 10 localhost
>   libbpf: prog 'sys_enter_sendto': BPF program load failed: Permission de=
nied
>   libbpf: prog 'sys_enter_sendto': -- BEGIN PROG LOAD LOG --
>   reg type unsupported for arg#0 function sys_enter_sendto#59
>   0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
>   ; int sys_enter_sendto(struct syscall_enter_args *args)
>   0: (bf) r6 =3D r1                       ; R1=3Dctx(off=3D0,imm=3D0) R6_=
w=3Dctx(off=3D0,imm=3D0)
>   1: (b7) r1 =3D 0                        ; R1_w=3D0
>   ; int key =3D 0;
>   2: (63) *(u32 *)(r10 -4) =3D r1         ; R1_w=3D0 R10=3Dfp0 fp-8=3D000=
0????
>   3: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
>   ;
>   4: (07) r2 +=3D -4                      ; R2_w=3Dfp-4
>   ; return bpf_map_lookup_elem(&augmented_args_tmp, &key);
>   5: (18) r1 =3D 0xffff8de5a5b8bc00       ; R1_w=3Dmap_ptr(off=3D0,ks=3D4=
,vs=3D8272,imm=3D0)
>   7: (85) call bpf_map_lookup_elem#1    ; R0_w=3Dmap_value_or_null(id=3D1=
,off=3D0,ks=3D4,vs=3D8272,imm=3D0)
>   8: (bf) r7 =3D r0                       ; R0_w=3Dmap_value_or_null(id=
=3D1,off=3D0,ks=3D4,vs=3D8272,imm=3D0) R7_w=3Dmap_value_or_null(id=3D1,off=
=3D0,ks=3D4,vs=3D8272,imm=3D0)
>   9: (b7) r0 =3D 1                        ; R0_w=3D1
>   ; if (augmented_args =3D=3D NULL)
>   10: (15) if r7 =3D=3D 0x0 goto pc+25      ; R7_w=3Dmap_value(off=3D0,ks=
=3D4,vs=3D8272,imm=3D0)
>   ; unsigned int socklen =3D args->args[5];
>   11: (79) r1 =3D *(u64 *)(r6 +56)        ; R1_w=3Dscalar() R6_w=3Dctx(of=
f=3D0,imm=3D0)
>   ;
>   12: (bf) r2 =3D r1                      ; R1_w=3Dscalar(id=3D2) R2_w=3D=
scalar(id=3D2)
>   13: (67) r2 <<=3D 32                    ; R2_w=3Dscalar(smax=3D92233720=
32559808512,umax=3D18446744069414584320,var_off=3D(0x0; 0xffffffff00000000)=
,s32_min=3D0,s32_max=3D0,u32_max=3D0)
>   14: (77) r2 >>=3D 32                    ; R2_w=3Dscalar(umax=3D42949672=
95,var_off=3D(0x0; 0xffffffff))
>   15: (b7) r8 =3D 128                     ; R8=3D128
>   ; if (socklen > sizeof(augmented_args->saddr))
>   16: (25) if r2 > 0x80 goto pc+1       ; R2=3Dscalar(umax=3D128,var_off=
=3D(0x0; 0xff))
>   17: (bf) r8 =3D r1                      ; R1=3Dscalar(id=3D2) R8_w=3Dsc=
alar(id=3D2)
>   ; const void *sockaddr_arg =3D (const void *)args->args[4];
>   18: (79) r3 =3D *(u64 *)(r6 +48)        ; R3_w=3Dscalar() R6=3Dctx(off=
=3D0,imm=3D0)
>   ; bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
>   19: (bf) r1 =3D r7                      ; R1_w=3Dmap_value(off=3D0,ks=
=3D4,vs=3D8272,imm=3D0) R7=3Dmap_value(off=3D0,ks=3D4,vs=3D8272,imm=3D0)
>   20: (07) r1 +=3D 64                     ; R1_w=3Dmap_value(off=3D64,ks=
=3D4,vs=3D8272,imm=3D0)
>   ; bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
>   21: (bf) r2 =3D r8                      ; R2_w=3Dscalar(id=3D2) R8_w=3D=
scalar(id=3D2)
>   22: (85) call bpf_probe_read#4
>   R2 min value is negative, either use unsigned or 'var &=3D const'
>   processed 22 insns (limit 1000000) max_states_per_insn 0 total_states 1=
 peak_states 1 mark_read 1
>   -- END PROG LOAD LOG --
>   libbpf: prog 'sys_enter_sendto': failed to load: -13
>   libbpf: failed to load object 'augmented_raw_syscalls_bpf'
>   libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13
>
> So use the suggested &=3D variant since sizeof(saddr) =3D=3D 128 bytes.

Could this be an assert?

Thanks,
Ian

>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 0586c4118656d3e4..9c1d0b271b20f693 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -187,8 +187,7 @@ int sys_enter_connect(struct syscall_enter_args *args=
)
>          if (augmented_args =3D=3D NULL)
>                  return 1; /* Failure: don't filter */
>
> -       if (socklen > sizeof(augmented_args->saddr))
> -               socklen =3D sizeof(augmented_args->saddr);
> +       socklen &=3D sizeof(augmented_args->saddr) - 1;
>
>         bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
>
> @@ -206,8 +205,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
>          if (augmented_args =3D=3D NULL)
>                  return 1; /* Failure: don't filter */
>
> -       if (socklen > sizeof(augmented_args->saddr))
> -               socklen =3D sizeof(augmented_args->saddr);
> +       socklen &=3D sizeof(augmented_args->saddr) - 1;
>
>         bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
>
> --
> 2.41.0
>
