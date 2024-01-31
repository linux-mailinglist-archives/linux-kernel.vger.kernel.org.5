Return-Path: <linux-kernel+bounces-45737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4088434C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F8EB232E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1E120DEA;
	Wed, 31 Jan 2024 04:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr8lAtri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7185020DE2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706674834; cv=none; b=hVyhHxOnB0/psaPEA8emWkdHZ+gSOeysfhgSqWo33zEkxYWLb42yXjRebMDF/9nLsXoSfXbnBi/W9YwV87Gw3TyHhtP6gn8NRLpqfdJtw7UA8HG6pDsj/VQQleOI7V1RMVHvCumdMYDl2NSIF8IF2ZD/ACCVOBazbZSH0QVFUk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706674834; c=relaxed/simple;
	bh=3z6NePDi6VjROHSEUmUP6m+ClXwaQp2Wc75yKLYaC4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/nXh93Z8CNME2czn6IrtzE3YGodNcY/2mCATFYQBcvyE/3iCkXKyVNbIonAFwYxEsl5iXSkX7ZYvIkOqfoCksAOjtzddzPKeP1SDtQtaE0z2vC9fg2vRTgHra2xZrbSBRF4wgVLcFwlOIhnFIDYp7ovIY15T68ZVyWORMXVtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr8lAtri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74537C433F1;
	Wed, 31 Jan 2024 04:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706674833;
	bh=3z6NePDi6VjROHSEUmUP6m+ClXwaQp2Wc75yKLYaC4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jr8lAtriyfOjjmYfwZCFCBe6QQDrdPYiP3W8zzl+V1bBUL6nhEAXlbFmC3PmX3Wez
	 Lscu0T2RSCzo9QUMt3cDTyvyleV/QuSurhPS+YBvJezROVCqOy5zVdj49Q2zD0DZrB
	 lDXLAsgI9VUceVbxGsIYqLJFeZZmvIutN4iEpBaSEynbR5Pnr664p2AjvPwOzGubCy
	 nB3XNSPbH8KZuV0Cb9fpfS3Zg5FcR6DHgfSILpv6jcIqX+HKjNXGDH3BA8EamXRQw1
	 CCP8pdpM+sPdW2WdUD28cWB377Xk41thsIPcoliJQEQC/vW0yAPUJsiiuPe0reXtEI
	 ZYVvsBtGlqMBw==
Date: Tue, 30 Jan 2024 21:20:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 09/10] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
Message-ID: <20240131042031.GA3946229@dev-arch.thelio-3990X>
References: <20240125170628.2017784-1-tj@kernel.org>
 <20240125170628.2017784-10-tj@kernel.org>
 <CAJhGHyAuoGNmaaDa0p+wiJMprXYVYnVV75PS4+kPy-fsPJVH8w@mail.gmail.com>
 <ZbfrEx9nnkr0FnZE@slm.duckdns.org>
 <CGME20240130223021eucas1p1172b060d53847b8b77f6455d6257528e@eucas1p1.samsung.com>
 <91eacde0-df99-4d5c-a980-91046f66e612@samsung.com>
 <ZbnGbC8YM0rcI8Jm@slm.duckdns.org>
 <20240131041205.GA3517117@dev-arch.thelio-3990X>
 <ZbnIzqmClhAvPxKC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbnIzqmClhAvPxKC@slm.duckdns.org>

On Tue, Jan 30, 2024 at 06:13:02PM -1000, Tejun Heo wrote:
> On Tue, Jan 30, 2024 at 09:12:05PM -0700, Nathan Chancellor wrote:
> > Hi Tejun,
> > 
> > On Tue, Jan 30, 2024 at 06:02:52PM -1000, Tejun Heo wrote:
> > > Hello,
> > > 
> > > Thanks for the report. Can you please test whether the following patch fixes
> > > the problem?
> > 
> > I just tested this change on top of 5797b1c18919 but it does not appear
> > to resolve the issue for any of the three configurations that I tested.
> 
> Bummer. Can you map the faulting address to the source line?

Sure, here is the arm64 stacktrace run through
scripts/decode_stacktrace.sh, the line numbers correspond to your tree
at 5797b1c18919.

[    0.000000] Unable to handle kernel paging request at virtual address ffff000021c0b380
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x0000000096000006
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000]   FSC = 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[    0.000000]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.000000]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000413b1000
[    0.000000] [ffff000021c0b380] pgd=180000005fff7003, p4d=180000005fff7003, pud=180000005fff6003, pmd=0000000000000000
[    0.000000] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.0-09946-g5797b1c18919 #1
[    0.000000] Hardware name: linux,dummy-virt (DT)
[    0.000000] pstate: 600000c9 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : wq_update_node_max_active (include/asm-generic/bitops/generic-non-atomic.h:128 include/linux/cpumask.h:504 kernel/workqueue.c:1513)
[    0.000000] lr : apply_wqattrs_commit (kernel/workqueue.c:4838)
[    0.000000] sp : ffff8000814b3be0
[    0.000000] x29: ffff8000814b3be0 x28: ffff000001c0d600 x27: 0000000000000000
[    0.000000] x26: ffff000001c0d6c0 x25: 0000000000000001 x24: 0000000000000200
[    0.000000] x23: 00000000ffffffff x22: ffff8000814b9c40 x21: 0000000000000008
[    0.000000] x20: ffff8000814b9a40 x19: ffff000001c0b360 x18: ffff00001feebed0
[    0.000000] x17: 0000000000c65c70 x16: ffff00001feebb28 x15: fffffc0000070488
[    0.000000] x14: 0000000000000000 x13: 0000000000000000 x12: ffff00001feebb28
[    0.000000] x11: 0000000000000001 x10: ffff000001c0b388 x9 : 0000000000000000
[    0.000000] x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffff000001c0d600
[    0.000000] x5 : ffff000001c0d600 x4 : ffff000001c0e880 x3 : ffff000001c0d600
[    0.000000] x2 : ffff000001c0b388 x1 : ffff8000814b9000 x0 : 0000000003ffffff
[    0.000000] Call trace:
[    0.000000] wq_update_node_max_active (include/asm-generic/bitops/generic-non-atomic.h:128 include/linux/cpumask.h:504 kernel/workqueue.c:1513)
[    0.000000] apply_wqattrs_commit (kernel/workqueue.c:4838)
[    0.000000] apply_workqueue_attrs_locked (kernel/workqueue.c:4745 kernel/workqueue.c:4864)
[    0.000000] alloc_workqueue (kernel/workqueue.c:4894 kernel/workqueue.c:5015 kernel/workqueue.c:5224)
[    0.000000] workqueue_init_early (kernel/workqueue.c:7210)
[    0.000000] start_kernel (init/main.c:965)
[    0.000000] __primary_switched (arch/arm64/kernel/head.S:524)
[ 0.000000] Code: f9418033 d000a081 9100a262 f90037e2 (f8607840)
All code
========
   0:*  33 80 41 f9 81 a0       xor    -0x5f7e06bf(%rax),%eax           <-- trapping instruction
   6:   00 d0                   add    %dl,%al
   8:   62 a2 00 91 e2          (bad)
   d:   37                      (bad)
   e:   00 f9                   add    %bh,%cl
  10:   40 78 60                rex js 0x73
  13:   f8                      clc

Code starting with the faulting instruction
===========================================
   0:   40 78 60                rex js 0x63
   3:   f8                      clc
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Cheers,
Nathan

