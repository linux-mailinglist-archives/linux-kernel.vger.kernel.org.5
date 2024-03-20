Return-Path: <linux-kernel+bounces-108739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3D6880F66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD2AB22370
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D023E3CF6A;
	Wed, 20 Mar 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHssG+tr"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778673C47B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929585; cv=none; b=Ey1A2MpCI4YzMtCByOu38dfszMy/fdMdizHFMaKU9HRPXQF2rrLRmUKs57LvVGG+WrUUdwYb6rsz7onhReNhG1Q3X4Xz4vjgnEtPqXDmOeMn282OFAwj1p6Avu69WDSmQKMAvmgwlbkpCs5wizlwDNKblSlJC6T4xLh0Imj1XPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929585; c=relaxed/simple;
	bh=5m5rEvrKdIFk1HR0PEKHh2vD/F61aTmd6GSGCitb6rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnO8nwN9Br8bX/Ajx3VfoZ9eGpPgzoCGeestZuV+ru5i2HLM7MYKBeZfN6B5bESpPbFrAF0W2FzLrpW44+kZZJ36lxLeqdHGtihr33kdVxFfEe/9nx6CSY/+jFeXz/kd0PRuxyOg+TTzwqAubFKpQzVJd+sk382gXsJ8ukg+W7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHssG+tr; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78a052a3fc5so165168285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710929582; x=1711534382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTp075kwbc6LfAaXvHEolsZ8AZN/qxf8o0cgwtL8pnM=;
        b=VHssG+tr0hhL8Hi86d5fXFcp5U5ZHYz2lQvlpINz1kyKQeO8njS6/UgDmjsoDFjAXl
         2uClfvG4SvXMlpg8ykM/oEfWMT+a53NrWsMVx5D1Ikd0Uj+vhaB4RpRmPtDdG9Zm7OG4
         F+UfmpD4506NJtRTefVyozJbd8aQ8FXDlA1q7zeOQU2oZcLImc2Bdknzz5J+0DlcKIrO
         dQc2torENU//UO5rTfW/iZi1bNsjq/ylo+Ops3rzCh6ZkXz5ji3nWKGc5766aB6Jd1yv
         ZufIoQIxTiDeL27ZMSBLrz0q3ZFswW5jGiAuPEPxE2KRlfLF6gD1nNnURhaw17c4UJlA
         OZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710929582; x=1711534382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTp075kwbc6LfAaXvHEolsZ8AZN/qxf8o0cgwtL8pnM=;
        b=i0zShpj/uttl9H8RXWYNrtGAL1pbc2tX+Ma/il/5dh5EfhXLd6Ak97O3JSm091+DxX
         ToX44aTRRovaM1d3xfJqV+zk26bZaQhjeM8aHtezyscUl0qCrGMmuFj5pY5GH5IqCHoZ
         3Gacq7S1j7y3C8VEBJFwmM2e+Hi002wGYULDOVF7KV+3C8Tv57SPITp7UUH38jOOQU+H
         Andm65Dg4V7ggz/lCzi6gA9DT7awfqk8vSyyw+R24J8Hcj4WkyeX7eBn6CyMRujkCf5U
         wG4ZoWhAGdpR/gwrlsCU3BYwDmfppaso7Aj0ULpo9xImWMjBmhMm1ab4o+NN7z1z7jon
         H6/g==
X-Forwarded-Encrypted: i=1; AJvYcCUkCcdJb14DUA05ecNMw9hST2ysA8Xr+RKTKaAOgEmB6UNgbcUiNnuRsNZx1L+f557/eWr+VVQ6xOYl5x44J0bV3eidHWlI+m2WgeM7
X-Gm-Message-State: AOJu0YwCKuNxU/dpJ0KCR5ql30NE1aEvm02IQxQiRLlOIdS599cCIKRB
	/iJsynH4LvUWugLf6Qzu9XSYLm4dYpez4HEVls//do0frQM4uHl0cD9aeq7eKOXwrE8IFn8Tjgb
	764YxB98rYRdOiDKarnpL21QP2I5Ti9A91dfS
X-Google-Smtp-Source: AGHT+IGLI4oQNvj0ZrWfizm7uSaZYg0DWwsg20e7D8kug0TuDxHAh+4D2eaIqN2wxNhaeqBmJNG5Et8TjvmFmBQCIhI=
X-Received: by 2002:a0c:f38e:0:b0:691:3ccd:62cc with SMTP id
 i14-20020a0cf38e000000b006913ccd62ccmr5727614qvk.6.1710929582254; Wed, 20 Mar
 2024 03:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319163656.2100766-1-glider@google.com> <20240319163656.2100766-3-glider@google.com>
 <CAHk-=wiUf3Eqqz3PttTCBLyDKqwW2sdpeqjL+PuKtip15vDauA@mail.gmail.com>
In-Reply-To: <CAHk-=wiUf3Eqqz3PttTCBLyDKqwW2sdpeqjL+PuKtip15vDauA@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 20 Mar 2024 11:12:23 +0100
Message-ID: <CAG_fn=WRz22XEV_Em+M2FJsNjuBr3mZFT7aA5G8YdT4OTf1p1g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] x86: call instrumentation hooks from copy_mc.c
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 6:58=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 19 Mar 2024 at 09:37, Alexander Potapenko <glider@google.com> wro=
te:
> >
> >         if (copy_mc_fragile_enabled) {
> >                 __uaccess_begin();
> > +               instrument_copy_to_user(dst, src, len);
> >                 ret =3D copy_mc_fragile((__force void *)dst, src, len);
> >                 __uaccess_end();
>
> I'd actually prefer that instrument_copy_to_user() to be *outside* the
> __uaccess_begin.

Good point, this is doable.

>
> In fact, I'm a bit surprised that objtool didn't complain about it in tha=
t form.

This is because a bunch of KMSAN functions is ignored by objtool:
https://elixir.bootlin.com/linux/latest/source/tools/objtool/check.c#L1200

> __uaccess_begin() causes the CPU to accept kernel accesses to user
> mode, and I don't think instrument_copy_to_user() has any business
> actually touching user mode memory.

Ack.

> In fact it might be better to rename the function and change the prototyp=
e to
>
>    instrument_src(src, len);
>
> because you really can't sanely instrument the destination of a user
> copy, but "instrument_src()" might be useful in other situations than
> just user copies.

Right now at least for KMSAN it is important to distinguish between a
usercopy and e.g. a URB submission: both are checked using the same
function, but depending on what is happening the report title is
different.

The destination parameter is also used by KMSAN to print fancier error repo=
rts.
For an infoleak we show the target userspace address together with
other information, e.g.:

  BUG: KMSAN: kernel-infoleak in instrument_copy_to_user
include/linux/instrumented.h:114 [inline]
  ...
  Bytes 34-35 of 36 are uninitialized
  Memory access of size 36 starts at ffff8881152e5680
  Data copied to user address 00007ffc9a4a12a0

It comes in handy when debugging reproducers locally.

Future debugging tools may also need more insight into the semantics
of the instrumented accesses.

