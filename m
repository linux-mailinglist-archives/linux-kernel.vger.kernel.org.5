Return-Path: <linux-kernel+bounces-66026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E45FF85558B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B70828397B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A2714198A;
	Wed, 14 Feb 2024 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WPacOA76"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC0141987
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948447; cv=none; b=BPlGC9cV/qoySxXOYoiAGaTSW5zsLbrQTaoyZmqmEGCfmMq4SaaViVtBBfcZSW2bJvI8umYyo7P9I+cxKNui5gUMxJTet47IFL8Laxoy9A95prfwXTXlc6foKLjtsAVnN4O7o5vh2l961GYNT8kJddtcKuIepc4kZQziZqK36Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948447; c=relaxed/simple;
	bh=K6cDHnzAl4sLP14OKUvfd5jdUMhZX1ctJ8TVWJBz+yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REq7GqRA660gz6PPrQ/nKO0kQexAtvWwY00iUDQTRsBfyXDKMhB0c7mqT2rRKaNF8zD6rsc5pT2UGjQxxFX8PmMrj3y5UMoyS1LtuiLYWr6WyOz7UXwcG+yg6NdUpJnKcMGINQVfwVsbsLpyg0VEga2qYk4k9kALd0ZA41Ymhjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WPacOA76; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5961a2726aaso139245eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707948445; x=1708553245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sleFKn1PUH2Rkn/xzX8cOIwI1bd0b7EDvB+KCcYyKCs=;
        b=WPacOA76FkFbypMPCyvHfhvPba1UdRyaa15FARcSy7n69jN7bRReH2lhsesnGYEy2d
         oIMKW7WbxDXiIH3FTLpO8IPsLR05+JKeI6KN7abkdMK7Dqqkr2SiQvKantN453aURbfy
         r2t/TWvTks3PxURBRoRyFMs9S4ZQMLDPJgOZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707948445; x=1708553245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sleFKn1PUH2Rkn/xzX8cOIwI1bd0b7EDvB+KCcYyKCs=;
        b=CNpklxYRPeS14pxrliwDo6EWMpuRszHPdc+xEcbHWeaBtrSUadosDGQlms7N5L7QWc
         CY36GVGtgpmfEJg2vcDVcaZ3N39vyxe+kVTf80DllTMdMNCFeaEGP++CtHV70LtEGr89
         rZy97QQjQUVl7O/slYp/nryyZuGZGGc68zyjHTvrrQnOta5TtIOMRPm2hH4r+oQDYsCF
         O5gNwgYaZOCJ4khrbTbr4htNS/2VPiMxZWZ+7pjymevdOhHGfwvL3VZiT7pk+m+qLD+5
         eP8rCHcCiehfHfu0HNyh4R7fJlTGXsGQSpuB74La5CUNJZriZ7zquYtFsOy4m3wLfLeX
         lVLw==
X-Forwarded-Encrypted: i=1; AJvYcCUjjw8wdzoXpMs/2FPVBqPRmekmWMjMknxiW4bu3x3cE704d8PbgOfzHlmUqLLJ5OhT4/dgFGs3e/twrUJwMHYAIOTx0ff+OrWA0iin
X-Gm-Message-State: AOJu0YxMdaDu4CotMrGhNwDTqkmrrbP05DsCxb7LOAzI2x+EwJM0ehnJ
	AfhYkXR0FXwgW18OkSuc2FxGlRml0C2x+Kltm6yHnHKhALWDnb7nt4iRCIXK7A==
X-Google-Smtp-Source: AGHT+IGz/ssrchHiTuyzilMpWL/T9c2lkPAOgkUgzUcy8sr4eYzKQF2LdNDAK5B6bwMdevqCle4AAg==
X-Received: by 2002:a05:6358:648c:b0:176:5a5e:4bfc with SMTP id g12-20020a056358648c00b001765a5e4bfcmr4080166rwh.3.1707948444846;
        Wed, 14 Feb 2024 14:07:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUchfZsRVKTfQebs+X7kNrW9fUdJ8LZ5XMtaiqhqSXF9jSBU2WtwT1FdJEBgg8UhbKxDiD19wrmGnhaTWs59a91wXO5Kovz00uoPU/4CfRLF8heeZP0m1YGhUECswc9oh85gMjXAYRZjnbhhHHNsuQ4pEubyqNI0rS4LsK6K8PTCLihcN7EOIvmbO7xgwIHPg1c6bEX9brNmiYx+dLwDJA7pfMqyVMo
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j191-20020a638bc8000000b005cfbdf71baasm4819711pge.47.2024.02.14.14.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 14:07:24 -0800 (PST)
Date: Wed, 14 Feb 2024 14:07:23 -0800
From: Kees Cook <keescook@chromium.org>
To: Fangrui Song <maskray@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] x86/build: Simplify patterns for unwanted section
Message-ID: <202402141405.0755DD4E5E@keescook>
References: <20240214212929.3753766-1-maskray@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214212929.3753766-1-maskray@google.com>

On Wed, Feb 14, 2024 at 01:29:29PM -0800, Fangrui Song wrote:
> A s390 patch modeling its --orphan-handling= after x86 [1] sparked my
> motivation to simplify patterns. Commit 5354e84598f2 ("x86/build: Add
> asserts for unwanted sections") added asserts that certain input
> sections must be absent or empty. The patterns can be simplified.
> 
> For dynamic relocations,
> 
> *(.rela.*) is sufficient to match all dynamic relocations synthesized by
> GNU ld and LLD. .rela_* is unnecessary. --emit-relocs may create .rela_*
> sections for section names prefixed with _, but they are not matched by
> linker scripts.
> 
> .plt instead of .plt.* is sufficient to match synthesized PLT entries.

Do you mean ".plt.foo" matches ".plt" ?

> .igot and .igot.plt are for non-preemptible STT_GNU_IFUNC in GNU ld (LLD
> just uses .got), which the kernel does not use. In addition, if .igot or
> .igot.plt is ever non-empty, there will be .rela.* dynamic relocations
> leading to an assert failure anyway.

I think at the time I was dealing with avoid multiple warnings out of
the linker, as I was getting orphan warnings in addition to the
non-empty warnings.

> 
> [1]: https://lore.kernel.org/all/20240207-s390-lld-and-orphan-warn-v1-6-8a665b3346ab@kernel.org/
> 
> Signed-off-by: Fangrui Song <maskray@google.com>

Is anything harmed by leaving all of this as-is?

-Kees

> ---
>  arch/x86/boot/compressed/vmlinux.lds.S | 6 +++---
>  arch/x86/kernel/vmlinux.lds.S          | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 083ec6d7722a..9f288f67972a 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -104,17 +104,17 @@ SECTIONS
>  	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
>  
>  	.plt : {
> -		*(.plt) *(.plt.*)
> +		*(.plt)
>  	}
>  	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
>  
>  	.rel.dyn : {
> -		*(.rel.*) *(.rel_*)
> +		*(.rel.*)
>  	}
>  	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
>  
>  	.rela.dyn : {
> -		*(.rela.*) *(.rela_*)
> +		*(.rela.*)
>  	}
>  	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
>  }
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index a349dbfc6d5a..b3da7b81d2b3 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -463,22 +463,22 @@ SECTIONS
>  	 * explicitly check instead of blindly discarding.
>  	 */
>  	.got : {
> -		*(.got) *(.igot.*)
> +		*(.got)
>  	}
>  	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
>  
>  	.plt : {
> -		*(.plt) *(.plt.*) *(.iplt)
> +		*(.plt)
>  	}
>  	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
>  
>  	.rel.dyn : {
> -		*(.rel.*) *(.rel_*)
> +		*(.rel.*)
>  	}
>  	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
>  
>  	.rela.dyn : {
> -		*(.rela.*) *(.rela_*)
> +		*(.rela.*)
>  	}
>  	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
>  }
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 

-- 
Kees Cook

