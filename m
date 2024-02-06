Return-Path: <linux-kernel+bounces-55617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A05484BF09
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73ED1C23B77
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBEC1B956;
	Tue,  6 Feb 2024 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ptsah1Cv"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B3B1B946
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707253729; cv=none; b=TYOI7Ns7rQS7EmBrUlRm4vOl5JgN20bDlfz8cvUYgbvoRMrcHbZepzJlQEW9JCDkVvm4uk8MPXTmeKxy7sCi8amG/mAOlDM8PmyIFnKgAicn8MD4gRocTABH9hNKmpQNwHi1cYTCOvTxIAwDHf2UshJsrCwBX0axdZzcEFYjcqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707253729; c=relaxed/simple;
	bh=zgAS7eEojvB4l1dUuynzszfleLxH1o1uHdUEOuRKM+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nmllUWKfBz8DATg7YwPZHaNlJLM+qJwPcNwKzTQtmabzzTfKD2ZOXbZcPvcG6DZf1LbGDsHwG54zBxy5O/vyMW2mH64pARhlWewTSt7VE5YTSYabYZsQhprP0LGDdXAKVx4aeQthZu0W0XMdosyNBB75V79UszFvEWKJz9RcypU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ptsah1Cv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6040ffa60ddso121771757b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707253727; x=1707858527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jgnL0Q5rTfFWXEVUOgZf2CAS8hpKNN7Sgg+AvUluPpQ=;
        b=ptsah1CvrUng+wtUau/vwqn94IsZZM105D5odxW3N5hAU/MlhjXUvviAriFSXjg/6r
         8+VeutkvE0KEninyKCWA6b13hT0jBGniBnCsjJ/c3PoFgxrRZUYaYEpXZhKdE6mUXTFL
         4GM6fZAt/kkPV+m4yCFPgsoZwEeeRP91b++6o3Pb79h8uhR5Lzsdj5V0Ns38SSTSlOUI
         PR5yshL6MAU+Pq3cX6055zw9i5zdq6WaSY8o/T0/LEPLCrHpnwn/zlneTRlNKGpIdwsr
         HiiFRaoXCX3fc4m7sMthtziraezMXzCBITjAOxXXIFkP9Ax9QtUJRHYXQphzYANYvAXG
         c9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707253727; x=1707858527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgnL0Q5rTfFWXEVUOgZf2CAS8hpKNN7Sgg+AvUluPpQ=;
        b=knIJgOhbmAftXn8FnQDUdKPokUpZca+RZvlpcRyHFWq4kHmo1nUXBmdgAuBSKODu+D
         Od9l1/jHTQhR6V6mTI1GcB1cdXbc2VGV9Gr8avJj9g05PHjymAA3tyegI/Kvd6beWWYL
         EYPZAIrwlSWmdx2HuOCfSa6L+A80tmbUf962bHytzF3BAPzCnThrZWsBmDFfddK4R2hJ
         QJhEKQMLFpYqgSpLNGtE4SgtUd0NAJLLgMgAyQCWmi1Z7BFFwSv2Rs7wzS5jD+amKxNt
         02fkmJaUQHMjfpKSSFWYwk09SKAmhcawZNSd1qViep21u3OfHR1xVGnMjVeBYruFP/sz
         OsOA==
X-Gm-Message-State: AOJu0YyewU0KQJlRvip2RHyEDXGEijNJAZZQVPG2JA0taDNK6tXyp4sV
	1VLvTxlSPEI4jDJyPXOrkO3ZtqqiYtWfB+G/WSaS3AFXkCcrWP2V4vxDwCqzMqSRDXel/Lem/vv
	eqg==
X-Google-Smtp-Source: AGHT+IHsQBjp6ilaiBbfbQpKFm/RSNkoDuvhzxvLO3wHQwgXXBD5flGG40KhtkrgYZsgXjL9FlPKO9Xe/78=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:98f:b0:dc2:4d91:fb4b with SMTP id
 bv15-20020a056902098f00b00dc24d91fb4bmr725206ybb.9.1707253727335; Tue, 06 Feb
 2024 13:08:47 -0800 (PST)
Date: Tue, 6 Feb 2024 13:08:45 -0800
In-Reply-To: <ZcKKwSi7FdbSnexE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206032054.55070-1-likexu@tencent.com> <ZcKKwSi7FdbSnexE@google.com>
Message-ID: <ZcKf3RvyoVJ77sUQ@google.com>
Subject: Re: [PATCH v2] KVM: x86/intr: Explicitly check NMI from guest to
 eliminate false positives
From: Sean Christopherson <seanjc@google.com>
To: Like Xu <like.xu.linux@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andi Kleen <ak@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 06, 2024, Sean Christopherson wrote:
> +Oliver
> 
> On Wed, Dec 06, 2023, Like Xu wrote:
> > Note that when vm-exit is indeed triggered by PMI and before HANDLING_NMI
> > is cleared, it's also still possible that another PMI is generated on host.
> > Also for perf/core timer mode, the false positives are still possible since
> > that non-NMI sources of interrupts are not always being used by perf/core.
> > In both cases above, perf/core should correctly distinguish between real
> > RIP sources or even need to generate two samples, belonging to host and
> > guest separately, but that's perf/core's story for interested warriors.
> 
> Oliver has a patch[*] that he promised he would send "soon" (wink wink) to
> properly fix events that are configured to exclude the guest.  Unless someone
> objects, I'm going to tweak the last part of the changelog to be:
> 
>     Note that when VM-exit is indeed triggered by PMI and before HANDLING_NMI
>     is cleared, it's also still possible that another PMI is generated on host.
>     Also for perf/core timer mode, the false positives are still possible since
>     that non-NMI sources of interrupts are not always being used by perf/core.
>     
>     For events that are host-only, perf/core can and should eliminate false
>     positives by checking event->attr.exclude_guest, i.e. events that are
>     configured to exclude KVM guests should never fire in the guest.
>     
>     Events that are configured to count host and guest are trickier, perhaps
>     impossible to handle with 100% accuracy?  And regardless of what accuracy
>     is provided by perf/core, improving KVM's accuracy is cheap and easy, with
>     no real downsides.

Never mind, this causes KUT's pmu_pebs test to fail:

  FAIL: Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x1): Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x2): Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x4): Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x1f000008): Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: GP counter 0 (0xfffffffffffe): No OVF irq, none PEBS records.
  FAIL: Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x1): GP counter 0 (0xfffffffffffe): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x1): Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x2): GP counter 0 (0xfffffffffffe): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x2): Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x4): GP counter 0 (0xfffffffffffe): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x4): Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x1f000008): GP counter 0 (0xfffffffffffe): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x1f000008): Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x1): Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x2): Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x4): Multiple (0x700000055): No OVF irq, none PEBS records.
  FAIL: Adaptive (0x1f000008): Multiple (0x700000055): No OVF irq, none PEBS records.

It might be a test bug, but I have neither the time nor the inclination to
investigate.


Like,

If you want any chance of your patches going anywhere but my trash folder, you
need to change your upstream workflow to actually run tests.  I would give most
people the benefit of the doubt, e.g. assume they didn't have the requisite
hardware, or didn't realize which tests would be relevant/important.  But this
is a recurring problem, and you have been warned, multiple times.

