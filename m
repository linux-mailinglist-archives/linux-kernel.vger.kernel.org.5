Return-Path: <linux-kernel+bounces-111209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35D888692F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0650F1C23BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFB422301;
	Fri, 22 Mar 2024 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LBj4Ioc+"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0016E1F93F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099640; cv=none; b=A326JrtoB3+oLb16HTqgRoEzSa4liLvszIhrZHRvflSZXwqrsYOWkq5hk1rv3wOtgQmqFrVEE3IndwNvltraralO8G//DhazHGY6GKVn8q/epu/nuAUJtilGWDQp0kaKKtZZClDK82hGMaBIkEIOWJjUJp3/EWwcWD3+3WZjWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099640; c=relaxed/simple;
	bh=I5vDRHCUnCKFa2aNtQCchey/7qoDzsxdM3JrslD/8qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2xYA+f1Mf5xrlQ5ssslePM5ZuXsTzuR6690M7cYRWGw996LAk7BxLEoAUq5whIRXeYV7eV1h0o++xAcBmSGjF12HnyIl8SXrOY7TYopqrETniezEaIUYc7YmQf7cj/xvgiYWt2pFnJBVAiqjXiHJSmeOwUtFahPGEHjF5LO0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LBj4Ioc+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46d0a8399aso499371966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711099636; x=1711704436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IekDpHsRIB0jNlYcuPAp+KNHumI/dhNoBkltlzhFj3I=;
        b=LBj4Ioc++idaSFRk7zbqM5PCJh+4gQvXrxZY+fzTBpcqJH9dFbTascoLkoglAz8hut
         KEWp2EOf0/UBOShA+meJrVhvqexzwQV6FBK1gGWCKlVCIrqbOleSutVkZssy470XzcQz
         TMIanpq9Ingq+u/JMkLEbtSUTXoUKSgnrFA+6wUCNP5Zx6WONS5/d33+WztyJktNU10l
         Mk1yi8fJh7meQ2K78KMQcy1yjN1VYgVQs9od8uS3O0HsKnpFA867U6MegjAJoOjLWRCV
         YQtX31B/Res0A0AjdknlU4x33AiW5b01otiJlawLnPc9+KCFv8xzueYQjZIfq6syFlvG
         mVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711099636; x=1711704436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IekDpHsRIB0jNlYcuPAp+KNHumI/dhNoBkltlzhFj3I=;
        b=Zirg+SNxGAigHLQ4Z0EkUcjrPmg1XWOurzeOhe4bQ8NP8GJNFyJeZ79BWPIS5RZGNO
         RnXMktstPdtLgqfF4olc1NRh0SpEcYJi0Gv4Lqs2hWyKNBCC4zvmU597ol0y8t8aXnVX
         NST8RHgJj13I4kg3aFZvEWRm7qNXrat6sTpJ+CmrMXC9ZpBcOB1PV61XWa8gGCo+2H46
         H/tTBkB+bOS/YPXlpshpWzXvxwL+PGdknxmEeyzRfQXgmV9I1TSSVLblbMe//UJM+W6B
         Gk6QymL87TYk8WMg3Uc5aN008qjlFN63i2eqTBlMFyQ2Okoq3NR5FPqTkqv0/IEY7vJ7
         Mk9w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6WKwQ/Y8zG+RjVoCYybMy/kylTUlo9aTf8lo2iUCPuNZrxXBS8+psYyC36YRDzAQCYhRgKtSpaGkNDTOmSKdSpHF167FQD/8Fw/r
X-Gm-Message-State: AOJu0YzhIjGZTt1LDskU9cTVBC1EQ3sdpOIxzfPdV/0aVDe65kArL1Fk
	cvzrSRvCjfpqhU3LsfQs/2ruETuTxPx/KVi83VS106szb4TEoFkfiZJbqTIySa7UgO0EG2Uym2Z
	1uK/pgkjcxxx6FaG+pCQX0jgLeFfAy6fuNQRKSA==
X-Google-Smtp-Source: AGHT+IEcKOdce9iM5lzHHEilvm/5tqIg3w73KLA0Ya2/No6KaIfzIWYpDxSk0trtFUMCBPwI6mWGiaZgroTHHgY9RmE=
X-Received: by 2002:a17:907:7211:b0:a47:3588:6b99 with SMTP id
 dr17-20020a170907721100b00a4735886b99mr441177ejc.7.1711099636041; Fri, 22 Mar
 2024 02:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321230131.1838105-1-samuel.holland@sifive.com>
In-Reply-To: <20240321230131.1838105-1-samuel.holland@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 22 Mar 2024 10:27:05 +0100
Message-ID: <CAHVXubgez9NCE1XTu6WvumuMOsNeWyDMvze44w4f8kCMG2-X5g@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Add tracepoints for SBI calls and returns
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Andrew Jones <ajones@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Fri, Mar 22, 2024 at 12:01=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> These are useful for measuring the latency of SBI calls. The SBI HSM
> extension is excluded because those functions are called from contexts
> such as cpuidle where instrumentation is not allowed.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v2:
>  - Remove some blank lines
>
>  arch/riscv/include/asm/trace.h | 54 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/sbi.c        |  7 +++++
>  2 files changed, 61 insertions(+)
>  create mode 100644 arch/riscv/include/asm/trace.h
>
> diff --git a/arch/riscv/include/asm/trace.h b/arch/riscv/include/asm/trac=
e.h
> new file mode 100644
> index 000000000000..6151cee5450c
> --- /dev/null
> +++ b/arch/riscv/include/asm/trace.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM riscv
> +
> +#if !defined(_TRACE_RISCV_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_RISCV_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT_CONDITION(sbi_call,
> +       TP_PROTO(int ext, int fid),
> +       TP_ARGS(ext, fid),
> +       TP_CONDITION(ext !=3D SBI_EXT_HSM),
> +
> +       TP_STRUCT__entry(
> +               __field(int, ext)
> +               __field(int, fid)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->ext =3D ext;
> +               __entry->fid =3D fid;
> +       ),
> +
> +       TP_printk("ext=3D0x%x fid=3D%d", __entry->ext, __entry->fid)
> +);
> +
> +TRACE_EVENT_CONDITION(sbi_return,
> +       TP_PROTO(int ext, long error, long value),
> +       TP_ARGS(ext, error, value),
> +       TP_CONDITION(ext !=3D SBI_EXT_HSM),
> +
> +       TP_STRUCT__entry(
> +               __field(long, error)
> +               __field(long, value)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->error =3D error;
> +               __entry->value =3D value;
> +       ),
> +
> +       TP_printk("error=3D%ld value=3D0x%lx", __entry->error, __entry->v=
alue)
> +);
> +
> +#endif /* _TRACE_RISCV_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +
> +#define TRACE_INCLUDE_PATH asm
> +#define TRACE_INCLUDE_FILE trace
> +
> +#include <trace/define_trace.h>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index e66e0999a800..a1d21d8f5293 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -14,6 +14,9 @@
>  #include <asm/smp.h>
>  #include <asm/tlbflush.h>
>
> +#define CREATE_TRACE_POINTS
> +#include <asm/trace.h>
> +
>  /* default SBI version is 0.1 */
>  unsigned long sbi_spec_version __ro_after_init =3D SBI_SPEC_VERSION_DEFA=
ULT;
>  EXPORT_SYMBOL(sbi_spec_version);
> @@ -31,6 +34,8 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long=
 arg0,
>  {
>         struct sbiret ret;
>
> +       trace_sbi_call(ext, fid);
> +
>         register uintptr_t a0 asm ("a0") =3D (uintptr_t)(arg0);
>         register uintptr_t a1 asm ("a1") =3D (uintptr_t)(arg1);
>         register uintptr_t a2 asm ("a2") =3D (uintptr_t)(arg2);
> @@ -46,6 +51,8 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long=
 arg0,
>         ret.error =3D a0;
>         ret.value =3D a1;
>
> +       trace_sbi_return(ext, ret.error, ret.value);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL(sbi_ecall);
> --
> 2.43.1
>

sbi_ecall() is used by flush_icache_all() so I was a bit scared we
would need to patch 2 instructions using a tracepoint and then to use
flush_icache_all() which could bug if only one of the patched
instruction was seen. But I took a look at the disassembled code, and
tracepoints happen to only need to patch 1 nop into an unconditional
jump, which is not a problem then.

But then when disassembling, I noticed that the addition of the
tracepoint comes with "quite" some overhead:

Before:

Dump of assembler code for function sbi_ecall:
   0xffffffff800085e0 <+0>: add sp,sp,-32
   0xffffffff800085e2 <+2>: sd s0,24(sp)
   0xffffffff800085e4 <+4>: mv t1,a0
   0xffffffff800085e6 <+6>: add s0,sp,32
   0xffffffff800085e8 <+8>: mv t3,a1
   0xffffffff800085ea <+10>: mv a0,a2
   0xffffffff800085ec <+12>: mv a1,a3
   0xffffffff800085ee <+14>: mv a2,a4
   0xffffffff800085f0 <+16>: mv a3,a5
   0xffffffff800085f2 <+18>: mv a4,a6
   0xffffffff800085f4 <+20>: mv a5,a7
   0xffffffff800085f6 <+22>: mv a6,t3
   0xffffffff800085f8 <+24>: mv a7,t1
   0xffffffff800085fa <+26>: ecall
   0xffffffff800085fe <+30>: ld s0,24(sp)
   0xffffffff80008600 <+32>: add sp,sp,32
   0xffffffff80008602 <+34>: ret

After:

Dump of assembler code for function sbi_ecall:
   0xffffffff8000bbf2 <+0>: add sp,sp,-112
   0xffffffff8000bbf4 <+2>: sd s0,96(sp)
   0xffffffff8000bbf6 <+4>: sd s1,88(sp)
   0xffffffff8000bbf8 <+6>: sd s3,72(sp)
   0xffffffff8000bbfa <+8>: sd s4,64(sp)
   0xffffffff8000bbfc <+10>: sd s5,56(sp)
   0xffffffff8000bbfe <+12>: sd s6,48(sp)
   0xffffffff8000bc00 <+14>: sd s7,40(sp)
   0xffffffff8000bc02 <+16>: sd s8,32(sp)
   0xffffffff8000bc04 <+18>: sd s9,24(sp)
   0xffffffff8000bc06 <+20>: sd ra,104(sp)
   0xffffffff8000bc08 <+22>: sd s2,80(sp)
   0xffffffff8000bc0a <+24>: add s0,sp,112
   0xffffffff8000bc0c <+26>: mv s1,a0
   0xffffffff8000bc0e <+28>: mv s3,a1
   0xffffffff8000bc10 <+30>: mv s9,a2
   0xffffffff8000bc12 <+32>: mv s8,a3
   0xffffffff8000bc14 <+34>: mv s7,a4
   0xffffffff8000bc16 <+36>: mv s6,a5
   0xffffffff8000bc18 <+38>: mv s5,a6
   0xffffffff8000bc1a <+40>: mv s4,a7
   0xffffffff8000bc1c <+42>: nop
   0xffffffff8000bc20 <+46>: mv a0,s9
   0xffffffff8000bc22 <+48>: mv a1,s8
   0xffffffff8000bc24 <+50>: mv a2,s7
   0xffffffff8000bc26 <+52>: mv a3,s6
   0xffffffff8000bc28 <+54>: mv a4,s5
   0xffffffff8000bc2a <+56>: mv a5,s4
   0xffffffff8000bc2c <+58>: mv a6,s3
   0xffffffff8000bc2e <+60>: mv a7,s1
   0xffffffff8000bc30 <+62>: ecall
   0xffffffff8000bc34 <+66>: mv s4,a0
   0xffffffff8000bc36 <+68>: mv s3,a1
   0xffffffff8000bc38 <+70>: nop
   0xffffffff8000bc3c <+74>: ld ra,104(sp)
   0xffffffff8000bc3e <+76>: ld s0,96(sp)
   0xffffffff8000bc40 <+78>: ld s1,88(sp)
   0xffffffff8000bc42 <+80>: ld s2,80(sp)
   0xffffffff8000bc44 <+82>: ld s5,56(sp)
   0xffffffff8000bc46 <+84>: ld s6,48(sp)
   0xffffffff8000bc48 <+86>: ld s7,40(sp)
   0xffffffff8000bc4a <+88>: ld s8,32(sp)
   0xffffffff8000bc4c <+90>: ld s9,24(sp)
   0xffffffff8000bc4e <+92>: mv a0,s4
   0xffffffff8000bc50 <+94>: mv a1,s3
   0xffffffff8000bc52 <+96>: ld s4,64(sp)
   0xffffffff8000bc54 <+98>: ld s3,72(sp)
   0xffffffff8000bc56 <+100>: add sp,sp,112
   0xffffffff8000bc58 <+102>: ret

Not sure this is really problematic though, let me know what you think.

FYI, I'm about to send a patch to reorder the arguments of sbi_ecall()
to avoid the mv-dance before the ecall.

Thanks,

Alex

