Return-Path: <linux-kernel+bounces-152051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1C28AB805
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B564CB21067
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5B6A20;
	Sat, 20 Apr 2024 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5cjYStS"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A238C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713571563; cv=none; b=j/J6xPiUfQQZqTTxjXfutT47jRHl6mLhR3YH2kwpgXqolxibqJ8lAakFfVn+0ZO0uJdSJVx7TgOvIW29eG3jPeITTVggRtrMYniM6pF+OjmtMpdwOmdcfIbJRGS8Jfcxyh1IkvmFru0D0JnoeTkl+a9khuhRj11IRbH7G4mAUzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713571563; c=relaxed/simple;
	bh=wVJWitwP36/dCcnEpGZQhd0zcrqkVaMjQgPhoSbNptU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WV3HkdehxZR17BTTrKdC/oDwIVo7dj1d86kOsr99a8JBrMtsgdVFKoXnGdFHzB8XlCB0V3fOUM6QR7p4PzhHlQ/SPaaHjOmPjMn658cvQY8kX/+xxrfP/YUUXXFMQIKj+H0L+lCkU9Vh8n4SPrQyHty/PAZVmAQeaG13k/e0BQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5cjYStS; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cec090b2bdso2661152a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713571561; x=1714176361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRsj/jpn4TVxhWDg9DHeSLK4ijgkPxuI5zxP54h8ix0=;
        b=U5cjYStSUjjmzjZ8W704GRAVuD0hsR78945D0agBIJKvkfZ4/AyCrIdCCe3NFV5mn/
         MCTSrvg0jBNb4sTGno+8lqmkZFzsQgwFiWuDDBeWT5+dmH5DseBlv6NLRxc0u86WvyO7
         IN1HJoehs83SJyuO7usTkVnxHfmwsBw2JzkBbVOJVZo53G6JVzZxjGAe8FPK44i+EJP/
         rlsjJxGvlBYKgxr4opJqmxSjJOupvAoz7SQbla9EmvgZAgQGMlIX93hEPtQA6/9ySoC9
         Rngr5NeKZLH7iQ0T+vtn84bBVNdPa5bVv4ViigvztOzy43OYgB0dOw3aYPFNRErwjWmp
         AlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713571561; x=1714176361;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRsj/jpn4TVxhWDg9DHeSLK4ijgkPxuI5zxP54h8ix0=;
        b=TvkE2Wx2mXPQqe2PXyuAlQi/Pn4QEB0RDmHlKSSTqC94CgDFNf9qvHnfzS1Gs//dka
         YkW/WE05E9RzNzdNRKAeXihPegC158D5RSCTKBClDdFAR3y8aXx3RV08laY7nyz1NXb1
         dpEZvv4H1J4OD4GxD2BPtseHjE9P6CljYufOtzwnFJa/81IFrzeeZmtLGrTwTgNI9VPV
         cLZAEVynOTnZGF/g/SGwq7XfXe2Lad6DKdIJZslVp7D2r23876wBs41u9zgl/7tXWL7l
         3vSOCugI4KLsJ1wNBYmdHmUrN+5qtcYR/NE5yvJIVk0NqGltMnHZVn5EDLS0B51ayjvw
         90Lw==
X-Gm-Message-State: AOJu0Yw93J/9Mkob9gv8wZkScc177NljlMSMJKPfOlpbhfX4flfLptH5
	hXMmSYQo/ycksO7DyJ2bC8z2Vni1MzmHlCFxqEdoL3pYpcAOhBPa+huctORqH5ugpGI6KRLQNwR
	7ZQ==
X-Google-Smtp-Source: AGHT+IHYZS+bhScmMklMn6Th2vDPjoVCMLKyG3MC/+DP9z635juHWEc4kUB6wLQLwjmaG2I6hsRe00v3EWk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3681:0:b0:5cd:9ea4:c99 with SMTP id
 d123-20020a633681000000b005cd9ea40c99mr10113pga.6.1713571561320; Fri, 19 Apr
 2024 17:06:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Apr 2024 17:05:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240420000556.2645001-1-seanjc@google.com>
Subject: [PATCH v2 0/2] cpu: Fix default mitigation behavior
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Will Deacon <will@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Linus, I Cc'd you on this as patch 1 fixes a goof that causes mitigations
to be completely disabled on all !x86 architectures, and it'd be nice to
fix that in rc5.  There was a decent bit of discussion on how exactly to
juggle the Kconfigs, and so I don't expect anyone to include this in a pull
request for rc5.

The discussion didn't fully resolve, i.e. this hasn't gotten a thumbs up
from the affected parties, but I think/hope my approach here is minimal
enough for other architectures (just restores previous behavior), and
shouldn't result in a huge amount of churn if we decide to go in a
different direction.

TL;DR: please grab patch 1 directly if you think it's worth squeezing into
rc5, and isn't completely crazy.

Thanks!


Patch 2 is probably 6.9 material, but is definitely not rc5 material.  It
disallows retroactively enabling mitigations via command line if the kernel
was built with CPU_MITIGATIONS=n, as it's infeasible for x86 to provide
sane, predictable behavior for this scenario.

v2:
 - Rework the Kconfigs so that there's a single user-visible CPU_MITIGATION
   config. [Everyone]
 - Define CPU_MITIGATIONS in arch/Kconfig. [Josh]
 - Completely compile out the cpu_mitigations code if CPU_MITIGATIONS=n,
   e.g. to make impossible to end up in a half-baked state where
   cpu_mitigations ends up enabled but the kernel wasn't compiled with
   mitigations enabled.

v1: https://lore.kernel.org/all/20240417001507.2264512-1-seanjc@google.com

Sean Christopherson (2):
  cpu: Re-enable CPU mitigations by default for !X86 architectures
  cpu: Ignore "mitigations" kernel parameter if CPU_MITIGATIONS=n

 .../admin-guide/kernel-parameters.txt         |  3 +++
 arch/Kconfig                                  |  8 ++++++++
 arch/x86/Kconfig                              | 19 ++++++++++++-------
 include/linux/cpu.h                           | 11 +++++++++++
 kernel/cpu.c                                  | 13 ++++++++++---
 5 files changed, 44 insertions(+), 10 deletions(-)


base-commit: 96fca68c4fbf77a8185eb10f7557e23352732ea2
-- 
2.44.0.769.g3c40516874-goog


