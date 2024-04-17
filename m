Return-Path: <linux-kernel+bounces-149197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CDA8A8D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3751F2170A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C533D54C;
	Wed, 17 Apr 2024 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZ1py54b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D352C69A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386239; cv=none; b=qjiMjdIdJoB8A/I1l46ZRq1K69+iORNMm/mChX+cnC/jzp/yQxeUV1geV2AgtpiWbiqnlPt9MFiQ7a03/s8jaKatrwv0h/CmszWjoKGNqBEMqxf4pgYWWIYcd8bkGjP4ufQjWC59TZzV0PDEXPds05ovDzWyngPdn8V6hwmP0DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386239; c=relaxed/simple;
	bh=0fxrj0l4TnhUB9V5QYOGnaaFLDoyHeRuV75JKhy5UeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCUBn3jzgOAXdFWiETypWx9oR6D0vRKCMyyGF/2Wq4SwZp0+J0gEmOjOsQdLW0rqVJJXM2JFItxVJFrkL3Zaqut+uv29qkKD17ck618qM1NPPPn6jCkwasWbvRuXwrYDTmu4TqYXLjLR0nS0SfR9gikNiITTm+BLYG3Ewit5Iv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZ1py54b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713386236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OjOuibrnAqJkR6ILH2qe3B2MC0JgGVAzLdrU1EZavU=;
	b=TZ1py54bDFPY2lOa/4Y8fXEdOa+E8BV6QrLDWpn9lmrhufDcrnLCZ0yFpqg+fqC3o/Q+sR
	iRnxZTunHJ2dZ15ZGXnzTzbrWt5mwCMLAm4z6vI/RMaMHtKI1ikUfXVq1Rh5DTgheijdOp
	wo43ky4dixPyMyTuW3O7MU35SwvARII=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-SOsGMfxOOd6ceGPmCzFXOQ-1; Wed, 17 Apr 2024 16:37:15 -0400
X-MC-Unique: SOsGMfxOOd6ceGPmCzFXOQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343e775c794so80060f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713386234; x=1713991034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OjOuibrnAqJkR6ILH2qe3B2MC0JgGVAzLdrU1EZavU=;
        b=j+4j2z8QFeLbQWkEs35TVmESmADElHs57MdlHNQXRX3B7QdZ7kKR5f2Ms6Ni9D9E3f
         ImzGkQMvgUthQ6wn73xTGGpssEpka4f1DEgdz7ab8V8ddfmLg+30J133yI/5D2yN+9PQ
         uV27cDz5nZV5zdw6wgqfRB8/ARNidqugBm0bUAKd2ZZv8a/jacj+b6KYQdapu20acLLe
         z1NbgHw/LmEElFzm/iYVa2vabIn/ELoh5EolmwgtmnZpQCptqynSIlfaCUfmPtGKD1Qt
         h5w4cdPUKAizGagSQ7Ua0fDDvXdjbW6S+2Gv2TdwPxEyiIOB2cg0N0ielPUFmcQj/X2A
         6Rbg==
X-Gm-Message-State: AOJu0Yym1yCFE1Z3Bp6yuiVe3abaotT59EvKauIst716AO+D4YCc+0EN
	H28GhP6PTK3Zgy3r6+CCPEqt9AnSiBBUAgy9fqNgoJf9/TBV9VeifwgiWfCCv73WNZFDa71EXk0
	yF2ph235Ptr60Ewk1FE6H91j/cKTyV74WYSfNh3BmcgJ2IoDvd02PCTrKoa90RCw2ndi5YUib6u
	jIGecmjIo0XXAn9PBf3X/6bJgpr3AP6NW/ueBt
X-Received: by 2002:adf:ff8d:0:b0:349:f8a1:cd6a with SMTP id j13-20020adfff8d000000b00349f8a1cd6amr278175wrr.16.1713386233842;
        Wed, 17 Apr 2024 13:37:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU9ndjqJmTepwAVDhSHoIewhE9kNn3HqYSbmjhx5WoLKj6UhTkzOn107FxBNx5uL5nlfOAr0w6pwnk1bvOhf4=
X-Received: by 2002:adf:ff8d:0:b0:349:f8a1:cd6a with SMTP id
 j13-20020adfff8d000000b00349f8a1cd6amr278165wrr.16.1713386233462; Wed, 17 Apr
 2024 13:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417153450.3608097-1-pbonzini@redhat.com> <20240417153450.3608097-2-pbonzini@redhat.com>
 <ZiAw1jd8840jXqok@google.com>
In-Reply-To: <ZiAw1jd8840jXqok@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2024 22:37:00 +0200
Message-ID: <CABgObfYNNgpwOWFNmhHED7wL72Gi7sbFi5_ED_B7f-BUO+nrZg@mail.gmail.com>
Subject: Re: [PATCH 1/7] KVM: Document KVM_MAP_MEMORY ioctl
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com, 
	rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 10:28=E2=80=AFPM Sean Christopherson <seanjc@google=
com> wrote:
>
> On Wed, Apr 17, 2024, Paolo Bonzini wrote:
> > +4.143 KVM_MAP_MEMORY
> > +------------------------
> > +
> > +:Capability: KVM_CAP_MAP_MEMORY
> > +:Architectures: none
> > +:Type: vcpu ioctl
> > +:Parameters: struct kvm_map_memory (in/out)
> > +:Returns: 0 on success, < 0 on error
> > +
> > +Errors:
> > +
> > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +  EINVAL     The specified `base_address` and `size` were invalid (e.g=
 not
> > +             page aligned or outside the defined memory slots).
>
> "outside the memslots" should probably be -EFAULT, i.e. keep EINVAL for t=
hings
> that can _never_ succeed.
>
> > +  EAGAIN     The ioctl should be invoked again and no page was process=
ed.
> > +  EINTR      An unmasked signal is pending and no page was processed.
>
> I'm guessing we'll want to handle large ranges, at which point we'll like=
ly end
> up with EAGAIN and/or EINTR after processing at least one page.

Yes, in that case you get a success (return value of 0), just like read().

> > +  EFAULT     The parameter address was invalid.
> > +  EOPNOTSUPP The architecture does not support this operation, or the
> > +             guest state does not allow it.
>
> I would phrase this as something like:
>
>                 Mapping memory given for a GPA is unsupported by the
>                 architecture, and/or for the current vCPU state/mode.

Better.

> > +  struct kvm_map_memory {
> > +     /* in/out */
> > +     __u64 base_address;
>
> I think we should commit to this being limited to gpa mappings, e.g. go w=
ith
> "gpa", or "guest_physical_address" if we want to be verbose (I vote for "=
gpa").
>
> > +     __u64 size;
> > +     /* in */
> > +     __u64 flags;
> > +     __u64 padding[5];
> > +  };
> > +
> > +KVM_MAP_MEMORY populates guest memory in the page tables of a vCPU.
>
> I think we should word this very carefully and explicitly so that KVM doe=
sn't
> commit to behavior that can't be guaranteed.  We might even want to use a=
 name
> that explicitly captures the semantics, e.g. KVM_PRE_FAULT_MEMORY?
>
> Also, this doesn't populate guest _memory_, and "in the page tables of a =
vCPU"
> could be interpreted as the _guest's_ page tables.
>
> Something like:
>
>   KVM_PRE_FAULT_MEMORY populates KVM's stage-2 page tables used to map me=
mory
>   for the current vCPU state.  KVM maps memory as if the vCPU generated a
>   stage-2 read page fault, e.g. faults in memory as needed, but doesn't b=
reak
>   CoW.  However, KVM does not mark any newly created stage-2 PTE as Acces=
sed.
>
> > +When the ioctl returns, the input values are updated to point to the
> > +remaining range.  If `size` > 0 on return, the caller can just issue
> > +the ioctl again with the same `struct kvm_map_memory` argument.
>
> This is likely misleading.  Unless KVM explicitly zeros size on *every* f=
ailure,
> a pedantic reading of this would suggest that userspace can retry and it =
should
> eventually succeed.

Gotcha... KVM explicitly zeros size on every success, but never zeros
size on a failure.

> > +In some cases, multiple vCPUs might share the page tables.  In this
> > +case, if this ioctl is called in parallel for multiple vCPUs the
> > +ioctl might return with `size` > 0.
>
> Why?  If there's already a valid mapping, mission accomplished.  I don't =
see any
> reason to return an error.  If x86's page fault path returns RET_PF_RETRY=
, then I
> think it makes sense to retry in KVM, not punt this to userspace.

Considering that vcpu_mutex critical sections are killable I think I
tend to agree.

> > +The ioctl may not be supported for all VMs, and may just return
> > +an `EOPNOTSUPP` error if a VM does not support it.  You may use
> > +`KVM_CHECK_EXTENSION` on the VM file descriptor to check if it is
> > +supported.
>
> Why per-VM?  I don't think there's any per-VM state that would change the=
 behavior.

Perhaps it may depend on the VM type? I'm trying to avoid having to
invent a different API later. But yeah, I can drop this sentence and
the related code.

> The TDP MMU being enabled is KVM wide, and the guest state modifiers that=
 cause
> problems are per-vCPU, not per-VM.
>
> Adding support for KVM_CHECK_EXTENSION on vCPU FDs is probably overkill, =
e.g. I
> don't think it would add much value beyond returning EOPNOTSUPP for the i=
octl()
> itself.

Yes, I agree.

Paolo


