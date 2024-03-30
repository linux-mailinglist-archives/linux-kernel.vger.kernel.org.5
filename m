Return-Path: <linux-kernel+bounces-126180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E089334B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294351F236A3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C061155A59;
	Sun, 31 Mar 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nle+vzJj"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6C154425;
	Sun, 31 Mar 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902519; cv=fail; b=YOjkJvV7o6UhFBfNMl53sSzkXk7CfsaIdUZdFNRBVK6LTs93Hh52n+/Ou/LDkuBVhSRcDjyIjiuMELOV3LXoLtdFQy5jb8QUS4RQcZT2K/NWTAn/a8WtOufaJ2wABLh9qgQXsuDVpTQbYxSdzoiIOR9D5JbEKUDKpuMkhI/CbBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902519; c=relaxed/simple;
	bh=iCPuYGTwaJTGC1ivQKfSK1Ydr+Yg0BM/A/ZR5mYdhaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfXx0AlOF2Ob6kc5qEtwDyb4YjVt6a6EdMU2u04me8U8ND+3Gx9jetuk7CmIF2AXksqkOuRIxdfDh2z69UbI4bwdtjL+4WoQOuiU/214Mzx/RWy7o1FGh4OpuDqeSZ4yXk5J8BE9pFTJUHZwW4XMX3z82LY8dem4Bw0DkCiCziU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nle+vzJj reason="signature verification failed"; arc=none smtp.client-ip=209.85.208.171; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id AE964208D2;
	Sun, 31 Mar 2024 18:28:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oB9rEsbX0BEs; Sun, 31 Mar 2024 18:28:31 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 605AC208D9;
	Sun, 31 Mar 2024 18:28:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 605AC208D9
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 535E4800058;
	Sun, 31 Mar 2024 18:28:30 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:30 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:46 +0000
X-sender: <netdev+bounces-83496-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoADaTp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAPAAAAl4oAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 27017
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83496-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com BCB2D207E4
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789276; cv=none; b=LJliKGtxdDA5DncUU3WQ86IqJfxxDdmZL62lReMe091FMMVzSAkVNUab0eixlHeqVTjIQ9EEtdUySkdcLp6rFtixRUTTmQdeeFsygIBsVZzOYDo25RMQNI1crLiHrVMDdGnqz68Wu6CyxrARRiiLwfKV6AS/7WwNSvW09W60zck=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789276; c=relaxed/simple;
	bh=CFUfaZfb7X/JJv0DB5cn0CBJrMrECWzMZrlMK1UCZYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3BMwVDUvqhNVOZ/cIBlL/eEF8qwRIumKR1fMWrSA7H4zcSOpuQv/ioQzXQqrodsIUyARBuvkzwtgX1F3ahG1oBV9JsqyrWjN58qqzsylGWNrONt419EuA+HV2Hnb6GN/l1yLYA/QgPCW6C6kp/GDTzIPXK00zlXkPjIpLmtnu4=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nle+vzJj; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711789272; x=1712394072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbl/CLMq3nWKqNjaubWInMz1kaQBbZVVwZ4B6Yhcsik=;
        b=Nle+vzJjShWs0Ti3+DNi47la3wp5ECIHDAW+EvbhX+Ton8pxr5GAT+OKLN9tkpsdWp
         7pmY92Vv0JN9muB7m6ZKKOed2eTaDIbVC7yQe3iYoQYmuzNt6FG/2CRXCn5axo5T0Er+
         mIawl+AjZ9LcJ+2LwfqLqtGS9Swzi333W06D5Rkope/9r9oRpQjGT7vy46uzFz6Xcl6b
         S77spLQ2G+CQpl+4BKwdDBzhD3S36TpnXk6mrY+NzXkbO3VsCQIQvMCBSh38nAhwLdwg
         DDcnS4Gu8cVLbgH/tpVDy41vXbLuY8G8wYbQmHDkXrHBBWVRq9R4WCn8orBArD2q7glw
         BXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711789272; x=1712394072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbl/CLMq3nWKqNjaubWInMz1kaQBbZVVwZ4B6Yhcsik=;
        b=SissUbPdoWrUM0u1xqTsea9iktJot0W8ikz/21w6oDLw29oHo1E/zyykrKQer/3OWO
         qPdKEegxJqdMg3v5GqOnOKWhyGLwFbh6p2b85j1Ts+6BbLFl9oFkAqze+79DH3UTgvpX
         8eHg+dcra2W81v3T0kNwO/Rz19x/a4qUnJoY4xXfsGku0ULlQwIKn/HG4uSfeFFaQsvQ
         uTzuZm8A/9h9KcYqL8SvAcdlpvE/AK5/d243lGtC7Es8bpk5HpBF6YLgEqB9CQU7scmf
         XLKGETg+gvfwQ/3vIK2nDBH9GUewEyTA+wZonkJx4DDqfRJaO4cU3mQBB6idP5IB1mep
         Hw+g==
X-Forwarded-Encrypted: i=1; AJvYcCXMPjsPXXatSVDH641eiZD9Tylx5ujw2zvU8pLsO9HYR1XJhfBDwIOO8cDOnkZQvsFw51iNGrNYsj+ZOC9s/nmtelqQeBg/s4CmUPCyx03PDGJu4fX5flrhGr2i0fu9s/8eCySMSfdAa696W6WVC4RItEDieQnLUtLc
X-Gm-Message-State: AOJu0YxogawIyIXt1FmwtLXKYPIfA7/NqcoJp2+CkbXskVq401KWqBS9
	dv/uHIbm1VAuF/Vdv+59bCR/JaF94WfnbXteVNB+T1wBqWVEkaHONlAM1xQ2s4fdMV8thx39cxA
	tPcarlYh9vw0yYnOBdeRY+OsGAlI=
X-Google-Smtp-Source: AGHT+IGeaymGC7cAQwieQg4TakZq0ARBnpQFix3PExtV6ez87eomevGZHhs6eDxl1CtxiB/HrZm8Uq2a8idogtbdJIc=
X-Received: by 2002:a2e:8612:0:b0:2d6:a5ce:b261 with SMTP id
 a18-20020a2e8612000000b002d6a5ceb261mr2175202lji.25.1711789271815; Sat, 30
 Mar 2024 02:01:11 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094906.18147-1-ubizjak@gmail.com> <20240329094906.18147-3-ubizjak@gmail.com>
 <CAADnVQ+6D++hCXaP=aK+Q5wienMzhHo3h9YCvpA_7sHjMt+q6A@mail.gmail.com>
In-Reply-To: <CAADnVQ+6D++hCXaP=aK+Q5wienMzhHo3h9YCvpA_7sHjMt+q6A@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 30 Mar 2024 10:01:04 +0100
Message-ID: <CAFULd4b6juiw3wC3Z61V9=-UnA+NGyUt4231vC14UnGAATk6tA@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf 2/2] x86/bpf: Fix IP for relocating call depth accounting
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 29, 2024 at 10:53=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 29, 2024 at 2:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> >
> > The recently introduced support for %rip-relative relocations in the
> > call thunk template assumes that the code is being patched in-place,
> > so the destination of the relocation matches the address of the code.
> > This is not true for the call depth accounting emitted by the BPF JIT,
> > so the calculated address is wrong and usually causes a page fault.
>
> Could you share the link to what this 'rip-relative' relocation is ?

Please see the "RIP relative addressing" section in [1].

[1] https://compas.cs.stonybrook.edu/~nhonarmand/courses/sp17/cse506/ref/as=
sembly.html

In our case:

The callthunks patching creates a call thunk template in the .rodata
section (please see arch/x86/kernel/callthunks.c)  that is later
copied to the .text section at the correct place. The template uses
X86_call_depth in the pcpu_hot structure. Previously, the template
used absolute location for X86_call_depth and the linker resolved the
address in the template to this absolute location. There is no issue
when this template is copied to the various places in the .text
section.

When we want to use PC relative relocations (to reduce the code size),
then the linker calculates the address of the variable in the template
according to the PC in the .rodata section. If we want to copy the
template to its final location, then the address of X86_call_depth,
relative to the PC, has to be adjusted, as explained in
arch/x86/kernel/alternative.c, in the comment above apply_reloc_n
macro.

Uros.

> > Pass the destination IP when the BPF JIT emits call depth accounting.
> >
> > Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations =
in call thunk template")
>
> Ohh. It's buried inside that patch.
> Pls make commit log a bit more clear that that commit 17bce3b2ae2d
> broke x86_call_depth_emit_accounting logic.
>
> > Signed-off-by: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> > Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
> > Acked-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > ---
> >  arch/x86/include/asm/alternative.h |  4 ++--
> >  arch/x86/kernel/callthunks.c       |  4 ++--
> >  arch/x86/net/bpf_jit_comp.c        | 19 ++++++++-----------
> >  3 files changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/=
alternative.h
> > index fcd20c6dc7f9..67b68d0d17d1 100644
> > --- a/arch/x86/include/asm/alternative.h
> > +++ b/arch/x86/include/asm/alternative.h
> > @@ -117,7 +117,7 @@ extern void callthunks_patch_builtin_calls(void);
> >  extern void callthunks_patch_module_calls(struct callthunk_sites *site=
s,
> >                                           struct module *mod);
> >  extern void *callthunks_translate_call_dest(void *dest);
> > -extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
> > +extern int x86_call_depth_emit_accounting(u8 **pprog, void *func, void=
 *ip);
> >  #else
> >  static __always_inline void callthunks_patch_builtin_calls(void) {}
> >  static __always_inline void
> > @@ -128,7 +128,7 @@ static __always_inline void *callthunks_translate_c=
all_dest(void *dest)
> >         return dest;
> >  }
> >  static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
> > -                                                         void *func)
> > +                                                         void *func, v=
oid *ip)
> >  {
> >         return 0;
> >  }
> > diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.=
c
> > index 30335182b6b0..e92ff0c11db8 100644
> > --- a/arch/x86/kernel/callthunks.c
> > +++ b/arch/x86/kernel/callthunks.c
> > @@ -314,7 +314,7 @@ static bool is_callthunk(void *addr)
> >         return !bcmp(pad, insn_buff, tmpl_size);
> >  }
> >
> > -int x86_call_depth_emit_accounting(u8 **pprog, void *func)
> > +int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
> >  {
> >         unsigned int tmpl_size =3D SKL_TMPL_SIZE;
> >         u8 insn_buff[MAX_PATCH_LEN];
> > @@ -327,7 +327,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void=
 *func)
> >                 return 0;
> >
> >         memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
> > -       apply_relocation(insn_buff, tmpl_size, *pprog,
> > +       apply_relocation(insn_buff, tmpl_size, ip,
>
> Did the logic inside apply_relocation() change to have
> a new meaning for 'dest' and 'src'?
> Answering to myself... yes. in that commit.
> Better commit log would have made the code review so much easier.
>
> >                          skl_call_thunk_template, tmpl_size);
> >
> >         memcpy(*pprog, insn_buff, tmpl_size);
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 09f7dc9d4d65..f2e8769f5eee 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -481,7 +481,7 @@ static int emit_rsb_call(u8 **pprog, void *func, vo=
id *ip)
> >  {
> >         void *adjusted_ip;
> >         OPTIMIZER_HIDE_VAR(func);
> > -       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func=
);
> > +       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func=
, ip);
>
> Now I see why you added extra var in the previous patch.
> Should have mentioned it in the commit log.
>
> >         return emit_patch(pprog, func, adjusted_ip, 0xE8);
> >  }
> >
> > @@ -1973,20 +1973,17 @@ st:                     if (is_imm8(insn->off))
> >
> >                         /* call */
> >                 case BPF_JMP | BPF_CALL: {
> > -                       int offs;
> > +                       u8 *ip =3D image + addrs[i - 1];
> >
> >                         func =3D (u8 *) __bpf_call_base + imm32;
> >                         if (tail_call_reachable) {
> >                                 RESTORE_TAIL_CALL_CNT(bpf_prog->aux->st=
ack_depth);
> > -                               if (!imm32)
> > -                                       return -EINVAL;
> > -                               offs =3D 7 + x86_call_depth_emit_accoun=
ting(&prog, func);
> > -                       } else {
> > -                               if (!imm32)
> > -                                       return -EINVAL;
> > -                               offs =3D x86_call_depth_emit_accounting=
(&prog, func);
> > +                               ip +=3D 7;
> >                         }
> > -                       if (emit_call(&prog, func, image + addrs[i - 1]=
 + offs))
> > +                       if (!imm32)
> > +                               return -EINVAL;
> > +                       ip +=3D x86_call_depth_emit_accounting(&prog, f=
unc, ip);
> > +                       if (emit_call(&prog, func, ip))
> >                                 return -EINVAL;
> >                         break;
> >                 }
> > @@ -2836,7 +2833,7 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
> >                  * Direct-call fentry stub, as such it needs accounting=
 for the
> >                  * __fentry__ call.
> >                  */
> > -               x86_call_depth_emit_accounting(&prog, NULL);
> > +               x86_call_depth_emit_accounting(&prog, NULL, image);
>
> Overall it all makes sense.
> Pls respin with more precise commit logs.

X-sender: <linux-kernel+bounces-125632-steffen.klassert=3Dcunet.com@vger.ke=
rnel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Dc822;steffen.klassert@se=
cunet.com NOTIFY=3DVER; X-ExtendedProps=3DAVABYAAgAAAAUAFAARAPDFCS25BAlDktI=
I2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSX=
NSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAA=
AUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChG=
WURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwA=
XAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG=
1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHc=
m91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29u=
ZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAw=
AAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC=
5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAAB=
QBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1V=
c2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1J=
lc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb=
3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=0A=
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoADaTp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAaAAAAl4oAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=0A=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 27137
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DS1_2, cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 10:01:43 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DS1_2,
 cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sat, 30 Mar 2024 10:01:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 10A2520315
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 10:01:43 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.049
X-Spam-Level:
X-Spam-Status: No, score=3D.049 tagged_above=3D99 required=3D1
	tests=3DAYES_00=3D.9, DKIM_SIGNED=3D1, DKIM_VALID=3D.1,
	DKIM_VALID_AU=3D.1, FREEMAIL_FORGED_FROMDOMAIN=3D001,
	FREEMAIL_FROM=3D001, HEADER_FROM_DIFFERENT_DOMAINS=3D249,
	MAILING_LIST_MULTI=3D, RCVD_IN_DNSWL_MED=3D.3, SPF_HELO_NONE=3D001,
	SPF_PASS=3D.001] autolearn=3Dm autolearn_force=3D
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dss (2048-bit key) header.d=3Dail.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B8ZWMzr-RJt4 for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 10:01:42 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dilfrom; client-ip=139=
178.88.99; helo=3D.mirrors.kernel.org; envelope-from=3Dnux-kernel+bounces-=
125632-steffen.klassert=3Dcunet.com@vger.kernel.org; receiver=3Deffen.klass=
ert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com A420F2025D
Authentication-Results: b.mx.secunet.com;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3Dle+vzJj"
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id A420F2025D
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 10:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF4D282F2A
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AE9DF5A;
	Sat, 30 Mar 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3Dle+vzJj"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.2=
08.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F7847E;
	Sat, 30 Mar 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-ip 9=
85.208.171
ARC-Seal: i=3D a=3Da-sha256; d=3Dbspace.kernel.org; s=3Dc-20240116;
	t=1711789276; cv=3Dne; b=3DliKGtxdDA5DncUU3WQ86IqJfxxDdmZL62lReMe091FMMVzS=
AkVNUab0eixlHeqVTjIQ9EEtdUySkdcLp6rFtixRUTTmQdeeFsygIBsVZzOYDo25RMQNI1crLiH=
rVMDdGnqz68Wu6CyxrARRiiLwfKV6AS/7WwNSvW09W60zckARC-Message-Signature: i=3D =
a=3Da-sha256; d=3Dbspace.kernel.org;
	s=3Dc-20240116; t=1711789276; c=3Dlaxed/simple;
	bh=CFUfaZfb7X/JJv0DB5cn0CBJrMrECWzMZrlMK1UCZYA=3D=0A=
	h=3DME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3DBMwVDUvqhNVOZ/cIBlL/eEF8qwRIumKR1fMWrSA7H4zcSOpuQ=
v/ioQzXQqrodsIUyARBuvkzwtgX1F3ahG1oBV9JsqyrWjN58qqzsylGWNrONt419EuA+HV2Hnb6=
GN/l1yLYA/QgPCW6C6kp/GDTzIPXK00zlXkPjIpLmtnu4ARC-Authentication-Results: i=
=3D smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3Dne) header.from=3Dai=
l.com; spf=3Dss smtp.mailfrom=3Dail.com; dkim=3Dss (2048-bit key) header.d=
=3Dail.com header.i=3Dmail.com header.b=3De+vzJj; arc=3Dne smtp.client-ip 9=
85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3D=
ne) header.from=3Dail.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=3D=
ail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d6ee6c994=
5so20258311fa.3;
        Sat, 30 Mar 2024 02:01:13 -0700 (PDT)
DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=3Dail.com; s 230601; t=1711789272; x=1712394072; darn=3Der.kernel=
org;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBl/CLMq3nWKqNjaubWInMz1kaQBbZVVwZ4B6Yhcsik=3D=0A=
        b=3De+vzJjShWs0Ti3+DNi47la3wp5ECIHDAW+EvbhX+Ton8pxr5GAT+OKLN9tkpsdW=
p
         7pmY92Vv0JN9muB7m6ZKKOed2eTaDIbVC7yQe3iYoQYmuzNt6FG/2CRXCn5axo5T0E=
r+
         mIawl+AjZ9LcJ+2LwfqLqtGS9Swzi333W06D5Rkope/9r9oRpQjGT7vy46uzFz6Xcl=
6b
         S77spLQ2G+CQpl+4BKwdDBzhD3S36TpnXk6mrY+NzXkbO3VsCQIQvMCBSh38nAhwLd=
wg
         DDcnS4Gu8cVLbgH/tpVDy41vXbLuY8G8wYbQmHDkXrHBBWVRq9R4WCn8orBArD2q7g=
lw
         BXGA=3D=0A=
X-Google-DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=1E100.net; s 230601; t=1711789272; x=1712394072;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBl/CLMq3nWKqNjaubWInMz1kaQBbZVVwZ4B6Yhcsik=3D=0A=
        b=3DssUbPdoWrUM0u1xqTsea9iktJot0W8ikz/21w6oDLw29oHo1E/zyykrKQer/3OW=
O
         qPdKEegxJqdMg3v5GqOnOKWhyGLwFbh6p2b85j1Ts+6BbLFl9oFkAqze+79DH3UTgv=
pX
         8eHg+dcra2W81v3T0kNwO/Rz19x/a4qUnJoY4xXfsGku0ULlQwIKn/HG4uSfeFFaQs=
vQ
         uTzuZm8A/9h9KcYqL8SvAcdlpvE/AK5/d243lGtC7Es8bpk5HpBF6YLgEqB9CQU7sc=
mf
         XLKGETg+gvfwQ/3vIK2nDBH9GUewEyTA+wZonkJx4DDqfRJaO4cU3mQBB6idP5IB1m=
ep
         Hw+g=3D=0A=
X-Forwarded-Encrypted: i=3D AJvYcCXMPjsPXXatSVDH641eiZD9Tylx5ujw2zvU8pLsO9H=
YR1XJhfBDwIOO8cDOnkZQvsFw51iNGrNYsj+ZOC9s/nmtelqQeBg/s4CmUPCyx03PDGJu4fX5fl=
rhGr2i0fu9s/8eCySMSfdAa696W6WVC4RItEDieQnLUtLc
X-Gm-Message-State: AOJu0YxogawIyIXt1FmwtLXKYPIfA7/NqcoJp2+CkbXskVq401KWqBS=
9
	dv/uHIbm1VAuF/Vdv+59bCR/JaF94WfnbXteVNB+T1wBqWVEkaHONlAM1xQ2s4fdMV8thx39cx=
A
	tPcarlYh9vw0yYnOBdeRY+OsGAlIX-Google-Smtp-Source: AGHT+IGeaymGC7cAQwieQg4T=
akZq0ARBnpQFix3PExtV6ez87eomevGZHhs6eDxl1CtxiB/HrZm8Uq2a8idogtbdJIcX-Receiv=
ed: by 2002:a2e:8612:0:b0:2d6:a5ce:b261 with SMTP id
 a18-20020a2e8612000000b002d6a5ceb261mr2175202lji.25.1711789271815; Sat, 30
 Mar 2024 02:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094906.18147-1-ubizjak@gmail.com> <20240329094906.1814=
7-3-ubizjak@gmail.com>
 <CAADnVQ+6D++hCXaP=3D+Q5wienMzhHo3h9YCvpA_7sHjMt+q6A@mail.gmail.com>
In-Reply-To: <CAADnVQ+6D++hCXaP=3D+Q5wienMzhHo3h9YCvpA_7sHjMt+q6A@mail.gmai=
l.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 30 Mar 2024 10:01:04 +0100
Message-ID: <CAFULd4b6juiw3wC3Z61V9=3DnA+NGyUt4231vC14UnGAATk6tA@mail.gmail=
com>
Subject: Re: [PATCH RESEND bpf 2/2] x86/bpf: Fix IP for relocating call dep=
th accounting
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>,=20
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kern=
el.org>,=20
	=3DTF-8?Q?Joan_Bruguera_Mic=C3=B3?=3Doanbrugueram@gmail.com>,=20
	Ingo Molnar <mingo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,=20
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset=3DTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: linux-kernel+bounces-125632-steffen.klassert=3Dcunet.com@vger.=
kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 09:01:43.0950
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 728bc2a0-e193-4119-8421-08dc=
5098051f
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dx-dres=
den-01.secunet.de:TOTAL-HUB=3D436|SMR=3D345(SMRDE=3D035|SMRC=3D310(SMRCL=3D=
101|X-SMRCR=3D310))|CAT=3D090(CATOS=3D012
 (CATSM=3D012(CATSM-Malware
 Agent=3D012))|CATRESL=3D040(CATRESLP2R=3D017)|CATORES=3D035
 (CATRS=3D035(CATRS-Index Routing Agent=3D034)));2024-03-30T09:01:43.556Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 16312
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=CAs-essen-01.secunet.de:TOTA=
L-FE=3D025|SMR=3D009(SMRPI=3D007(SMRPI-FrontendProxyAgent=3D007))|SMS=3D015
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAT4OAAAPAAADH4sIAAAAAAAEAMVZ6XLb=
1hUGKS4SJXppnK
 Zp486Nk9jaSImUrM2uY9lRJkolW2MraaaZDAcEL0VYIMDBoiWpO32j
 /ugj9E3aF+l3zgVAkARFOclMMRwSujj7+c6550L/ffTSFl+65rI41F
 1R314W9dX6utB9UVvdebj2n3/88+hQ7FryQprita+7zplj+s5ZufRY
 58Wq1198etLVTatqON0n4tx1fLlTLj3BR4xTUd9Z34aG3UPxjet44p
 n54xv9VDwOmnyTKk6wwCeQ53R3xNeObotnbnASSFcXh6bx73+Jx2+w
 2AzXugkhCe7jjhSuNKTtW5fCtH3XaQWGbAkv6PUc1xdtxxWfuWav4k
 pL980zorYcA7eO7YFB+B2pJBm6ZeGvwD4Vvuz2QC2F7nlBV3pYho+g
 FIbTksL0RFOa9ono6b7RgTLTroDekMtKkucwbUt6vmmzJuG0eamvW3
 SZ1+NlvdVypedFVKSkGrkHZfjYDvS7gWR/mIasbcme3xG6YTiB7ZNB
 smv6PgxqXjLRs6Mvxdf7x4NmgdMIyLtWrBcKkBbw63ZLBF4A2ZegCz
 zYp8PLE+jVA8uvhih47gRWS1w6gfA6uitZrGVS4BxxrkIFkQ+SYX+Q
 9B0PPy+XyqUjS+qeFJ5UIu692j8ScZ5C4+DWPVAYitEW39d+qBIvfk
 XH93vezsoKMNHTvarhAcOOfdl0Hee0KlvByt/tjmPrbhd+gShw4dCK
 16ttrhiefLi6seLK9gpyLLtN67La8bsWSd5HugIX/nuE03LpOAw3Y8
 NTSadgG65EFClCadBR0BJVAFL39XIpcmG+13dad43OysXWxsqpdG1p
 rfS1VI0FoVCHWJE8t1wynJ6JpPkqjVVfXvhxYGJ4uigGXzAaq1wcsU
 GUzXLpu62NBqlpKOyEVvaMXtDoAGMeQGb4gQvmI1eemU7gWZfLTBMJ
 KpcgCdhpeo4VQG6cVYLmkHjCUwQO6SK34DmTLVV0MfrsAfnKQbg9oo
 EdcqWqB3x7AaScd6St6Puh98RgrM50lzxRYYkVcgTjxDCo/kLCzqU4
 122fmOGpOHouUnvHPJ67krpNvzN45o9yAeXmK6Nix+OaS613Mk9vWn
 I4EggRStttEdhCT2DMILAiBFTFfjtpOQJwqcKcjKvpe6KNnmTFMeXc
 2sNWDaYRDsURiO1YFh3doz+bxPkm8NBQltEwhbyAOtPmtggPhiCuW8
 CyzbKqxnLkDAq4ixaOlDtU+b2eddngWDcgoqsbrsPpob2Fb6idHaFw
 R/osGsh55E/Y/bgpeukNs5rch8wL6e2I2mbTkGvNui7rLTF/j0zvl+
 WO+AqQRqau3FJS2sG9hWgD7XSQKv8BtpDANTlIntmSqta5tbBNR5aH
 HeJURcb0kS40Z9HEXddBBRjoIW60K+ErpEraTlLQCCHiYiCZDQpHI7
 FnQLRpRJ39iXhtniB3FafdrjQvf86+LF6hb8hzyCD+CeOA4tg1TkPy
 ffvEEYeOhaYtHndhnvNUAafquCch9XNjJ2WOEY91z08n/kK3TWmJZ4
 57ip3AFo9bvPDUdE4QxqZzUbWlH9JXKhV102/Opm1YQUtio+gOwLcj
 /ibEulhaGmVJ6edCXWNZYMJKs9duvEF2aD+LOcBS2waLuir9K5Swho
 q20FiMjm6fUA3W6gQq6TIe55cWsPIQyLekWqgsJEDfMttt+HwC8Ogr
 1/C4eQ0iJdm0W/JCtI1WfdXYaBmb7e1qdWOzubHVWm3VNls1TKWrG+
 vrcdSvpV9RIwzvYMjTp6JSq20ub4ol9YMFNH6QCSCnldjaG1x/jWZg
 WqgMrhlvnmgWHoWxvpKvi9HTkiGb2kj7RA3PpO6/yD/hQHb9K5SmNI
 hF/KaatJiwyXd126PWE9W+588rIrqN2CshOybnCX1iPtgSi4u9nuuc
 LIfa2oFtRIKWfqmg6N7sxa59Ii0vHM4RASTVEI2Gbp3rl17DtLG1yu
 tnUPz0drKkBGDqWwwY/sHCVerfIeqDeXclJi2b96/I5QlGvlt0wxS/
 A84Gr0SWwyT/CqISeQ59/Sk1KqtDIUnvVGmNtnnl42R3WltdW3tY26
 o3N5qr1arcrrfbq0at1mpuXdWdxgod6ktj6Qhga7V1Apj66QOs6TgW
 5tdGzBSih2azdPR83DS6vfme3qJhyrOB/XYbQx3GjgZPo4NhDB36+e
 UeevprlHl6+gPMQydqevT7bog/idd/PmgcHx4dNF7v/3Xv0RDTVt/5
 7w93v2sc7R4//6pxsPfih0eJmNd5F1A/WPilURi+BpE7SNOVXaN3OZ
 9IkXdqKc1qf4gmxZTcRRWcmIt52JxPS/iyGKj+pXfjNXvL4ST4hRke
 3Wg8jKbUESkL4dhBB4GOfsbdWhe2PIfDGLIwXtKp8AG1uAd8Gnzguc
 aDz4ls1/bOpRuebbqXnrTa1WpVXEqvqo4F8VzLE/Ez6ft0kurPw+f8
 FoK0YlRuJU5hLg+g9L6jGxgdgeO2Kd3+hDv2unZGUlMbweSqKkxvYi
 mjX/Oqp8kWtrrd3mwZ26311sbDarVdl1ubG9vth1LKq1rYOJlDHWwc
 GRXT+laNikn99BsY1RQXkes1OZg/tw9EfU+dLBtmb6jkXx4d7x+iE7
 xqfLX/xV7j291X88l5JK6ZvgD0EHwtTSr50NSB4ebXEEbFxQJJ5gvn
 XOzzO6DzziW/SUOHR9PDFIVj1hlOP9GbmfAtTOJs+LqTAD5OzahDap
 d+8jCtSmQU82GLYjNZ4qCFCQeXxerF3lbq9sED0vbm2nJ9FSMS3dRC
 COyk1pXZFvPY08xud4vbTuUJTpcLCymlNHytLKrD9OJKOh29o6Nzfu
 PrwyOck+ju+e7BwU4EpnGzD6EUNnhD+R2+CLoq1V16B7rEr0i8703I
 rf2Q1gqGL4oq2LkGFjDNUTExWppk+BLkdtfqj66WQdHzcV5WjK7U0X
 GbllwYLphx16u918cvX+01jnf3Dzg6jecvjufJEsp85YkeXFSeoHqN
 U4Xh4Qq6yq6P2YGFdxs0QwxW9vZffLt7cE1tlC1EcnNyyd0frd9xwt
 8KOmFMAsv/1eF3d3bSkE5tC4GcgLq3EwoIsWBbuMXfH+hyKbWCP8mf
 hQnniJEIT/IlNbJjpbPj1w9o3LAnWDwuDr2FMXPitbwYdzXRAU7H0L
 zt9+f61toG7c/4XRvZoHGsxBaP+pc93ZXclbDtdHsOHTKjVxfxakNl
 dNHsRpu2e461MWYuYnKk/0FUuHG3sT+5l9AdNPnlsEcDGTYnW8qWl/
 zPVfh/rbFCGw0lqtHgHaE6jnAlHbfXy/qLbw4OxmX8+hLCEoj3+pdn
 0qVY0NCHH3qti0BI25Pxq15Xej3s3uem31EveJEaw/SSe7l68a1pWW
 1qSstPZbQ5fLRcVsvltHw2MzWtadPaTEErzmo3ChntI7qZy2sFEOe1
 8jiuoqYVtWncF7TpYka7rU1HLLdzWgHrkImbckb7QLvBj25OaTkslr
 RZMIYyeQXqWAvowV7AipI8pXRpU1jESjYDO3GviHMRVy4SmCMaXslp
 s4pRScC3uoEcRawe8aeUFKJ0KVEISEbLMldZLapvJRnf8C5yoQT2LL
 OwzHzk6RybnctoWiYzTd+Qn9FeMSWEgAvESjVHsqgYc31HZpRtKiaR
 PRQilRcKPucu9hT3oM/0Q1dUuqbI4Hzse5HyFasjR25EIQpVU7RJ4I
 w2C0eYsqTSOs1WJVlUMKGIH/W1KDsjrpISrqziAOYVQWRhGPbIWiR9
 Lo62IsA3A6asuJTXuQgtyvckEqJAkfEzUa6VDRy9YpEJYhUsJx9zca
 hLSngos+/1dEyWZfeVnGnWwrr6GZml6plKRL4AGJTxrRUIEqSirIgV
 qmPQKhsi6P4WcZvjOkJGkPqhCoqwcVvlusCp58WSCpSKGFAUl0Muop
 zTbuUZBn9MPEIw89rNAplanIpqf6SuS8DlLIUiN9INSnlCUSF+hD9v
 aQU2g+LDkSmrkCYXEUMovaMVZ8jyO3H8VXwymTyXUnkA8JnZ5KLC51
 xU+HiaRQPM3GWaLPWTzEyWW2Ipc1PdzGgf5KL4DGsEa8piEXLmtBtz
 mXJB0wrarTSa2ZTFDNINNexFJtu/50RQ2CkLs6rpcSLK8fpdXi+wan
 zPZLSbVFb4c4PTDRVzTFxQQmYYvapZKTkqMkNZztJ98do09MlSbc4W
 MsWbWjZG2ojlNwcIMuWxjg/ISTX+PX50J0k53s4vmWUvYe2HYGRdt4
 ayHDXM7MjK2PxGBLPDK5MymyVMTrFfyiPVuPKwZka5Gd78flIK5q6X
 ow9Vr47EFqeollXPfI86RrieV+vcAW6Mc2GSxj9EEX6fcx16NEWNIh
 e1plK0fke1AkgY8R1hv+IpnCrFjZEKIaQsq40jx7tkVG5sAFk+o5p/
 gXjDPl8AeiMUxZ0w7pMRzcIY+z8s8AY6Yt7cELqGG1ECZiOPxuJthH
 J27KMrEaiQUO5PVsNowXfUzG+jt/wm2vuQr2iduNK2ieL1aKBlNt6D
 4jyqESLesrFhqXpRWVPrbH8IrRKLVQL7u0/mo7yGEBS41U/170np70
 CA0BfjyU1byml3FfKLZAYBdZoM/oz9/YToeZenPVqNcNp9GswyhZvR
 BspY/ZRVa+8xfma0Omrgfa7rXFQyLJZnYzIVZldY8nqBpp1KLqya0e
 Ka47xA6fIAPVdxGuUybGNRn2f7JR8md9ARrH/KMpdZ5mfZlK1/LkLF
 vVFpWW1RMeYz91WcFd769wpvmdxdBqra+0pccVO0Z6mkF3kwKCAvec
 oyGgjiU8yF3bIQT2Vqbme0/LFA48f6GGs/GudFXrsRz4SsuqQQlYum
 Yrr/H4HsKjsIKwAAAQKDBTw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2
 Rpbmc9InV0Zi0xNiI/Pg0KPFRhc2tTZXQ+DQogIDxWZXJzaW9uPjE1
 LjAuMC4wPC9WZXJzaW9uPg0KICA8VGFza3M+DQogICAgPFRhc2sgU3
 RhcnRJbmRleD0iNjEwIj4NCiAgICAgIDxUYXNrU3RyaW5nPiZndDsg
 Q291bGQgeW91IHNoYXJlIHRoZSBsaW5rIHRvIHdoYXQgdGhpcyAncm
 lwLXJlbGF0aXZlJyByZWxvY2F0aW9uIGlzID88L1Rhc2tTdHJpbmc+
 DQogICAgICA8QXNzaWduZWVzPg0KICAgICAgICA8RW1haWxVc2VyIE
 lkPSJhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tIj5BbGV4ZWkg
 U3Rhcm92b2l0b3Y8L0VtYWlsVXNlcj4NCiAgICAgIDwvQXNzaWduZW
 VzPg0KICAgIDwvVGFzaz4NCiAgICA8VGFzayBTdGFydEluZGV4PSI2
 ODQiPg0KICAgICAgPFRhc2tTdHJpbmc+UGxlYXNlIHNlZSB0aGUgIl
 JJUCByZWxhdGl2ZSBhZGRyZXNzaW5nIiBzZWN0aW9uIGluIFsxXS48
 L1Rhc2tTdHJpbmc+DQogICAgICA8QXNzaWduZWVzPg0KICAgICAgIC
 A8RW1haWxVc2VyIElkPSJhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwu
 Y29tIj5BbGV4ZWkgU3Rhcm92b2l0b3Y8L0VtYWlsVXNlcj4NCiAgIC
 AgIDwvQXNzaWduZWVzPg0KICAgIDwvVGFzaz4NCiAgPC9UYXNrcz4N
 CjwvVGFza1NldD4BCr0DPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZG
 luZz0idXRmLTE2Ij8+DQo8RW1haWxTZXQ+DQogIDxWZXJzaW9uPjE1
 LjAuMC4wPC9WZXJzaW9uPg0KICA8RW1haWxzPg0KICAgIDxFbWFpbC
 BTdGFydEluZGV4PSI1NCI+DQogICAgICA8RW1haWxTdHJpbmc+YWxl
 eGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbTwvRW1haWxTdHJpbmc+DQ
 ogICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3RhcnRJbmRleD0iMTQy
 IiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgICAgIDxFbWFpbFN0cm
 luZz51Yml6amFrQGdtYWlsLmNvbTwvRW1haWxTdHJpbmc+DQogICAg
 PC9FbWFpbD4NCiAgICA8RW1haWwgU3RhcnRJbmRleD0iMjA0Ij4NCi
 AgICAgIDxFbWFpbFN0cmluZz5qb2FuYnJ1Z3VlcmFtQGdtYWlsLmNv
 bTwvRW1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgPC9FbWFpbH
 M+DQo8L0VtYWlsU2V0PgELlAI8P3htbCB2ZXJzaW9uPSIxLjAiIGVu
 Y29kaW5nPSJ1dGYtMTYiPz4NCjxVcmxTZXQ+DQogIDxWZXJzaW9uPj
 E1LjAuMC4wPC9WZXJzaW9uPg0KICA8VXJscz4NCiAgICA8VXJsIFN0
 YXJ0SW5kZXg9Ijc0OCIgVHlwZT0iVXJsIj4NCiAgICAgIDxVcmxTdH
 Jpbmc+aHR0cHM6Ly9jb21wYXMuY3Muc3Rvbnlicm9vay5lZHUvfm5o
 b25hcm1hbmQvY291cnNlcy9zcDE3L2NzZTUwNi9yZWYvYXNzZW1ibH
 kuaHRtbDwvVXJsU3RyaW5nPg0KICAgIDwvVXJsPg0KICA8L1VybHM+
 DQo8L1VybFNldD4BDLIKPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZG
 luZz0idXRmLTE2Ij8+DQo8Q29udGFjdFNldD4NCiAgPFZlcnNpb24+
 MTUuMC4wLjA8L1ZlcnNpb24+DQogIDxDb250YWN0cz4NCiAgICA8Q2
 9udGFjdCBTdGFydEluZGV4PSIzMyI+DQogICAgICA8UGVyc29uIFN0
 YXJ0SW5kZXg9IjMzIj4NCiAgICAgICAgPFBlcnNvblN0cmluZz5BbG
 V4ZWkgU3Rhcm92b2l0b3Y8L1BlcnNvblN0cmluZz4NCiAgICAgIDwv
 UGVyc29uPg0KICAgICAgPEVtYWlscz4NCiAgICAgICAgPEVtYWlsIF
 N0YXJ0SW5kZXg9IjU0Ij4NCiAgICAgICAgICA8RW1haWxTdHJpbmc+
 YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbTwvRW1haWxTdHJpbm
 c+DQogICAgICAgIDwvRW1haWw+DQogICAgICA8L0VtYWlscz4NCiAg
 ICAgIDxDb250YWN0U3RyaW5nPkFsZXhlaSBTdGFyb3ZvaXRvdg0KJm
 x0O2FsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb208L0NvbnRhY3RT
 dHJpbmc+DQogICAgPC9Db250YWN0Pg0KICAgIDxDb250YWN0IFN0YX
 J0SW5kZXg9IjEyOSIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogICAg
 ICA8UGVyc29uIFN0YXJ0SW5kZXg9IjEyOSIgUG9zaXRpb249IlNpZ2
 5hdHVyZSI+DQogICAgICAgIDxQZXJzb25TdHJpbmc+VXJvcyBCaXpq
 YWs8L1BlcnNvblN0cmluZz4NCiAgICAgIDwvUGVyc29uPg0KICAgIC
 AgPEVtYWlscz4NCiAgICAgICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjE0
 MiIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogICAgICAgICAgPEVtYW
 lsU3RyaW5nPnViaXpqYWtAZ21haWwuY29tPC9FbWFpbFN0cmluZz4N
 CiAgICAgICAgPC9FbWFpbD4NCiAgICAgIDwvRW1haWxzPg0KICAgIC
 AgPENvbnRhY3RTdHJpbmc+VXJvcyBCaXpqYWsgJmx0O3ViaXpqYWtA
 Z21haWwuY29tPC9Db250YWN0U3RyaW5nPg0KICAgIDwvQ29udGFjdD
 4NCiAgICA8Q29udGFjdCBTdGFydEluZGV4PSIxODQiPg0KICAgICAg
 PFBlcnNvbiBTdGFydEluZGV4PSIxODQiPg0KICAgICAgICA8UGVyc2
 9uU3RyaW5nPkpvYW4gQnJ1Z3VlcmE8L1BlcnNvblN0cmluZz4NCiAg
 ICAgIDwvUGVyc29uPg0KICAgICAgPEVtYWlscz4NCiAgICAgICAgPE
 VtYWlsIFN0YXJ0SW5kZXg9IjIwNCI+DQogICAgICAgICAgPEVtYWls
 U3RyaW5nPmpvYW5icnVndWVyYW1AZ21haWwuY29tPC9FbWFpbFN0cm
 luZz4NCiAgICAgICAgPC9FbWFpbD4NCiAgICAgIDwvRW1haWxzPg0K
 ICAgICAgPENvbnRhY3RTdHJpbmc+Sm9hbiBCcnVndWVyYSBNaWPDsy
 AmbHQ7am9hbmJydWd1ZXJhbUBnbWFpbC5jb208L0NvbnRhY3RTdHJp
 bmc+DQogICAgPC9Db250YWN0Pg0KICA8L0NvbnRhY3RzPg0KPC9Db2
 50YWN0U2V0PgEOzwFSZXRyaWV2ZXJPcGVyYXRvciwxMCwwO1JldHJp
 ZXZlck9wZXJhdG9yLDExLDE7UG9zdERvY1BhcnNlck9wZXJhdG9yLD
 EwLDA7UG9zdERvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcmRC
 cmVha2VyRGlhZ25vc3RpY09wZXJhdG9yLDEwLDI7UG9zdFdvcmRCcm
 Vha2VyRGlhZ25vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3Jp
 dGVyUHJvZHVjZXIsMjAsMTgX-MS-Exchange-Forest-IndexAgent: 1 6578
X-MS-Exchange-Forest-EmailMessageHash: 400C00D2
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, Mar 29, 2024 at 10:53=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 29, 2024 at 2:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> >
> > The recently introduced support for %rip-relative relocations in the
> > call thunk template assumes that the code is being patched in-place,
> > so the destination of the relocation matches the address of the code.
> > This is not true for the call depth accounting emitted by the BPF JIT,
> > so the calculated address is wrong and usually causes a page fault.
>
> Could you share the link to what this 'rip-relative' relocation is ?

Please see the "RIP relative addressing" section in [1].

[1] https://compas.cs.stonybrook.edu/~nhonarmand/courses/sp17/cse506/ref/as=
sembly.html

In our case:

The callthunks patching creates a call thunk template in the .rodata
section (please see arch/x86/kernel/callthunks.c)  that is later
copied to the .text section at the correct place. The template uses
X86_call_depth in the pcpu_hot structure. Previously, the template
used absolute location for X86_call_depth and the linker resolved the
address in the template to this absolute location. There is no issue
when this template is copied to the various places in the .text
section.

When we want to use PC relative relocations (to reduce the code size),
then the linker calculates the address of the variable in the template
according to the PC in the .rodata section. If we want to copy the
template to its final location, then the address of X86_call_depth,
relative to the PC, has to be adjusted, as explained in
arch/x86/kernel/alternative.c, in the comment above apply_reloc_n
macro.

Uros.

> > Pass the destination IP when the BPF JIT emits call depth accounting.
> >
> > Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations =
in call thunk template")
>
> Ohh. It's buried inside that patch.
> Pls make commit log a bit more clear that that commit 17bce3b2ae2d
> broke x86_call_depth_emit_accounting logic.
>
> > Signed-off-by: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> > Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
> > Acked-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > ---
> >  arch/x86/include/asm/alternative.h |  4 ++--
> >  arch/x86/kernel/callthunks.c       |  4 ++--
> >  arch/x86/net/bpf_jit_comp.c        | 19 ++++++++-----------
> >  3 files changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/=
alternative.h
> > index fcd20c6dc7f9..67b68d0d17d1 100644
> > --- a/arch/x86/include/asm/alternative.h
> > +++ b/arch/x86/include/asm/alternative.h
> > @@ -117,7 +117,7 @@ extern void callthunks_patch_builtin_calls(void);
> >  extern void callthunks_patch_module_calls(struct callthunk_sites *site=
s,
> >                                           struct module *mod);
> >  extern void *callthunks_translate_call_dest(void *dest);
> > -extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
> > +extern int x86_call_depth_emit_accounting(u8 **pprog, void *func, void=
 *ip);
> >  #else
> >  static __always_inline void callthunks_patch_builtin_calls(void) {}
> >  static __always_inline void
> > @@ -128,7 +128,7 @@ static __always_inline void *callthunks_translate_c=
all_dest(void *dest)
> >         return dest;
> >  }
> >  static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
> > -                                                         void *func)
> > +                                                         void *func, v=
oid *ip)
> >  {
> >         return 0;
> >  }
> > diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.=
c
> > index 30335182b6b0..e92ff0c11db8 100644
> > --- a/arch/x86/kernel/callthunks.c
> > +++ b/arch/x86/kernel/callthunks.c
> > @@ -314,7 +314,7 @@ static bool is_callthunk(void *addr)
> >         return !bcmp(pad, insn_buff, tmpl_size);
> >  }
> >
> > -int x86_call_depth_emit_accounting(u8 **pprog, void *func)
> > +int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
> >  {
> >         unsigned int tmpl_size =3D SKL_TMPL_SIZE;
> >         u8 insn_buff[MAX_PATCH_LEN];
> > @@ -327,7 +327,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void=
 *func)
> >                 return 0;
> >
> >         memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
> > -       apply_relocation(insn_buff, tmpl_size, *pprog,
> > +       apply_relocation(insn_buff, tmpl_size, ip,
>
> Did the logic inside apply_relocation() change to have
> a new meaning for 'dest' and 'src'?
> Answering to myself... yes. in that commit.
> Better commit log would have made the code review so much easier.
>
> >                          skl_call_thunk_template, tmpl_size);
> >
> >         memcpy(*pprog, insn_buff, tmpl_size);
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 09f7dc9d4d65..f2e8769f5eee 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -481,7 +481,7 @@ static int emit_rsb_call(u8 **pprog, void *func, vo=
id *ip)
> >  {
> >         void *adjusted_ip;
> >         OPTIMIZER_HIDE_VAR(func);
> > -       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func=
);
> > +       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func=
, ip);
>
> Now I see why you added extra var in the previous patch.
> Should have mentioned it in the commit log.
>
> >         return emit_patch(pprog, func, adjusted_ip, 0xE8);
> >  }
> >
> > @@ -1973,20 +1973,17 @@ st:                     if (is_imm8(insn->off))
> >
> >                         /* call */
> >                 case BPF_JMP | BPF_CALL: {
> > -                       int offs;
> > +                       u8 *ip =3D image + addrs[i - 1];
> >
> >                         func =3D (u8 *) __bpf_call_base + imm32;
> >                         if (tail_call_reachable) {
> >                                 RESTORE_TAIL_CALL_CNT(bpf_prog->aux->st=
ack_depth);
> > -                               if (!imm32)
> > -                                       return -EINVAL;
> > -                               offs =3D 7 + x86_call_depth_emit_accoun=
ting(&prog, func);
> > -                       } else {
> > -                               if (!imm32)
> > -                                       return -EINVAL;
> > -                               offs =3D x86_call_depth_emit_accounting=
(&prog, func);
> > +                               ip +=3D 7;
> >                         }
> > -                       if (emit_call(&prog, func, image + addrs[i - 1]=
 + offs))
> > +                       if (!imm32)
> > +                               return -EINVAL;
> > +                       ip +=3D x86_call_depth_emit_accounting(&prog, f=
unc, ip);
> > +                       if (emit_call(&prog, func, ip))
> >                                 return -EINVAL;
> >                         break;
> >                 }
> > @@ -2836,7 +2833,7 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
> >                  * Direct-call fentry stub, as such it needs accounting=
 for the
> >                  * __fentry__ call.
> >                  */
> > -               x86_call_depth_emit_accounting(&prog, NULL);
> > +               x86_call_depth_emit_accounting(&prog, NULL, image);
>
> Overall it all makes sense.
> Pls respin with more precise commit logs.


