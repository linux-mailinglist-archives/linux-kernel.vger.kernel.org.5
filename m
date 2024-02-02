Return-Path: <linux-kernel+bounces-49646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE17846D6C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401C81C22817
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2883E79935;
	Fri,  2 Feb 2024 10:11:26 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197178689;
	Fri,  2 Feb 2024 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868685; cv=none; b=SHLx0maBA1qrvPYx9VrfP7pSrPLpoUY9frH/RoZzWRxYg+ab38LB7iZN2UxEUbJMPlNtNfiiNKBNx8CFFAS206LBOy/rpfPOZOseDMqEa8K2ffC3slZa8wruzekvFGCdWkRFLR6MmLzgOZ+7huSFZHpclNc0qvo3+fHVyCWm72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868685; c=relaxed/simple;
	bh=C/3ZcqmxK31dP2orHhEIRzBdnVfPyYJkouCJKQL1S5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiiDtQIYicZwknTOaYxsp99L/xurmLoi45pbBQakaYAa1CNCRuhNs8j846kewIKLtQyk/QNsS1OqLxgh/WvnFNdvh1S7aeTitBjQnZQBP9GwhFGnKLaJXZtQBKBkIMAj+WqJ6gXX5SyRtfFrPqgg+xNpAg0cZv/EAVGA8CxFHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rVqVx-0092t5-TY; Fri, 02 Feb 2024 18:11:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Feb 2024 18:11:31 +0800
Date: Fri, 2 Feb 2024 18:11:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kim Phillips <kim.phillips@amd.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] crypto: ccp - Fix null pointer dereference in
 __sev_platform_shutdown_locked
Message-ID: <Zby/08lqfWYoz7Ws@gondor.apana.org.au>
References: <20240125231253.3122579-1-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125231253.3122579-1-kim.phillips@amd.com>

On Thu, Jan 25, 2024 at 05:12:53PM -0600, Kim Phillips wrote:
> The SEV platform device can be shutdown with a null psp_master,
> e.g., using DEBUG_TEST_DRIVER_REMOVE.  Found using KASAN:
> 
> [  137.148210] ccp 0000:23:00.1: enabling device (0000 -> 0002)
> [  137.162647] ccp 0000:23:00.1: no command queues available
> [  137.170598] ccp 0000:23:00.1: sev enabled
> [  137.174645] ccp 0000:23:00.1: psp enabled
> [  137.178890] general protection fault, probably for non-canonical address 0xdffffc000000001e: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN NOPTI
> [  137.182693] KASAN: null-ptr-deref in range [0x00000000000000f0-0x00000000000000f7]
> [  137.182693] CPU: 93 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc1+ #311
> [  137.182693] RIP: 0010:__sev_platform_shutdown_locked+0x51/0x180
> [  137.182693] Code: 08 80 3c 08 00 0f 85 0e 01 00 00 48 8b 1d 67 b6 01 08 48 b8 00 00 00 00 00 fc ff df 48 8d bb f0 00 00 00 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f 85 fe 00 00 00 48 8b 9b f0 00 00 00 48 85 db 74 2c
> [  137.182693] RSP: 0018:ffffc900000cf9b0 EFLAGS: 00010216
> [  137.182693] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 000000000000001e
> [  137.182693] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00000000000000f0
> [  137.182693] RBP: ffffc900000cf9c8 R08: 0000000000000000 R09: fffffbfff58f5a66
> [  137.182693] R10: ffffc900000cf9c8 R11: ffffffffac7ad32f R12: ffff8881e5052c28
> [  137.182693] R13: ffff8881e5052c28 R14: ffff8881758e43e8 R15: ffffffffac64abf8
> [  137.182693] FS:  0000000000000000(0000) GS:ffff889de7000000(0000) knlGS:0000000000000000
> [  137.182693] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  137.182693] CR2: 0000000000000000 CR3: 0000001cf7c7e000 CR4: 0000000000350ef0
> [  137.182693] Call Trace:
> [  137.182693]  <TASK>
> [  137.182693]  ? show_regs+0x6c/0x80
> [  137.182693]  ? __die_body+0x24/0x70
> [  137.182693]  ? die_addr+0x4b/0x80
> [  137.182693]  ? exc_general_protection+0x126/0x230
> [  137.182693]  ? asm_exc_general_protection+0x2b/0x30
> [  137.182693]  ? __sev_platform_shutdown_locked+0x51/0x180
> [  137.182693]  sev_firmware_shutdown.isra.0+0x1e/0x80
> [  137.182693]  sev_dev_destroy+0x49/0x100
> [  137.182693]  psp_dev_destroy+0x47/0xb0
> [  137.182693]  sp_destroy+0xbb/0x240
> [  137.182693]  sp_pci_remove+0x45/0x60
> [  137.182693]  pci_device_remove+0xaa/0x1d0
> [  137.182693]  device_remove+0xc7/0x170
> [  137.182693]  really_probe+0x374/0xbe0
> [  137.182693]  ? srso_return_thunk+0x5/0x5f
> [  137.182693]  __driver_probe_device+0x199/0x460
> [  137.182693]  driver_probe_device+0x4e/0xd0
> [  137.182693]  __driver_attach+0x191/0x3d0
> [  137.182693]  ? __pfx___driver_attach+0x10/0x10
> [  137.182693]  bus_for_each_dev+0x100/0x190
> [  137.182693]  ? __pfx_bus_for_each_dev+0x10/0x10
> [  137.182693]  ? __kasan_check_read+0x15/0x20
> [  137.182693]  ? srso_return_thunk+0x5/0x5f
> [  137.182693]  ? _raw_spin_unlock+0x27/0x50
> [  137.182693]  driver_attach+0x41/0x60
> [  137.182693]  bus_add_driver+0x2a8/0x580
> [  137.182693]  driver_register+0x141/0x480
> [  137.182693]  __pci_register_driver+0x1d6/0x2a0
> [  137.182693]  ? srso_return_thunk+0x5/0x5f
> [  137.182693]  ? esrt_sysfs_init+0x1cd/0x5d0
> [  137.182693]  ? __pfx_sp_mod_init+0x10/0x10
> [  137.182693]  sp_pci_init+0x22/0x30
> [  137.182693]  sp_mod_init+0x14/0x30
> [  137.182693]  ? __pfx_sp_mod_init+0x10/0x10
> [  137.182693]  do_one_initcall+0xd1/0x470
> [  137.182693]  ? __pfx_do_one_initcall+0x10/0x10
> [  137.182693]  ? parameq+0x80/0xf0
> [  137.182693]  ? srso_return_thunk+0x5/0x5f
> [  137.182693]  ? __kmalloc+0x3b0/0x4e0
> [  137.182693]  ? kernel_init_freeable+0x92d/0x1050
> [  137.182693]  ? kasan_populate_vmalloc_pte+0x171/0x190
> [  137.182693]  ? srso_return_thunk+0x5/0x5f
> [  137.182693]  kernel_init_freeable+0xa64/0x1050
> [  137.182693]  ? __pfx_kernel_init+0x10/0x10
> [  137.182693]  kernel_init+0x24/0x160
> [  137.182693]  ? __switch_to_asm+0x3e/0x70
> [  137.182693]  ret_from_fork+0x40/0x80
> [  137.182693]  ? __pfx_kernel_init+0x10/0x10
> [  137.182693]  ret_from_fork_asm+0x1b/0x30
> [  137.182693]  </TASK>
> [  137.182693] Modules linked in:
> [  137.538483] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 1b05ece0c9315 ("crypto: ccp - During shutdown, check SEV data pointer before using")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
>  drivers/crypto/ccp/sev-dev.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

