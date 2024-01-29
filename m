Return-Path: <linux-kernel+bounces-43008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5150F840A33
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847FF1C21AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13117154440;
	Mon, 29 Jan 2024 15:37:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E66B154435
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542663; cv=none; b=uKc2xmBNMmRC7zL4i6tafTiOhpPLyKb3THiGxDCKNnbrOQu0lFZhEZ43mFdx4De8Z3wzbVLXQf51efyPAGNwsAieYUBNtB6prqXN+2Ej/JitSdP0H2wp9a5bgUzV7k3wrjam5tIHTMejmUvHwqr9+lRRihawO9r4FEnqkvv3CF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542663; c=relaxed/simple;
	bh=tZUsCsVrPLu0QLOsaw2WJYzK1MXIQo4uhNvNa+T90nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3jJRzFQS2khEsSeGplQ0xRpiQD51yyJGO7u7zB7HJXvsNVmMK1Ha4xrtipjduyNKWXU8KdLAZoIfboW+FlIDneC1r2HJXXi+5KAuS/ZzRrnzlLD8PAmgUIfCdc6du5l27EE6iBqI+VO8yCgwTfeBMG9Hox1BV9qtq2BUzkSms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69068DA7;
	Mon, 29 Jan 2024 07:38:23 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86BE23F738;
	Mon, 29 Jan 2024 07:37:38 -0800 (PST)
Date: Mon, 29 Jan 2024 15:37:36 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: fix double free in smc cleanup path
Message-ID: <ZbfGQC4gRuwc7yyN@pluto>
References: <20240126122325.2039669-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126122325.2039669-1-andre.przywara@arm.com>

On Fri, Jan 26, 2024 at 12:23:25PM +0000, Andre Przywara wrote:
> When the generic SCMI code tears down a channel, it calls the chan_free
> callback function, defined by each transport. Since multiple protocols
> might share the same transport_info member, chan_free() might want to
> clean up the same member multiple times. This will lead to a NULL
> pointer dereference at the second time:

Hi Andre,

thanks for this.

> 
> [    9.788824] scmi_protocol scmi_dev.1: Enabled polling mode TX channel - prot_id:16
> [    9.813091] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
> [    9.814485] arm-scmi firmware:scmi: unable to communicate with SCMI
> [    9.824996] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    9.825586] Mem abort info:
> [    9.825863]   ESR = 0x0000000096000004
> [    9.826193]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    9.827625]   SET = 0, FnV = 0
> [    9.827927]   EA = 0, S1PTW = 0
> [    9.828232]   FSC = 0x04: level 0 translation fault
> [    9.828628] Data abort info:
> [    9.828909]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    9.829333]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    9.829745]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    9.830170] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000881ef8000
> [    9.830887] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> [    9.831763] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    9.832177] Modules linked in:
> [    9.832440] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc2-00124-g455ef3d016c9-dirty #793
> [    9.832997] Hardware name: FVP Base RevC (DT)
> [    9.833302] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [    9.833775] pc : smc_chan_free+0x3c/0x6c
> [    9.834089] lr : smc_chan_free+0x3c/0x6c
> [    9.834401] sp : ffff8000839bba00
> [    9.834652] x29: ffff8000839bba00 x28: 00000000ffffffa1 x27: ffff0008024aa350
> [    9.835227] x26: ffff800083305898 x25: ffff0008004d4a18 x24: ffff000800328000
> [    9.835804] x23: ffff0008024aa1b0 x22: 0000000000000000 x21: 000000007fffffff
> [    9.836375] x20: 0000000000000000 x19: ffff000802639440 x18: 0000000000000010
> [    9.836945] x17: 73203e3d20293062 x16: 3161613432303830 x15: 303066666666202c
> [    9.837522] x14: 00000000000001f4 x13: ffff000800328488 x12: 00000000ffffffea
> [    9.838094] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffff800082f3b430
> [    9.838667] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 000000000005fff4
> [    9.839237] x5 : 00000000002bffa8 x4 : 0000000000000000 x3 : 0000000000000000
> [    9.839803] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000000000004a
> [    9.840368] Call trace:
> [    9.840571]  smc_chan_free+0x3c/0x6c
> [    9.840868]  idr_for_each+0x68/0xf8
> [    9.841164]  scmi_cleanup_channels.isra.0+0x2c/0x58
> [    9.841543]  scmi_probe+0x434/0x734
> [    9.841848]  platform_probe+0x68/0xd8
> [    9.842164]  really_probe+0x110/0x27c
> [    9.842464]  __driver_probe_device+0x78/0x12c
> [    9.842801]  driver_probe_device+0x3c/0x118
> [    9.843130]  __driver_attach+0x74/0x128
> [    9.843439]  bus_for_each_dev+0x78/0xe0
> [    9.843783]  driver_attach+0x24/0x30
> [    9.844121]  bus_add_driver+0xe4/0x1e8
> [    9.844466]  driver_register+0x60/0x128
> [    9.844778]  __platform_driver_register+0x28/0x34
> [    9.845149]  scmi_driver_init+0x84/0xc0
> [    9.845459]  do_one_initcall+0x78/0x33c
> [    9.845778]  kernel_init_freeable+0x2b8/0x51c
> [    9.846127]  kernel_init+0x24/0x130
> [    9.846426]  ret_from_fork+0x10/0x20
> [    9.846772] Code: f0004701 910a0021 aa1403e5 97b91c70 (b9400280)
> [    9.847172] ---[ end trace 0000000000000000 ]---
> [    9.847604] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> Simply check for the struct pointer being NULL before trying to access
> its members, to avoid this situation.
> This was found when a transport doesn't really work (for instance no SMC
> service), the probe routines then tries to clean up, and triggers a crash.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Fixes: 1dc6558062da ("firmware: arm_scmi: Add smc/hvc transport")

LGTM, maybe explicitly saying in the commit message that it is an issue
of the SMC transport would be better, but I think Sudeep can easily add
such a remark without the need to post a V2.

> ---
> Hi,
> 
> reportedly Cristian has some patches in the making that solve this
> problem in a more general way, but meanwhile this is an easy backport
> candidate.

Yes, this fix is definitely needed as it is, beside any possible future
improvement in the core.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

