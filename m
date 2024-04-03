Return-Path: <linux-kernel+bounces-130477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D2F8978A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A419928B4BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F784154BE2;
	Wed,  3 Apr 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjKQJ0Hb"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4E2F24
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170533; cv=none; b=tUlzf2ronvt16ll0TY16URojv6ztgmF7ZyhWMhh62oPLJSiMJzHuBXdDMcvMpEfviO+URI//uYkWHoTuVDb4f1j5dIzxLZ8Vr5thNl3YaRAu9IDSiyBHOEKCaa9aBCXbIC2nwu3jx0lg4mcJKQgIPok37kYS3zAk5am3HRF0gJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170533; c=relaxed/simple;
	bh=7XDPcjGhh21TD94uSUZErS3ioNLCHjs+I9ktpoDyyz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z977rOD2v53Md57V4TdODroAf0ID836Gh1oQjUTk0gWkNKWHESr3p2ujo2vtre8SfNtUX4Yu6Y1hUIroqwyzAStQOFyJkSPlCymP0tFDnDSQMd3APMxb7HxjZDyaspPBGSGNKYv9ArzvwU0mrWa8LlwmgLfkmtplm+yj0DTN1zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjKQJ0Hb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a240c417d9so77597a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712170531; x=1712775331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kzq7wE2LZl4SFXr3lgccRsGuVgsB6ehLKZYX2fNnhEI=;
        b=gjKQJ0HbCDHax4O0JbMqWZRRcq+C7V+QCHjNkc8TQ6zECYzyMavV94nNDvdAVKaCEM
         gUvqmN/N87eNwrXdvy45FhoyD9VV/8E7c18I/8gGB112Kk6FC1HoJQxgvh475fqcjFvm
         YlJH/pw2gHLN8NsPLZI49/LxXacdo9l8tj8Ew9AwO54NpmmwOLRJ4MiUb3t/4txb2kyl
         AnUpVvjnfB7n1uxqz2ZLM6tvR/m/VmvDmYgn08EPg+ZVTvY/hmYBJ/OqL/GelhkiS/IS
         lkWQaRs9VokXjUfAZfTpmGfCZ/Pu2CY+o81vJVdu5MIemdmh9cA9/oFL1rsMpWZ47E00
         uPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712170531; x=1712775331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kzq7wE2LZl4SFXr3lgccRsGuVgsB6ehLKZYX2fNnhEI=;
        b=aypapTdzP1CU+5IaG0ZPS/sDUu4UREhuBNEBY70LiCQfX7i1+KBSj2zQ27LDM1fl46
         ASRacuTunXfo/6H9kiC9+FqxRJb2jf6lMopPCh2sTJJVZkmZCiKCoYeRFW5AzXVbf8Ub
         qoeVvJSMlj0eYlfh9AUtynsoWkEV0mS8WqydO5Xp2MxMdl1bmpCCzOndMYE+DzuqElmw
         4OmRzB8fZcPagx0fLjwFrC+4DZDxJDldIoecWJcJ+N2sTSCbiE5c/ECM0RYVa97hq+O0
         +R1Kova7wvMuOuMceYZI/qSI9MYWx8mctWXWJWsW0/jQ719KsTTxKnFtgQ6Y2tMvQ4AR
         E9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXXp1IihQA3mfs8zZ7P2DBcczwgRFivFqtyPvAA66Sso223LJtihuQNt6NpYXYYTykxYgIeQ8IFG1BxH8kbV+gVJBZ6HVkRM63bgFe
X-Gm-Message-State: AOJu0YzqLb431hAmAJRtkMwixPbIQqzVSB6YanBtLNp8/yokA1rg8Msa
	nObJvUPnVhBm7NxSjemNN/iEjn8balvmVeX1RpWhb2BUFo4kzne9vu/GX/ijpVvILVj+sEUnC3m
	pig==
X-Google-Smtp-Source: AGHT+IFKGa2KzmAjSzr/ynps6PguHbVfuoYrDmr/tcPFpr26buqw+kLsdXlJNwSfn1UBTe813gJXVI83dEM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:de01:b0:29b:c2b7:7d29 with SMTP id
 m1-20020a17090ade0100b0029bc2b77d29mr1023pjv.9.1712170531325; Wed, 03 Apr
 2024 11:55:31 -0700 (PDT)
Date: Wed, 3 Apr 2024 11:55:30 -0700
In-Reply-To: <20240403183420.GI2444378@ls.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1708933498.git.isaku.yamahata@intel.com>
 <d6547bd0c1eccdfb4a4908e330cc56ad39535f5e.1708933498.git.isaku.yamahata@intel.com>
 <ZgY0hy6Io72yZ9dF@chao-email> <20240403183420.GI2444378@ls.amr.corp.intel.com>
Message-ID: <Zg2mItGOnHsQIP8R@google.com>
Subject: Re: [PATCH v19 097/130] KVM: x86: Split core of hypercall emulation
 to helper function
From: Sean Christopherson <seanjc@google.com>
To: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com, 
	Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, chen.bo@intel.com, 
	hang.yuan@intel.com, tina.zhang@intel.com, 
	Sean Christopherson <sean.j.christopherson@intel.com>, isaku.yamahata@linux.intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 03, 2024, Isaku Yamahata wrote:
> On Fri, Mar 29, 2024 at 11:24:55AM +0800,
> Chao Gao <chao.gao@intel.com> wrote:
> 
> > On Mon, Feb 26, 2024 at 12:26:39AM -0800, isaku.yamahata@intel.com wrote:
> > >@@ -10162,18 +10151,49 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
> > > 
> > > 		WARN_ON_ONCE(vcpu->run->hypercall.flags & KVM_EXIT_HYPERCALL_MBZ);
> > > 		vcpu->arch.complete_userspace_io = complete_hypercall_exit;
> > >+		/* stat is incremented on completion. */
> > 
> > Perhaps we could use a distinct return value to signal that the request is redirected
> > to userspace. This way, more cases can be supported, e.g., accesses to MTRR
> > MSRs, requests to service TDs, etc. And then ...
> 
> The convention here is the one for exit_handler vcpu_enter_guest() already uses.
> If we introduce something like KVM_VCPU_CONTINUE=1, KVM_VCPU_EXIT_TO_USER=0, it
> will touch many places.  So if we will (I'm not sure it's worthwhile), the
> cleanup should be done as independently.

Yeah, this is far from the first time that someone has complained about KVM's
awful 1/0 return magic.  And every time we've looked at it, we've come to the
conclusion that it's not worth the churn/risk.

And if we really need to further overload the return value, we can, e.g. KVM
already does this for MSR accesses:

/*
 * Internal error codes that are used to indicate that MSR emulation encountered
 * an error that should result in #GP in the guest, unless userspace
 * handles it.
 */
#define  KVM_MSR_RET_INVALID	2	/* in-kernel MSR emulation #GP condition */
#define  KVM_MSR_RET_FILTERED	3	/* #GP due to userspace MSR filter */

