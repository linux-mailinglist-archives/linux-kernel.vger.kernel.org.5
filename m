Return-Path: <linux-kernel+bounces-8902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A761A81BDF5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2DD283F16
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF2863504;
	Thu, 21 Dec 2023 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="as0Ierba"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EDE634F5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Dec 2023 18:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703182465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aup1y7DMypb5wPtcvwloevUDTj0Q9j+BJY8D6Z+NijM=;
	b=as0IerbasBR/dZTFoOiCqg7ve4xqsh2t0qP46njjzYZ5anYkz4I53EyK5yrZ65gvXkLG8l
	Qsppl/r8B7BRLiAW5ZDQdOjRkLXVwrfgjH5TSQ/O2PUPLGQYg8oc/0G3yiL9DstFvGKLIa
	Xgfr0FgAPAFwRjen+HVwg1K/91IWx/0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ene <sebastianene@google.com>
Cc: will@kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
	mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	vdonnefort@google.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v4 02/10] KVM: arm64: Add ptdump registration with
 debugfs for the stage-2 pagetables
Message-ID: <ZYSAfORj2-cXo5t_@linux.dev>
References: <20231218135859.2513568-2-sebastianene@google.com>
 <20231218135859.2513568-4-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218135859.2513568-4-sebastianene@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 18, 2023 at 01:58:52PM +0000, Sebastian Ene wrote:
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

It isn't really a good idea to mount debugfs at all in a production
system. There are already plenty worse interfaces lurking in that
filesystem. The pKVM portions already depend on CONFIG_NVHE_EL2_DEBUG,
so I don't see a need for this Kconfig option.

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e5f75f1f1..ee8d7cb67 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -40,6 +40,7 @@
>  #include <asm/kvm_pkvm.h>
>  #include <asm/kvm_emulate.h>
>  #include <asm/sections.h>
> +#include <kvm_ptdump.h>
>  
>  #include <kvm/arm_hypercalls.h>
>  #include <kvm/arm_pmu.h>
> @@ -2592,6 +2593,7 @@ static __init int kvm_arm_init(void)
>  	if (err)
>  		goto out_subs;
>  
> +	kvm_ptdump_register_host();
>  	kvm_arm_initialised = true;
>  
>  	return 0;
> diff --git a/arch/arm64/kvm/kvm_ptdump.h b/arch/arm64/kvm/kvm_ptdump.h
> new file mode 100644
> index 000000000..98b595ce8
> --- /dev/null
> +++ b/arch/arm64/kvm/kvm_ptdump.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +//
> +// Copyright (C) Google, 2023
> +// Author: Sebastian Ene <sebastianene@google.com>

You've got the comment styles backwards for these. The SPDX license uses
the 'C++' style comment (//), whereas your multiline comment should always
use a 'C' style comment (/* */).

> +struct kvm_ptdump_register {
> +	void *(*get_ptdump_info)(struct kvm_ptdump_register *reg);
> +	void (*put_ptdump_info)(void *priv);
> +	int (*show_ptdump_info)(struct seq_file *m, void *v);
> +	void *priv;
> +};

Please thoroughly consider the necessity of this. You're wrapping a
callback structure with yet another callback structure. IMO, it would
make a lot more sense to implement the file ops structure for every
walker variant you need and avoid the indirection, it's hard to
understand.

> +void kvm_ptdump_register_host(void)
> +{
> +	if (!is_protected_kvm_enabled())
> +		return;
> +
> +	kvm_ptdump_debugfs_register(&host_reg, "host_page_tables",
> +				    kvm_debugfs_dir);
> +}
> +
> +static int __init kvm_host_ptdump_init(void)
> +{
> +	host_reg.priv = (void *)host_s2_pgtable_pages();
> +	return 0;
> +}
> +
> +device_initcall(kvm_host_ptdump_init);

Why can't all of this be called from finalize_pkvm()?

> -- 
> 2.43.0.472.g3155946c3a-goog
> 

-- 
Thanks,
Oliver

