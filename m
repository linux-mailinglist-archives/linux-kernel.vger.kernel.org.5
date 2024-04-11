Return-Path: <linux-kernel+bounces-141603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3EF8A2098
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54281F23C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9122BD18;
	Thu, 11 Apr 2024 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F13iYDMX"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B5128DCA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869384; cv=none; b=IXnl5XJRoQEmSTvwEcEirp79UXIBYzdc3DOydj4HN8EngBwKmMmpGp1viIJ6+SpsuRY1V9ASViF0oBnm/FKs+hTItpwerz2Y1DnvjkVr4m3KRep5MUnmb+FWn+Dh2Zub5+Mrx7uub8LFaC5fpSr1qLvDw4wkaMygZxBMRVGVOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869384; c=relaxed/simple;
	bh=6ohnLm7z3PDG7MWeKCsPtN2uBOTfngdUGkrSE6HEqWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GK4W4y9ESJY2DgXo0U4mHPCw3DKN5OeDv1ihjeK6OKL3+HGFU4Sl1zmUMWysV7ew3KvDTvubtB27xrqZCsWnGiMfv68ufQ+MC4tT2hN/0188x3ohA89bh3In4KNFiAiPWhqgtXU4mCoq/0qs/GO3T6SDppigb0IMzNAeaFCTzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F13iYDMX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso398295276.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712869381; x=1713474181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqNHTRbTBamf9CG0cXrMM0YOfuqafLOBk3xuoM8380s=;
        b=F13iYDMX7yW18JTzN5qfC/hm/ZPvBRTo5yh/aO1ndLxy0G0tLlFAbH5L5rTjJ56BBx
         ZO++GqvBmmI6zqXsVInX8cRsKLg1w5i4ZN+HzePNsubtpi6GnaprrsAA4vmHWhv7MUYz
         n/uiJin7NXSG2TlZ9ud4FUM1pE0eT29LWDaYFYR+mNq/W3QL38gcX0P5jOUaZO73xX34
         v4h6Wdgc/5HCNz4hdCblQcov/OfRN9Hik51ZyYhc/dJy8fYTIlYWilVrXy+1WpYO+O03
         peEj9axx1TS3N4J5BakoxcMmQFpcgONFrXYWgZJq7u7bv98gquaIuBgRALSy6vgCvQ69
         heyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869381; x=1713474181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqNHTRbTBamf9CG0cXrMM0YOfuqafLOBk3xuoM8380s=;
        b=CFdn1NhFHTnxwwU84/oTIHNlsgOQevTogl0AQHcbOWlyrZwtKciBfqlEo1f+Q5FN4j
         mfKZ+pxFnS9cNQSVc2YoekGxWctlcEOMKbMsn8PUE/47gS96ZL0j8GVo+5V2HOqPF36t
         XRV4IcUb5/3SYt26P5DYGl+rNa+zLGq/c2i4/YSFwAoddGRK5Dwr3kzOOTg5gAhsKBYj
         R4Js1KLVZpo96U3tFtkZ7v4l+nYBuMHYP2XcmQ+Q+MQotyNymbphoSD+toSYft8td4c3
         JXMDS2dWQS9DAlfnphIpU6FmcU7C+jRwfXPwyXJuAIWRf/njgMat3/U4dKFwgwUezJp5
         ulrg==
X-Forwarded-Encrypted: i=1; AJvYcCW2lwu8mmJCYFEWjoEHZBNC13fVsTBkEk2BOlY1ZgGEa+5PjpYPtTibRS+AEHd0nba0aHfEa0ll0/IgaUJe9oBBR71wQLmD2cSxNvDm
X-Gm-Message-State: AOJu0Yyy1FhT8B+wv3IWO/pvkh5vSgC9KFcHLofeWHVdtzRJIL15FTVt
	dBBmm8EsbccZqj0xk40Q9HCrOYuQoSl0V+4dld4WCK80dPd9Pl7ZCQGqm2QMChVVlrKx6XmQgy+
	8zw==
X-Google-Smtp-Source: AGHT+IHLAavkjmCuRth9ZO5j6qCkcn9lXltBiSUO5FeZiNUU85dnwhoGihd7JtI7vD7CCsfcYc6LQX6nRa0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:70c:b0:dc6:e823:9edb with SMTP id
 k12-20020a056902070c00b00dc6e8239edbmr104731ybt.12.1712869381654; Thu, 11 Apr
 2024 14:03:01 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:03:00 -0700
In-Reply-To: <20240126085444.324918-12-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-12-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhhQBHQ6V7Zcb8Ve@google.com>
Subject: Re: [RFC PATCH 11/41] KVM: x86/pmu: Introduce enable_passthrough_pmu
 module parameter and propage to KVM instance
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com, Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4432e736129f..074452aa700d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -193,6 +193,11 @@ bool __read_mostly enable_pmu = true;
>  EXPORT_SYMBOL_GPL(enable_pmu);
>  module_param(enable_pmu, bool, 0444);
>  
> +/* Enable/disable PMU virtualization */

Heh, copy+paste fail.  Just omit a comment, it's pretty self-explanatory.

> +bool __read_mostly enable_passthrough_pmu = true;
> +EXPORT_SYMBOL_GPL(enable_passthrough_pmu);
> +module_param(enable_passthrough_pmu, bool, 0444);

Almost forgot.  Two things:

 1. KVM should not enable the passthrough/mediate PMU by default until it has
    reached feature parity with the existing PMU, because otherwise we are
    essentially breaking userspace.  And if for some reason the passthrough PMU
    *can't* reach feature parity, then (a) that's super interesting, and (b) we
    need a more explicit/deliberate transition plan.

 2. The module param absolutely must not be exposed to userspace until all patches
    are in place.  The easiest way to do that without creating dependency hell is
    to simply not create the module param.

I.e. this patch should do _only_

bool __read_mostly enable_passthrough_pmu;
EXPORT_SYMBOL_GPL(enable_passthrough_pmu);

