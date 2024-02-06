Return-Path: <linux-kernel+bounces-54113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE6A84AAF7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5DDE1C23767
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCE2817;
	Tue,  6 Feb 2024 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sA7uDE+p"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F14E391
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178351; cv=none; b=jOeyHfH8GN1kfGPxe4Qqri/+ZVv1DUdrawxYEqKh4mjEQrykO71RM/ePun33JhyPz/8raMQRZqaBHGWcVTzGhpQqDZxGylOPuUC08PCzQXMFuN+5lyAyiJHoZowLyWSxsH/JaiF7qIMw8K4ct5CE9DsFBhbXILcsMoO4MsBSo7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178351; c=relaxed/simple;
	bh=U7p1iFE6ywvljPJognZaN8unEMxJXmtola9t/S0saE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BtvdbgXwrAatayMfB2M87sdeuYrTM7hN3eBy+n7LIkfIvkXxSdPxqH+Uinv7oQHkADEXumLTElRkulmAvtyzDCFBGbt7LwrIyK+RawYeIMkBNfpE/BfDYndOgIxv3B6/Qelezz0XK7M1La3DUp84hgFb41m8UpNHTAhJEXnPEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sA7uDE+p; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d94eeacec4so484945ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 16:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707178349; x=1707783149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aHBcot/2NqMYA7ZGuWe5JuLCcnyjFV+ziaoOKAd19I=;
        b=sA7uDE+p+Au52Gr59NBaIRz8K9RyvlI4tf6Tys6SP2l2xwq/ndA5cisuoDeoKPnSgr
         BavVl4oTvJdoFP04y/aLvvtCBG6vun3c13SVJhm7DMTIpxEFU/1i5OjGGrGGFHrsT5zp
         8IaKrXYgMA6RFXPcRemSQSNAIBPzPZgDl2gr/BLVJr+bUdRh2r9o+twViZhKVbiMaZ/Y
         804r6L7y8ImuXPY1ut/ZItCT7cpawXV9SXI7IwD3cIi7AQKF3zCJvyu/BG56rS+oVDTg
         SSCcu4kJvFLQhEKyIJf9/EaJW20RG0ULkZHLIe4HpLWri1AEka3k5shpznmCAjOsEbiA
         9pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707178349; x=1707783149;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2aHBcot/2NqMYA7ZGuWe5JuLCcnyjFV+ziaoOKAd19I=;
        b=w5xHQAYrPkTp3LdMC1QAaHMQE5bniS0aDxnAxYeuqudxxmgdf1enbGUo+TTaCMZAc8
         MKzq/l120G67NzNgdJZU1iGS6QkhUSmTAUF3eoIX8zCnMC6pT8uwdtW5gWyy6EJUtqMw
         F1Uc4Q8aw3hKazwHkD/s4ljKdpUnkgvR9sQk7vqazwUG/ulx/SL0IO2lT+w+Fpta09pt
         YiVMcpSlmJci01HqV5gOnvpSKySQtTWxMRK0hSFtfU3iY7uFhyZCIVmUu/LOfbFORp0L
         XiEl+lpQy4kswxgSz2g9mo3HwVKaTAjAJw3BrXi1eE9UYBoA4v2KMP+v8XjXUPn2qhty
         uHPw==
X-Gm-Message-State: AOJu0Yz4y/JnjFXd+EGAe44pZ9/q4pPfulhSW2bNxg8QAeZwSzANozem
	/K8hfXFltkNqpZ3Pah4YzEYto8JICu8TG7HbqIhYrGTDKm2c/b4kMRchuEqnRYZspfXyX61+bSm
	BIg==
X-Google-Smtp-Source: AGHT+IGrtWHSBFbmlk1OGbAiCKrrldxhM8yAJ86BBSoQJD/eK75NBEnbVI50mHb+WvJO+r3RBjcBOSJoxps=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ced1:b0:1d9:5778:f923 with SMTP id
 d17-20020a170902ced100b001d95778f923mr87plg.5.1707178348825; Mon, 05 Feb 2024
 16:12:28 -0800 (PST)
Date: Mon, 5 Feb 2024 16:12:27 -0800
In-Reply-To: <CANaxB-yAJf4wFyRgkc+XzAdkC9JUKtx-BoZ=eCV7jRSagjsv0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205173124.366901-1-avagin@google.com> <ZcErs9rPqT09nNge@google.com>
 <CANaxB-yAJf4wFyRgkc+XzAdkC9JUKtx-BoZ=eCV7jRSagjsv0g@mail.gmail.com>
Message-ID: <ZcF5a72HihKkLGVx@google.com>
Subject: Re: [PATCH] kvm/x86: add capability to disable the write-track mechanism
From: Sean Christopherson <seanjc@google.com>
To: Andrei Vagin <avagin@gmail.com>
Cc: Andrei Vagin <avagin@google.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, kvm@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Zhi Wang <zhi.a.wang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024, Andrei Vagin wrote:
> On Mon, Feb 5, 2024 at 10:41=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Mon, Feb 05, 2024, Andrei Vagin wrote:
> > > The write-track is used externally only by the gpu/drm/i915 driver.
> > > Currently, it is always enabled, if a kernel has been compiled with t=
his
> > > driver.
> > >
> > > Enabling the write-track mechanism adds a two-byte overhead per page =
across
> > > all memory slots. It isn't significant for regular VMs. However in gV=
isor,
> > > where the entire process virtual address space is mapped into the VM,=
 even
> > > with a 39-bit address space, the overhead amounts to 256MB.
> > >
> > > This change introduces the new KVM_CAP_PAGE_WRITE_TRACKING capability=
,
> > > allowing users to enable/disable the write-track mechanism. It is ena=
bled
> > > by default for backward compatibility.
> >
> > I would much prefer to allocate the write-tracking metadata on-demand i=
n
> > kvm_page_track_register_notifier(), i.e. do the same as mmu_first_shado=
w_root_alloc(),
> > except for just gfn_write_track.
> >
> > The only potential hiccup would be if taking slots_arch_lock would dead=
lock, but
> > it should be impossible for slots_arch_lock to be taken in any other pa=
th that
> > involves VFIO and/or KVMGT *and* can be coincident.  Except for kvm_arc=
h_destroy_vm()
> > (which deletes KVM's internal memslots), slots_arch_lock is taken only =
through
> > KVM ioctls(), and the caller of kvm_page_track_register_notifier() *mus=
t* hold
> > a reference to the VM.
> >
> > That way there's no need for new uAPI and no need for userspace changes=
.
>=20
> I think it is a good idea, I don't know why I didn't consider it.

Because you wanted to make me look smart ;-)

