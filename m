Return-Path: <linux-kernel+bounces-87665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3F786D789
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098FB1C21468
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59047A158;
	Thu, 29 Feb 2024 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0KGTJ8T"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62816FF21
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248083; cv=none; b=YFMCWq1Z4if6WguKN3NE1+uG89dK1SrxYyFwzL1O0MvaGo0RjejqzM64QP0JePLxftBelJwpCEcl0BNeWeoJ6tR1pga7TseLiYX2f6EVJPtnlXfS6aKzKvBtcHBJ93dd5mF+jjkTpEAXWhVbrQJhdVg2SGh6cBC/dNFV/8M93Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248083; c=relaxed/simple;
	bh=zJhWfx7GK1YysklElLdHCde42C/JNXRPYOyOMcUqrT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Avwc1outHExQ7NnCnfMeVRlcKrj/ckIu7//JH9OlhWWPmpfRrSkZbF8ILdNoXpg7uzbk8j8xc214EQ8qI3JIAYrztCs0uXmGTrSN/+1ZJ65sMWWuubr/IDB0iMIkeTnSoMbgcmXySTWZtZ9Oetl6j89MQMFy9QqjKPuJR5x87mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0KGTJ8T; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60942936e31so25903527b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709248080; x=1709852880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tONzLipD7XoMDHe1nP9IUEdoxrUsyW7/+yWAsS/QFWs=;
        b=E0KGTJ8TDUeJP1LUkVFUr2hHL1ecIukLv10FwScQBF1h8v+vP7uUwOQgGMT8Qd+Z9B
         z4prci/rHGC52jogvSK+CSZBTks/5/YDUKpjupifNURLdRID6aKMRwi3fYD8kvZfBTjX
         oyHD5h7oRY/oFkLF1T+8XtMfrgDKSGjO8dcMaFa4u93c867n/e48RgCQ7pT1FvKsTyCB
         +8c2Fc9va1/lPI/2KTj0oIaV/9L7w+aRvGrmMYW0vZq9NK4QWS/NLOX9SR6bXh60Khdq
         MbgZv3590P+l/dhylFDiMjihBsFoLpZoaePRoyuZ/w96vN3xx3sEgkMMHNYtCAcmYOB4
         DbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248080; x=1709852880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tONzLipD7XoMDHe1nP9IUEdoxrUsyW7/+yWAsS/QFWs=;
        b=pnaosgj1uQrq9edrjxf7ry0dY92N1cyj8sYAS+HijQ4RQzf6RRlwOViq+LYTb8lOjS
         awwnj6VTHwEMArejoddj2hz20ODNyZPBDBxHSu2/ox1NbUr+c7nkaOEtRCvC4yBHCV2u
         8mcOcbXTHnKWb8vy6Ds25JzF78oLqk0YjZX1gIYTlQEdOuRzNegh2GxVt2Jk6nxSp6C/
         raKzEqW++hSnUAWc+R7b5g7vwUrTDu7WKkDx47mVCT5DcmVZR8f6pznDx1prUkEI0eDq
         A1K6dB6XNDTEWL9aso5KxjHV1JSO0NUXSyBQY1ullJ+QwZuPeaySu+MqjxfU0/x9WxcY
         ZTtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlfivcI0UZO1RMzNnD8jIv9LezeIDdZG2TbeSDHWs4ORTFa3MKxtGF0YcXKR5SSmMZv+7xkZoZ6c1xdxVYeI3Zobh5sMujpczo5z4t
X-Gm-Message-State: AOJu0Ywd+ocu0EXR4yYaWLqgJ5F6Z4fqbR08XXyDdH5Lxf7uzP1A8e+m
	SJTLyYo8M4UauQkZa4HcgvO4FitfuqAICHfKKfhYwffqN1DvDd/BRVf9yJgr0qOmj2Z1M1WVstr
	ApQ==
X-Google-Smtp-Source: AGHT+IF8uRtPMSJ8u7aHFCiJdwuPHLXyrqDLlrx/6yzTWtQtBrDoMWtMR9KRBcYb2IP716mjTPkcTB4vWsQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:98cf:0:b0:609:2031:1e09 with SMTP id
 p198-20020a8198cf000000b0060920311e09mr124141ywg.6.1709248080639; Thu, 29 Feb
 2024 15:08:00 -0800 (PST)
Date: Thu, 29 Feb 2024 15:07:59 -0800
In-Reply-To: <3779953f-4d07-41d7-b450-bbc2afffaa43@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-7-seanjc@google.com>
 <3779953f-4d07-41d7-b450-bbc2afffaa43@intel.com>
Message-ID: <ZeEOTxUTSkYnP9Y0@google.com>
Subject: Re: [PATCH 06/16] KVM: x86/mmu: WARN if upper 32 bits of legacy #PF
 error code are non-zero
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 01, 2024, Kai Huang wrote:
> 
> 
> On 28/02/2024 3:41 pm, Sean Christopherson wrote:
> > WARN if bits 63:32 are non-zero when handling an intercepted legacy #PF,
> 
> I found "legacy #PF" is a little bit confusing but I couldn't figure out a
> better name either :-)
> 
> > as the error code for #PF is limited to 32 bits (and in practice, 16 bits
> > on Intel CPUS).  This behavior is architectural, is part of KVM's ABI
> > (see kvm_vcpu_events.error_code), and is explicitly documented as being
> > preserved for intecerpted #PF in both the APM:
> > 
> >    The error code saved in EXITINFO1 is the same as would be pushed onto
> >    the stack by a non-intercepted #PF exception in protected mode.
> > 
> > and even more explicitly in the SDM as VMCS.VM_EXIT_INTR_ERROR_CODE is a
> > 32-bit field.
> > 
> > Simply drop the upper bits of hardware provides garbage, as spurious
> 
> "of" -> "if" ?
> 
> > information should do no harm (though in all likelihood hardware is buggy
> > and the kernel is doomed).
> > 
> > Handling all upper 32 bits in the #PF path will allow moving the sanity
> > check on synthetic checks from kvm_mmu_page_fault() to npf_interception(),
> > which in turn will allow deriving PFERR_PRIVATE_ACCESS from AMD's
> > PFERR_GUEST_ENC_MASK without running afoul of the sanity check.
> > 
> > Note, this also why Intel uses bit 15 for SGX (highest bit on Intel CPUs)
> 
> "this" -> "this is" ?
> 
> > and AMD uses bit 31 for RMP (highest bit on AMD CPUs); using the highest
> > bit minimizes the probability of a collision with the "other" vendor,
> > without needing to plumb more bits through microcode.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/mmu/mmu.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 7807bdcd87e8..5d892bd59c97 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -4553,6 +4553,13 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
> >   	if (WARN_ON_ONCE(fault_address >> 32))
> >   		return -EFAULT;
> >   #endif
> > +	/*
> > +	 * Legacy #PF exception only have a 32-bit error code.  Simply drop the
> 
> "have" -> "has" ?

This one I'll fix by making "exception" plural.

Thanks much for the reviews!

> 
> > +	 * upper bits as KVM doesn't use them for #PF (because they are never
> > +	 * set), and to ensure there are no collisions with KVM-defined bits.
> > +	 */
> > +	if (WARN_ON_ONCE(error_code >> 32))
> > +		error_code = lower_32_bits(error_code);
> >   	vcpu->arch.l1tf_flush_l1d = true;
> >   	if (!flags) {
> Reviewed-by: Kai Huang <kai.huang@intel.com>

