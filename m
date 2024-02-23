Return-Path: <linux-kernel+bounces-78774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC80F8618A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771341F25FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB65129A8E;
	Fri, 23 Feb 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XYzNY+5N"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1728D12BE99
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707708; cv=none; b=sar8NuEWQ3buKlSiQ5WnxJDZFCgH6HhYgCktuaGj2JI41Tsll0O0IA/jzUS+L0N1Dpyw8KgO/2y2L9xmKLMphpkbwzNuM40553C77VL3OAxwmIVttn4P7KKO2DDuerbXdpFiJKsg+uJKxeHXqjPRKq1/BR/YHWwAlM/1rWJMawA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707708; c=relaxed/simple;
	bh=x9++INN2m+gpmUh/KCO+PSvjrYfe9RJFSkVt3950PsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z8aDoQ9zOEg8jp4uf9DBGXMxj3/J+MCPyQwqjRUyBC7u7oDpX+Ywqtr16EveOZinFpS8UuCZh0/NUpmxjcyioQmDELRB3D50sNoq2wQTe2zABv3cFtVL9zbx7v+0zG3iiyf0ulYLygbMBhXtnl1DXziTSrHzzfToF/bNWcVhSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XYzNY+5N; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cfc2041cdfso759535a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708707706; x=1709312506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfc17/TKkSDYgpRi5ALTWEPHfW2uf7bskubXgF1ZJyM=;
        b=XYzNY+5N9nDJwUBFHJ59wyzsY5acfJX/77wylFZqBcvmkBkeuLWfpsTkVO627VN/k7
         8qhGqEK5DnMb21wTWOxk42QNwALjarm7cAIGJVz/NoAV2yrbybNK9M1PGKclu/RlkiBA
         MiOD2u+LG1vIzDmYLEgfq3f+SlWY6lm5fsSxg4ZtG72oTUo9yMkoVnWsl9R2znh8+vlZ
         kJf0ROc3egeebelhdlu/EgLbFNrN8E0vH8sn7q1Kbnhd1Ix9jhncccIcdtm5SL/4Iy+L
         0Dt4wrIFe0Q0Ibs2EJ6FkZlsqnHO6oeSM2i0lHnj3k9GXIrZWXdt8TXGVxoClmuXqGUm
         ix3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707706; x=1709312506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfc17/TKkSDYgpRi5ALTWEPHfW2uf7bskubXgF1ZJyM=;
        b=W9YCt7fnkE+uqAL0hwXdk/ZTTGf4+lfTpLl6lvj6vsY+GyOJxkmumrH9Gt8WFhNpse
         ugXulpyfzNC6/G9u4OtBlpy6FpOY444Crd4vxq5nOi43KJzYMPs/G12mkA/76k5hSND/
         UhUQOZqF2Np98jIVVcyaw4PrAVluJPxfsUTrubbvB7owJWwc2q9Ppi8zaVpGopAJGRcw
         pXLGdzcLI7zI19vBjtjR9u8S1GyxWZvC1r+xnPHPXvyMwoAo9A3SNlGQnLFwCYiibdpb
         zvKKF2mSX5025jhgZ1x4vbOdnsaGp43R/8fnapfADcmBZv0qrrd95iWUq5aSKXwu0+bC
         v3Lw==
X-Gm-Message-State: AOJu0YyTb/N4GuhPdyEulF6+bDBQZGKx4uA0QLVpFrnFq6rGSTVp9UUW
	N3SD9hvXSJhPLkCLmtz2vJHhOxMkl9+iiZQ4CS/b+vUCAmib6tfBSXALX6FSGJJrlio/6t+xvDb
	zjA==
X-Google-Smtp-Source: AGHT+IHN4bcZqxgjuf+nU1Zula5l2c65fnndy7t0fwNKOatXmncYBrpJyaX50gAvLeG5jHGHzeWmn+kw+xU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:995:b0:5ca:43c7:a67 with SMTP id
 cl21-20020a056a02099500b005ca43c70a67mr997pgb.9.1708707706441; Fri, 23 Feb
 2024 09:01:46 -0800 (PST)
Date: Fri, 23 Feb 2024 09:01:44 -0800
In-Reply-To: <43b9125f-35d4-4368-8783-a41799b11c21@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223104009.632194-1-pbonzini@redhat.com> <20240223104009.632194-5-pbonzini@redhat.com>
 <ZdjCpX4LMCCyYev9@google.com> <43b9125f-35d4-4368-8783-a41799b11c21@redhat.com>
Message-ID: <ZdjPeKDITWoVre6o@google.com>
Subject: Re: [PATCH v2 04/11] KVM: SEV: publish supported VMSA features
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	aik@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 23, 2024, Paolo Bonzini wrote:
> On 2/23/24 17:07, Sean Christopherson wrote:
> > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > index f760106c31f8..53e958805ab9 100644
> > > --- a/arch/x86/kvm/svm/sev.c
> > > +++ b/arch/x86/kvm/svm/sev.c
> > > @@ -59,10 +59,12 @@ module_param_named(sev_es, sev_es_enabled, bool, 0444);
> > >   /* enable/disable SEV-ES DebugSwap support */
> > >   static bool sev_es_debug_swap_enabled = true;
> > >   module_param_named(debug_swap, sev_es_debug_swap_enabled, bool, 0444);
> > > +static u64 sev_supported_vmsa_features;
> > >   #else
> > >   #define sev_enabled false
> > >   #define sev_es_enabled false
> > >   #define sev_es_debug_swap_enabled false
> > > +#define sev_supported_vmsa_features 0
> > 
> > Ok, I've reached my breaking point.  Compiling sev.c for CONFIG_KVM_AMD_SEV=n is
> > getting untenable.  Splattering #ifdefs _inside_ SEV specific functions is weird
> > and confusing.
> 
> Ok, I think in some cases I prefer stubs but I'll weave your 4 patches in
> v3.

No problem, I don't have a strong preference.  I initially added stubs instead of
the IS_ENABLED().  The main reason I switched is when I realized that sev_set_cpu_caps()
*cleared* capabilities, and so decided it would be safer to have a separate patch
that effectively stubbed out the global SEV calls.

