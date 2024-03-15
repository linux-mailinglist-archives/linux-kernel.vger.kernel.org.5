Return-Path: <linux-kernel+bounces-104755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB7F87D31F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387AF1F242AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A76C4D13B;
	Fri, 15 Mar 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="04cfUQk2"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356944CB2B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710525258; cv=none; b=jxOt1Vrxdei6tux96x9e+R1OcttcFjg9Czc/XzaQro6YXo4t19jactZi6RB9vPE9NL3dBrvH4LMzsbbcAAPZqsXdX6GJlG6aNBdQL7IqPOILy+EaNJadkyzJALwTtiCVibJ4a42ePDiCQowpY8CR1hES2CzElEB78cz5qze18WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710525258; c=relaxed/simple;
	bh=lz9UOu8zwPxOJOC9JnglDqWSmLeWMHfg3F8fVmAosDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pfnGhvOFhwldekH2IRKdc29YdRrV16PAkowc+RR/QbFkQg/OGPj55VzgWhMgiMC0pp2/s5RpPwwJ2awRRm6WvuxJCDGHTgUupUOAu9DJ/0+i0cA1SJCPue1oiknFIv0WqFRWPx+edDyLljcfePV86IMOrlqwy9wxc0NQR2vKiuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=04cfUQk2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5c65e666609so2042876a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710525256; x=1711130056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCsDGVvQ5JoDUuAN7b8P1xADRPn/t2ImWR7kgkVi4o8=;
        b=04cfUQk2ojDZ8Zg9YW2+FbR9NI9xSkZMiv+3ZrwgTJ9EvZzyc70KJqVsGSCEZoNG0T
         3q34VZL/CJuJ7BWfZbKBXddBcNVvnFZeylWZFd4PRKZlzVSxeOLRDIqYL8f6roUu7P1q
         lswDwJswVZflZT7eCYYVDQr7sycroI9g9ljjZEhljJy/hf5nkSjE+VCOY7k0TYOTYlNW
         JqNhCAXxGCMpSX1Y1fCmWlHR+LV1Hf7Ad/FRWJpjUHdoKtjoIznqTdHOiYLpIqBAhdtB
         d92HPyeTo71mamND81M/GQfnZl1L8m1lg8gc1sIAPvze5HJbxA9+9C0Ry1dAZgY6HZY4
         EUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710525256; x=1711130056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCsDGVvQ5JoDUuAN7b8P1xADRPn/t2ImWR7kgkVi4o8=;
        b=iA1YZpcIljcYwHKJfLA/h8+2OblwZjaFrd+HOVZHjiFgZb4Wfk9BK2HBRztqjS2YKl
         1EE5122JZ+llMWaSC+PbflbGXfHdyGrarlRtH6oSelt5ozK6ABQHnLwHSTFzNXXEKlGV
         +2U+TIcXWUfKitdQ2SzSsHx3Ghzn4fw8m3wJQaAbJCXRP8MVByCVcw1y+w5m3y2NAkm+
         /AQ4Ne/+TbiaHtkK6DKHM+AfOnIo1dStxfIYyUlSFF7JXQxLxdvRfYs4eQ8p00jrRkX+
         TSxLDo6M8VLWVbhLEXDNlPmULHTDBVOzYLF6efgulD6aNAfqUuYRATCuJ5vvjl3TgoBr
         V2EA==
X-Forwarded-Encrypted: i=1; AJvYcCVru+OFwbwo8Lt6jHrhTNJs9/dG8Xs1cr34UvZA85HjpzP8dydD484TTo4arsFT9mbIWNA3WMllv/wdX0QmZ3wSZ6a8aK/lWcjDLgrr
X-Gm-Message-State: AOJu0Yyg/KXoHUaDTmh8KV/TXE+A75RTCZ7r3IJ0gwQFYhx+44ZGwsKp
	aaPKIup/Uw4Igys0sUDeN57UnoVgU9TEXJPcrKa+sRZDYNhRQD+pRn+rQBcgUgu1ffkC2AjT38O
	pIQ==
X-Google-Smtp-Source: AGHT+IGx3iU2+pXYgrsYlfzRD4L2SFsFI2Lh2FuJp29A8reYoyIdPfgXOZkztIK0oo4Aw0JFW3nQyT0NIVw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:6546:0:b0:5d6:cfc:2f39 with SMTP id
 z67-20020a636546000000b005d60cfc2f39mr13226pgb.11.1710525256443; Fri, 15 Mar
 2024 10:54:16 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:54:14 -0700
In-Reply-To: <ZfRtSKcXTI/lAQxE@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309012725.1409949-1-seanjc@google.com> <20240309012725.1409949-9-seanjc@google.com>
 <ZfRtSKcXTI/lAQxE@intel.com>
Message-ID: <ZfSLRrf1CtJEGZw2@google.com>
Subject: Re: [PATCH v6 8/9] KVM: VMX: Open code VMX preemption timer rate mask
 in its accessor
From: Sean Christopherson <seanjc@google.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Shan Kang <shan.kang@intel.com>, Kai Huang <kai.huang@intel.com>, Xin Li <xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 15, 2024, Zhao Liu wrote:
> On Fri, Mar 08, 2024 at 05:27:24PM -0800, Sean Christopherson wrote:
> > Use vmx_misc_preemption_timer_rate() to get the rate in hardware_setup(),
> > and open code the rate's bitmask in vmx_misc_preemption_timer_rate() so
> > that the function looks like all the helpers that grab values from
> > VMX_BASIC and VMX_MISC MSR values.

..

> > -#define VMX_MISC_PREEMPTION_TIMER_RATE_MASK	GENMASK_ULL(4, 0)
> >  #define VMX_MISC_SAVE_EFER_LMA			BIT_ULL(5)
> >  #define VMX_MISC_ACTIVITY_HLT			BIT_ULL(6)
> >  #define VMX_MISC_ACTIVITY_SHUTDOWN		BIT_ULL(7)
> > @@ -162,7 +161,7 @@ static inline u32 vmx_basic_vmcs_mem_type(u64 vmx_basic)
> >  
> >  static inline int vmx_misc_preemption_timer_rate(u64 vmx_misc)
> >  {
> > -	return vmx_misc & VMX_MISC_PREEMPTION_TIMER_RATE_MASK;
> > +	return vmx_misc & GENMASK_ULL(4, 0);
> >  }
> 
> I feel keeping VMX_MISC_PREEMPTION_TIMER_RATE_MASK is clearer than
> GENMASK_ULL(4, 0), and the former improves code readability.
> 
> May not need to drop VMX_MISC_PREEMPTION_TIMER_RATE_MASK?

I don't necessarily disagree, but in this case I value consistency over one
individual case.  As called out in the changelog, the motivation is to make
vmx_misc_preemption_timer_rate() look like all the surrounding helpers.

_If_ we want to preserve the mask, then we should add #defines for vmx_misc_cr3_count(),
vmx_misc_max_msr(), etc.

I don't have a super strong preference, though I think my vote would be to not
add the masks and go with this patch.  These helpers are intended to be the _only_
way to access the fields, i.e. they effectively _are_ the mask macros, just in
function form.

