Return-Path: <linux-kernel+bounces-30123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B116A8319CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2AC1C24A66
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C321B250E7;
	Thu, 18 Jan 2024 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="sAdDn6QI"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC924B4E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582769; cv=none; b=G7FQ1/sp81WprKLPOvSxNC5wNt6GfUT6MNIatu9TfzHDXi3kBsfxV8ttV7yKZhvbMnSdF8urhr0xs8qsOqc2iw+dPzDL3ZetblwOcZU02DheQQCf1YnD8zogFJN5eEWUyzPGEiYDbC+S+dBD9xxm7U9+l+Egta+TZnzHE+6RWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582769; c=relaxed/simple;
	bh=NyU7+c+3R5qieLOE7iZQGD9dmLTqV7McsWlPf5E4zCw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=qFNEvE9kExshGab2n1xlr5N15VQDjTXjy3lvoUzM3wJWDt6TDsN1zZMmWibLFkpoRy9q6tte1eIAXB9muk6uLV8swYUwcrD3QScNpAQQs5fLfN7iTmQH2v6iDs2GK+YJgsjZSBK9/D8c1XUCCDK3PEc0esjRT5u1eGARfEW3Gx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=sAdDn6QI; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36082f3cb06so64475305ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 04:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1705582767; x=1706187567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWADTwPjX+2jaYXFvN/zsXEQ2ZmoOpg5k/PCeUcdjSk=;
        b=sAdDn6QI8crmJgVo+jnaEFygVmZ7zyFNm6KMdmnS43XY1SxfIEsbV8M1DrcvFZFLMl
         Q5UFaOBpJb9CYb17hnTZ0u7v417roGLBDtPLhC/ZWVTa3JVYmg5hr8r+6yWtuOp5Y2Xt
         9t0f1UoA1Xw7fx1TvjUKabrd/BBo1cLMjDOHhR1aejp8L86na+fFTUDHi9ZPdub70rSD
         jjFyY/cC/9H0YJhyHgiw3eZqX5eXrkWvcz+CYvfGSLt+LFLZhfXrKWByfQSLZuQpvC3s
         feVSPTsxY/Pn8ZBfqDJIgOqEMGaP07AGy0IV59neSM26io8ClnTJ7tA52erAiRBAUPsT
         a7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705582767; x=1706187567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWADTwPjX+2jaYXFvN/zsXEQ2ZmoOpg5k/PCeUcdjSk=;
        b=MNujvNVnDBONo4Ibix1FCpuuiH/5Y5pZkMuGfU1Bd42iHPOZuEuJGbpX4JAaSX4dSN
         8opx4oKlMauG4CIL0fw0fQtFY7TU+T7XOBSJbqOVOFDao4edAF41qeSw9Ri2/NC3hksX
         3CVqmFV+DMwbtjlKgpOV3GiD3KByqL1Irk1YuBHWYEZFAd90lYQ3xEh1qzq1saFQqfUk
         jGQFRWbxCf927nOvsHReFVMsMGrYKRUbtx9iH9WC2OkjRcqx2AOTBkYpzIdZvo973oPx
         1o9BO2uyxokwwEX0HohDjshA3NPz1+HOLGMETrN4SSM1i3ZoAz272MTsvMFvPlMb7hvC
         pVVA==
X-Gm-Message-State: AOJu0YxD+DSClEPFHkou1gMgwpnrYVXXRa4nAzR4wFbfHX1PK8oBpkm4
	dtkmh1gUsnBRtXwnu4fFV9jf4ZcailBXczweNufYdDDrGMES0RYpYOBjQQqjRYQILIQVc5WSKGT
	N1YkECKp2ojCIFzbGoWd3DbPq4arCniRdF+a5aQ==
X-Google-Smtp-Source: AGHT+IEULXICvafspeHkLMkr6soWFzV0SUySB8GzLHkUsKVp+V05biZlODsydI6eC8onv1WinflroTNSid+Lah/ulTM=
X-Received: by 2002:a05:6e02:5ac:b0:361:98a3:a7ac with SMTP id
 k12-20020a056e0205ac00b0036198a3a7acmr879075ils.58.1705582767073; Thu, 18 Jan
 2024 04:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104123727.76987-2-ajones@ventanamicro.com>
In-Reply-To: <20240104123727.76987-2-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 18 Jan 2024 18:29:16 +0530
Message-ID: <CAAhSdy0SxZWdCHQVW0Bki+bHpg4qrHWV0aFzJq8V2xYtwsMWhw@mail.gmail.com>
Subject: Re: [PATCH -fixes v2] RISC-V: KVM: Require HAVE_KVM
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-next@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, atishp@atishpatra.org, rdunlap@infradead.org, 
	sfr@canb.auug.org.au, alex@ghiti.fr, mpe@ellerman.id.au, npiggin@gmail.com, 
	linuxppc-dev@lists.ozlabs.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 6:07=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> KVM requires EVENTFD, which is selected by HAVE_KVM. Other KVM
> supporting architectures select HAVE_KVM and then their KVM
> Kconfigs ensure its there with a depends on HAVE_KVM. Make RISCV
> consistent with that approach which fixes configs which have KVM
> but not EVENTFD, as was discovered with a randconfig test.
>
> Fixes: 99cdc6c18c2d ("RISC-V: Add initial skeletal KVM support")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/44907c6b-c5bd-4e4a-a921-e4d3825539d8@=
infradead.org/
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Queued this patch for Linux-6.8

Regards,
Anup

> ---
>
> v2:
>  - Added Fixes tag and -fixes prefix [Alexandre/Anup]
>
>  arch/riscv/Kconfig     | 1 +
>  arch/riscv/kvm/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a935a5f736b9..daba06a3b76f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -128,6 +128,7 @@ config RISCV
>         select HAVE_KPROBES if !XIP_KERNEL
>         select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>         select HAVE_KRETPROBES if !XIP_KERNEL
> +       select HAVE_KVM
>         # https://github.com/ClangBuiltLinux/linux/issues/1881
>         select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
>         select HAVE_MOVE_PMD
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index 1fd76aee3b71..36fa8ec9e5ba 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -19,7 +19,7 @@ if VIRTUALIZATION
>
>  config KVM
>         tristate "Kernel-based Virtual Machine (KVM) support (EXPERIMENTA=
L)"
> -       depends on RISCV_SBI && MMU
> +       depends on HAVE_KVM && RISCV_SBI && MMU
>         select HAVE_KVM_IRQCHIP
>         select HAVE_KVM_IRQ_ROUTING
>         select HAVE_KVM_MSI
> --
> 2.43.0
>

