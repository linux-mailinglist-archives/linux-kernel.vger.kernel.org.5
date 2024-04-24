Return-Path: <linux-kernel+bounces-156859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2630E8B0957
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5D91C23D12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FE215CD55;
	Wed, 24 Apr 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eRkBEobK"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B015B975
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961453; cv=none; b=EbOZPvOfzYG0CJ8HrFsQhNygr9+KK5iJ5qXq3IfMWLfzZolQmgxkPsQCNwjHm728w85VhG2XzChbEMi5BTLvP9KSKAR78bkoR/19SoHhFy9mEl542PvhEkQoBylPY8fIVY8UQTHUPRMah8a4D5G1YE5rp/BHFYknBKxgF5wvz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961453; c=relaxed/simple;
	bh=HlazUzSr4amxm9DuYzU249o+uWW/IwDWB+kYCy7wJbE=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExZZyWIhuFka/swVlFkGEweYGoNv6UP9NWTnt+7qJ0UkLK8ixS1oj0bIBHYAYaaJQZk2FgV6AFO0OhPNgSiOrhin34bJQjNdd5O41zPWjz/h2enQrkYqvoKifgvVdmqKHwww3Um/F3mVitDmaJd5/T/PS6dnXS7wFxMpLv+TcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eRkBEobK; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D87FF3FE53
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713961448;
	bh=kP7Qj5CwpDA66Gz8AB4puXE6Tb6dE/jjDd5MukJFIok=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=eRkBEobK9qMo6CKt2t93IF8CICQCK3r85nlfHuLIw1WMPYuijWikAa+m/OAAHfnM4
	 Ofg7dN68CHP0EJi7lmEgH3mCSIUhRXKqzTkMVzmY7pALBXvW6BlM4lVYoC66G9/lx1
	 hE6B4IiV62v7BxKLLvEo3cGZbJS8bxgE/08ZybWoDp+4Q9dUKlALWRhdqa8MQRgyWl
	 fwNgGNVfZDseNb17oxOQKlhocYa0AQd+84GATE41SWbl3mZwFdz4niXRFabSF07cdc
	 rOEki7cqiNMDprQnwbigITKUnWwM2twgE844L/QB2cOxZuuH7pchL4/jMlNDSdeA3M
	 TFK0JjeCYROeg==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-434e823ba24so79343171cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961447; x=1714566247;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kP7Qj5CwpDA66Gz8AB4puXE6Tb6dE/jjDd5MukJFIok=;
        b=ssbliztB09KPpocDXQg+KkfPmZb+9EmeqRoODzhthSSh8cnFoh2nhnQqfH4mnrQS8j
         yJDhn0Xx0X0zLJD0bW7QydDaWZ0/Iqjkq0sVwJaWv/zLehSX0avArav5qk0OhiJe7abW
         V2uy6p3q9dN1eB+qiFs//NaKa8j/NVvrtlTkS95zWeZzunKINZaRvOowtZkAc6zVpvG5
         8IqBwkcesLRRzZefvxHsFAzVYqC2ZQ4hIsgYjo3c4J/cn0FnzF9ImY60Nsbah9OsEQEL
         QdROy0iNxukwyLI3upDSCkzaMJdVV3QQg8X9PxbQIV9qdvGGbaoyh3Jp1xROHh4JbC+r
         RzPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWic4bxZGbeWEviCnaLub+2XXaB2TVhVOfHRsFoB6fMFHz68kgMxZ5BxWjAz03+6WO9jd6haX24RfkXf+jACROR6SoBUQmn5WUwvKN/
X-Gm-Message-State: AOJu0Yzz2QH87wdkhBLNoA9hAZfi667MBs2L9IRiOJh3e0MjbMA+dvFe
	P84Az9Rd5ZvirP9jc3ZzeJyas+5EPbL9ZO7FktNFYPlqPqf/5Piy/HJ+4v17vef6yWwL3HWyOAa
	gz+CeDsQCNn9Wv3Qr2dAp/2Zu2MPlwk/N8VC+Ph50CVPmk3IKdfC5y1doIZPUlB+ZXFPWyqEtCZ
	v8uE3i4V8WlsPlD8LN8FmAYW9CjZagJfbvaH4fU8IiNtFwUFWrkXxo
X-Received: by 2002:a05:622a:c3:b0:439:ff39:eda5 with SMTP id p3-20020a05622a00c300b00439ff39eda5mr2850161qtw.46.1713961446652;
        Wed, 24 Apr 2024 05:24:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE9LSddkv0aBFD9sD7nfjwgf9rCGcKJnWtVWsbq4dHYSmThicP0HSvR1y+4PaXDdyrxJ35vOBfb5XosrnnuVc=
X-Received: by 2002:a05:622a:c3:b0:439:ff39:eda5 with SMTP id
 p3-20020a05622a00c300b00439ff39eda5mr2850143qtw.46.1713961446367; Wed, 24 Apr
 2024 05:24:06 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Apr 2024 12:24:05 +0000
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240424-cost-monkhood-14ab2a933bb5@spud>
References: <20240410142347.964-1-jszhang@kernel.org> <20240410142347.964-3-jszhang@kernel.org>
 <20240424-cost-monkhood-14ab2a933bb5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 24 Apr 2024 12:24:05 +0000
Message-ID: <CAJM55Z9E7GnacYhQHcYmHKur6kD155d6C-xkORaEfxS9JxLFxg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] clocksource/drivers/timer-clint: Add T-Head C9xx clint
To: Conor Dooley <conor@kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Conor Dooley wrote:
> On Wed, Apr 10, 2024 at 10:23:47PM +0800, Jisheng Zhang wrote:
> > To use the T-HEAD C9xx clint in RISCV-M NOMMU env, we need to take
> > care two points:
> >
> > 1.The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
> > implement such support.
> >
> > 2. As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer:
> > add a quirk for lacking mtime register") of opensbi:
> >
> > "T-Head developers surely have a different understanding of time CSR and
> > CLINT's mtime register with SiFive ones, that they did not implement
> > the mtime register at all -- as shown in openC906 source code, their
> > time CSR value is just exposed at the top of their processor IP block
> > and expects an external continous counter, which makes it not
> > overrideable, and thus mtime register is not implemented, even not for
> > reading. However, if CLINTEE is not enabled in T-Head's MXSTATUS
> > extended CSR, these systems still rely on the mtimecmp registers to
> > generate timer interrupts. This makes it necessary to implement T-Head
> > C9xx CLINT support in OpenSBI MTIMER driver, which skips implementing
> > reading mtime register and falls back to default code that reads time
> > CSR."
> >
> > So, we need to fall back to read time CSR instead of mtime register.
> > Add riscv_csr_time_available static key for this purpose.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/include/asm/clint.h    |  2 ++
> >  arch/riscv/include/asm/timex.h    | 18 +++++++++---
> >  drivers/clocksource/timer-clint.c | 48 +++++++++++++++++++++++++++----
> >  3 files changed, 59 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
> > index 0789fd37b40a..c6057a182c5d 100644
> > --- a/arch/riscv/include/asm/clint.h
> > +++ b/arch/riscv/include/asm/clint.h
> > @@ -10,6 +10,7 @@
> >  #include <asm/mmio.h>
> >
> >  #ifdef CONFIG_RISCV_M_MODE
> > +#include <linux/jump_label.h>
> >  /*
> >   * This lives in the CLINT driver, but is accessed directly by timex.h to avoid
> >   * any overhead when accessing the MMIO timer.
> > @@ -21,6 +22,7 @@
> >   * like "riscv_mtime", to signify that these non-ISA assumptions must hold.
> >   */
> >  extern u64 __iomem *clint_time_val;
> > +DECLARE_STATIC_KEY_FALSE(riscv_csr_time_available);
> >  #endif
> >
> >  #endif
> > diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> > index a06697846e69..007a15482d75 100644
> > --- a/arch/riscv/include/asm/timex.h
> > +++ b/arch/riscv/include/asm/timex.h
> > @@ -17,18 +17,27 @@ typedef unsigned long cycles_t;
> >  #ifdef CONFIG_64BIT
> >  static inline cycles_t get_cycles(void)
> >  {
> > -	return readq_relaxed(clint_time_val);
> > +	if (static_branch_likely(&riscv_csr_time_available))
> > +		return csr_read(CSR_TIME);
> > +	else
> > +		return readq_relaxed(clint_time_val);
> >  }
> >  #else /* !CONFIG_64BIT */
> >  static inline u32 get_cycles(void)
> >  {
> > -	return readl_relaxed(((u32 *)clint_time_val));
> > +	if (static_branch_likely(&riscv_csr_time_available))
> > +		return csr_read(CSR_TIME);
> > +	else
> > +		return readl_relaxed(((u32 *)clint_time_val));
> >  }
> >  #define get_cycles get_cycles
> >
> >  static inline u32 get_cycles_hi(void)
> >  {
> > -	return readl_relaxed(((u32 *)clint_time_val) + 1);
> > +	if (static_branch_likely(&riscv_csr_time_available))
> > +		return csr_read(CSR_TIMEH);
> > +	else
> > +		return readl_relaxed(((u32 *)clint_time_val) + 1);
> >  }
>
> None of the else branches here need to actually be an else, since the
> other branch returns. Otherwise, looks aight to me, thanks for the
> update.

Also the static key is initialized to false and the commit message says only
the C9xx cores need to use the CSR_TIME, so shouldn't it be

  if (static_branch_unlikely(&riscv_csr_time_available))

instead, or am I reading this wrong?

/Emil

