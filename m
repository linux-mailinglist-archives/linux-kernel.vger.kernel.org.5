Return-Path: <linux-kernel+bounces-34996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B8C838A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD5BB23CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875945A0F5;
	Tue, 23 Jan 2024 09:27:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB76257894;
	Tue, 23 Jan 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002055; cv=none; b=ctw+aAnJQ0RImERsx6AKVX5Q6+4GdyDWlD3qwpv4hxrTLjZQT0q5vzy+UyOP8SRhSI8t89Y2JgOIBtUlSGVlsV1NI3KNjaIn8fu03I0Di6j5P2Eq/Y+t4Vc0G/A8SVsTqBxyyU1ChAr4y3buSq19OCcV0G2mtnrckHTeqiR/hDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002055; c=relaxed/simple;
	bh=JysJK2JlLSGAqooo7PY7sHFbY2NERVJ2AeZzg9T9Avs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYITShRv65SI0CSI03bGXJWqSYw10KyF+5gNfF2PKUVcn6BJjZEw9lI2VrFKq7YGWMAPFzWE1gYYMoHn8w4gunWfxKiggJbHpLVLXu7ZBIPkjzke8kKJ5jkBQd9rZ7XJ3ohoT8ZkhdtB+5lIaBys2M181/6FVj2iqPL6+ojuk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F7261FB;
	Tue, 23 Jan 2024 01:28:17 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.48.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C27CC3F5A1;
	Tue, 23 Jan 2024 01:27:29 -0800 (PST)
Date: Tue, 23 Jan 2024 09:27:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/82] locking/atomic/x86: Silence intentional wrapping
 addition
Message-ID: <Za-GfqSFEA_4fUtA@FVFF77S0Q05N>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-10-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-10-keescook@chromium.org>

On Mon, Jan 22, 2024 at 04:26:45PM -0800, Kees Cook wrote:
> Annotate atomic_add_return() to avoid signed overflow instrumentation.
> It is expected to wrap around.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/include/asm/atomic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
> index 55a55ec04350..4120cdd87da8 100644
> --- a/arch/x86/include/asm/atomic.h
> +++ b/arch/x86/include/asm/atomic.h
> @@ -80,7 +80,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
>  }
>  #define arch_atomic_add_negative arch_atomic_add_negative
>  
> -static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> +static __always_inline __signed_wrap int arch_atomic_add_return(int i, atomic_t *v)
>  {
>  	return i + xadd(&v->counter, i);
>  }

I think that here (and in the arm64 patch) it'd be better to use add_wrap() on
the specific statement, i.e. have:

static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
{
	return add_wrap(i, xadd(&v->counter, i));
}

.. since otherwise the annotation could applly to the '+' or something else
(e.g. if the 'xadd() part is a special macro), and the annotation might
unexpectedly hide things if we add other statements here in future.

Mark.

> -- 
> 2.34.1
> 

