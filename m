Return-Path: <linux-kernel+bounces-150092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE95B8A9A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1CA283C35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55DC15FCF2;
	Thu, 18 Apr 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W0r87b1Z"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353415CD50
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444282; cv=none; b=Ihzree+yzFy5GhJ+6v6Qcrw+KXVfdUWYWegdcexiql1aUmn9NoWAxqeDyTG/vQDtFoYYuaVgyjJMGGfl4kBZHvMsl8GI8zjOCYEmUf9+JTY7b0N7JzV1a+LnTGs4PG69kZu6FIlc9o+dTNEHVFMFMY8MLGDia681lXviYuvqAug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444282; c=relaxed/simple;
	bh=QSLjRysyo0/Hks98oKtI4/m2R9Pa84vsDqodcCUOS5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZoko6HgE3FuxZYYRkoHRAEDURKcP5O/EV2RSoej+lSQ+mxMzcEdRIcThlrNDvcihKzZIdHzR6I0sdziohvPXiuW4YSmJg1pcQWEYK60zSAhIfXi7S5XQzD5nWG7OgeXGfO/meYRp4m9/raLoXfs0V9Sp3PdtLoaoda7ZXjEN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W0r87b1Z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e2b137d666so6950595ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713444279; x=1714049079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5uQ54D2RstiRVHvKawp7XVaoXmllI6/ulgRZL1uiKc=;
        b=W0r87b1Zip+eam20KACJS1WE9ku/x9FufVYrcK60OplLGnmRYohyJGdhFWXtfbXSf0
         1l6/DjEeb4UmI0XiG9MZ4rjn/N4V+4y3AOCpIGFfmE1v5Ddg7NaUUWKvyD6Xw9FgXESn
         AY+d281r7rUs4BfQrPVLJNWvjZG92BMWsMSILQCU34VaNs1GYRl0WwIntK2VY2rsNJJA
         lsIHBvQDOD63JOln1SQtBXv8UuTMUWeWgjNrKhHYpWG5QCERBOc8fBFPCHtkUdd7tbiC
         EAX4dUcfQy8FwSSGKChlj+4cvSUQHpmb7ej5cI/V6wnVhWhPZoCiP4Hk/sXQyDl1rb9w
         cQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444279; x=1714049079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5uQ54D2RstiRVHvKawp7XVaoXmllI6/ulgRZL1uiKc=;
        b=KC3E/qQFsw8jFT6+2+BEigS5TepickiH79PivrxUb4xnEdoWlqTgvqSolxFY34euA+
         Mak6Yh9zyoXuEC9G1BPx+HU+0AlECoNyumi4S22fA6MZVDYLkBN2x52XIl8VEiz3OC9h
         cfhp7dXCHYRqpp4/U9iXXxIDym7TsugkFkjpV7x02Hid9tV/CjtVD0IBPrEt313KWURY
         9HrU/qHBijTQHi7Onug4ZllYNZcFJjigT1YQvoQ5W74uL6xXx7uHA4Ueu7aopuDHLztC
         Xpz0QQQnCCQiR+atbM+9rPggQNMM2nlBqqrHN3LafyCcSENSZYLUGl4eA2sIFzaFLCtM
         U8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCW7uI8JFUII1o1lI8AXKeqLfR2KxoIIhGz3ZSqblYxNpK58UTXmWiuZGerSNeRQbt45Y5/OrDh1FQLQtDpM1Mmth02T9pfPSnkOXOgE
X-Gm-Message-State: AOJu0Yw0gmDs6l/+tn0fIDrRcXA7TEwUfRu3WFbSLNBnwkFpIhxwE967
	PxG6Ynp09JLXQ5iF24Hfm9DDDXDembIz4YM3Kq4ZCe3FH6Kz0vlQ0MZ8bwsAc2HomsshFfedQ9R
	Dv5yQDWzEsKkK+uKsUAEU5eavGOeF+hCqkxk1LQ==
X-Google-Smtp-Source: AGHT+IEVhN1TepgowxkZx3zMUiDk/JogONvQq/CRTPtE1ye8HxlbipGC6rPc0ieZh6EzWl0IuXwLE4FG98AxDucqM8A=
X-Received: by 2002:a17:90a:4a09:b0:2a6:e857:4b2e with SMTP id
 e9-20020a17090a4a0900b002a6e8574b2emr2303349pjh.3.1713444279597; Thu, 18 Apr
 2024 05:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418114942.52770-1-luxu.kernel@bytedance.com> <CAEg0e7gDk6SFRh4oF0KsA7xZoMr7RuZXFWL8qD7rmM2cBDLwcg@mail.gmail.com>
In-Reply-To: <CAEg0e7gDk6SFRh4oF0KsA7xZoMr7RuZXFWL8qD7rmM2cBDLwcg@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Thu, 18 Apr 2024 20:44:28 +0800
Message-ID: <CAPYmKFsQQPCd-34GArHfC-Sv8PCYHgmZxprK3WHKnJquQDoXiQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC 0/2] riscv: Idle thread using Zawrs extension
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	andy.chiu@sifive.com, guoren@kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, lihangjing@bytedance.com, 
	dengliang.1214@bytedance.com, xieyongji@bytedance.com, 
	chaiwen.cc@bytedance.com, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:26=E2=80=AFPM Christoph M=C3=BCllner
<christoph.muellner@vrull.eu> wrote:
>
> On Thu, Apr 18, 2024 at 1:50=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com>=
 wrote:
> >
> > This patch series introduces a new implementation of idle thread using
> > Zawrs extension.
>
> This overlaps with the following series:
>   https://lore.kernel.org/all/20240315134009.580167-7-ajones@ventanamicro=
com/

Hi Christoph.
Thanks for your reply!
Actually our patch series is different from this. The work from your
link focuses on providing support for Zawrs and implementing spinlock
using it, while our work focuses on implementing idle thread using
Zawrs and accelerating IPI to idle cpu. Of course, the ISA ZAWRS
config part can be merged. We will refine our code in the next version
to reduce code conflicts.

>
> BR
> Christoph
>
> >
> > The Zawrs[0] extension introduces two new instructions named WRS.STO an=
d
> > WRS.NTO in RISC-V. When software registers a reservation set using LR
> > instruction, a subsequent WRS.STO or WRS.NTO instruction will cause the
> > hart to stall in a low-power state until a store happens to the
> > reservation set or an interrupt becomes pending. The difference between
> > these two instructions is that WRS.STO will terminate stall after an
> > implementation-defined timeout while WRS.NTO won't.
> >
> > This patch series implements idle thread using WRS.NTO instruction.
> > Besides, we found there is no need to send a real IPI to wake up an idl=
e
> > CPU. Instead, we write IPI information to the reservation set of an idl=
e
> > CPU to wake it up and let it handle IPI quickly, without going through
> > tranditional interrupt handling routine.
> >
> > [0] https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
> >
> > Xu Lu (2):
> >   riscv: process: Introduce idle thread using Zawrs extension
> >   riscv: Use Zawrs to accelerate IPI to idle cpu
> >
> >  arch/riscv/Kconfig                 |  24 +++++++
> >  arch/riscv/include/asm/cpuidle.h   |  11 +---
> >  arch/riscv/include/asm/hwcap.h     |   1 +
> >  arch/riscv/include/asm/processor.h |  31 +++++++++
> >  arch/riscv/include/asm/smp.h       |  14 ++++
> >  arch/riscv/kernel/cpu.c            |   5 ++
> >  arch/riscv/kernel/cpufeature.c     |   1 +
> >  arch/riscv/kernel/process.c        | 102 ++++++++++++++++++++++++++++-
> >  arch/riscv/kernel/smp.c            |  39 +++++++----
> >  9 files changed, 205 insertions(+), 23 deletions(-)
> >
> > --
> > 2.20.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

