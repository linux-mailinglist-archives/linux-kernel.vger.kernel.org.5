Return-Path: <linux-kernel+bounces-59839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D758584FC60
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33D9B25951
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B184482881;
	Fri,  9 Feb 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUO0zJqb"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926A57339
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504960; cv=none; b=cICgf4IC8lzxVbrVYd1ws5lAs7oim+rFWnpbvLF4XQBjxF1WpZBnMjK95uCk8xIFW1TY7ETEhdfgSqB8lS2UuSkJrqk4JrF3Ve6RoNLqpgsBZOkX1d62/4AaqNJ4xauujVsjCZoSCT09GbKAnWMv6KsvnZoQzQ13G5m9d70qaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504960; c=relaxed/simple;
	bh=vr5rJvFiGAhBJJXv+RHazOWDEKyoNkrSI04U1hYyfH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/iALE/LWKKLDUBEEwVVNx474soFPoLHavL5swyAqFP3SO6jkP0MzM7O8FEzsvg/qRl4npk3kcu/U4ReYbHLxwtKF0GcuH7zyHd+Z+r/AU+SW5n2qBIoXHJ7CSNHwnBgHY3+r/ph0n/7h6STlkmfKpuigVJXQvISMXMvgTcT3OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUO0zJqb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4103be6e938so11174255e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 10:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707504957; x=1708109757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIO9eqEBuzeJvHgboL0yq147O60ChCDjxtRjTyvfnAk=;
        b=aUO0zJqbaS/flcjJdvFSrL4koTHYIOTHTGdr6dvzPlEK67YE8FVFe43Xpv1vGfOMX3
         YjuLo41K6EBieE9gAStci5kb/DfhqGeTCEuU2Gxe1eeOaaMB+qyIpRODBR5RO4/8L6qW
         1Q7NeUZgAZmAjWmUyzzR8d0DEPQuJx0Wz/LtFfHR9aFJV2v4hRLTiP7cpbxz0Ci0tCzw
         9LEtpRAOcRQI9MTwLZWwuScjJIhpY4y5XJxutYRtz+2KYdJyX6w2QLiw0bcSDa7kCxti
         2GfNqoCYtIX5U3MxvXd2mCh9IQE+AIYHO4/DECeyCEPW0YPomLGiXP4pcO1GSM+5LjDf
         pD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707504957; x=1708109757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIO9eqEBuzeJvHgboL0yq147O60ChCDjxtRjTyvfnAk=;
        b=NT/ufSLoGxrEwXL5qEPgoPgA2r4Kh/mFZgzjy6e9V5rtUL6XIKwqJdlkI6c786no3D
         /FIXuNR5qkoDWAzXC3wkxdoDZ526qFyzeMbmIEyJoouY+UlIP88gJRM8ySYQkP2DbRP4
         Dd4FHD4aXgD0ScNfM0nUkLRQ92GU9I/RaiZvXiZtHkXFHkmDC2vFSTYm8o+H8EKVZewz
         U5VuaG6hjhB5mcQYFsLhevBUtsWkdMYmA4ZmA8U5BJduM+B5X3seFUyHaPUNjuul54Xj
         X/hrr2QJhEmNWDkB5tDt1niuFjHZgmNNr0hkYGRAwex1r6BzhxTY1zfCVzPX+nwMGD/n
         MCMA==
X-Forwarded-Encrypted: i=1; AJvYcCUH3CdD8/FpaoszMjyYiQ5RnSnhhWSFMvLNtPyxdUs3UCT44epqJpazOmBVIgi8WoJHJ93Q1+RSdWtNVxP5zCSEe6Bpr7BlFn5VJjX+
X-Gm-Message-State: AOJu0YzB7H/Am8I/b2f1iqjz9V8E/nthYWC+ErNFOr5WODy97n+it+2u
	MxuvRl/Ldcni7y3ObVMtmFt+fhWV9i+v/pQlNr9U0cjyD1Ju3sUtKgkTF+MuY9UlypRcaJwdMj/
	g8oRiO+0o8BKP/YzrhLlmP7TlgDtyfCK88OVO
X-Google-Smtp-Source: AGHT+IFhtTJvlp6btzPTOCweFKlqDV+HT5LMMNeDCjfk83IbytbntRjDykhFwI+vkGM7a47x/psO7pGbV+9DOlJM2G4=
X-Received: by 2002:adf:f6c7:0:b0:33b:183f:b194 with SMTP id
 y7-20020adff6c7000000b0033b183fb194mr1576381wrp.38.1707504957230; Fri, 09 Feb
 2024 10:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208220604.140859-1-seanjc@google.com> <CAKwvOdk_obRUkD6WQHhS9uoFVe3HrgqH5h+FpqsNNgmj4cmvCQ@mail.gmail.com>
 <DM6PR02MB40587AD6ABBF1814E9CCFA7CB84B2@DM6PR02MB4058.namprd02.prod.outlook.com>
 <CAHk-=wi3p5C1n03UYoQhgVDJbh_0ogCpwbgVGnOdGn6RJ6hnKA@mail.gmail.com> <ZcZyWrawr1NUCiQZ@google.com>
In-Reply-To: <ZcZyWrawr1NUCiQZ@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 9 Feb 2024 10:55:42 -0800
Message-ID: <CAKwvOdmKaYYxf7vjvPf2vbn-Ly+4=JZ_zf+OcjYOkWCkgyU_kA@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: Explicitly disable asm goto w/ outputs on gcc-11
 (and earlier)
To: Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 10:43=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Feb 09, 2024, Linus Torvalds wrote:
> > On Fri, 9 Feb 2024 at 09:14, Andrew Pinski (QUIC)
> > <quic_apinski@quicinc.com> wrote:
> > >
> > > So the exact versions of GCC where this is/was fixed are:
> > > 12.4.0 (not released yet)
> > > 13.2.0
> > > 14.1.0 (not released yet)
> >
> > Looking at the patch that the bugzilla says is the fix, it *looks*
> > like it's just the "mark volatile" that is missing.
> >
> > But Sean says that  even if we mark "asm goto" as volatile manually,
> > it still fails.
> >
> > So there seems to be something else going on in addition to just the vo=
latile.
>
> Aha!  Yeah, there's a second bug that set things up so that the "not impl=
icitly
> volatile" bug could rear its head.  (And now I feel less bad for not susp=
ecting
> the compiler sooner, because it didn't occur to me that gcc could possibl=
y think
> the asm blob had no used outputs).
>
> With "volatile" forced, gcc generates code for the asm blob, but doesn't =
actually
> consume the output of the VMREAD.  As a result, the optimization pass see=
s the
> unused output and throws it away because the blob isn't treated as volati=
le.
>
>    vmread %rax,%rax       <=3D output register is unused
>    jbe    0xffffffff8109994a <sync_vmcs02_to_vmcs12+1898>
>    xor    %r12d,%r12d     <=3D one of the "return 0" statements
>    mov    %r12,0xf0(%rbx) <=3D store the output
>
> > Side note: the reason we have that "asm_volatile_goto()" define in the
> > kernel is that we *used* to have a _different_ workaround for a gcc
> > bug in this area:
> >
> >  /*
> >   * GCC 'asm goto' miscompiles certain code sequences:
> >   *
> >   *   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D58670
> >   *
> >   * Work it around via a compiler barrier quirk suggested by Jakub Jeli=
nek.
> >   *
> >   * (asm goto is automatically volatile - the naming reflects this.)
> >   */
> >  #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0=
)
> >
> > and looking at that (old) bugzilla there seems to be a lot of "seems
> > to be fixed", but it's not entirely clear.
> >
> > We've removed that workaround in commit 43c249ea0b1e ("compiler-gcc.h:

Interesting, I thought I had proposed removing that earlier and Linus
had yelled about doing so.
https://lore.kernel.org/lkml/20180907222109.163802-1-ndesaulniers@google.co=
m/
seems like in ~2018 I was trying to, but can't seem to find the thread
where Linus pushed back.

> > remove ancient workaround for gcc PR 58670"), I'm wondering if maybe
> > that removal was a bit optimistic.
>
> FWIW, reverting that does restore correct behavior on gcc-11.

And also pessimizes all asm gotos (for gcc) including ones that don't
contain output as described in 43c249ea0b1e.  The version checks would
at least not pessimize those.

>
> Note, this is 100% reproducible across multiple systems, though AFAICT it=
's
> somewhat dependent on the .config.  Holler if anyone wants the .config.



--=20
Thanks,
~Nick Desaulniers

