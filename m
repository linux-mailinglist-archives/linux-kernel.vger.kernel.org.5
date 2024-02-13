Return-Path: <linux-kernel+bounces-64490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75A0853F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA151C22767
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470DF629FF;
	Tue, 13 Feb 2024 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWtSMuw4"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF04626DB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864451; cv=none; b=jF4mcBYHPxSCTy8ELqgXcZEJEg2JcLv3G4evS2AIVUNoVvft3ju8VUo035pFNqVcVhHXdCKb+36QfESuqFrdNUD9ak9hpXmbm09/aBKCTwjjR5NfbxckEVe5iqMxKWscnAxW2ZvFN4RIXoTphQ/KK6EJFvaA8KmNhu9u82Dtbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864451; c=relaxed/simple;
	bh=h6roo4nzai1plnwUDMJ8X4JCHbJwwjdVH3mZ5DCnk7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fKVGU1E0p7P+ribHJFP9YVWWAKvDxTdnfZ/v1YcPZ5THwJUVjLY4IfqVQsPk95a6OSV+0N/C5+MwQAUkyhC14YMFUK7/YTErcwYOoccWC6LKBb1/5idhRiqgY89p9tzi+PqDT08REyCrQ2QfiWCcH+KePs3+qsFLAbIQ6xy8Oco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWtSMuw4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso8311029276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707864449; x=1708469249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YMLNcnuC5oAh9dkduNsu7ea1PmxDXxNMUX+9+b4QQbo=;
        b=pWtSMuw4ecLHQYXbJimVUZ/0qmWz9hjtvZ9VtEHx+T/NtYAnaDAraTYijL2reOKMRU
         hpxdC7GgOPGHR/oo82Up95IDvUMDbHJVXEX3fnGJl1P1+Tp76oj1EAK03E1zlo6jsAHf
         peqt/R+gZzaS+DUFy4ob1wVgXAkOQov0DV26pSF0eIR56zrRlF3OLIGXsUbjQ/Elm/iF
         LxwKNVaZrZqs+apZyxBm3DQHEkRNHrIpUuC+8bq8XaS67kVyGu8L7kFBPWEj0nOxUuvD
         6zfQNwptTSv+L5mn50r7EkWnZXu7Zv7MoJUoxTkmQtNu/H9P+4zUXonvQWrzpMx0OVZT
         aZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864449; x=1708469249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMLNcnuC5oAh9dkduNsu7ea1PmxDXxNMUX+9+b4QQbo=;
        b=g1aAU+NEv20zKw33V83p7gnLFkmLNhE63ZXUoNstJnb4UN8x+xp/k7bXlLWn3eS5iB
         u1yCeWbqp9i1T0Jy7z0zLxsqoKKIeC6Dgi3CP4XnYsavaUmvIZJeOFItmUfdRLSXqOrN
         rC7c1245+SSmvJTkxXM/n/PIyZPUSdKt1+Dhu/LtVNiKU/oKb+tGiL86DDeC/3imFHIp
         y8K1IQVG93IDs+IQFPr7TmduZ1PygjyOzyJG+en4/dQ0aE7lXb24i3MG1fVdxynfz97h
         PFf5BlIbIi27KlQvdwEcBibJwyvKxDIu+6ilH6k8SoVZSQZo8VvayoLClhJClq1ixGws
         MTXA==
X-Gm-Message-State: AOJu0YxuCDKLX2cTDPYseBa4B7R/HdVEOMi6OyJPJAfXrHRsr0a81vgc
	tUimS9CMivK47kUTUK6IZL5Yk2L1fuH/n/9qpHBtKFGYGdD7Scma6+UbEBvCaAcIzEzsefmj0oX
	YWg==
X-Google-Smtp-Source: AGHT+IF252kSBEQS48Y/ROryQIMgImMVNQDVJMPHGUyo6F8rUBPDvDjGb/zGZ5wS5MOW9teIbcz3suG4nk4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:150d:b0:dc6:e1ed:bd1a with SMTP id
 q13-20020a056902150d00b00dc6e1edbd1amr177506ybu.2.1707864448755; Tue, 13 Feb
 2024 14:47:28 -0800 (PST)
Date: Tue, 13 Feb 2024 14:47:27 -0800
In-Reply-To: <20240206182032.1596-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206182032.1596-1-xin3.li@intel.com>
Message-ID: <Zcvxf-fjYhsn_l1F@google.com>
Subject: Re: [PATCH v5 1/2] KVM: VMX: Cleanup VMX basic information defines
 and usages
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin3.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	weijiang.yang@intel.com, kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

Please send cover letters for series with more than one patch, even if there are
only two patches.  At the very least, cover letters are a convenient location to
provide feedback/communication for the series as a whole.  Instead, I need to
put it here:

I'll send a v6 with all of my suggestions incorporated.  I like the cleanups, but
there are too many process issues to fixup when applying, a few things that I
straight up disagree with, and more aggressive memtype related changes that can
be done in the context of this series.

On Tue, Feb 06, 2024, Xin Li wrote:
> Define VMX basic information fields with BIT_ULL()/GENMASK_ULL(), and
> replace hardcoded VMX basic numbers with these field macros.
> 
> Save the full/raw value of MSR_IA32_VMX_BASIC in the global vmcs_config
> as type u64 to get rid of the hi/lo crud, and then use VMX_BASIC helpers
> to extract info as needed.
> 
> VMX_EPTP_MT_{WB,UC} values 0x6 and 0x0 are generic x86 memory type
> values, no need to prefix them with VMX_EPTP_.

*sigh*

This obviously, like super duper obviously, should be at least three distinct
patches.  The changelog has three paragraphs that have *zero* relation to each
other, and the changelog doesn't even cover all of the opportunistic cleanups
that are being done.

> +/* x86 memory types, explicitly used in VMX only */
> +#define MEM_TYPE_WB				0x6ULL
> +#define MEM_TYPE_UC				0x0ULL

No, this is ridiculous.  These values are architectural, there's no reason for
KVM to have yet another copy.  The MTRRs #defines have goofy names, and are
incomplete, but it's trivial to move the enums from pat/memtype.c to msr-index.h.

> @@ -505,8 +521,6 @@ enum vmcs_field {
>  #define VMX_EPTP_PWL_5				0x20ull
>  #define VMX_EPTP_AD_ENABLE_BIT			(1ull << 6)
>  #define VMX_EPTP_MT_MASK			0x7ull
> -#define VMX_EPTP_MT_WB				0x6ull
> -#define VMX_EPTP_MT_UC				0x0ull

I would strongly prefer to keep the VMX_EPTP_MT_WB and VMX_EPTP_MT_UC defines,
at least so long as KVM is open coding reads and writes to the EPTP.  E.g. if
someone wants to do a follow-up series that adds wrappers to decode/encode the
memtype (and other fiels) from/to EPTP values, then I'd be fine dropping these.

But this:


	/* Check for memory type validity */
	switch (new_eptp & VMX_EPTP_MT_MASK) {
	case MEM_TYPE_UC:
		if (CC(!(vmx->nested.msrs.ept_caps & VMX_EPTP_UC_BIT)))
			return false;
		break;
	case MEM_TYPE_WB:
		if (CC(!(vmx->nested.msrs.ept_caps & VMX_EPTP_WB_BIT)))
			return false;
		break;
	default:
		return false;
	}

looks wrong and is actively confusing, especially when the code below it does:

	/* Page-walk levels validity. */
	switch (new_eptp & VMX_EPTP_PWL_MASK) {
	case VMX_EPTP_PWL_5:
		if (CC(!(vmx->nested.msrs.ept_caps & VMX_EPT_PAGE_WALK_5_BIT)))
			return false;
		break;
	case VMX_EPTP_PWL_4:
		if (CC(!(vmx->nested.msrs.ept_caps & VMX_EPT_PAGE_WALK_4_BIT)))
			return false;
		break;
	default:
		return false;
	}

>  static inline bool cpu_has_virtual_nmis(void)
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 994e014f8a50..80fea1875948 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -1226,23 +1226,29 @@ static bool is_bitwise_subset(u64 superset, u64 subset, u64 mask)
>  	return (superset | subset) == superset;
>  }
>  
> +#define VMX_BASIC_FEATURES_MASK			\
> +	(VMX_BASIC_DUAL_MONITOR_TREATMENT |	\
> +	 VMX_BASIC_INOUT |			\
> +	 VMX_BASIC_TRUE_CTLS)
> +
> +#define VMX_BASIC_RESERVED_BITS			\
> +	(GENMASK_ULL(63, 56) | GENMASK_ULL(47, 45) | BIT_ULL(31))

Looking at this with fresh eyes, I think #defines are overkill.  There is zero
chance anything other than vmx_restore_vmx_basic() will use these, and the feature
bits mask is rather weird.  It's not a mask of features that KVM supports, it's
a mask of feature *bits* that KVM knows about.

So rather than add #defines, I think we can keep "const u64" variables, but split
into feature_bits and reserved_bits (the latter will have open coded GENMASK_ULL()
usage, whereas the former will not).

BUILD_BUG_ON() is fancy enough that it can detect overlap.

> @@ -6994,6 +7000,9 @@ static void nested_vmx_setup_misc_data(struct vmcs_config *vmcs_conf,
>  	msrs->misc_high = 0;
>  }
>  
> +#define VMX_BSAIC_VMCS12_SIZE	((u64)VMCS12_SIZE << 32)

Typo.

> +#define VMX_BASIC_MEM_TYPE_WB	(MEM_TYPE_WB << 50)

I don't see any value in either of these.  In fact, I find them both to be far
more confusing, and much more likely to be incorrectly used.

Back in v1, when I said "don't bother with shift #defines", I was very specifically
talking about feature bits where defining the bit shift is an extra, pointless
layer.  I even (tried) to clarify that.

