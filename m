Return-Path: <linux-kernel+bounces-73062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968285BCF9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290561F23763
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E03C6A32B;
	Tue, 20 Feb 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="JZUUgBhi"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B26A02D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434961; cv=none; b=Qfxznyf/p2NcyQWjTAFo7ROTuwu3XZdYO6d+KN5aINL1P44NZd8+cxoipYoXl67HKpjdMj81UtSyqLz25W1tZB2IVfTQHukztBMVFU/rLbTnXCMBFLa0uVVaJ1D0DI59VoxWohwnVhSj8LHa7evl40B9SCmA9eLvVS+YNrpQsaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434961; c=relaxed/simple;
	bh=IqjOTROjMQYB67bxRQ6W3keFDzFkSXSEKRuI3JlJhrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j73LFy61f+z9A8DIWxawwaQqcfFMfVhx2SdwLRuxuGjlaiZJY2G1bC9GicUGvotz0GIZwusJMNp/I2rUAk9jFDvrHuIAKLumDABy1mIrHaRsdU2hDxvv1jNl5NM/KkQPPEAtgfRYMTn8BapWYShkPbNjSQbmh+K94UN6izp6sAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=JZUUgBhi; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3651b948db6so7082845ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1708434959; x=1709039759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqjOTROjMQYB67bxRQ6W3keFDzFkSXSEKRuI3JlJhrA=;
        b=JZUUgBhi4CmBa1e9THLSmdnIzP7xi0o/Ie8KGr+O2WSNgAXLwU8tb/ZZn4YaJH19Ay
         I3kkZo5//m4bX9l0vVMOcgza+ysWKnlsOeQJwv5vfQSqG0WqlifwtVXpzMLAc3kd5Xdu
         pskliOHc4z92llrsRYaKIC8GOKZM6+UCGVm63w3V8dz11HqYjJYs9yQw/eBp7MRX3oM3
         o3lpiMDbDfyoOprh4cOmIfOqe7Yd360f68GcezPfqMgkpaKHcW8kn+g9/0wigM24Jxt5
         97/kLgE4n4kgwHKRxoabUC4ck3pDpwUiSBzl7t8PAq8ybhgkBOYWRiUoGXdCkPK/tzbu
         +/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708434959; x=1709039759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqjOTROjMQYB67bxRQ6W3keFDzFkSXSEKRuI3JlJhrA=;
        b=eAdzkeVDJnJ2f0NBW01lfF3G/kAuNc4YdScXnuRYSxDAOvtNPKsFnSUqdgz3BtTxqb
         6hSsmxFQ/C30jZ0nRTq/ngR8Uk5ECLPrOunYNXeulY3pu0MbV8CdibRXbwZvZ6k2xh5/
         N43BRZrJghQfTfbe40V4ndDV4ImgwKy6OhjyIk0ma7uOpRoKXQbPOhQxmg+A8kOVj0nq
         odrupQJ75jgZBg3sEPdwMj4hOAY3uQZUnQmgo4ToHgMLgUGPPl014oReG/AmFdzvQwid
         fWfx81LV4IpMlXkQ1iiIP17aLdvtIitQ5HFVatd7rUSWTHX9K7gf4D8CHHNwxEzBV01p
         lGlw==
X-Forwarded-Encrypted: i=1; AJvYcCWMMs1VCuPfV9kQVlw3d3wvFVobwx4R1Z0Zbgd32xKEWpOAsCRQMPCtVC1WWYXp5uZzklclwgL1wdryJ1Ue3NPvkihMjDDRSez/xt2g
X-Gm-Message-State: AOJu0YxmuIP9+JbErYObhmaJ3h1+XPXawxIjSjgKlphDEP5DOAZK5a61
	FTKz2IOULI2EksApHhgMcYX9ltCbB+TP0LLe7BwoBed7sx4qHCfxYQhet+VqFtaZHZe9GGe6VOk
	c6JJuJp74A2L1IMe0dgHu1pUsaQ3E4UA4xWhXJQ==
X-Google-Smtp-Source: AGHT+IGBHyxhOfx+rHBkUEIb+UN9EusJtSraJpbfRqOa1twSLXdPbfjomfAe1MpQwps5BmFOHpbz4M0jqq6MI7Pf8d0=
X-Received: by 2002:a92:cf0f:0:b0:365:1785:88f6 with SMTP id
 c15-20020a92cf0f000000b00365178588f6mr10945548ilo.3.1708434959388; Tue, 20
 Feb 2024 05:15:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-7-apatel@ventanamicro.com> <87a5nvfj2s.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87a5nvfj2s.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 20 Feb 2024 18:45:47 +0530
Message-ID: <CAAhSdy187H0E1-V4uhrik42qHoZrk-w499YWFzR13EWX-Wyu=g@mail.gmail.com>
Subject: Re: [PATCH v13 06/13] irqchip: Add RISC-V incoming MSI controller
 early driver
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:23=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > The RISC-V advanced interrupt architecture (AIA) specification
> > defines a new MSI controller called incoming message signalled
> > interrupt controller (IMSIC) which manages MSI on per-HART (or
> > per-CPU) basis. It also supports IPIs as software injected MSIs.
> > (For more details refer https://github.com/riscv/riscv-aia)
> >
> > Let us add an early irqchip driver for RISC-V IMSIC which sets
> > up the IMSIC state and provide IPIs.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>
> This patch has a couple of checkpatch issues:
>
> CHECK: Alignment should match open parenthesis
> CHECK: Please don't use multiple blank lines
> CHECK: Please use a blank line after function/struct/union/enum declarati=
ons
> CHECK: Unnecessary parentheses around 'global->nr_guest_ids < IMSIC_MIN_I=
D'
> CHECK: Unnecessary parentheses around 'global->nr_guest_ids >=3D IMSIC_MA=
X_ID'
> CHECK: Unnecessary parentheses around 'global->nr_ids < IMSIC_MIN_ID'
> CHECK: Unnecessary parentheses around 'global->nr_ids >=3D IMSIC_MAX_ID'
> CHECK: Unnecessary parentheses around global->local
> CHECK: Unnecessary parentheses around imsic->lpriv
> CHECK: extern prototypes should be avoided in .h files
>

Okay, I will address these in the next revision.

Regards,
Anup

