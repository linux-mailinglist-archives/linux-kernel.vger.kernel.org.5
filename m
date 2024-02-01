Return-Path: <linux-kernel+bounces-48517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A4845D32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EBB1F239E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E665A4D0;
	Thu,  1 Feb 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0d2InUYm"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BD7E119
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804634; cv=none; b=aVPERGHL+C6A/Lr213WHqeNEQvxEzQIdo2IIzM2mgIJs3VPdH+y03m7tJKQlPw20lpt3+FhtVgD7VawaVc9VsmLCse8hNdoKLPtQlJtGIIftb5PdZT5dh+/4T41A2zwt+hEfMrr6Xyr//5xpzvEwYJ1ALlWK9hTQwp7cEhF/Bwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804634; c=relaxed/simple;
	bh=r6HuU+nMuZPxOqccbs5Of8zd1RTaXx42PjFB7lXu1/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1Bz0EhOQDtoNuMkDys3PZfIRB084iPkJfpuzR1NRYl79tWpAGoU48/LsexUcoN005JQd8z6ogogh7BT+vSc+5q6BBXyeJmN+6+vgf5eBT1+ByLAy5PJUPwrPooHuTVsaDhdnbA9jcl5Ft2dTgwl4WFgSfWFmDXjX0BgXq46MbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0d2InUYm; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4676a37e2c4so482064137.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 08:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706804632; x=1707409432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6HuU+nMuZPxOqccbs5Of8zd1RTaXx42PjFB7lXu1/I=;
        b=0d2InUYmDxOyOfqid/WGR/Xpy61ElDA17p4pnCN5yHWmxkWydBhVbwxaKqsN9djm3R
         nHod7/b8GpwkLaFYyK0qccRxCiLxcaj4j6N9IHNglpHlQazf9C5CFcZxtGiFiWlSEJWd
         umucrCBbVUPRZ9WuQTemTYSOQ7ewjAvR0FmmoElQmLPna8zRji28lA2AZK/kXNN0Krgp
         DJMRdwAM5E9ZBoEko8WYwcyq5zlC7fQjcZPaNsd9EL7VlrVo3djCCXkc0WEmcX3GIWTo
         Xl4RZXv1eCTR+4vpZ36r93z6Ma+IK22eIoFZNgZcWDC2odDjbbqmweWNn0IQTALblEYt
         QT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804632; x=1707409432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6HuU+nMuZPxOqccbs5Of8zd1RTaXx42PjFB7lXu1/I=;
        b=H5ZC1EHOnbbbv1ILJissoVckiMrREX9ucAtcngBFbI9d30HniAPzMgJKMtVeYaDpYU
         EuzH3pxzoyurRYC7MEyRXEN0b3K26BBcGMsYRF0SiqPw5n1lQ/24Gu4ngoW0DiTncok2
         EztGSbViFrJ7sg1AHOjp7dYRM6Cw03yc1emoA7OxKIXXaDXVFffST1A236pAsSreUuMR
         lXfGH9BVBXQwKufpEDMBws9SQ5IO6YIj3+xnnoIgHh/rBQEqH28fdeAvwJXMdSxmTwly
         Yglz1RQgXghSZa4xH4wkTxHEcCm+6a92f0Y7Vj07lt8/lnQuE8EEGaq+xbt4LbzobDoa
         J9tA==
X-Gm-Message-State: AOJu0Yw8BF+9/+8E61sBs7kyO0SPAIMFAr1S85ZJ+ZKlBDvJiVuR1/CH
	Ig5ZIVvHTXGyLQe7mS5E7AsFZDE0UsfxWGP+PvZgEgwbMV4ewuj+qycm3i1alsyttqgQ16xhI7I
	+CMO6awwYajLwu+u+k7O9wX6kvkEx3aA3hUIZ
X-Google-Smtp-Source: AGHT+IHZLNoTy9E7TayTesZ1prle6Vi1TuRcJ9benAaEiMnkjqKwtoceCYTAuIKDKKFkE7hFgE89TvCQ3nXaE5/5lg4=
X-Received: by 2002:a67:fad9:0:b0:467:9f70:e137 with SMTP id
 g25-20020a67fad9000000b004679f70e137mr5119440vsq.34.1706804632143; Thu, 01
 Feb 2024 08:23:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-22-ardb+git@google.com> <20240131073156.GHZbn3bILaWLEluzp-@fat_crate.local>
In-Reply-To: <20240131073156.GHZbn3bILaWLEluzp-@fat_crate.local>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Thu, 1 Feb 2024 08:23:41 -0800
Message-ID: <CAGdbjmJi_b0jt4-noJEdVFvQ80BOBULmHic8D-uGsNn4m9rTyg@mail.gmail.com>
Subject: Re: [PATCH v3 01/19] efi/libstub: Add generic support for parsing mem_encrypt=
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, Conrad Grobler <grobler@google.com>, 
	Andri Saar <andrisaar@google.com>, Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 11:32=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Mon, Jan 29, 2024 at 07:05:04PM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Parse the mem_encrypt=3D command line parameter from the EFI stub if
> > CONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy, so that it can be passed to the early
> > boot code by the arch code in the stub.
>
> I guess all systems which do memory encryption are EFI systems anyway so
> we should not worry about the old ones...

There is at least one non-EFI firmware supporting memory encryption:
Oak stage0 firmware [0]. However, I think Ard's patch seems simple
enough to adopt in non-EFI firmware(s) if needed. I merely wanted to
point out the existence of non-EFI memory encryption systems for
potential future cases (ex: reviewing more complex patches at the
firmware interface).

[0] https://github.com/project-oak/oak/tree/main/stage0_bin

