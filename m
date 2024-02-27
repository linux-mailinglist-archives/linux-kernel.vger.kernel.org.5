Return-Path: <linux-kernel+bounces-82460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF848684E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 488F0B22602
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6D67FF;
	Tue, 27 Feb 2024 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVg84o3j"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F4360
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708992669; cv=none; b=dYLz50dpJJaQZPCIXke9yjFbnn3iKAKTseLNMwQ07m2/+Eo3K6aFze9oAUW4FK9gFnwNiDOl/QaF2n8fiLIwWdr/lPuz3cWuHaI1enHeJnMpDbJELuqyx9p6PbArTtyJn3TuePu/WRWZl6KGVd4+86pW9SqeGDS90nUBgP8qQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708992669; c=relaxed/simple;
	bh=+0HW0I+Sds5Zs5b5rGWRfw72kX6o58U/vNE4sJhB39k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=II0Sz4GYtHOZXulDehE496Guw8SoPlxLl00xb0xANuVyfLG64wnP4/u5u33HeiOasxuzsHIq56TVkiedeYe/prYujuni9TJRXlKdfRrXzwhTPxazuLSuv1qdgndtBmViUVF0IS0W3CsbIpMkSF+FwpH5CFOdBNHUFE2yhU2N/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVg84o3j; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso5036847276.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708992666; x=1709597466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6lCojt3BigDKF1Z6DNZEhqVi/bp1on2H69YUvcRX6rE=;
        b=iVg84o3jTA0sEICa/8a1TjsEsQEmnmlEwwSm0wl3jpljNZnXCOQ/7GkoBDoXg30YJX
         mZDb/bl6MksxgKfY4fn5jYCeWTKULA/2NhfcXOMpO0DfuZt14UxVwuDU7aduEIzCdlw1
         VtL430VDUWxKgpCOr6i+E1VqLoCZj1ORloQb/v6hAV4ooeDHcJkI7ZgNAMzw62EBYFWK
         ylb+C2gNLo2LJOOj0fGihCJSxUKASSZeiSTTk1Aro5DDW87EkT3dK4rFNUNqSSFSGHJX
         CReumaOy727tnXbMpBSgu+NjX/ajHV6K7/WRGmeaH78DTFfv2P8e1uteFIQrSnPAyFR9
         8rDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708992666; x=1709597466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lCojt3BigDKF1Z6DNZEhqVi/bp1on2H69YUvcRX6rE=;
        b=Q6DjS/u8sWfv/GjqCqr2Nj6vpE6ALwaTN1utzH0C4lWIAAd4khUsycd+gyefmnWTJk
         kDFDfAUZTj+zyFYh3Sv/7Px9kfKIOGkYW3i1F2OCPHO4gojisRq7iNi+uz9Fv9iQeA/l
         M7p61UlSDXCjdgsIv9CruyHmTFRkz+3e44Yo0NUxpE0g5W1B3n43l6uAz95IgBRZ6xNI
         jSSpZCeuuu6ilap2pR0yPi/To+eC7it4P+V+6EY8MyDryZ0MdLtOBb+c213Fc56fPF/a
         nhg5QN9HtwQJkdEiTGBq39eD0xheeTMZaFKfnoCC/8z36BOuirgn6c1K3RjDhNt3+Y5h
         ZMGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk4gCdaQ8yC6AZXyyN9et1PsWtKmCUim7Ts9Bbu7xOYnCF4BGPIgSpRxFxfcPJ2Wx8fars1Cvh5cL8+cfpIqNu146ymg/jd08dYIkR
X-Gm-Message-State: AOJu0Yzd/m88T6ATv1HiTdiJmvkmqxivad7g1BXpH87lZ3U0ru1y3DBf
	rm1x1MhmT73pmBXTxs+43dAoovTkjTuNrYZp6NiZgtyfMeG8jGeQ4KViLxY0uA0k+zhU/0JcBWH
	Hxw==
X-Google-Smtp-Source: AGHT+IGoqOLH0Yj/filzZmuPfrAn41iSOW15YVUYnEsFixu/WDYss+uM9VgJXxhJpO/Xwg/X/XhhFa9WlCs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:83ce:0:b0:dc6:519b:5425 with SMTP id
 v14-20020a2583ce000000b00dc6519b5425mr200134ybm.11.1708992666356; Mon, 26 Feb
 2024 16:11:06 -0800 (PST)
Date: Mon, 26 Feb 2024 16:11:04 -0800
In-Reply-To: <585a36d2-6e46-44a0-8224-8d4cd54d0dd3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206032054.55070-1-likexu@tencent.com> <ZcKKwSi7FdbSnexE@google.com>
 <ZcKf3RvyoVJ77sUQ@google.com> <585a36d2-6e46-44a0-8224-8d4cd54d0dd3@gmail.com>
Message-ID: <Zd0omLAgMu2P3lWX@google.com>
Subject: Re: [PATCH v2] KVM: x86/intr: Explicitly check NMI from guest to
 eliminate false positives
From: Sean Christopherson <seanjc@google.com>
To: Like Xu <like.xu.linux@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andi Kleen <ak@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, Feb 18, 2024, Like Xu wrote:
> On 7/2/2024 5:08 am, Sean Christopherson wrote:
> > On Tue, Feb 06, 2024, Sean Christopherson wrote:
> > Never mind, this causes KUT's pmu_pebs test to fail:
> > 
> >    FAIL: Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x1): Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x2): Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x4): Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x1f000008): Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: GP counter 0 (0xfffffffffffe): No OVF irq, none PEBS records.
> >    FAIL: Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x1): GP counter 0 (0xfffffffffffe): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x1): Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x2): GP counter 0 (0xfffffffffffe): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x2): Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x4): GP counter 0 (0xfffffffffffe): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x4): Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x1f000008): GP counter 0 (0xfffffffffffe): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x1f000008): Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x1): Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x2): Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x4): Multiple (0x700000055): No OVF irq, none PEBS records.
> >    FAIL: Adaptive (0x1f000008): Multiple (0x700000055): No OVF irq, none PEBS records.
> > 
> > It might be a test bug, but I have neither the time nor the inclination to
> > investigate.
> 
> For PEBS ovf case, we have "in_nmi() = 0x100000" from the core kernel and
> the following diff fixes the issue:
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 995760ba072f..dcf665251fce 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1891,7 +1891,7 @@ enum kvm_intr_type {
>  /* Enable perf NMI and timer modes to work, and minimise false positives. */
>  #define kvm_arch_pmi_in_guest(vcpu) \
>  	((vcpu) && (vcpu)->arch.handling_intr_from_guest && \
> -	 (in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
> +	 (!!in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
> 
>  void __init kvm_mmu_x86_module_init(void);
>  int kvm_mmu_vendor_module_init(void);
> 
> , does it help (tests passed on ICX) ?

Yes, that resolves the issues I was seeing.  I'll get this applied with the above
squashed.

I'll also see if the tip tree folks would be open to converting the in_{nmi,hardirq,...}()
macros to functions that return bools (or at least casting to bools in the macros).
I can't see any reason for in_nmi() to effectively return an int since it's just
a wrapper to nmi_count(), and this seems like a disaster waiting to happen.

> > If you want any chance of your patches going anywhere but my trash folder, you
> > need to change your upstream workflow to actually run tests.  I would give most
> > people the benefit of the doubt, e.g. assume they didn't have the requisite
> > hardware, or didn't realize which tests would be relevant/important.  But this
> > is a recurring problem, and you have been warned, multiple times.
> 
> Sorry, my CI resources are diverted to other downstream projects.
> But there's no doubt it's my fault and this behavior will be corrected.

Thank you.

