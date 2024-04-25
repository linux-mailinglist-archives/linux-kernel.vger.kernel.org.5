Return-Path: <linux-kernel+bounces-159287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565288B2CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F151F27688
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1F9155A57;
	Thu, 25 Apr 2024 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1g4Z3EUI"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3353155A56
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082129; cv=none; b=rQsvyc+IH+d78v23clpC8aGF5MZDYUzw1QAAq/zzSwuhmuVZQIusMMW+ZT0WfpusS9UcXM/CdvcjpE+dfzLPHn2RI6+Zx3UbUNXz4IS6w4Ven29XiRDxM0qwN2cbKVk82bZUCGNUenwBH7GYNHKfnlWGlw2mK1rVEOvkTNpRLXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082129; c=relaxed/simple;
	bh=BzOHcVMefmjvcTfGWEBm0nSE5WfFbU5ZjZjG3AMyzgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tbsLOFR8crMrtjxKDnk6tRn28/yYsXsdo7BDZXP3utM2nnjhvRhIQrCJRPaI3ZStZQKvBmVkaL/Z4zYowlbwl4YNfcOTPPgvk2b3v7p6ORIkChBOUaBiIANhUlC4SdgvIrS/VD8+2G+tV6fG8VEsRUdZrvWGrhQUduUrR9Nx1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1g4Z3EUI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a5066ddd4cso1609534a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714082127; x=1714686927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RsYl5l4pMgJWCav/WMt8FHwRjQ9Kn5L/ws+uvKXVHfw=;
        b=1g4Z3EUIHAjITa3TiStzyaCPhk7Oa7K+/mL7APFHifxfUQV/Wz7fFHNxCqu92dFK3H
         eoomFKJX03i8UyEPLOg+qgD0nDsH/uTZbSTTjf/sEtUGfgvdbWZh606mQmH48kWUoAFk
         76E72o/c/Iq843W3oboL6k3VH2GTtP3PdKOzANlS2kXC7qiLpPLspSQbQwzcUyC+5mAG
         eiRxunlE2jld/hsFSeFY+BFtcdkw61kQIRBREOmSgrZKLRH1fvo5ZuBQ8+QOZ/hw6PZQ
         hkD36UtADlq9QkwLR2HsuMQ++xiE4TN8qmD99CR7/MILkjjPG7kwz7fqXdsEGqS59IRi
         z+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082127; x=1714686927;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsYl5l4pMgJWCav/WMt8FHwRjQ9Kn5L/ws+uvKXVHfw=;
        b=FDFP2TVxOtj4TRAmU/cs8Blb9crG7mp1+SWEX349oqjMRdRDRrSVu/6wZvwEnRyAE+
         6TKg0OnGVlNFtHV6HVXbqp5KGkzw22tLZTiFCUzckxnExBL7kaGqEFzsMUtefpK1PsTr
         j9BQ7p/W7wz6bIGyrbSV9OeV25ZREZDrcJSdwwNB+ZYNMPDlzTsuIqUvHlAoDqqJNEx4
         Y/Owfim5bf6REGM+5CsW0pxBcY6qsMwEIqGzk0LGKT/MAeU1iPMqZNdgsvHPcwz5AmPP
         mcHxHX9Y5yn9Xoebz8hNP2ixxFqGj9tB3taG1GmvzS1aC+XhxaCaH6FwzA66ntBnJV6T
         fJ2w==
X-Forwarded-Encrypted: i=1; AJvYcCW53rOwbrYMW/VR10RjRCQs9LANG7zLy42P5PL83KhW1hoEZlXJ5M26zpmlsgCcNXHABHkz3BCHe8l4eEO+0WfFZWmSiMJN2kzEBYZv
X-Gm-Message-State: AOJu0Yxf1XNDeiGzyJgFpzJ6HCQidQ+nKzCzbOWc9yLGn6qZTeCR/WBx
	dWfOH5422m7hdm0z/EInMhYPRAsKw41yrcntca101l7oiJ4D2DKFEv3tglPjf7jgZ/c5kTYanl2
	qGw==
X-Google-Smtp-Source: AGHT+IHJjopOQrAy3bDBQrp6IQy93j3DR0aHwuFk/XSs4EC7EEAp9HrJQM06y5gG8vjnVdS4Ht9jUntHwjU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d396:b0:2af:3c8f:12bc with SMTP id
 q22-20020a17090ad39600b002af3c8f12bcmr46744pju.8.1714082127170; Thu, 25 Apr
 2024 14:55:27 -0700 (PDT)
Date: Thu, 25 Apr 2024 14:55:25 -0700
In-Reply-To: <20240425205245.aga3cyo5qa5xfnee@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240421180122.1650812-1-michael.roth@amd.com>
 <20240421180122.1650812-4-michael.roth@amd.com> <Zilp3Sp5S-sljoQE@google.com> <20240425205245.aga3cyo5qa5xfnee@amd.com>
Message-ID: <ZirRTVebhn-W8w7W@google.com>
Subject: Re: [PATCH v14 03/22] KVM: SEV: Add GHCB handling for Hypervisor
 Feature Support requests
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, jroedel@suse.de, 
	thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, pbonzini@redhat.com, 
	vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, 
	Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 25, 2024, Michael Roth wrote:
> On Wed, Apr 24, 2024 at 01:21:49PM -0700, Sean Christopherson wrote:
> > On Sun, Apr 21, 2024, Michael Roth wrote:
> > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > index 6e31cb408dd8..1d2264e93afe 100644
> > > --- a/arch/x86/kvm/svm/sev.c
> > > +++ b/arch/x86/kvm/svm/sev.c
> > > @@ -33,9 +33,11 @@
> > >  #include "cpuid.h"
> > >  #include "trace.h"
> > >  
> > > -#define GHCB_VERSION_MAX	1ULL
> > > +#define GHCB_VERSION_MAX	2ULL
> > >  #define GHCB_VERSION_MIN	1ULL
> > 
> > This needs a userspace control.  Being unable to limit the GHCB version advertised
> > to the guest is going to break live migration of SEV-ES VMs, e.g. if a pool of
> > hosts has some kernels running this flavor of KVM, and some hosts running an
> > older KVM that doesn't support v2.
> > 
> 
> The requirements for implementing the non-SNP aspects of the GHCB
> version 2 protocol are fairly minimal, and KVM_SEV_INIT2 is already
> migration incompatible with older kernels running KVM_SEV_ES_INIT (e.g.
> migrate to newer host, shutdown, start -> measurement failure). There
> are QEMU patches here that allow for controlling this via QEMU versioned
> machine types to handle this [1]
> 
> So I think it makes sense to go ahead move to GHCB version 2 as the base
> version for all SEV-ES/SNP guests created via KVM_SEV_INIT2, and leave
> KVM_SEV_ES_INIT restricted to GHCB version 1.

Hmm, I like that.  Dangle a carrot to get folks to switch to KVM_SEV_INIT2.

> This could be done in a pretty self-contained way for SEV-ES by applying
> the following patches from this series which are the version 2 protocol
> interfaces also applicable to SEV-ES:
> 
>   KVM: SEV: Add GHCB handling for Hypervisor Feature Support requests
>   KVM: SEV: Add support to handle AP reset MSR protocol
>   KVM: SEV: Add support for GHCB-based termination requests
> 
> And then applying the below patch on top to set GHCB version 1 or 2
> accordingly for SEV-ES. (and relocating the GHCB_VERSION_MAX bump to the
> below patch as well, although it's not really used at that point so
> could also just be dropped completely).
> 
> Then in the future we can extend KVM_SEV_INIT2 to allow specifying
> specific/newer versions of the GHCB protocol when that becomes needed.

Any reason not to let userspace restrict the GHCB protocol from the get-go?  It
seems inevitable that KVM will need to support that at some point, we'd have a
wee bit more confidence that we didn't botch the definition of KVM_SEV_INIT2 and
end up with KVM_SEV_INIT3, and in the unlikely event some poor provider gets into
a situation where guests are crashing because they don't handle v2 correctly,
userspace can workaround the issue without need to extend KVM's uAPI.

> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 28140bc8af27..229cb630b540 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -87,6 +87,7 @@ struct kvm_sev_info {
>  	struct list_head regions_list;  /* List of registered regions */
>  	u64 ap_jump_table;	/* SEV-ES AP Jump Table address */
>  	u64 vmsa_features;
> +	u64 ghcb_version;	/* Highest guest GHCB protocol version allowed */

This can/should be a u16, no?

>  	struct kvm *enc_context_owner; /* Owner of copied encryption context */
>  	struct list_head mirror_vms; /* List of VMs mirroring */
>  	struct list_head mirror_entry; /* Use as a list entry of mirrors */

