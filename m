Return-Path: <linux-kernel+bounces-97665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFE1876D43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627EE1F22754
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130125B5DD;
	Fri,  8 Mar 2024 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y32rmSWr"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31C604C8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937445; cv=none; b=k76fJZOM7at17tU101svbLYkDnSKSzfitC4oD2gW9wX+XmHtK8Mo6k4y0ySZF3KFEpHulp4II5KBMoNZKsPDEJTDIV7vcJ0F5gmT/Oa/vArSZYzmNacY3TAxJ+41JzmJd6zOiv9rEj58mcEpsjx8UatAW6J3EA8j++hs3ybJs1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937445; c=relaxed/simple;
	bh=OBObAJ4WpB/i7V7cItJnAgMVJSMlTB9q1yOUgXuA288=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AxRYOaeMSoNJNtZNUFi1lmbNpw9Ye56YR8NL0DaA+jHcydekj3j53bqWoibndpEmwOG9ApavPDpcy4j5GodwuEohgIt3IYa4kCiQvQugMj2jpkZz+AuG7zYVleXWLK73eYIRxaAxWlJ8fe2UbkUilhYABj5ILPFeKHfN5Fc47/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y32rmSWr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0899c5f3so14579107b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 14:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709937442; x=1710542242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EKAP1XoeyNhKxelGB2Z1fg6FQidmIgOAbXl0GE76mf4=;
        b=Y32rmSWrdy6ModDpWtoX9+9ST81lzLT4w/tiUWkxZA189tVJzJz/yLgWUa0czZRtym
         nDYDZAjcujzZ7aOV12COV5CZHPb+zDexEERiE/BrqlHIszm4PGNcn0IMYdYm9v2L0DSB
         Xu4cpaG2Y3BeKfaqfogzpn7ArEMN4Ooa5xSSLCi5ABaQH5bhY1+gHxiWn+85ekWqTxoQ
         VVfXvLPkUiZ3HQNqbQ++egsb9R4yJpzm8HO9+ASDoFuweTMKsmPatPyFmahietUGafLX
         uVjqfd/OnNb5i2c5fRX/vecu3QbCsdeobSLlsS+nB84UVfz+xdtRm/X1W2iV9g8FYFS0
         N2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937442; x=1710542242;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKAP1XoeyNhKxelGB2Z1fg6FQidmIgOAbXl0GE76mf4=;
        b=r247g5k7nE2NWVISc6tEsGPj4DkyBGrV2o9BVPbjH9jmwBjZ9pJH/ZmFEF+/FVtQN9
         +yIIi9Fa+Go0p5pT56hA0GCnSVl+D/yRrfn1mbUpZIxypTSR6+GjCtj5kiqXw34nOuKh
         iIkot8P4bTzy1bFjTSS7K6mpXM+zIi2fimyuw56BmB9pL/gjTvFvRv+aR1KLaP1+Wfnu
         2AB453pmyfD8X467YG41vQoKGRb1cUmZtvbIcNssW4unYeNcFKtrTbl9KxWgVtZN6h6f
         82cVLx2a0SJ86MYnHFN2egxdyxntwqzvU06pqxMnGcSSz52OWHLQrVKNR4svqFZ93Yvk
         v8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWv6TxSWJPgYRNsehQS2xs3M6MoP64guu2s76MyigzV9xFxrQUaUptJn2XgmQGkjhLKlSl9MpPR1/2iklFR1DGC/7qaI+Xbz8RISbt4
X-Gm-Message-State: AOJu0YxeIQ+8BHYuDPX6E7AVKKMzSf+OAHh+RfoX0f6CopVIiDQANnA6
	YAUT7pY21uz+v4ajxoi2/hEAQaai6Jgx+RAwTVO6BoJ/b/+5n+JWeee/IMt8ZN1dzZEiJeRqUSn
	RUA==
X-Google-Smtp-Source: AGHT+IFGMEIq8/Zn5g6GqOwVYD2BLgPyM1uLHIW1Nw8QtUXpLYEEBjOmyGwXZ6wDcO9s6FahxZh98SDYb8w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:528a:0:b0:609:9bc:bdf1 with SMTP id
 g132-20020a81528a000000b0060909bcbdf1mr114465ywb.3.1709937442638; Fri, 08 Mar
 2024 14:37:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Mar 2024 14:37:01 -0800
In-Reply-To: <20240308223702.1350851-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308223702.1350851-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308223702.1350851-9-seanjc@google.com>
Subject: [GIT PULL] KVM: Xen and gfn_to_pfn_cache changes for 6.9
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Aaaand seeing my one commit in the shortlog made me realize I completely forgot
to get acks from s390 on the kvm_is_error_gpa() => kvm_is_gpa_in_memslot()
refactor.  Fudge.

s390 folks, my apologies for not reaching out earlier.  Please take a look at
commit 9e7325acb3dc ("KVM: s390: Refactor kvm_is_error_gpa() into
kvm_is_gpa_in_memslot()").  It *should* be a straight refactor, and I don't
expect the rename to be contentious, but I didn't intend to send this pull request
before getting an explicit ack.

As for the actual pull request, the bulk of the changes are to add support
for using gfn_to_pfn caches without a gfn, e.g. to opimize handling of overlay
pages, and then use that functionality for Xen's shared_info page.

Note, the commits towards the end are a variety of fixes from David that have
been on the list for a while, but only got applied this week due to issues with
the patches being corrupted (thanks to Evolution doing weird things).

The following changes since commit db7d6fbc10447090bab8691a907a7c383ec66f58:

  KVM: remove unnecessary #ifdef (2024-02-08 08:41:06 -0500)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-xen-6.9

for you to fetch changes up to 7a36d680658ba5a0d350f2ad275b97156b8d4333:

  KVM: x86/xen: fix recursive deadlock in timer injection (2024-03-04 16:22:39 -0800)

----------------------------------------------------------------
KVM Xen and pfncache changes for 6.9:

 - Rip out the half-baked support for using gfn_to_pfn caches to manage pages
   that are "mapped" into guests via physical addresses.

 - Add support for using gfn_to_pfn caches with only a host virtual address,
   i.e. to bypass the "gfn" stage of the cache.  The primary use case is
   overlay pages, where the guest may change the gfn used to reference the
   overlay page, but the backing hva+pfn remains the same.

 - Add an ioctl() to allow mapping Xen's shared_info page using an hva instead
   of a gpa, so that userspace doesn't need to reconfigure and invalidate the
   cache/mapping if the guest changes the gpa (but userspace keeps the resolved
   hva the same).

 - When possible, use a single host TSC value when computing the deadline for
   Xen timers in order to improve the accuracy of the timer emulation.

 - Inject pending upcall events when the vCPU software-enables its APIC to fix
   a bug where an upcall can be lost (and to follow Xen's behavior).

 - Fall back to the slow path instead of warning if "fast" IRQ delivery of Xen
   events fails, e.g. if the guest has aliased xAPIC IDs.

 - Extend gfn_to_pfn_cache's mutex to cover (de)activation (in addition to
   refresh), and drop a now-redundant acquisition of xen_lock (that was
   protecting the shared_info cache) to fix a deadlock due to recursively
   acquiring xen_lock.

----------------------------------------------------------------
David Woodhouse (5):
      KVM: x86/xen: improve accuracy of Xen timers
      KVM: x86/xen: inject vCPU upcall vector when local APIC is enabled
      KVM: x86/xen: remove WARN_ON_ONCE() with false positives in evtchn delivery
      KVM: pfncache: simplify locking and make more self-contained
      KVM: x86/xen: fix recursive deadlock in timer injection

Paul Durrant (17):
      KVM: pfncache: Add a map helper function
      KVM: pfncache: remove unnecessary exports
      KVM: x86/xen: mark guest pages dirty with the pfncache lock held
      KVM: pfncache: add a mark-dirty helper
      KVM: pfncache: remove KVM_GUEST_USES_PFN usage
      KVM: pfncache: stop open-coding offset_in_page()
      KVM: pfncache: include page offset in uhva and use it consistently
      KVM: pfncache: allow a cache to be activated with a fixed (userspace) HVA
      KVM: x86/xen: separate initialization of shared_info cache and content
      KVM: x86/xen: re-initialize shared_info if guest (32/64-bit) mode is set
      KVM: x86/xen: allow shared_info to be mapped by fixed HVA
      KVM: x86/xen: allow vcpu_info to be mapped by fixed HVA
      KVM: selftests: map Xen's shared_info page using HVA rather than GFN
      KVM: selftests: re-map Xen's vcpu_info using HVA rather than GPA
      KVM: x86/xen: advertize the KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA capability
      KVM: pfncache: check the need for invalidation under read lock first
      KVM: x86/xen: allow vcpu_info content to be 'safely' copied

Sean Christopherson (1):
      KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()

 Documentation/virt/kvm/api.rst                     |  51 +++-
 arch/s390/kvm/diag.c                               |   2 +-
 arch/s390/kvm/gaccess.c                            |  14 +-
 arch/s390/kvm/kvm-s390.c                           |   4 +-
 arch/s390/kvm/priv.c                               |   4 +-
 arch/s390/kvm/sigp.c                               |   2 +-
 arch/x86/include/uapi/asm/kvm.h                    |   9 +-
 arch/x86/kvm/lapic.c                               |   5 +-
 arch/x86/kvm/x86.c                                 |  68 ++++-
 arch/x86/kvm/x86.h                                 |   1 +
 arch/x86/kvm/xen.c                                 | 325 ++++++++++++++-------
 arch/x86/kvm/xen.h                                 |  18 ++
 include/linux/kvm_host.h                           |  56 +++-
 include/linux/kvm_types.h                          |   8 -
 .../testing/selftests/kvm/x86_64/xen_shinfo_test.c |  59 +++-
 virt/kvm/pfncache.c                                | 245 +++++++++-------
 16 files changed, 602 insertions(+), 269 deletions(-)

