Return-Path: <linux-kernel+bounces-108257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777FD880874
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CAF1F236FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52D67489;
	Wed, 20 Mar 2024 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BmpNwsXd"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63823187F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710893751; cv=none; b=AdD5hKrtFqloQ3It45Kc2Kw5grxtXoaA/2LSlQzajjXl65ngATrpwo5kIlS4voZNsj/5q4oSDqR1p3kBYFDcuOK7iIV8PukA5VyDcLSENPaOrK1cFuxt9CDhNAFQmRmTB1pLON3dYBs72bWeOcWcLCtg6gf77umEij/uxRSPx2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710893751; c=relaxed/simple;
	bh=Yt+8bVzeNRVFwoSbiyyZuiajeFUG3KOlGSiF7ZwTVSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SQkH+faDjnDB9bdhuNT5RoUSmJatvnB50phc5bv2IP3SYwLJKRbOZ6teEluwitLM8FoPWqE+2D6PgnQfIdw8rV5XzQdGb7mc22r82Fpp5cI1ZcIWY6aB/7rGht3BsrHp8sRtDRFs/VQykdmRfqfCT8U0OSI8DHLHZ76ny/piHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BmpNwsXd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609fe93b5cfso106538507b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710893748; x=1711498548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UhfoJMqa7cgNDZOfpPVEAPEpiQKCx49jDxBa32QwPAM=;
        b=BmpNwsXdYI6/JGb+exXrYX/eFJL/C8wSN8tD3FEpjUVJmGxPQsCOOHhuj8HK0etjcA
         WnA97gjyzB7R1GJ2NXahJSTgl/FwTg0DevzGeMx3vCxAi0mYu/3VeexkbvGyoc1Kycup
         3YtaDHwWYXnhWNcAxnaStR653PEejZGZe3uoKSsSBoBuMcJBTaO6Fe4ldta53WvyEPMU
         v+oEn9LBW1J0hQwPFfKKTcftEnFSj85COUO1NobnH3f/ZvVJummDldwjjVMDjlaBqE3A
         cwzJr8j5GJdaNJx2yhpJrC0l110BD2lYj9v5xaem4lwCq0ZD6KPVw8v7bnDRKZFpSvX3
         O5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710893748; x=1711498548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhfoJMqa7cgNDZOfpPVEAPEpiQKCx49jDxBa32QwPAM=;
        b=TH9+2PYWl3TKpWyu5o/hsF1eFSYNvCEVRTVkL6lynS3Gga2dFo824senyBSOKipPKC
         h59yXwxux7bYE7KyEL/1ZKNNajF4tBUkYd6t6UACcgnF4m64JBfqvXjnnq3smhayyyms
         YZU6xZc4XMHKDHa223Ft/JeUXNxNN2gz4AAJX162CTzA/rYXOOjpE4rh5ymLOVplrkmg
         80rqrRn2komKGpjFTrwJK9j1MuUeQQ/Ysggn8OQNwk97dYXCF6iTdVkjLO8LeoiNB9/G
         9yGdzXbJZIQdhPRvlDK5J4Y4Mwp2uxzpMjYEmaqBv71yrdNjneAci12JBxYtOTA4zFce
         ZpYw==
X-Forwarded-Encrypted: i=1; AJvYcCW8C/5zAYKvSka5ks6ar0mgz+Yi6RifvRWXiiNdS6D4jWBmol4wqXISiXAOroZVdR0mCNq8UtIBzmvLArHJ6UZWroBD33rofGDuVvKP
X-Gm-Message-State: AOJu0Yx/3lpEcu/u98jhiEZeXHEsP1EoNiflBt28a0189l8jS1hwbsln
	yDq4bgU82OnxnWm7Ze/Mc5BZEpqv1Pl6lz7yJujqoJwm19PnnhIbXMwWeNpSyoSGqOJRyHhiewq
	iBA==
X-Google-Smtp-Source: AGHT+IEEvlbSsccTqQ4jGgQQB1hc+eWbYdcXnNRWLJsFow/ZnDqIfy1THCaZsqq7Y5Q3P1IQWedbNpfgLH8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2181:b0:dc6:dd76:34cc with SMTP id
 dl1-20020a056902218100b00dc6dd7634ccmr887389ybb.1.1710893748542; Tue, 19 Mar
 2024 17:15:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 19 Mar 2024 17:15:41 -0700
In-Reply-To: <20240320001542.3203871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320001542.3203871-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240320001542.3203871-3-seanjc@google.com>
Subject: [PATCH 2/3] KVM: Check validity of offset+length of gfn_to_pfn_cache
 prior to activation
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, syzbot+106a4f72b0474e1d1b33@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"

When activating a gfn_to_pfn_cache, verify that the offset+length is sane
and usable before marking the cache active.  Letting __kvm_gpc_refresh()
detect the problem results in a cache being marked active without setting
the GPA (or any other fields), which in turn results in KVM trying to
refresh a cache with INVALID_GPA.

Attempting to refresh a cache with INVALID_GPA isn't functionally
problematic, but it runs afoul of the sanity check that exactly one of
GPA or userspace HVA is valid, i.e. that a cache is either GPA-based or
HVA-based.

Reported-by: syzbot+106a4f72b0474e1d1b33@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000005fa5cc0613f1cebd@google.com
Fixes: 721f5b0dda78 ("KVM: pfncache: allow a cache to be activated with a fixed (userspace) HVA")
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/pfncache.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 8f2121b5f2a0..91b0e329006b 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -245,8 +245,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	return -EFAULT;
 }
 
-static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
-			     unsigned long len)
+static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva)
 {
 	unsigned long page_offset;
 	bool unmap_old = false;
@@ -260,9 +259,6 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 	if (WARN_ON_ONCE(kvm_is_error_gpa(gpa) == kvm_is_error_hva(uhva)))
 		return -EINVAL;
 
-	if (!kvm_gpc_is_valid_len(gpa, uhva, len))
-		return -EINVAL;
-
 	lockdep_assert_held(&gpc->refresh_lock);
 
 	write_lock_irq(&gpc->lock);
@@ -365,6 +361,9 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 
 	guard(mutex)(&gpc->refresh_lock);
 
+	if (!kvm_gpc_is_valid_len(gpc->gpa, gpc->uhva, len))
+		return -EINVAL;
+
 	/*
 	 * If the GPA is valid then ignore the HVA, as a cache can be GPA-based
 	 * or HVA-based, not both.  For GPA-based caches, the HVA will be
@@ -372,7 +371,7 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	 */
 	uhva = kvm_is_error_gpa(gpc->gpa) ? gpc->uhva : KVM_HVA_ERR_BAD;
 
-	return __kvm_gpc_refresh(gpc, gpc->gpa, uhva, len);
+	return __kvm_gpc_refresh(gpc, gpc->gpa, uhva);
 }
 
 void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
@@ -392,6 +391,9 @@ static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned
 {
 	struct kvm *kvm = gpc->kvm;
 
+	if (!kvm_gpc_is_valid_len(gpa, uhva, len))
+		return -EINVAL;
+
 	guard(mutex)(&gpc->refresh_lock);
 
 	if (!gpc->active) {
@@ -411,7 +413,7 @@ static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned
 		gpc->active = true;
 		write_unlock_irq(&gpc->lock);
 	}
-	return __kvm_gpc_refresh(gpc, gpa, uhva, len);
+	return __kvm_gpc_refresh(gpc, gpa, uhva);
 }
 
 int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
-- 
2.44.0.291.gc1ea87d7ee-goog


