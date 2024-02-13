Return-Path: <linux-kernel+bounces-63954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5958536B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38AB21F26754
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E205FBA2;
	Tue, 13 Feb 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vEiqSeTz"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76264B65E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843547; cv=none; b=DKbs2Yj7eTtEChHvEC0lYL9tmOlA4bXVddygcru0zSUiV+mHzOt9enGKvy5IlA1AG1/JP5cP30hg9tJm8O9SAkab8fYZvm9opnkHnbJtSUla3lFV7soIcnmCGjroXmzPbgXhpICvLxrze6fMWLxj2DEFpHk2IILDTcYgwBs91ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843547; c=relaxed/simple;
	bh=i0Gnk8WjglIEP3k3txEC2+8M76N/IEkGhhy+lMVjaGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8fovCfGxy1lxAMyU5ZFu57A8MrLA0XPajJeHixlT7bWFbC78ubNObqQd0SunBBTq0KJ1uUMzm0Oxq5bFgbiO14Y+i285FcDGlAURcxhNZJ1uTvMxqSU0Nt8zeTZb07vkz0Twsz/tz0xk2s+jSGojnEHREElbH68BOyXUW97Beo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vEiqSeTz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-410acf9e776so65045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707843544; x=1708448344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjHgRqK53+Z/Iq+FMNbpTXTAGux6p7HXMqS53v9U+74=;
        b=vEiqSeTzaDMA32ZPQEMFrxyoJJcpBmIybGfdsYqMUgSDLX+LcPX6eUDjHCN2BKcErx
         uPqSf5eEEpgh4Io9le7eLgN2jZgd6Y8sJ0bjutOJ/ag1pPRoJ48pCSHblktV3pU+o+0H
         xxy6/KPFIl4jmf7D//uOueeAiFWBUsPQmwYkl44DXsH2GNxOheJ2wbMPP2HJ6cAooJM8
         3BnRyQsl6kKgv2/WXp8B/QwKRLkjRTe7k/LdIiwIAuuH64fxlm4PRh+cZfx5fRyWAgHG
         Iklan8gbEY4ALrXXRI4yh7hHqPNvVm8jteEhQbvVGgjVVUnnPHH924WHKwzqCBu8zXbs
         0NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707843544; x=1708448344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjHgRqK53+Z/Iq+FMNbpTXTAGux6p7HXMqS53v9U+74=;
        b=rYpEedVeqNV9okeBcsnIrlZ96rE82JkjIDd7+J8NCIrmRTT3wSMhoIfOcwqC/x36X8
         XjQA9I05P79TN2v1l+LdpgFkB3C/Yv9t1ihF67ekp9adEn6Hi86CMzyN95QWEm6OQH3X
         sGq0Q5dfSoaV7m0mzXgcmMlWwQnvCNzg42YwqelCTcdNv5ow8AO+yglfffQPu8jbv/lZ
         mqu6i3VEDH/ki+MHS2yi1K0gSgMq0gGkXQy539HFfX+vKIAl5MI5yYMEF0AgyiRhnHQZ
         ZvOlSbXFzB4w6u0FU7jRfth0nD0NayOtIT9NLaVuFTFtyzneigPz8APgqHWzSe8+6JzO
         oYqg==
X-Forwarded-Encrypted: i=1; AJvYcCUw/pbWE5GqnevoDgJPFemep5XMLJ1Zlt2/I6m3Q4NW9SfSXja7UiZcEgXqgQuJ2G88WZXnDeMq1UxSRfrb6ep9GhvYWW1JUmwTt7rq
X-Gm-Message-State: AOJu0YzoX2kjJ9zMIw+I/KhL9Q3eFPayjNam3BCoIKc9ZgJFlnHqM9oO
	pbPPjhcje3NSb3J+Wf4tKqzanqDyA2qWyx407IV9hHR9WN/ntLzNaprlkQHQzg==
X-Google-Smtp-Source: AGHT+IGlCgeYc2G5NMvG/5KdHodX0ldfX5951gwHVabcierGBfqA2oBgQ+km8E7JEFS3ZUPtuyGqzw==
X-Received: by 2002:a05:600c:4e06:b0:411:cf85:9549 with SMTP id b6-20020a05600c4e0600b00411cf859549mr17305wmq.3.1707843543608;
        Tue, 13 Feb 2024 08:59:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVgfBUBIeSfy/VTDfV7wJPSK+x9usF7TNREp66vg4zts9aON/TukvLypDt0PHHfe4amRnfxAR/udmtPFy+ZNo2kTjA/tHJ0BjcgzUq7dPE8mHk1yhjEUGq+5d70PeP91QhOLuzDgPjBiNgMTbfzvLTZrSoZB/zRQHkZxD0Jc9lrpesh2VEB2FFONgkmhOtOO3szgDEUvxKmQmnxE6Ut+HbnKlHEhgI0jewZtgXskMFp0BX3qVx/suLIK2STrqDtCzGu+VpHwG2krKu/oK13lHKhk+e5mECf28aTv/EpoSFcumE/fcAGzG+78+6DF5UWpu3NC/Bi6kXXvvo3nCYjVr7m/Q0ZffRJdRYG2OeyWVUnzIu5R8d+uMD4PhwzqIJNkqb7Ycylzobz+uji49yiVnzYoIQgin8BF5eY7aMZTHKjn/RvR6kL4ufGIyRGZCjoiuO50s+TUTrmBsxNfMin3O2hkdZp2MZHJ0wnAYJLYnsYWdjnDHRAMrAi1Q1Fp7UT6ZVuWhdAM3MhreQaZkg0lsRxGA4W9aYywhj4Q==
Received: from google.com (161.126.77.34.bc.googleusercontent.com. [34.77.126.161])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c4f4e00b00411bff9f7cbsm2296147wmq.37.2024.02.13.08.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 08:59:03 -0800 (PST)
Date: Tue, 13 Feb 2024 16:59:01 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: catalin.marinas@arm.com, gshan@redhat.com, james.morse@arm.com,
	mark.rutland@arm.com, maz@kernel.org, rananta@google.com,
	ricarkol@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	vdonnefort@google.com
Subject: Re: [PATCH v5 4/4] KVM: arm64: Initialize the ptdump parser with
 stage-2 attributes
Message-ID: <Zcuf1ZUvwhxBobuG@google.com>
References: <20240207144832.1017815-2-sebastianene@google.com>
 <20240207144832.1017815-6-sebastianene@google.com>
 <Zcq7AoII8qLWwjsu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcq7AoII8qLWwjsu@linux.dev>

On Tue, Feb 13, 2024 at 12:42:42AM +0000, Oliver Upton wrote:
> On Wed, Feb 07, 2024 at 02:48:33PM +0000, Sebastian Ene wrote:
> > Define a set of attributes used by the ptdump parser to display the
> > properties of a guest memory region covered by a pagetable descriptor.
> > Build a description of the pagetable levels and initialize the parser
> > with this configuration.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/kvm/ptdump.c | 156 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 156 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> > index a4e984da8aa7..60725d46f17b 100644
> > --- a/arch/arm64/kvm/ptdump.c
> > +++ b/arch/arm64/kvm/ptdump.c
> > @@ -14,6 +14,69 @@
> >  #include <kvm_ptdump.h>
> >  
> >  
> > +#define ADDR_MARKER_LEN		(2)
> > +#define MARKER_MSG_LEN		(32)
> > +
> > +static const struct prot_bits stage2_pte_bits[] = {
> > +	{
> > +		.mask	= PTE_VALID,
> > +		.val	= PTE_VALID,
> > +		.set	= " ",
> > +		.clear	= "F",
> > +	}, {
> > +		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> > +		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> > +		.set	= "XN",
> > +		.clear	= "  ",
> > +	}, {
> > +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> > +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> > +		.set	= "R",
> > +		.clear	= " ",
> > +	}, {
> > +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
> > +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
> > +		.set	= "W",
> > +		.clear	= " ",
> > +	}, {
> > +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> > +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> > +		.set	= "AF",
> > +		.clear	= "  ",
> > +	}, {
> > +		.mask	= PTE_NG,
> > +		.val	= PTE_NG,
> > +		.set	= "FnXS",
> > +		.clear	= "  ",
> > +	}, {
> > +		.mask	= PTE_CONT | PTE_VALID,
> > +		.val	= PTE_CONT | PTE_VALID,
> > +		.set	= "CON",
> > +		.clear	= "   ",
> > +	}, {
> > +		.mask	= PTE_TABLE_BIT,
> > +		.val	= PTE_TABLE_BIT,
> > +		.set	= "   ",
> > +		.clear	= "BLK",
> 
> <snip>
> 
> > +	}, {
> > +		.mask	= KVM_PGTABLE_PROT_SW0,
> > +		.val	= KVM_PGTABLE_PROT_SW0,
> > +		.set	= "SW0", /* PKVM_PAGE_SHARED_OWNED */
> > +	}, {
> > +		.mask   = KVM_PGTABLE_PROT_SW1,
> > +		.val	= KVM_PGTABLE_PROT_SW1,
> > +		.set	= "SW1", /* PKVM_PAGE_SHARED_BORROWED */
> > +	}, {
> > +		.mask	= KVM_PGTABLE_PROT_SW2,
> > +		.val	= KVM_PGTABLE_PROT_SW2,
> > +		.set	= "SW2",
> > +	}, {
> > +		.mask   = KVM_PGTABLE_PROT_SW3,
> > +		.val	= KVM_PGTABLE_PROT_SW3,
> > +		.set	= "SW3",
> > +	},
> 
> </snip>
> 
> These bits are never set in a 'normal' stage-2 PTE, does it make sense
> to carry descriptors for them here? In contexts where the SW bits are
> used it might be more useful if the ptdump used the specific meaning of
> the bit (e.g. OWNED, BORROWED, etc) instead of the generic SW%d.
> 
> That can all wait for when the pKVM bits come into play though.
> 

True, I guess we don't need these bits for now. We can insert them at a
later time when we will have the pKVM support and then we will have to
use their real maning for the state tracking.

> > +};
> > +
> >  static int kvm_ptdump_guest_open(struct inode *inode, struct file *file);
> >  static int kvm_ptdump_guest_show(struct seq_file *m, void *);
> >  
> > @@ -52,6 +115,94 @@ static int kvm_ptdump_show_common(struct seq_file *m,
> >  	return kvm_pgtable_walk(pgtable, 0, BIT(pgtable->ia_bits), &walker);
> >  }
> >  
> > +static void kvm_ptdump_build_levels(struct pg_level *level, u32 start_lvl)
> > +{
> > +	static const char * const level_names[] = {"PGD", "PUD", "PMD", "PTE"};
> > +	u32 i = 0;
> > +	u64 mask_lvl = 0;
> 
> nit: _lvl adds nothing to this, and actually confused me for a sec as
> to whether the mask changed per level.
> 

I will drop it from the name to avoid the confusion.

> > +	if (start_lvl > 2) {
> > +		pr_err("invalid start_lvl %u\n", start_lvl);
> > +		return;
> > +	}
> 
> Can't we get something like -EINVAL out here and fail initialization?
> Otherwise breadcrumbs like this pr_err() are hard to connect to a
> specific failure.
>

Ok, I will add a return code for this function.

> > +	for (i = 0; i < ARRAY_SIZE(stage2_pte_bits); i++)
> > +		mask_lvl |= stage2_pte_bits[i].mask;
> > +
> > +	for (i = start_lvl; i <= KVM_PGTABLE_LAST_LEVEL; i++) {
> > +		level[i].name = level_names[i];
> > +		level[i].num = ARRAY_SIZE(stage2_pte_bits);
> > +		level[i].bits = stage2_pte_bits;
> > +		level[i].mask = mask_lvl;
> > +	}
> > +
> > +	if (start_lvl > 0)
> > +		level[start_lvl].name = level_names[0];
> > +}
> > +
> > +static int kvm_ptdump_parser_init(struct pg_state *st,
> > +				  struct kvm_pgtable *pgtable,
> > +				  struct seq_file *m)
> > +{
> > +	struct addr_marker *ipa_addr_marker;
> > +	char *marker_msg;
> > +	struct pg_level *level_descr;
> > +	struct ptdump_range *range;
> > +
> > +	ipa_addr_marker = kzalloc(sizeof(struct addr_marker) * ADDR_MARKER_LEN,
> > +				  GFP_KERNEL_ACCOUNT);
> > +	if (!ipa_addr_marker)
> > +		return -ENOMEM;
> > +
> > +	marker_msg = kzalloc(MARKER_MSG_LEN, GFP_KERNEL_ACCOUNT);
> > +	if (!marker_msg)
> > +		goto free_with_marker;
> > +
> > +	level_descr = kzalloc(sizeof(struct pg_level) * (KVM_PGTABLE_LAST_LEVEL + 1),
> > +			      GFP_KERNEL_ACCOUNT);
> > +	if (!level_descr)
> > +		goto free_with_msg;
> > +
> > +	range = kzalloc(sizeof(struct ptdump_range) * ADDR_MARKER_LEN,
> > +			GFP_KERNEL_ACCOUNT);
> > +	if (!range)
> > +		goto free_with_level;
> > +
> > +	kvm_ptdump_build_levels(level_descr, pgtable->start_level);
> > +
> > +	snprintf(marker_msg, MARKER_MSG_LEN, "IPA bits %2u start lvl %1d",
> > +		 pgtable->ia_bits, pgtable->start_level);
> > +
> > +	ipa_addr_marker[0].name = marker_msg;
> 
> Is the dynamic name worth the added complexity? I see nothing wrong with
> exposing additional debugfs files for simple attributes like the IPA
> range and page table levels.
> 
> I know it isn't *that* much, just looking for every opportunity to
> simplify further.
> 

We can keep them separate, I have no strong opinion about this. I think
this was Vincent's, original suggestion to have them so I will check with
him as well.

> > +	ipa_addr_marker[1].start_address = BIT(pgtable->ia_bits);
> > +	range[0].end = BIT(pgtable->ia_bits);
> > +
> > +	st->seq = m;
> > +	st->marker = ipa_addr_marker;
> > +	st->level = -1,
> > +	st->pg_level = level_descr,
> > +	st->ptdump.range = range;
> > +	return 0;
> > +
> > +free_with_level:
> > +	kfree(level_descr);
> > +free_with_msg:
> > +	kfree(marker_msg);
> > +free_with_marker:
> > +	kfree(ipa_addr_marker);
> > +	return -ENOMEM;
> > +}
> > +
> > +static void kvm_ptdump_parser_teardown(struct pg_state *st)
> > +{
> > +	const struct addr_marker *ipa_addr_marker = st->marker;
> > +
> > +	kfree(ipa_addr_marker[0].name);
> > +	kfree(ipa_addr_marker);
> > +	kfree(st->pg_level);
> > +	kfree(st->ptdump.range);
> > +}
> > +
> >  static int kvm_ptdump_guest_show(struct seq_file *m, void *)
> >  {
> >  	struct kvm *guest_kvm = m->private;
> > @@ -59,10 +210,15 @@ static int kvm_ptdump_guest_show(struct seq_file *m, void *)
> >  	struct pg_state parser_state = {0};
> >  	int ret;
> >  
> > +	ret = kvm_ptdump_parser_init(&parser_state, mmu->pgt, m);
> > +	if (ret)
> > +		return ret;
> > +
> 
> Can this be done at open(), or am I missing something?
> 

I guess we can do this in open() but then we will have to add again that
struct that wraps some ptdump specific state tracking. It seemed a bit cleaner in
this way. What do you think ?

> >  	write_lock(&guest_kvm->mmu_lock);
> >  	ret = kvm_ptdump_show_common(m, mmu->pgt, &parser_state);
> >  	write_unlock(&guest_kvm->mmu_lock);
> >  
> > +	kvm_ptdump_parser_teardown(&parser_state);
> 
> Same question here, can this happen at close()? I guess you'll need a
> struct to encapsulate pg_state and a pointer to the VM at least.
>

Right, I tried to avoid using a separate struct as we discussed in v4.

> Actually, come to think of it, if you embed all of the data you need for
> the walker into a structure you can just do a single allocation for it
> upfront.
> 
> -- 
> Thanks,
> Oliver

Thanks for the feedback,
Seb

