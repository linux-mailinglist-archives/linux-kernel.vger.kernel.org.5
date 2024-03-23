Return-Path: <linux-kernel+bounces-112448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6268879F6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5B2B214C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B1C57315;
	Sat, 23 Mar 2024 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo/fN+to"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B36623BF;
	Sat, 23 Mar 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711219081; cv=none; b=tno0Pa6VhxEKjx50FDVKPCp0zP4PBnBXPDGE1b+6hvusSqxZ93yNS3uL887gOjl45JdfsH+ufW5oIIaQ0xLYnIOp3rURsZhxjcxOxg57eU0jE690YWMPRDoe/iZ1pXxD4mwbBHrPtu5mUYQr86K59/p7USzkuWOfQ0eaqMvFvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711219081; c=relaxed/simple;
	bh=NS4fURU7kzpRSrqIPRb1K4MNYCHDTlf5iFlZrDqAgW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUca1IbkpTh8yTVDP0sp8wch2cU7b6BznQbmtrnTnRk6ojMx171Ftg5h3awnu5hosJ84QQ7+svCALrlvNC+VYqRs3xwfzaOcV3YQQZE08+0cPj7WVWyM1X4ESVeg2fvIHkMz0eaJg80Dw97Pfbp7+9GdPdMpVAiOt/qJy7hvBzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fo/fN+to; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e570ef661so1495352f8f.1;
        Sat, 23 Mar 2024 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711219078; x=1711823878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfH5WGMGx2/rhyl1QkGDZcJNlwpDJH+Q6GuhYoIntBE=;
        b=fo/fN+to6jOvVMUajvrEH3+VLfLW5HX3akdgtp9Hevp587Stpej+gtV3Gv56Ndcwh0
         PW3r/ZucIGlHJccWdX40eh4Ve2pnH7DDjCr7JDyNZfwppuNSVuaxUkFTX+yeoCa4UnqC
         cxtdjcANJwVKuK76p2uyC86FLOoKdcw8YVa3wdyemRjcQTTWnR+He3DdHHGnumUy92FS
         Hfal87Ydy26vmDsgQNJgmt4rQILmqdTpoe5V/ACOwWPSXf9lef/PGTY96OrfTwzQKVXE
         DpMC7BghiRtl0859387X41XToiduqw7VEajUnJNfCNG5Soxxc2VIIhjaI9iUiqw93lD1
         QtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711219078; x=1711823878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfH5WGMGx2/rhyl1QkGDZcJNlwpDJH+Q6GuhYoIntBE=;
        b=Swf+0KeAwgA9lCLz+PdA3b+MrlIvoVGFbg/yxlEtkqpoHVRmTCrZH2olf+6s34LCvn
         X6+XwNQzsxTiWhwmfqKfHI5zzlhp2mID7AWJrdrTfT8jHfDbDzOrPvjszl3uWkJIF87u
         lq8F6+PiEEA3rGwcVOikRBQsLOGfSk0sOVqayT84aWAF/bZz+fQQL87S8Lxaofgq7YoE
         +wWctArhPycwLPcv7PsnAYxi0x0dm/RV2NPF89j6gJkBMddReVJmTBohJiHlOybN/h7Y
         Aid0A6Uzo0lJBdiL0t5fv92QfCTQSeCSE/t/onevSVwtPCpUsoKd2u9n4TlzMZxzFD+d
         6HbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkFizQURDKokRrDjZF6v82JAgW/f0dkSke4+B0JSvsYA3/PYtAVHhQn+asih/LD7Iw6mBfBYVZ05ustHp4r8yLVJTEIBmEGs5H19cF8qTG8rRnpJDQZgFMdFqLNmXQlO5/
X-Gm-Message-State: AOJu0Ywofh737bp2JuYPWf1HN6g85Rw6kTgeGP7NB/pwmEE6APDFXkH+
	MhETztLCHH3EkWFr87jbbWDGEsPra0WfEvXp1A/joPLX0rTck/Km6ainjxFLt2aPjWMdrjheel5
	BRFFE/ApVZMoLBu7KZF9n7c9KV3Q=
X-Google-Smtp-Source: AGHT+IEsIxO0glIvBi1dgQLe0aNKeZmhmgRSkvuB69Irs9ZeionhCzyCfv4nsPLzOYyQEumbSGQjon4EjFDDweSh8Ro=
X-Received: by 2002:a5d:6b0d:0:b0:33e:1ea:2eeb with SMTP id
 v13-20020a5d6b0d000000b0033e01ea2eebmr1950375wrw.67.1711219077568; Sat, 23
 Mar 2024 11:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323154652.54572-1-puranjay12@gmail.com> <20240323154652.54572-3-puranjay12@gmail.com>
In-Reply-To: <20240323154652.54572-3-puranjay12@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 Mar 2024 11:37:46 -0700
Message-ID: <CAADnVQKQiG_mmWFUa5Jzt1upCTOQTOGQP=h98z9Et8VSwm=L_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf,riscv: Implement bpf_addr_space_cast instruction
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, bpf <bpf@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 8:47=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> LLVM generates bpf_addr_space_cast instruction while translating
> pointers between native (zero) address space and
> __attribute__((address_space(N))). The addr_space=3D0 is reserved as
> bpf_arena address space.
>
> rY =3D addr_space_cast(rX, 0, 1) is processed by the verifier and
> converted to normal 32-bit move: wX =3D wY
>
> rY =3D addr_space_cast(rX, 1, 0) has to be converted by JIT:
>
> Here I explain using symbolic language what the JIT is supposed to do:
> We have:
>         src =3D [src_upper32][src_lower32] // 64 bit src kernel pointer
>         uvm =3D [uvm_upper32][uvm_lower32] // 64 bit user_vm_start

This is a bit misleading.
src_lower32 are always equal to uvm_lower32
and src_upper32 are either zero or uvm_upper32.

Hence most of the time llvm doesn't generate this insn,
since it knows that upper 32 bit are uvm_upper32.

> The JIT has to make the dst reg like following
>         dst =3D [uvm_upper32][src_lower32] // if src_lower32 !=3D 0
>         dst =3D [00000000000][00000000000] // if src_lower32 =3D=3D 0
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/riscv/net/bpf_jit.h        |  1 +
>  arch/riscv/net/bpf_jit_comp64.c | 15 +++++++++++++++
>  arch/riscv/net/bpf_jit_core.c   |  1 +
>  3 files changed, 17 insertions(+)
>
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 8a47da08dd9c..5fc374ed98ea 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -82,6 +82,7 @@ struct rv_jit_context {
>         unsigned long flags;
>         int stack_size;
>         u64 arena_vm_start;
> +       u64 user_vm_start;
>  };
>
>  /* Convert from ninsns to bytes. */
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index f51b832eafb6..3c389e75cb96 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1083,6 +1083,16 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>         /* dst =3D src */
>         case BPF_ALU | BPF_MOV | BPF_X:
>         case BPF_ALU64 | BPF_MOV | BPF_X:
> +               if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64 && insn->off =
=3D=3D BPF_ADDR_SPACE_CAST &&
> +                   insn->imm =3D=3D 1U << 16) {

Let's add a generic helper like insn_is_zext(),
call it insn_is_cast_user() ?
and use it in all JIT-s ?
I should have added it right away when I did x86 part. Sorry.

And a comment next to the helper that addr space cast 0->1
is for converting bpf arena pointers to user vma.
Hence the name.

Same comments for arm64 JIT arena support.

pw-bot: cr

