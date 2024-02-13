Return-Path: <linux-kernel+bounces-63918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8409785365C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97591F268D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DB06024C;
	Tue, 13 Feb 2024 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRUiMBX9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF3360240
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842554; cv=none; b=H7EKhrJFoRlWWSrA7JYNUI+cT8rm3DybBKQ+UVfp+7i9wdzfLbL9AA0AAXzdL+Dd27RFjlq1ocWorHhKGW4WEaUPfllmUkFzpi5aNxNIHSmYjuCHR6ZQtNm+EdMx+/0NuBNApOEJlLqdQm01iYNusnNvzwUMo1nsZ6D8UqhZnuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842554; c=relaxed/simple;
	bh=5fbIdqjQ0pjST0jLB5/NYZqj5QUdWaDy2LETc337cM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxWfJcgzsZIB8s/enlV7CsxkiXehYSJMbI6WFV2UKoomUDZ85kjEV/DvDu+nRcJ1smYA/CeQrMlxhYOQzgRimPquxViQKVOulA0tJIH6YKu1ckM0znWhOnrA9SucJhew7/MFKxPnx8aLEFSpsoMShuHoCE4xxmnYOXAYqGaFptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRUiMBX9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-410acf9e776so62615e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707842549; x=1708447349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=go1NDQqUFQni149mzcXDcSXrog8f9Zls+FdUA+jGdQk=;
        b=NRUiMBX9kKuTMnYcVMGEkfrZ+bV2XNYBuRHSoSr6ilCFSQ9W20rAk/H/MbdWCGGhai
         TGnTkbNEIUxflJ6ypogziCZ5zT/JZ+N71vUTbHTw8JH3j4J29lbec46dk/eX4DdhBG4H
         y6wQAHHZGEfT2XvYFNlTQq9j7QrgjJbP4Vp+xQ9+h+acx5leHAPk3xQWQWk40cRD29Aw
         Bb75XQPBx0W388r2BqkBKx71UVcF/R13kMW0ZaaZkKlPKMYkwK1/+OswCcgRr2iV7cb6
         g8PuHq33ObVbeRKXOW4erwcn+lDa6YCnzLNH7O1LifvNssM2w3RZCdpFcX3Id0UWmvWs
         aVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842549; x=1708447349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=go1NDQqUFQni149mzcXDcSXrog8f9Zls+FdUA+jGdQk=;
        b=AldwDYLeYOsSHJgTtmn0THIZ7/YGlG8CZmgTlcFygdnj/LwmkpMgPZAJqcwTkky3dK
         MKNAOAZrfXzDYBo3BGDBBz1A1q0gsvD+8HF52B2QS0+YIgkh4lBiySc6bi6zcemuKAIm
         dxIPfU+iJOBXsV2muOWuaC612aIg5F93LMXfB06NdaMoYEGhVQeKP5znZc5FNk7AfR+r
         LlqFFxNi1uiAqDv2eros0gOPLYf7FdOIjt8UQOCE2Zlxk/EYnoyaCc69eOJCyPCJicR7
         5qI+KQ2MLm0M94Uad6nCUE+gtjzH2z/ssOERf6job76w8ClzelATeQGbwh6nHgw/UP5a
         s6WA==
X-Forwarded-Encrypted: i=1; AJvYcCXCTHZSjlo7bhK9AIR6d7ZIZQMnX1Tkh41akBFTj1fGqj/ERUHi9IaVg78TT+XsLAYcJ78TJBlUFO9TxOAYRlsYf/0LF3oaAL3IcyO+
X-Gm-Message-State: AOJu0YxbomqRWo6Y7WyIyOJMp4bKzBYMN3+y7jlEl3+rkBFtdsEdfzn6
	Y6sM+qipqmsTK0aT2iN0Kwk8NSxmzPOCS+l1wwCQ7f6GvlAKtSajI3kA51EfTA==
X-Google-Smtp-Source: AGHT+IEQ4OF+7VY3dkS4xJoz0W42M2A0tS6ekcpBsUb3AD8IA75L0XaTEOsjHGusJ1xpxWDlVsgqAg==
X-Received: by 2002:a05:600c:3d8f:b0:411:b159:1705 with SMTP id bi15-20020a05600c3d8f00b00411b1591705mr16193wmb.4.1707842549229;
        Tue, 13 Feb 2024 08:42:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfwGzBn6/aurEiTGpszh2LCsNgtKpZaK4O7KSdW15zt3eyvpV9u23g+v3vDptqHLzRGeVsJ3SKDXfsnt7e+UtF+Sg4rkbKRmuHXInQ2d6aDLuPgPfHFtSk6yg3gWBnknLRoqabklqiNrX+hs+xrbDaqtwwCzlMABDgBvnXxEX+zOPPNyKByAKcJuPlMxGBjSoAZPCIm2WqZrckhftEokC1hml+Ax6bV4UHjDYOZxMzRnWSgpezBZClJ+ddCUB6Fr3ar4Q3R0SWOVgJKbeG6vFcXtgH7BNJxL3kklmxx2VWHradejD05VcsQ0+o594aFRBYQJ01EFU6WvfYCtoEsqlvUBpgyMhOVq07zak64IJC/UuWYPWYxhBQpgDXHV5ea/z8TFEMIxlpZU7WVztwZww0EZzj+9dgqdYpzBb08GhdwoAv3hp1gRxH60PsGN88JH5T8dsPkcCxNquHoz2n8DRFShFJgIk8FapAKRRBjYc5/sOZZtdr2eQ5I7TCvo2rarim+kXSXWKWPxpM0d37bSQy5q2KvHmw2yEYAg==
Received: from google.com (161.126.77.34.bc.googleusercontent.com. [34.77.126.161])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b0033b4f82b301sm10232741wrb.3.2024.02.13.08.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 08:42:28 -0800 (PST)
Date: Tue, 13 Feb 2024 16:42:27 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: catalin.marinas@arm.com, gshan@redhat.com, james.morse@arm.com,
	mark.rutland@arm.com, maz@kernel.org, rananta@google.com,
	ricarkol@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	vdonnefort@google.com
Subject: Re: [PATCH v5 3/4] KVM: arm64: Register ptdump with debugfs on guest
 creation
Message-ID: <Zcub87FwaVPkCXQE@google.com>
References: <20240207144832.1017815-2-sebastianene@google.com>
 <20240207144832.1017815-5-sebastianene@google.com>
 <Zcq-NGa-Gd9rVVgF@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcq-NGa-Gd9rVVgF@linux.dev>

On Tue, Feb 13, 2024 at 12:56:20AM +0000, Oliver Upton wrote:
> On Wed, Feb 07, 2024 at 02:48:32PM +0000, Sebastian Ene wrote:

Hello Oliver,

> > While arch/*/mem/ptdump handles the kernel pagetable dumping code,
> > introduce KVM/ptdump which shows the guest stage-2 pagetables. The
> > separation is necessary because most of the definitions from the
> > stage-2 pagetable reside in the KVM path and we will be invoking
> > functionality **specific** to KVM.
> > 
> > When a guest is created, register a new file entry under the guest
> > debugfs dir which allows userspace to show the contents of the guest
> > stage-2 pagetables when accessed.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/kvm/Kconfig      | 13 ++++++
> >  arch/arm64/kvm/Makefile     |  1 +
> >  arch/arm64/kvm/debug.c      |  7 ++++
> >  arch/arm64/kvm/kvm_ptdump.h | 20 ++++++++++
> >  arch/arm64/kvm/ptdump.c     | 79 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 120 insertions(+)
> >  create mode 100644 arch/arm64/kvm/kvm_ptdump.h
> >  create mode 100644 arch/arm64/kvm/ptdump.c
> > 
> > diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> > index 6c3c8ca73e7f..28097dd72174 100644
> > --- a/arch/arm64/kvm/Kconfig
> > +++ b/arch/arm64/kvm/Kconfig
> > @@ -68,4 +68,17 @@ config PROTECTED_NVHE_STACKTRACE
> >  
> >  	  If unsure, or not using protected nVHE (pKVM), say N.
> >  
> > +config PTDUMP_STAGE2_DEBUGFS
> > +       bool "Present the stage-2 pagetables to debugfs"
> > +       depends on PTDUMP_DEBUGFS && KVM
> > +       default n
> > +       help
> > +         Say Y here if you want to show the stage-2 kernel pagetables
> > +         layout in a debugfs file. This information is only useful for kernel developers
> > +         who are working in architecture specific areas of the kernel.
> > +         It is probably not a good idea to enable this feature in a production
> > +         kernel.
> > +
> > +         If in doubt, say N.
> > +
> >  endif # VIRTUALIZATION
> > diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> > index c0c050e53157..190eac17538c 100644
> > --- a/arch/arm64/kvm/Makefile
> > +++ b/arch/arm64/kvm/Makefile
> > @@ -23,6 +23,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
> >  	 vgic/vgic-its.o vgic/vgic-debug.o
> >  
> >  kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
> > +kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
> >  
> >  always-y := hyp_constants.h hyp-constants.s
> >  
> > diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> > index 8725291cb00a..aef52836cd90 100644
> > --- a/arch/arm64/kvm/debug.c
> > +++ b/arch/arm64/kvm/debug.c
> > @@ -14,6 +14,8 @@
> >  #include <asm/kvm_arm.h>
> >  #include <asm/kvm_emulate.h>
> >  
> > +#include <kvm_ptdump.h>
> > +
> >  #include "trace.h"
> >  
> >  /* These are the bits of MDSCR_EL1 we may manipulate */
> > @@ -342,3 +344,8 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
> >  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
> >  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
> >  }
> > +
> > +int kvm_arch_create_vm_debugfs(struct kvm *kvm)
> > +{
> > +	return kvm_ptdump_guest_register(kvm);
> > +}
> > diff --git a/arch/arm64/kvm/kvm_ptdump.h b/arch/arm64/kvm/kvm_ptdump.h
> > new file mode 100644
> > index 000000000000..a7c00a28481b
> > --- /dev/null
> > +++ b/arch/arm64/kvm/kvm_ptdump.h
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) Google, 2023
> > + * Author: Sebastian Ene <sebastianene@google.com>
> > + */
> > +
> > +#ifndef __KVM_PTDUMP_H
> > +#define __KVM_PTDUMP_H
> > +
> > +#include <linux/kvm_host.h>
> > +#include <asm/ptdump.h>
> > +
> > +
> > +#ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
> > +int kvm_ptdump_guest_register(struct kvm *kvm);
> > +#else
> > +static inline int kvm_ptdump_guest_register(struct kvm *kvm) { return 0; }
> > +#endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
> > +
> > +#endif /* __KVM_PTDUMP_H */
> > diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> > new file mode 100644
> > index 000000000000..a4e984da8aa7
> > --- /dev/null
> > +++ b/arch/arm64/kvm/ptdump.c
> > @@ -0,0 +1,79 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +//
> > +// Debug helper used to dump the stage-2 pagetables of the system and their
> > +// associated permissions.
> > +//
> > +// Copyright (C) Google, 2023
> > +// Author: Sebastian Ene <sebastianene@google.com>
> 
> Same comment as last time about ... the comment :)
> 
> Should be of the form
> 
> /*
>  *
>  */
> 

I forgot to update this, sorry. Let me fix it.

> > +#include <linux/debugfs.h>
> > +#include <linux/kvm_host.h>
> > +#include <linux/seq_file.h>
> > +
> > +#include <asm/kvm_pkvm.h>
> 
> is this needed?
>

We only need  <asm/kvm_pgtable.h> so I will update this.

> > +#include <kvm_ptdump.h>
> > +
> > +
> > +static int kvm_ptdump_guest_open(struct inode *inode, struct file *file);
> > +static int kvm_ptdump_guest_show(struct seq_file *m, void *);
> 
> can you structure the file in a way to avoid forward declarations?
> 

Sounds good, let me drop those.

> > +static const struct file_operations kvm_ptdump_guest_fops = {
> > +	.open		= kvm_ptdump_guest_open,
> > +	.read		= seq_read,
> > +	.llseek		= seq_lseek,
> > +	.release	= single_release,
> > +};
> > +
> > +static int kvm_ptdump_guest_open(struct inode *inode, struct file *file)
> > +{
> > +	return single_open(file, kvm_ptdump_guest_show, inode->i_private);
> > +}
> > +
> 
> Shouldn't we take a reference on the KVM struct at open to avoid UAF?
> 
> 	struct kvm *kvm = inode->i_private;
> 
> 	if (!kvm_get_kvm_safe(kvm))
> 		return -ENOENT;
> 
> Then you can do a put on it at close().
> 

Thanks, I though that the kvm_destroy_vm_debugfs will keep spinning if
there are opened paths to the debugfs entry, but I guess nothing prevents
that from happening and the kvm struct can be removed behind our back.

> > +static int kvm_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
> > +			      enum kvm_pgtable_walk_flags visit)
> > +{
> > +	struct pg_state *st = ctx->arg;
> > +	struct ptdump_state *pt_st = &st->ptdump;
> > +
> > +	note_page(pt_st, ctx->addr, ctx->level, ctx->old);
> > +	return 0;
> > +}
> > +
> > +static int kvm_ptdump_show_common(struct seq_file *m,
> > +				  struct kvm_pgtable *pgtable,
> > +				  struct pg_state *parser_state)
> > +{
> > +	struct kvm_pgtable_walker walker = (struct kvm_pgtable_walker) {
> > +		.cb     = kvm_ptdump_visitor,
> > +		.arg	= parser_state,
> > +		.flags	= KVM_PGTABLE_WALK_LEAF,
> > +	};
> > +
> > +	return kvm_pgtable_walk(pgtable, 0, BIT(pgtable->ia_bits), &walker);
> > +}
> > +
> > +static int kvm_ptdump_guest_show(struct seq_file *m, void *)
> > +{
> > +	struct kvm *guest_kvm = m->private;
> > +	struct kvm_s2_mmu *mmu = &guest_kvm->arch.mmu;
> > +	struct pg_state parser_state = {0};
> > +	int ret;
> > +
> > +	write_lock(&guest_kvm->mmu_lock);
> > +	ret = kvm_ptdump_show_common(m, mmu->pgt, &parser_state);
> > +	write_unlock(&guest_kvm->mmu_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +int kvm_ptdump_guest_register(struct kvm *kvm)
> > +{
> > +	struct dentry *parent;
> > +
> > +	parent = debugfs_create_file("stage2_page_tables", 0400,
> > +				     kvm->debugfs_dentry, kvm,
> > +				     &kvm_ptdump_guest_fops);
> > +	if (IS_ERR(parent))
> > +		return PTR_ERR(parent);
> 
> This makes the otherwise benign debugfs failure into something fatal for
> VM creation, no?
> 
> From the documentation on debugfs_create_file():
> 
>  * NOTE: it's expected that most callers should _ignore_ the errors returned
>  * by this function. Other debugfs functions handle the fact that the "dentry"
>  * passed to them could be an error and they don't crash in that case.
>  * Drivers should generally work fine even if debugfs fails to init anyway.
> 
> The fact that kvm_arch_create_vm_debugfs() has a return value is a bit
> of an anti-pattern to begin with.
>

Ack, I will ignore the retun code then.

> -- 
> Thanks,
> Oliver

Thanks,
Sebastian

