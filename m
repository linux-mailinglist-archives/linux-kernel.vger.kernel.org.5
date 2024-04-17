Return-Path: <linux-kernel+bounces-149286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7F38A8EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6361F221AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6581D7E58F;
	Wed, 17 Apr 2024 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2g7Mzbv"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BB07C083
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713393441; cv=none; b=IRMoprvG+aRO9f5HCqlp8bQ+Ddic0P2lAPVGNOBb2/ks/xMboz4u2U7hgk4HW8kxMB5teLuClc7kaLX0EWuLJvFpD7+kFhq7wUGr0hi5ZX0N3+nkvX+pN2FHXcBGgfeMFWp5Jklf9crKPTCiIWWfQow1yVVDVlREFUSTLcdYbE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713393441; c=relaxed/simple;
	bh=9Diuar4zSEBe6PV6jqdWT8jOdW7PHA+9wjn/yHJKVn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GIXzT7JpfD48SdMgRNAGQ+t67TF+qcu9E/hXUxeq6jC49ypGkm/fMI5khIk5ctTLYqrZQLBWY+IhNzneFhNyxH/Asi6fvlUJEEgM8Qr/7Tg71dHtypZBGZVaBPOD0xI1q/r1Ued3XbbXd32og6DnXBtnp+IHmlJpKF2qpZhuk38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2g7Mzbv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so548704276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713393439; x=1713998239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLOqVnpH5dycTSpt7sJQ0gumy6eJRRhFek46wdDt8Nc=;
        b=s2g7Mzbv5FuAUrI/cD7e26NBv1YyWe5RsppfBbxAGZvKZtuYJkdh5/4eFeB7kR20U+
         4Eh7FjsP+O75woIk+BJy/RpgE2/MnTe8D9jP9mDRPWZ4hwFAefFFpwdBiaP4QKfZpSIY
         dAFnx7aqfRaC6vvwkuI12p3bTPBlFZed58Zqywv2Zupnmi2AHhG2zsaH7KyvePYdW9jK
         tkbbJgc+B6Bu5Elg/ELhWc9UgiUwtwKef/I1+wq/+ux7g29nFhtFV0qOgREmuTuYqECE
         zNkNRF2zqEoNT40/cd0bHtyX5KkIQolbaraT4AhWSURv065jI7ZCWS9F7NuI8YXv+O1a
         MCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713393439; x=1713998239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLOqVnpH5dycTSpt7sJQ0gumy6eJRRhFek46wdDt8Nc=;
        b=Nl4vESYPO3LHmL6zEQRjnqH1IBvc/en9PDgKIjJWnIFKZNA/A0G41zQzzXhT3er2eN
         uHrE2GVAlUW1LMvBOiuS9bmkesup+HAkYok0rWVXMdvKZQJrQJ/F+QpYCTIFAAwRPCV5
         uKF91Pe848neUolzyuIb8HLQ5Qt0/keF3PtZ/HmuGuLUVfXbWAnWDe3y0FfCsPxYb0ah
         Cryky5A0AwQzkqfkZkY4uARD1GFD+9OTX/z6gzusAUGGYF6zr5wliTrU+FCzwBjARuT0
         QfcLs9Xq4bbsuoi3Nzgo+kL0My++i9P+E7bjLQLTywssxjdCKE/TXG/ckUSQUQqCl8tu
         8cSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUABJwAPVI0I9jHreMbuHnOdDEqSIEpTiyZ9wckRtmSjx079jokWTRWCf5nGko3vC8cYVasfEWz6HquZ0W/o5Am2tkqDXCem/oe+vdL
X-Gm-Message-State: AOJu0YwfSAiQof7fM3CKmzJpL2OA2MLEGQDKy2xE5niTwczp9ImB/wmT
	jxkhfYNIY2uHd4ZW3/ZbYapRhFXSQRxaChtx2Fdq1vs17mr8UCrxohRkvUKMVHbVZr4hLZyCxRM
	yRA==
X-Google-Smtp-Source: AGHT+IFla4GDZfHaU90+p/2AOWX0WflGLZrF5O8BHncJtppZttlhhCuIMLc3r7pr43yg6goGgjFtLzAvkvQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1104:b0:dc2:1f34:fac4 with SMTP id
 o4-20020a056902110400b00dc21f34fac4mr202972ybu.2.1713393439333; Wed, 17 Apr
 2024 15:37:19 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:37:17 -0700
In-Reply-To: <20240417200849.971433-2-alejandro.j.jimenez@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417200849.971433-1-alejandro.j.jimenez@oracle.com> <20240417200849.971433-2-alejandro.j.jimenez@oracle.com>
Message-ID: <ZiBPHVKKnQPYK7Xy@google.com>
Subject: Re: [PATCH 1/2] KVM: x86: Only set APICV_INHIBIT_REASON_ABSENT if
 APICv is enabled
From: Sean Christopherson <seanjc@google.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, linux-kernel@vger.kernel.org, 
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
	suravee.suthikulpanit@amd.com, mlevitsk@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 17, 2024, Alejandro Jimenez wrote:
> Use the APICv enablement status to determine if APICV_INHIBIT_REASON_ABSENT
> needs to be set, instead of unconditionally setting the reason during
> initialization.
> 
> Specifically, in cases where AVIC is disabled via module parameter or lack
> of hardware support, unconditionally setting an inhibit reason due to the
> absence of an in-kernel local APIC can lead to a scenario where the reason
> incorrectly remains set after a local APIC has been created by either
> KVM_CREATE_IRQCHIP or the enabling of KVM_CAP_IRQCHIP_SPLIT. This is
> because the helpers in charge of removing the inhibit return early if
> enable_apicv is not true, and therefore the bit remains set.
> 
> This leads to confusion as to the cause why APICv is not active, since an
> incorrect reason will be reported by tracepoints and/or a debugging tool
> that examines the currently set inhibit reasons.
> 
> Fixes: ef8b4b720368 ("KVM: ensure APICv is considered inactive if there is no APIC")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  arch/x86/kvm/x86.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 26288ca05364..eadd88fabadc 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9999,7 +9999,20 @@ static void kvm_apicv_init(struct kvm *kvm)
>  
>  	init_rwsem(&kvm->arch.apicv_update_lock);
>  
> -	set_or_clear_apicv_inhibit(inhibits, APICV_INHIBIT_REASON_ABSENT, true);
> +	/*
> +	 * Unconditionally inhibiting APICv due to the absence of in-kernel
> +	 * local APIC can lead to a scenario where APICV_INHIBIT_REASON_ABSENT
> +	 * remains set in the apicv_inhibit_reasons after a local APIC has been
> +	 * created by either KVM_CREATE_IRQCHIP or the enabling of
> +	 * KVM_CAP_IRQCHIP_SPLIT.
> +	 * Hardware support and module parameters governing APICv enablement
> +	 * have already been evaluated and the initial status is available in
> +	 * enable_apicv, so it can be used here to determine if an inhibit needs
> +	 * to be set.
> +	 */

Eh, this is good changelog material, but I don't think it's not necessary for
a comment.  Readers of this code really should be able to deduce that enable_apicv
can't be toggled on, i.e. DISABLE can't go away.

> +	if (enable_apicv)
> +		set_or_clear_apicv_inhibit(inhibits,
> +					   APICV_INHIBIT_REASON_ABSENT, true);
>  
>  	if (!enable_apicv)
>  		set_or_clear_apicv_inhibit(inhibits,

This can more concisely be:

	enum kvm_apicv_inhibit reason = enable_apicv ? APICV_INHIBIT_REASON_ABSENT :
						       APICV_INHIBIT_REASON_DISABLE;

	set_or_clear_apicv_inhibit(&kvm->arch.apicv_inhibit_reasons, reason, true);

	init_rwsem(&kvm->arch.apicv_update_lock);

which I think also helps the documentation side, e.g. it's shows the VM starts
with either ABSENT *or* DISABLE.

> -- 
> 2.39.3
> 

