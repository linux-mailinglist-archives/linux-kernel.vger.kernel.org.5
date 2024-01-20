Return-Path: <linux-kernel+bounces-31702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E788332AF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 05:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65438B22E90
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 04:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4380111E;
	Sat, 20 Jan 2024 04:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="kxJB7nm6"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440920E8
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705723224; cv=none; b=trmTtXDigam5xj1LGNp3Hjdmiu+vuTF084xAO727p2fiHlmFq7VUntjhkQrx8ZwHp4WFRQmO5M4t4u+Xnkotfcz32qoi13NAccFfZzLEXdVhrC/wHT2uXSdiaQfqOCBwm+5jh6nTxuHtDgPp6I2krz1En6aUcs34krnx+3AEqXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705723224; c=relaxed/simple;
	bh=FbwnOXhtsKqXJeeZ2OFxb3t8jHZNshQnkJChhyol8zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvWpaKmiowmjfjuygtu0jVvhSrav+/cXjldmO3D/m4lz8+c6pk5tGOkPKkUpU+647Yz8VHDcLIZZNLaJCIQqj1SxJ/GOImS1s4WjFdUMPYG8gC//oUIfAtoCf6NgnEc59RqCedFmfIko/ZnLX72Yn+NvYAJTmuiZNX/s7i4joQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=kxJB7nm6; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bed9f5d35dso72352239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 20:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1705723222; x=1706328022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xm77cdy8sjLxejMosTN9VvQDmoUNl7t40h/yggndkso=;
        b=kxJB7nm6lordM5Pd46QyW228UFUgNMdp6/mzvNa5t7WUP5B4lh8q1YqlltfxLgs4Ht
         iU4ULQXUnAPrzRsaj6rDbR3V5DxzFKPnwbAWh9OpIjA+Vd887G+tGT3aM54hsdOMmP1z
         Em0/slK5AbYCvdfDs3c6gDO/Ad+u/azNnIw8gBf+H4MY/DypYmx6cAOp+Qx3R9ENzPSm
         UiT09ZA8sAFF9YMYe7lfQ8us3a2YUL5H7e4B4RHfd7xrOsQKRBQyUaAQgIEicIDTe9tw
         yCruli6DGCPMAcCewLnZbaxziALz2tb3d0PF1+doSqLn04RslZx3r1inFGU1WUhOZpD1
         IHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705723222; x=1706328022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xm77cdy8sjLxejMosTN9VvQDmoUNl7t40h/yggndkso=;
        b=kEUnyKQP4IVY58pmwQqbcF2ldcaxQg7yxU0Zg17nu1Qe6UCSOwLRC5xqaLsKCx21xJ
         vgtoOvz2ewMbsZlr1qIM9+fiND4TlySZq6e0kMEPaijhOy8WwZkmFU0iqj0FDqhHyB+B
         AkbryJuyPox0t2QhFMRpuSS9EBqx6sVu/60h3teiykSi2D2hWa8JfMpOIokOzeG3Pgln
         Y1FBHaZ3gDQ97NVgtA4MQ94v+n/DQzZ5UsaSv1G/od5Hb3aSWnJtJKnHCJY0Gc64ng7a
         nkov2TJdARI5LRKWCkx8YXmO9VqAPQsE9MSJQ4qCaDK+olrMHCiXbjJUqnCulpBYo0UY
         JwLQ==
X-Gm-Message-State: AOJu0Yy5CGn9LkijUUsECDYM461lrghKORKcX6crQfl6hys5e2N4CdZL
	x9uM70TW7dJPDkov4WDjJbJrj08lPSWFvmrRAdL/kRpJt5m/TsrKRdi37pQuY2fFc8JTfzjcp30
	swYu1WFVcFwjrg7vRqoeur+n/LDXK/1xJr66W8LSLjEcPdkuP
X-Google-Smtp-Source: AGHT+IGg4ZcMYreFV9xlYVnib9lYgAyXv1Hi5hQ3Ji6o35ET/PG3DLNpo8igmEKscRALY1LTjwXa2naZ6EqS+RMFBqM=
X-Received: by 2002:a05:6602:4f49:b0:7bf:4f95:c10f with SMTP id
 gm9-20020a0566024f4900b007bf4f95c10fmr758470iob.33.1705723221837; Fri, 19 Jan
 2024 20:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK9=C2UV8J52a1pZjsNpFNwpUKn5K3nhS-+bS-3pohDwi3HrfQ@mail.gmail.com>
 <mhng-f5f3ec82-ce6a-4e20-8799-f36fd82d74b6@palmer-ri-x1c9>
In-Reply-To: <mhng-f5f3ec82-ce6a-4e20-8799-f36fd82d74b6@palmer-ri-x1c9>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 20 Jan 2024 09:30:10 +0530
Message-ID: <CAAhSdy1irrxUXTZKVvYB6UmXC6brb4U7xB_k5z2T82qOS=jdug@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] RISC-V SBI debug console extension support
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: apatel@ventanamicro.com, Greg KH <gregkh@linuxfoundation.org>, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	jirislaby@kernel.org, Conor Dooley <conor@kernel.org>, ajones@ventanamicro.com, 
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 3:29=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Fri, 19 Jan 2024 02:09:18 PST (-0800), apatel@ventanamicro.com wrote:
> > On Sat, Jan 13, 2024 at 12:00=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt=
com> wrote:
> >>
> >> On Thu, 11 Jan 2024 06:50:37 PST (-0800), patchwork-bot+linux-riscv@ke=
rnel.org wrote:
> >> > Hello:
> >> >
> >> > This series was applied to riscv/linux.git (for-next)
> >> > by Palmer Dabbelt <palmer@rivosinc.com>:
> >> >
> >> > On Fri, 24 Nov 2023 12:39:00 +0530 you wrote:
> >> >> The SBI v2.0 specification is now frozen. The SBI v2.0 specificatio=
n defines
> >> >> SBI debug console (DBCN) extension which replaces the legacy SBI v0=
1
> >> >> functions sbi_console_putchar() and sbi_console_getchar().
> >> >> (Refer v2.0-rc5 at https://github.com/riscv-non-isa/riscv-sbi-doc/r=
eleases)
> >> >>
> >> >> This series adds support for SBI debug console (DBCN) extension in
> >> >> Linux RISC-V.
> >> >>
> >> >> [...]
> >> >
> >> > Here is the summary with links:
> >> >   - [v5,1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
> >> >     https://git.kernel.org/riscv/c/f503b167b660
> >> >   - [v5,2/5] RISC-V: Add SBI debug console helper routines
> >> >     https://git.kernel.org/riscv/c/f43fabf444ca
> >> >   - [v5,3/5] tty/serial: Add RISC-V SBI debug console based earlycon
> >> >     https://git.kernel.org/riscv/c/c77bf3607a0f
> >> >   - [v5,4/5] tty: Add SBI debug console support to HVC SBI driver
> >> >     https://git.kernel.org/riscv/c/88ead68e764c
> >> >   - [v5,5/5] RISC-V: Enable SBI based earlycon support
> >> >     https://git.kernel.org/riscv/c/50942ad6ddb5
> >> >
> >> > You are awesome, thank you!
> >>
> >> Nathan points out that this has some semantic conflicts with a patch i=
n
> >> Greg's TTY tree: https://git.kernel.org/pub/scm/linux/kernel/git/gregk=
h/tty.git/commit/?id=3Df32fcbedbe9290565e4eac3fd7c4c451d5478787
> >>
> >> So I think the best bet is to wait on Greg's patch to land in Linus'
> >> tree, and then base a v6 of this patch set on that merged patch.  I'm
> >> going to drop this one from for-next.
> >
> > Greg's patch is now available in upstream Linux so I will rebase and
> > send out v6.
>
> Sorry, I forgot about this one and merged it.  I just sent up a fixup:
> https://lore.kernel.org/all/20240119215612.20529-2-palmer@rivosinc.com/

No issues. Apart from a minor comment, your fixup looks good to me.

Thanks,
Anup

> .
>
> >
> > Thanks,
> > Anup
>

