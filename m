Return-Path: <linux-kernel+bounces-157791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFA78B163A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C161B22B33
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C09016DEC1;
	Wed, 24 Apr 2024 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2aPw+sag"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CBD2942D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998069; cv=none; b=OtoRmLNE0ULJHqJ//vQXl9JbOBBdEIToaaW2iVFzzXbN2Ynzr/Ytv8xkiu0YZz4R8b765djppCs9I4j+P+qkhIdKqkGZpT7+K0M7N1RHdcEAd00f7Bgj9e2jsv9UQwSaALKih1hvFxeN3iFdIvsP7XRFIMZiFRzDMVV3D76qWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998069; c=relaxed/simple;
	bh=asc2e9byBb6WbLiXPgQe7Wz0QSbFZ/SU6XAk6Ce1SYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SNsp/mvmPn+qVbJ4V3BUgzxE8q1UvIi+ByeGXbDPNbhUTf5VHCfZhLn7UU3X4nJ+P96VsrFgNhsg8HfYLmtJZ4JDNc7iNoHwVbRKKGxh8czk28qdfd54w+j3LkoJDAYLoj5ZFk0JDhgRCbI44KzeYX1WmYZjplTdiYafVvv4DNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2aPw+sag; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc693399655so761232276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713998067; x=1714602867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhZptQyvv5xokxwHGECOmJsyHAUY1E5WI4kuUHDLdOc=;
        b=2aPw+sagdPWEKp/sU1sHRHS9T7HuLpWdZZIq8kRxu0CmXPDZSUHA72fjfzvKhRyvco
         OPzdoNKs8D5FcYv/nB0yQdGg3KbtVME/zkCAxwYVgcthkWW3WBN07KN1uHN8WXJT0+kO
         zerUHdobFIE7uo+09+ynhiaik/inSILZmBqMop+1tzPgGM0pp4Yrhh1MI80pw5Es+nHQ
         NPgAmAxcpnb9LFddgL0jFQMSkQJRWfXT/UiPfkmxOcH5iYJ8AchsvjtFBont5bm4n1VP
         NkYfKV6Zk+lqARBhPiW3JJ5+VFG4a19yKbcyjgAKY4HTIMKsocSuOzup1zDvmQRAI/EE
         vL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713998067; x=1714602867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhZptQyvv5xokxwHGECOmJsyHAUY1E5WI4kuUHDLdOc=;
        b=OvKDYEA9gg4FmCsxjLOr8iiPq3wHXWrru31s/jHfEndaHpM/ctqGlriTt4xSyBe4MX
         CR+hXYpLb6R2pknaM1IqzPPdX0UFdkg4p0V0HXC/lTfe9MKpRJ8gYOnjNsC4uXBwRSWd
         3BriVwXroWsZ8bkzzlnoLsp88jVLlD6Jk04I1MV0JOU+ZPg/A0z/ufVFD/clNcdwIxzz
         vecQQEV1SWsgTn1FUs2tCYGjqIOX0teFMfkNVDMYnf5XV4xkeQrsrmnJOsNIlz2/kqMK
         rvWUjCoHgNgJxmGtI2cD37v+KQz0S5VbG83PabKRY9f59ORX1IxghldN5nuA6RgPldzU
         943g==
X-Gm-Message-State: AOJu0YyXbH/9V7/WLHrsK5FD7lEYvAb+qCfVKStee6aSGLmukHlsqxcd
	TG63gQvQEh9GtNemzI18Acm6TJXkn5dp2lfxRLCqjmcfQutbkm1f+/Bx9zPKxwQlAZeHrRVxE1Z
	wdQ==
X-Google-Smtp-Source: AGHT+IGcMfHiAY6VH/m2Qvr49Qo7gg/Pdi4g71eeY/PE32J1XzS9ozT9Aczn/8PsKtNUQdNvIsu5y2fV7V8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:150d:b0:dc7:7ce9:fb4d with SMTP id
 q13-20020a056902150d00b00dc77ce9fb4dmr1279124ybu.12.1713998067469; Wed, 24
 Apr 2024 15:34:27 -0700 (PDT)
Date: Wed, 24 Apr 2024 15:34:26 -0700
In-Reply-To: <20240404185034.3184582-8-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240404185034.3184582-1-pbonzini@redhat.com> <20240404185034.3184582-8-pbonzini@redhat.com>
Message-ID: <ZimI8j9LIUsAArdD@google.com>
Subject: Re: [PATCH 07/11] KVM: guest_memfd: extract __kvm_gmem_get_pfn()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 04, 2024, Paolo Bonzini wrote:
> In preparation for adding a function that walks a set of pages
> provided by userspace and populates them in a guest_memfd,
> add a version of kvm_gmem_get_pfn() that has a "bool prepare"
> argument and passes it down to kvm_gmem_get_folio().
> 
> Populating guest memory has to call repeatedly __kvm_gmem_get_pfn()
> on the same file, so make the new function take struct file*.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  virt/kvm/guest_memfd.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 486748e65f36..a537a7e63ab5 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -540,33 +540,29 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
>  	fput(file);
>  }
>  
> -int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> -		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
> +static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
> +		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prepare)

I genuinely don't know what it means to "prepare" a guest_memfd.  I see it becomes

	if (!prepare)
		fgp_flags |= FGP_CREAT_ONLY;

but I find the name "prepare" to be extremely unhelpful.

