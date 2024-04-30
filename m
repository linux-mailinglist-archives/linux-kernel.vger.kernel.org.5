Return-Path: <linux-kernel+bounces-164655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF048B80C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5F01F24080
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0D3199E9A;
	Tue, 30 Apr 2024 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PL/lPr2j"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F3199E80
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506667; cv=none; b=s4PXDiZtUO3jzIHnKT+wzHPy2pZ02ypM2iumjXH0tcDADnGiJZcet+90qq8s4uCVPsHBr5RGbsLdLIIjKG184l2wfmWzN4GysL/tl01Mkkm7jVHDjqQs8XhrNY2jTteqc0oZdnby8T5C60dEYJrb0g97dZMOZPlqiwvWJJ8MzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506667; c=relaxed/simple;
	bh=pZkNSqQimNQ+c8QfbZSIETCjRj3NWobbupgjMbXV758=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=huCwkh2/WXSpP3Qdp5ffqWXWT78FyiZG3bdNr/IygNfxBA2t39G9owuCUjoRG2thp+vC77SkZ/0xgIBKcRpwZBBitkjSdATC9HAUDw87zy1bO4Nbuu2nfzTsygreR9g4SdWIv+ee3uLqRzzFCWGAUWslGkYWk17EODmY1xEWljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PL/lPr2j; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso9316355276.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714506664; x=1715111464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bRW5S0ts0YJ1jBUFnS/VETT+cE0ujqNsSJB9yVriaWg=;
        b=PL/lPr2jLWSHcg+xeljNhz2y/TggnpaQ9U5qxpDv/k+bW7YLS/jdxk1G5e0UWbzW8X
         L/gCaPYZJvZQEG0i0PFlqARiQUvQGO4BExmQU61nhKwdVqXBisUARLVruhhI+ZkU4/nM
         dAfPh43w+BLGdgtXwjo8yvfFjK1vBl+y+V1deYFeUvQPoI8AHwTUpVoSvtKXHFCag8qa
         pq3nYVGymOo6tvU3855RJdQx3Pnw+jmO0IlBkxc1n28VIiWxbJUebVfclcS/WNv+iIac
         sflP/4nzmIeJOT+YmTa9CsuhmxtArRBILHXWbvKQE4Fd3cE0O6qLMlpIp3QQyAhT9PgT
         LpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714506664; x=1715111464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRW5S0ts0YJ1jBUFnS/VETT+cE0ujqNsSJB9yVriaWg=;
        b=veD35VfC5Nh317NOWGF0oos2kCDvWOUiAEDOYCC+SrrekUSgmJB1jTPjFf4obtBEOT
         TcS+QGo8g9P1UPKe+E7m1flsGHc1nuyD/XBxc67LNDOam1mIniFlCYyRr0o95DavdlLP
         CnFXqFE4kM1QIho+lR6bFrShHJhfjqe9QIBICpqj2EAinroPMXH8zFnvPTBdttIqHCJZ
         7CUkAieZvekB6nkzdcgz72uBtg4zpYvZhTTzTX/vDEsgfRFaTD2wj/2LsmC7skP7RzX1
         NYEdVoV8cHpMF5WP55bJ2lxRJIdZb9tStzK4lJ3BqXRFFng+TwF2WExk9f6MS3jeRxXE
         pWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdtNdoEo0f14wNr8k9UpviM4ccqN7ZSb7pGNpJSZph4X1bB+u4Ybm6nYwWfPmMWV16mWpjpvH6OGUyHD6NyOzOnrgTfpWfOlDJ9h4c
X-Gm-Message-State: AOJu0YwUrZV/eHEbhrk+4IFEOM8Zfo7O2pCGm9kFkSIQmaoM0dMhdCHg
	6LCFt3FzYR0DIARSsE9kBZoqRo8jVC2CB09Es+iOdjI88IRvq9/vt+dvJgcdq62TKr2EalE9dNs
	woQ==
X-Google-Smtp-Source: AGHT+IF4RivS1EjTDpEBzk4powVofAbI6FibOEO3YCH+mzhy8p2ZRX8re13LLSKcvM/uElHlANx+oqumZuY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c584:0:b0:dcc:6065:2b3d with SMTP id
 v126-20020a25c584000000b00dcc60652b3dmr138504ybe.8.1714506664545; Tue, 30 Apr
 2024 12:51:04 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:51:02 -0700
In-Reply-To: <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202404302233.f27f91b2-oliver.sang@intel.com> <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
 <ZjE7DkTBSbPlBN8k@google.com> <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
Message-ID: <ZjFLpkgI3Zl4dsXs@google.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a: WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Srikanth Aithal <sraithal@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 30, 2024, Borislav Petkov wrote:
> On Tue, Apr 30, 2024 at 11:40:14AM -0700, Sean Christopherson wrote:
> > Hmm, I don't think the problem is that init_ia32_feat_ctl() is called too late.
> > It too is called from the BSP prior to alternative_instructions():
> > 
> >   arch_cpu_finalize_init()
> >   |
> >   -> identify_boot_cpu()
> >      |
> >      -> identify_cpu()
> >         |
> >         -> .c_init() => init_intel()
> 
> Yeah, but look at the his stacktrace:
> 
> [ 0.055225][ T0] init_intel (arch/x86/include/asm/msr.h:146 arch/x86/include/asm/msr.h:300 arch/x86/kernel/cpu/intel.c:583
> +arch/x86/kernel/cpu/intel.c:687)
> [ 0.055225][ T0] identify_cpu (arch/x86/kernel/cpu/common.c:1824)
> [ 0.055225][ T0] identify_secondary_cpu (arch/x86/kernel/cpu/common.c:1949)
> [ 0.055225][ T0] smp_store_cpu_info (arch/x86/kernel/smpboot.c:333)
> 
> That's after alternatives.
>
> > Ah, and the WARN even specifically checks for the case where there's divergence
> > from the boot CPU:
> > 
> > 	if (boot_cpu_has(feature))
> > 		WARN_ON(alternatives_patched);
> 
> Funny you should mention that - I have this check in
> setup_force_cpu_cap() too which works on boot_cpu_data *BUT*, actually,
> the test in do_clear_cpu_cap() should be:
> 
>         if (c && cpu_has(c, feature))
>                 WARN_ON(alternatives_patched);
> 
> because setting a feature flag in *any* CPU's cap field is wrong after
> alternatives because as explained earlier.
> 
> I know, our feature flags handling is a major mess.

..

> my guess would be no and that init_ia32_feat_ctl() really needs to go
> before alternatives have been patched because it clears flags.

But that would just mask the underlying problem, it wouldn't actually fix anything
other than making the WARN go away.  Unless I'm misreading the splat+code, the
issue isn't that init_ia32_feat_ctl() clears VMX late, it's that the BSP sees
VMX as fully enabled, but at least one AP sees VMX as disabled.

I don't see how the kernel can expect to function correctly with divergent feature
support across CPUs, i.e. the WARN is a _good_ thing in this case, because it
alerts the user that their system is messed up, e.g. has a bad BIOS or something.

