Return-Path: <linux-kernel+bounces-130212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE9389756E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27E51C2601D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0B11514F4;
	Wed,  3 Apr 2024 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="naXJo8yB"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1288718E20
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162584; cv=none; b=AE1peQipCEsA7PSR8HF3w2qHgUR9NL7rPYUv9cUvU3AN/g1Fkn6SWFPeNafKKCu9W7OIJ4ss5yzHxk4lQ3/BIvLvcdGqOlwF5T6jWhGKoW3VLRkyYGLZn6afTuevIzrThiT/Wr1G4feL2U+WHOn4ACNayXS+GxajzrcZhGWvwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162584; c=relaxed/simple;
	bh=Gco9AHEogz8wRiHKn22/x6SZepvKYQXuhwQs8RmLgEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpskvcYOUKKpD7ydo7TXEhCQKQg3pbaSjHVYYPnpIfIJahQQr1qVEeXnfBrOlF2B6Q2Ye2vKN7Bfix8dEG5jwfqP3Ggkz4Kgg7QKGIhQcKkcrs27SEvAcI/5An5OO0DSNzbc1Y7a8vxLKx0m1IVu4sVH/Fv/r01S18snpkoytko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=naXJo8yB; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c8ad87b2acso961739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1712162581; x=1712767381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ldYJZM3ZNQODceb54+safcmgQ5V5QG7ihgBUD2TQZ0=;
        b=naXJo8yBnpQx1lvWqEEZ9NCTDv/sXdIsn0ffwDK6R3PTFdN3s2wF3q51pY3dJ5Lf8r
         RVLeWeiKTR9NJKY+D4HoPW14kMkRCYI6T9Ob7Gx4XFMaR2p8geeDEZWzOaUpQ8PviyYO
         P1f4gxAfZDkTcO1psJIwrdh6ODFlQoJcs0Rzq8Po7iUJx4+aJDGEMiJYsQfvoyYRiilE
         uGb5A6vILz9VZJUONVjb2btLz/oUQKtzm4KVuuh0ZizeE5AAt2m81+5OK5qxjVHDmiU4
         Mtd32CA/U81rJt/savLKI0jnc5zq7TosaH4sOZKiadFBNSTW+6e2xasfGsiX/o1ZYydL
         E3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712162581; x=1712767381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ldYJZM3ZNQODceb54+safcmgQ5V5QG7ihgBUD2TQZ0=;
        b=kqLE/BVKckgTRY3Pbpvuf8kgWfzoIcVwMjSfbfzck+lbphgEt0KNtO+LvQhQDgnSOD
         BpSDRqelOAgxZmV7KYd0UNHRo/0Uo1x6BCxweEfWHkRGEwBCZ8wXKkn3uG8myUxHXtMb
         g3WK0DzJ1nUZoelBcCKXdWiUVlS+81S5rT9vXl4F86US0vRIWnX4xc2Wo3eoUjLbYKAd
         MkXWnCrTLBmAYtjVLQMwvMYyyUnC4XNbOW3ceAcKJNUEErjxecufmmqhqBRkwO9j9fuu
         qNTlVOWA2MKmx6czA7HILmIKaaQy8fHJRQxKKgYvmGJIYtcJ1hj8n1BadwoP41Zkok1E
         cWFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmIyZiZDNrcAFMHSnIUtMa33ld3dHMbzrq+4CJHaBus7o9nPVxACZAbnNTsZEpNxamonEiqrjlyjeEn3f0sq5vTBvPC3BaibHn+VmB
X-Gm-Message-State: AOJu0YxVfgpsJBvN5bUS6bBqZDve4B7PHjPpFrD6sR1aD4uiXpXSUXmn
	pb2wsiK/ZsyaQ+4ez8VDJdciYo9x0RondiG65w1Es4PlI4tlFBTN6VemMibu5OQw2DS0uW/fsoh
	epBxnrCZKFelYs/GPKXsNGFzkJGsviIhFh4K3Ig==
X-Google-Smtp-Source: AGHT+IETZsCmYZR+7MNOTFHFuZFLWE66bnvv0TlpnZS/RG9obXEpluMFpdguyK8UQZTF5zYgpmG2F2lenvvxyMTZHlc=
X-Received: by 2002:a05:6e02:1caf:b0:369:95dc:e4ed with SMTP id
 x15-20020a056e021caf00b0036995dce4edmr136568ill.15.1712162581079; Wed, 03 Apr
 2024 09:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-2-apatel@ventanamicro.com> <CA+V-a8tGucbJ87hsMQDEgcor5BzDmB_WnRsEn6c9F_HzucWLXQ@mail.gmail.com>
 <CAK9=C2VgiRcQjBEPmZjdcMf221omKS8ntdcenSE7G__4xYcCUA@mail.gmail.com> <CA+V-a8ser=hDmst6+XSeOWaEoOd+iY3Ys6bYBWDa5UYPfT+Pug@mail.gmail.com>
In-Reply-To: <CA+V-a8ser=hDmst6+XSeOWaEoOd+iY3Ys6bYBWDa5UYPfT+Pug@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 3 Apr 2024 22:12:49 +0530
Message-ID: <CAAhSdy15r+mx8+HYV5Xe9BYTy0BYk50Nds=qgfBwosEDb63aNw@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 9:19=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> On Wed, Apr 3, 2024 at 3:17=E2=80=AFPM Anup Patel <apatel@ventanamicro.co=
m> wrote:
> >
> > On Wed, Apr 3, 2024 at 2:01=E2=80=AFPM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > >
> > > Hi Anup,
> > >
> > > On Thu, Feb 22, 2024 at 9:41=E2=80=AFAM Anup Patel <apatel@ventanamic=
ro.com> wrote:
> > > >
> > > > The PLIC driver does not require very early initialization so conve=
rt
> > > > it into a platform driver.
> > > >
> > > > After conversion, the PLIC driver is probed after CPUs are brought-=
up
> > > > so setup cpuhp state after context handler of all online CPUs are
> > > > initialized otherwise PLIC driver crashes for platforms with multip=
le
> > > > PLIC instances.
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > ---
> > > >  drivers/irqchip/irq-sifive-plic.c | 101 ++++++++++++++++++--------=
----
> > > >  1 file changed, 61 insertions(+), 40 deletions(-)
> > > >
> > > This patch seems to have broken things on RZ/Five SoC, after revertin=
g
> > > this patch I get to boot it back again on v6.9-rc2. Looks like there
> > > is some probe order issue after switching to platform driver?
> >
> > Yes, this is most likely related to probe ordering based on your DT.
> >
> > Can you share the failing boot log and DT ?
>
> non working case, https://paste.debian.net/1312947/

> after reverting, https://paste.debian.net/1312948/
> (attached is the DTB)

Can you add "console=3DttySC0,115200" to kernel parameters and
share updated boot logs ?

Regards,
Anup

