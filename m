Return-Path: <linux-kernel+bounces-99688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5E1878BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EC3281E28
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA5565C;
	Tue, 12 Mar 2024 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="birIeGsB"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A719B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710202126; cv=none; b=eiwLk9CGPh7FakcmLonfJDdl6oflgYKPB8hhPUZwgcBy11Prh89HGO+Pqzv4ArWWAn5YAogTyn+BSDAW/iiO9Sr913Xg/FeTO/Own8nnWsoS232uXBexGPLpAbJIO3XtYB43XJtFS7b49CfLxtL7YzWmUakarCpkRBhjn6VR1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710202126; c=relaxed/simple;
	bh=0Yb12pPEmKrsC1pLW8reJgDFPcWSOLnjlFPRgboKnzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GG4IS9FgKA/0JIbBTY1la2E5lFeXs1GflP/b40FeSWpG8REjOR7w84j3QYfmq7qRLBIg/TFHm3gH0JQeV59y60mGkQ1OULcF0DY1jcY/l+OSUPfjWsMxqSUdiqlcDQPkZVoivlTxDFhauDXmF+W9Pn/R3GXx2ewKqriL7uZNfDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=birIeGsB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd169dd4183so123557276.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710202124; x=1710806924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+d74PXd4taKq/kej/o6mNWve0XFGzP2O6HVRwkMDONA=;
        b=birIeGsBBaAQIffVUzrsSkdieJBLwk7eZdpIOPCXTqlADokw1+d/KcrsIhieBq67uH
         xDVqBjEMll/LUgDtNKkYOfO/gkSQyGbHUVMMrXcPbN9GUyIIVeS7QdRFAFb9B/6wHysY
         +ErhaYewCw0Q5kMAq7C4v33IM9CUgjBWLbizzanf8uRAFKzsRIqY8wPp7hXmF+H/4lWr
         ZR2cSLBWJOug8HxXdYbP/RFd65BsDybx1OOYkaGlNpGyyjE5H20uFXRFhkG5Rm0ruFw1
         cLlyRsVqRn9Z3Ljfubmk5U6Y0qSHoR9WoTr0kGtJnARq+dlOwbH7s+QoFfPnZY9aV7sC
         mr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710202124; x=1710806924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+d74PXd4taKq/kej/o6mNWve0XFGzP2O6HVRwkMDONA=;
        b=Tr1VJxI/c24R24NiFqMKbbaZ0FvKZxbHyxaKkSqIYMSkaaxqT4xjmPpCNb39n0+Sz9
         1aVWYHFIuqKtMpVDMkQCGjP1WsSjZbMdbPH1RVZ+jZaWix6otSTr1CYxIavz2Pq3a6rX
         ri/uXIy1gOpjQtgrZBWWv7EQWdbjl5Oi6zFX5KFVWHpRyhKVx0oRN4BxYpmfy1AkMiSL
         5qHwoAuXUo85SLhNtcxCX3GydTas38pe+WZjUReEbkaN7SvZ1JeRWJ7rECm/UhQJB7gr
         58+4c0SKfHPPGoRgG//3TTLRKjStlRAZvup56P5uBE6iBoBnjHtQ28By7XMkuhSJLYsJ
         DXUg==
X-Forwarded-Encrypted: i=1; AJvYcCUdFuDCQY0cIlDGcspf+3d3zMlVtPiwTuFFdXJ7hLJcbKjLxkpoJizlm8x9xG48rlIgS+irSJ7FEM1/1hljMWbWRsDvOYpVuGtCLBrS
X-Gm-Message-State: AOJu0YwS12ECGTon2XwbCW4ry11qALSSGDak1bkpfRiEVIG8e2+Eisn9
	elyzeNGSNJIAY8isJ4VR8EaqnadxmwwwdbyUUShVZNqByc9o4pzGrO6rvse82Jnotxzg9JXJPi/
	THQ==
X-Google-Smtp-Source: AGHT+IFKY3pZHfuOr1Yij7OhUEHiSO8WW9VIgdjvPIWPfwcBwVP8Sm713pwSINrR33+2phQXB5qutd145N4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ab6f:0:b0:dcd:3a37:65 with SMTP id
 u102-20020a25ab6f000000b00dcd3a370065mr414308ybi.7.1710202124212; Mon, 11 Mar
 2024 17:08:44 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:08:42 -0700
In-Reply-To: <Ze62bqgWhbReg9wl@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com> <20240309010929.1403984-2-seanjc@google.com>
 <Ze62bqgWhbReg9wl@yzhao56-desk.sh.intel.com>
Message-ID: <Ze-dCirMCOCsbsVJ@google.com>
Subject: Re: [PATCH 1/5] KVM: x86: Remove VMX support for virtualizing guest
 MTRR memtypes
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, kvm@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 11, 2024, Yan Zhao wrote:
> On Fri, Mar 08, 2024 at 05:09:25PM -0800, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 7a74388f9ecf..66bf79decdad 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -7596,39 +7596,27 @@ static int vmx_vm_init(struct kvm *kvm)
> >  
> >  static u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
> >  {
> > -	/* We wanted to honor guest CD/MTRR/PAT, but doing so could result in
> > -	 * memory aliases with conflicting memory types and sometimes MCEs.
> > -	 * We have to be careful as to what are honored and when.
> > -	 *
> > -	 * For MMIO, guest CD/MTRR are ignored.  The EPT memory type is set to
> > -	 * UC.  The effective memory type is UC or WC depending on guest PAT.
> > -	 * This was historically the source of MCEs and we want to be
> > -	 * conservative.
> > -	 *
> > -	 * When there is no need to deal with noncoherent DMA (e.g., no VT-d
> > -	 * or VT-d has snoop control), guest CD/MTRR/PAT are all ignored.  The
> > -	 * EPT memory type is set to WB.  The effective memory type is forced
> > -	 * WB.
> > -	 *
> > -	 * Otherwise, we trust guest.  Guest CD/MTRR/PAT are all honored.  The
> > -	 * EPT memory type is used to emulate guest CD/MTRR.
> > +	/*
> > +	 * Force UC for host MMIO regions, as allowing the guest to access MMIO
> > +	 * with cacheable accesses will result in Machine Checks.
> This does not always force UC. If guest PAT is WC, the effecitve one is WC.

Doh, right, I keep forgetting that KVM doesn't ignore guest PAT for MMIO.

