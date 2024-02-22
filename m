Return-Path: <linux-kernel+bounces-76761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AEF85FC22
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B067D28971F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1981014D434;
	Thu, 22 Feb 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeEyt97g"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5859E14D435
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615029; cv=none; b=KRNicYJlaVlz0H+gHNQG+xjhNfVqfqkkAxML7edLJ7DCSszeCf9yAh7wRHDTug0jki9paOL1/Pm0z/5aYkRDObgtJ6yKbfP1eTWwdnYdE6AmAnaQJ3QBze8wG+pmkqE0fV1uRQ+JeW9aV9kJ3eaQreZYGh4xj3FHE/1b+Do5Hrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615029; c=relaxed/simple;
	bh=jE1smbilwwuUTxlOGPI8u4Pvc86xtJjVhfwWSrbdnNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2OMPj3yGWXtR+TYr/s5ebEag7J9Yg/mnT7igCYbD2xeTzz0YuLKwyK+o846R3MNMuAK+Q2ky3mkWHiuLFb24ymmSyn8IoHpOKzzdKfHv5CG9vvt0ASjC05MZytZbcFnrLQHVafVAt9R67/TN4kdeiB1mW8ae4bGtAkaFdLgwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jeEyt97g; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-410acf9e776so59375e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708615025; x=1709219825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+iF9o/NZzsGZGtwVZGeQKMH65Ee8z6fiQn4IwAd3ZA=;
        b=jeEyt97gz63KFz//MQixJicJOZSy43YjFw84N61fNkkNemF6c0gCg6BIdh8O0UprTu
         qOXZEqXy++NmzMLOsB1bkmrTS/Vyw5ZDrbHO4nEx2iQvkUK3Y44cSE/j2u096h0rbA6A
         lYZMF03oqEublZMDufglZS0aDI5yBHiZUQyqBgQoBRSd3/A7y7nNUnffLbCQYMx0VJc8
         l7KP5rgig+0R3XS9hWwNRfQq0IhV7v7hxC6UmH31+XoATHslUkDUF1gZwNHApngrGjZi
         ApnnbRxVN8dhvlehTNtAZg7n4ZVG8wYqctQROlZdMG3U5R5LvmZiVJ2ZA5pUIFwAUfqI
         Ap9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615025; x=1709219825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+iF9o/NZzsGZGtwVZGeQKMH65Ee8z6fiQn4IwAd3ZA=;
        b=S4Ghh6oy+CnntVTG3aS4PzhUlC5y2fiPTCS57CMsLsgPUshrYwVPUcfSxpDlgx8jtp
         gZQ33j8L3CBoXxlU3q1m+by5tkKyhqooEb4X1tegSliMvwqGtEtjTZpkFSIMBF54UHB8
         bk0HjDRP/iycdrxgzxI+EC/16M4q0ZduArsYq2Ey1Tl0ZF7qhm/ItrNitIIFvvzJO5ze
         gTdQ6CtVtRggUg4QrLcYuqrGwwrjQqhTSDVfoE0oZmWPM4EXdBwpHJQzg3V9SRY6qeYw
         fzehIzh7eGTuYDPMLmrZth/u0EoJHSS+nDnAeevGGaUq7kdqgdKgRFZQuAKS1L/OJ8Mo
         W0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxvAalfSaM5FNJ5l6XdeDlDlCAtzcR3o30osdx+VyWmTiegX0GwkUTmBQ/oucp2/xpgWwkeed/9BW1pTjH7j2fGXSI+NeD3OJ408jv
X-Gm-Message-State: AOJu0YwarGFnUk5PvU0Jyirw5M0OtkAYfQ/1xZTV0QuymXfF5S30X1Q4
	Q8w3Ys0IW/wBhWYc+mN40/Q9gTRXrLkGaBLlCX2Nc3pP9SxHYSEhkV9ciRZQs2CW+AKmYoneDkW
	7SFDs
X-Google-Smtp-Source: AGHT+IEV5jG6AiN4BwmXoTQnJIhm9yCBOIr4zqeXzJCp6J7wpxLmYTEmrmtGvEUPUAGTbpyh0WG1lQ==
X-Received: by 2002:a05:600c:4e11:b0:412:8f47:d872 with SMTP id b17-20020a05600c4e1100b004128f47d872mr22221wmq.1.1708615025452;
        Thu, 22 Feb 2024 07:17:05 -0800 (PST)
Received: from google.com (161.126.77.34.bc.googleusercontent.com. [34.77.126.161])
        by smtp.gmail.com with ESMTPSA id je11-20020a05600c1f8b00b0040fdf5e6d40sm22277768wmb.20.2024.02.22.07.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:17:04 -0800 (PST)
Date: Thu, 22 Feb 2024 15:17:02 +0000
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, gshan@redhat.com, james.morse@arm.com,
	mark.rutland@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	rananta@google.com, ricarkol@google.com, ryan.roberts@arm.com,
	shahuang@redhat.com, suzuki.poulose@arm.com, will@kernel.org,
	yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	vdonnefort@google.com
Subject: Re: [PATCH v6 4/6] KVM: arm64: Register ptdump with debugfs on guest
 creation
Message-ID: <ZddlbkG9j8UjhaWs@google.com>
References: <20240220151035.327199-1-sebastianene@google.com>
 <20240220151035.327199-5-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220151035.327199-5-sebastianene@google.com>

On Tue, Feb 20, 2024 at 03:10:33PM +0000, Sebastian Ene wrote:
> While arch/*/mem/ptdump handles the kernel pagetable dumping code,
> introduce KVM/ptdump which shows the guest stage-2 pagetables. The
> separation is necessary because most of the definitions from the
> stage-2 pagetable reside in the KVM path and we will be invoking
> functionality **specific** to KVM.
> 
> When a guest is created, register a new file entry under the guest
> debugfs dir which allows userspace to show the contents of the guest
> stage-2 pagetables when accessed.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/kvm/Kconfig      | 13 ++++++
>  arch/arm64/kvm/Makefile     |  1 +
>  arch/arm64/kvm/debug.c      |  8 ++++
>  arch/arm64/kvm/kvm_ptdump.h | 20 +++++++++
>  arch/arm64/kvm/ptdump.c     | 88 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 130 insertions(+)
>  create mode 100644 arch/arm64/kvm/kvm_ptdump.h
>  create mode 100644 arch/arm64/kvm/ptdump.c
> 
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 27ca89b628a0..83ca07d16cf4 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -67,4 +67,17 @@ config PROTECTED_NVHE_STACKTRACE
>  
>  	  If unsure, or not using protected nVHE (pKVM), say N.
>  
> +config PTDUMP_STAGE2_DEBUGFS
> +       bool "Present the stage-2 pagetables to debugfs"
> +       depends on PTDUMP_DEBUGFS && KVM
> +       default n
> +       help
> +         Say Y here if you want to show the stage-2 kernel pagetables
> +         layout in a debugfs file. This information is only useful for kernel developers
> +         who are working in architecture specific areas of the kernel.
> +         It is probably not a good idea to enable this feature in a production
> +         kernel.
> +
> +         If in doubt, say N.
> +
>  endif # VIRTUALIZATION
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index c0c050e53157..190eac17538c 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -23,6 +23,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
>  	 vgic/vgic-its.o vgic/vgic-debug.o
>  
>  kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
> +kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
>  
>  always-y := hyp_constants.h hyp-constants.s
>  
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 8725291cb00a..ff97af2c0513 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -14,6 +14,8 @@
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_emulate.h>
>  
> +#include <kvm_ptdump.h>
> +
>  #include "trace.h"
>  
>  /* These are the bits of MDSCR_EL1 we may manipulate */
> @@ -342,3 +344,9 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>  }
> +
> +int kvm_arch_create_vm_debugfs(struct kvm *kvm)
> +{
> +	kvm_ptdump_guest_register(kvm);
> +	return 0;
> +}
> diff --git a/arch/arm64/kvm/kvm_ptdump.h b/arch/arm64/kvm/kvm_ptdump.h
> new file mode 100644
> index 000000000000..5e8a655605f1
> --- /dev/null
> +++ b/arch/arm64/kvm/kvm_ptdump.h
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) Google, 2023
> + * Author: Sebastian Ene <sebastianene@google.com>
> + */
> +
> +#ifndef __KVM_PTDUMP_H
> +#define __KVM_PTDUMP_H
> +
> +#include <linux/kvm_host.h>
> +#include <asm/ptdump.h>
> +
> +
> +#ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
> +void kvm_ptdump_guest_register(struct kvm *kvm);
> +#else
> +static inline void kvm_ptdump_guest_register(struct kvm *kvm) {}
> +#endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
> +
> +#endif /* __KVM_PTDUMP_H */
> diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> new file mode 100644
> index 000000000000..9b04c24bb9be
> --- /dev/null
> +++ b/arch/arm64/kvm/ptdump.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Debug helper used to dump the stage-2 pagetables of the system and their
> + * associated permissions.
> + *
> + * Copyright (C) Google, 2023
> + * Author: Sebastian Ene <sebastianene@google.com>
> + */
> +#include <linux/debugfs.h>
> +#include <linux/kvm_host.h>
> +#include <linux/seq_file.h>
> +
> +#include <asm/kvm_pgtable.h>
> +#include <kvm_ptdump.h>
> +
> +
> +static int kvm_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
> +			      enum kvm_pgtable_walk_flags visit)
> +{
> +	struct pg_state *st = ctx->arg;
> +	struct ptdump_state *pt_st = &st->ptdump;
> +
> +	note_page(pt_st, ctx->addr, ctx->level, ctx->old);
> +	return 0;
> +}
> +
> +static int kvm_ptdump_show_common(struct seq_file *m,
> +				  struct kvm_pgtable *pgtable,
> +				  struct pg_state *parser_state)
> +{
> +	struct kvm_pgtable_walker walker = (struct kvm_pgtable_walker) {
> +		.cb     = kvm_ptdump_visitor,
> +		.arg	= parser_state,
> +		.flags	= KVM_PGTABLE_WALK_LEAF,
> +	};
> +
> +	return kvm_pgtable_walk(pgtable, 0, BIT(pgtable->ia_bits), &walker);
> +}
> +
> +static int kvm_ptdump_guest_show(struct seq_file *m, void *)
							^
FIXME: Here I need to specify an argument name as building with clang
complaints about this.

> +{
> +	struct kvm *kvm = m->private;
> +	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
> +	struct pg_state parser_state = {0};
> +	int ret;
> +
> +	write_lock(&kvm->mmu_lock);
> +	ret = kvm_ptdump_show_common(m, mmu->pgt, &parser_state);
> +	write_unlock(&kvm->mmu_lock);
> +
> +	return ret;
> +}
> +
> +static int kvm_ptdump_guest_open(struct inode *m, struct file *file)
> +{
> +	struct kvm *kvm = m->i_private;
> +	int ret;
> +
> +	if (!kvm_get_kvm_safe(kvm))
> +		return -ENOENT;
> +
> +	ret = single_open(file, kvm_ptdump_guest_show, m->i_private);
> +	if (ret < 0)
> +		kvm_put_kvm(kvm);
> +
> +	return ret;
> +}
> +
> +static int kvm_ptdump_guest_close(struct inode *m, struct file *file)
> +{
> +	struct kvm *kvm = m->i_private;
> +
> +	kvm_put_kvm(kvm);
> +	return single_release(m, file);
> +}
> +
> +static const struct file_operations kvm_ptdump_guest_fops = {
> +	.open		= kvm_ptdump_guest_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= kvm_ptdump_guest_close,
> +};
> +
> +void kvm_ptdump_guest_register(struct kvm *kvm)
> +{
> +	debugfs_create_file("stage2_page_tables", 0400, kvm->debugfs_dentry,
> +			    kvm, &kvm_ptdump_guest_fops);
> +}
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

