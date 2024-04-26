Return-Path: <linux-kernel+bounces-160319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF79B8B3BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0143B24729
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D828015253B;
	Fri, 26 Apr 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s09jxD+i"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893AA14A4D2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146138; cv=none; b=EzY0VG1zQW7gHKV1Mb9Z3CTE6Y1HtuxbDuJb3mxRZVLGmOGEwCdyWDXQAqG3TdjUhxuJyJOQ9+kJByWDyzjsH6UmYFiEzh1SLNVEydg/TxfwzvAT1zGZIm/armTVowO95Ioq3ByoBOjVOx2TVFOkSTNbUXBWiZhEwhHSN7/VvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146138; c=relaxed/simple;
	bh=5aUkPQKXl0fmcyKi1yp1q6NI4zqtUpvcJOtYnfEulME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f4wHD/aVbltXUrMcb62o2SUZwysdVJlX8rziDv95p5PG+f1nmvAFkiEBWvg5HP0zJh8EBh/E3pcDr5Oe0PH4uavxUZnBwCas/evVyMQrgkGh1+z/VtYh4Lfu6164GhTGeZfGBvTYqCQ91WAEjHb6eQzo3qp1bvhSA+8gGJfAOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s09jxD+i; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714146134;
	bh=5aUkPQKXl0fmcyKi1yp1q6NI4zqtUpvcJOtYnfEulME=;
	h=From:To:Cc:Subject:Date:From;
	b=s09jxD+i4byT7++j6mCHoGUuuv9IGR81RKhOaNaSljb0RPr5SzRf3yxQ2YLipQVov
	 slCoBsmaW2sA8t9RVchoBLzd39qWwz2Hv2koD+qL8lO0clBV2GJJ7TpYgGyNY1Kbrk
	 oe4YFQKnKdzymJ1EZOsHHSzrnFdurGTjRpIqXtv15OR/+u30ll8dOeameUYNogZDW+
	 c0L54ENVMFRvMqOdoE9Qp5y3fmaIt0bxbELFNi+JBAztvJ8CJ5bZDB+6t3NUb0LWfx
	 mruXSXDEBI0T7o7RA2nRyh5CB3u7Qn2/FUKI5zvT1NTrB71AbId1JrOfLKDTwSpgr3
	 KihDhaLbw821w==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 789473782157;
	Fri, 26 Apr 2024 15:42:14 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [REGRESSION] next boot regression caused by RIP:0010:acpi_find_gpio+0x4b/0x103 kernel panic
Date: Fri, 26 Apr 2024 17:42:08 +0200
Message-Id: <20240426154208.81894-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

KernelCI has identified a next boot regression on the following
Chromebooks, between next-20240416 and next-20240418:
- Lenovo ThinkPad C13 Yoga Chromebook (codename morphius) - kernel
  configuration used [1]
- ASUS Chromebook Flip C436FA (codename helios) - kernel configuration
  used [2]

The following kernel panic is reported in the logs:

[    5.136433] BUG: kernel NULL pointer dereference, address: 0000000000000218
[    5.143393] #PF: supervisor read access in kernel mode
[    5.148529] #PF: error_code(0x0000) - not-present page
[    5.153664] PGD 0 P4D 0 
[    5.156203] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[    5.161080] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc5-next-20240424 #1 a1639945aaee7370a5f0daa79d321d2bc0769584
[    5.172023] Hardware name: LENOVO Morphius/Morphius, BIOS Google_Morphius.13434.60.0 10/08/2020
[    5.180714] RIP: 0010:acpi_find_gpio+0x4b/0x103
[    5.185246] Code: 65 48 8b 04 25 28 00 00 00 48 89 44 24 38 31 c0 48 89 3c 24 e8 24 9a 04 00 48 8b 3c 24 48 8b 74 24 08 84 c0 74 04 48 8d 5f f0 <48> 8b 93 18 02 00 00 48 8d 83 18 02 00 00 31 c9 48 39 c2 75 10 48
[    5.203988] RSP: 0018:ffffa5a0c0033b98 EFLAGS: 00010246
[    5.209212] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffa5a0c0033c24
[    5.216341] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8a90c02a5420
[    5.223470] RBP: ffffa5a0c0033c24 R08: ffffa5a0c0033c28 R09: fffffffffffcc098
[    5.230599] R10: ffffffff96054f10 R11: fefefefefefefeff R12: ffff8a90c0ba6410
[    5.237728] R13: ffffa5a0c0033c28 R14: ffffffff95da5d86 R15: 0000000000000000
[    5.244857] FS:  0000000000000000(0000) GS:ffff8a90eae00000(0000) knlGS:0000000000000000
[    5.252940] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.258684] CR2: 0000000000000218 CR3: 00000000b2a2e000 CR4: 00000000003506f0
[    5.265813] Call Trace:
[    5.268262]  <TASK>
[    5.270367]  ? __die_body+0x1b/0x5d
[    5.273861]  ? page_fault_oops+0x340/0x3dc
[    5.277957]  ? prb_read_valid+0x14/0x1a
[    5.281794]  ? srso_return_thunk+0x5/0x5f
[    5.285806]  ? console_unlock+0x91/0xc0
[    5.289644]  ? exc_page_fault+0x1e2/0x502
[    5.293658]  ? asm_exc_page_fault+0x22/0x30
[    5.297846]  ? acpi_find_gpio+0x4b/0x103
[    5.301769]  ? acpi_find_gpio+0x3a/0x103
[    5.305694]  ? kvasprintf+0x77/0xba
[    5.309186]  gpiod_find_and_request+0xd5/0x395
[    5.313634]  devm_fwnode_gpiod_get_index+0x76/0xb1
[    5.318427]  gpio_keys_probe+0x43f/0x933
[    5.322353]  ? srso_return_thunk+0x5/0x5f
[    5.326365]  ? acpi_dev_pm_attach+0x96/0xb8
[    5.330551]  ? __device_attach_driver+0x93/0x93
[    5.335083]  platform_probe+0x3e/0x83
[    5.338748]  really_probe+0x111/0x261
[    5.342411]  __driver_probe_device+0xc5/0xf9
[    5.346683]  driver_probe_device+0x1e/0x77
[    5.350778]  __driver_attach+0xce/0xe7
[    5.354530]  bus_for_each_dev+0x7c/0xc2
[    5.358366]  ? kmalloc_trace_noprof+0x150/0x163
[    5.362897]  bus_add_driver+0xf4/0x1e6
[    5.366650]  driver_register+0xa6/0xe8
[    5.370401]  ? atkbd_init+0x26/0x26
[    5.373892]  do_one_initcall+0x80/0x1d9
[    5.377730]  kernel_init_freeable+0x1be/0x206
[    5.382088]  ? rest_init+0xbc/0xbc
[    5.385491]  kernel_init+0x16/0x119
[    5.388981]  ret_from_fork+0x24/0x38
[    5.392558]  ? rest_init+0xbc/0xbc
[    5.395961]  ret_from_fork_asm+0x11/0x20
[    5.399887]  </TASK>
[    5.402075] Modules linked in:
[    5.405133] CR2: 0000000000000218
[    5.408450] ---[ end trace 0000000000000000 ]---
[    5.413064] RIP: 0010:acpi_find_gpio+0x4b/0x103
[    5.417592] Code: 65 48 8b 04 25 28 00 00 00 48 89 44 24 38 31 c0 48 89 3c 24 e8 24 9a 04 00 48 8b 3c 24 48 8b 74 24 08 84 c0 74 04 48 8d 5f f0 <48> 8b 93 18 02 00 00 48 8d 83 18 02 00 00 31 c9 48 39 c2 75 10 48
[    5.436334] RSP: 0018:ffffa5a0c0033b98 EFLAGS: 00010246
[    5.441558] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffa5a0c0033c24
[    5.448687] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8a90c02a5420
[    5.455816] RBP: ffffa5a0c0033c24 R08: ffffa5a0c0033c28 R09: fffffffffffcc098
[    5.462945] R10: ffffffff96054f10 R11: fefefefefefefeff R12: ffff8a90c0ba6410
[    5.470074] R13: ffffa5a0c0033c28 R14: ffffffff95da5d86 R15: 0000000000000000
[    5.477203] FS:  0000000000000000(0000) GS:ffff8a90eae00000(0000) knlGS:0000000000000000
[    5.485286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.491026] CR2: 0000000000000218 CR3: 00000000b2a2e000 CR4: 00000000003506f0
[    5.498155] Kernel panic - not syncing: Fatal exception


The issue is still present on next-20240426.

Sending this report in order to track the regression while a fix is
identified.

Best,

Laura

[1] https://pastebin.com/raw/C8ZVg4s2 
[2] https://pastebin.com/raw/iej1hNWw

#regzbot introduced: next-20240416..next-20240418


