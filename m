Return-Path: <linux-kernel+bounces-74992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 947FA85E0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC28284D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD9480624;
	Wed, 21 Feb 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X43WiF5R"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1DC80606
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529062; cv=none; b=E3rYHUi6teULmARJ3Y45JKAI2wcv7HN+NcDRPctMkgJlINrG/0O6R//R5v98xFObeeH4dD8MQY9B2lPVucWN4T1jALLNCiiqnqMfXlHW1yMqTMewF2KpDYkAvd3NQjEi48IB+Hbwv/BHEQDpnRwmi2ZeIHvDREu16/kWbDsV5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529062; c=relaxed/simple;
	bh=G1SI2A6tUC59YrjJyks6t8vsbhf0181tsF0nRbc+Gok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qc1DEsAsFsVc4w4gTAW+RhAmyfGJ4PU8iJDsNhTVpUuQcPBa7TGDzxQ9UTqMROySbeFgmi0a/47ouoF8XORYI5ooOq1vxpCfN0aIEaUuYOrWVN8I2N+9XesuD2IBnj6tEzhxGoq5rYKkFHROnsQ2bJzvH+9oA9ncstMBkaORuFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X43WiF5R; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so8073367276.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708529060; x=1709133860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHHzhvHN0kTOVo3wOm3ee1AH8U5eQGWfBAmKM9n5eN0=;
        b=X43WiF5RExkr9EECTADddb6evCbVDhimXJjF9Z8G1tBPIpqd42YzvkWgXqXe0pwiMP
         XvFq8cY20TKg3kTMLcAbc8ZqzGgkm+9WBF4vbuaQ/pJVl8BGWzw3Ev62NzGohQAFDAm1
         BTyeR98Ap8Ovku2X+RUA5RZjqO1UKH/0Rx3cQp71NPWIN/OGRVPBsJhL481LsWlZH/aI
         xDnSkpMoAAnT+hOEr/T4oYJdci78npqM8m+Qb3rJBGTWmrvrHRzEonmfw0AIDghXQ4q2
         zaCcKaaxAHBCf3ojozyQz4NSepuHajT/O3By5RDbtoUi/LqUCzTzeNfS0rirPuDl0vzz
         8TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529060; x=1709133860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHHzhvHN0kTOVo3wOm3ee1AH8U5eQGWfBAmKM9n5eN0=;
        b=jrX4Ow8WI/t4VGePSO2lNPWJt8dVHz9shhovmez/BtslqeM5ZkBGcEINzUsLFbWBkf
         k8lkfqcZyu5PMyN9ZPnJUbjvAVmQdc73akt/Iyy47Od3JQUA7TVRnpDKkH1FGr58hbVd
         +YoYAyohoOrf7TJ6ZCoRvyfMXhBHJk9p+GDEVOp+mAN5Z0T83yNE4xvwRhzTxvdLGA/1
         sthCmHFODklX49X69qpGOpXJlRDVrsO1emBC4jRNgsvNnZFExP0smOUrCFyb2cVlMcgP
         C9EinAE09E7qgmhHO7osPP3sWnmagcw4c4dcxpXOW+JDsD3grSYA9E9+l1vmbQtIdOuQ
         sAwA==
X-Forwarded-Encrypted: i=1; AJvYcCXM4NKAwB0sezP/jvWTGakd5r4Q9kt6/U0wh0HF5dYbFQxJHUsnLKR+9gUVSe4Bmh2zAtS1J7K+3t+JLJ3vdxSmc9bwnVa2rpV0eGsQ
X-Gm-Message-State: AOJu0YyzZyBBwKMdNGKp9u266NRMA7MTyubBE9iFShXgy0BPHG0Fdtq4
	/WtwOtXY2+QOy3DErgyU8XouZIbOdwLnNqvuWXaTdpqM0qrECOFjhWZu8dRuwApzHQwh8JIz9pz
	SQA==
X-Google-Smtp-Source: AGHT+IHIiqpo182eOydyp2kAE2MyaxiISahNsXsmBtUhUZTch3wVQ+TmxdSEWBoV3EtlCh1QkxcGWISraHk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:114a:b0:dc6:b982:cfa2 with SMTP id
 p10-20020a056902114a00b00dc6b982cfa2mr703388ybu.8.1708529060015; Wed, 21 Feb
 2024 07:24:20 -0800 (PST)
Date: Wed, 21 Feb 2024 07:24:18 -0800
In-Reply-To: <20240217055504.2059803-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240217055504.2059803-1-masahiroy@kernel.org>
Message-ID: <ZdYVouaZX0AQF0V0@google.com>
Subject: Re: [PATCH 1/2] kbuild: change tool coverage variables to take the
 path relative to $(obj)
From: Sean Christopherson <seanjc@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Feb 17, 2024, Masahiro Yamada wrote:
> To maintain the current behavior, I made adjustments to two Makefiles:
> 
>  - arch/x86/entry/vdso/Makefile, which compiles vclock_gettime.o and
>    vdso32/vclock_gettime.o
> 
>  - arch/x86/kvm/Makefile, which compiles vmx/vmenter.o and svm/vmenter.o
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/x86/entry/vdso/Makefile |  2 ++
>  arch/x86/kvm/Makefile        |  3 ++-
>  scripts/Makefile.build       |  2 +-
>  scripts/Makefile.lib         | 16 ++++++++--------
>  4 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index 7a97b17f28b7..148adfdb2325 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -9,7 +9,9 @@ include $(srctree)/lib/vdso/Makefile
>  # Sanitizer runtimes are unavailable and cannot be linked here.
>  KASAN_SANITIZE			:= n
>  KMSAN_SANITIZE_vclock_gettime.o := n
> +KMSAN_SANITIZE_vdso32/vclock_gettime.o	:= n
>  KMSAN_SANITIZE_vgetcpu.o	:= n
> +KMSAN_SANITIZE_vdso32/vgetcpu.o	:= n
>  
>  UBSAN_SANITIZE			:= n
>  KCSAN_SANITIZE			:= n
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index 475b5fa917a6..a88bb14266b6 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -4,7 +4,8 @@ ccflags-y += -I $(srctree)/arch/x86/kvm
>  ccflags-$(CONFIG_KVM_WERROR) += -Werror
>  
>  ifeq ($(CONFIG_FRAME_POINTER),y)
> -OBJECT_FILES_NON_STANDARD_vmenter.o := y
> +OBJECT_FILES_NON_STANDARD_vmx/vmenter.o := y
> +OBJECT_FILES_NON_STANDARD_svm/vmenter.o := y
>  endif

I'm 99% certain only svm/vmenter.S "needs" to be compiled with OBJECT_FILES_NON_STANDARD,
and that vmx/vmenter.S got caught in the crossfire off commit commit 7f4b5cde2409
("kvm: Disable objtool frame pointer checking for vmenter.S").

"Needs" in quotes because I don't see any reason when __svm_vcpu_run() can't play
the same games as __vmx_vcpu_run() to make stack validation happy, and
__svm_sev_es_vcpu_run() flat out shouldn't be touching RBP.

I'll throw together a series to (hopefully) remove OBJECT_FILES_NON_STANDARD
completely.

But for this patch/series, I think it makes sense to do a 1:1 conversion.  That'll
make it much more straightforward to resolve the eventual conflict, assuming I am
successful in dropping OBJECT_FILES_NON_STANDARD.

Which is a very long-winded way of saying:

Acked-by: Sean Christopherson <seanjc@google.com>

