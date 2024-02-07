Return-Path: <linux-kernel+bounces-55920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57284C363
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7740D286ED3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B13D125C1;
	Wed,  7 Feb 2024 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SF8Qnkhd"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82BE14AB2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 04:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707279015; cv=none; b=IzLUSlFzZWqLn0J8WcyC4UXk5x2p0nNUvR9/uUrTSV/kaUR+T+VBlUYlW3Jn9yQjLgBYNo9x3rYY/ncrqx1p6aMLC0dQBR2xTOBPiozHVj1Wgsdh9hRr7rJ1JOvBWeM24lYs/hvkjbAxkXJzXXrV0n406gq+Xp+Qva91f7GGliY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707279015; c=relaxed/simple;
	bh=GoYtXApYyZBo4VKeqb1AsTKENYpsyaUCglDP8GuS7kQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gpW8s+sfljyEphQZU6EZ7LUkjy6VicbP0Fx7xY3rwmVPAA6i4Jq8EccxIdKdbMXXzQjxR4BfGZ+jYi3hRMM/JTrJw1Ys9eH5CqUgNylsLc8H9qrmK0lZXFdNz+PcldrD/fmYk7wUpXanmRLgJLeSZhYEJdKRHsxBOY7BDucorek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SF8Qnkhd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2966701bedcso182895a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 20:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707279012; x=1707883812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ykLN7fs6qQRnuF8WSISkwVcQAWTyJrlW1o+moHfC85k=;
        b=SF8QnkhdmzPTdOrFesWrthVZBtR5tJkCM6a1G1aS4RwUlGEQ4b20Pyai4LwpRFZEDO
         gbEOvuVlz/MRpZJJnFJ8Y14uy8DBy1xXBNcixgUNsPHwR0c8U9QgwuzYRARv3SdKJkEJ
         G4ogiri+ow+sdLNpjI+GZf0jqlAMbKT4Xdd+P3FDWi4ftO6FTEagEdvcP1TVkBHDKoyj
         eTRBV2/y/ysc1M+lxWYKioQ3UiKFv8T8LYhfqG/EECEi77PtBhPBago1/6LkW65MaCEB
         YpHz8/1KXdv5sAI1vG91MYiVxcqC1cvEvNFtGSYRI90M8h+cSwh28uhh3ZCDvKQMfyLL
         Ru9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707279012; x=1707883812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykLN7fs6qQRnuF8WSISkwVcQAWTyJrlW1o+moHfC85k=;
        b=KeWZm9erJhnDkSmwIIe88snHUKbC9wqmf17LE9sestC6JUBHS7ciafiaWl6zd6pdPG
         SqcRRQ/nKB0p9oBQyFC4T9//AsEcvqT5crEFqeUhAiCeeYj0s86jRw2h44lmKAnZs6BU
         110549TzaHCJICvkbyfCx1iIWJwWRIIW0x1cDZuLjf33pm8yp6B8Ocd4MRm4gcptZ+m2
         lUA1pny+5woUpERNOY/5PanMNtQ5cibARPNDOxpJqCsqCHGSW+v4LbR7dFpMOmaQnH8C
         h/Al6WQojUjxbVCpGlZCZqEgj173IwXYyzWbqcmCnZTvrNm09x+gpzDDxOcpVUOhlBcJ
         0YjQ==
X-Gm-Message-State: AOJu0Yw0SbrBoOaQ60Q2KLLL5YYyUEXFstaGwLvv9sL1MNtj/HsrQAou
	S3+0wu0Kcl4Kn5s6w6TnkSi/qyAErcmx9p5cRxmmvjK4muwgo858svdX0aPY7+z3EmwSH/A/2do
	/Qg==
X-Google-Smtp-Source: AGHT+IH+x2hZr5hgrqRm9mwlhGTe1zHc/Sl0rpDh0FcM4XBSnVg/GkvyIkz7aXggcw04KlEwBYkQvLZXGzU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:50c8:b0:296:58cc:601f with SMTP id
 sb8-20020a17090b50c800b0029658cc601fmr51199pjb.9.1707279012122; Tue, 06 Feb
 2024 20:10:12 -0800 (PST)
Date: Tue, 6 Feb 2024 20:10:10 -0800
In-Reply-To: <20240115125707.1183-12-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115125707.1183-1-paul@xen.org> <20240115125707.1183-12-paul@xen.org>
Message-ID: <ZcMCogbbVKuTIXWJ@google.com>
Subject: Re: [PATCH v12 11/20] KVM: xen: allow shared_info to be mapped by
 fixed HVA
From: Sean Christopherson <seanjc@google.com>
To: Paul Durrant <paul@xen.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 15, 2024, Paul Durrant wrote:
> @@ -638,20 +637,32 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
>  		}
>  		break;
>  
> -	case KVM_XEN_ATTR_TYPE_SHARED_INFO: {
> +	case KVM_XEN_ATTR_TYPE_SHARED_INFO:
> +	case KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA: {
>  		int idx;
>  
>  		mutex_lock(&kvm->arch.xen.xen_lock);
>  
>  		idx = srcu_read_lock(&kvm->srcu);
>  
> -		if (data->u.shared_info.gfn == KVM_XEN_INVALID_GFN) {
> -			kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
> -			r = 0;
> +		if (data->type == KVM_XEN_ATTR_TYPE_SHARED_INFO) {
> +			if (data->u.shared_info.gfn == KVM_XEN_INVALID_GFN) {
> +				kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
> +				r = 0;
> +			} else {
> +				r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
> +						     gfn_to_gpa(data->u.shared_info.gfn),
> +						     PAGE_SIZE);
> +			}
>  		} else {
> -			r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
> -					     gfn_to_gpa(data->u.shared_info.gfn),
> -					     PAGE_SIZE);
> +			if (data->u.shared_info.hva == 0) {

I know I said I don't care about the KVM Xen ABI, but I still think using '0' as
"invalid" is ridiculous.

More importantly, this code needs to check that HVA is a userspace pointer.
Because __kvm_set_memory_region() performs the address checks, KVM assumes any
hva that it gets out of a memslot, i.e. from a gfn, is a safe userspace address.

kvm_is_error_hva() will catch most addresses, but I'm pretty sure there's still
a small window where userspace could use this to write kernel memory.

> +				kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
> +				r = 0;
> +			} else {
> +				r = kvm_gpc_activate_hva(&kvm->arch.xen.shinfo_cache,
> +							 data->u.shared_info.hva,
> +							 PAGE_SIZE);
> +			}

