Return-Path: <linux-kernel+bounces-84442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8CF86A6D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FAB1F2A9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4E120319;
	Wed, 28 Feb 2024 02:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpsnoFLQ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EFE2D05D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088146; cv=none; b=fb1qb5FKxu4jIeUFHcH0/IKMsIEVMFF7lx6NjBURJfrkhEFWVXJUNbs3YGNVUdIWFYz9p0h3h2FSOfpFw5mI9isvWlIBoT2rsU6PTa4q99urS3fX22PWOjhrxZpzI4cX0qbZgZdNQ96M5TaWpqG9bZ4saVQzkXxYNjh/ANTuOqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088146; c=relaxed/simple;
	bh=szLQWH4Y5Bzo6Uy7reBTywxc6dUFXHryHkO47zK9DXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OuL5yGe5S+omMHQDD8/IEq325uE4sjYbFC3Su3B9rhHVNYRJzJ75EkG7pYMFHaIa6W2zrzsNLU9BSOHxqYrXHoO2Ah+042Mr27S3L+LDFv+Jq01aBc0Uuug6/XDvNHeFoFUBcXFxA82/m3N/+cPGbXNDGIOz120sDSdv55ds7sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rpsnoFLQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2993efc802dso2200183a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709088140; x=1709692940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fK/e/x3+Tf/3Rz4S7hZymU4b4heBfx/RABet1RXMTfk=;
        b=rpsnoFLQv8Hr66kEDU1R/DQUQ6CdvcALLXvKoaMxmlhmQQG0O67AeLnt9n4kiGI3r+
         PWR7gPyio7d5kk9PHvrwe7XFTqnGtSBvBBUha/E58qdt+bIRrE6ajvnakAJv8ygpVNm0
         ZVB22rxYNL2l03f1fOgK3fKGP2AMjMOFUenCCXtDI1rvr148vHTjobq17YZnIdfdOrty
         Z7LqtuCCEzC2upLTszhOf9oi1MamnqctqOUGgibMm3WrrOxMYmtZtV/76so88kR7Fwl2
         KgJ8DDkgQakRo3CVqGSAEY/9qgpAiz6YRMPVu36M27+i2ImmG5uj2SU1X8ON65jaU2KD
         OIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709088140; x=1709692940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fK/e/x3+Tf/3Rz4S7hZymU4b4heBfx/RABet1RXMTfk=;
        b=S2jsREXF+16tvZn+wmzZF2taq3zf98Uuu+BKxqGosvPQJsOKVtiLQU8aqW1XeACQrO
         Ynx8YM97sCZTYroOFyZB0NjgekD248oeBS3qHPDYKfmB168y655p7tCQQTQ8zXUsnmw1
         /M3iMU8zD/foTHvlkWS0+dHA165VwvohQ2sle60mkzoyuGvi3zDZ2pyg0Ivg3NFjg08p
         YYsrkuEQ3AFECkm17PEZXnTawZ/6voYMlVjJQzyvDScWvm5P0BItqbpRnbktV7zc1vjD
         4wVWBdT82dyfh9WpAJu1yTCFLHlPyYuOhz8WmQTgmdK3o+ZwPzhPYnp2KLmOLEkUtcjF
         PekA==
X-Forwarded-Encrypted: i=1; AJvYcCV4gy9Ffufa+mXn2Y1GxwyumLJdHGKKAkM6Yo7VNEW4WC9cHPlDr5Mp7MI12v2nPs4QGJhtoNelM9tC0Sdbxb9TNtVHarVuBwCrYelv
X-Gm-Message-State: AOJu0YyV9xfHfz/yqbZLOQvuMzia9i8Zs21dBaaVrEDKmhc25jQm6WcR
	s/jODDAipauaN4uokey+YzmVY9Y8VOfatF1YYSxz2pFbQt13cd5HTmCVE+UwNexWQ5ydUgsuwzo
	M6w==
X-Google-Smtp-Source: AGHT+IFQ0g9E+Mk5m1PF8jqDNWlJr3OOxNFUEzGXFuClugZHZeqtSpftN+Bu/TNy5X1nKDvg9GP+3UI48k4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2d0b:b0:299:40c3:338f with SMTP id
 sy11-20020a17090b2d0b00b0029940c3338fmr38855pjb.1.1709088140382; Tue, 27 Feb
 2024 18:42:20 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Feb 2024 18:41:47 -0800
In-Reply-To: <20240228024147.41573-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240228024147.41573-17-seanjc@google.com>
Subject: [PATCH 16/16] KVM: x86/mmu: Sanity check that __kvm_faultin_pfn()
 doesn't create noslot pfns
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if __kvm_faultin_pfn() generates a "no slot" pfn, and gracefully
handle the unexpected behavior instead of continuing on with dangerous
state, e.g. tdp_mmu_map_handle_target_level() _only_ checks fault->slot,
and so could install a bogus PFN into the guest.

The existing code is functionally ok, because kvm_faultin_pfn() pre-checks
all of the cases that result in KVM_PFN_NOSLOT, but it is unnecessarily
unsafe as it relies on __gfn_to_pfn_memslot() getting the _exact_ same
memslot, i.e. not a re-retrieved pointer with KVM_MEMSLOT_INVALID set.
And checking only fault->slot would fall apart if KVM ever added a flag or
condition that forced emulation, similar to how KVM handles writes to
read-only memslots.

Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 43f24a74571a..cedacb1b89c5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4468,7 +4468,7 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	if (unlikely(is_error_pfn(fault->pfn)))
 		return kvm_handle_error_pfn(vcpu, fault);
 
-	if (WARN_ON_ONCE(!fault->slot))
+	if (WARN_ON_ONCE(!fault->slot || is_noslot_pfn(fault->pfn)))
 		return kvm_handle_noslot_fault(vcpu, fault, access);
 
 	/*
-- 
2.44.0.278.ge034bb2e1d-goog


