Return-Path: <linux-kernel+bounces-157713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CE68B14FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E602857D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E9F156F29;
	Wed, 24 Apr 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjCaHm4S"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E0156971
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992392; cv=none; b=bz4IVS4d0OZLIEA6cyfyL7CfcqqRC+AoTmALil5rkWZgyffsgvf1C1u5Zuy5zMWWX5zvTV1iWJMbKm3Dwxt/sAvyDnVpZonRZXOQ7f8XZxLIB1e1g2sSXYKn9Y/b8GDeIzhpmCZI7LvZcO/O4h6aF9IL6pLtdLlUpw+rfRluRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992392; c=relaxed/simple;
	bh=uoU2R06bl1D+d4rxO77OZBS6BnVKagWYLEFnEXdTDn8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dk6UfYQTgs2jDbQgE8mKBzgupdPaV1oIZ7uBOcIeYs7B9cYHxIw/R9ShTPYPFNB0D5Y2cYg1mY+m91KRtAmTgs4gy1/gTPZ6x4hn2ctBW+t/ZWsWK5sBx9n+uukVdqLPn+XlzAmfHuYpajOOum1ASD/6AVfXRSNeUZcaeUXcBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjCaHm4S; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ee0d64070aso314845b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713992390; x=1714597190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8U1TRrKJi3x9eg5Tfok1QV3PlGCm0SDXSlp6I7iPxGE=;
        b=KjCaHm4SfZ0BSz0gxlpk5zUch7+meGfx9lZbZw04Lz0w8FrageE3zC70GAizxI4+h8
         XUei4YaPq43QeQX1M+YP7SZKkvlABz4GhDP8bAV6MEC4VO4Fp//Jb1YacuHa3MMlV9S2
         yD1nk99sdUxoR6odE/vZyD8QY7ORDmbAW+VTwbXhMCfnjhXQPVuxkX1knY64vPGB2HUb
         LCu/uRkslz8iPcEgg2q9hEHlRwvd4X3Y+KH4qbPqmi9Zhujm6oo8x7hyFd25FvsF/eUM
         W6AFyGp921NU+dKGc7hC8n1zU7nIrbobPjnV/TFanhYoLJFfDZaiiraT8KWPQx2y6fn9
         XjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713992390; x=1714597190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8U1TRrKJi3x9eg5Tfok1QV3PlGCm0SDXSlp6I7iPxGE=;
        b=oQnEHSEQvV1ZuSMcOuzPLSr94huiQHZAd62J//v4v/WSXYUmY8gHIasGFc00vQWKIy
         kUbA0nrN+7aELvjr8Ts6F02ex4nsPoclN26RjTNlWT9sHj+WpaGBUMeHEVUZzm78TDHr
         o3YaAwTrpvWkZO7QG21ldt+HgzpD4H/5OAmwf9iPGH7rE8JLSXY262R5kE40EM4Z0Bga
         NYe6g+okOMqNesf25yaQ3e0QvTyDFZmNNNDALzNLo+61njfP9+jkn643S+g3ViP7+uDR
         IZ/XdnYQ8XX/MOWWRhAGGW/Qjy6Z3gKepiY4kTgFE7sFDm5eXA6tsqX/f4MaL8sEVEQU
         IlNg==
X-Forwarded-Encrypted: i=1; AJvYcCVUcCw3/Mv9MhdPDToLX2etdywzTuYBfpZox3YuC3M6Md71mqjzxsnnD4BgHWHvOTExL1iqS13WNifq6Ss2PluRTiWGOIuzEuPbEMzd
X-Gm-Message-State: AOJu0YzOzpeyHN+I+qRCPGLwsGByDgDSckRy719EnirDLjbdZptg/yKS
	sfKXL7YXDtq8tTB3Mv2CTcKqnKd881OXRT1we9rO0DSwG8NdLN+/CZeJqCm49yIVc6S4W0/6vGv
	diw==
X-Google-Smtp-Source: AGHT+IGmpsjpffCacAgU+oA7c6LytEyPptV84YPXAIS11abUo+sjJaZSSsVlO+4Jy+7xcfCJfVr3EYbcplE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:22c4:b0:6ec:f18a:2783 with SMTP id
 f4-20020a056a0022c400b006ecf18a2783mr446579pfj.0.1713992389985; Wed, 24 Apr
 2024 13:59:49 -0700 (PDT)
Date: Wed, 24 Apr 2024 13:59:48 -0700
In-Reply-To: <20240421180122.1650812-10-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240421180122.1650812-1-michael.roth@amd.com> <20240421180122.1650812-10-michael.roth@amd.com>
Message-ID: <ZilyxFnJvaWUJOkc@google.com>
Subject: Re: [PATCH v14 09/22] KVM: SEV: Add support to handle MSR based Page
 State Change VMGEXIT
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

On Sun, Apr 21, 2024, Michael Roth wrote:
> +static int snp_begin_psc_msr(struct kvm_vcpu *vcpu, u64 ghcb_msr)
> +{
> +	u64 gpa = gfn_to_gpa(GHCB_MSR_PSC_REQ_TO_GFN(ghcb_msr));
> +	u8 op = GHCB_MSR_PSC_REQ_TO_OP(ghcb_msr);
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +
> +	if (op != SNP_PAGE_STATE_PRIVATE && op != SNP_PAGE_STATE_SHARED) {
> +		set_ghcb_msr(svm, GHCB_MSR_PSC_RESP_ERROR);
> +		return 1; /* resume guest */
> +	}
> +
> +	vcpu->run->exit_reason = KVM_EXIT_VMGEXIT;
> +	vcpu->run->vmgexit.type = KVM_USER_VMGEXIT_PSC_MSR;
> +	vcpu->run->vmgexit.psc_msr.gpa = gpa;
> +	vcpu->run->vmgexit.psc_msr.op = op;

Argh, no.

This is the same crud that TDX tried to push[*].  Use KVM's existing user exits,
and extend as *needed*.  There is no good reason page state change requests need
*two* exit reasons.  The *only* thing KVM supports right now is private<=>shared
conversions, and that can be handled with either KVM_HC_MAP_GPA_RANGE or
KVM_EXIT_MEMORY_FAULT.

The non-MSR flavor can batch requests, but I'm willing to bet that the overwhelming
majority of requests are contiguous, i.e. can be combined into a range by KVM,
and that handling any outliers by performing multiple exits to userspace will
provide sufficient performance.

And the non-MSR version that comes in later patch is a complete mess.  It kicks
the PSC out to userspace without *any* validation.  As I complained in the TDX
thread, that will create an unmaintable ABI for KVM.

KVM needs to have its own, well-defined ABI.  Splitting functionality between
KVM and userspace at seemingly random points is not maintainable.

E.g. if/when KVM supports UNSMASH, upgrading to the KVM would arguably break
userspace as PSC requests that previously exited would suddenly be handled by
KVM.  Maybe.  It's impossible to review this because there's no KVM ABI, KVM is
little more than a dumb pipe parroting information to userspace.

I truly do not understand why we would even consider allowing this.  We push back
on people wanting new hypercalls for some specific use case, because we already
have generic ways to achieve things, but then CoCo comes along and we apparently
throw out any thought of maintainability.  I don't get it.

[*] https://lore.kernel.org/all/Zg18ul8Q4PGQMWam@google.com

