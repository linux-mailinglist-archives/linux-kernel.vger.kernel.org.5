Return-Path: <linux-kernel+bounces-157789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1408B1632
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED573284FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F7316E873;
	Wed, 24 Apr 2024 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6OJygM0"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5EA16E86E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997952; cv=none; b=eKInbzRirpVeyIz38icW1rfJqy9BFifYrlH7dzFQ8g0O6oluKUfg4nTsNDUonzJJT0w7OFEQMntqV3qP5pcVZLdu7+2rNlosViu17/HLdEjScr/Eo7u1P99emp8RCrIY8ErbkOjZwa2DZuc8gMadJCxgEuDDXOkcGnQdp06Gx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997952; c=relaxed/simple;
	bh=J+DEJmdO809x/feSfhv8NrKQjz9zBpNYGJ6iMTXQyQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RUlkWepKYFiG4V/ouju4+CV7kTwELr23rezdRW8hIIs3fHWtSdNNsRo8lK/ZcjaUrbtp+jjoY9q3PjD/RULuke5IhPU71b7N5xxZWDIYwqsqCoZ3l4KNu06N6kPDu3BbUG6FzDZ9iwX1/e0u8rxAlyCZfibdbeY64PHO2/Vl08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I6OJygM0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-60765123837so429883a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713997950; x=1714602750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fbHAzOJmO400UI3EbfnqZCQHux+va8GoDnejftzSERA=;
        b=I6OJygM0dvXTS84Rm4hvHf0M+VGW+ZccLj+K9JZ0Ml82+64YguCZ9FTBIWLO5jNUrW
         8FX+BY2TDePQ1HCIE9lnSfeXQ64DR94Fkw9SYXzdlBrLZpdz9mqY4yz97aFA9tOgmpzQ
         3XE5eajnOcelZp8vo+5CikilW85po1HjiJMK+E6FSeflE066JkjhDVU9eX3d4RL8YfHo
         bgSGkWR8Vyr9t+V9MJPKIzVhlfiBkOSksZ8+8p5GnAMztN4OTkktbFpkOqd9NepfgU3B
         YKwKSVHZY3b93dS0f+dH8saAn58oLtxwA9Kn2ncSJ7KGlPboPBcUk/A5+P6NtrL2JgRs
         q0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713997950; x=1714602750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbHAzOJmO400UI3EbfnqZCQHux+va8GoDnejftzSERA=;
        b=GZfMPXwW7eLALcVDHQdCNCHpPu3URcZrzpQsd4ovET0BjI9nbMJqCHDJrSJzVBbz9J
         4dmbzhM89MKn7wosY03brXa+0lRQa7ubghLhBu641Lzu4QvZnwu5Jw2q87pFYbp3lmZ5
         OT2DbtI4aHGMHyovJg6SoHZpjL7JmWlD1ubvZnzlvE9qXbrv0gpcv8URxXh9SiU6uBnc
         +VvVyH0qw9ilB9SjpSr06P5R1q74MHtuZKlAS2Nu2FXfuCPxNG7lRqJkecUHQNn0NmPD
         kV6XVMyyTVXkHBczIh6jnaO420KdwuKeVQ4ny9+TnOlmnByceKTQvo/oEZqkstOwAnOf
         upbQ==
X-Gm-Message-State: AOJu0YxvtRyUfbghN47CGnCClj4aTV4ijtyuKc9EWKRthah5opyW02kV
	oiU206CPF6xC513AzluzdBLNz4+e35VmLEqg7ltijj8gX2kbT7mXXCeMgtwfQVijhxCAq9NXkw5
	JBg==
X-Google-Smtp-Source: AGHT+IHVH74OpMP/nUdHkgxN9kdOGAEK7F25vK4oYMnoHDkLL1BvoFE0EekEgncSt0FuF51T/8OKIw4h+PI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:4714:0:b0:5db:edca:d171 with SMTP id
 u20-20020a634714000000b005dbedcad171mr56373pga.6.1713997949952; Wed, 24 Apr
 2024 15:32:29 -0700 (PDT)
Date: Wed, 24 Apr 2024 15:32:28 -0700
In-Reply-To: <20240404185034.3184582-10-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240404185034.3184582-1-pbonzini@redhat.com> <20240404185034.3184582-10-pbonzini@redhat.com>
Message-ID: <ZimIfFUMPmF_dV-V@google.com>
Subject: Re: [PATCH 09/11] KVM: guest_memfd: Add interface for populating gmem
 pages with user data
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 04, 2024, Paolo Bonzini wrote:
> +long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages,
> +		       int (*post_populate)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +					    void __user *src, int order, void *opaque),

Add a typedef for callback?  If only to make this prototype readable.

> +long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages,
> +		       int (*post_populate)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +					    void __user *src, int order, void *opaque),
> +		       void *opaque)
> +{
> +	struct file *file;
> +	struct kvm_memory_slot *slot;
> +
> +	int ret = 0, max_order;
> +	long i;
> +
> +	lockdep_assert_held(&kvm->slots_lock);
> +	if (npages < 0)
> +		return -EINVAL;
> +
> +	slot = gfn_to_memslot(kvm, gfn);
> +	if (!kvm_slot_can_be_private(slot))
> +		return -EINVAL;
> +
> +	file = kvm_gmem_get_file(slot);
> +	if (!file)
> +		return -EFAULT;
> +
> +	filemap_invalidate_lock(file->f_mapping);
> +
> +	npages = min_t(ulong, slot->npages - (gfn - slot->base_gfn), npages);
> +	for (i = 0; i < npages; i += (1 << max_order)) {
> +		gfn_t this_gfn = gfn + i;

KVM usually does something like "start_gfn" or "base_gfn", and then uses "gfn"
for the one gfn that's being processed.  And IMO that's much better because the
propotype for kvm_gmem_populate() does not make it obvious that @gfn is the base
of a range, not a singular gfn to process.


> +		kvm_pfn_t pfn;
> +
> +		ret = __kvm_gmem_get_pfn(file, slot, this_gfn, &pfn, &max_order, false);
> +		if (ret)
> +			break;
> +
> +		if (!IS_ALIGNED(this_gfn, (1 << max_order)) ||
> +		    (npages - i) < (1 << max_order))
> +			max_order = 0;
> +
> +		if (post_populate) {

Is there any use for this without @post_populate?  I.e. why make this optional?

> +			void __user *p = src ? src + i * PAGE_SIZE : NULL;

Eh, I would vote to either define "p" at the top of the loop.  

> +			ret = post_populate(kvm, this_gfn, pfn, p, max_order, opaque);
> +		}
> +
> +		put_page(pfn_to_page(pfn));
> +		if (ret) {
> +			/*
> +			 * Punch a hole so that FGP_CREAT_ONLY can succeed
> +			 * again.
> +			 */
> +			kvm_gmem_undo_get_pfn(file, slot, this_gfn, max_order);
> +			break;
> +		}
> +	}
> +
> +	filemap_invalidate_unlock(file->f_mapping);
> +
> +	fput(file);
> +	return ret && !i ? ret : i;
> +}
> +EXPORT_SYMBOL_GPL(kvm_gmem_populate);
> -- 
> 2.43.0
> 
> 

