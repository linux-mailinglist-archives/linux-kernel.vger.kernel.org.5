Return-Path: <linux-kernel+bounces-100909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21E0879F80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10BDBB21D81
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8E64655F;
	Tue, 12 Mar 2024 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gU+eK7wZ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F7A14293
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284623; cv=none; b=fmgSSoIx/DiHQU+OKH+1bXrkrtDq4LNc8IjNLDZxTdaNO82sPIn/DFLS/S0ETFz2OmzWsgMQBVU4SPbSLLYsW9gCtH/moTXgoNnJpSYb9UjsPnPigItBzSUZLC8KeoPV8ue9CDDVJai8gpSG/QNGyjOnJl7CFozeyGL8JuORvi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284623; c=relaxed/simple;
	bh=K83M/gOkLwVJy/iWndMZQ3/mNyjmwqZz2ejy3OkYwbg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dITVOIgREYdL+OmCt/zEnahV29TbsVzzaxieOAiujLMOB/A2lL7h/6H3IOosMQAja97r5IjedvHtW0a93xIcs1pnZQqAc7V9p6XPbY/eItM2LyENjOYT+hJdaY2oMjyQY1sT6XgU+gOxerD7gCVMw3aXFT5fm1Tdq2+PUAvQgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gU+eK7wZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso77611407b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710284621; x=1710889421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wycjXUpdcjRTIVTczU6imQHDHg2SNIM+Jho2dwX/OCo=;
        b=gU+eK7wZOirO+4AKADjq8rdh5s3BlFPD3pS5rbtcxiI4ifhXJ2dbQeusGewybbbcke
         acXJuxAIYPZAM76RVI8sp88E11IHRw1Oi8LBqe7B++9+UONOH21omNMKcad1Ykt/QV4K
         8QrIVKuYGxg/FSQ2OQc018P+S9UjQqjnHeR/uwoy4vgnE8mWjz1pLrQ3BtcNZVBpEzwD
         jjspoCH4sf+N5U9a4+3iCjzGVcfQOMX1TtDRcwisoslHHbnR5YBw//0n70jYEApqeQmK
         QVl5KAMLGMi1WCFxKQU4XA9rVyjs9LTeAHWfEc9MhUzJqoWO89zG7fopj7AiS0eSJs2I
         e0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710284621; x=1710889421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wycjXUpdcjRTIVTczU6imQHDHg2SNIM+Jho2dwX/OCo=;
        b=Sr7slVvISC7Xt7tEa6qAt1mmPH2OMmkppwKQ2zyQuvDxlfHY2FmznOWi44yOtm9w5+
         zE1E+5e/cQcBvS4CU5a8Yg8Sfo2iE+v22thMaHVu1L0kHmlLXBMN/pCnvDuUU5zhTmpn
         kWdv7sH4cLJiNMrw5ApPXdi/BvOkpBGOdimwv1+K2U8sd24PIRbDJ1bNaBum41/NsOSm
         wLMUELVyf/uWRST5sO38dQtkj38+P0I4lJSmRFRGG88gOi7kek8nXXmGtrbXjc0jo53w
         FE8OqDIo9zJG6cJkPDrMbfS8UhnJt5KW/KYTO3Yh2uTYPv2c8HUhIRy+H4P8Pbla0M88
         30aA==
X-Forwarded-Encrypted: i=1; AJvYcCXMZBqjmHQlVy3l2IbMgFEZo+WqLDI2p5IZnutssa/EdhXVwBS9zLQHRNBUF2m4yurPFAhZu0gR2ft90deBmWWCMEL1mV2/I1IOdCsU
X-Gm-Message-State: AOJu0YxRt/diMeoazwziLUQxoX7XVz4ZYjGe4TBemEEj/O5WUwuOPpCg
	2W7z+zlH7qeV0oxwBPpLRjEGZ7FtVrK1IUQpwIRsrK/x8L5GpgS/BtDC8pla80HzkpVOImRivbE
	+Bg==
X-Google-Smtp-Source: AGHT+IHRIsSL43ZWHDYJyv+wWduH/mp7DvjWIBy12G8JAyQ7ZviuKBfYKWxrd22+duGrw/tAqkI65WqHd18=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:84c:b0:609:f189:1f59 with SMTP id
 bz12-20020a05690c084c00b00609f1891f59mr169425ywb.4.1710284621474; Tue, 12 Mar
 2024 16:03:41 -0700 (PDT)
Date: Tue, 12 Mar 2024 16:03:40 -0700
In-Reply-To: <fc3102f42ef6a1efa93d5bc75c9ed8653554cde2.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1709288671.git.isaku.yamahata@intel.com>
 <66a957f4ec4a8591d2ff2550686e361ec648b308.1709288671.git.isaku.yamahata@intel.com>
 <Ze-TJh0BBOWm9spT@google.com> <6b38d1ea3073cdda0f106313d9f0e032345b8b75.camel@intel.com>
 <ZfBkle1eZFfjPI8l@google.com> <3c840ebd9b14d7a9abe0a563e2b6847273369dcd.camel@intel.com>
 <fc3102f42ef6a1efa93d5bc75c9ed8653554cde2.camel@intel.com>
Message-ID: <ZfDfTIIxVBhLzqqk@google.com>
Subject: Re: [RFC PATCH 6/8] KVM: x86: Implement kvm_arch_{, pre_}vcpu_map_memory()
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "dmatlack@google.com" <dmatlack@google.com>, 
	"federico.parola@polito.it" <federico.parola@polito.it>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 12, 2024, Kai Huang wrote:
> On Tue, 2024-03-12 at 21:41 +0000, Huang, Kai wrote:
> > On Tue, 2024-03-12 at 07:20 -0700, Sean Christopherson wrote:
> > > On Tue, Mar 12, 2024, Kai Huang wrote:
> > > > > Wait. KVM doesn't *need* to do PAGE.ADD from deep in the MMU.  The only inputs to
> > > > > PAGE.ADD are the gfn, pfn, tdr (vm), and source.  The S-EPT structures need to be
> > > > > pre-built, but when they are built is irrelevant, so long as they are in place
> > > > > before PAGE.ADD.
> > > > > 
> > > > > Crazy idea.  For TDX S-EPT, what if KVM_MAP_MEMORY does all of the SEPT.ADD stuff,
> > > > > which doesn't affect the measurement, and even fills in KVM's copy of the leaf EPTE, 
> > > > > but tdx_sept_set_private_spte() doesn't do anything if the TD isn't finalized?
> > > > > 
> > > > > Then KVM provides a dedicated TDX ioctl(), i.e. what is/was KVM_TDX_INIT_MEM_REGION,
> > > > > to do PAGE.ADD.  KVM_TDX_INIT_MEM_REGION wouldn't need to map anything, it would
> > > > > simply need to verify that the pfn from guest_memfd() is the same as what's in
> > > > > the TDP MMU.
> > > > 
> > > > One small question:
> > > > 
> > > > What if the memory region passed to KVM_TDX_INIT_MEM_REGION hasn't been pre-
> > > > populated?  If we want to make KVM_TDX_INIT_MEM_REGION work with these regions,
> > > > then we still need to do the real map.  Or we can make KVM_TDX_INIT_MEM_REGION
> > > > return error when it finds the region hasn't been pre-populated?
> > > 
> > > Return an error.  I don't love the idea of bleeding so many TDX details into
> > > userspace, but I'm pretty sure that ship sailed a long, long time ago.
> > 
> > In this case, IIUC the KVM_MAP_MEMORY ioctl() will be mandatory for TDX
> > (presumbly also SNP) guests, but _optional_ for other VMs.  Not sure whether
> > this is ideal.

No, just TDX.  SNP's RMP purely works with pfns, i.e. the enforcement layer comes
into play *after* the stage-2 page table walks.  KVM can zap NPTs for SNP VMs at
will.

> > And just want to make sure I understand the background correctly:
> > 
> > The KVM_MAP_MEMORY ioctl() is supposed to be generic, and it should be able to
> > be used by any VM but not just CoCo VMs (including SW_PROTECTED ones)?
> > 
> > But it is only supposed to be used by the VMs which use guest_memfd()?  Because
> > IIUC for normal VMs using mmap() we already have MAP_POPULATE for this purpose.
> > 
> > Looking at [*], it doesn't say what kind of VM the sender was trying to use.
> > 
> > Therefore can we interpret KVM_MAP_MEMORY ioctl() is effectively for CoCo VMs? 
> > SW_PROTECTED VMs can also use guest_memfd(), but I believe nobody is going to
> > use it seriously.
> > 
> > [*] https://lore.kernel.org/all/65262e67-7885-971a-896d-ad9c0a760907@polito.it/
> > 
> > 
> 
> Hmm.. Just after sending I realized the MAP_POPULATE only pre-populate page
> table at host side, not EPT...

Yep, exactly.

> So the KVM_MAP_MEMORY is indeed can be used by _ALL_ VMs.  My bad :-(

