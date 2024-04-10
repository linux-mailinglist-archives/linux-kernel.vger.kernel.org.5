Return-Path: <linux-kernel+bounces-139378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A14D08A0238
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE6B1F2118E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE200190674;
	Wed, 10 Apr 2024 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kJe1cU1i"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD60118412B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784889; cv=none; b=jizJZ8hR+ez3VArqg/wvO6iU7FMBE2o/ELfL2CxO70mqOf6PAd6MCl1CTCLJPj7Twi8y6ohqBc+WMrWm46eL5mbRrMcA9mPHlrKUW2W72B7Dus1zwORj7ZSIPdS+24zDXgBwUgxFwh03ybV8BflfZ4KE0rRd9msu49KgcCuGGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784889; c=relaxed/simple;
	bh=+Zl2pAaKAA2HzyDnhWshXv9VyS5payJIT/fbySA2d9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPDo9A2vxNvEnZwuuNpN9fBWr52YiQ0jKFGMdqNijyUnYMHdPhi1DI4WNgHUDoLyBm6aBIZOkw1+kQhAMfsGR5goxKq1CCuzuBw4bn1rBywTUEa7nRpuWpxOnWJ4rApN1OMlr5uKKGCzLOILdlm9x/rKuNRWQNZHOVyvNMPKa70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kJe1cU1i; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61587aa9f4cso73822017b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712784887; x=1713389687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCWiTOuyXFMcE85DuFu420bVCS/UPVrh/Hb5YvaLOl8=;
        b=kJe1cU1ikx4LojZpQfBUuxfP/ItKGXMjdEMO09nx+OWzWfUQOJh3h2KQpJKNMdMWqp
         8CJoXoCUzG/HvAVkcHes2ASfIiOlxsX1R/7X4hmP6mSdgVlx2a2XTaP1TqGbE7bf1AWO
         P0KuS97pMWGKTggW1KZjGLnknZyB4wcWaxyd8cawzsS55nwn0rQw0EZDdqNJCEdEkt9Y
         Z5bx5F9SyZHLjZRnX1TsMUMF9fTOg6OEGFXUmN2/f+qYE+MikMSIdGvo3D8i22lHgrVX
         RjwzTPN0Gd21NBgTKTqYRvA5/z0995MByw/4F8OF8ZME0Z24xFciNqclNGcjZdDdVEvG
         ZO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712784887; x=1713389687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCWiTOuyXFMcE85DuFu420bVCS/UPVrh/Hb5YvaLOl8=;
        b=mfhP2SXAiVzuh9dy3o/HsTG0A7pVgvIHOw5yL4dadMVt75XHYI/cH2YJcvAI5d/nok
         CPe85Bza7ZqnEhi3mh9VO/c2FEu2EBInLGi37N91NuScYTv3xqZwVHFhp7j5DLyyG6Du
         CWjMfaMQISmfmxqO6XSRO95/taZCYQu1rRuwDu5puACWEiLY5+lMEQOF+el07BHSjv4z
         saP21KaCtpeG4mE9hdUnc135CI3BErf8xlnIU3HMowOmQK1OicG4SKvnh9+CzVlZzlrf
         fxfgFYC7TrDPruClFlzbqqpFFeREnyYyrS5RnKmYY3RUNWZ3Xagx9GQPLtr+VhnonfhU
         /N9g==
X-Forwarded-Encrypted: i=1; AJvYcCVY+zFcEF33GulDzn421WYg/DhiqTUhcFPeM7ZPV87uNUYPBiuDviXERkYIN1FcBl8ra0OlmXPcWNTtzFmDBi18Y2kE4qhniu/YwAXG
X-Gm-Message-State: AOJu0YyEGjiS6DUgF/TA/g9luJohvtqeOCRH/4U9/KCl7dKTeawxq2Fr
	PnDdGYpdt5+GPmJXm+tk97jfX/nwfJUzvTx2cn/SwHJxWAqq5oQDA7h8FZ0/IIH1yWx4hmfRcP3
	CYh+ZR0SwNdLMqZM2vCgwYT8NyNlT4Q2ZWLVbGw==
X-Google-Smtp-Source: AGHT+IEJg6eBXgbrMvBxZrqHkCbyEafHccYY//puWMRuRRJPxivVjKGGtxP4Mzjd2PLpKtGs9YHHsRYFuI2P7eGObSs=
X-Received: by 2002:a81:e946:0:b0:609:fff2:3bbc with SMTP id
 e6-20020a81e946000000b00609fff23bbcmr3613852ywm.49.1712784886891; Wed, 10 Apr
 2024 14:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410091106.749233-1-cleger@rivosinc.com>
In-Reply-To: <20240410091106.749233-1-cleger@rivosinc.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 10 Apr 2024 14:34:33 -0700
Message-ID: <CAKC1njRJRnxj8XjwJ-Yx6Guu=9kSEdaFnxF1e+gXq9ij_j=atA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add support for a few Zc* extensions as well as Zcmop
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Anup Patel <anup@brainfault.org>, 
	Shuah Khan <shuah@kernel.org>, Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the series:

Reviewed-by: Deepak Gupta <debug@rivosinc.com>

On Wed, Apr 10, 2024 at 2:13=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> Add support for (yet again) more RVA23U64 missing extensions. Add
> support for Zcmop, Zca, Zcf, Zcd and Zcb extensions isa string parsing,
> hwprobe and kvm support. Zce, Zcmt and Zcmp extensions have been left
> out since they target microcontrollers/embedded CPUs and are not needed
> by RVA23U64
>
> This series is based on the Zimop one [1].
>
> Link: https://lore.kernel.org/linux-riscv/20240404103254.1752834-1-cleger=
@rivosinc.com/ [1]
>
> Cl=C3=A9ment L=C3=A9ger (10):
>   dt-bindings: riscv: add Zca, Zcf, Zcd and Zcb ISA extension
>     description
>   riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
>   riscv: hwprobe: export Zca, Zcf, Zcd and Zcb ISA extensions
>   RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb extensions for Guest/VM
>   KVM: riscv: selftests: Add some Zc* extensions to get-reg-list test
>   dt-bindings: riscv: add Zcmop ISA extension description
>   riscv: add ISA extension parsing for Zcmop
>   riscv: hwprobe: export Zcmop ISA extension
>   RISC-V: KVM: Allow Zcmop extension for Guest/VM
>   KVM: riscv: selftests: Add Zcmop extension to get-reg-list test
>
>  Documentation/arch/riscv/hwprobe.rst          | 24 ++++++++++++
>  .../devicetree/bindings/riscv/extensions.yaml | 37 +++++++++++++++++++
>  arch/riscv/include/asm/hwcap.h                |  5 +++
>  arch/riscv/include/uapi/asm/hwprobe.h         |  5 +++
>  arch/riscv/include/uapi/asm/kvm.h             |  5 +++
>  arch/riscv/kernel/cpufeature.c                |  5 +++
>  arch/riscv/kernel/sys_hwprobe.c               |  5 +++
>  arch/riscv/kvm/vcpu_onereg.c                  | 10 +++++
>  .../selftests/kvm/riscv/get-reg-list.c        | 20 ++++++++++
>  9 files changed, 116 insertions(+)
>
> --
> 2.43.0
>
>

