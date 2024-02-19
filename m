Return-Path: <linux-kernel+bounces-71659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A4485A897
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813F0B2387B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0321F3E470;
	Mon, 19 Feb 2024 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5cj25p+"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E83D0D8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359496; cv=none; b=VgIqC9BHaVRGEq9+ABf1WlGZVma54fNELC9o9alGM6CuFz0BEyVexIh31hSavMfNAAnYxCSPTxjBflV37BR3O3JA8aPpExIraeMv8KyRlceid+SbmNH14sPQ6E8T8jFhrZfAgI6uMlXQvRIZzQ9FZW/1eotlUvrRvdhKc8wUGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359496; c=relaxed/simple;
	bh=DKi9ClYEI2bnAdqgXQhxDsS6OIw5QRI8XJDUvDaOSFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OCqzwI+eMMPCQN4o2/mU8fqkUVrL6Wse/5QYhVYxNnKHJEGFJGCD/xOOBWWKrmeSTUolj1ezW43zPtgjbR2qtE3n9KTNghckB3WX+y/Ub65qBUSgL311NJ7rKbsBtjO+Pn1Pmq/qwE3mE+ydOhMbgM8DHBlEN0v6coPr5puV+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5cj25p+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607a628209eso81426857b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708359494; x=1708964294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxVgM4sFgvltRiBksmHu5Sv+NRJFlTzi90+ryT5Fkzk=;
        b=C5cj25p+vuXpbVTM2ftW/3LHvunPLMp4SvtJAq5TiGaWFY4d+fVYbAZLEg2dW+rF3g
         nGfA37wHdOmh2MYDKyh/OUkGlrmrKmQCDJSM08OufxNo42xLdY7bLzyNZZqPjVk4QTKX
         EjZKRl0+UP4GgXX2w+ihi2idqYmU5XxkKA2+zmkI2QfvfW01ebr7l4FlFGmJK1E7a8Aq
         2bod52ZM/X64fnj5NpBZdskkNrgDpW0ob0TwG4B8u4nuqQw++1cSx1UZYbonQp3JsvDb
         EPByTn9/7fsLqknsvvMQ47+TGdkkqngIGmV2RUdmfaZawey/uY4LwzihvVkhJO/Umd/4
         3wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708359494; x=1708964294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxVgM4sFgvltRiBksmHu5Sv+NRJFlTzi90+ryT5Fkzk=;
        b=tzjnFXuH47H0/Vf9Io6frAgPY/AEU7I/bQU2X45KTLw7xAUQo55UxL2ypM2nh20nxd
         h9rzTgVvynRhbymJYKfICdh5eLRGz9hMjtRlyUImak2gOFo3HodUnACV1RkxMOgUtvgh
         pFonI8+yfCIS5obQ2DFYJ9z+N+DGZAb4TcvMkiLqCHzZIHU7ZT7ythRvLT/b3NzWQgaD
         27kkVRgJoz4fM/3/K3B5t2KpnYmrpFE/swL4H06NckOSG9yS2OxXpHIScPtVYo4MKM6q
         cVY7KNxclwWhru5x9RizAq+UA5TojNmYGwgfkM0Urt6PlZRmkUhonREXOB7az8/UJRvK
         caIg==
X-Forwarded-Encrypted: i=1; AJvYcCUAEQuELW69KR5RcxS6yK+NI7S5MjJsPc20N8805pfICWmjlpUDOCmXaEvOARxL1ZMvd5aG72J79D7ENxI+0D5c5xI+K0wLC7AQPKEf
X-Gm-Message-State: AOJu0YxXNJFoOTuxECn7GVOMQvLbawS/w8PggTvukLnWAPn8Z9XmDd0f
	ocD0+QzVtGkG8Rzs2uCYGlnUPDTKeLUNWtMuXpZIxIARzB2fRYM0E02sGfKib6eLCORAhS+z488
	MOw==
X-Google-Smtp-Source: AGHT+IHPO+KAFMFbQFRd+7ASVQ43PJ+mYJJ1avOdvFckaE7fEErIBRHV5mqyYUo8l3V2m9JAyHSm0+2KWrU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:e611:0:b0:607:9268:6665 with SMTP id
 p17-20020a0de611000000b0060792686665mr3175499ywe.10.1708359493839; Mon, 19
 Feb 2024 08:18:13 -0800 (PST)
Date: Mon, 19 Feb 2024 08:18:12 -0800
In-Reply-To: <ZdDGooxx/a+sAzmq@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209222858.396696-1-seanjc@google.com> <20240209222858.396696-2-seanjc@google.com>
 <ZdDGooxx/a+sAzmq@yilunxu-OptiPlex-7050>
Message-ID: <ZdN_RM2awyNyKiZu@google.com>
Subject: Re: [PATCH v4 1/4] KVM: x86/mmu: Retry fault before acquiring
 mmu_lock if mapping is changing
From: Sean Christopherson <seanjc@google.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Friedrich Weber <f.weber@proxmox.com>, 
	Kai Huang <kai.huang@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Fuad Tabba <tabba@google.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Feb 17, 2024, Xu Yilun wrote:
> >  static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
> >  			   unsigned int access)
> >  {
> > +	struct kvm_memory_slot *slot = fault->slot;
> >  	int ret;
> >  
> >  	fault->mmu_seq = vcpu->kvm->mmu_invalidate_seq;
> >  	smp_rmb();
> >  
> > +	/*
> > +	 * Check for a relevant mmu_notifier invalidation event before getting
> > +	 * the pfn from the primary MMU, and before acquiring mmu_lock.
> > +	 *
> > +	 * For mmu_lock, if there is an in-progress invalidation and the kernel
> > +	 * allows preemption, the invalidation task may drop mmu_lock and yield
> > +	 * in response to mmu_lock being contended, which is *very* counter-
> > +	 * productive as this vCPU can't actually make forward progress until
> > +	 * the invalidation completes.
> > +	 *
> > +	 * Retrying now can also avoid unnessary lock contention in the primary
> > +	 * MMU, as the primary MMU doesn't necessarily hold a single lock for
> > +	 * the duration of the invalidation, i.e. faulting in a conflicting pfn
> > +	 * can cause the invalidation to take longer by holding locks that are
> > +	 * needed to complete the invalidation.
> > +	 *
> > +	 * Do the pre-check even for non-preemtible kernels, i.e. even if KVM
> > +	 * will never yield mmu_lock in response to contention, as this vCPU is
> > +	 * *guaranteed* to need to retry, i.e. waiting until mmu_lock is held
> > +	 * to detect retry guarantees the worst case latency for the vCPU.
> > +	 */
> > +	if (!slot &&
> 
> typo?   if (slot &&

Ugh, and bad testing on my end.

