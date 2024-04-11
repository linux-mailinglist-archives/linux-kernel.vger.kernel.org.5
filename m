Return-Path: <linux-kernel+bounces-139794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B088A07CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296E91F22249
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B36B13C9C9;
	Thu, 11 Apr 2024 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJJR4NwN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9B0E57F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814117; cv=none; b=VuosBFjPwvuOwF3qIrZC1PtycTcnrGow24r4lHIDpiFDEOn9pPilRPfGASL/iiC4foZmjkMnv711LDg5iy1A7wEnXg4NLd6cVT0Ixkv79CTKLe7RPlKfiNDAnpS2dcJwqgcrkpgrl8NUeIBMfnQ5zS720990vlwbxRt99p7o3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814117; c=relaxed/simple;
	bh=UxjF62Kauzg32l2Xaebivdamax7t6IDMUPCds7LpphY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cO+lODqXwxYmVKuxH3xx1sZOVwc+KcVxt2dYdMWNkY2JGDmu5jyDP8vAwIxvMVF4V4t+GnHHRgEez2M2msTru3V61a2/iIEzG5KIFbeieXSjPGUQWG15enP6vPRP/oDN30G0Ka9UHivtGIbpEd5cm5BqUkY9HiITWLGm1HLWUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJJR4NwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C9BC433C7;
	Thu, 11 Apr 2024 05:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712814116;
	bh=UxjF62Kauzg32l2Xaebivdamax7t6IDMUPCds7LpphY=;
	h=From:To:Cc:Subject:Date:From;
	b=nJJR4NwNsSvhHf/p1YsY5oeQDmaEZGDBUJBWYueA/uxwtr4ar/PhrgaPmg8g6q4sl
	 5chDOH0UQyOsuAmXoQ5WkXI+mXSdYwnOWv50+FufB/nCcLMLrnT1uXUF+2qnMTGiz2
	 zS3Vxp+ZPaPmz403I61WUxkwd1ytUJEELo86CpceHONjPkuS8EBEXQHwqJEfVb0h91
	 pIbS3T/Y+IOdHOF10XAiAsP3h07jGjoZUR6y+mAuNMKaapWvq+aNpuM2bStTeXfDBP
	 w15CHu5/MqmofYTAL0B6z8NDEbvh4hH7vvDdNJKZwe6nbRlQr66PRS8mxNWrRRdViT
	 ImAgIR6UUDlIg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH 0/7] x86/bugs: BHI fixes / improvements
Date: Wed, 10 Apr 2024 22:40:44 -0700
Message-ID: <cover.1712813475.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An assortment of BHI fixes.

Josh Poimboeuf (7):
  x86/bugs: BHI documentation fixes
  x86/bugs: Cache the value of MSR_IA32_ARCH_CAPABILITIES
  x86/bugs: Fix BHI handling of RRSBA
  x86/bugs: Clarify that syscall hardening isn't a BHI mitigation
  x86/bugs: Only harden syscalls when needed
  x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto
  x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with
    CONFIG_MITIGATION_SPECTRE_BHI

 Documentation/admin-guide/hw-vuln/spectre.rst | 22 ++---
 .../admin-guide/kernel-parameters.txt         | 12 +--
 arch/x86/Kconfig                              | 22 +----
 arch/x86/entry/common.c                       | 30 +++++-
 arch/x86/entry/syscall_32.c                   | 11 +--
 arch/x86/entry/syscall_64.c                   |  8 +-
 arch/x86/entry/syscall_x32.c                  |  7 +-
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/syscall.h                |  8 +-
 arch/x86/kernel/cpu/bugs.c                    | 98 +++++++++++--------
 10 files changed, 119 insertions(+), 100 deletions(-)

-- 
2.44.0


