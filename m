Return-Path: <linux-kernel+bounces-85566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CBF86B7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40051C222A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2171371EDD;
	Wed, 28 Feb 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="za4ZdViA"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB80540843
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146972; cv=none; b=nCEFXUJGIaxctqkK+KezGyFLFErSq9xadWEWbjrYCQnfuN5uWBTqRCYVPsOp1uqkP+FoLZgXdrpO05jsDPzEEWEDWJ7M4wI0MFP5bTFwUkycE64grVMi8Oy0UMp86iNyoHhvJUC21wqmqJI2CvAyq6zNhbPBPGHsIxaBngptgTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146972; c=relaxed/simple;
	bh=skFUv9Uol9+cRhzF1ak6ei4adRuspYQ8Rx2dU/hvc/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdxVEtLXkI8dEjXRBNpT/RUIQrcfye8zAYJyz7r/bnVElT70ERY3v3D0uBlwHYq337kcZfBcPXFTykvGBDEK2azcNevWfEWPZtMD8tD+XBucOpijESPdK9hoosBfmKY8zb3TOt9qFb3UV2LydoiecFj1yKqzqZ0BgLd/lNgCJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=za4ZdViA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso143362a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709146967; x=1709751767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8tVlwjS8losoKuCZ/fjzZ/9YF7qU0FgMHqFQ3Tqj9U=;
        b=za4ZdViA1avUJ2A2Jnb0AV12V+8pVtq0+GTRtMo7OuicrLANFG6k2ypUb2iP9cCoGx
         kG87Jg5UmQr5UNRgcKa6FgEfmNA+TJ1nZuKp/V+onmEGNGUxbNSn+I5BMOl8QNaYy5OO
         iBLpcoBebRmvJFpvCEpTOeMt70BZ8sIihkB+fx3iEAzW0eiI9gaXG16J4CngluOcVzu/
         1pWYXhnw+0nkUlOJrkISq8gwS3feEd+JJW9xihfCqWXDI4ZJnGOARboXrXYpqDVR/KpX
         NlmzLSPYhluD9xDfTuML5dILInOlhfyzTDca0wuYgb7ONRIcDE9GQKkSiv6YYS9l7klY
         peOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709146967; x=1709751767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8tVlwjS8losoKuCZ/fjzZ/9YF7qU0FgMHqFQ3Tqj9U=;
        b=daJiZDXuB5RhKoqwE9jjyj0rWX/qaI9QrxST5HLcLow3LPuI3MhZWSRblK1daOEjug
         ByStxm1YRTQufwzf4QKx1lPnn3LTR1UXH550iP4OXlFV/rYejG6zJKECd3wCakRPRyTV
         MdiF6BuG5WAbZwq5tuSPXnhn3hneZCdyhbPE2IX33l/JvHgIcZsT2O9xayYDyGT2oOu4
         s/Bg6nXkW7tTWdXpkmd2hXYGcUOjFMGxPIvpfPUtadrA2uls0wFrTzE4DH12SeanB2vk
         0dxNbhm6HDsJrQzfC6gjZFdXH1MC08raGUihX+K2pP38saATHdlJwa00Olk8FS2tswqN
         /KFg==
X-Forwarded-Encrypted: i=1; AJvYcCXr+qxV84kF7ZQ+icli8w7GBscrRJi+ruIzJfkXZr+I4egg1w5t07zwVBiRsdypjXAr5IdlRDEjqlfvDenZ/2xAbtRYEF94ZeYmP1bv
X-Gm-Message-State: AOJu0YyGN+qVHLRQZJ01dDsLlGxjGRLxsh4lUSp0CWE3G/SDho4R2hfW
	/xaY0xsJKR9/WCgdzsuUCLjWGbkHag5L5tGefJungxjVupdpVkDQ+gMwc1hlXCafiFO4jWrlYMY
	VJpB5GlVrGozKfHjtPTmE7w6+L5tXe4EmeWKstA==
X-Google-Smtp-Source: AGHT+IE3utn3vyJsWF2mAg/s87LAZC7cECKzA/OV3r5FZbp8dm6m45TbYz9+U3CBjLv2zPJfvrM9+hF0Z6dwrR4u53s=
X-Received: by 2002:a17:906:1d59:b0:a3f:c6a6:3b79 with SMTP id
 o25-20020a1709061d5900b00a3fc6a63b79mr421674ejh.6.1709146967406; Wed, 28 Feb
 2024 11:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228175149.162646-1-alexghiti@rivosinc.com>
 <20240228175149.162646-3-alexghiti@rivosinc.com> <74d7adee-8293-4fad-82c3-f4458b2e3960@sifive.com>
In-Reply-To: <74d7adee-8293-4fad-82c3-f4458b2e3960@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 28 Feb 2024 20:02:36 +0100
Message-ID: <CAHVXubiiyYAdKeVpzEdiySk=xz3bs6sb70SHT6_zM9XWDxWp+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Fix text patching when IPI are used
To: Samuel Holland <samuel.holland@sifive.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrea Parri <andrea@rivosinc.com>, 
	Anup Patel <anup@brainfault.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:21=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Alex,
>
> On 2024-02-28 11:51 AM, Alexandre Ghiti wrote:
> > For now, we use stop_machine() to patch the text and when we use IPIs f=
or
> > remote icache flushes (which is emitted in patch_text_nosync()), the sy=
stem
> > hangs.
> >
> > So instead, make sure every cpu executes the stop_machine() patching
> > function and emit a local icache flush there.
> >
> > Co-developed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/patch.h |  1 +
> >  arch/riscv/kernel/ftrace.c     | 42 ++++++++++++++++++++++++++++++----
> >  arch/riscv/kernel/patch.c      | 18 +++++++++------
> >  3 files changed, 50 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/pa=
tch.h
> > index e88b52d39eac..9f5d6e14c405 100644
> > --- a/arch/riscv/include/asm/patch.h
> > +++ b/arch/riscv/include/asm/patch.h
> > @@ -6,6 +6,7 @@
> >  #ifndef _ASM_RISCV_PATCH_H
> >  #define _ASM_RISCV_PATCH_H
> >
> > +int patch_insn_write(void *addr, const void *insn, size_t len);
> >  int patch_text_nosync(void *addr, const void *insns, size_t len);
> >  int patch_text_set_nosync(void *addr, u8 c, size_t len);
> >  int patch_text(void *addr, u32 *insns, int ninsns);
> > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> > index f5aa24d9e1c1..5654966c4e7d 100644
> > --- a/arch/riscv/kernel/ftrace.c
> > +++ b/arch/riscv/kernel/ftrace.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/ftrace.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/memory.h>
> > +#include <linux/stop_machine.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/patch.h>
> >
> > @@ -75,8 +76,7 @@ static int __ftrace_modify_call(unsigned long hook_po=
s, unsigned long target,
> >               make_call_t0(hook_pos, target, call);
> >
> >       /* Replace the auipc-jalr pair at once. Return -EPERM on write er=
ror. */
> > -     if (patch_text_nosync
> > -         ((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
> > +     if (patch_insn_write((void *)hook_pos, enable ? call : nops, MCOU=
NT_INSN_SIZE))
> >               return -EPERM;
> >
> >       return 0;
> > @@ -88,7 +88,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned=
 long addr)
> >
> >       make_call_t0(rec->ip, addr, call);
> >
> > -     if (patch_text_nosync((void *)rec->ip, call, MCOUNT_INSN_SIZE))
> > +     if (patch_insn_write((void *)rec->ip, call, MCOUNT_INSN_SIZE))
> >               return -EPERM;
> >
> >       return 0;
> > @@ -99,7 +99,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ft=
race *rec,
> >  {
> >       unsigned int nops[2] =3D {NOP4, NOP4};
> >
> > -     if (patch_text_nosync((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
> > +     if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
> >               return -EPERM;
> >
> >       return 0;
> > @@ -134,6 +134,40 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
> >
> >       return ret;
> >  }
> > +
> > +struct ftrace_modify_param {
> > +     int command;
> > +     atomic_t cpu_count;
> > +};
> > +
> > +static int __ftrace_modify_code(void *data)
> > +{
> > +     struct ftrace_modify_param *param =3D data;
> > +
> > +     if (atomic_inc_return(&param->cpu_count) =3D=3D num_online_cpus()=
) {
> > +             ftrace_modify_all_code(param->command);
> > +             /*
> > +              * Make sure the patching store is effective *before* we
> > +              * increment the counter which releases all waiting cpus
> > +              * by using the release version of atomic increment.
> > +              */
> > +             atomic_inc_return_release(&param->cpu_count);
> > +     } else {
> > +             while (atomic_read(&param->cpu_count) <=3D num_online_cpu=
s())
> > +                     cpu_relax();
> > +     }
> > +
> > +     local_flush_icache_all();
> > +
> > +     return 0;
> > +}
> > +
> > +void arch_ftrace_update_code(int command)
> > +{
> > +     struct ftrace_modify_param param =3D { command, ATOMIC_INIT(0) };
> > +
> > +     stop_machine(__ftrace_modify_code, &param, cpu_online_mask);
> > +}
> >  #endif
> >
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 0b5c16dfe3f4..82d8508c765b 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -188,7 +188,7 @@ int patch_text_set_nosync(void *addr, u8 c, size_t =
len)
> >  }
> >  NOKPROBE_SYMBOL(patch_text_set_nosync);
> >
> > -static int patch_insn_write(void *addr, const void *insn, size_t len)
> > +int patch_insn_write(void *addr, const void *insn, size_t len)
> >  {
> >       size_t patched =3D 0;
> >       size_t size;
> > @@ -211,11 +211,9 @@ NOKPROBE_SYMBOL(patch_insn_write);
> >
> >  int patch_text_nosync(void *addr, const void *insns, size_t len)
> >  {
> > -     u32 *tp =3D addr;
> >       int ret;
> >
> > -     ret =3D patch_insn_write(tp, insns, len);
> > -
> > +     ret =3D patch_insn_write(addr, insns, len);
> >       if (!ret)
> >               flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
>
> This only happens to compile because flush_icache_range() is a macro that
> ignores its parameters. You could replace tp with addr in this line as we=
ll, but
> that seems like more of a cosmetic change and should be a separate patch =
(like
> in [1] which covers both related functions) if you respin this.

I'll respin a new version and won't touch the extra variables since
you did. Your patchset is getting closer and closer in my todo list :)

Thanks,

Alex

>
> Regards,
> Samuel
>
> [1]:
> https://lore.kernel.org/linux-riscv/20240212025529.1971876-8-samuel.holla=
nd@sifive.com/
>
> >
> > @@ -232,15 +230,21 @@ static int patch_text_cb(void *data)
> >       if (atomic_inc_return(&patch->cpu_count) =3D=3D num_online_cpus()=
) {
> >               for (i =3D 0; ret =3D=3D 0 && i < patch->ninsns; i++) {
> >                       len =3D GET_INSN_LENGTH(patch->insns[i]);
> > -                     ret =3D patch_text_nosync(patch->addr + i * len,
> > -                                             &patch->insns[i], len);
> > +                     ret =3D patch_insn_write(patch->addr + i * len, &=
patch->insns[i], len);
> >               }
> > -             atomic_inc(&patch->cpu_count);
> > +             /*
> > +              * Make sure the patching store is effective *before* we
> > +              * increment the counter which releases all waiting cpus
> > +              * by using the release version of atomic increment.
> > +              */
> > +             atomic_inc_return_release(&patch->cpu_count);
> >       } else {
> >               while (atomic_read(&patch->cpu_count) <=3D num_online_cpu=
s())
> >                       cpu_relax();
> >       }
> >
> > +     local_flush_icache_all();
> > +
> >       return ret;
> >  }
> >  NOKPROBE_SYMBOL(patch_text_cb);
>

