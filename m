Return-Path: <linux-kernel+bounces-76037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B01585F238
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F43BB220B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E388179B0;
	Thu, 22 Feb 2024 07:57:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E4A179A1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588656; cv=none; b=RdKx83CuDAJADCPlGlfjgmSZx/zESWDDWvU0rWGiAMTEeeAJ2R/IlsxkVXTlzMGwDeDDxO7P/cnIJ4hz/IcWx0k1z2Uc8rpzwMeY1UEeK197LJ0FUCPetXn2Bx90ptdVenRRFx0CdaeJxyC1B7xntn5sUD1C+3VMT8KaV/2Z6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588656; c=relaxed/simple;
	bh=oMyefNR+7htdHsSwW8tVj52OaxrpLXOnt/v+n+gwScc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkEGYd/yJQm+JU8AoNDzMExSl0F123j8qGlLK3+zymG2txohcgudr327a7oYQuvKRu6gnOTGGUoWbxusNi/iseEQnjwQG3SGMMR71y8JqxYfG9o6J7gGtkUe9CZTnDJPPIj67uOOklWYHFxH6MY0y0/oLbyai9C88+c4wohavMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 851811007;
	Wed, 21 Feb 2024 23:58:12 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A0663F762;
	Wed, 21 Feb 2024 23:57:33 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	Andre Przywara <andre.przywara@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Peng Fan <peng.fan@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: fix double free in smc cleanup path
Date: Thu, 22 Feb 2024 07:57:27 +0000
Message-ID: <170858859374.106562.8183631887743483435.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240126122325.2039669-1-andre.przywara@arm.com>
References: <20240126122325.2039669-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 26 Jan 2024 12:23:25 +0000, Andre Przywara wrote:
> When the generic SCMI code tears down a channel, it calls the chan_free
> callback function, defined by each transport. Since multiple protocols
> might share the same transport_info member, chan_free() might want to
> clean up the same member multiple times. This will lead to a NULL
> pointer dereference at the second time:
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
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: fix double free in smc cleanup path
      https://git.kernel.org/sudeep.holla/c/f1d71576d2c9
--
Regards,
Sudeep


