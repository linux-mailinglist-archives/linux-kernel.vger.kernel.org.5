Return-Path: <linux-kernel+bounces-66942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D4C8563DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8511F264C5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D312130AEC;
	Thu, 15 Feb 2024 12:59:57 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E712FF82
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001997; cv=none; b=ZmCmpEGnC2yRyoX13h1w9vc17uirC1R7Qd8UxB3DuCe2KA+sTM5z46Pm4CmisWZ5HFPXGDzY4sH6bjRmuUtz3AR+K9YmID/sq2a/NamCaPxhU22M9OPppo6qKE9/LhkPb1ON4eD6sJeok0R2nkP6XE45Uxg9wASN496bhF3UYLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001997; c=relaxed/simple;
	bh=xQkOb6y1JCWfpEExQ5lqideXPPKtvO571JNEJZfo4Vs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bUNmTwAMPJtd2FSCAPFqHIkG/uSLBL6KdLFnr5OrBNBVJltOzyVJixgD4axeP65h556euXlN8V6Ow/INVfTlVxg860UlZ/cnUfROg0J2R5RRNbjQVMyKWaOGneAi7iW2CW5sX7Pf6KS7NHR4QaXTHbekehgZS8f5x8rRbM94UEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TbFX71m2Qz4x0n;
	Thu, 15 Feb 2024 23:59:51 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, jgg@ziepe.ca, jroedel@suse.de, tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com, gregkh@linuxfoundation.org, gbatra@linux.vnet.ibm.com, vaibhav@linux.ibm.com, venkat88@linux.vnet.ibm.com
In-Reply-To: <170784021983.6249.10039296655906636112.stgit@linux.ibm.com>
References: <170784021983.6249.10039296655906636112.stgit@linux.ibm.com>
Subject: Re: [PATCH] powerpc/iommu: Fix the missing iommu_group_put() during platform domain attach
Message-Id: <170800185788.599237.5797864611377163325.b4-ty@ellerman.id.au>
Date: Thu, 15 Feb 2024 23:57:37 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 10:05:22 -0600, Shivaprasad G Bhat wrote:
> The function spapr_tce_platform_iommu_attach_dev() is missing to call
> iommu_group_put() when the domain is already set. This refcount leak
> shows up with BUG_ON() during DLPAR remove operation as,
> 
>   KernelBug: Kernel bug in state 'None': kernel BUG at arch/powerpc/platforms/pseries/iommu.c:100!
>   Oops: Exception in kernel mode, sig: 5 [#1]
>   LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=8192 NUMA pSeries
>   <snip>
>   Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_016) hv:phyp pSeries
>   NIP:  c0000000000ff4d4 LR: c0000000000ff4cc CTR: 0000000000000000
>   REGS: c0000013aed5f840 TRAP: 0700   Tainted: G          I         (6.8.0-rc3-autotest-g99bd3cb0d12e)
>   MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44002402  XER: 20040000
>   CFAR: c000000000a0d170 IRQMASK: 0
>   GPR00: c0000000000ff4cc c0000013aed5fae0 c000000001512700 c0000013aa362138
>   GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000119c8afd0
>   GPR08: 0000000000000000 c000001284442b00 0000000000000001 0000000000001003
>   GPR12: 0000000300000000 c0000018ffff2f00 0000000000000000 0000000000000000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR24: c0000013aed5fc40 0000000000000002 0000000000000000 c000000002757d90
>   GPR28: c0000000000ff440 c000000002757cb8 c00000183799c1a0 c0000013aa362b00
>   NIP [c0000000000ff4d4] iommu_reconfig_notifier+0x94/0x200
>   LR [c0000000000ff4cc] iommu_reconfig_notifier+0x8c/0x200
>   Call Trace:
>   [c0000013aed5fae0] [c0000000000ff4cc] iommu_reconfig_notifier+0x8c/0x200 (unreliable)
>   [c0000013aed5fb10] [c0000000001a27b0] notifier_call_chain+0xb8/0x19c
>   [c0000013aed5fb70] [c0000000001a2a78] blocking_notifier_call_chain+0x64/0x98
>   [c0000013aed5fbb0] [c000000000c4a898] of_reconfig_notify+0x44/0xdc
>   [c0000013aed5fc20] [c000000000c4add4] of_detach_node+0x78/0xb0
>   [c0000013aed5fc70] [c0000000000f96a8] ofdt_write.part.0+0x86c/0xbb8
>   [c0000013aed5fce0] [c00000000069b4bc] proc_reg_write+0xf4/0x150
>   [c0000013aed5fd10] [c0000000005bfeb4] vfs_write+0xf8/0x488
>   [c0000013aed5fdc0] [c0000000005c0570] ksys_write+0x84/0x140
>   [c0000013aed5fe10] [c000000000033358] system_call_exception+0x138/0x330
>   [c0000013aed5fe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
>   --- interrupt: 3000 at 0x20000433acb4
>   <snip>
>   ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/iommu: Fix the missing iommu_group_put() during platform domain attach
      https://git.kernel.org/powerpc/c/0846dd77c8349ec92ca0079c9c71d130f34cb192

cheers

