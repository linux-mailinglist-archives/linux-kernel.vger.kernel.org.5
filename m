Return-Path: <linux-kernel+bounces-104021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC8F87C7FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C4C1C2216E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52156D52E;
	Fri, 15 Mar 2024 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcrFCS1A"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F82D517
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710473601; cv=none; b=Uy4M+/azSNoRCtbMvnH2e0/nf3PlVwgYxokqsM2va+DI6NldSyyBqFEMJ+bXVnN8tCGoCuClef7ycHraXunszh2uhHzcjn75k4XSfJwJpJBx5193oHHlMbPxUpeXTs9AeKOwhzx4Z0xt2IqUZ2MsaHtBdj3VCuZbgcukPPviTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710473601; c=relaxed/simple;
	bh=p3XT5kBMyqXeFKhp5hnPEnsXzgnV5U7qU2ovO/CYlYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=kXKCvJVuMPFU4q0s1abWjsAw+uO3wc385JJLnE5fsfg2RLQ6lTWYk5pioTnJOmht2Av+iIEr/yXPP4TcL4Jhp7ZX2yHAR7mNyZkYG1waQSc1o6H74QvTsxdcGICZp7yqkgnhvgZahmV/BNwgLU5Lh3yFo/jvPcZMaSnbgG51F74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcrFCS1A; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d24a727f78so19570311fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 20:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710473598; x=1711078398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H32FltJCYmRuT1xpAWB9CWf2fiNQNrbCsZf2QEEHNWY=;
        b=gcrFCS1AJ+3PYA2JiK5exOWJ67MOUtXQ8HMyQ7LIeYdX4YBccLYMhO6L+kZ8rE4bea
         9/qZz3koHGkh1y7yMBWlgjh8UBlUP54NUlW2yBn7zc0Cy+6uUobN3MGCfDOzMNFxM9A2
         +NPkhXdY9bf0G3d7Syd5jvAMZR9pnERDsQM/bQmyNZ+s1GYhtNGBNlSO1Qw3TuYrs15N
         MyYlKcZeVnkpDnK2Wjlfrn6cQ2B6tB5dEEZzoLeVgaWuORnY7XX5Mnr2Al77i2ZfxnDK
         u5lj0wrnyNZd4IZCxp212dSo7P1nxx1G6maGhyOAJUeFt2THQusXKFwi7dKFiUL4sS0l
         772w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710473598; x=1711078398;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H32FltJCYmRuT1xpAWB9CWf2fiNQNrbCsZf2QEEHNWY=;
        b=vMukMbRGEwxgnkyTXfN9lunk0BJTl3oN8dDV5dPCHzs/0XrwKvX8drJWKgOtvhbR7p
         3Bu1ZrMRud5tNkmrJk3FxKh2Am6hZqqBMycMG0MfxiHueBwCEM3p7Rqnr4LiKdZFgZl7
         kCMMpF0YQtFPCXCrxtcEFfOhFEQ5XKtcKBDPQU+/BGjH/Pnc69TmRR6wUl1sLYK8wXyb
         945zIDjKuY+yf9PFOfUISOaSzbp9bXpdnKinUokKIIGmKVbWy3wdUbuKLzCgH0EUdSNb
         roetjmu36Bxw/gQ98muJ22qMyStzxPwftZ1SLLb8fmHJ1TQKDrNqetO5WuZv+6znLnll
         ilng==
X-Forwarded-Encrypted: i=1; AJvYcCXYk4t0NfVWJtgufcmD7QvwKDAE3+zPS+3MkKs1aSpBom/iSEsuE9A8cUrBMwm268Q0JVX+KuHX3uBjKW68I5GsZc6+rdkXNmy5QKlW
X-Gm-Message-State: AOJu0YyvcRN9gZzc6b8tp/4Ps6fZmmmwxNJjFy89bldGrkc0xYyyA3pq
	WOlehtYvbK9GPmKO1ILPNPPBGkEeSlsbEy6xmECZ3HtA/0e0CIZHjaydiL/4YJWEQa9Yz0qmFU9
	RMjR8X5Lz9sdywWGhY9TdTBTMlVg=
X-Received: by 2002:a2e:91cd:0:b0:2d4:24cc:b499 with SMTP id
 u13-20020a2e91cd000000b002d424ccb499mt2098030ljg.15.1710473597737; Thu, 14
 Mar 2024 20:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+eeCSPUDpUg76ZO8dszSbAGn+UHjcyv8F1J-CUPVARAzEtW9w@mail.gmail.com>
 <20240314-sublevel-jargon-4234df3fa614@spud>
In-Reply-To: <20240314-sublevel-jargon-4234df3fa614@spud>
From: Eva Kurchatova <nyandarknessgirl@gmail.com>
Date: Fri, 15 Mar 2024 05:33:06 +0200
Message-ID: <CA+eeCSPgxB9VCyB9fmEy4A1rEynNFv34LYA1UDBNT8Po=ag28w@mail.gmail.com>
Subject: Re: Boot hang with SiFive PLIC when routing I2C-HID level-triggered interrupts
Cc: linux-riscv <linux-riscv@lists.infradead.org>, bugs@lists.linux.dev, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 11:46=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> This immediately seemed odd to me, but I have no reason to disbelieve
> you, given you say this was discovered in RVVM which is an emulator and
> you should know whether or not registers are accessed.
> The very first action taken by the ocores i2c controller driver when it
> gets an interrupt though is to read a register:
>
>         u8 stat =3D oc_getreg(i2c, OCI2C_STATUS);
>
> I would expect that this handler would be called, and therefore you'd
> see the register read, had the probe function of that driver run to
> completion. I'd also expect that the interrupt would not even be
> unmasked if that probe function had failed.
> In your case though, you can see that the interrupt is not masked,
> since it is being raised and handled repeatedly by the PLIC driver.
> Has the i2c controller driver probed in the period of boot that you say
> this problem manifests?

There is not a single problem with the ocores I2C driver. I2C-HID device
itself has a separate IRQ line which is level-triggered.
This is to signal the host that there is input available without polling,
since I2C is a master-driven bus with no "data available" notifications.
So in reality the I2C-HID driver should handle the interrupt; Then it
uses the I2C controller to access I2C-HID slave registers (via I2C) to
read the incoming HID input report. I2C controller interrupts are unrelated=
;
it's the link between the HID device and the host and it doesn't seem
to be touched at all inside the I2C-HID IRQ handler (So it's just a pair
of Claim/Complete actions). I2C ocores interrupts are not generated
(and shouldn't) at that point, because no I2C transfer was initiated at all=
.

There is a way to make I2C-HID device edge-triggered, in RVVM
emulation code, but it's not actually spec compliant. It gets rid of the
hang too; However the same Claim/Complete actions without any
handling inside the IRQ handler are observed at least once, which
technically means a lost interrupt (Pressing a key somewhere early in
boot thus doesn't propagate the keypress to the guest until you press
another key later, after which both HID reports are read), so it's not
a way how I'd like to mitigate this in the emulator code.
I, and another developer from Haiku OS team (X512), are almost sure
this is a kernel bug related to level triggered IRQs with PLIC or a
specific incompatibility of PLIC/I2C-HID (Not the ocores I2C controller).

This hang is not reproducible with a Haiku OS guest in any way and
most of the drivers involved seem to be FreeBSD based or written by
X512 (Specifically the PLIC and I2C-HID drivers are). This person also
believes that this Claim/Complete behavior on PLIC side without any
other actions made in between is erroneous kernel behavior too.

I am open to discussions what specifically could be wrong with the VM
since one of my end goals is to just make HID devices work without
issues there; However if a simple 2-line patch (which I'm not entirely
sure of it's implications) that removes return path at line 223 in PLIC
driver resolves the issue (I kept a guest in a 24 hr reboot loop whilst
spamming fake I2C-HID input and no hang was observed), then it does
lead me to belief that it's at least not some blatant emulation issue.

I came here to collect some kernel devs opinions since we are
debugging this for some 2 weeks already. Your initial understanding
that something is wrong with ocores I2C controller is not what I meant,
sorry for lacking in my explanation.

>Are interrupts unmasked by default on RVVM?

By default all PLIC ENABLE registers are set to zero. All PRIO,
THRESHOLD registers are zero on reset. So all PLIC state is
simply zeroed on reset, as can be seen here:
https://github.com/LekKit/RVVM/blob/f81df57a2af77cbae25fd3cc65d07106d9505e2=
3/src/devices/plic.c#L265

> Have you checked that this actually affects any actual hardware?

I might very soon if no one has immediate ideas what is wrong;
Problem is that I don't have hardware that exposes PLIC IRQ lines to
the user. It might be possible to use some FPGA or at least reproduce
in other simulators.

