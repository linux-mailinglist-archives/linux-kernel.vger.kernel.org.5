Return-Path: <linux-kernel+bounces-67616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A124856E12
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AB41F21416
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B488413A89E;
	Thu, 15 Feb 2024 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOopWdvt"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7322CCA0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026934; cv=none; b=HmCl5k5QvZQAQxJLXBLZIRyq5UKD09i4/y1Et/bEc8kx4PuHNyyIYiAWgUf0RKuDEQS9/yI+MrkFCbdkUBGPhuOXyEB26HEdqpN88DYGI0sRrrSSTxZmmQ0I/qNJZEjCGex0eRHKI0XCs1yCVdPZLn7uO/zTKRLdow5SZdkiAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026934; c=relaxed/simple;
	bh=kT5YoBgoPZ0lLO55VRtAadBAv4FxNR0YQTQAqq356es=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m4Y6dLUc1qkZgEqFG9bSjveI7yYcO9S0wwwzJ1BxR4O5ssohlvey611OQ4bMyY9JIW9L7joavqWRUQncpl3w/J6yATn5kMT7EcGcFPlvaBTS48MPr6LMa+f18BU2yhxGsZBRqot6iyKXm3RJnMHEiJ6zTBkr6G/tHft3tReIAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vOopWdvt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso1837005276.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708026931; x=1708631731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+ytbs/OlyKZvUUYHvg+QSwbP7J8EV4VQfdwZAf3qxo=;
        b=vOopWdvt93Hcbgkx7FHYmHUtYfT5N7GfvPQdRvDaT9D5f1z7lP627a8GUUa2CilUAZ
         Cp3U47D2bO3Ycjo9zZ6/XRnm2nIX5ZmZW+5WyodUPYCJWtOKgveXOhTD8bbs9sqbg9il
         8VV1lEZ2uwo2UcWFIoXbkZXY/fW0qX2XIobf7YxVC9k8EJ1qGRzK7684+VEp1fu92C+v
         ADI3x77jhQIuPtv9+jMSzHhS2oEkM/4PzKNAMXFngwEEgjifK2/Qff2oN+lUWR9P/lob
         ihKu3Rl69gIR44nr6r9J24/28xnXgmnaKwu/7Unco6QHPkXZqT82YKTFB+7w2bTrSamX
         xRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026931; x=1708631731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+ytbs/OlyKZvUUYHvg+QSwbP7J8EV4VQfdwZAf3qxo=;
        b=EXUUcJfQ4G0Qw6v7kFwf+ryvZIzBjfMjuandK2sBj2jfjJKMP5eKLWTHuWWIrMrH9/
         BavICwq6Ka6ymWGI/uyk9kQI4GWr6Y7gvGmCk2JRy2gE4YJ+u/gy61PvdW14xM7+HkYq
         pgvwSQhqSiS7XM7jbF1e21yUifOf41fwbdF7VzcD7Uwrd2/ZiOWcWfqr3RrBLupyKloe
         OLSGqv5aQJE0kQaUfrjeP6y2OUnKInCcKpOCKzny5GSbO5NVr8EyZMVunKMu5Ql+leo0
         Y2jh0PRChTW/CeubLXwA3lQCAgHedLEtmCIITOgk5sVp/gX/FzASMXXjo1H+7KzvNnVG
         Fv9A==
X-Forwarded-Encrypted: i=1; AJvYcCVNPXKRH5GKmQqJyEt+bLTOSHCGOSVqUO/nak6nOWQrdFNevt3F2wt8s45H04SgC60WguwZLHePydVFJl70zkT0W2S6tfdxnX7DEZxE
X-Gm-Message-State: AOJu0YzK4GMyLhv/caaRZOlolKIaOp4hrTjVYLP0F+rLLpOYvckYcs/J
	XU/x29YOUQ4rj7JFzJE8nGKrrEVxBbRs3ry9bf0nmuvwhbg0O1YqOMIAlYvClPUt95udbJYItNx
	/Ew==
X-Google-Smtp-Source: AGHT+IG04njOW89dgCobRztopxDWGJ70SPl/1yBF3/h9CXtghLVsshGy50Hx8eZcwGq/tfqEm9M4YoyGBb8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1885:b0:dc6:207e:e8b1 with SMTP id
 cj5-20020a056902188500b00dc6207ee8b1mr622114ybb.2.1708026931610; Thu, 15 Feb
 2024 11:55:31 -0800 (PST)
Date: Thu, 15 Feb 2024 11:55:30 -0800
In-Reply-To: <20240215133631.136538-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215133631.136538-1-max.kellermann@ionos.com>
Message-ID: <Zc5sMmT20kQmjYiq@google.com>
Subject: Re: [PATCH] arch/x86/entry_fred: don't set up KVM IRQs if KVM is disabled
From: Sean Christopherson <seanjc@google.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

+Paolo and Stephen

FYI, there's a build failure in -next due to a collision between kvm/next and
tip/x86/fred.  The above makes everything happy.

On Thu, Feb 15, 2024, Max Kellermann wrote:
> When KVM is disabled, the POSTED_INTR_* macros do not exist, and the
> build fails.
> 
> Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  arch/x86/entry/entry_fred.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
> index ac120cbdaaf2..660b7f7f9a79 100644
> --- a/arch/x86/entry/entry_fred.c
> +++ b/arch/x86/entry/entry_fred.c
> @@ -114,9 +114,11 @@ static idtentry_t sysvec_table[NR_SYSTEM_VECTORS] __ro_after_init = {
>  
>  	SYSVEC(IRQ_WORK_VECTOR,			irq_work),
>  
> +#if IS_ENABLED(CONFIG_KVM)
>  	SYSVEC(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
>  	SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	kvm_posted_intr_wakeup_ipi),
>  	SYSVEC(POSTED_INTR_NESTED_VECTOR,	kvm_posted_intr_nested_ipi),
> +#endif
>  };
>  
>  static bool fred_setup_done __initdata;
> -- 
> 2.39.2

