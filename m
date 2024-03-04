Return-Path: <linux-kernel+bounces-91204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49D1870B2B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7048D287359
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AF67A70E;
	Mon,  4 Mar 2024 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3a2Eonsn"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31DF7995F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709582791; cv=none; b=gBY29Fmu4DjFuEDCpe4bMq8kS7VwtAbYR/83FeUOHSVFdHxuMGfOKNkau0EwYJckwjLcgWGOqJA8/e6MtyoFMHqolc6AptoaR1YaYf82pt7yc5EB2xvvFJIx3IK/0N4I+K3LoLGuqhbDteZoWn2LKXwsFyd5Uzfq3tWv06ROah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709582791; c=relaxed/simple;
	bh=GHP7I/u3vUquhe+K1M+ZaFqHUB/rzDKBDJZVY3m6prI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vA3mwx5mRUUWpGZd6LijjYFZLYyibsx+DEXGC29tkrRNnePQJMczfty4Af3Atc0Z8+tFujV4XbncNVs5OFzyuUcML+mxGqlgs7+zespxXY/oQfTLxnwE9fdPEqs3OvX259e47X/ckWeaRPssE0OCTNMhpjVbimFAUzjbpNtYLU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3a2Eonsn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc0e5b223eso41946805ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 12:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709582789; x=1710187589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5+eTVAGom9Y/EulEC8DKGgZzlPMveil+3DBMCpoOSA=;
        b=3a2EonsnvXA5WbM6ZAmfl0/bGj+S+2S5pNotYRgLU+94J9YHE73uFY7uDsdjITjBml
         jRFNlmgT2GpF6LbUVw+maXBhs2H/7PrScHVVDlngZ9NrRzyFz/1ZVI6cInniyqCJUASw
         WAQ9b+Q4uwLTL0oIHJGFkocEvdbsPKqaPvhmnvHgiWztkcZFQhn7Xhh9CnPCp5PnsbyB
         2N1kX2FtY8YK14XYY3d1YK2yrAQePu71eLJ9+tjthRYTq1Y/keSqRJ70d/ZjjNTe9wSl
         08vhlMo9YV9l/r83bSeRD0NdrlWikUBpkQh9C/EO36KWFm1A5ry3ZSd/MHJAsYdq+Io2
         ItyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709582789; x=1710187589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5+eTVAGom9Y/EulEC8DKGgZzlPMveil+3DBMCpoOSA=;
        b=NzzKxFy56qbrrs8OdVo0JISUzoe+ryZlW2BxKWt/qZxkEYVy7jyps+e1i/IfiC2Gc/
         1prE/IC/DZ2ijkpM7zrt11eeoJeIpy5x7kJ383rZ1Z4xy8A4mSD49veiA47yRCnk4xHJ
         Ga9iYlx2a57JMKJ6As4zi++i8m+5/K+CGRtQ3kS18wPo1JeoJCsRR1VtxSEuWbmT7LEE
         Mv3J44n0xBAX7XLzLKje0nGy/cCYKaoEzw7ziJhfbKRfqdMyZLr27XwzLIlgK0QELlyO
         nHzwEcvSQntjouKsa2cmXlw1/sctSdN5yINI3hMs2STU7g+py154BnMDuDOUuYJW7DrC
         9Tmg==
X-Forwarded-Encrypted: i=1; AJvYcCXrET8EtrGKd/OQ6UzFTVydMwvycNBbl5G3XWQTDtrsM7CAWnNhboK+q/MoDdjfbQ9weQEWswDyk3rJ9Wk6rMH1QcOlMGufTmOhcyu7
X-Gm-Message-State: AOJu0Yzc9ZIaYSO5jk7qjwdMM+y9Ckt571NFBUATMq1ZyCkhzE6whWwv
	yyF3RnuU53FMxfqs6NzXAzaUdd1jVN2CG+K5JrapcV6wkDrw7v2jftyUcICkCQ==
X-Google-Smtp-Source: AGHT+IHgNazi0RYzC98ne1rVkJ6HKPhxYV3yGegzQx2AGrQpy5NA2hVMrjXMt5w9KuMM6BvjS4/6bQ==
X-Received: by 2002:a17:902:ecc5:b0:1dd:7db:69ce with SMTP id a5-20020a170902ecc500b001dd07db69cemr6381559plh.51.1709582788935;
        Mon, 04 Mar 2024 12:06:28 -0800 (PST)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d3c400b001da1ecb05f9sm8909609plb.240.2024.03.04.12.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:06:28 -0800 (PST)
Date: Mon, 4 Mar 2024 20:06:25 +0000
From: Mingwei Zhang <mizhang@google.com>
To: Like Xu <like.xu.linux@gmail.com>
Cc: Sandipan Das <sandipan.das@amd.com>, seanjc@google.com,
	pbonzini@redhat.com, dapeng1.mi@linux.intel.com,
	jmattson@google.com, ravi.bangoria@amd.com, nikunj.dadhania@amd.com,
	santosh.shukla@amd.com, manali.shukla@amd.com, babu.moger@amd.com,
	kvm list <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86/svm/pmu: Set PerfMonV2 global control bits
 correctly
Message-ID: <ZeYpwY5XayggqtlL@google.com>
References: <20240301075007.644152-1-sandipan.das@amd.com>
 <06061a28-88c0-404b-98a6-83cc6cc8c796@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06061a28-88c0-404b-98a6-83cc6cc8c796@gmail.com>

On Fri, Mar 01, 2024, Like Xu wrote:
> On 1/3/2024 3:50 pm, Sandipan Das wrote:
> > With PerfMonV2, a performance monitoring counter will start operating
> > only when both the PERF_CTLx enable bit as well as the corresponding
> > PerfCntrGlobalCtl enable bit are set.
> > 
> > When the PerfMonV2 CPUID feature bit (leaf 0x80000022 EAX bit 0) is set
> > for a guest but the guest kernel does not support PerfMonV2 (such as
> > kernels older than v5.19), the guest counters do not count since the
> > PerfCntrGlobalCtl MSR is initialized to zero and the guest kernel never
> > writes to it.
> 
> If the vcpu has the PerfMonV2 feature, it should not work the way legacy
> PMU does. Users need to use the new driver to operate the new hardware,
> don't they ? One practical approach is that the hypervisor should not set
> the PerfMonV2 bit for this unpatched 'v5.19' guest.
> 
How could hypervisor know the guest 'Linux version'? KVM should not even
assume it is Linux. So that means, if the 'guest driver' does not
support PerfMonV2, then guest should just continue to use its legacy code.
Otherwise, the guest is considered broken.

Thanks.
-Mingwei
> > 
> > This is not observed on bare-metal as the default value of the
> > PerfCntrGlobalCtl MSR after a reset is 0x3f (assuming there are six
> > counters) and the counters can still be operated by using the enable
> > bit in the PERF_CTLx MSRs. Replicate the same behaviour in guests for
> > compatibility with older kernels.
> > 
> > Before:
> > 
> >    $ perf stat -e cycles:u true
> > 
> >     Performance counter stats for 'true':
> > 
> >                     0      cycles:u
> > 
> >           0.001074773 seconds time elapsed
> > 
> >           0.001169000 seconds user
> >           0.000000000 seconds sys
> > 
> > After:
> > 
> >    $ perf stat -e cycles:u true
> > 
> >     Performance counter stats for 'true':
> > 
> >               227,850      cycles:u
> > 
> >           0.037770758 seconds time elapsed
> > 
> >           0.000000000 seconds user
> >           0.037886000 seconds sys
> > 
> > Reported-by: Babu Moger <babu.moger@amd.com>
> > Fixes: 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
> > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > ---
> >   arch/x86/kvm/svm/pmu.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> > index b6a7ad4d6914..14709c564d6a 100644
> > --- a/arch/x86/kvm/svm/pmu.c
> > +++ b/arch/x86/kvm/svm/pmu.c
> > @@ -205,6 +205,7 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
> >   	if (pmu->version > 1) {
> >   		pmu->global_ctrl_mask = ~((1ull << pmu->nr_arch_gp_counters) - 1);
> >   		pmu->global_status_mask = pmu->global_ctrl_mask;
> > +		pmu->global_ctrl = ~pmu->global_ctrl_mask;
> >   	}
> >   	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << 48) - 1;

