Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E8180B416
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjLIMB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjLIMBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:01:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED9E137
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 04:01:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE34C433CA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702123291;
        bh=v6j74HE6xrurTYx8QhlYVAfvFiamjz3g/t4Mghp6X80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XvcKKWALitnJ6jf0MN/zEb9yNbxzDyTqpHYJ8EEHK8hXr7NToU7akKyhNjMh1gUxw
         66jcg6H31aHy0ZbvSXuR5b7CZaOC00xD8RI5rFuzZ4iEi3acRK1fu2BidvfuAuZ+GG
         /Fvp8f/KrJjOeOKmXIyUvwTrcr9bTNSK/iPpcM/F/7l+akqercZzvvAjs1K7xUbreO
         QmzcPboH7yqgPzK1ruYVsXLGSxQhWiPPji4bBpgt3uBm1/Dba0Ojt5DHDgw6bnWBNg
         rFeP7ZAhuuRyKzwb71hxNqBcFAG3BYtJbup69T8usMYXMc31bL/tGA71jyhVZMbI4I
         TgpEmFEB4H5Ng==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a1f653e3c3dso206341266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 04:01:31 -0800 (PST)
X-Gm-Message-State: AOJu0YyC1qHdQUCaUR50xYFpXNDV9cyjZFICB6M42fQ2z4kqli4ccJ+E
        KHwn0PtjQ/ZVkihp93LdWIzFw2Nn6+F2JkZIRnE=
X-Google-Smtp-Source: AGHT+IGH4hXb/oapmY9eisK/qfmrj6vT+qlWX9EvvvU4aoPdF8LV60ZKmhmLLZwYL/v+zjtnbKnEtLA3j82LuImdns0=
X-Received: by 2002:a17:907:3e12:b0:a1d:182:efc4 with SMTP id
 hp18-20020a1709073e1200b00a1d0182efc4mr369766ejc.200.1702123289602; Sat, 09
 Dec 2023 04:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20231207032951.16334-1-yangtiezhu@loongson.cn>
 <20231207032951.16334-2-yangtiezhu@loongson.cn> <CAAhV-H40YTpJP0giD6Y9ekfaceimpzuxqJndoBJiMU89YLA3zw@mail.gmail.com>
 <CAEyhmHQOfs39cgKBb0VEdF6=pFodBYYkBichsxX_uBh30kNZXg@mail.gmail.com>
In-Reply-To: <CAEyhmHQOfs39cgKBb0VEdF6=pFodBYYkBichsxX_uBh30kNZXg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 9 Dec 2023 20:01:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5r6f3Fq4c=GBk4Nv9jUw0=8xjQnsuEhEBvY8rHvdRTmA@mail.gmail.com>
Message-ID: <CAAhV-H5r6f3Fq4c=GBk4Nv9jUw0=8xjQnsuEhEBvY8rHvdRTmA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] LoongArch: BPF: Fix sign-extension mov instructions
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks.

Huacai

On Sat, Dec 9, 2023 at 2:04=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> On Thu, Dec 7, 2023 at 12:12=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > On Thu, Dec 7, 2023 at 11:30=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> > >
> > > We can see that "Short form of movsx, dst_reg =3D (s8,s16,s32)src_reg=
"
> > > in include/linux/filter.h, additionally, for BPF_ALU64 the value of
> > > the destination register is unchanged whereas for BPF_ALU the upper
> > > 32 bits of the destination register are zeroed, so it should clear
> > > the upper 32 bits for BPF_ALU.
> > >
> > > [root@linux fedora]# echo 1 > /proc/sys/net/core/bpf_jit_enable
> > > [root@linux fedora]# modprobe test_bpf
> > >
> > > Before:
> > > test_bpf: #81 ALU_MOVSX | BPF_B jited:1 ret 2 !=3D 1 (0x2 !=3D 0x1)FA=
IL (1 times)
> > > test_bpf: #82 ALU_MOVSX | BPF_H jited:1 ret 2 !=3D 1 (0x2 !=3D 0x1)FA=
IL (1 times)
> > >
> > > After:
> > > test_bpf: #81 ALU_MOVSX | BPF_B jited:1 6 PASS
> > > test_bpf: #82 ALU_MOVSX | BPF_H jited:1 6 PASS
> > >
> > > By the way, the bpf selftest case "./test_progs -t verifier_movsx" ca=
n
> > > also be fixed with this patch.
> > Hmmm, it is a little strange that privileged verifier_movsx has no prob=
lem.
> >
>
> I have found the differences between priv and unpriv mode.
> The BPF verifier performs different optimizations for priv and upriv prog=
s.
> See the following commits:
>
> https://github.com/torvalds/linux/commit/e2ae4ca266a1c
> https://github.com/torvalds/linux/commit/52875a04f4b26
> https://github.com/torvalds/linux/commit/a1b14abc009d9
>
> As a result, with unprivileged_bpf_disabled on, we have:
>
>   # bpftool p d x i 55
>   void mov32sx_s16_range_2():
>   ; asm volatile ("                    \
>      0: (b7) r1 =3D 65535
>      1: (bc) w2 =3D w1
>      2: (77) r2 >>=3D 1
>      3: (b7) r0 =3D 1
>      4: (95) exit
>
>   # bpftool p d j i 55
>   void mov32sx_s16_range_2():
>   0xffff800002416238:
>   ; asm volatile ("                    \
>      0:    addi.d          $a6, $zero, 33(0x21)
>      4:    addi.d          $sp, $sp, -64(0xfc0)
>      8:    st.d            $ra, $sp, 56(0x38)
>      c:    st.d            $fp, $sp, 48(0x30)
>     10:    st.d            $s0, $sp, 40(0x28)
>     14:    st.d            $s1, $sp, 32(0x20)
>     18:    st.d            $s2, $sp, 24(0x18)
>     1c:    st.d            $s3, $sp, 16(0x10)
>     20:    st.d            $s4, $sp, 8(0x8)
>     24:    st.d            $s5, $sp, 0
>     28:    addi.d          $fp, $sp, 64(0x40)
>     2c:    lu12i.w         $a0, 15(0xf)
>     30:    ori             $a0, $a0, 0xfff
>     34:    move            $t1, $a0
>     38:    ext.w.h         $a1, $t1
>     3c:    srli.d          $a1, $a1, 0x1
>     40:    addi.w          $a5, $zero, 1(0x1)
>     44:    ld.d            $ra, $sp, 56(0x38)
>     48:    ld.d            $fp, $sp, 48(0x30)
>     4c:    ld.d            $s0, $sp, 40(0x28)
>     50:    ld.d            $s1, $sp, 32(0x20)
>     54:    ld.d            $s2, $sp, 24(0x18)
>     58:    ld.d            $s3, $sp, 16(0x10)
>     5c:    ld.d            $s4, $sp, 8(0x8)
>     60:    ld.d            $s5, $sp, 0
>     64:    addi.d          $sp, $sp, 64(0x40)
>     68:    move            $a0, $a5
>     6c:    jirl            $zero, $ra, 0
>
> With unprivileged_bpf_disabled off, we have:
>
>   # bpftool p d x i 59
>      0: (b7) r1 =3D 65535
>      1: (bc) w2 =3D w1
>      2: (77) r2 >>=3D 1
>      3: (55) if r2 !=3D 0x7fffffff goto pc+2
>      4: (b7) r0 =3D 1
>      5: (95) exit
>      6: (05) goto pc-1
>      7: (05) goto pc-1
>
>   # bpftool p d j i 59
>   0xffff8000024146a0:
>      0:    addi.d          $a6, $zero, 33(0x21)
>      4:    addi.d          $sp, $sp, -64(0xfc0)
>      8:    st.d            $ra, $sp, 56(0x38)
>      c:    st.d            $fp, $sp, 48(0x30)
>     10:    st.d            $s0, $sp, 40(0x28)
>     14:    st.d            $s1, $sp, 32(0x20)
>     18:    st.d            $s2, $sp, 24(0x18)
>     1c:    st.d            $s3, $sp, 16(0x10)
>     20:    st.d            $s4, $sp, 8(0x8)
>     24:    st.d            $s5, $sp, 0
>     28:    addi.d          $fp, $sp, 64(0x40)
>     2c:    lu12i.w         $a0, 15(0xf)
>     30:    ori             $a0, $a0, 0xfff
>     34:    move            $t1, $a0
>     38:    ext.w.h         $a1, $t1
>     3c:    srli.d          $a1, $a1, 0x1
>     40:    lu12i.w         $t1, 524287(0x7ffff)
>     44:    ori             $t1, $t1, 0xfff
>     48:    move            $t2, $a1
>     4c:    beq             $t2, $t1, 8(0x8)    # 0x0000000000000054
>     50:    b               12(0xc)    # 0x000000000000005c
>     54:    addi.w          $a5, $zero, 1(0x1)
>     58:    b               12(0xc)    # 0x0000000000000064
>     5c:    b               0    # 0x000000000000005c
>     60:    b               0    # 0x0000000000000060
>     64:    ld.d            $ra, $sp, 56(0x38)
>     68:    ld.d            $fp, $sp, 48(0x30)
>     6c:    ld.d            $s0, $sp, 40(0x28)
>     70:    ld.d            $s1, $sp, 32(0x20)
>     74:    ld.d            $s2, $sp, 24(0x18)
>     78:    ld.d            $s3, $sp, 16(0x10)
>     7c:    ld.d            $s4, $sp, 8(0x8)
>     80:    ld.d            $s5, $sp, 0
>     84:    addi.d          $sp, $sp, 64(0x40)
>     88:    move            $a0, $a5
>     8c:    jirl            $zero, $ra, 0
>
> Without this fix, it seems like the prog is trapped in an infinite loop.
>
> This patch looks good to me, so I am going to offer:
>
> Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
>
> Cheers,
> --
> Hengqi
>
> > Huacai
> >
> > >
> > > Fixes: f48012f16150 ("LoongArch: BPF: Support sign-extension mov inst=
ructions")
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > ---
> > >  arch/loongarch/net/bpf_jit.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_ji=
t.c
> > > index 169ff8b3915e..8c907c2c42f7 100644
> > > --- a/arch/loongarch/net/bpf_jit.c
> > > +++ b/arch/loongarch/net/bpf_jit.c
> > > @@ -480,10 +480,12 @@ static int build_insn(const struct bpf_insn *in=
sn, struct jit_ctx *ctx, bool ext
> > >                 case 8:
> > >                         move_reg(ctx, t1, src);
> > >                         emit_insn(ctx, extwb, dst, t1);
> > > +                       emit_zext_32(ctx, dst, is32);
> > >                         break;
> > >                 case 16:
> > >                         move_reg(ctx, t1, src);
> > >                         emit_insn(ctx, extwh, dst, t1);
> > > +                       emit_zext_32(ctx, dst, is32);
> > >                         break;
> > >                 case 32:
> > >                         emit_insn(ctx, addw, dst, src, LOONGARCH_GPR_=
ZERO);
> > > --
> > > 2.42.0
> > >
> > >
>
