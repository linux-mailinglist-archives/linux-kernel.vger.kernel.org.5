Return-Path: <linux-kernel+bounces-54268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B4084AD08
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB55285B93
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6D4745D2;
	Tue,  6 Feb 2024 03:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwAjamn0"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EAA41C65
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190994; cv=none; b=s3OHlUV4JGoRcJQkTuV4EPyt0DBNEY2kofx0ggdFS7W6mwoVmo8bY3rrl296TekAvlyb8+3GZd9eZHsxsQ7eeznoAss9RbugJaVoNf6pV+Xs3MtsToRTZegpB8HonZ13IqmhuRL2kizJGDxU+9WG1Qi/nE+mvGXQD4VmbpiCIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190994; c=relaxed/simple;
	bh=+LEUIXV0lFwpLO3k4xpDM5EQvBUvVsuMxEq6CEOiPXM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h38BoA3ejdKaHkIpcdZpeNfioPbdGkZ3kpVuynPoQruz2bT1XJISArBlcWaB/yCn/Qi/EVgKsmkz9P3drlLNoCNMoSUE3Ccle7Nw8v4c4KXet2bViRscAfMpkA1BNSoOUNFEJwmKQHav3sP2IgCnwkhXC5FbJmZPTSPiCuRXRoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwAjamn0; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-78319f64126so622882485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 19:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707190991; x=1707795791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpqFA9NyY5bI4wueUVg/+/e+POejKlZHsq+ipwNoeKU=;
        b=mwAjamn0x4ZfBJ9oxSIFUvVS6RO/S9s7nSw6Zo7juJX0ciEqaoaaDDSeyWIjQvIq/x
         CjQl3/tWOhgs+eXAN18B5xd9HXyTE3BMdmtRYSOQJMODwoo6LG7SFbd1X9Go11Z0qUr/
         vJdXxz/q1gVSKdb8oM1JtytUkyY/7TEUy1r9ssxME83877xS93/ht0YQKC32vK4/C5T1
         UKjNeH5mx+YTZ+ZTS3Uhmajsp0K+t4jTsh13jIUuOrO8I9P/nwpg5k93UDuvNBBrNLQM
         snVUomuayn37e/3LIeCGc0NqUivWHTqLW1IrJbLA8UJ/lV0razXUtB5dGcXJb9WuI0zc
         kPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707190991; x=1707795791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpqFA9NyY5bI4wueUVg/+/e+POejKlZHsq+ipwNoeKU=;
        b=C/a0jMm8jv+FoJgcZNnucVXt20eElqXbiI/biadaMPl4lYnDphJjrbOJUTakATzr+A
         hnNcvplUzadShXXY43AknaDqqUpGqjaD/LJJF5HlyfMnXs3mVbmPuLCmz4iVWj9q6Nie
         FwgYgAHxtJ0C+HSO8LVQlCowCUah6SE9Z8Sp3P5+Jz4G9strkNvwxVu4+K1l25IiLiLj
         owkFNkGrmNgLg/jM/tdzhJRJn7BiujP7uNT+Hrhfov9ENNCEOPwBmXzK0+9/jnfVDAwU
         T9IKlCfzjbRfF74y9D0X2xJJm9Qgz4Yatm3sb52tm8lKjgnSv0892gDwwjWK+9KIC98/
         YVrQ==
X-Gm-Message-State: AOJu0YzE0dSThYyUNAijXNZ1OqGp99yFq/bdoj+Tb4roPB3YhwF5W1WA
	Jem3ORGBqICuOZ9gN6TP5dHnJSWN9wv6cuNFbYIdk0Kqv79lzXtoI86uOWyeQbOFioju2vb0pAv
	1JQ==
X-Google-Smtp-Source: AGHT+IFr2uxVl+q3AGojz+bZO6tfUszLovI2zdfqgieC5phJzxpTgflfE6Ekefg9f+gIKeMLk97J6P57cPY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:118f:b0:dc6:c623:ce6f with SMTP id
 m15-20020a056902118f00b00dc6c623ce6fmr16494ybu.13.1707190516967; Mon, 05 Feb
 2024 19:35:16 -0800 (PST)
Date: Mon, 5 Feb 2024 19:35:15 -0800
In-Reply-To: <ZcGbjstPnwVpR3Jw@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240203003518.387220-1-seanjc@google.com> <ZcAoZ/uZqJHFNfLC@yzhao56-desk.sh.intel.com>
 <ZcEolLQYSlLEVslN@google.com> <ZcGbjstPnwVpR3Jw@yzhao56-desk.sh.intel.com>
Message-ID: <ZcGo8yr5oYV6Cf2K@google.com>
Subject: Re: [PATCH v3] KVM: x86/mmu: Retry fault before acquiring mmu_lock if
 mapping is changing
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 06, 2024, Yan Zhao wrote:
> > Just to be super claer, by "repeated faulting", you mean repeated faulting in the
> > primary MMU, correct?
> >
> Yes. Faulting in the primary MMU.
> (Please ignore my typo in return type above :))
> 
> BTW, will you also send the optmization in v1 as below?

No, mainly because I'm not entirely confident that it's safe/correct to loop
there, at least not that "tightly".  At the very least, there would need to be
resched checks, and then probably signal checks, etc.

I'm not opposed to something of this nature if it provides a measurable benefit
to the guest, but it's firmly an "on top" sort of change.

> iff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 1e340098d034..c7617991e290 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5725,11 +5725,13 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
>         }
>  
>         if (r == RET_PF_INVALID) {
> -               r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa,
> -                                         lower_32_bits(error_code), false,
> -                                         &emulation_type);
> -               if (KVM_BUG_ON(r == RET_PF_INVALID, vcpu->kvm))
> -                       return -EIO;
> +               do {
> +                       r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa,
> +                                                 lower_32_bits(error_code),
> +                                                 false, &emulation_type);
> +                       if (KVM_BUG_ON(r == RET_PF_INVALID, vcpu->kvm))
> +                               return -EIO;
> +               while (r == RET_PF_RETRY);
>         }
>  
>         if (r < 0)

