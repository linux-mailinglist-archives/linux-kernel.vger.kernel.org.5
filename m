Return-Path: <linux-kernel+bounces-94682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370C987435B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E063B21080
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CBD1C684;
	Wed,  6 Mar 2024 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gGLKdnTx"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44D1B7E4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766068; cv=none; b=BgVWiBnvh8R5zRhhKt/MfonJMfkdDTkQ58CpKh2Fi7qn4P/2YhWYIRA6I+ek2PePs0oSZ+6jltrIsCPKyRunOunkkbxLD/qJ92tP1aQcJS1VAyCPjeQ1zFh9h/hWlDVEb2dbSPiBp9TR3zFPVFKOgrp2D67+f2aACwMJ5jYNq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766068; c=relaxed/simple;
	bh=NW+sQlo/7EybAM3SogmzAKt1K9OGuME79HDfxRhZzro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZYp6uznDUobcLJZ322N7h5MZ0oJMEgW/sJdAuN50r/2NU+3PJuZuZrjZq7wQTjLcvbDA8AMYU2COfbUtJVNdLgNRUzut5aLT+4vvGjm0/Sc6GrBKzPsENN7LwYoJXTSBuGNdDIrMWXSt+D71C2QjF/tRdW7VSuvhhcNeUUnFHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gGLKdnTx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so330449276.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709766066; x=1710370866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RcwkQpLt5gEvw9lzOYXIygCaKSwMUmTC1mBtpnpNrdY=;
        b=gGLKdnTxGIK2wuNX8E8loTBpdtR4iExJl8/YS6YX9Zdu3zBXU0gZ2c4+R2KMPXAlV9
         QSiUFOA/jaHvimJkhhrGBmi/IQCSLqvYcnaH2OTXwR/7TCI4MeXgEhrZvhDeUD3zSdxu
         OSPINLhhRCENoGaCuDjPx14K9sz1Aj9oFGJp9oWBwnvOd4FWe4ggE1ItbReNklTZ0Qkh
         qXjWoPlH/3YGydBYzz76A9c6rkmrTVe93crVzKb7kt6iN3tYtG2FNk+gKvO4tD7ln/J0
         pMO6khfHCLWMf21BQQPlVL+0adOluXPAQNp5HRqC+Vsedp51u7aHeTiMAeeOBhkSnHxz
         4y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766066; x=1710370866;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RcwkQpLt5gEvw9lzOYXIygCaKSwMUmTC1mBtpnpNrdY=;
        b=B2UeZkDnEtToNHsbGTYgYezCCm9IyPHtg+WUqJPMo+4UwoyO68o1y0G2uW0BFAdX5N
         F5cpZTz9zp40HpF9Ptz8KR2Ud9GNkW4yLnAhcm+rhrSPm96SMDo8sKuIfIwDoDVprLEw
         f+IZw7SzMGSP8xR4aKA8wuHjMEoaUcSMT/fyj3k0tOxnaQczQPhV86E4BwpkGg/3ZcWv
         imCNUN5iJo7Iui5ZNCmiCEDd8xbKv620Fjv80BzLsPcI/nBFZTXiol1REMit2Y+LrFLd
         2qQjQsxx/w7+28wuwGRPCSBOOHSU5QnGBmQJzU9JSJc5XIl8h7vk4eGd1wvCdmrTSci0
         V8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN1Q0s+DkTgPwPThQMcQy1QTZRkzI+tV6+WVmtMs69/VdiFYseX7+uT1SdSpi+yDOBwZP0HhTOvsgfwCgEN+kSwEscbJPFNbUzn5eP
X-Gm-Message-State: AOJu0YwUb8tE0MsAYLNAimVOfvBeshk4cBlf9/iRqiQwEGyjtP7nBCnv
	/uhwcccyRciZUfc3ydKCnvQ5aCzj1r5z7H+0sCUNCN+9Lj7tBJKJ+bKSsdYHx9evaW/2NFvXLiC
	WkA==
X-Google-Smtp-Source: AGHT+IGZoQmVqCVd/23cUslfqz8onL3il57LkzhWOvgl7OCZGQJeoymsA0M5Y2Vn5b0vjetJm1+A83a8IOs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1004:b0:dc7:48ce:d17f with SMTP id
 w4-20020a056902100400b00dc748ced17fmr4153235ybt.10.1709766066391; Wed, 06 Mar
 2024 15:01:06 -0800 (PST)
Date: Wed, 6 Mar 2024 15:01:04 -0800
In-Reply-To: <5f230626-2738-41cc-875d-ab1a7ef19f64@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-12-seanjc@google.com>
 <0a05d5ec-5352-4bab-96ae-2fa35235477c@intel.com> <ZejxqaEBi3q0TU_d@google.com>
 <5f230626-2738-41cc-875d-ab1a7ef19f64@intel.com>
Message-ID: <Zej1sBTPLXIhfemS@google.com>
Subject: Re: [PATCH 11/16] KVM: x86/mmu: Explicitly disallow private accesses
 to emulated MMIO
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024, Kai Huang wrote:
>=20
>=20
> On 7/03/2024 11:43 am, Sean Christopherson wrote:
> > On Thu, Mar 07, 2024, Kai Huang wrote:
> > >=20
> > >=20
> > > On 28/02/2024 3:41 pm, Sean Christopherson wrote:
> > > > Explicitly detect and disallow private accesses to emulated MMIO in
> > > > kvm_handle_noslot_fault() instead of relying on kvm_faultin_pfn_pri=
vate()
> > > > to perform the check.  This will allow the page fault path to go st=
raight
> > > > to kvm_handle_noslot_fault() without bouncing through __kvm_faultin=
_pfn().
> > > >=20
> > > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > > ---
> > > >    arch/x86/kvm/mmu/mmu.c | 5 +++++
> > > >    1 file changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > index 5c8caab64ba2..ebdb3fcce3dc 100644
> > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > @@ -3314,6 +3314,11 @@ static int kvm_handle_noslot_fault(struct kv=
m_vcpu *vcpu,
> > > >    {
> > > >    	gva_t gva =3D fault->is_tdp ? 0 : fault->addr;
> > > > +	if (fault->is_private) {
> > > > +		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> > > > +		return -EFAULT;
> > > > +	}
> > > > +
> > >=20
> > > As mentioned in another reply in this series, unless I am mistaken, f=
or TDX
> > > guest the _first_ MMIO access would still cause EPT violation with MM=
IO GFN
> > > being private.
> > >=20
> > > Returning to userspace cannot really help here because the MMIO mappi=
ng is
> > > inside the guest.
> >=20
> > That's a guest bug.  The guest *knows* it's a TDX VM, it *has* to know.=
  Accessing
> > emulated MMIO and thus taking a #VE before enabling paging is nonsensic=
al.  Either
> > enable paging and setup MMIO regions as shared, or go straight to TDCAL=
L.
>=20
> +Kirill,
>=20
> I kinda forgot the detail, but what I am afraid is there might be bunch o=
f
> existing TDX guests (since TDX guest code is upstream-ed) using unmodifie=
d
> drivers, which doesn't map MMIO regions as shared I suppose.
>=20
> Kirill,
>=20
> Could you clarify whether TDX guest code maps MMIO regions as shared sinc=
e
> beginning?

Y'all get the same answer we gave the SNP folks: KVM does not yet support T=
DX,
so as far is KVM is concerned, there is no existing functionality to suppor=
t.

s/firmware/Linux if this is a Linux kernel problem.

  On Thu, Feb 08, 2024, Paolo Bonzini wrote:
  > On Thu, Feb 8, 2024 at 6:27=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
  > > No.  KVM does not yet support SNP, so as far as KVM's ABI goes, there=
 are no
  > > existing guests.  Yes, I realize that I am burying my head in the san=
d to some
  > > extent, but it is simply not sustainable for KVM to keep trying to pi=
ck up the
  > > pieces of poorly defined hardware specs and broken guest firmware.
  >=20
  > 101% agreed. There are cases in which we have to and should bend
  > together backwards for guests (e.g. older Linux kernels), but not for
  > code that---according to current practices---is chosen by the host
  > admin.
  >=20
  > (I am of the opinion that "bring your own firmware" is the only sane
  > way to handle attestation/measurement, but that's not how things are
  > done currently).

