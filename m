Return-Path: <linux-kernel+bounces-110261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E22885C39
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770D7285FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1069126F35;
	Thu, 21 Mar 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOVl1PFY"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6C86262;
	Thu, 21 Mar 2024 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035522; cv=none; b=oRmbCgaiVH8Tj9ML4OkskeUw00W0fZwaBqrcVu6vThqiaSOwIQM3ft/Rj6ievIIJBPbj0pVuCeXjoiG7J4pMVBZfIzRliRWp8ETuFD8rdWS3GW1b8pNtbeQ6ueZrmp1HYZOl9NOLSuxCcmEHDsAbRKVYky8nWuv6Fk1MQ4NqM3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035522; c=relaxed/simple;
	bh=vJEZk6/IF32GmYoS+ANMbVDaYuQ49rxjNBklyzfSgt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bLZHDI+5c49XGuGwOHr+dbSggjbihY4cOX2PXSlKkQuPJT5syMrzXzH62QbdKbLelXMMiQZwnB2eZw6OH/DzIH/oWKhi+tKLJxJvfJIV+bnzFWLFbIF65QNbdnKe1JN+sNQLxt2bSlWQl6XvW2+riSQq7f+V9+QY8iMwTFaVEVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOVl1PFY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51381021af1so1816478e87.0;
        Thu, 21 Mar 2024 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711035518; x=1711640318; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8qJ2xinG15xjfWxzz0ilp8huPxskxcCawEncmzpJpY=;
        b=MOVl1PFYA7wQRMRje+zVU53/4qOsyVpb+Ab2+mtzUFVww6LebsCj/UnP2qCdqCur5H
         sogDK1lsrP8YEMcrn3GD1qiFB8vknoGMw0ifQp5dRkS2BAjxw6LkhFahRys0CvFgBWi/
         BECN3UsTGgL31Du0uJukc4WEZwKmn2KpG+wBPz5gEbDHfNjX4DXX04muZJAkJLLpcTzt
         6B89ZsPta+mHy0/vAeGegMZLPBmpVI71iQWlboH5IBnLsG/4l2jfmWdS8QK7+Jr9gPK3
         I9QjjzdUcm18cmAVs59UjfxgOcuYWjA+gxpYKc66T41nb9Qd+WCGKUkaR9mwb1q/hK0s
         EwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035518; x=1711640318;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8qJ2xinG15xjfWxzz0ilp8huPxskxcCawEncmzpJpY=;
        b=nPTDlV2WOQFn31+P7RElWPo+es5x5ti5ct3d+KCVh+Qbblz4wo/kbe2uxWdVvRHKS9
         LZm5bdSqflg2yYIzWfVCHliIun3gmZ/9FNmQFeFHU2y7jk5ZwvLHi9VHCvFQOyTCu3a1
         LKlMBsfTEf/J8BZ13AjyCXrjLCqyG2MsZFgTuMDw1Qomb2Ys80LstZhQHSAafHZhmoHh
         cGMWpe3Fc77wyEXo3t8c8hR8ENvKji+AMFQ2LueJCJO32TeSMGCLKlJXkxmyUrGyO8hn
         W+TVxEDRLC7M8zhwoMLFdJTfB7B+oshWmnY8o8Tv7UOO7T+o3dMB8XaBV3roz0NrvaaG
         otoA==
X-Forwarded-Encrypted: i=1; AJvYcCVpAs9pSkJ0s7NlbbOXtRIMfwgXW5iVrZCRyymSqZ7B6JvBQhItjIWYWHpO7VRc5YwcgCBo1o7hpM3bjMGcrBXa5ORBtQfBTi3oq1ztl94f0QAGtfa25ynz/5oM9c7P6oED
X-Gm-Message-State: AOJu0Yx7R0QRAp6bbmHPSOcn9LaAVjSOon5GrQdGEkP96PmKg0JDDW8a
	imejiPUhR8S7zMNOlrrKHunXniWfJxeAp4Tm+b/u+6eFJ740bRkNwVDXPcV/mPaLi0auoRRB4q/
	J32TEe7AQ0JPsZsr8T6bN0l3IxWI=
X-Google-Smtp-Source: AGHT+IEGteT+xsETnK9Rs87EItJsWax6ttFqGmrPj5jSxE+SV6YJGe8bsXUYa/0Rq0FpxFoA4hiV/plVe92gS0ccnLI=
X-Received: by 2002:a19:3848:0:b0:513:ce01:592b with SMTP id
 d8-20020a193848000000b00513ce01592bmr2031312lfj.6.1711035518046; Thu, 21 Mar
 2024 08:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321150300.66598-1-puranjay12@gmail.com>
In-Reply-To: <20240321150300.66598-1-puranjay12@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 21 Mar 2024 16:38:26 +0100
Message-ID: <CANk7y0jJN7D8Df0b9-6TSvpwqMuQFyf8mmtyRBQ6hNtKFU3mvQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: verifier: fix addr_space_cast from as(1) to as(0)
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:03=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> The verifier currently converts addr_space_cast from as(1) to as(0) that
> is: BPF_ALU64 | BPF_MOV | BPF_X with off=3D1 and imm=3D1
> to
> BPF_ALU | BPF_MOV | BPF_X with imm=3D1 (32-bit mov)
>
> Because of this imm=3D1, the JITs that have bpf_jit_needs_zext() =3D=3D t=
rue,
> interpret the converted instruction as BPF_ZEXT_REG(DST) which is a
> special form of mov32, used for doing explicit zero extension on dst.
> These JITs will just zero extend the dst reg and will not move the src to
> dst before the zext.
>
> Fix do_misc_fixups() to set imm=3D0 when converting addr_space_cast to a
> normal mov32.
>
> The JITs that have bpf_jit_needs_zext() =3D=3D true rely on the verifier =
to
> emit zext instructions. Mark dst_reg as subreg when doing cast from
> as(1) to as(0) so the verifier emits a zext instruction after the mov.
>
> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the v=
erifier.")
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  kernel/bpf/verifier.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index de7813947981..ee796402ef60 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14046,8 +14046,11 @@ static int check_alu_op(struct bpf_verifier_env =
*env, struct bpf_insn *insn)
>                                 if (insn->imm) {
>                                         /* off =3D=3D BPF_ADDR_SPACE_CAST=
 */
>                                         mark_reg_unknown(env, regs, insn-=
>dst_reg);
> -                                       if (insn->imm =3D=3D 1) /* cast f=
rom as(1) to as(0) */
> +                                       if (insn->imm =3D=3D 1) { /* cast=
 from as(1) to as(0) */
>                                                 dst_reg->type =3D PTR_TO_=
ARENA;
> +                                               /* PTR_TO_ARENA is 32-bit=
 */
> +                                               dst_reg->subreg_def =3D e=
nv->insn_idx + 1;
> +                                       }
>                                 } else if (insn->off =3D=3D 0) {
>                                         /* case: R1 =3D R2
>                                          * copy register state to dest re=
g
> @@ -19606,8 +19609,9 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                             (((struct bpf_map *)env->prog->aux->arena)->m=
ap_flags & BPF_F_NO_USER_CONV)) {
>                                 /* convert to 32-bit mov that clears uppe=
r 32-bit */
>                                 insn->code =3D BPF_ALU | BPF_MOV | BPF_X;
> -                               /* clear off, so it's a normal 'wX =3D wY=
' from JIT pov */
> +                               /* clear off and imm, so it's a normal 'w=
X =3D wY' from JIT pov */
>                                 insn->off =3D 0;
> +                               insn->imm =3D 0;
>                         } /* cast from as(0) to as(1) should be handled b=
y JIT */
>                         goto next_insn;
>                 }
> --
> 2.40.1
>

This did not reach the list somehow.
I will have to resend to trigger the CI.

Sorry for the noise.

Puranjay

