Return-Path: <linux-kernel+bounces-30411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D58831E57
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB73A1C25FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF202CCA2;
	Thu, 18 Jan 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQD/jx0A"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02922C844
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598560; cv=none; b=oLyLrjgCZTTThXtG6KUdp1lXffOYGO71xsm6eu2kYA0yOeaqHpfBLzpyd9uJlrvGGZgbQ/LYQcORQ1ZX8IpPMx55c58f7sSQd2YHoEqKf+nPraDFzak9qwCQufVVxHPwdumoD6asr+owOv4K0lQnIohRfZjWJZbUXWD7p68fTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598560; c=relaxed/simple;
	bh=iltjkxDb/0xDzy61r2/TbtUzAI6MQI7RRvk4pFe4udA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 In-Reply-To:Mime-Version:References:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=jNqK1uBHADOwLuQgyalQ9HQ2trfYRqetsRcciJjNEhKWVNoLP3uDpDWsIgwOqP//mVZd6GMtNJoEe9eESq8TV7cQQ9u5pxwKY/sw/xM5slPmBWWtirNKbyOtg1pLaFd4mGlza4m0JKwYmYb0h+Najtsnt3PI0kUTQHTIW9qpGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQD/jx0A; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cf2714e392so900830a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705598559; x=1706203359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xm/DLf0OcCuLKlxlCaP549a+9gpOVuErhiD2mGiJHlQ=;
        b=gQD/jx0Aie9Tx5J4J1EH9EZm1ItntNmoTTo86f5aJHlFML2s+Iek3MK2bAJ3ahTrKR
         fKFa0mZ46GtQDs5mg/ck2O3KtlL1qCJEtevS9vZjVfAzcO+nOlYSN57ijLJ0j45b1eXr
         m4hVB7oszICG5ilcFkviEyn0Lf5jwIR8t9c/lcLafrHXZX5znEUKNom6aCN3XHihfcB0
         oav90tLCDfLEN+enSC5ccIjDulhgMzqgTZd67q3NEEooDfwR/j1wvdHHsGB9dAN+OcsJ
         3kKf73v6bEDc6SY0Z9QtLKoh7esp8KSQEAV+2BVgMIgGaabY2Kv2Dtku4qsHG18IRHxg
         mciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705598559; x=1706203359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xm/DLf0OcCuLKlxlCaP549a+9gpOVuErhiD2mGiJHlQ=;
        b=Ipr7yV3BiHkZmXnSdRuM1xU1WfZSV/vtMNLwy8Ec4mfDxWJPtvjclgMo4fKu8bvlXa
         UEmZmfcAYobvHH53nYTKCLrISdVXRkKWNEn0toRxR7RGdrFeAv6iAcUFtg1z8EGhF4Cb
         tz5v8S2zbA9sGwQuEmD5eoZynDs6uYaT4q9q+jW/2rS5eLjQjIkJKcbVgtKLK4tgIDT2
         7NhnNxx8N2UOTDqUD4lLU4/nY1muekzNXnsOivLCxXhRBeMv1+LOOpanAwpRKZX0Nj2g
         9ucGtKb1q39/g1doZwuJ4dVxhH4O835IXd0IKwKISnzkawsZWOwnzc5iKV0cj5P2BAbu
         noMg==
X-Gm-Message-State: AOJu0YxBGvuN7gb0RMSabmuAG503XtCRpQrwzwufe58BOhFkExpyt7fU
	azgikAM3UhmY061+oEfh29RvLsSJ64N8LNJHB9C5ONUADgHIYE6OS+MxtFGNhOcCr2J+Ee9+5Ji
	2NA==
X-Google-Smtp-Source: AGHT+IFj0K9PMfNUkyIXk2MoqpEsxlcU1BvtMNNHuZ0E9DjQoqOOnxEeyHeSACPYhxmxjY7LB8Kr8Vkm5As=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:5c03:0:b0:577:4619:a0a0 with SMTP id
 q3-20020a635c03000000b005774619a0a0mr22204pgb.6.1705598558913; Thu, 18 Jan
 2024 09:22:38 -0800 (PST)
Date: Thu, 18 Jan 2024 09:22:37 -0800
In-Reply-To: <ZalUDLVJSVN/rEf2@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240110012045.505046-1-seanjc@google.com> <ZalUDLVJSVN/rEf2@yilunxu-OptiPlex-7050>
Message-ID: <ZaleXWn7reOI5yJY@google.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Retry fault before acquiring mmu_lock if
 mapping is changing
From: Sean Christopherson <seanjc@google.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 19, 2024, Xu Yilun wrote:
> On Tue, Jan 09, 2024 at 05:20:45PM -0800, Sean Christopherson wrote:
> > Retry page faults without acquiring mmu_lock if the resolved gfn is covered
> > by an active invalidation.  Contending for mmu_lock is especially
> > problematic on preemptible kernels as the mmu_notifier invalidation task
> > will yield mmu_lock (see rwlock_needbreak()), delay the in-progress
> 
> Is it possible fault-in task avoids contending mmu_lock by using _trylock()?
> Like:
> 
> 	while (!read_trylock(&vcpu->kvm->mmu_lock))
> 		cpu_relax();
> 
> 	if (is_page_fault_stale(vcpu, fault))
> 		goto out_unlock;
>   
> 	r = kvm_tdp_mmu_map(vcpu, fault);
> 
> out_unlock:
> 	read_unlock(&vcpu->kvm->mmu_lock)

It's definitely possible, but the downsides far outweigh any potential benefits.

Doing trylock means the CPU is NOT put into the queue for acquiring the lock,
which means that forward progress isn't guaranteed.  E.g. in a pathological
scenario (and by "pathological", I mean if NUMA balancing or KSM is active ;-)),
it's entirely possible for a near-endless stream of mmu_lock writers to be in
the queue, thus preventing the vCPU from acquiring mmu_lock in a timely manner.

And hacking the page fault path to bypass KVM's lock contention detection would
be a very willful, deliberate violation of the intent of the MMU's yielding logic
for preemptible kernels.

That said, I would love to revisit KVM's use of rwlock_needbreak(), at least in
the TDP MMU.  As evidenced by this rash of issues, it's not at all obvious that
yielding on mmu_lock contention is *ever* a net positive for KVM, or even for the
kernel.  The shadow MMU is probably a different story since it can't parallelize
page faults with other operations, e.g. yielding in kvm_zap_obsolete_pages() to
allow vCPUs to make forward progress is probably a net positive.

But AFAIK, no one has done any testing to prove that yielding on contention in
the TDP MMU is actually a good thing.  I'm 99% certain the only reason the TDP
MMU yields on contention is because the shadow MMU yields on contention, i.e.
I'm confident that no one ever did performance testing to shadow that there is
any benefit whatsoever to yielding mmu_lock in the TDP MMU.

> > invalidation, and ultimately increase the latency of resolving the page
> > fault.  And in the worst case scenario, yielding will be accompanied by a
> > remote TLB flush, e.g. if the invalidation covers a large range of memory
> > and vCPUs are accessing addresses that were already zapped.
> 
> This case covers all usage of mmu_invalidate_retry_gfn(), is it? Should
> we also consider vmx_set_apic_access_page_addr()?

Nah, reloading the APIC access page is an very, very infrequent operation.  And
post-boot (of the VM), the page will only be reloaded if it's migrated by the
primary MMU, i.e. after a relevant mmu_notifier operation.  And the APIC access
page is a one-off allocation, i.e. it has its own VMA of PAGE_SIZE, so even if
vmx_set_apic_access_page_addr() does manage to trigger contention with a relevant
mmu_notifier event, e.g. races ahead of page migration completion, the odds of it
forcing KVM's mmu_notifier handler to yield mmu_lock are low (maybe impossible?)
because the invaldation event shouldn't be spanning multipl pages.

