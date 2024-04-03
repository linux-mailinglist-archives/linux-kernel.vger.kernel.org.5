Return-Path: <linux-kernel+bounces-130446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD55897843
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2F21F21F9B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF427153BED;
	Wed,  3 Apr 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4l5Q98X"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5E53A7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169031; cv=none; b=uVOQBd1F1LQSSk1ZNsyWQbCAY2HAlcBHJjh+54ou9rrLcGKa0wF0rdUMrlXmeRb7DRJNB48PDnlZpJ1Nc5hX8yBJj+d13VfBkN0Pm7/e8ZWIRUoHQxIy6hUhB73729KxCjnQZNWysTcopaByUYUx9yjrFDSKiDqT2c8ZWX4JPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169031; c=relaxed/simple;
	bh=3+9lMpILcT4GrzjklqZThP0A8O5Au3Kt8WUWoV+QX18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RmkBaZjR+8Zrm1T0xKMj6aNYaedRxHf+Iy9OxPZ0iOY+VeugbIcxuI6o2OWV/W2IB3QVZYsAAos3qfe9i0ps/KuXRnPU/fNVUVyCcb94TEsmgsBXz+DStRdky7T2cw7/dPJKo5DLw7FGDPNsbDJiyGKtZDXws5g3FRMmaWDHRMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O4l5Q98X; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ea844bfbb7so98727b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 11:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712169029; x=1712773829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwSQRZk+BRxb7GZSaFeES/scIy0HPs9KPKeQnP6jNQA=;
        b=O4l5Q98XSlJ72CMiyfQLVgLeeDoICseHsQPl9PQcQRZEanElc/xhifRioSWN/kmDJ1
         q4X8YjhIeTuuekY6pg2l1AYn+616tmQRUMbjsdLbxx30h+Y3No4Ox51OHNCLRZgZ0mE1
         ePAGleNsio1BUflY2SvqlfD9MK1VuJthlBeF6cyPb39o74K4Gue+iiBddBslhhbHTxK4
         ALJnOaVj3WK4UYNYFiFpVDVvvjozo5SXSy/Uug5CVuUCAK+NgBXWR7QewwZLFGCbz9LB
         CawLdpfUKxhwLN3A2i7sUlejoOmy/T//l48WU0ESvh1pj8xD/5LEtevm1PJgQdCnBNGN
         xTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712169029; x=1712773829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwSQRZk+BRxb7GZSaFeES/scIy0HPs9KPKeQnP6jNQA=;
        b=ii78cFqhcRh1mmiwFpfgA6NjzBxDbWBSQOa/X3TFCs0RdzZTKWC6irFqJtQ0vbkRVy
         7Atk8aCJdK1RZn+gRtOj/nIweeDCmLynEo/5r85ZNRhOQ24HsmfTFPkg3R9ILrxoexu+
         oMHGh70MZEnkUvNZwKZv0F/7O9R8o1aYq7M5QhUupGQbCLUyn1uaW37vlLVRYqJX4DNh
         lUnooFmwPRgopgGpZql3YjW9FXJlSKBewIWxT/Cc7kypiCsMlXDhryd+7pT3+a82KvCp
         9PHipfcmG25BcB+49K/2RJhVtdnH/nqKyYwUJfjzR4/4c+VA8u2/G3J6o5bNbiqUBcBw
         a4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMgYsPGsJ9Qlreh0NqiwKknYdbPBLQPXTODp1DvfGaZlHmZGIkv5OHCsuxassS+H72ZIwuOBUKmfV+o3exAVoQC3/S6tOUyG1MWPOb
X-Gm-Message-State: AOJu0YzAqyxohhCOrHu5rVt/UGPEYtXc9Wp3fKqss05wkkMHCeP9rWVQ
	OHN4NIsYU9YzpaAufbzKwGjR0PBhiqWEE9mn3fBqPP8nf2MR7fE8zE7k1lxgUsUN4WJoXkZn358
	9lw==
X-Google-Smtp-Source: AGHT+IG/dVT1QOvlvL3U4/nwwVAfLf64pBOTR5Elndu+IJvpzi5Oo1x0lhZjKdwFiBZ+AqTPHPDpWYXpEf8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d07:b0:6ea:b999:4de1 with SMTP id
 fa7-20020a056a002d0700b006eab9994de1mr10338pfb.5.1712169028875; Wed, 03 Apr
 2024 11:30:28 -0700 (PDT)
Date: Wed, 3 Apr 2024 11:30:21 -0700
In-Reply-To: <20240319163309.GG1645738@ls.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1709288671.git.isaku.yamahata@intel.com>
 <ZekQFdPlU7RDVt-B@google.com> <20240307020954.GG368614@ls.amr.corp.intel.com> <20240319163309.GG1645738@ls.amr.corp.intel.com>
Message-ID: <Zg2gPaXWjYxr8woR@google.com>
Subject: Re: [RFC PATCH 0/8] KVM: Prepopulate guest memory API
From: Sean Christopherson <seanjc@google.com>
To: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Michael Roth <michael.roth@amd.com>, Federico Parola <federico.parola@polito.it>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 19, 2024, Isaku Yamahata wrote:
> On Wed, Mar 06, 2024 at 06:09:54PM -0800,
> Isaku Yamahata <isaku.yamahata@linux.intel.com> wrote:
> 
> > On Wed, Mar 06, 2024 at 04:53:41PM -0800,
> > David Matlack <dmatlack@google.com> wrote:
> > 
> > > On 2024-03-01 09:28 AM, isaku.yamahata@intel.com wrote:
> > > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > > > 
> > > > Implementation:
> > > > - x86 KVM MMU
> > > >   In x86 KVM MMU, I chose to use kvm_mmu_do_page_fault().  It's not confined to
> > > >   KVM TDP MMU.  We can restrict it to KVM TDP MMU and introduce an optimized
> > > >   version.
> > > 
> > > Restricting to TDP MMU seems like a good idea. But I'm not quite sure
> > > how to reliably do that from a vCPU context. Checking for TDP being
> > > enabled is easy, but what if the vCPU is in guest-mode?
> > 
> > As you pointed out in other mail, legacy KVM MMU support or guest-mode will be
> > troublesome.

Why is shadow paging troublesome?  I don't see any obvious issues with effectively
prefetching into a shadow MMU with read fault semantics.  It might be pointless
and wasteful, as the guest PTEs need to be in place, but that's userspace's problem.

Testing is the biggest gap I see, as using the ioctl() for shadow paging will
essentially require a live guest, but that doesn't seem like it'd be too hard to
validate.  And unless we lock down the ioctl() to only be allowed on vCPUs that
have never done KVM_RUN, we need that test coverage anyways.

And I don't think it makes sense to try and lock down the ioctl(), because for
the enforcement to have any meaning, KVM would need to reject the ioctl() if *any*
vCPU has run, and adding that code would likely add more complexity than it solves.

> > The use case I supposed is pre-population before guest runs, the guest-mode
> > wouldn't matter. I didn't add explicit check for it, though.

KVM shouldn't have an explicit is_guest_mode() check, the support should be a
property of the underlying MMU, and KVM can use the TDP MMU for L2 (if L1 is
using legacy shadow paging, not TDP).

> > Any use case while vcpus running?
> > 
> > 
> > > Perhaps we can just return an error out to userspace if the vCPU is in
> > > guest-mode or TDP is disabled, and make it userspace's problem to do
> > > memory mapping before loading any vCPU state.
> > 
> > If the use case for default VM or sw-proteced VM is to avoid excessive kvm page
> > fault at guest boot, error on guest-mode or disabled TDP wouldn't matter.
> 
> Any input?  If no further input, I assume the primary use case is pre-population
> before guest running.

Pre-populating is the primary use case, but that could happen if L2 is active,
e.g. after live migration.

I'm not necessarily opposed to initially adding support only for the TDP MMU, but
if the delta to also support the shadow MMU is relatively small, my preference
would be to add the support right away.  E.g. to give us confidence that the uAPI
can work for multiple MMUs, and so that we don't have to write documentation for
x86 to explain exactly when it's legal to use the ioctl().

