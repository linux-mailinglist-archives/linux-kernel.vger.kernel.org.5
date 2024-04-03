Return-Path: <linux-kernel+bounces-129515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF11896BCB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC38F1F21C00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA1C1384B0;
	Wed,  3 Apr 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fuWJz5xB"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F49B13AA38
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139148; cv=none; b=Wtf5iBWSFNur8xDRak8wfrzn5uBJoZfL1uoSckrcsz2IXyJUQ+bWsl7TMHeASgIU5+4DLZBRnM1TmbQOJ+ePMdLwygq2W97SmvR2wKGVLLJ6NKRe4+KtMx98KLyZC/Bpmio8MQ8ux/1KZUr35YUq25Vvpv7cbfFyUIjq/SxRBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139148; c=relaxed/simple;
	bh=dBoosYSLCKiN/Z4tyIZ+kREWT4a37+GEzlZscyrSPgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itRHQz3jk98PScGsPCI9io/8e6XT2a3l1DfEpfwMEaRt7u8nVNNhW+OCLTNuz+7G/TB28JgfKSOyFArlxUeXobz2m2UdU2anXGHi1s4ENUsnieawQ4TKrFrDheLbQpP4aZaHeESiDCi43oEOQnzo0rzbNj1/vB8J4XSCV+AgHmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fuWJz5xB; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ddaebc9d6c9so5806560276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 03:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712139145; x=1712743945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DM3MruV8xgndrXUKi0XabWvgomlzzo6Hs77lj1LmAyw=;
        b=fuWJz5xB0p863eutso/dFfDCAkzwbeB9T7ULudM1DTnf1BOgxXO67/yi3OohxhG3lm
         n4QBhfc6w2M9dHCsy+w+hA2angVuU77O4b6SxwI3VXe1qJjDzjJ1HU38tgzjS+N3JhaN
         0JwViKYjyu5R2jCgUOAV5KxLdov1ZvtFzb2HBDkiz3YGboK/b85q5UFp9z+CrHWARQ6M
         F5gunApzeXa6VZr/OL5GK5dN5hWizn9ujJRVO6/q950EjDZVbbtKGHVhjjIp8lbPI/0b
         Myw6Uodx/fuSeUmWhWo5mohF4QVYAR2bRis5dy/Z14tia32sbhjsOVQTAVmBg+CyXIb9
         U4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712139145; x=1712743945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DM3MruV8xgndrXUKi0XabWvgomlzzo6Hs77lj1LmAyw=;
        b=LZY/QpiVfwh0DFkFYGTbBptkpNtVuIf8sUoLYKkDRDKPtLzZpEp5PtepxPKE0wPaH2
         WLhTclsp6FLN+B7oVJBoDA6YHAEaHCJ6zg72+e1ajJN6xmF1X3t2W02B6Vu7KD/ZQEdY
         rXV8lh/fo0Efzj/oj6989S+qE9e5jI0I0Mgk5cnVx0M22mvYRx8e0z3TjaX4YUvoteiB
         Nk4rjCKT0z6Zsljdn/+MrtAkamBOnaRjtbOrx1g5MHuuKnOfd5dex8tOIrYtnpuJeiFz
         t8PllM0W8k0SzjXdzAeMRKXD78Tm+lNaEhTkQhdcWJRMew3BWv6hUvUao6ULMyvjcmPw
         44Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXO71S8pQDZJ5wdJAoiQzyX/cp7/h/3wH/iCdx792L3PBXiN5YP8NIfOXFyhWgd7nqDbCTo/IWaUWN5EU/Hk0/tox/9PcJs3TY0pnhn
X-Gm-Message-State: AOJu0YwS7b5jl4m/TXxMpmas7zYhzlZ0r9XJxyarKdKwN0ezoP5KwooF
	EX6xcXxVGINIHAGzQsg0KAFrahCWSybsB+oxPvxLZvJJkBt3BIkwofP2GINV8HQ7qi1k42CaBxp
	NJVNetUt9vdDPuaGaLYmg4zhA7Yb2w4zzMB3/Tw==
X-Google-Smtp-Source: AGHT+IHjMnzB/WfOcWlU9Kk+q09w4kesr+xOTOdAJk4LZekAm9xMRBJgYqj2I5+13o+rL07Q+TszRqGktSr54zyAjuM=
X-Received: by 2002:a25:870e:0:b0:dd1:3909:bdd with SMTP id
 a14-20020a25870e000000b00dd139090bddmr11067625ybl.65.1712139145217; Wed, 03
 Apr 2024 03:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403072638.567446-1-bjorn@kernel.org>
In-Reply-To: <20240403072638.567446-1-bjorn@kernel.org>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Wed, 3 Apr 2024 18:12:14 +0800
Message-ID: <CABgGipVsoMi7uZ3o5nTLNBODCjworrppezE0CxfMsZfN0p07tQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix vector state restore in rt_sigreturn()
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
	Vincent Chen <vincent.chen@sifive.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Greentime Hu <greentime.hu@sifive.com>, Haorong Lu <ancientmodern4@gmail.com>, 
	Jerry Shih <jerry.shih@sifive.com>, Nick Knight <nick.knight@sifive.com>, 
	linux-kernel@vger.kernel.org, Vineet Gupta <vineetg@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Vineet Gupta <vgupta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 3:27=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> The RISC-V Vector specification states in "Appendix D: Calling
> Convention for Vector State" [1] that "Executing a system call causes
> all caller-saved vector registers (v0-v31, vl, vtype) and vstart to
> become unspecified.". In the RISC-V kernel this is called "discarding
> the vstate".
>
> Returning from a signal handler via the rt_sigreturn() syscall, vector
> discard is also performed. However, this is not an issue since the
> vector state should be restored from the sigcontext, and therefore not
> care about the vector discard.
>
> The "live state" is the actual vector register in the running context,
> and the "vstate" is the vector state of the task. A dirty live state,
> means that the vstate and live state are not in synch.
>
> When vectorized user_from_copy() was introduced, an bug sneaked in at
> the restoration code, related to the discard of the live state.
>
> An example when this go wrong:
>
>   1. A userland application is executing vector code
>   2. The application receives a signal, and the signal handler is
>      entered.
>   3. The application returns from the signal handler, using the
>      rt_sigreturn() syscall.
>   4. The live vector state is discarded upon entering the
>      rt_sigreturn(), and the live state is marked as "dirty", indicating
>      that the live state need to be synchronized with the current
>      vstate.
>   5. rt_sigreturn() restores the vstate, except the Vector registers,
>      from the sigcontext
>   6. rt_sigreturn() restores the Vector registers, from the sigcontext,
>      and now the vectorized user_from_copy() is used. The dirty live
>      state from the discard is saved to the vstate, making the vstate
>      corrupt.
>   7. rt_sigreturn() returns to the application, which crashes due to
>      corrupted vstate.
>
> Note that the vectorized user_from_copy() is invoked depending on the
> value of CONFIG_RISCV_ISA_V_UCOPY_THRESHOLD. Default is 768, which
> means that vlen has to be larger than 128b for this bug to trigger.
>
> The fix is simply to mark the live state as non-dirty/clean prior
> performing the vstate restore.
>
> Link: https://github.com/riscv/riscv-isa-manual/releases/download/riscv-i=
sa-release-8abdb41-2024-03-26/unpriv-isa-asciidoc.pdf # [1]
> Reported-by: Charlie Jenkins <charlie@rivosinc.com>
> Reported-by: Vineet Gupta <vgupta@kernel.org>
> Fixes: c2a658d41924 ("riscv: lib: vectorize copy_to_user/copy_from_user")
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Thanks for the findings!

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

> ---
>  arch/riscv/kernel/signal.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index 501e66debf69..5a2edd7f027e 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -119,6 +119,13 @@ static long __restore_v_state(struct pt_regs *regs, =
void __user *sc_vec)
>         struct __sc_riscv_v_state __user *state =3D sc_vec;
>         void __user *datap;
>
> +       /*
> +        * Mark the vstate as clean prior performing the actual copy,
> +        * to avoid getting the vstate incorrectly clobbered by the
> +        *  discarded vector state.
> +        */
> +       riscv_v_vstate_set_restore(current, regs);
> +
>         /* Copy everything of __sc_riscv_v_state except datap. */
>         err =3D __copy_from_user(&current->thread.vstate, &state->v_state=
,
>                                offsetof(struct __riscv_v_ext_state, datap=
));
> @@ -133,13 +140,7 @@ static long __restore_v_state(struct pt_regs *regs, =
void __user *sc_vec)
>          * Copy the whole vector content from user space datap. Use
>          * copy_from_user to prevent information leak.
>          */
> -       err =3D copy_from_user(current->thread.vstate.datap, datap, riscv=
_v_vsize);
> -       if (unlikely(err))
> -               return err;
> -
> -       riscv_v_vstate_set_restore(current, regs);
> -
> -       return err;
> +       return copy_from_user(current->thread.vstate.datap, datap, riscv_=
v_vsize);
>  }
>  #else
>  #define save_v_state(task, regs) (0)
>
> base-commit: 7115ff4a8bfed3b9294bad2e111744e6abeadf1a
> --
> 2.40.1
>

