Return-Path: <linux-kernel+bounces-150055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141EF8A99BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E991C20C03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9156B15F404;
	Thu, 18 Apr 2024 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="H4ps8HvI"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F715DBD6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443185; cv=none; b=b9ZKaFyFP95Zuwb0F4wFwuphrvZ+MXvCdkcKHgs5V2c62tRhazhh7PYTAmuDy7F4zkQUHnU0Zc6E7fReW5bJ9fbNQS15+lhIlStbOQxNYTwcX6LUcBho9LUzlDH5YFrtRnt05hA9OxXyReTVbSbntRsGvln4SYFiH6KPHc8b9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443185; c=relaxed/simple;
	bh=8Sqp6mnN9+p83BJR/N5uCLmE2eq/TDMhfHYkKeqrloc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2PqDFmHkhyep/A5Rk4axl6hVWeMWrEjcuEhVO3feCncPHTQQ+Dm4qKtBn6n4nEe3JXVz0uUnKGFtJPvymWzvW8J9kROGI5hMwfjGF+YPV3f6l+4wVGnbxhIEOMfvyGKCDefwjNrnucKfN/EKa0GMsyBTUwhJV2g5dvSHx+bc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=H4ps8HvI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a7e19c43faso616194a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1713443184; x=1714047984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/UmS13xtcMZDnEIpdmRzkPPXx3eO/KfzcsngCuc2tk=;
        b=H4ps8HvISpLZ36Qdg4EwdGgojWSYCz5a8fQFNke6GiY4bMHRxiK8h1P0Kx/gowo43f
         uQGuKJyFkeSzR/1iwfGYXbMGHJ+qBt7WrUV2IVIwGgQeFyzBjPD/k9Nc+QXzB5+d8P7o
         rhlB4NtiIJgM6F7Or8KJprQHDwJrs4mjE9cxjVRhNzRlVL/ap3iORwR+Cf5x0PA1mUZ4
         fRVNwmo1nQkDDdsyOwKAvlkwwpwvUMB3q3Vxgsnn1KWLdkar9Yj6lInzVzVjnQ8VFSwy
         2t5Yd+QBMzB3Fgz9tIMyhaMqoIBFG2uoTVw2P85VKwZDN7XOskND5+46Vvpu5Cr+BZHd
         xWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713443184; x=1714047984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/UmS13xtcMZDnEIpdmRzkPPXx3eO/KfzcsngCuc2tk=;
        b=WT9jRSYmckyvu5XUk57CBWYsqvOCgAg3N04CeK3pDihetemBBc3fAcuXW8sqO5pSo8
         IUcLInYBoLZonkovmZTbzFxvYVPsx1GhNo8IauDVShRmGkemM1i99TTGGwQe7+MrGxOg
         VR/o5eB7DJlPEx0/0EFf+19IfPw7MP0uMx0/2cFQlCBTWBoTWqStyI0m9gKj8O8Be9w0
         KrAtE87cA9AH7SieFPp6r7vEC7Xoai75Gx/H/mL6nOabY5MaB3Urx90kYNhIz6j0rBde
         rxu04S4xD5V0BAkwnNU6AxDeNKBIMj2vB8uz/OwjksEMASM8YGuKcn5zWD9mQLwCpCUw
         OJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUClcKc1NyMXXUPyNM4LCvoS9pA/QLAlMpgTeEKMhJ9JugA7zkTzyVrxrko1nm7A1o3vc+QnHduASvzrc6e/v5f2IOU0nsZoDq9WkTI
X-Gm-Message-State: AOJu0YwPUnrZSa7NualPkWNojYqXUwwJCQmAzkYCqIZE/KGMSpkiSuki
	z/svlXmVGwkb2xgAswXdyz/TFFY1j7CY0asye+Oz8h52KjSaVGM5++aZ6MoAixGDbTOTh8R4ayw
	xGYe/pGMLTYyGxUAZspxPqrwizgtFl+weqgdCrw==
X-Google-Smtp-Source: AGHT+IFDobrs6jP7bQ06gkwfNDSAO5xZlBX+SZvdes90CxOyBYYPmWfXh2FZ/zWFafvNqrUkV1L5UE+4JWMG++qVWl8=
X-Received: by 2002:a17:90a:a106:b0:2a5:2be6:3ff5 with SMTP id
 s6-20020a17090aa10600b002a52be63ff5mr2495695pjp.21.1713443183703; Thu, 18 Apr
 2024 05:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418114942.52770-1-luxu.kernel@bytedance.com>
In-Reply-To: <20240418114942.52770-1-luxu.kernel@bytedance.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Thu, 18 Apr 2024 14:26:12 +0200
Message-ID: <CAEg0e7gDk6SFRh4oF0KsA7xZoMr7RuZXFWL8qD7rmM2cBDLwcg@mail.gmail.com>
Subject: Re: [RFC 0/2] riscv: Idle thread using Zawrs extension
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	andy.chiu@sifive.com, guoren@kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, lihangjing@bytedance.com, 
	dengliang.1214@bytedance.com, xieyongji@bytedance.com, 
	chaiwen.cc@bytedance.com, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 1:50=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> This patch series introduces a new implementation of idle thread using
> Zawrs extension.

This overlaps with the following series:
  https://lore.kernel.org/all/20240315134009.580167-7-ajones@ventanamicro.c=
om/

BR
Christoph

>
> The Zawrs[0] extension introduces two new instructions named WRS.STO and
> WRS.NTO in RISC-V. When software registers a reservation set using LR
> instruction, a subsequent WRS.STO or WRS.NTO instruction will cause the
> hart to stall in a low-power state until a store happens to the
> reservation set or an interrupt becomes pending. The difference between
> these two instructions is that WRS.STO will terminate stall after an
> implementation-defined timeout while WRS.NTO won't.
>
> This patch series implements idle thread using WRS.NTO instruction.
> Besides, we found there is no need to send a real IPI to wake up an idle
> CPU. Instead, we write IPI information to the reservation set of an idle
> CPU to wake it up and let it handle IPI quickly, without going through
> tranditional interrupt handling routine.
>
> [0] https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
>
> Xu Lu (2):
>   riscv: process: Introduce idle thread using Zawrs extension
>   riscv: Use Zawrs to accelerate IPI to idle cpu
>
>  arch/riscv/Kconfig                 |  24 +++++++
>  arch/riscv/include/asm/cpuidle.h   |  11 +---
>  arch/riscv/include/asm/hwcap.h     |   1 +
>  arch/riscv/include/asm/processor.h |  31 +++++++++
>  arch/riscv/include/asm/smp.h       |  14 ++++
>  arch/riscv/kernel/cpu.c            |   5 ++
>  arch/riscv/kernel/cpufeature.c     |   1 +
>  arch/riscv/kernel/process.c        | 102 ++++++++++++++++++++++++++++-
>  arch/riscv/kernel/smp.c            |  39 +++++++----
>  9 files changed, 205 insertions(+), 23 deletions(-)
>
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

