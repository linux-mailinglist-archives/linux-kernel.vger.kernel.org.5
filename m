Return-Path: <linux-kernel+bounces-105222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3073D87DAB0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90008B21EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858F41BC3C;
	Sat, 16 Mar 2024 16:12:20 +0000 (UTC)
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D761A702;
	Sat, 16 Mar 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.191.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710605540; cv=none; b=jfVS68nJ054l0EkbjmFrPokyaxv2nBdO00MHmEptcEAIMXD6VJfOBOiS3NmS6GVxg1znVdq7robl/hUZx+IWvHI3azHvY37Fj4ozB4XN6X6FZmwjM3TANb5XPzu+K5eDpUjGlLX+mTMsD5DHqrdqwIPoFuK5m6ivYcLMo1yToFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710605540; c=relaxed/simple;
	bh=g4nGgd5d+n4r1pkNGKScINQzMsotxC1M0q7NSeKpWag=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdJY14PhIyFC43Qu3Ewe0ogAnxU7sR5OldM08VkpW6rud74Rd3FzwnIiebcG5V651KBgwaZdeiF8UxARAw1Ukwjm/V0rBvx/slwYGI4oXLBwRRE6l3KrDXvjpIiDbmZ6jpRtovrHvXfwZT2CVn0SAmfYx29rxecZCQ1G6moxo4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=194.150.191.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id D3AFE8C23DA;
	Sat, 16 Mar 2024 17:12:15 +0100 (CET)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject:
 Re: [regression] 6.8.1: fails to hibernate with
 pm_runtime_force_suspend+0x0/0x120 returns -16
Date: Sat, 16 Mar 2024 17:12:15 +0100
Message-ID: <12401263.O9o76ZdvQC@lichtvoll.de>
In-Reply-To: <2325246.ElGaqSPkdT@lichtvoll.de>
References: <2325246.ElGaqSPkdT@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Martin Steigerwald - 16.03.24, 17:02:44 CET:
> ThinkPad T14 AMD Gen 1 fails to hibernate with self-compiled 6.8.1.
> Hibernation works correctly with self-compiled 6.7.9.

Apparently  6.8.1 does not even reboot correctly anymore. runit on Devuan.
It says it is doing the system reboot but then nothing happens.

As for hibernation the kernel cancels the attempt and returns back to
user space desktop session.

> Trying to use "no_console_suspend" to debug next. Will not do bisect
> between major kernel releases on a production machine.

Output with "no_console_suspend":

[   82.593360] r8169 0000:05:00.0 en1: Link is Down
[   83.196401] PM: hibernation: hibernation entry
[   83.671489] Filesystems sync: 0.121 seconds
[   83.671977] Freezing user space processes
[   83.674855] Freezing user space processes completed (elapsed 0.002 seconds)
[   83.674879] OOM killer disabled.
[   83.675111] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
[   83.675114] PM: hibernation: Marking nosave pages: [mem 0x0009f000-0x000fffff]
[   83.675117] PM: hibernation: Marking nosave pages: [mem 0x09c00000-0x09d00fff]
[   83.675122] PM: hibernation: Marking nosave pages: [mem 0x09f00000-0x09f0ffff]
[   83.675123] PM: hibernation: Marking nosave pages: [mem 0xa2357000-0xa2357fff]
[   83.675125] PM: hibernation: Marking nosave pages: [mem 0xa2364000-0xa2365fff]
[   83.675126] PM: hibernation: Marking nosave pages: [mem 0xa2373000-0xa2374fff]
[   83.675128] PM: hibernation: Marking nosave pages: [mem 0xa2385000-0xa2385fff]
[   83.675129] PM: hibernation: Marking nosave pages: [mem 0xb9532000-0xb95c2fff]
[   83.675132] PM: hibernation: Marking nosave pages: [mem 0xbd9de000-0xcc3fdfff]
[   83.675620] PM: hibernation: Marking nosave pages: [mem 0xce000000-0xffffffff]
[   83.676393] PM: hibernation: Basic memory bitmaps created
[   83.681188] PM: hibernation: Preallocating image memory
[   85.599072] PM: hibernation: Allocated 2043901 pages for snapshot
[   85.599105] PM: hibernation: Allocated 8175604 kbytes in 1.91 seconds (4280.42 MB/s)
[   85.599125] Freezing remaining freezable tasks
[   85.600726] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   85.611679] port 0000:02:00.1:0.0: PM: dpm_run_callback(): pm_runtime_force_suspend+0x0/0x120 returns -16
[   85.611709] port 0000:02:00.1:0.0: PM: failed to freeze: error -16
[   86.303477] PM: hibernation: Basic memory bitmaps freed
[   86.304003] OOM killer enabled.
[   86.304582] Restarting tasks ... done.
[   86.307452] thermal thermal_zone0: failed to read out thermal zone (-61)
[   86.307507] PM: hibernation: hibernation exit
[   86.331566] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY driver (mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
[   86.932558] r8169 0000:02:00.0 en0: rtl_ep_ocp_read_cond == 0 (loop: 30, delay: 10000).
[   87.004862] psmouse serio1: synaptics: queried max coordinates: x [..5678], y [..4694]
[   87.038125] r8169 0000:02:00.0 en0: Link is Down
[   87.043559] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
[   87.067568] Generic FE-GE Realtek PHY r8169-0-500:00: attached PHY driver (mii_bus:phy_addr=r8169-0-500:00, irq=MAC)
[   87.204101] r8169 0000:05:00.0 en1: Link is Down
[   90.639039] r8169 0000:05:00.0 en1: Link is Up - 1Gbps/Full - flow control rx/tx

Downgrading to 6.7.

Thanks.
-- 
Martin



