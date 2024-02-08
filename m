Return-Path: <linux-kernel+bounces-58463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4849A84E6CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9BDB2A6C7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278A77B3C2;
	Thu,  8 Feb 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a12FjRP+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C039080C05
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413450; cv=none; b=SHAuDafBqPWSa4Q10t/mnxt5fsvkDK8PPCeQdDoXSNgRIrX8BVsPeumpjXlC31bPjAFgwbRg/04mQMSzWUJvdWRK3bCFVmemMPVOSmSa0VovrxEOrC3NA5qlFmg9qxRBLO3EYIACg4G5onNPW/C5+znWD5d2Mf8GLNAp/Dqg6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413450; c=relaxed/simple;
	bh=1IQJLk1ty4Cbv9srUf/jkoJhkkc0s4qbS6Kv1KMw1nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSmYaplGHwKNgUDm9nwTqB3sAzDhuwy92UvjDFPfThn72Cd4E3EZai4HsfI3O6+J4dZ+jp2b80zBpBI5F7Ib6y7iYqeomU12CWitKbW4tVBX2BLQMs+4qF1rkTrmEJuRI4qrYm39XI7VToqsNtTsAs6o/tFJtJmLE7jIwaRRJ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a12FjRP+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707413447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6sek37PEy2MZoPmgCe0RKHy1EATtqvffN4QHzb+4/dw=;
	b=a12FjRP+LdNnDXJCBACmwQcs59sJfRLqD3RHmG67rNOtbwCbXMvo4mLQwpDnpO09iBA6Ct
	eNkKCKNNXIq0D7vWXPuH0uD3N0MmIF4F525G+p7OGnfEHwsQYZpJA14A42HMGi7rxb+LD/
	T5Snt7tXrm0eV9Dz9AviqPfX+PrdNo4=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-P22isv3TMESPgyBjAU3omg-1; Thu, 08 Feb 2024 12:30:46 -0500
X-MC-Unique: P22isv3TMESPgyBjAU3omg-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7d2dfa4c63dso6151241.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 09:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413445; x=1708018245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sek37PEy2MZoPmgCe0RKHy1EATtqvffN4QHzb+4/dw=;
        b=EDbG6uJ53AG+DhAs/dWFjauCrpQfLRrXTYfb6XV6AqjDL3Ff2FoMXi/+b5IcDn/3GD
         C288JtzaCQF0nwhlaAJbhzOGqIvAZRzw5LB8A2T2gYshYFpcjfVW4U5MQEUHl9RngAmI
         LIlVsxoeYsWTIrdOnibfhJYpzAAuDkTAugwdlwNNLUKXqo7FCmJHAWTVrXYjgEYA2rkn
         +0sK1D+vfhCYXmB5mM/JgRDHwUmj2Fd9lypgGCckhe3OTHzUxBXFhz04KH0D47AY5mrr
         BiUJlXu5/RSsYTVEhYIieeCAKWMTg9Ak4WaxYbiFqwif9wkigMm9l+bleOsIHUlLtASD
         irsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2MTWrjPKqVU/7Bt8w8oh3tWtEt9SusaIEI0KzdacLoLPpuBvNGqC+cT7+y6dew7kbkCwFVI0ZxmmVo8FFm/p9+Hh3GGebXX8hUK7c
X-Gm-Message-State: AOJu0YyVV/B0uH78Tp+PHnFgAneelxjaP3CHjnmEgfWXfJFtCkfjbsLo
	JaAfjrZJ9zCCnmGIHC28foBHOUQlNCQCr2YbdAahprUhKgFyI6r4Ea5qD5K5Ipadd0xXkMrwDHQ
	DUUaC1Y/UgMEQf3wTTpahfSVPIXtAZs33POo8HYkaHc6xQYoKTvpqCQlafnO8sZ92pt/r2//5Ec
	HWgtNv+Dr15cHzu43xjwsoKajqr7atr994/NG2
X-Received: by 2002:a05:6102:1158:b0:46d:5cb9:c3a0 with SMTP id j24-20020a056102115800b0046d5cb9c3a0mr2966153vsg.33.1707413445631;
        Thu, 08 Feb 2024 09:30:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHVJrEfvzHf07ew1SqpcL/nGkmHxsA0uPvjt9O5eXM69qEknptZPt4QM5pHUoRhFZH5bdOAnh06VotZpQb5AI=
X-Received: by 2002:a05:6102:1158:b0:46d:5cb9:c3a0 with SMTP id
 j24-20020a056102115800b0046d5cb9c3a0mr2966099vsg.33.1707413445212; Thu, 08
 Feb 2024 09:30:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016115028.996656-1-michael.roth@amd.com> <20231016115028.996656-9-michael.roth@amd.com>
 <ZbmenP05fo8hZU8N@google.com> <20240208002420.34mvemnzrwwsaesw@amd.com> <ZcUO5sFEAIH68JIA@google.com>
In-Reply-To: <ZcUO5sFEAIH68JIA@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 8 Feb 2024 18:30:31 +0100
Message-ID: <CABgObfa_KWVTk-yitCSU2aQi_a3vMTOMTHiT5s0qst5GtMwTzg@mail.gmail.com>
Subject: Re: [PATCH RFC gmem v1 8/8] KVM: x86: Determine shared/private faults
 based on vm_type
To: Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	isaku.yamahata@intel.com, ackerleytng@google.com, vbabka@suse.cz, 
	ashish.kalra@amd.com, nikunj.dadhania@amd.com, jroedel@suse.de, 
	pankaj.gupta@amd.com, thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 6:27=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> No.  KVM does not yet support SNP, so as far as KVM's ABI goes, there are=
 no
> existing guests.  Yes, I realize that I am burying my head in the sand to=
 some
> extent, but it is simply not sustainable for KVM to keep trying to pick u=
p the
> pieces of poorly defined hardware specs and broken guest firmware.

101% agreed. There are cases in which we have to and should bend
together backwards for guests (e.g. older Linux kernels), but not for
code that---according to current practices---is chosen by the host
admin.

(I am of the opinion that "bring your own firmware" is the only sane
way to handle attestation/measurement, but that's not how things are
done currently).

Paolo

> > > > +static bool kvm_mmu_fault_is_private(struct kvm *kvm, gpa_t gpa, u=
64 err)
> > > > +{
> > > > + bool private_fault =3D false;
> > > > +
> > > > + if (kvm_is_vm_type(kvm, KVM_X86_SNP_VM)) {
> > > > +         private_fault =3D !!(err & PFERR_GUEST_ENC_MASK);
> > > > + } else if (kvm_is_vm_type(kvm, KVM_X86_SW_PROTECTED_VM)) {
> > > > +         /*
> > > > +          * This handling is for gmem self-tests and guests that t=
reat
> > > > +          * userspace as the authority on whether a fault should b=
e
> > > > +          * private or not.
> > > > +          */
> > > > +         private_fault =3D kvm_mem_is_private(kvm, gpa >> PAGE_SHI=
FT);
> > > > + }
> > >
> > > This can be more simply:
> > >
> > >     if (kvm_is_vm_type(kvm, KVM_X86_SNP_VM))
> > >             return !!(err & PFERR_GUEST_ENC_MASK);
> > >
> > >     if (kvm_is_vm_type(kvm, KVM_X86_SW_PROTECTED_VM))
> > >             return kvm_mem_is_private(kvm, gpa >> PAGE_SHIFT);
> > >
> >
> > Yes, indeed. But TDX has taken a different approach for SW_PROTECTED_VM
> > case where they do this check in kvm_mmu_page_fault() and then synthesi=
ze
> > the PFERR_GUEST_ENC_MASK into error_code before calling
> > kvm_mmu_do_page_fault(). It's not in the v18 patchset AFAICT, but it's
> > in the tdx-upstream git branch that corresponds to it:
> >
> >   https://github.com/intel/tdx/commit/3717a903ef453aa7b62e7eb65f230566b=
7f158d4
> >
> > Would you prefer that SNP adopt the same approach?
>
> Ah, yes, 'twas my suggestion in the first place.  FWIW, I was just review=
ing the
> literal code here and wasn't paying much attention to the content.
>
> https://lore.kernel.org/all/f474282d701aca7af00e4f7171445abb5e734c6f.1689=
893403.git.isaku.yamahata@intel.com
>


