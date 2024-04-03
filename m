Return-Path: <linux-kernel+bounces-130479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C197D8978CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C5FB2B5F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B56154BF1;
	Wed,  3 Apr 2024 18:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VVKsuhdq"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A22C15443A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170675; cv=none; b=nSeNc0Tg+/n/tLuvtBNM75j8WenYzpwvxnTxQdlL6wes0uet0j0sCfIsIIXn5QMLlyCrJDP12XpprVm3EgWLtN58VZNqIJgja9F3XhnvNQs6zAUszjkjFPjgrdKZ6Ov/R0PhXbWMNVSvLlcSQ3Z6J4DN8oTS10oLiSH7ogts3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170675; c=relaxed/simple;
	bh=VCwseDRS3dH3F4RP475OT1y3yFT5wh4XfK3fMdZed10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QThS6H/mYCoVHQBCZiPOrDbuDPEX3NdF19UdCxXhjUumlt/x+yxrtd4wDc1ROuK73/eBuwcygmICKFcvW3Q2P2bMCKipeYECsp+3Y3jg6HW01k+hSWcHdL2c1F9QwXCqdCeX0ri0+8lOZ/yKAgvEXMPlqX/4oyswA1Z9WSF5MU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VVKsuhdq; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ea80a33cf6so108354b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712170674; x=1712775474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6D4+Csx/H66fuN0gEWyFJ3602T63PEUSY/egYj1Tek=;
        b=VVKsuhdqjGoiEOE5BIgAYJXQOrSxUsZS7zIf/pgRzdP01SBTSpyVBasfwIuYIrq9Qf
         hfzY8UXSN14TSDrTNau2BzmmBppNLebg72gUZKmWDCzRh9lYyi+TmAjdW8H/HlLXXy2Z
         0+Zz9N27W3UYhHt8VduRLWI+S5jtd/6g5Dkn6fL/ScyjOYbY214d5TyRF38yKa7+kmq1
         4GdJJDg4NpbHj5V6vKEYwPCjX4arwH+U/uy9l8Bzb3Qsd6NmWd+klh7lPjdWWrIDfLGH
         gks4UH7J/PJQGotHc0PdYAcG5u7dwUpfHJViyX3cBXtBqoaMpnoFuAHn7+ar/ksNG+cH
         2x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712170674; x=1712775474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6D4+Csx/H66fuN0gEWyFJ3602T63PEUSY/egYj1Tek=;
        b=Lx0+D1IT50PCK4zqL+OX4MlbUTMD7TRZLafa9fl0+2Ez8Xp8GATATEovg4ueOMwUwo
         LIPr/dG4dcjkhE5pHLp6WknbXnCNY/yDpT2pKYn4CilhQls/Etumx+Af7cyavL1Mu6Js
         87zyGyggCi0gsNXWIiRy754U+hF8EHV3gdFl55ylwXoB48g0B4QTWocyFcE3MhbKTOzH
         +ySEtkJzONrFTnnM00j9N2Qoj2wAXr7CeJFgbXk3A/i7hWLzt1iOwj9Oa9qIpowiXlWR
         +ajAqB1g33/N5xoYZj7WoCh9XNCLHNaIgS9ANC3ULr1YuXm5s27helUssXP1PhM6EGQH
         p7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVn8dMXvwPmJ5n4hDizYfmTe8c8mgAs9dhFyDx4ZlH9dFLMvkiUn4MYV5LFHWna+Orq4GpRCzsPM3XfNwCC85WhVtkMNAZpHLd8Ijlr
X-Gm-Message-State: AOJu0Yy4GlROUk5GImDVrzWPyo3yHTgToApGol5O5HKH4OT8qNmT4cRB
	kDUFcrHim4hTLURyMZ0/LlDET4jr4/yka+ThOAWCgnG+fzLhxSlKX5L/gRv3HKairqC9w2W9K7c
	G6w==
X-Google-Smtp-Source: AGHT+IGSfcmG/cgqkT8mk/sOij3zo2TrmnCSUo9i4s8ZEzOAKnvTQcTZ6PJy7nE55fdROYLozfhDSuzqvJM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2e1b:b0:6ea:8a0d:185f with SMTP id
 fc27-20020a056a002e1b00b006ea8a0d185fmr18248pfb.2.1712170673887; Wed, 03 Apr
 2024 11:57:53 -0700 (PDT)
Date: Wed, 3 Apr 2024 11:57:52 -0700
In-Reply-To: <2a369e6e229788f66fb2bbf8bc89552d86ba38b9.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309012725.1409949-1-seanjc@google.com> <20240309012725.1409949-2-seanjc@google.com>
 <2a369e6e229788f66fb2bbf8bc89552d86ba38b9.camel@intel.com>
Message-ID: <Zg2msDI9q_7GcwHk@google.com>
Subject: Re: [PATCH v6 1/9] x86/cpu: KVM: Add common defines for architectural
 memory types (PAT, MTRRs, etc.)
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "luto@kernel.org" <luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Xin3 Li <xin3.li@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Shan Kang <shan.kang@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 27, 2024, Kai Huang wrote:
> On Fri, 2024-03-08 at 17:27 -0800, Sean Christopherson wrote:
> > Add defines for the architectural memory types that can be shoved into
> > various MSRs and registers, e.g. MTRRs, PAT, VMX capabilities MSRs, EPTPs,
> > etc.  While most MSRs/registers support only a subset of all memory types,
> > the values themselves are architectural and identical across all users.
> > 
> > Leave the goofy MTRR_TYPE_* definitions as-is since they are in a uapi
> > header, but add compile-time assertions to connect the dots (and sanity
> > check that the msr-index.h values didn't get fat-fingered).
> > 
> > Keep the VMX_EPTP_MT_* defines so that it's slightly more obvious that the
> > EPTP holds a single memory type in 3 of its 64 bits; those bits just
> > happen to be 2:0, i.e. don't need to be shifted.
> > 
> > Opportunistically use X86_MEMTYPE_WB instead of an open coded '6' in
> > setup_vmcs_config().
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> 
> [...]
> 
> >  
> >  #include "mtrr.h"
> >  
> > +static_assert(X86_MEMTYPE_UC == MTRR_TYPE_UNCACHABLE);
> > +static_assert(X86_MEMTYPE_WC == MTRR_TYPE_WRCOMB);
> > +static_assert(X86_MEMTYPE_WT == MTRR_TYPE_WRTHROUGH);
> > +static_assert(X86_MEMTYPE_WP == MTRR_TYPE_WRPROT);
> > +static_assert(X86_MEMTYPE_WB == MTRR_TYPE_WRBACK);
> > +
> > 
> 
> Hi Sean,
> 
> IIUC, the purpose of this patch is for the kernel to use X86_MEMTYPE_xx, which
> are architectural values, where applicable?

Maybe?  Probably?

> Yeah we need to keep MTRR_TYPE_xx in the uapi header, but in the kernel, should
> we change all places that use MTRR_TYPE_xx to X86_MEMTYPE_xx?  The
> static_assert()s above have guaranteed the two are the same, so there's nothing
> wrong for the kernel to use X86_MEMTYPE_xx instead.
> 
> Both PAT_xx and VMX_BASIC_MEM_TYPE_xx to X86_MEMTYPE_xx, it seems a little bit
> odd if we don't switch for MTRR_TYPE_xx.
> 
> However by simple search MEM_TYPE_xx are intensively used in many files, so...

Yeah, I definitely don't want to do it in this series due to the amount of churn
that would be required.

  $ git grep MTRR_TYPE_ | wc -l
  100

I'm not even entirely convinced that it would be a net positive.  Much of the KVM
usage that's being cleaned up is flat out wrong, e.g. using "MTRR" enums in places
that having nothing to do with MTRRs.  But the majority of the remaining usage is
in MTRR code, i.e. isn't wrong, and is arguably better off using the MTRR specific
#defines.

