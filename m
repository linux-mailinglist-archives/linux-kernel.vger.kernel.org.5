Return-Path: <linux-kernel+bounces-37315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2866C83AE25
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFE91C2118D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA997E56E;
	Wed, 24 Jan 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N9AqOEFK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AB7CF3C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112918; cv=none; b=t5QW/bnm+M6fxteYjSY654A5RR3NhCBuG7udJgXoUylWgif7Gv6kF46AtedM96cozwLIvBIuokKvo77mdV1XaxQymOjsJmUyK4e1wnm3sq3Y43T0vtq+OLjbH3Mk5A+NUewDQZlGX29YxzRba0f65zt3Ky30a477dSx0T0JaCs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112918; c=relaxed/simple;
	bh=RvfyWPN0/pDbmTb/g0GVVom9vXJvmbkAO74qsKrres4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CEGo3rEW6UTtitDGJ9vnAux5oBjwbsgTzO15/WBJfwxi8m4DoRfFY0CiAyJAMC1HpQCDI8ofukEbYkibStemRg2AIghXuzwuh3AepuLSNI9YToRNvq48cn9maJznrjO6XjIaWT/S237xTi17wxFos6l+T1EzXzBDA8mVYngjsTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N9AqOEFK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5fface2c4afso52883497b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706112915; x=1706717715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DScpWxX4P0NW45UuZVlmkL6cF3+1DTwlqBdTnasMemw=;
        b=N9AqOEFKObdczq+6DdcfWjisDlehSMSZ38vgNr0eHmGPEFfdgQCUiSa8jE5puBhaL7
         ry4ZXRNoj7geN+c5tmSsqC9Q7kPz0npTZgTVntYzB/SeTMRTtFoc2XUC7EPnoE/rXTEe
         lP3EkUSQfsTNfQmXmdQPIYAdhYERpr88th6c+6GXKdwcWsIdEcT9UwHkw7kn3G/+ULso
         UMg0WzVF4QA0/2RWw24Eq1NuiHBOy6/vIDJM5R9c9tT2mmkgS2E9rAefL7iAoeWvpkPQ
         jMTg2dAS7xCUBvOkxgXi51/gWTDv/mez+Y07itlf8PtTgqZxXjNYvMCME2PjXY05cwWG
         TY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706112915; x=1706717715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DScpWxX4P0NW45UuZVlmkL6cF3+1DTwlqBdTnasMemw=;
        b=fl/v3WaDkxUek70ZGhwwenveKzzlqJSSWTTezDpRzZg35vrS5sJx4rqHv7ubwac7vd
         NIGu7hLfBavwdpM5l2p20BtRWRbT5T6sD5jA3avjhKVwMIt9Kte8+1j/50rvT0eccHVz
         8+oqoJv7fvZcLNetN1QFM35K4AQV7ci+UbuqrkYd4fcz1OhsIQvVIYY9QPrSpwQJXESX
         q3FX7xZUKBuii3gBXhLp7laQJGN8i53FgxxDfc7CyX5w6jKMoVk1MKVpd1tDGtDY5mRy
         MW6pdhm6MjC9oWN7h8CnyR5dzMPQpVLdRG5paVe4GxNEm3spAWMpAsUoktMT+0v85HCD
         I+zg==
X-Gm-Message-State: AOJu0YxLG5S72SDR0eNwuN6Seat2lCkct0pod8E0rG2wP9smbtg1X/8H
	otkLcc/EtxCThuOjI3hqjJNAiLwnrdzpTlm55+ygiwCPVVWmEVY0pvxIm26K51+gj1LgI3Lge3a
	dGQ==
X-Google-Smtp-Source: AGHT+IHugFCA1MsFbxTlJk6F3wFNy0Bmcnzj0q7iNmFt3wGOlc6Mlj+zbpXGNq5Bn6FE8++AUc/nRsQatQ0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:b949:0:b0:dc2:3247:89d5 with SMTP id
 s9-20020a25b949000000b00dc2324789d5mr51217ybm.4.1706112915268; Wed, 24 Jan
 2024 08:15:15 -0800 (PST)
Date: Wed, 24 Jan 2024 08:15:13 -0800
In-Reply-To: <20240123002814.1396804-25-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-25-keescook@chromium.org>
Message-ID: <ZbE3kacV0GbtK5zA@google.com>
Subject: Re: [PATCH 25/82] KVM: SVM: Refactor intentional wrap-around calculation
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 22, 2024, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded unsigned wrap-around addition test to use
> check_add_overflow(), retaining the result for later usage (which removes
> the redundant open-coded addition). This paves the way to enabling the
> wrap-around sanitizers in the future.

IIUC, the plan is to get UBSAN to detect unexpected overflow, at which point an
explicit annotation will be needed to avoid false positives.  If that's correct,
can you put something like that in these changelogs?  Nothing in the changelog
actually says _why_ open coded wrap-around checks will be problematic.

> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/kvm/svm/sev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index f760106c31f8..12a6a2b1ac81 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -400,16 +400,17 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
>  	unsigned long locked, lock_limit;
>  	struct page **pages;
>  	unsigned long first, last;
> +	unsigned long sum;

Similar to Marc's comments, I would much prefer to call this uaddr_last.

>  	int ret;
>  
>  	lockdep_assert_held(&kvm->lock);
>  
> -	if (ulen == 0 || uaddr + ulen < uaddr)
> +	if (ulen == 0 || check_add_overflow(uaddr, ulen, &sum))
>  		return ERR_PTR(-EINVAL);
>  
>  	/* Calculate number of pages. */
>  	first = (uaddr & PAGE_MASK) >> PAGE_SHIFT;
> -	last = ((uaddr + ulen - 1) & PAGE_MASK) >> PAGE_SHIFT;
> +	last = ((sum - 1) & PAGE_MASK) >> PAGE_SHIFT;
>  	npages = (last - first + 1);
>  
>  	locked = sev->pages_locked + npages;
> -- 
> 2.34.1
> 

