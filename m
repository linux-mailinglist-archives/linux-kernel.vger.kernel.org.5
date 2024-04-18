Return-Path: <linux-kernel+bounces-150105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFB38A9A73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F33CAB21290
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E4313281C;
	Thu, 18 Apr 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="nZQSkvOO"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1033BBFC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444990; cv=none; b=Gv8OhE+RYXughK+XX2BOaDxCx2Dx5aXpBbDbCSPSPwbhmg8biNl2ryk5disgr0N9wzh09TNwG9ZvO9+tDBYHgmcMPa6ZDOPDQPy6aPLtmP0nwWATbqDNnHTSLX/vjqdoMDyrJO6NUUddGobfGNLPFRMVIrfg2bbtIIf8R5k1Kms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444990; c=relaxed/simple;
	bh=eONc5jQoyQjdrj6WTix0Sacq/kcRKhn2B3XzhwRlZBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMcZOoduc4/qwprwEID2mLNfZRSU2v2lXsy/dj8Kj9eV8QN1gL8iop8FBoaOWoeSAXFwwjFC5fY6Dx47sykkszZOhpIoK7WkL8o3YVY5M8zAK+8Dy9W9xjcMqIhPpB9MnTBnPv3gZj5KwxtCTj3dgdiZB40DEjtsoDERg93fWZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=nZQSkvOO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso807387b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1713444988; x=1714049788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZGKtTtTKQ/7Znmul1mkHwdqYW0+SJZLEn1PqGOozb0=;
        b=nZQSkvOON/fNDfEVlsIfEQ7k2rUSj1Pg4X4ao2ysewQracqw0TWVOlLJ1rNM0RyXz3
         CHNTx7b/nnzSBZ6hH6gd6WMrdlUOd7/MDEnW/1EEsBRsYhKRWv9sJh9SHuohk1aH7rx7
         f9XXKV1xhGsSO7gJeyNEIgNSC/no6EqhBMJfLJzPIluJSAPh+A0i9rzSzzziBDDfouE9
         e1YBTAJxnv0fanBSylN0HCINDZnKwUN2jqdkCSXcBWPn8UcmZJynuYgUyT9uPqWGi4mV
         gR8Yr3uZzxE74jid4+S2E+HvP6AM78yM9+QW/C3k28ypkdcfouCnLnnQsEaBAgHEwVws
         +EVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444988; x=1714049788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZGKtTtTKQ/7Znmul1mkHwdqYW0+SJZLEn1PqGOozb0=;
        b=GnNwB33qiT/kawwDdRmi4oHSj/B88o18UXCl0rkgkwBx0d63P7iZLDedwqS6+qljX4
         OS2kz3ChZQh2xAoIEX1k3Cjk6HpXOoa5s8zTcnmSAqP44SPUFFow1EBCiOJ6RX9iBfm8
         we07W1Xn+n6CKKvh/wqyXvaFND/NrGJ2YH1RaFWWEaNSlDcTxc67S/JnF7OaAxu32xRp
         6xKW4WRYXnbqLlOtXHpodKyXLLHQIWCFEzBW5hxlrchB8nMgTZwFn0f+sgFAf1UAXVI8
         k7U0Ezdbwgr4FvogoyUa17/ILTxYtOc0a94mw+auL+loSFZDqKl5FAtevbijpOIQSHPG
         mbOw==
X-Forwarded-Encrypted: i=1; AJvYcCUi9D7kOl7JtGYTn7wczo+oNsnFref74uGafVYRiTeU4NEu38JzaYQC4D8JKJkscNv+7+8I2e7hZB6HStBorvrAwjZkU9rMfRE+FY1K
X-Gm-Message-State: AOJu0YxK8jD+CGIf0JBgqKk0jClHyOAoE9BcdKaczi3fG8kf2/0tG/XJ
	9VK6lAY+XDOYFDvlmcWqBG7D2a7gv/jUzXYssUo5Js1ZLNgsXDhYmDDE8ELy7LpT0t8kIyvxQkw
	PH6ow2ASPnIhweC3vg8utl8NuSOA2N9x/FYM6SQ==
X-Google-Smtp-Source: AGHT+IG6GxtpQKCYpAgXP5AnlMz+qAxDgM5gYopI2HcArvrJJoes+Kwuta+YB1wkg7pyxgzIbNPpXoDjsP+/f2Sk9Zw=
X-Received: by 2002:a05:6a00:189b:b0:6ed:1c7:8c61 with SMTP id
 x27-20020a056a00189b00b006ed01c78c61mr3623550pfh.12.1713444988686; Thu, 18
 Apr 2024 05:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418114942.52770-1-luxu.kernel@bytedance.com>
 <CAEg0e7gDk6SFRh4oF0KsA7xZoMr7RuZXFWL8qD7rmM2cBDLwcg@mail.gmail.com> <CAPYmKFsQQPCd-34GArHfC-Sv8PCYHgmZxprK3WHKnJquQDoXiQ@mail.gmail.com>
In-Reply-To: <CAPYmKFsQQPCd-34GArHfC-Sv8PCYHgmZxprK3WHKnJquQDoXiQ@mail.gmail.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Thu, 18 Apr 2024 14:56:17 +0200
Message-ID: <CAEg0e7hpjAec=2k+PwJeb0WezmJCFdUD=HbCiGe7+RxKgPHgtg@mail.gmail.com>
Subject: Re: [External] Re: [RFC 0/2] riscv: Idle thread using Zawrs extension
To: Xu Lu <luxu.kernel@bytedance.com>, Andrew Jones <ajones@ventanamicro.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	andy.chiu@sifive.com, guoren@kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, lihangjing@bytedance.com, 
	dengliang.1214@bytedance.com, xieyongji@bytedance.com, 
	chaiwen.cc@bytedance.com, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 2:44=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> On Thu, Apr 18, 2024 at 8:26=E2=80=AFPM Christoph M=C3=BCllner
> <christoph.muellner@vrull.eu> wrote:
> >
> > On Thu, Apr 18, 2024 at 1:50=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.co=
m> wrote:
> > >
> > > This patch series introduces a new implementation of idle thread usin=
g
> > > Zawrs extension.
> >
> > This overlaps with the following series:
> >   https://lore.kernel.org/all/20240315134009.580167-7-ajones@ventanamic=
ro.com/
>
> Hi Christoph.
> Thanks for your reply!
> Actually our patch series is different from this. The work from your
> link focuses on providing support for Zawrs and implementing spinlock
> using it, while our work focuses on implementing idle thread using
> Zawrs and accelerating IPI to idle cpu. Of course, the ISA ZAWRS
> config part can be merged. We will refine our code in the next version
> to reduce code conflicts.

Yes, I've seen that this targets another optimization, but the basic
Zawrs support
would be identical to the other patchset (even if it is not).
I would propose that we work on a basic Zawrs support patchset that introdu=
ces
the Kconfig, DTS and hwprobe parts (a subset of Andrew's patchset).
Once this is merged, all other optimizations can be built upon it
(spinlocks, idle thread, glibc CPU spinning).
If this proposal is fine for the maintainers/reviewers, then Andrew could r=
esend
these basic-support patches.

BR
Christoph


>
> >
> > BR
> > Christoph
> >
> > >
> > > The Zawrs[0] extension introduces two new instructions named WRS.STO =
and
> > > WRS.NTO in RISC-V. When software registers a reservation set using LR
> > > instruction, a subsequent WRS.STO or WRS.NTO instruction will cause t=
he
> > > hart to stall in a low-power state until a store happens to the
> > > reservation set or an interrupt becomes pending. The difference betwe=
en
> > > these two instructions is that WRS.STO will terminate stall after an
> > > implementation-defined timeout while WRS.NTO won't.
> > >
> > > This patch series implements idle thread using WRS.NTO instruction.
> > > Besides, we found there is no need to send a real IPI to wake up an i=
dle
> > > CPU. Instead, we write IPI information to the reservation set of an i=
dle
> > > CPU to wake it up and let it handle IPI quickly, without going throug=
h
> > > tranditional interrupt handling routine.
> > >
> > > [0] https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
> > >
> > > Xu Lu (2):
> > >   riscv: process: Introduce idle thread using Zawrs extension
> > >   riscv: Use Zawrs to accelerate IPI to idle cpu
> > >
> > >  arch/riscv/Kconfig                 |  24 +++++++
> > >  arch/riscv/include/asm/cpuidle.h   |  11 +---
> > >  arch/riscv/include/asm/hwcap.h     |   1 +
> > >  arch/riscv/include/asm/processor.h |  31 +++++++++
> > >  arch/riscv/include/asm/smp.h       |  14 ++++
> > >  arch/riscv/kernel/cpu.c            |   5 ++
> > >  arch/riscv/kernel/cpufeature.c     |   1 +
> > >  arch/riscv/kernel/process.c        | 102 +++++++++++++++++++++++++++=
+-
> > >  arch/riscv/kernel/smp.c            |  39 +++++++----
> > >  9 files changed, 205 insertions(+), 23 deletions(-)
> > >
> > > --
> > > 2.20.1
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv

