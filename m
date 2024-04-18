Return-Path: <linux-kernel+bounces-150135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3098A9AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04472284E51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC3D15FA8A;
	Thu, 18 Apr 2024 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NB5zSt5p"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9C81AA2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445762; cv=none; b=uttKvshtAi5jSOpzXh31EpP1isVORsCezov9VSOARE9LJfEX1W0jdEya8Nsb1OryuV2khzXIbwpZaBvTAIDuQgT57iVUFWsFyPKTs/3Gr0gHZlBUQRMb2nGqydBjwYNNwm04Fvn6sxVARikGoujLxNw7pyhbSxn6e/x1g8xIvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445762; c=relaxed/simple;
	bh=X+U4lYI1ltAh+ScRo/qpfNjCt3veXdLbLYQ4JvMTKk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkB1R2Kr5W6k/zYC00+Ac0hs18F9MmOasPWvSdYJoQM1K4zqHL4uMhZhE8EyD/I0U4sU0u04BaNqUEKyJ8Y+if1Wop3lPBFb2Y0ggFhbPyWivRwpI4vyrPePklTuWW6kbb/jBlyGPQT9Uas5H/aXbcr5Y148ysrxjli980DTlRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NB5zSt5p; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-53fa455cd94so593661a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713445757; x=1714050557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7DOuhy0FvgdVscxhexEi9GDhNcDoFdv6wRWpKftVNE=;
        b=NB5zSt5pR7ul1hzazXCw3c4MEPZ/Bob9vZiZBEcS25L4+jmmMJahqwwBsR/gaTDk+c
         1e6QEo0TVmFxoZDFYM+HUV5OG9N4OZNcobc7AUUGfU5OQFafkx1K+1xvsZsTsvl8QhvX
         i9z5VwuYTpLMZ366KIsw06vL8iSJhWblWiGsZsi26m/RLJUXZAwuNJ2ojK2JJi8tVri5
         hFd7Pxrh42Vmo1uNh0p5JumqV+gp9NgHv9LEUKfM9qN8ADEPmA2s/9B9W5mCFf/ixdgi
         NjYIAlzCe7n85ErY9VPKhvdoND6w0eFFJQsAtc4sGNtFolNimulieFa+uhOE4K8lAGSD
         bP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713445757; x=1714050557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7DOuhy0FvgdVscxhexEi9GDhNcDoFdv6wRWpKftVNE=;
        b=CS/RR8mTw5m+K1imbgqq+vsDLX+mWYliyELjmAixivxFQZpeHdex6sbh/dsCIzdBMI
         O/TkSMJl2Vp78Gs0kLK2HJMxMQ4ggyQ+qPtWtFMECvvUwd8/hZzM6pHdGKicuSSxUV1t
         SbeDXLMggXQddTSNZkVruuFZTQ0fwsFBooj6NSOPLWsH63bCNoEGMVeBdvM8h1FVz0kx
         ed6kCMooa5Mj9SZ/rSteclJsy6sD/Hv0L9oA85QCw4Nah7mafndJT42OgQFsvbUhjQ7D
         YYWqp5Go7uLwwexnA5dxWtPtdF7foCHTgyv6pFNzTg72Uxr5hTFzdAIs7LGa1goTIMvy
         RoCA==
X-Forwarded-Encrypted: i=1; AJvYcCX0nYTeUssxRt/aW9FrcqnZ2Hp6jPOY7Q0BaScJSEnzirR+TiWDxr1rQ+qdfBGUdF9L4cvm8NPDwsmXwU9pJYTITmCqk4ZSqfnmG+PN
X-Gm-Message-State: AOJu0YyiBsmOPMSAnVPOaMrk5kQUb/Iy77yLdrPAGTxPdN4Y7zRyDbAA
	a4E3PErm2XOKgvCeaBZ0sA8szGQ4vlJYl+pqmTJynurvKPhdVofxIWfRZmdTHU5ROHbFGxufZoj
	AaIxS3r0xONGRhNWh8XoYwGy1YqahVhsv0V99OQ==
X-Google-Smtp-Source: AGHT+IGvWMiggmbzELLI8cJWt85uuFMvS8w1Ajbr7CdDz7vIKCaJYhq4lRASe+ONnZ4awnQwlxjff2VW/aPJt29tYlU=
X-Received: by 2002:a17:90b:b14:b0:29d:dd93:5865 with SMTP id
 bf20-20020a17090b0b1400b0029ddd935865mr2258889pjb.46.1713445757422; Thu, 18
 Apr 2024 06:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418114942.52770-1-luxu.kernel@bytedance.com>
 <CAEg0e7gDk6SFRh4oF0KsA7xZoMr7RuZXFWL8qD7rmM2cBDLwcg@mail.gmail.com>
 <CAPYmKFsQQPCd-34GArHfC-Sv8PCYHgmZxprK3WHKnJquQDoXiQ@mail.gmail.com> <CAEg0e7hpjAec=2k+PwJeb0WezmJCFdUD=HbCiGe7+RxKgPHgtg@mail.gmail.com>
In-Reply-To: <CAEg0e7hpjAec=2k+PwJeb0WezmJCFdUD=HbCiGe7+RxKgPHgtg@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Thu, 18 Apr 2024 21:09:06 +0800
Message-ID: <CAPYmKFudqq6Yg=uaVjAubCMM5TBMj8dkC0mXz+6eq3vNizTt7A@mail.gmail.com>
Subject: Re: [External] Re: [RFC 0/2] riscv: Idle thread using Zawrs extension
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: Andrew Jones <ajones@ventanamicro.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, andy.chiu@sifive.com, guoren@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	lihangjing@bytedance.com, dengliang.1214@bytedance.com, 
	xieyongji@bytedance.com, chaiwen.cc@bytedance.com, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:56=E2=80=AFPM Christoph M=C3=BCllner
<christoph.muellner@vrull.eu> wrote:
>
> On Thu, Apr 18, 2024 at 2:44=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com>=
 wrote:
> >
> > On Thu, Apr 18, 2024 at 8:26=E2=80=AFPM Christoph M=C3=BCllner
> > <christoph.muellner@vrull.eu> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 1:50=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.=
com> wrote:
> > > >
> > > > This patch series introduces a new implementation of idle thread us=
ing
> > > > Zawrs extension.
> > >
> > > This overlaps with the following series:
> > >   https://lore.kernel.org/all/20240315134009.580167-7-ajones@ventanam=
icro.com/
> >
> > Hi Christoph.
> > Thanks for your reply!
> > Actually our patch series is different from this. The work from your
> > link focuses on providing support for Zawrs and implementing spinlock
> > using it, while our work focuses on implementing idle thread using
> > Zawrs and accelerating IPI to idle cpu. Of course, the ISA ZAWRS
> > config part can be merged. We will refine our code in the next version
> > to reduce code conflicts.
>
> Yes, I've seen that this targets another optimization, but the basic
> Zawrs support
> would be identical to the other patchset (even if it is not).
> I would propose that we work on a basic Zawrs support patchset that intro=
duces
> the Kconfig, DTS and hwprobe parts (a subset of Andrew's patchset).
> Once this is merged, all other optimizations can be built upon it
> (spinlocks, idle thread, glibc CPU spinning).
> If this proposal is fine for the maintainers/reviewers, then Andrew could=
 resend
> these basic-support patches.
>
> BR
> Christoph

Roger that! This does make more sense. We will rebase our code on
Andrew's basic support patches in the next version.

Regards,
Xu Lu

>
>
> >
> > >
> > > BR
> > > Christoph
> > >
> > > >
> > > > The Zawrs[0] extension introduces two new instructions named WRS.ST=
O and
> > > > WRS.NTO in RISC-V. When software registers a reservation set using =
LR
> > > > instruction, a subsequent WRS.STO or WRS.NTO instruction will cause=
 the
> > > > hart to stall in a low-power state until a store happens to the
> > > > reservation set or an interrupt becomes pending. The difference bet=
ween
> > > > these two instructions is that WRS.STO will terminate stall after a=
n
> > > > implementation-defined timeout while WRS.NTO won't.
> > > >
> > > > This patch series implements idle thread using WRS.NTO instruction.
> > > > Besides, we found there is no need to send a real IPI to wake up an=
 idle
> > > > CPU. Instead, we write IPI information to the reservation set of an=
 idle
> > > > CPU to wake it up and let it handle IPI quickly, without going thro=
ugh
> > > > tranditional interrupt handling routine.
> > > >
> > > > [0] https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
> > > >
> > > > Xu Lu (2):
> > > >   riscv: process: Introduce idle thread using Zawrs extension
> > > >   riscv: Use Zawrs to accelerate IPI to idle cpu
> > > >
> > > >  arch/riscv/Kconfig                 |  24 +++++++
> > > >  arch/riscv/include/asm/cpuidle.h   |  11 +---
> > > >  arch/riscv/include/asm/hwcap.h     |   1 +
> > > >  arch/riscv/include/asm/processor.h |  31 +++++++++
> > > >  arch/riscv/include/asm/smp.h       |  14 ++++
> > > >  arch/riscv/kernel/cpu.c            |   5 ++
> > > >  arch/riscv/kernel/cpufeature.c     |   1 +
> > > >  arch/riscv/kernel/process.c        | 102 +++++++++++++++++++++++++=
+++-
> > > >  arch/riscv/kernel/smp.c            |  39 +++++++----
> > > >  9 files changed, 205 insertions(+), 23 deletions(-)
> > > >
> > > > --
> > > > 2.20.1
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv

