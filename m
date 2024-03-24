Return-Path: <linux-kernel+bounces-115125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8509C888D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244581F2A101
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1F62FE87E;
	Mon, 25 Mar 2024 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmzpY9+l"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67591826E1;
	Sun, 24 Mar 2024 23:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324151; cv=none; b=e2y6V4c11tt/Q1WYynycVBHN84L/TMXF6w6pquca8L3UXgcBwVOb9xOd8I3/KsoxMhmVibSam9v1VyAed+1thzt1wUnbwZJvHBEw7FS/X0GF4Csy6yBG++BoKNmjlfBc3X3BvhOMWLrJfyfYXMUfPMTv3roh6+5rJ50cBmVMK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324151; c=relaxed/simple;
	bh=LFsZTRHTodwxEEOWKO2+M2F3Tn2p02vzi+3C1Wgsjpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+veooiko2pLB/CTedqoG/Je7tRy0Sl5UzxRxSRA/gLfAwIyczxIxhQ60gW1rECbHn3VhVHC5kdlr0jWt8ElkpP47W0bJrfREEUBNkjNk78bnB2jPP+HQOcWmBpEcrx/9YIVYH1Uc44eYAgilZ6Da3CkdUrGIdvgekw9CDqIpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmzpY9+l; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3417a3151c5so2460058f8f.1;
        Sun, 24 Mar 2024 16:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711324147; x=1711928947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rymGosSZY4eZQBtQAJDoTYCW4+6dXqpQDiTevlfvmPE=;
        b=PmzpY9+lzY57zYbpE3RrmQwlk9jXUZ46SX0/iiipIcI2l9pey164dplL5salIwW8vE
         glhl4/D/Z0GUBsWrla8TG/+T6u5bjUODSWvd7ybnkYDKVlrJJp2GsPwGhvdEy61d80uJ
         dQ6Ipr3nJAk9Lmfeeb40stERKtrE4KQFANzrqEV9HXJobteNCwtvdbzk2w34EWzbqxBC
         zgQXd8wJNOhIcsCYKNJXvAyxa0IZdgp+sBQbal2HeGwR6s0tJOJOSQ3Dp1ibTE5OUGDt
         dh3p8MCy6cgYm/kulPR0cc8O4CR+EimZFK0APVxZ1zwUQkjZO/CWuQQwMII3XTjBuMEf
         Ke/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711324147; x=1711928947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rymGosSZY4eZQBtQAJDoTYCW4+6dXqpQDiTevlfvmPE=;
        b=NvpT6xvkvTcsbDc47gkfcnBx7iC0Ne4vuk81NkZAbd2X2xVrG66cPXkWSGrZ/S6FwG
         KwYT2Bgae3QKwJIaKWgwzGJsPQdRAvk3HrOByPv3bkFnCo9K8XZi+CyOSGOS64hT1WH6
         +WjlsR0gzsvSrS36eIBGv14aSb5rcJUFjDdsDdktIqloYByixu/TCWFWvaaPuwOVP6I8
         Y+deI45B+Xy/ZENbljvMloqm4qVGwdiJW1JoW2e0BKfzsquN6YnuN9qQh6eJuRSMk3R6
         CAnDtwYyWLGsXCuRinR7qsOT7UcfQ16Kp37DNUf7pdfJFk7uR2sYo2aE+RQ6vVjBn4ny
         SSqg==
X-Forwarded-Encrypted: i=1; AJvYcCXxb5jBDqJMseBl0+TeJo+Wt56LVTGrkdaFHrtcXEGzigX8DVyRB4HV49y7zR9R8RHoHgWSo1u1eGQWiCa2KtiyXp9MMbciM/uw2gVFFg7BBkH1FRd/XnkzHCHxFGQiWjpsdkJEonHWbdNybHE+udHLC0bqyc4FZvEf
X-Gm-Message-State: AOJu0YzvgkEi6oAzUQRAIyV90Vxrx40Y/eqeXkhlt0j5XubKVQkvuIWa
	8t3ZMxdQsgygfOfe/p+yYCs6+Lo8c4H9hWxsxYmI7+ryDe5XxEzQ7QVL0MnGRy4gxehnnTMS6Ne
	+qqAenFSS0b4xkkF1jBzB5BsgyjE=
X-Google-Smtp-Source: AGHT+IHCKP1lCoGQBWq085iK334TXrHJHlJK+UFurfZZTtsCL6NXswYufrLlFvKp0pWPSn7nZLF6sIhFzpATPW83QKg=
X-Received: by 2002:a5d:51d1:0:b0:33e:6cce:c2ea with SMTP id
 n17-20020a5d51d1000000b0033e6ccec2eamr4432251wrv.51.1711324146870; Sun, 24
 Mar 2024 16:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320105436.4781-1-puranjay12@gmail.com> <CAADnVQJ3o6DsURi=N_KXx+mbW9r7__3LrwYLyYwuoMOsqFHPkw@mail.gmail.com>
 <1686adb401b34adaa3b703ec1a8ffe49@AcuMS.aculab.com> <CAADnVQJzfnK0Mv6HVKZ38VDuAemzbmSMeYscf77YoEy0SgWw+A@mail.gmail.com>
 <c73258ae8425470f90ad31c424cebe3a@AcuMS.aculab.com>
In-Reply-To: <c73258ae8425470f90ad31c424cebe3a@AcuMS.aculab.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Mar 2024 16:48:55 -0700
Message-ID: <CAADnVQ+d3pumHKBA1tTwy-8Vm21xu5Xckqv+4y-27FidBVetvQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: verifier: prevent userspace memory access
To: David Laight <David.Laight@aculab.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 3:30=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Alexei Starovoitov
> > Sent: 24 March 2024 20:43
> >
> > On Sun, Mar 24, 2024 at 1:05=E2=80=AFPM David Laight <David.Laight@acul=
ab.com> wrote:
> > >
> > > From: Alexei Starovoitov
> > > > Sent: 21 March 2024 06:08
> > > >
> > > > On Wed, Mar 20, 2024 at 3:55=E2=80=AFAM Puranjay Mohan <puranjay12@=
gmail.com> wrote:
> > > > >
> > > > > The JITs need to implement bpf_arch_uaddress_limit() to define wh=
ere
> > > > > the userspace addresses end for that architecture or TASK_SIZE is=
 taken
> > > > > as default.
> > > > >
> > > > > The implementation is as follows:
> > > > >
> > > > > REG_AX =3D  SRC_REG
> > > > > if(offset)
> > > > >         REG_AX +=3D offset;
> > > > > REG_AX >>=3D 32;
> > > > > if (REG_AX <=3D (uaddress_limit >> 32))
> > > > >         DST_REG =3D 0;
> > > > > else
> > > > >         DST_REG =3D *(size *)(SRC_REG + offset);
> > > >
> > > > The patch looks good, but it seems to be causing s390 CI failures.
> > >
> > > I'm confused by the need for this check (and, IIRC, some other bpf
> > > code that does kernel copies that can fault - and return an error).
> > >
> > > I though that the entire point of bpf was that is sanitised and
> > > verified everything to limit what the 'program' could do in order
> > > to stop it overwriting (or even reading) kernel structures that
> > > is wasn't supposed to access.
> > >
> > > So it just shouldn't have a address that might be (in any way)
> > > invalid.
> >
> > bpf tracing progs can call bpf_probe_read_kernel() which
> > can read any kernel memory.
> > This is nothing but an inlined version of it.
>
> It was the getsockopt() code were I saw the copy_nocheck() calls.
> Those have to be broken.

No. If you mean csum_partial_copy_nocheck() then they're fine.

> Although the way some of the options use the ptr:len supplied by
> the application you stand no chance of do an in-kernel call
> without a proper buffer descriptor argument (with separate optlen
> and bufferlen fields.)
>
> >
> > > The only possible address verify is access_ok() to ensure that
> > > a uses address really is a user address.
> >
> > access_ok() considerations don't apply.
> > We're not dealing with user memory access.
>
> If you do need a check for 'not a user address' don't you want to just
> require access_ok() fail?
> That would be architecture independent.

No. access_ok() can only be used on the user addr.
access_ok() =3D=3D false on the kernel addr doesn't mean that
it's a kernel addr.

