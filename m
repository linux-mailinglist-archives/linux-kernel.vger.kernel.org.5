Return-Path: <linux-kernel+bounces-110510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF30B885FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94839284166
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3E68624C;
	Thu, 21 Mar 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y8Zfzg/t"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396C18AE8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042756; cv=none; b=I0dz1asfcA3GNCYkapGGbNUWiPqLzRJ5sB07ZbdutOEEyMwO6KnTlnHAQq9fNHmF2VAfBBD0fwHBKx6/iZjTd5kMqcuCly4GFMdbRxO6LUhczd4yzL7pnHA/Vb0+tZZFmz4VmcIXrU/7+TDSKsGcqIM4aIDL4K9LTBJRUyie9as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042756; c=relaxed/simple;
	bh=BEIFLZSkkhM2iS/YSn+O4zZiExh+PkHLv3CcpmWP1Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdwE/NchELAYr5ebjOyljFtmTNfd/KFoKyBsv2C/CKEK8qwsbu4XQ92wbOcPD1CWBWFz9ov0c1IjQX7nbtu8YEpN9Bb/VWGtiJrnudJyvy9WIm+tohXMsq+fI88081hNa5lzvSvs8yAIAHTA4qlTcVBMEFXwY5SUhg25pLCfzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Y8Zfzg/t; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6098a20ab22so11518617b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711042754; x=1711647554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWa9Gp1UOA4TQWk/Eto3UyuRiNhA+KGh+CdUx4ew+tQ=;
        b=Y8Zfzg/tYmawB2xqFFc1RztgfkUD/Lpvb9Q1VP3nKEyWEgMtafAadG3Ranmd5HNQbH
         eJte3u4RLD9/AP5yJ2lO/Ce1PVpoxxmbn1dUY54f9GwAfaqwOEpmlXkDeM/2W0G50CKB
         FWjzNiIUTujk4zqXsSlxFku32kJnmBMyGN7k3HdqSUyoUPVISbcKAeM9cFwr/JISuKUt
         jvPDx6YjQtPtFIm4/c1vA+yEO+jgiS9ODiAYf0VtbP+nX51e9MwBUSfy+eX+vaupVKym
         95khyYWamzKOPZHzjJ0v+pqw9vhilNbYNkB4ChfJEIXsncPJzuJjZc320lvZ+G84GW+r
         zGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711042754; x=1711647554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWa9Gp1UOA4TQWk/Eto3UyuRiNhA+KGh+CdUx4ew+tQ=;
        b=oW6avwFg5qrMp0eMPwsftFZ8YBuAJjkzi9C4XOoBjn1Cf9EQAXS6t132A9AV5DJMvN
         GXdJhnhGg5FE5rMr9w869XO4IDgAQvnwwm4FT9TzWMKTnlK5Sv5h4SqhDmXivhhh3+Tl
         rXSsWG+8PUla6w4+7cyJmR0/D5kjHrSglzcYEA/PL4m5ZD7ywoyUDjC2D+iU1buObVo/
         NB/GdnLcEgSevdOTc1SSuv5gCQ5i6OMiLwyksNMREgd3iNJbgqPEG0o+aS+pZofnlsrw
         Ogv+90bjnpNY92pAA/SsYTj8DbA2GvhV26Dx+5cJSyDmeHT7jKI3lMh2lQMmP989gJd/
         fWvw==
X-Forwarded-Encrypted: i=1; AJvYcCVeF3EcnGEZaUoVm6IDWslwcs15dR227tfdIafIwbxR9zN0bJq+OBw9EgkBTiJ2uFNDmI3iarRsXarLdQeMTu+Q7kxz3dIV7BFhJQ+z
X-Gm-Message-State: AOJu0Yw4GaiXugwbSRSpKYEldib4rkrKTaSH7b/JzBKP/zrsAwAIN+0o
	7RDxuBCl3kpnEnYIq7C1ksYJsSBzZe0YkBFNIB9L38HkphiHW1YIFQ4XVgjlRa85IzmV6qM2XzN
	xEMwAX4sVU9QbxRqCdAStm72hBbREEF3XzJgjOQ==
X-Google-Smtp-Source: AGHT+IGLaHoKDEUpZTaFbsTHYjBWd8sycSKG1qiDbSuCEaocfB12w3HAsQSoCaBKqaTj0o1wrETMbkjfOME91imXWE0=
X-Received: by 2002:a25:86cd:0:b0:dcf:f9bd:fe05 with SMTP id
 y13-20020a2586cd000000b00dcff9bdfe05mr18608462ybm.48.1711042754275; Thu, 21
 Mar 2024 10:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306165904.108141-1-puranjay12@gmail.com> <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N> <8734suqsth.fsf@all.your.base.are.belong.to.us>
 <mb61pplvw6grf.fsf@gmail.com> <87zfv0onre.fsf@all.your.base.are.belong.to.us>
 <87il1oedx8.fsf@all.your.base.are.belong.to.us> <CABgGipWPuvwi43v1+60-=0_MN_q_CD0ZGasxHHVWJ37cig5MmA@mail.gmail.com>
 <87msqsotr8.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87msqsotr8.fsf@all.your.base.are.belong.to.us>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 22 Mar 2024 01:39:03 +0800
Message-ID: <CABgGipUayONdvaH0nexBJUai=qT3yqURhinTbDWxORfMDQ_5pw@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
	Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>, 
	Bjorn Topel <bjorn@rivosinc.com>, Song Shuai <suagrfillet@gmail.com>, 
	"Cl'ement L'eger" <cleger@rivosinc.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Robbin Ehn <rehn@rivosinc.com>, Brendan Sweeney <brs@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:48=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> Andy,
>
> Pulling out the A option:
>
> >> > A) Use auipc/jalr, only patch jalr to take us to a common
> >> >    dispatcher/trampoline
> >> >
> >> >  | <func_trace_target_data_8B> # probably on a data cache-line !=3D =
func .text to avoid ping-pong
> >> >  | ...
> >> >  | func:
> >> >  |   ...make sure ra isn't messed up...
> >> >  |   aupic
> >> >  |   nop <=3D> jalr # Text patch point -> common_dispatch
> >> >  |   ACTUAL_FUNC
> >> >  |
> >> >  | common_dispatch:
> >> >  |   load <func_trace_target_data_8B> based on ra
> >> >  |   jalr
> >> >  |   ...
> >> >
> >> > The auipc is never touched, and will be overhead. Also, we need a mv=
 to
> >> > store ra in a scratch register as well -- like Arm. We'll have two i=
nsn
> >> > per-caller overhead for a disabled caller.
> >
> > My patch series takes a similar "in-function dispatch" approach. A
> > difference is that the <func_trace_target_data_8B_per_function> is
> > embedded within each function entry. I'd like to have it moved to a
> > run-time allocated array to reduce total text size.
>
> This is what arm64 has as well. It's a 8B + 1-2 dirt cheap movish like
> instructions (save ra, prepare jump with auipc). I think that's a
> reasonable overhead.
>
> > Another difference is that my series changes the first instruction to
> > "j ACTUAL_FUNC" for the "ftrace disable" case. As long as the
> > architecture guarantees the atomicity of the first instruction, then
> > we are safe. For example, we are safe if the first instruction could
> > only be "mv tmp, ra" or "j ACTUAL_FUNC". And since the loaded address i=
s
> > always valid, we can fix "mv + jalr" down so we don't have to
> > play with the exception handler trick. The guarantee from arch would
> > require ziccif (in RVA22) though, but I think it is the same for us
> > (unless with stop_machine). For ziccif, I would rather call that out
> > during boot than blindly assume.
>
> I'm maybe biased, but I'd prefer the A) over your version with the
> unconditional jump. A) has the overhead of two, I'd say, free
> instructions (again "Meten is Weten!" ;-)).

Yes, I'd also prefer A for less overall patch size. We can also
optimize the overhead with a direct jump if that makes sense. Though,
we need to sort out a way to map functions to corresponding
trampolines. A direct way I could image is CALL_OPS'ish patching
style, if the ftrace destination has to be patched in a per-function
manner. For example:

<index-in-dispatch-list>
func_symbol:
auipc t0, common_dispatch:high <=3D> j actual_func:
jalr t0, common_dispatch:low(t0)

common_dispatch:
load t1, index + dispatch-list
ld t1, 0(t1)
jr t1


>
> > However, one thing I am not very sure is: do we need a destination
> > address in a "per-function" manner? It seems like most of the time the
> > destination address can only be ftrace_call, or ftrace_regs_call. If
> > the number of destination addresses is very few, then we could
> > potentially reduce the size of
> > <func_trace_target_data_8B_per_function>.
>
> Yes, we do need a per-function manner. BPF, e.g., uses
> dynamically/JIT:ed trampolines/targets.
>
>
>
> Bj=C3=B6rn

Cheers,
Andy

