Return-Path: <linux-kernel+bounces-84331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECEC86A4FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F750283B58
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F7A6125;
	Wed, 28 Feb 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EsqJO86J"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422E4C90
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083506; cv=none; b=nL6NX/KFhYNQIJBvn+DojeKfCjjw7AoEu6IKfP4sWSO+ETP285ByrOIC+WKuCjACfd6A0KiZiPmUrjvoGectp575F53qW9vIPyGuOtr8nmpBScqcruWl3ziXc/wqleXDdM4Eu7XJQUVS71oYfH1yifRbJysu6IV9R7I689oUd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083506; c=relaxed/simple;
	bh=P+T2/KdNaUMzvOhMbpBjdj+yxpY1Uqw4mbrFFrWAyPY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KnjJgl7MK6iHhoX8v/hIxTPZXlPJ2YQGhG/3aYuQQaO8fFKumFbXfww0S4XGC2mMV6maCHdGaQsKLEjWwlTxLuIPGs4Ipono5k3rHkrzMjNjgOfvwEWKapzmENfK1+IXWdZlxEpJaaoVn6omirXTjTC6BSl4N1Ae5gKcwCRkOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EsqJO86J; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so6962145276.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709083501; x=1709688301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D36nrH8uCCWoLOXqhvxDMO2liC+swKIKBKli/KC6bpI=;
        b=EsqJO86JkxHEOqzrCHraUyQi7s+diPlu6andWZ6SNsKjFTBzkiA7nGOGFe8VQO+YVb
         TpeND4hpnFPdiJa/h1PZ1/R+ZRKtfvZZU0C2NePG52e4c9cn1t67ufpbETpuhrvULd/k
         /ndcK+SS1To7XL9V7KHmKAayoooLtvqmXvuUwx2h3Riobzq8spTJYCXYx6mRf2GzFQQK
         xNZFbzhLCGQFM3q62mbGXAjJRtzBFixnwgbY25Rjd5awF+STKPa5LhdHxNAETavMEwN8
         FKPDbtURAHyHqSeXlTDy73DGYC2iLlypPfT2h/dO/JviGaz+ooCX0CnO1S9n8+Z99Ob2
         5TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709083501; x=1709688301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D36nrH8uCCWoLOXqhvxDMO2liC+swKIKBKli/KC6bpI=;
        b=eWP3WhtAWmZ4eRDiluj9PwxDwMyHiLlkIlqTFG+EiU7YsAEjepz22o/RW5fXbnek67
         BJR4bT6nhxp4umOBfP5W1groCR5KkgvuP6pt6HmwF3xSF4nwDqytU3mIMgA96o9+i7/n
         onfQCV+nPlLlyiwfqSGyEm3RRvsDYeROnRqTgmwoIXzss2MBJJvhz6jpmjVqu0cZtlA/
         jB+cxNeDjSO6HBRjGf619esMviTdyydnOMgh9j7NVWmz5/X16GQONcCMJq6m/39ZAhdp
         nZfMs9MxnNPY2g7cHSdCOy6zeHrE/+6pm0wzmAAVkN351x/3QiB3oMnDN+2eZBQnLDhD
         Z2+g==
X-Gm-Message-State: AOJu0YwtSl4Y4/7UlMOv5JL5Zt1He6yMeIpl7/hJMtb/yH9DLDaPwXBG
	ZhA+XcYUJOBHqaY2IpeGUGKxWY8vqQqiRI4rSVO3S38HGr6cYIdKKse4ghLLOn+StnugFzAc9j0
	mcw==
X-Google-Smtp-Source: AGHT+IEbMfRi16vIeowLxCKjG+0LzWZVW5MRCjpDdyceKp59dVxqF8NnYWi8Az9JG6pue+0KnE8kDAQAvmM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1001:b0:dcd:b593:6503 with SMTP id
 w1-20020a056902100100b00dcdb5936503mr98978ybt.2.1709083501195; Tue, 27 Feb
 2024 17:25:01 -0800 (PST)
Date: Tue, 27 Feb 2024 17:24:59 -0800
In-Reply-To: <20240227232100.478238-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227232100.478238-1-pbonzini@redhat.com>
Message-ID: <Zd6LK7RpZZ8t-5CY@google.com>
Subject: Re: [PATCH 00/21] TDX/SNP part 1 of n, for 6.9
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com, thomas.lendacky@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 27, 2024, Paolo Bonzini wrote:
> This is a first set of, hopefully non-controversial patches from the

Heh, you jinxed yourself.  :-)

> SNP and TDX series.  They cover mostly changes to generic code and new
> gmem APIs, and in general have already been reviewed when posted by
> Isaku and Michael.
> 
> One important change is that the gmem hook for initializing memory
> is designed to return -EEXIST if the page already exists in the
> guestmemfd filemap.  The idea is that the special case of
> KVM_SEV_SNP_LAUNCH_UPDATE, where __kvm_gmem_get_pfn() is used to
> return an uninitialized page and make it guest-owned, can be be done at
> most once per page unless the ioctl fails.
> 
> Of course these patches add a bunch of dead code.  This is intentional
> because it's the only way to trim the large TDX (and to some extent SNP)
> series to the point that it's possible to discuss them.  The next step is
> probably going to be the private<->shared page logic from the TDX series.
> 
> Paolo
> 
> Isaku Yamahata (5):
>   KVM: x86/mmu: Add Suppress VE bit to EPT
>     shadow_mmio_mask/shadow_present_mask
>   KVM: VMX: Introduce test mode related to EPT violation VE
>   KVM: x86/tdp_mmu: Init role member of struct kvm_mmu_page at
>     allocation
>   KVM: x86/tdp_mmu: Sprinkle __must_check
>   KVM: x86/mmu: Pass around full 64-bit error code for KVM page faults

I have a slight tweak to this patch (drop truncation), and a rewritten changelog.
 
> Michael Roth (2):
>   KVM: x86: Add gmem hook for invalidating memory
>   KVM: x86: Add gmem hook for determining max NPT mapping level
> 
> Paolo Bonzini (6):
>   KVM: x86/mmu: pass error code back to MMU when async pf is ready
>   KVM: x86/mmu: Use PFERR_GUEST_ENC_MASK to indicate fault is private

This doesn't work.  The ENC flag gets set on any SNP *capable* CPU, which results
in false positives for SEV and SEV-ES guests[*].

I have a medium-sized series to add a KVM-defined synthetic flag, and clean up
the related code (it also has my slight variation on the 64-bit error code patch).

I'll post my series exactly as I have it, mostly so that I don't need to redo
testing, but also because it's pretty much a drop-in replacement.  This series
applies cleanly on top, except for the two obvious conflicts.

[*] https://lore.kernel.org/all/Zdar_PrV4rzHpcGc@google.com

>   KVM: guest_memfd: pass error up from filemap_grab_folio
>   filemap: add FGP_CREAT_ONLY
>   KVM: x86: Add gmem hook for initializing memory
>   KVM: guest_memfd: add API to undo kvm_gmem_get_uninit_pfn
> 
> Sean Christopherson (7):
>   KVM: x86: Split core of hypercall emulation to helper function
>   KVM: Allow page-sized MMU caches to be initialized with custom 64-bit
>     values
>   KVM: x86/mmu: Replace hardcoded value 0 for the initial value for SPTE
>   KVM: x86/mmu: Track shadow MMIO value on a per-VM basis
>   KVM: x86/mmu: Allow non-zero value for non-present SPTE and removed
>     SPTE
>   KVM: VMX: Move out vmx_x86_ops to 'main.c' to wrap VMX and TDX
>   KVM: VMX: Modify NMI and INTR handlers to take intr_info as function
>     argument
> 
> Tom Lendacky (1):
>   KVM: SEV: Use a VMSA physical address variable for populating VMCB
> 
>  arch/x86/include/asm/kvm-x86-ops.h |   3 +
>  arch/x86/include/asm/kvm_host.h    |  12 +
>  arch/x86/include/asm/vmx.h         |  13 +
>  arch/x86/kvm/Makefile              |   2 +-
>  arch/x86/kvm/mmu.h                 |   1 +
>  arch/x86/kvm/mmu/mmu.c             |  55 ++--
>  arch/x86/kvm/mmu/mmu_internal.h    |   6 +-
>  arch/x86/kvm/mmu/mmutrace.h        |   2 +-
>  arch/x86/kvm/mmu/paging_tmpl.h     |   4 +-
>  arch/x86/kvm/mmu/spte.c            |  16 +-
>  arch/x86/kvm/mmu/spte.h            |  21 +-
>  arch/x86/kvm/mmu/tdp_iter.h        |  12 +
>  arch/x86/kvm/mmu/tdp_mmu.c         |  74 +++--
>  arch/x86/kvm/svm/sev.c             |   3 +-
>  arch/x86/kvm/svm/svm.c             |   9 +-
>  arch/x86/kvm/svm/svm.h             |   1 +
>  arch/x86/kvm/vmx/main.c            | 168 +++++++++++
>  arch/x86/kvm/vmx/vmcs.h            |   5 +
>  arch/x86/kvm/vmx/vmx.c             | 460 +++++++++++------------------
>  arch/x86/kvm/vmx/vmx.h             |   6 +-
>  arch/x86/kvm/vmx/x86_ops.h         | 124 ++++++++
>  arch/x86/kvm/x86.c                 |  69 +++--
>  include/linux/kvm_host.h           |  25 ++
>  include/linux/kvm_types.h          |   1 +
>  include/linux/pagemap.h            |   2 +
>  mm/filemap.c                       |   4 +
>  virt/kvm/Kconfig                   |   8 +
>  virt/kvm/guest_memfd.c             | 120 +++++++-
>  virt/kvm/kvm_main.c                |  16 +-
>  29 files changed, 855 insertions(+), 387 deletions(-)
>  create mode 100644 arch/x86/kvm/vmx/main.c
>  create mode 100644 arch/x86/kvm/vmx/x86_ops.h
> 
> -- 
> 2.39.0
> 

