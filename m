Return-Path: <linux-kernel+bounces-126177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EC289332F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD14A282D3C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47201153BF3;
	Sun, 31 Mar 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtFEeVUc"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58EA147C93;
	Sun, 31 Mar 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902510; cv=fail; b=uZPcz9iPgjLy9idYPDdFHEp/G2CUu1YvoosBiUgg4oRTjkfK7tW7M9STmFvWSlSrMlfOTjw/l9aKEE4LLBDsWXW8qzrvHjKr8wUfq2YoBmsun8SoDkPspP1wSCPsgkSKXmESGLM97bv8mPYycoFDjbeyGhh6lZdI2DeGeNdDJcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902510; c=relaxed/simple;
	bh=lKNdfIJPzLfABJnWQROq4vNaLeRH+VdaQ+eVJkhZq6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqXIBd0Gh1mYCNKWaBiI/y0m9CvP5h5gKmkmnQwOkYVBL8qNMXymozEvF/jG1AuoZiWnOOxMt0KyfkGt1tS9GSL52Xdx2UKl0ROwgxwkPh0TqbGMZx9i6Q1D9zsIvC9e/Nv0pvfr6hdx4mty9R8UjFpOqad+plz/Apv05aNajMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtFEeVUc reason="signature verification failed"; arc=none smtp.client-ip=209.85.221.54; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A4A2420185;
	Sun, 31 Mar 2024 18:28:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J8SPew8I-Hlm; Sun, 31 Mar 2024 18:28:25 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1CB8520826;
	Sun, 31 Mar 2024 18:28:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1CB8520826
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 0FE4B800058;
	Sun, 31 Mar 2024 18:28:25 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:24 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:33 +0000
X-sender: <netdev+bounces-83468-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAPpLp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgC5AAAAi4oAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 23330
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83468-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 48CEE20882
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749199; cv=none; b=YcUIPWpHs7mLZnVdaPh2sGq8r5F5xF21yFPDxMZ/gm0YeJrT/TWfFs/Gh9WnFRa71L3nMBK9Nnv6q1uk/kZxQqMajeyclU7BgxRjaaMsw/eReYwfsEd5M1f1xxGZ/6c71chWZmsbAHPSHVYj437pvbvRgRDUvYwenfjdDa7AKfY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749199; c=relaxed/simple;
	bh=ZkGv2aECxPpKjlvqInjY5t6BAWJ1JpiWyKfHeeHLgFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4wUMXak4yyRayehjv1ar0r8EyyPLMwBc3uJ0bwl/C4uF0p7B7G/bWOwvNeZYeq6b3W3Vcfr0NdbT29Ffwzm149FPXaVcG2iO3WP/b1G80f4/vw74ISsQwa8epN/zn528A3NyNmNXX0nycQdjpBblQ7EyQAtFDKts98b9c+Xxik=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtFEeVUc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711749195; x=1712353995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSnIkrXKOxIFx664NuP3H7hYth27RezAKOIyptzRih0=;
        b=DtFEeVUcXHxQSM1acoLPB3xIZ2HSM6vWTSGbB4Vn2PTFo59S2qm9Wdb/PYmKmlkt7q
         bweDNoN2FkFdd+biODVbvTAWaLZraY63rTLXLI3Uj2YXC5gXRj51NmN6ndvk0CmDMb0e
         HIob6o5pR32SYbzkWHSn4Jg4Btu/S+g0UAjgMXPRMh1EcOgJV/whXSYiykrw7f/6s77P
         /H5ZCsxnDWl4kNYCj9mzXKbfqQBAv6Lnt80sLG1vRk3gD9HqNaAkNP/seJmggh7Vb0eo
         x3i++yNtv1UR3TkN0hCOiKzOfpwFxG/x3+oaCYHUq4IcorpsSpcrx239+6AZFAOrQdbA
         WyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711749195; x=1712353995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSnIkrXKOxIFx664NuP3H7hYth27RezAKOIyptzRih0=;
        b=oKWLVHtPvz9J+QXVTc54yStjx+NkapzU4nW5NsuqPQ5h82t98mF43eq2fZPnUSPhaT
         MGdf9ycXYZkO41VrOpN62JqHNhZQR/quC5iGCtAX8SbX3Zql03mdeT6pd9hdt04AMwNI
         v7s3h6cmiqq3SNt6pWwVBYRqxOm+JPpZT5yDuDLXj7HFAWYEdMSKpeIILWSrLfRqeGmF
         0Wu0zy7UE5pH6ZQnPhhEBhM4jmoqIk7Jl9U1SyEn4ioN3y3x18oyrKxSulpIT55d/yc8
         64AGB3PNnhGmaMJktfTQg6iokvhAcecEo9Sr4wvXZuzD5l1KTyylDAgGYGp2D5OwKZyP
         iGgw==
X-Forwarded-Encrypted: i=1; AJvYcCUd4xvQHL/oaQCMtCuugnR3C+1mNP+kYnHMed8zOGO5hdRvAX21HlPyuCzWSAKy8Bt5pMwgz3toD1E3Xn4ARVBMo22+kQWtIVLj26ICYQSx1B5RhgBvSbm3JXQKMiyRL5E4gFZ/VAumoFjE2Vcpg7zLq5/DEIrGAbwW
X-Gm-Message-State: AOJu0YyKhnyWxAp7UfXLi6lEMSL4950T9e1nKDvTnmG9yMcApYpszSgu
	6nlrYsSq1udaQLoImKyk+HbI3U4g2GsYOT0pZe1ZoHsOJsdjCd5+EVv1QU8gEWIM6DBowMLNfme
	dpizDXQEt670AhG7mMjM3Cbt2ZFB5CMSUPpA=
X-Google-Smtp-Source: AGHT+IESQ34cqmbczYM0CtTFQ4n7hfhahLrps7uGUEuczD5xhOvFv09EChC/YJ/FIRR8VtuzAy4gIzrPZKwGa0EMMVQ=
X-Received: by 2002:a5d:6d49:0:b0:341:e4f4:4399 with SMTP id
 k9-20020a5d6d49000000b00341e4f44399mr1687491wri.68.1711749195364; Fri, 29 Mar
 2024 14:53:15 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094906.18147-1-ubizjak@gmail.com> <20240329094906.18147-3-ubizjak@gmail.com>
In-Reply-To: <20240329094906.18147-3-ubizjak@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 14:53:03 -0700
Message-ID: <CAADnVQ+6D++hCXaP=aK+Q5wienMzhHo3h9YCvpA_7sHjMt+q6A@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf 2/2] x86/bpf: Fix IP for relocating call depth accounting
To: Uros Bizjak <ubizjak@gmail.com>
Cc: X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 29, 2024 at 2:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
>
> The recently introduced support for %rip-relative relocations in the
> call thunk template assumes that the code is being patched in-place,
> so the destination of the relocation matches the address of the code.
> This is not true for the call depth accounting emitted by the BPF JIT,
> so the calculated address is wrong and usually causes a page fault.

Could you share the link to what this 'rip-relative' relocation is ?

> Pass the destination IP when the BPF JIT emits call depth accounting.
>
> Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in=
 call thunk template")

Ohh. It's buried inside that patch.
Pls make commit log a bit more clear that that commit 17bce3b2ae2d
broke x86_call_depth_emit_accounting logic.

> Signed-off-by: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  arch/x86/include/asm/alternative.h |  4 ++--
>  arch/x86/kernel/callthunks.c       |  4 ++--
>  arch/x86/net/bpf_jit_comp.c        | 19 ++++++++-----------
>  3 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/al=
ternative.h
> index fcd20c6dc7f9..67b68d0d17d1 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -117,7 +117,7 @@ extern void callthunks_patch_builtin_calls(void);
>  extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
>                                           struct module *mod);
>  extern void *callthunks_translate_call_dest(void *dest);
> -extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
> +extern int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *=
ip);
>  #else
>  static __always_inline void callthunks_patch_builtin_calls(void) {}
>  static __always_inline void
> @@ -128,7 +128,7 @@ static __always_inline void *callthunks_translate_cal=
l_dest(void *dest)
>         return dest;
>  }
>  static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
> -                                                         void *func)
> +                                                         void *func, voi=
d *ip)
>  {
>         return 0;
>  }
> diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
> index 30335182b6b0..e92ff0c11db8 100644
> --- a/arch/x86/kernel/callthunks.c
> +++ b/arch/x86/kernel/callthunks.c
> @@ -314,7 +314,7 @@ static bool is_callthunk(void *addr)
>         return !bcmp(pad, insn_buff, tmpl_size);
>  }
>
> -int x86_call_depth_emit_accounting(u8 **pprog, void *func)
> +int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
>  {
>         unsigned int tmpl_size =3D SKL_TMPL_SIZE;
>         u8 insn_buff[MAX_PATCH_LEN];
> @@ -327,7 +327,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *=
func)
>                 return 0;
>
>         memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
> -       apply_relocation(insn_buff, tmpl_size, *pprog,
> +       apply_relocation(insn_buff, tmpl_size, ip,

Did the logic inside apply_relocation() change to have
a new meaning for 'dest' and 'src'?
Answering to myself... yes. in that commit.
Better commit log would have made the code review so much easier.

>                          skl_call_thunk_template, tmpl_size);
>
>         memcpy(*pprog, insn_buff, tmpl_size);
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 09f7dc9d4d65..f2e8769f5eee 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -481,7 +481,7 @@ static int emit_rsb_call(u8 **pprog, void *func, void=
 *ip)
>  {
>         void *adjusted_ip;
>         OPTIMIZER_HIDE_VAR(func);
> -       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func);
> +       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func, =
ip);

Now I see why you added extra var in the previous patch.
Should have mentioned it in the commit log.

>         return emit_patch(pprog, func, adjusted_ip, 0xE8);
>  }
>
> @@ -1973,20 +1973,17 @@ st:                     if (is_imm8(insn->off))
>
>                         /* call */
>                 case BPF_JMP | BPF_CALL: {
> -                       int offs;
> +                       u8 *ip =3D image + addrs[i - 1];
>
>                         func =3D (u8 *) __bpf_call_base + imm32;
>                         if (tail_call_reachable) {
>                                 RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stac=
k_depth);
> -                               if (!imm32)
> -                                       return -EINVAL;
> -                               offs =3D 7 + x86_call_depth_emit_accounti=
ng(&prog, func);
> -                       } else {
> -                               if (!imm32)
> -                                       return -EINVAL;
> -                               offs =3D x86_call_depth_emit_accounting(&=
prog, func);
> +                               ip +=3D 7;
>                         }
> -                       if (emit_call(&prog, func, image + addrs[i - 1] +=
 offs))
> +                       if (!imm32)
> +                               return -EINVAL;
> +                       ip +=3D x86_call_depth_emit_accounting(&prog, fun=
c, ip);
> +                       if (emit_call(&prog, func, ip))
>                                 return -EINVAL;
>                         break;
>                 }
> @@ -2836,7 +2833,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>                  * Direct-call fentry stub, as such it needs accounting f=
or the
>                  * __fentry__ call.
>                  */
> -               x86_call_depth_emit_accounting(&prog, NULL);
> +               x86_call_depth_emit_accounting(&prog, NULL, image);

Overall it all makes sense.
Pls respin with more precise commit logs.

X-sender: <linux-kernel+bounces-125454-steffen.klassert=3Dcunet.com@vger.ke=
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
X-ExtendedProps: BQBjAAoAPpLp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgC7AAAAi4oAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=0A=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 23484
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DS1_2, cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 22:53:44 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DS1_2,
 cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 22:53:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 131EF2032C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:53:44 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.749
X-Spam-Level:
X-Spam-Status: No, score=3D.749 tagged_above=3D99 required=3D1
	tests=3DAYES_00=3D.9, DKIM_SIGNED=3D1, DKIM_VALID=3D.1,
	DKIM_VALID_AU=3D.1, FREEMAIL_FORGED_FROMDOMAIN=3D001,
	FREEMAIL_FROM=3D001, HEADER_FROM_DIFFERENT_DOMAINS=3D249,
	MAILING_LIST_MULTI=3D, RCVD_IN_DNSWL_NONE=3D.0001,
	SPF_HELO_NONE=3D001, SPF_PASS=3D.001]
	autolearn=3Davailable autolearn_force=3D
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dss (2048-bit key) header.d=3Dail.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d5KexhzrzbVj for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 22:53:43 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dilfrom; client-ip=147=
75.199.223; helo=3D.mirrors.kernel.org; envelope-from=3Dnux-kernel+bounces=
-125454-steffen.klassert=3Dcunet.com@vger.kernel.org; receiver=3Deffen.klas=
sert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 3B5E2200BB
Authentication-Results: b.mx.secunet.com;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3DtFEeVUc"
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223=
])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 3B5E2200BB
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9C71C211BB
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9A513CF9A;
	Fri, 29 Mar 2024 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3DtFEeVUc"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221=
54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92E1E897;
	Fri, 29 Mar 2024 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-ip 9=
85.221.54
ARC-Seal: i=3D a=3Da-sha256; d=3Dbspace.kernel.org; s=3Dc-20240116;
	t=1711749199; cv=3Dne; b=3DUIPWpHs7mLZnVdaPh2sGq8r5F5xF21yFPDxMZ/gm0YeJrT/=
TWfFs/Gh9WnFRa71L3nMBK9Nnv6q1uk/kZxQqMajeyclU7BgxRjaaMsw/eReYwfsEd5M1f1xxGZ=
/6c71chWZmsbAHPSHVYj437pvbvRgRDUvYwenfjdDa7AKfYARC-Message-Signature: i=3D =
a=3Da-sha256; d=3Dbspace.kernel.org;
	s=3Dc-20240116; t=1711749199; c=3Dlaxed/simple;
	bh=3DGv2aECxPpKjlvqInjY5t6BAWJ1JpiWyKfHeeHLgFY=3D=0A=
	h=3DME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3DwUMXak4yyRayehjv1ar0r8EyyPLMwBc3uJ0bwl/C4uF0p7B7G=
/bWOwvNeZYeq6b3W3Vcfr0NdbT29Ffwzm149FPXaVcG2iO3WP/b1G80f4/vw74ISsQwa8epN/zn=
528A3NyNmNXX0nycQdjpBblQ7EyQAtFDKts98b9c+XxikARC-Authentication-Results: i=
=3D smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3Dne) header.from=3Dai=
l.com; spf=3Dss smtp.mailfrom=3Dail.com; dkim=3Dss (2048-bit key) header.d=
=3Dail.com header.i=3Dmail.com header.b=3DFEeVUc; arc=3Dne smtp.client-ip 9=
85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3D=
ne) header.from=3Dail.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=3D=
ail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341e3682c78=
so1377084f8f.0;
        Fri, 29 Mar 2024 14:53:16 -0700 (PDT)
DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=3Dail.com; s 230601; t=1711749195; x=1712353995; darn=3Der.kernel=
org;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DnIkrXKOxIFx664NuP3H7hYth27RezAKOIyptzRih0=3D=0A=
        b=3DFEeVUcXHxQSM1acoLPB3xIZ2HSM6vWTSGbB4Vn2PTFo59S2qm9Wdb/PYmKmlkt7=
q
         bweDNoN2FkFdd+biODVbvTAWaLZraY63rTLXLI3Uj2YXC5gXRj51NmN6ndvk0CmDMb=
0e
         HIob6o5pR32SYbzkWHSn4Jg4Btu/S+g0UAjgMXPRMh1EcOgJV/whXSYiykrw7f/6s7=
7P
         /H5ZCsxnDWl4kNYCj9mzXKbfqQBAv6Lnt80sLG1vRk3gD9HqNaAkNP/seJmggh7Vb0=
eo
         x3i++yNtv1UR3TkN0hCOiKzOfpwFxG/x3+oaCYHUq4IcorpsSpcrx239+6AZFAOrQd=
bA
         WyHA=3D=0A=
X-Google-DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=1E100.net; s 230601; t=1711749195; x=1712353995;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DnIkrXKOxIFx664NuP3H7hYth27RezAKOIyptzRih0=3D=0A=
        b=3DWLVHtPvz9J+QXVTc54yStjx+NkapzU4nW5NsuqPQ5h82t98mF43eq2fZPnUSPha=
T
         MGdf9ycXYZkO41VrOpN62JqHNhZQR/quC5iGCtAX8SbX3Zql03mdeT6pd9hdt04AMw=
NI
         v7s3h6cmiqq3SNt6pWwVBYRqxOm+JPpZT5yDuDLXj7HFAWYEdMSKpeIILWSrLfRqeG=
mF
         0Wu0zy7UE5pH6ZQnPhhEBhM4jmoqIk7Jl9U1SyEn4ioN3y3x18oyrKxSulpIT55d/y=
c8
         64AGB3PNnhGmaMJktfTQg6iokvhAcecEo9Sr4wvXZuzD5l1KTyylDAgGYGp2D5OwKZ=
yP
         iGgw=3D=0A=
X-Forwarded-Encrypted: i=3D AJvYcCUd4xvQHL/oaQCMtCuugnR3C+1mNP+kYnHMed8zOGO=
5hdRvAX21HlPyuCzWSAKy8Bt5pMwgz3toD1E3Xn4ARVBMo22+kQWtIVLj26ICYQSx1B5RhgBvSb=
m3JXQKMiyRL5E4gFZ/VAumoFjE2Vcpg7zLq5/DEIrGAbwW
X-Gm-Message-State: AOJu0YyKhnyWxAp7UfXLi6lEMSL4950T9e1nKDvTnmG9yMcApYpszSg=
u
	6nlrYsSq1udaQLoImKyk+HbI3U4g2GsYOT0pZe1ZoHsOJsdjCd5+EVv1QU8gEWIM6DBowMLNfm=
e
	dpizDXQEt670AhG7mMjM3Cbt2ZFB5CMSUPpAX-Google-Smtp-Source: AGHT+IESQ34cqmbc=
zYM0CtTFQ4n7hfhahLrps7uGUEuczD5xhOvFv09EChC/YJ/FIRR8VtuzAy4gIzrPZKwGa0EMMVQ=
X-Received: by 2002:a5d:6d49:0:b0:341:e4f4:4399 with SMTP id
 k9-20020a5d6d49000000b00341e4f44399mr1687491wri.68.1711749195364; Fri, 29 =
Mar
 2024 14:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329094906.18147-1-ubizjak@gmail.com> <20240329094906.1814=
7-3-ubizjak@gmail.com>
In-Reply-To: <20240329094906.18147-3-ubizjak@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 14:53:03 -0700
Message-ID: <CAADnVQ+6D++hCXaP=3D+Q5wienMzhHo3h9YCvpA_7sHjMt+q6A@mail.gmail=
com>
Subject: Re: [PATCH RESEND bpf 2/2] x86/bpf: Fix IP for relocating call dep=
th accounting
To: Uros Bizjak <ubizjak@gmail.com>
Cc: X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>,=20
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kern=
el.org>,=20
	=3DTF-8?Q?Joan_Bruguera_Mic=C3=B3?=3Doanbrugueram@gmail.com>,=20
	Ingo Molnar <mingo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,=20
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset=3DTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: linux-kernel+bounces-125454-steffen.klassert=3Dcunet.com@vger.=
kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 21:53:44.1103
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: b06851bb-1973-4a64-ca20-08dc=
503ab42f
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dx-dres=
den-01.secunet.de:TOTAL-HUB=3D405|SMR=3D340(SMRDE=3D035|SMRC=3D304(SMRCL=3D=
101|X-SMRCR=3D305))|CAT=3D064(CATOS=3D011
 (CATSM=3D011(CATSM-Malware
 Agent=3D011))|CATRESL=3D024(CATRESLP2R=3D001)|CATORES=3D026
 (CATRS=3D026(CATRS-Index Routing Agent=3D025)));2024-03-29T21:53:44.520Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 14782
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=CAs-essen-02.secunet.de:TOTA=
L-FE=3D012|SMR=3D011(SMRPI=3D008(SMRPI-FrontendProxyAgent=3D008))
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAYsLAAAPAAADH4sIAAAAAAAEAMVYeW8b=
1xF/Sy4PUZKdOH
 GvNMWz00aiJFIkJeuy61q2FUSpZAu2EhQNgsUej+JaexB76EhqoN+o
 f/Qj9I9+j36SzszbJVfUkqKSAFkQ3Me3c89v5s3yv63XHv8isFf4oR
 7wzvYK77Q661yPeGdnfft///zX7iH/OvBD/tz+/p1+yp/EBi2enbi6
 7TRN333KzwM/EjvztafwAVm+u8O/8nWPPw/ik1gEOj+0zf/8mz95B5
 tGsudmBCScxz3BA2EKL3Iuue1FgW/FprB4GPf7fhDxrh/wPwV2vxEI
 R4/sM6R2fBOWvhcCA496AuWYuuPAOvZOeSTcPtAKrodh7IoQtsEzoO
 Ombwluh9wQtnfC+3pk9kCV7TWA3hQrKCf0idISYWR7pIX7Xdoa6uUu
 cYa0rVtWIMIwpUIVTekYKIKP54PuIBbkCVGgpZboRz2um6YfexEaI1
 w7isAY45KInh99wb/aP86aBHxmjH5ZA50gHtIA3Lpn8TiMQfIl0MUh
 2KaDfyegVY+dCAyar73wY8fil37Mw54eCJLp2Bgvn5/LCIG8hWysF7
 JOw8O/oJyn/AgCey1K+0cgRXhZ68mpMN/hZooc+0KEO7y9aZhizejo
 omPxxYcXWxuryEYJhcdfgoOOmAyEHAQ8rKPBr3u9Jt+PFiDvcWBTwk
 PbEhIWBAIw5sgJIa2nmEAXrOaOD1HlBqxcH4JlOkIPUiDBV0KVNXu+
 ZgQ+CADbNbRFI5c1jIGWSTQIts2mDORb+8QTVsPvdhvG5e3rh78RZ7
 Y4BwnIfUPBIv2ueZoQ73snPj/0HQ+8euKCXf6zUxF4wmn6wQnRvjB3
 +K4jLoTN30Z64J/5duSf8Sd6GOWRvtQ9Wzj8uR+currn8ScWbTyz/R
 OInOFfND0REXWj0cAb1wOzt4qJtj3TiS2xqofuqu5EIJvy2+zxf3C+
 zpeXRxmk+gxAmiaX1xgGUL1q9LvaO0gFxKI/oAeG9jYwyKsxvIh/jX
 dtB0rJ7OneibBWeLuD2BEBYW5xuQ47jwDZjpAbjXoCasvudsHPE0CI
 vjqFn8YURCjX9ixxwbum1WmZG5a52d1uNjc2jY0tq2W1N602b7daG+
 vrSZSn0o204PrUJjx7xhvt9ubKJl+WN9gQF0jEASEWHyZFo9LSjNh2
 APhUEuEi0tQfU3QncrlwDDgiYQqhf5rRkEgL7QjSskQ3apHTX4ksKZ
 8vwT3HnKWMPVGgeyE2k7Sow2hREuFSMjcSZji/bij/xXiLLy31+4F/
 spLo6saeKcUs/1Qx6druJ059JpyQjkfwG5Jock3TnXP9MtRsD3q/mD
 5n/If3N8kZwKOzRfCgG2xMUn2LSGfzHIgohkDhvnR0onG3iycl9BaI
 unplckop/RkEZbJKXv6QE4lWJgz53SevaRoTHw87zlprbe1Re6tjbB
 itZlNsd7rdltluW8bW+I4zRuBIrxlDhTBaa68jjORtCCPD9x2YRbQB
 S4IRnInyMPLAMN3+Yl+H9g292wNsd7srPIIBAdrI96I+DBw58eNLmL
 z7OUr3epJjGFhwUiAkD0znf+Zv/3qgHR8eHWhv9/++9/gKy9bQ3W8P
 d/+mHe0ev/hSO9h79d3jQYQ71MflDTZ+mu+jVxaZ2eeucM3+5WImGe
 GpI3XK7p5Ob9eylFal3u87l9pw/FvMS+wKz9Tz8u047f4KDmgvwT+a
 knFkS6fGayLqyXyAc3RPP4N2q3NPnIOfMAHBwIdz/wJ2qgUa0xfCwF
 yAQXrXC89FgATA516Gwuk2m01+KcKmfK0ZTJkwLD4X8HIQZGfTc5rm
 UR+MrZYYvt4ENBPiS4Mbmz0u9NAWQTJvjr2mzEBOGlMwjK+t/HaUM5
 IZk54Om1Fru7tpmdvWurXxqNnsdsTW5sZ295EQYnwzypc30ovyibBQ
 1rfaWCjyNmxFWC9UIEFoUPh+TG2n3etdHMKrnWb3r5Tx66Pj/UOo7T
 fal/sv97Rvdt8sDueFQT0MmaEnwNfyTWWcmJgZPX4OUVg4KG6+9so/
 5/s8hJSc9y7pnRPaM/QvGHDgzeYMXjrkmzvvI1z9OBy8h73tZYAtPK
 ww7HtRyjAsgRFMJ+2GzCNhVy3LOLbCWxd7WyONnwaX7c21lU4LRhdc
 tJNU7+RWjN3li3AK2a67RU2k8RTe4ur1kSIZvVaX5Gvq0moelamH9O
 6sfXV4BG8muHqxe3CwIwEzbiZBFILu8EoeRy8Epkypi/8KLNNfCOG3
 Nkhtfzda2qMXRhBYCd11mK6wSAgRBhq8DDLdtc7jSRIwWhG8iUq2QO
 jQMg1H1K+Wwrjrzd7b49dv9rTj3f0Dioj24tXxIlqBGW481eOLxlOo
 SfNUYvRqdUyy6QGZXr/NyJfgrLG3/+qb3YOpNGF2IH6bNxfT56N1OU
 70e46T/WRg/GKO3tbJm4ZkbEMQvokIez+xRCACZAU16c+vdKyceoCf
 6El94gQ/EtWbfMiJ5ljJ5O70QUzb7mRbx/nfr+dOb1PYP+4yoL5Pcy
 nep522s7W2gScq3NeuHanw+gZHMtS26OuBoG4Dp4bb9/FlLv0zYLCr
 yQwu2W56zAbnsJdr4BJ/aQfCjBrUhLtwvASXoDk24HwIeYjzEpwtnh
 BWmP1vNvnndoxITZOCNI16ezOfbDUPn9Pl+NXXBwf5+Z2ePwG6PJ1f
 n4kAA4ATGdzwb0/wXnihSP4IDUTYh/P23I568u9PyIVph9nTN6Tjl7
 ECKxZZqaiwOfgwtcBUlZUKSrHCWIVVYV1m1YrCPmTVEisDZYnNq6wM
 +1U2A4t5hf2a3aFHs0WmwmaNzQJjIpN2ZtkcaamoyF6GHSm5KHWxIm
 zCTkFhVVzXiFhNudRUoIo0tKOi6lK6RjlyAXIksXxEn2pWiNQlRZUZ
 uFUgrprclN9SMnyDd6kLNWAvsJrUJQ0b6JWMqfZ7JVaZY3dJ4xyEbi
 QIaQTuFFE+xLZSTsJSlarhJyzAsIFHako5J+OssD9kHoFhJVCksHli
 lOm7lppqVWGzbKaQqMgmtFrCsJcHj+DnB6xMZkC4VFjMsnlQeofWg0
 2ICSj9mFVmWK3IPpDRkGkCTxUFxDDQKfeBHuxUlNnsJn4oONJTeFoA
 NCqfEE0BIaHMFAifNeWuXMywj9Q0PqMagTVnE6MEcZtT5suMldmdPJ
 qZnE0F8AlqyAulMFxTIjDsmIVZiVtKxOxg/1Pah5/yG6TfRYDBz3VK
 N6ioEXFZCpkhXEm8STkyMiNZLuC6MjUNfgixM2WlcpcVBki7Zvn8FQ
 JldqzjV+TkGv8hPfogSznezpfE8iJj7X1gJF1zI1lO8JNJcbozNr8p
 wczozk2ZLSAmi+SX9Eh2qhJYMyPdTBYf35SC2nQ5ug/ViiWQiK0UsZ
 ZVCumH2DGS/ZLcpw4wN86FmzT+No0wZSr1qIiNQk1bUy3dvydbAUi4
 5juAecJTcKoyaIxYCAkl5KhCPbAs+5s8JlQ6VorUSeBpGeOWdOAyoD
 dF0aATDvpkSvP5GPvvYzfLuJkuaiPoGm1EGZhdezQWb9coZ8Y+mohA
 iYT54eE4ihb4Tpv5XdBxLz2VIF/pPnLlHROV6WhAS3VwBg3yKA9HeZ
 gCYkt0gAKXzJrcJ/vvSWjVSKwUODx9lF+VGISgTK2+OFyj0t8AAYS+
 Mjh82YLKPpHIr6AZCNQqGvwZ+fsA6enoBEWKolIMH6o4SJTvpgcoYf
 UhqWYfEX5mWAtq4D7VtZqWDIml8QZNBbOXSXKnjG4uq0nVXC+uOcrL
 H1W2dIWeqjiPcglsI1GPC8OST5J71RHYf0gyl0jmZ4Wco38uRQW/Lq
 3AFiVjSXko4yzxNlxLvCnqpwRUefbV5OGCZ5ZMeoUGgzLkpYRZhgYC
 8amoSbcsyxqUY1WNJsAi+30Zx4/WGGt/N86LUmZyI9VViSiZJjmwqf
 8H9miA7vkiAAABAu0CPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGlu
 Zz0idXRmLTE2Ij8+DQo8VGFza1NldD4NCiAgPFZlcnNpb24+MTUuMC
 4wLjA8L1ZlcnNpb24+DQogIDxUYXNrcz4NCiAgICA8VGFzayBTdGFy
 dEluZGV4PSI0OTYiPg0KICAgICAgPFRhc2tTdHJpbmc+Q291bGQgeW
 91IHNoYXJlIHRoZSBsaW5rIHRvIHdoYXQgdGhpcyAncmlwLXJlbGF0
 aXZlJyByZWxvY2F0aW9uIGlzID88L1Rhc2tTdHJpbmc+DQogICAgIC
 A8QXNzaWduZWVzPg0KICAgICAgICA8RW1haWxVc2VyIElkPSJ1Yml6
 amFrQGdtYWlsLmNvbSI+VXJvcyBCaXpqYWs8L0VtYWlsVXNlcj4NCi
 AgICAgIDwvQXNzaWduZWVzPg0KICAgIDwvVGFzaz4NCiAgPC9UYXNr
 cz4NCjwvVGFza1NldD4BCpIFPD94bWwgdmVyc2lvbj0iMS4wIiBlbm
 NvZGluZz0idXRmLTE2Ij8+DQo8RW1haWxTZXQ+DQogIDxWZXJzaW9u
 PjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8RW1haWxzPg0KICAgIDxFbW
 FpbCBTdGFydEluZGV4PSI0NSI+DQogICAgICA8RW1haWxTdHJpbmc+
 dWJpempha0BnbWFpbC5jb208L0VtYWlsU3RyaW5nPg0KICAgIDwvRW
 1haWw+DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjEwMyI+DQogICAg
 ICA8RW1haWxTdHJpbmc+am9hbmJydWd1ZXJhbUBnbWFpbC5jb208L0
 VtYWlsU3RyaW5nPg0KICAgIDwvRW1haWw+DQogICAgPEVtYWlsIFN0
 YXJ0SW5kZXg9IjEwMzMiIFBvc2l0aW9uPSJPdGhlciI+DQogICAgIC
 A8RW1haWxTdHJpbmc+bWluZ29Aa2VybmVsLm9yZzwvRW1haWxTdHJp
 bmc+DQogICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3RhcnRJbmRleD
 0iMTA3OCIgUG9zaXRpb249Ik90aGVyIj4NCiAgICAgIDxFbWFpbFN0
 cmluZz5hc3RAa2VybmVsLm9yZzwvRW1haWxTdHJpbmc+DQogICAgPC
 9FbWFpbD4NCiAgICA8RW1haWwgU3RhcnRJbmRleD0iMTExOCIgUG9z
 aXRpb249Ik90aGVyIj4NCiAgICAgIDxFbWFpbFN0cmluZz5kYW5pZW
 xAaW9nZWFyYm94Lm5ldDwvRW1haWxTdHJpbmc+DQogICAgPC9FbWFp
 bD4NCiAgPC9FbWFpbHM+DQo8L0VtYWlsU2V0PgEM4wY8P3htbCB2ZX
 JzaW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCjxDb250YWN0
 U2V0Pg0KICA8VmVyc2lvbj4xNS4wLjAuMDwvVmVyc2lvbj4NCiAgPE
 NvbnRhY3RzPg0KICAgIDxDb250YWN0IFN0YXJ0SW5kZXg9IjMyIj4N
 CiAgICAgIDxQZXJzb24gU3RhcnRJbmRleD0iMzIiPg0KICAgICAgIC
 A8UGVyc29uU3RyaW5nPlVyb3MgQml6amFrPC9QZXJzb25TdHJpbmc+
 DQogICAgICA8L1BlcnNvbj4NCiAgICAgIDxFbWFpbHM+DQogICAgIC
 AgIDxFbWFpbCBTdGFydEluZGV4PSI0NSI+DQogICAgICAgICAgPEVt
 YWlsU3RyaW5nPnViaXpqYWtAZ21haWwuY29tPC9FbWFpbFN0cmluZz
 4NCiAgICAgICAgPC9FbWFpbD4NCiAgICAgIDwvRW1haWxzPg0KICAg
 ICAgPENvbnRhY3RTdHJpbmc+VXJvcyBCaXpqYWsgJmx0O3ViaXpqYW
 tAZ21haWwuY29tPC9Db250YWN0U3RyaW5nPg0KICAgIDwvQ29udGFj
 dD4NCiAgICA8Q29udGFjdCBTdGFydEluZGV4PSI4MyI+DQogICAgIC
 A8UGVyc29uIFN0YXJ0SW5kZXg9IjgzIj4NCiAgICAgICAgPFBlcnNv
 blN0cmluZz5Kb2FuIEJydWd1ZXJhPC9QZXJzb25TdHJpbmc+DQogIC
 AgICA8L1BlcnNvbj4NCiAgICAgIDxFbWFpbHM+DQogICAgICAgIDxF
 bWFpbCBTdGFydEluZGV4PSIxMDMiPg0KICAgICAgICAgIDxFbWFpbF
 N0cmluZz5qb2FuYnJ1Z3VlcmFtQGdtYWlsLmNvbTwvRW1haWxTdHJp
 bmc+DQogICAgICAgIDwvRW1haWw+DQogICAgICA8L0VtYWlscz4NCi
 AgICAgIDxDb250YWN0U3RyaW5nPkpvYW4gQnJ1Z3VlcmEgTWljw7Mg
 Jmx0O2pvYW5icnVndWVyYW1AZ21haWwuY29tPC9Db250YWN0U3RyaW
 5nPg0KICAgIDwvQ29udGFjdD4NCiAgPC9Db250YWN0cz4NCjwvQ29u
 dGFjdFNldD4BDs8BUmV0cmlldmVyT3BlcmF0b3IsMTAsMTtSZXRyaW
 V2ZXJPcGVyYXRvciwxMSwxO1Bvc3REb2NQYXJzZXJPcGVyYXRvciwx
 MCwwO1Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMSwwO1Bvc3RXb3JkQn
 JlYWtlckRpYWdub3N0aWNPcGVyYXRvciwxMCwyO1Bvc3RXb3JkQnJl
 YWtlckRpYWdub3N0aWNPcGVyYXRvciwxMSwwO1RyYW5zcG9ydFdyaX RlclByb2R1Y2VyLDIwL=
DEy
X-MS-Exchange-Forest-IndexAgent: 1 5079
X-MS-Exchange-Forest-EmailMessageHash: E9B9F661
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, Mar 29, 2024 at 2:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
>
> The recently introduced support for %rip-relative relocations in the
> call thunk template assumes that the code is being patched in-place,
> so the destination of the relocation matches the address of the code.
> This is not true for the call depth accounting emitted by the BPF JIT,
> so the calculated address is wrong and usually causes a page fault.

Could you share the link to what this 'rip-relative' relocation is ?

> Pass the destination IP when the BPF JIT emits call depth accounting.
>
> Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in=
 call thunk template")

Ohh. It's buried inside that patch.
Pls make commit log a bit more clear that that commit 17bce3b2ae2d
broke x86_call_depth_emit_accounting logic.

> Signed-off-by: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  arch/x86/include/asm/alternative.h |  4 ++--
>  arch/x86/kernel/callthunks.c       |  4 ++--
>  arch/x86/net/bpf_jit_comp.c        | 19 ++++++++-----------
>  3 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/al=
ternative.h
> index fcd20c6dc7f9..67b68d0d17d1 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -117,7 +117,7 @@ extern void callthunks_patch_builtin_calls(void);
>  extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
>                                           struct module *mod);
>  extern void *callthunks_translate_call_dest(void *dest);
> -extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
> +extern int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *=
ip);
>  #else
>  static __always_inline void callthunks_patch_builtin_calls(void) {}
>  static __always_inline void
> @@ -128,7 +128,7 @@ static __always_inline void *callthunks_translate_cal=
l_dest(void *dest)
>         return dest;
>  }
>  static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
> -                                                         void *func)
> +                                                         void *func, voi=
d *ip)
>  {
>         return 0;
>  }
> diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
> index 30335182b6b0..e92ff0c11db8 100644
> --- a/arch/x86/kernel/callthunks.c
> +++ b/arch/x86/kernel/callthunks.c
> @@ -314,7 +314,7 @@ static bool is_callthunk(void *addr)
>         return !bcmp(pad, insn_buff, tmpl_size);
>  }
>
> -int x86_call_depth_emit_accounting(u8 **pprog, void *func)
> +int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
>  {
>         unsigned int tmpl_size =3D SKL_TMPL_SIZE;
>         u8 insn_buff[MAX_PATCH_LEN];
> @@ -327,7 +327,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *=
func)
>                 return 0;
>
>         memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
> -       apply_relocation(insn_buff, tmpl_size, *pprog,
> +       apply_relocation(insn_buff, tmpl_size, ip,

Did the logic inside apply_relocation() change to have
a new meaning for 'dest' and 'src'?
Answering to myself... yes. in that commit.
Better commit log would have made the code review so much easier.

>                          skl_call_thunk_template, tmpl_size);
>
>         memcpy(*pprog, insn_buff, tmpl_size);
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 09f7dc9d4d65..f2e8769f5eee 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -481,7 +481,7 @@ static int emit_rsb_call(u8 **pprog, void *func, void=
 *ip)
>  {
>         void *adjusted_ip;
>         OPTIMIZER_HIDE_VAR(func);
> -       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func);
> +       adjusted_ip =3D ip + x86_call_depth_emit_accounting(pprog, func, =
ip);

Now I see why you added extra var in the previous patch.
Should have mentioned it in the commit log.

>         return emit_patch(pprog, func, adjusted_ip, 0xE8);
>  }
>
> @@ -1973,20 +1973,17 @@ st:                     if (is_imm8(insn->off))
>
>                         /* call */
>                 case BPF_JMP | BPF_CALL: {
> -                       int offs;
> +                       u8 *ip =3D image + addrs[i - 1];
>
>                         func =3D (u8 *) __bpf_call_base + imm32;
>                         if (tail_call_reachable) {
>                                 RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stac=
k_depth);
> -                               if (!imm32)
> -                                       return -EINVAL;
> -                               offs =3D 7 + x86_call_depth_emit_accounti=
ng(&prog, func);
> -                       } else {
> -                               if (!imm32)
> -                                       return -EINVAL;
> -                               offs =3D x86_call_depth_emit_accounting(&=
prog, func);
> +                               ip +=3D 7;
>                         }
> -                       if (emit_call(&prog, func, image + addrs[i - 1] +=
 offs))
> +                       if (!imm32)
> +                               return -EINVAL;
> +                       ip +=3D x86_call_depth_emit_accounting(&prog, fun=
c, ip);
> +                       if (emit_call(&prog, func, ip))
>                                 return -EINVAL;
>                         break;
>                 }
> @@ -2836,7 +2833,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>                  * Direct-call fentry stub, as such it needs accounting f=
or the
>                  * __fentry__ call.
>                  */
> -               x86_call_depth_emit_accounting(&prog, NULL);
> +               x86_call_depth_emit_accounting(&prog, NULL, image);

Overall it all makes sense.
Pls respin with more precise commit logs.


