Return-Path: <linux-kernel+bounces-129761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60143896F9D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CF81F29781
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3748148308;
	Wed,  3 Apr 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSZBEQOv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF9146A9D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149001; cv=none; b=PfOKu6NlpOVr8aNIdwWd0Ezi1Ehh5TZoHm/Hf+FMbO4Zm4wyfWaZdoQCRHrRGTmzGrRWRL3zBMpWRIvYS7NanxDxwa1La0ixXGFxpjzHhg+63J9743dd+DMuaoQwlrNyY7dlGQzYTEiUeS572S4kS6H9fB0Svxrk5zMmjFZWaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149001; c=relaxed/simple;
	bh=k75X6e+xXR/2CHetkCcWpWKqu9lH9n9uyWfcUV8by6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2CHaerYTKmKWZNX63IWb9Vay+ZezMwFieeG1/ghquQFq7FnPSTXN+SJuugwS0Mr7H6WcvkNoqwAP3blsirsuJwBPIQ2w9MaizN09zK4vDmEEFsazJ7vzhdgn2EyoGk2g2FLNYkdi7Uq21zQyrGkgOU0ic6cLYx3Bk20z4PM1xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSZBEQOv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712148999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yewPQMR0S+4mdQyXSXgCBzYxRYzMDeDenPXpOjBMmY=;
	b=fSZBEQOvTc0wfYf0KXWHfNGI8sImRmBBDuHVj2nAs4CJ1LAudBlDctCdQx45y61a1zzeNd
	v9euQ2ATcxDfxfKciRK5TdKspHEcJsTEr+blmT4vEe5rooEwHsJQIpzMRKKlOuStz6+60B
	YfND0lCs7lROtGgzMjx5rgKx/E1YvPo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-psCWXIyzOb2h_kKiSYNUhw-1; Wed, 03 Apr 2024 08:56:38 -0400
X-MC-Unique: psCWXIyzOb2h_kKiSYNUhw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d8d208be9so4109359f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 05:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712148997; x=1712753797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yewPQMR0S+4mdQyXSXgCBzYxRYzMDeDenPXpOjBMmY=;
        b=s9dtrFbBTKnIfhnPGIor2jonfsmvSL6fzUyMnSoCiSLJTVEmjVIu6GxlIEn7kkyyBD
         v4H8smdXKhc9J948i3qckLoHSdBvtq0h6AncVQJwTzhZyuSlYLHir3d/79hA1Oi4CjKM
         HRIdKd+EsvkZ+/wdIDHpYxMF5Nr2U1zYeNs3khkfFLtW8kZy0DUjpDkVRsE84Quh+Dsw
         Yh6prDfps7U1+njwgYV37ZoY6qWcgn4eVY/mxbaVoFnL0DW6/QEF6G0k2GCohCbdc0gM
         ysGtrVlBQh3d57wLDyn/XVzNMvlx0qfhm411RUHZJE0SnXm85+00V/nEs1iL89fCIGeD
         XUsw==
X-Forwarded-Encrypted: i=1; AJvYcCUj5Rg6MoL+sz8oFGzsqef/BnD+d8aE6jdcNhMsr5CjkZqKOqLZz9+gkQmjZz5CXuhiUb6Hg6oMgonMF8esef8dTuB8WAJ5gn02Q5kC
X-Gm-Message-State: AOJu0YwjSN5o5oCCjGFUdk9ftLnNVGSee4CxuymQ/tKCPOVbRr5kkucQ
	C0TOERYCUzy74RcgnwbucmL60MhsjplKMy0FfOebEHYfDjNZEAFvrjbkm5Yd7H8579WXupfchgC
	TX9OjcPzSV2aKA1jiDMgM5h+i1q8bBZjV5VVpxhxWoIwkB7KNJmtAeOdv7E68pA8ctg5OlQzSwl
	Txz76qutiK4xFZ3qoYLoJYot5AASdRnJRcvVHS
X-Received: by 2002:a5d:6585:0:b0:343:8551:8d90 with SMTP id q5-20020a5d6585000000b0034385518d90mr2514213wru.34.1712148996811;
        Wed, 03 Apr 2024 05:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE6EvC96kkgT6mLgn0vUrYteEazg+ord6iBHG8W1WaPauUUkwzs1ek0iVVbDOhQrMvTDS6MXHEqaCEHyYWr0U=
X-Received: by 2002:a5d:6585:0:b0:343:8551:8d90 with SMTP id
 q5-20020a5d6585000000b0034385518d90mr2514173wru.34.1712148996414; Wed, 03 Apr
 2024 05:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329225835.400662-1-michael.roth@amd.com> <20240329225835.400662-13-michael.roth@amd.com>
 <40382494-7253-442b-91a8-e80c38fb4f2c@redhat.com> <20240401231731.kjvse7m7oqni7uyg@amd.com>
In-Reply-To: <20240401231731.kjvse7m7oqni7uyg@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 3 Apr 2024 14:56:25 +0200
Message-ID: <CABgObfYPT8yLvCDdc0B+4t4xCbk8deZg_G0_QVY_DcR_7--xSw@mail.gmail.com>
Subject: Re: [PATCH v12 12/29] KVM: SEV: Add KVM_SEV_SNP_LAUNCH_FINISH command
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, jroedel@suse.de, 
	thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, seanjc@google.com, 
	vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, 
	Brijesh Singh <brijesh.singh@amd.com>, Harald Hoyer <harald@profian.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 1:18=E2=80=AFAM Michael Roth <michael.roth@amd.com> =
wrote:
>
> On Sat, Mar 30, 2024 at 09:41:30PM +0100, Paolo Bonzini wrote:
> > On 3/29/24 23:58, Michael Roth wrote:
> > >
> > > +           /* Handle boot vCPU first to ensure consistent measuremen=
t of initial state. */
> > > +           if (!boot_vcpu_handled && vcpu->vcpu_id !=3D 0)
> > > +                   continue;
> > > +
> > > +           if (boot_vcpu_handled && vcpu->vcpu_id =3D=3D 0)
> > > +                   continue;
> >
> > Why was this not necessary for KVM_SEV_LAUNCH_UPDATE_VMSA?  Do we need =
it
> > now?
>
> I tried to find the original discussion for more context, but can't seem =
to
> locate it. But AIUI, there are cases where a VMM may create AP vCPUs earl=
ier
> than it does the BSP, in which case kvm_for_each_vcpu() might return an A=
P
> as it's first entry and cause that VMSA to get measured before, leading
> to a different measurement depending on the creation ordering.

I think that would be considered a bug in either the VMM or the
"thing" that computes the measurement.

If that hasn't been a problem for SEV-ES, I'd rather keep the code simple.

> We could however limit the change to KVM_X86_SEV_ES_VM and
> document that as part of KVM_SEV_INIT2, since there is similarly chance
> for measurement changes their WRT to the new FPU/XSAVE sync'ing that was
> added.

Hmm, I need to double check that the FPU/XSAVE syncing doesn't break
existing measurements, too.

Paolo


