Return-Path: <linux-kernel+bounces-46732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A3684434E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB8C28B9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0A129A97;
	Wed, 31 Jan 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZUKm2bO"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218AF80C07
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715813; cv=none; b=Mped+qu/7mevDuXDpmzzCsBbXezV7ppxs2Whjke8Meo7mt4o2c4HQ9pqcetefrr0xzNhasBw6YRR9wQeeI2CT1ATF3D2UsG4gfxZBWGYK4DJvpHrDYFJr2WjoOk3JOTa/I7GfJuHLApTNKkLdQ/uu3u8Rlcs0Qn8SW2QFei53bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715813; c=relaxed/simple;
	bh=vhbrZMHFjelXGRFhJ+BjMGubacmhxkKYeRxhEF4X3Wg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DFPzsvZsDOeYVq/Q7iR/MhiVORXJZnnauFTk2U8f7TYi/9xxIuHr/nUHTlQj8AgCjRM3oyX3YUH8r5AQQMgqGHWugpHbqYHQfPh+QYI7LsUC5yPc/GL2IvjGt894huYAtCzGxV0UYXvu8szatZNZZYgSx8g4sZdrvS8+RpygUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZUKm2bO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60404484c23so23311037b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706715811; x=1707320611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXirN1TSqSLWWOLHNkxUHkuNKeZ8QnnuiK8GRbGZ3WI=;
        b=nZUKm2bOv4Y/oKKlz7W08nhMwawd3ALiBhncqSJXQONTBJWACJvQOsl8sUaJ/mnTxK
         Pw6SemBuJSNhNzBfJTU/H6PqjnVinmKWmqeTgLKQsz9XkdA+MuGjyv81WMZIIBCmwt7i
         /kAex6UlC3z7Wk7N08RX+WQlQfA6L4AbHADXbAQCiNX1mMnzJG6LJQ3lD1rzdSh6Jexk
         7M9pu4Q7B0Yz1OqoKlngXKTvFNjCRr63x2l3wNcqkj9tngcK1XaIbWuyMRWfGlfWDa+9
         8kNaj66Q2T8ZR5OaWbvC7IS5AzS1wi5my9Uj/k0O+oOkAco0FOGkTiNcNJs5CULgqvoc
         TYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706715811; x=1707320611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXirN1TSqSLWWOLHNkxUHkuNKeZ8QnnuiK8GRbGZ3WI=;
        b=jVGtUWP15rCNrzoRf2+8So/xjSjR+WfxbimeA2OFizufL9tBhOlAXp6xj09e4Y2CiP
         u6LTxe1hL7YfE7mlDMTwTa2HnKVC8M8pb3Z9U0j5qGGplrs1LL5GH9h/qjtXHnFDd4HX
         5bU3hA4WPVdUY0kJ72LIiybgG5sJAdVn/dp9LEmjgyuJvpDm31ka9jIuIdIh65rvNqiT
         9Kr5bDxVeT1wAb5AldRtetERY4Ph1knB3On64ManW4noHkXTzRuMSDVVnZ03/3p2GywM
         ijrrSUwOkncqfGEvmKilJVuVQbXH3tmVfQECjfNLGVMTw8+k9jRMiAOnmt5rBtm1h7yg
         aOIA==
X-Gm-Message-State: AOJu0YyFJrsTl/8RFKEPWH7lo0lmlNwb02T+7VZcn2b65mvGHBw75AoR
	gZjJQHbUQegYRRlwZKj4ZwV/r/V7NdkJlNZme8flEprXrAaIDnH11jJKO7R+cpFV9GgKebQunLy
	OLQ==
X-Google-Smtp-Source: AGHT+IGa5eXROO4MrCt68oQY1jH9FGoPqrFbSytbtF+B4n2ewFSTJB3rHFDw5pL2slDaY8z/2D4CFC8loNk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4cd5:0:b0:604:9ba:9a03 with SMTP id
 z204-20020a814cd5000000b0060409ba9a03mr394475ywa.2.1706715811197; Wed, 31 Jan
 2024 07:43:31 -0800 (PST)
Date: Wed, 31 Jan 2024 07:43:29 -0800
In-Reply-To: <20240123221220.3911317-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123221220.3911317-1-mizhang@google.com>
Message-ID: <ZbpqoU49k44xR4zB@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Fix type length error when reading pmu->fixed_ctr_ctrl
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 23, 2024, Mingwei Zhang wrote:
> Fix type length error since pmu->fixed_ctr_ctrl is u64 but the local
> variable old_fixed_ctr_ctrl is u8. Truncating the value leads to
> information loss at runtime. This leads to incorrect value in old_ctrl
> retrieved from each field of old_fixed_ctr_ctrl and causes incorrect code
> execution within the for loop of reprogram_fixed_counters(). So fix this
> type to u64.

But what is the actual fallout from this?  Stating that the bug causes incorrect
code execution isn't helpful, that's akin to saying water is wet.

If I'm following the code correctly, the only fallout is that KVM may unnecessarily
mark a fixed PMC as in use and reprogram it.  I.e. the bug can result in (minor?)
performance issues, but it won't cause functional problems.

Understanding what actually goes wrong matters, because I'm trying to determine
whether or not this needs to be fixed in 6.8 and backported to stable trees.  If
the bug is relatively benign, then this is fodder for 6.9.

> Fixes: 76d287b2342e ("KVM: x86/pmu: Drop "u8 ctrl, int idx" for reprogram_fixed_counter()")
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index a6216c874729..315c7c2ba89b 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -71,7 +71,7 @@ static int fixed_pmc_events[] = {
>  static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
>  {
>  	struct kvm_pmc *pmc;
> -	u8 old_fixed_ctr_ctrl = pmu->fixed_ctr_ctrl;
> +	u64 old_fixed_ctr_ctrl = pmu->fixed_ctr_ctrl;
>  	int i;
>  
>  	pmu->fixed_ctr_ctrl = data;
> 
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

