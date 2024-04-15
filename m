Return-Path: <linux-kernel+bounces-145623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB928A58AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FC51F217E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8879286630;
	Mon, 15 Apr 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kdQBDfA1"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7660283CCC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200634; cv=none; b=XMpHcmox3fiHhziYF77ZiR5VTa5s9UBVNxJ6wlQS9DQs21cee201y89UVUHXUo9MlbSz4zqVSfWRRZ3psftv0FTD9LL9p3/OpzwX9qdXSWRMJkaeNuphjJI7TRRcltCZxp4ShCEzdSb4wFtphQnt9f+pMzkkfeWEXnaQcrAu4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200634; c=relaxed/simple;
	bh=irgloZCVTvzuDkYp0ohKwo1sf7N8wth+rz+R9T7PAmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IU4rX+ZcPdFI6+ObL/rXQyvH47gJYrvhOQWMJjCYEPmunIGM1Px8ZaLla7FlP6FCDRXZdlhR82FlrVOjOfwKjFzL7mH9SglaUnlJvsPwQc6OilWMzgCmgDl/0NEmj9KtasMEVAoBDtv5s5PkLTWzBiaIvQLXV3VWZNUMd7YI5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kdQBDfA1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f00a42c5bbso478312b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713200633; x=1713805433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfqt/NgDwjKFxB5AgyRPdEKVaYoxBURY78UkNYsrqoM=;
        b=kdQBDfA1YoD5eV5hZLFaW6lCUFn8xarhRyy1/AEzHDIaJElIy6gvxKCvJ8JNCXu6ei
         Kj7wNPfr4plDTbXyJ7g/lwiAKSWlxTV0on0Ad15kCXiS5NPPeZ1TeSdBA54D7k46L7FK
         lTUh8sJKVLevWb6+6gVYBAIhJ9D0mWkb5RUCsiiEdKMXRvOlMe6sjdq2bGwAjk12Cjju
         aTJwMH5Etf8T1lL3LK6m3+uevFPoTAQ/03BifcaNIWh4IQ2BGaWQnAoi+a2uNNL43VKS
         YJ2f5Czo2LoYtJkZ4DZFGVhfFZTu1bKzGuKoxX4iLYbVfyvD+/5lmgcmV1ngILr6pzoh
         tErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200633; x=1713805433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfqt/NgDwjKFxB5AgyRPdEKVaYoxBURY78UkNYsrqoM=;
        b=V5IseFVoBtxxIYKM248wfyQ21uthW40jJTnnw6sR6vvXqdPdYVx2yo9tzYnIVSk7S8
         zB0MkF9YsbFDPe/0YxbVnVAAn1UI/R2bg/2mVAB+i15V/iC3vv3WvQVJzwC+bbzQFjQ+
         uFiO7Yx3w8uqVNBpcFCQ5XjYHzRj19mNMLWhn5T/E5yLjQ8jEzC0kSmvDO3nu6hecFCY
         BGgliWIavbfkEor4lSR7Sli9F15lJ9SO/Y2PEXYgOcpZpBfe2C1otNWwIYIpPYDly6vE
         NT9tqcDNOPgAEfvm6n+SxCUJv09biqI0yxSMNrI0n7vLBiz0qgo6aOBFEW8PeYZyZmo2
         vzwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9E8cYnVDmHJizWtO0nVSfdsOpTAKQSgeyZMeHUJRZ5a1HplWiXYjBbJirw3xRhHEqA2o1HPtXGEWkH9twqYRlPbbnDVKHQeYBSUR8
X-Gm-Message-State: AOJu0YwGVx4b6IKqE7rLgSUbBIvKteGWDHhdQQf4tPinkfNqjmf/dCra
	3QuBC/jInFZ/oWTZyzg7tpJxULMbfxdxYJ+NDjhNP6ssO8MH//6jw/NWpHA+EmEEKcdvMtlZhg+
	j+A==
X-Google-Smtp-Source: AGHT+IGA4ztkhkZCfS7682EU3T6gUsIsEcYhQEyC6yG3styg4+lnibMOlTTY3gI+fKNitZWoNIXkz2MBC8E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9399:b0:6ec:f266:d214 with SMTP id
 ka25-20020a056a00939900b006ecf266d214mr254346pfb.4.1713200632756; Mon, 15 Apr
 2024 10:03:52 -0700 (PDT)
Date: Mon, 15 Apr 2024 10:03:51 -0700
In-Reply-To: <86h6g5si0m.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405115815.3226315-1-pbonzini@redhat.com> <20240405115815.3226315-2-pbonzini@redhat.com>
 <20240412104408.GA27645@willie-the-truck> <86jzl2sovz.wl-maz@kernel.org>
 <ZhlLHtfeSHk9gRRO@google.com> <86h6g5si0m.wl-maz@kernel.org>
Message-ID: <Zh1d94Pl6gneVoDd@google.com>
Subject: Re: [PATCH 1/4] KVM: delete .change_pte MMU notifier callback
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nicholas Piggin <npiggin@gmail.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Apr 13, 2024, Marc Zyngier wrote:
> On Fri, 12 Apr 2024 15:54:22 +0100, Sean Christopherson <seanjc@google.com> wrote:
> > 
> > On Fri, Apr 12, 2024, Marc Zyngier wrote:
> > > On Fri, 12 Apr 2024 11:44:09 +0100, Will Deacon <will@kernel.org> wrote:
> > > > On Fri, Apr 05, 2024 at 07:58:12AM -0400, Paolo Bonzini wrote:
> > > > Also, if you're in the business of hacking the MMU notifier code, it
> > > > would be really great to change the .clear_flush_young() callback so
> > > > that the architecture could handle the TLB invalidation. At the moment,
> > > > the core KVM code invalidates the whole VMID courtesy of 'flush_on_ret'
> > > > being set by kvm_handle_hva_range(), whereas we could do a much
> > > > lighter-weight and targetted TLBI in the architecture page-table code
> > > > when we actually update the ptes for small ranges.
> > > 
> > > Indeed, and I was looking at this earlier this week as it has a pretty
> > > devastating effect with NV (it blows the shadow S2 for that VMID, with
> > > costly consequences).
> > > 
> > > In general, it feels like the TLB invalidation should stay with the
> > > code that deals with the page tables, as it has a pretty good idea of
> > > what needs to be invalidated and how -- specially on architectures
> > > that have a HW-broadcast facility like arm64.
> > 
> > Would this be roughly on par with an in-line flush on arm64?  The simpler, more
> > straightforward solution would be to let architectures override flush_on_ret,
> > but I would prefer something like the below as x86 can also utilize a range-based
> > flush when running as a nested hypervisor.

..

> I think this works for us on HW that has range invalidation, which
> would already be a positive move.
> 
> For the lesser HW that isn't range capable, it also gives the
> opportunity to perform the iteration ourselves or go for the nuclear
> option if the range is larger than some arbitrary constant (though
> this is additional work).
> 
> But this still considers the whole range as being affected by
> range->handler(). It'd be interesting to try and see whether more
> precise tracking is (or isn't) generally beneficial.

I assume the idea would be to let arch code do single-page invalidations of
stage-2 entries for each gfn?

Unless I'm having a brain fart, x86 can't make use of that functionality.  Intel
doesn't provide any way to do targeted invalidation of stage-2 mappings.  AMD
provides an instruction to do broadcast invalidations, but it takes a virtual
address, i.e. a stage-1 address.  I can't tell if it's a host virtual address or
a guest virtual address, but it's a moot point because KVM doen't have the guest
virtual address, and if it's a host virtual address, there would need to be valid
mappings in the host page tables for it to work, which KVM can't guarantee.

