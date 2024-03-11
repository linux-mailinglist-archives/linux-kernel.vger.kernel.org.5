Return-Path: <linux-kernel+bounces-99656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60155878B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809661C20AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653A358AD7;
	Mon, 11 Mar 2024 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="xHS8WM0g"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CAB58AB2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199600; cv=none; b=FWnRNbe+ZlVJ6jKTOS0MB58MugoB22yKOPfDnTJ1nQ1JVR4aQiB/oMjNh+229+DruviI4WfoA97YeadlGLDMJhJ/H4zeXBNlc1winG8T7p/TqTB3xjbWn+JOJz6aCQzNn8MsWJDTPMNwsdejx7i6ur0fuZrv7e8VczYUuMf4a+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199600; c=relaxed/simple;
	bh=lpbX1mPwx2MxTAxNmn/tBPl9zy+fLFQYJC50tLoSVJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOaPKj3ZBfLvvg3YI/eOh7bPSMm61nV/XoBJAlfHpSlbSHUZIpQMU2UDD1xmQwTLZP+wLWdkKkTivudT7S5kR8lXIqM8dprJRY6NFcCLwkuN/nfFtAhDGTiWmAutz6TgRzVSeb8cVcE9/s2F7Fr6SkWi8ozLMBssgHdQBnJZ+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xHS8WM0g; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60832a48684so73724487b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710199598; x=1710804398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBMy6bPnqfy3nYeYeE9C0hAAknq/gOP1Jz4Zy/cxtck=;
        b=xHS8WM0gqN/tUYVVRNRSVsYJB5bsid12TpGbLP5Rukus19qFsDb1gwFbqIgJZE5iB2
         +F1289FjOZQI4b5++rS1Fm6LObzGScEvd3dZJaHMqO9TQbKBj/AlpJ2lIkzBlywlXQyZ
         HVqP+M0HwMqQxR8benU/ziOKDJqzFJjGM8O44DUNImXYteI00eyfliXDhW+G4fTQZdan
         CD7Cxpk0jYuJZgVgt4aTghq65F8dm3HB9X50uN1NtPorDylYIuVvEgorlhiB3utv64GK
         MQ+SIxJKsNTXZqo4QOQ08cFnFwjwIqaLW/PnOFZ7Dya82M2qbBevct3tGLI6Q1hi9/R9
         k0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710199598; x=1710804398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBMy6bPnqfy3nYeYeE9C0hAAknq/gOP1Jz4Zy/cxtck=;
        b=TOJS49DIrYSjT2GiP+yrtYJiHAmgXhlCr3fcfNJCqrW0MTA6Jq2v3KLXfI8Mo2ugao
         AfIC+ngEbCc9AKL3ljQheh2bfPT6K8JEvZll+5Dn9HNV01KNdzO8rUjy7V2WaYQduVU2
         mx3HVnO22CyOFR//k2sRT/uFhKC+cRvc81JiX31g7hSxgwiP+bPTn5Wr0VUoX96c1iSz
         pLlb0lFWtA/QL5lZQFY0z5w2h8Y6Tim2mxWI+iljuh0PQi0oSuI/1x9O3NPHwRkaMD02
         KKKQXTY/c5bMTkfRifEJ7OYgvJ0+dlmEdyLHTlFKIqf1FWSpwSmw1cIfiMVF3583/of1
         ub0g==
X-Forwarded-Encrypted: i=1; AJvYcCWFnYI3jiNwivHzXfYSi0bkjuTOiJSR/+rkZza1N3aTjT/H+525BfTgixdrkI5m8XafVXUd6w4ZRDcCIxeuuINCbB7UxZk/kJUpb4Ul
X-Gm-Message-State: AOJu0YzoqhKZeBy9hrGd8ycbhzG9goMteRkQ5xZ+/0PIUMuDMmJ4j+Hp
	+hEqQnH03vvN5hCRSBOGnt4OSDTwIknxkA+cldGfBuvEtShQG5cmZTIQYngCD3Y/I90P/iG2Hgc
	siQ==
X-Google-Smtp-Source: AGHT+IEZXZWPPsAZozjkVZRxvnjVyLOHjOG8HRAKLQ8CJujYIl7BVcjTDnkz4VHBrZpzFw2N4yJ1B2k95mg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:72b:b0:dcd:b593:6503 with SMTP id
 l11-20020a056902072b00b00dcdb5936503mr419450ybt.2.1710199597979; Mon, 11 Mar
 2024 16:26:37 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:26:30 -0700
In-Reply-To: <66a957f4ec4a8591d2ff2550686e361ec648b308.1709288671.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1709288671.git.isaku.yamahata@intel.com> <66a957f4ec4a8591d2ff2550686e361ec648b308.1709288671.git.isaku.yamahata@intel.com>
Message-ID: <Ze-TJh0BBOWm9spT@google.com>
Subject: Re: [RFC PATCH 6/8] KVM: x86: Implement kvm_arch_{, pre_}vcpu_map_memory()
From: Sean Christopherson <seanjc@google.com>
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Michael Roth <michael.roth@amd.com>, David Matlack <dmatlack@google.com>, 
	Federico Parola <federico.parola@polito.it>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 01, 2024, isaku.yamahata@intel.com wrote:
> +int kvm_arch_vcpu_map_memory(struct kvm_vcpu *vcpu,
> +			     struct kvm_memory_mapping *mapping)
> +{
> +	u8 max_level, goal_level = PG_LEVEL_4K;

goal_level is misleading.  kvm_page_fault.goal_level is appropriate, because for
the majority of the structures lifetime, it is the level KVM is trying to map,
not the level that KVM has mapped.

For this variable, maybe "mapped_level" or just "level"


> +	u32 error_code;

u64 when this gets rebased...

> +	int r;
> +
> +	error_code = 0;
> +	if (mapping->flags & KVM_MEMORY_MAPPING_FLAG_WRITE)
> +		error_code |= PFERR_WRITE_MASK;
> +	if (mapping->flags & KVM_MEMORY_MAPPING_FLAG_EXEC)
> +		error_code |= PFERR_FETCH_MASK;
> +	if (mapping->flags & KVM_MEMORY_MAPPING_FLAG_USER)
> +		error_code |= PFERR_USER_MASK;
> +	if (mapping->flags & KVM_MEMORY_MAPPING_FLAG_PRIVATE) {
> +#ifdef PFERR_PRIVATE_ACCESS
> +		error_code |= PFERR_PRIVATE_ACCESS;

..because PFERR_PRIVATE_ACCESS is in bits 63:32.

> +#else
> +		return -OPNOTSUPP;

Broken code.  And I don't see any reason for this to exist, PFERR_PRIVATE_ACCESS
will be unconditionally #defined.

> +#endif
> +	}
> +
> +	if (IS_ALIGNED(mapping->base_gfn, KVM_PAGES_PER_HPAGE(PG_LEVEL_1G)) &&
> +	    mapping->nr_pages >= KVM_PAGES_PER_HPAGE(PG_LEVEL_1G))
> +		max_level = PG_LEVEL_1G;
> +	else if (IS_ALIGNED(mapping->base_gfn, KVM_PAGES_PER_HPAGE(PG_LEVEL_2M)) &&
> +		 mapping->nr_pages >= KVM_PAGES_PER_HPAGE(PG_LEVEL_2M))
> +		max_level = PG_LEVEL_2M;
> +	else
> +		max_level = PG_LEVEL_4K;

Hrm, I would much prefer to allow KVM to map more than what is requested, i.e.
not artificially restrict the hugepage size.  Restricting the mapping size is
just giving userspace another way to shoot themselves in the foot.  E.g. if
userspace prefaults the wrong size, KVM will likely either run with degraded
performance or immediately zap and rebuild the too-small SPTE.

Ugh, and TDX's S-EPT *must* be populated with 4KiB entries to start.  On one hand,
allowing KVM to map a larger page (but still bounded by the memslot(s)) won't affect
TDX's measurement, because KVM never use a larger page.  On the other hand, TDX
would need a way to restrict the mapping.

Another complication is that TDH.MEM.PAGE.ADD affects the measurement.  We can
push the ordering requirements to userspace, but for all intents and purposes,
calls to this ioctl() would need to be serialized for doing PAGE.ADD, but could
run in parallel for every other use case, including PAGE.AUG and pre-mapping
shared memory for TDX.

Hrm.

Wait. KVM doesn't *need* to do PAGE.ADD from deep in the MMU.  The only inputs to
PAGE.ADD are the gfn, pfn, tdr (vm), and source.  The S-EPT structures need to be
pre-built, but when they are built is irrelevant, so long as they are in place
before PAGE.ADD.

Crazy idea.  For TDX S-EPT, what if KVM_MAP_MEMORY does all of the SEPT.ADD stuff,
which doesn't affect the measurement, and even fills in KVM's copy of the leaf EPTE, 
but tdx_sept_set_private_spte() doesn't do anything if the TD isn't finalized?

Then KVM provides a dedicated TDX ioctl(), i.e. what is/was KVM_TDX_INIT_MEM_REGION,
to do PAGE.ADD.  KVM_TDX_INIT_MEM_REGION wouldn't need to map anything, it would
simply need to verify that the pfn from guest_memfd() is the same as what's in
the TDP MMU.

Or if we want to make things more robust for userspace, set a software-available
flag in the leaf TDP MMU SPTE to indicate that the page is awaiting PAGE.ADD.
That way tdp_mmu_map_handle_target_level() wouldn't treat a fault as spurious
(KVM will see the SPTE as PRESENT, but the S-EPT entry will be !PRESENT).

Then KVM_MAP_MEMORY doesn't need to support @source, KVM_TDX_INIT_MEM_REGION
doesn't need to fake a page fault and doesn't need to temporarily stash the
source_pa in KVM, and KVM_MAP_MEMORY could be used to fully pre-map TDX memory.

I believe the only missing piece is a way for the TDX code to communicate that
hugepages are disallowed.

