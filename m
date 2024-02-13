Return-Path: <linux-kernel+bounces-62828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2558085269A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E91F22163
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C34565BA2;
	Tue, 13 Feb 2024 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bZtzy28t"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D5651AB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785801; cv=none; b=qwtw79nGuQcEqT5uOvZRfpLm59biayQsy1wRWo4AxExVRHBU5C2J3vQzDJXRPc6xUhVQfOzikARKiPv4j1wHbIhNOEFGj4CXkpgxyd8ZGo9bvKwU0MImeh4kkGLZxdfgmW21bJ2u4Y2e9vZ2dssima8Tt1LAIvXWDTQGZWPp9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785801; c=relaxed/simple;
	bh=cpXwYfa/s/OG0ffz6V/CvOkQmNg3H8ZvI1LfOLnOlZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbzvtYGPKujIwSWvsOMLLmojMOhhIAX4g5w/KrcPQI2jUGCrhjApsIGdeH/3teBHdGs3PCA8nve/CIYnTIsHuu/wfZGdJy2qmHLXDGchOo9HGnipI18cN5Upnnfs263PNokfWsqNyubTjYqksX5O6znM/CB6JmdWpFl97DG/oP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bZtzy28t; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 00:56:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707785792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxZyu7tPscjey5beeQmsSeREFcDJqNrkFYZl4eliD3U=;
	b=bZtzy28t7sioD5jzmg9WMbW0fB95PnG8PbDj0BcPYGUp2bCHLN3cvBkqqslyVFjfvgoXnn
	o4Gyz7e7PAWNWuonilJa4XWLJKPdgpm0N7t4C5wfHf+r9wINKHGubae1kKjan+p7gubo/t
	OkLkGtmBH/W47QRlNdTFXrzcH8dkl6o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, gshan@redhat.com, james.morse@arm.com,
	mark.rutland@arm.com, maz@kernel.org, rananta@google.com,
	ricarkol@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	vdonnefort@google.com
Subject: Re: [PATCH v5 3/4] KVM: arm64: Register ptdump with debugfs on guest
 creation
Message-ID: <Zcq-NGa-Gd9rVVgF@linux.dev>
References: <20240207144832.1017815-2-sebastianene@google.com>
 <20240207144832.1017815-5-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207144832.1017815-5-sebastianene@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 07, 2024 at 02:48:32PM +0000, Sebastian Ene wrote:
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
>  arch/arm64/kvm/debug.c      |  7 ++++
>  arch/arm64/kvm/kvm_ptdump.h | 20 ++++++++++
>  arch/arm64/kvm/ptdump.c     | 79 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 120 insertions(+)
>  create mode 100644 arch/arm64/kvm/kvm_ptdump.h
>  create mode 100644 arch/arm64/kvm/ptdump.c
> 
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 6c3c8ca73e7f..28097dd72174 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -68,4 +68,17 @@ config PROTECTED_NVHE_STACKTRACE
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
> index 8725291cb00a..aef52836cd90 100644
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
> @@ -342,3 +344,8 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>  }
> +
> +int kvm_arch_create_vm_debugfs(struct kvm *kvm)
> +{
> +	return kvm_ptdump_guest_register(kvm);
> +}
> diff --git a/arch/arm64/kvm/kvm_ptdump.h b/arch/arm64/kvm/kvm_ptdump.h
> new file mode 100644
> index 000000000000..a7c00a28481b
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
> +int kvm_ptdump_guest_register(struct kvm *kvm);
> +#else
> +static inline int kvm_ptdump_guest_register(struct kvm *kvm) { return 0; }
> +#endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
> +
> +#endif /* __KVM_PTDUMP_H */
> diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> new file mode 100644
> index 000000000000..a4e984da8aa7
> --- /dev/null
> +++ b/arch/arm64/kvm/ptdump.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Debug helper used to dump the stage-2 pagetables of the system and their
> +// associated permissions.
> +//
> +// Copyright (C) Google, 2023
> +// Author: Sebastian Ene <sebastianene@google.com>

Same comment as last time about ... the comment :)

Should be of the form

/*
 *
 */

> +#include <linux/debugfs.h>
> +#include <linux/kvm_host.h>
> +#include <linux/seq_file.h>
> +
> +#include <asm/kvm_pkvm.h>

is this needed?

> +#include <kvm_ptdump.h>
> +
> +
> +static int kvm_ptdump_guest_open(struct inode *inode, struct file *file);
> +static int kvm_ptdump_guest_show(struct seq_file *m, void *);

can you structure the file in a way to avoid forward declarations?

> +static const struct file_operations kvm_ptdump_guest_fops = {
> +	.open		= kvm_ptdump_guest_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int kvm_ptdump_guest_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, kvm_ptdump_guest_show, inode->i_private);
> +}
> +

Shouldn't we take a reference on the KVM struct at open to avoid UAF?

	struct kvm *kvm = inode->i_private;

	if (!kvm_get_kvm_safe(kvm))
		return -ENOENT;

Then you can do a put on it at close().

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
> +{
> +	struct kvm *guest_kvm = m->private;
> +	struct kvm_s2_mmu *mmu = &guest_kvm->arch.mmu;
> +	struct pg_state parser_state = {0};
> +	int ret;
> +
> +	write_lock(&guest_kvm->mmu_lock);
> +	ret = kvm_ptdump_show_common(m, mmu->pgt, &parser_state);
> +	write_unlock(&guest_kvm->mmu_lock);
> +
> +	return ret;
> +}
> +
> +int kvm_ptdump_guest_register(struct kvm *kvm)
> +{
> +	struct dentry *parent;
> +
> +	parent = debugfs_create_file("stage2_page_tables", 0400,
> +				     kvm->debugfs_dentry, kvm,
> +				     &kvm_ptdump_guest_fops);
> +	if (IS_ERR(parent))
> +		return PTR_ERR(parent);

This makes the otherwise benign debugfs failure into something fatal for
VM creation, no?

From the documentation on debugfs_create_file():

 * NOTE: it's expected that most callers should _ignore_ the errors returned
 * by this function. Other debugfs functions handle the fact that the "dentry"
 * passed to them could be an error and they don't crash in that case.
 * Drivers should generally work fine even if debugfs fails to init anyway.

The fact that kvm_arch_create_vm_debugfs() has a return value is a bit
of an anti-pattern to begin with.

-- 
Thanks,
Oliver

