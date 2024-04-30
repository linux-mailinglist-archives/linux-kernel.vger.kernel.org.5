Return-Path: <linux-kernel+bounces-164604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 870AB8B7FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432862821C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137F5194C9E;
	Tue, 30 Apr 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="3IszCfMW"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2FB23C9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502418; cv=none; b=EsFOB24V7nBxHi4A1UsuKCfwe8h/Ff1gp7Alt7dci/tYe2UBYOZ68Awhi8sMukKdgGRZUbQfreEuQv/WRi7JJIQOMEnhFtXaidtbztdU5ndR7cMb1P1XO95neormFyMgCL2N0tSsS/pDKiwpbVVG5bE+X0Vc5YPbXrTgRFS3bng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502418; c=relaxed/simple;
	bh=zwdY51+eyb+8RRA4oiPRHzVQ9fntHo3HpChfKzculaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W578uzNkiglZFjr0hSn07UevqBStAFEnvOXIVzOXoVDLaFi1O488VzqwRE/n2Nq2ogQ2dcpqQP2FSLKaNzdtqGEuD2ZtR29nBYqnZxSWMxnPuYZ4moGZxUUD/J9gkFwRlY7788YejO8M4vk0ugw6hW+YfjlDISV8cRihFsXTZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3IszCfMW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be621bd84so26067477b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714502416; x=1715107216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ran6BSBf09MzqnINtwYjR/epuBWKMosWFWWwnZMLsk=;
        b=3IszCfMWuHpfl2TCYFblHpopwI/6AzR2lNDbl7RBM0g0w4p3DvlcfXI+InQ4WXc8z6
         dSbh0qCbjS2zzbVaqDyiV5RBBxRzNKQxT4eHqW5j5XhHvvbAWF94kFaVqMKcKv9JINZ7
         PBIWkphMSReRa9KXkzKwZhf8tWakhxrWhYCfNYeMq3MzL1kTb9TJ6tmH71/A2sDYb23L
         z68OFpiUs8ynRStrG7bY2RhU0S0cpdIvazueBxh+A6b5bL5tJQb/2laubpxscRoKS34g
         pwaGAdhb2UjfJ/bEIL25bJLQcGJtTpWKr4pMnTTgQyBQuBMmAydSPjreD3RWIMJWiKON
         0e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714502416; x=1715107216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ran6BSBf09MzqnINtwYjR/epuBWKMosWFWWwnZMLsk=;
        b=LRJRiI5hSC/ZEw37ZUuaDc1SS1Xk5QRmjgKwF2L/U1/LIg0WghUqYlLYQW4lj1ipJ7
         oQSK27FMg6mImeGoj/9XBMQ3ypeqWsM1MRYoB8/veFzfmWxUXjtURHdME96Wlb1urfyn
         3tNq4Jo6uBBXWgXcOaMf7pf65k61TwktqrK68htZ8LEs25TVmrYmNTNtdNlhWA4MWD5F
         JaXgkTnwL1bRecCM6y7ktcURecVrRnQ07fWg9P6exSuNDBs2uLWP/dX/7Bqp/FParYPo
         95uGouF6aHjlFpT2MbAUo9OK8D6+O0r8tUpFvypsBSJKEweCAuPDegq8v70RBtYkaSyx
         2guQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZvI+X9E/VAgJ/dESLCKD9gxX32Ye7QNbylNxkQyaeawYgW69iMYsoBMBJg9vuxrPTqn5vWZiD8b/rrKfV+x0BrAzYJ/Ia94PE0Ehw
X-Gm-Message-State: AOJu0Yw5gudFZ0Fgxdr4HOj8cfxrhTh4FJzfYX9byrdHCcpFPOTV0bqz
	YVf9Z6KKB+lHYvicIK4tyRgVfGB/UZ3fBqTWW3Q9wpV7QXpqJCbrebRzdbn7LB8HopDXzKjq+Je
	DHA==
X-Google-Smtp-Source: AGHT+IHDMGb76IEBrmNmBvu2VXm6rEScC5BIxc3g7aclhYoQxKwJJCEpVgx6IU8zWjm4RsMseEcSuFoXKEM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:abd2:0:b0:de5:1ea2:fc75 with SMTP id
 v76-20020a25abd2000000b00de51ea2fc75mr42895ybi.7.1714502415792; Tue, 30 Apr
 2024 11:40:15 -0700 (PDT)
Date: Tue, 30 Apr 2024 11:40:14 -0700
In-Reply-To: <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202404302233.f27f91b2-oliver.sang@intel.com> <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
Message-ID: <ZjE7DkTBSbPlBN8k@google.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a: WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Srikanth Aithal <sraithal@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 30, 2024, Borislav Petkov wrote:
> + Sean.
> > [ 0.055225][ T0] ? __warn (kernel/panic.c:694) 
> > [ 0.055225][ T0] ? do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
> > [ 0.055225][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
> > [ 0.055225][ T0] ? handle_bug (arch/x86/kernel/traps.c:239 (discriminator 1)) 
> > [ 0.055225][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
> > [ 0.055225][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> > [ 0.055225][ T0] ? do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
> > [ 0.055225][ T0] ? __pfx_do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:109) 
> > [ 0.055225][ T0] init_ia32_feat_ctl (arch/x86/kernel/cpu/feat_ctl.c:181)
> 
> Yap, works as designed:

..

> won't work as expected because the patching has already happened.
> 
> And I'm not sure even the dynamic testing *cpu_has() does will always
> work as we do this dance in get_cpu_cap() with forced flags.
> 
> So, I'm thinking init_ia32_feat_ctl() should run in early_init_intel()
> which is before alternatives.
> 
> And looking at init_ia32_feat_ctl(), all it does is set and clear
> a bunch of bits so I think it should be ok.

Hmm, I don't think the problem is that init_ia32_feat_ctl() is called too late.
It too is called from the BSP prior to alternative_instructions():

  arch_cpu_finalize_init()
  |
  -> identify_boot_cpu()
     |
     -> identify_cpu()
        |
        -> .c_init() => init_intel()

Ah, and the WARN even specifically checks for the case where there's divergence
from the boot CPU:

	if (boot_cpu_has(feature))
		WARN_ON(alternatives_patched);

So I think this is a "real" warning about a misconfigured system, where VMX is
fully configured in MSR_IA32_FEAT_CTL on the boot CPU, but is disabled on a
secondary CPU.

FWIW, KVM will play nice with such a setup, as KVM specifically checks that VMX
is fully enabled all CPUs, but I would still consider this a misconfigured system.

> > [ 0.055225][ T0] init_intel (arch/x86/include/asm/msr.h:146 arch/x86/include/asm/msr.h:300 arch/x86/kernel/cpu/intel.c:583 arch/x86/kernel/cpu/intel.c:687) 
> > [ 0.055225][ T0] identify_cpu (arch/x86/kernel/cpu/common.c:1824) 
> > [ 0.055225][ T0] identify_secondary_cpu (arch/x86/kernel/cpu/common.c:1949) 
> > [ 0.055225][ T0] smp_store_cpu_info (arch/x86/kernel/smpboot.c:333) 
> > [ 0.055225][ T0] start_secondary (arch/x86/kernel/smpboot.c:197 arch/x86/kernel/smpboot.c:281) 
> > [ 0.055225][ T0] ? __pfx_start_secondary (arch/x86/kernel/smpboot.c:231) 
> > [ 0.055225][ T0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
> > [    0.055225][    T0]  </TASK>
> > [    0.055225][    T0] ---[ end trace 0000000000000000 ]---

