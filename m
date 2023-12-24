Return-Path: <linux-kernel+bounces-10782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0133481DBC0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6DE1F2167A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B91CD507;
	Sun, 24 Dec 2023 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mrman314.tech header.i=@mrman314.tech header.b="isElspyB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.mrman314.tech (unknown [135.0.77.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEF7D2F1;
	Sun, 24 Dec 2023 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mrman314.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mrman314.tech
Received: from mail.mrman314.tech (localhost [127.0.0.1])
	by mx.mrman314.tech (Postfix) with ESMTPSA id 177872F406D0;
	Sun, 24 Dec 2023 13:04:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrman314.tech;
	s=default; t=1703441075;
	bh=R0Ct9LAMRoC93PP14kNc4aB4j0kJN4qE7SAVSIp+0no=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=isElspyBcHBK12K9W1c/zyGQSPfY4sZMH2Rrjb+1JEE7SIEeGSy3V9Ku5R/75T6vy
	 hElhmYBoRmVgGc8AV3gAIXEALU4MeXURiUNROuBWRCuaawPB6qyooycpvJI5cjgCDo
	 +usDtlj2PWPPlme8qtGmMXadjFBqRXMmZhztYxdw=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 24 Dec 2023 13:04:33 -0500
From: Felix Zhang <mrman@mrman314.tech>
To: Aditya Garg <gargaditya08@live.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com, Orlando Chamberlain
 <orlandoch.dev@gmail.com>, Kerem Karabay <kekrby@gmail.com>, Aun-Ali Zaidi
 <admin@kodeit.net>, Asahi Linux <asahi@lists.linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [REGRESSION] Bluetooth is not working on Macs with BCM4377 chip
 starting from kernel 6.5
In-Reply-To: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
References: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
Message-ID: <956280a5c2e931b13d784ec5fca38156@mrman314.tech>
X-Sender: mrman@mrman314.tech
Organization: MrMan
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2023-11-13 15:57, Aditya Garg wrote:
> Starting from kernel 6.5, a regression in the kernel is causing 
> Bluetooth to not work on T2 Macs with BCM4377 chip.
> 
> Journalctl of kernel 6.4.8 which has Bluetooth working is given here: 
> https://pastebin.com/u9U3kbFJ
> 
> Journalctl of kernel 6.5.2, which has Bluetooth broken is given here: 
> https://pastebin.com/aVHNFMRs
> 
> Also, the bug hasn’t been fixed even in 6.6.1, as reported by users.
> 
> Some relevant bits imo:
> 
>     • Sep 19 21:24:36 RudyUbuMbp kernel: hci_bcm4377 0000:73:00.1: 
> can't disable ASPM; OS doesn't have ASPM control
> 
>     • Nov 14 01:29:28 RudyUbuMbp kernel: Call Trace:
>     • Nov 14 01:29:28 RudyUbuMbp kernel: <TASK>
>     • Nov 14 01:29:28 RudyUbuMbp kernel: dump_stack_lvl+0x48/0x70
>     • Nov 14 01:29:28 RudyUbuMbp kernel: dump_stack+0x10/0x20
>     • Nov 14 01:29:28 RudyUbuMbp kernel: 
> __ubsan_handle_shift_out_of_bounds+0x156/0x310
>     • Nov 14 01:29:28 RudyUbuMbp kernel: ? ttwu_do_activate+0x80/0x290
>     • Nov 14 01:29:28 RudyUbuMbp kernel: ? raw_spin_rq_unlock+0x10/0x40
>     • Nov 14 01:29:28 RudyUbuMbp kernel: ? try_to_wake_up+0x292/0x6c0
>     • Nov 14 01:29:28 RudyUbuMbp kernel: ? sched_slice+0x76/0x140
>     • Nov 14 01:29:28 RudyUbuMbp kernel: ? reweight_entity+0x15c/0x170
>     • Nov 14 01:29:28 RudyUbuMbp kernel: __reg_op.cold+0x14/0x38
>     • Nov 14 01:29:28 RudyUbuMbp kernel: bitmap_release_region+0xe/0x20
>     • Nov 14 01:29:28 RudyUbuMbp kernel: bcm4377_handle_ack+0x8c/0x130 
> [hci_bcm4377]
>     • Nov 14 01:29:28 RudyUbuMbp kernel: 
> bcm4377_poll_completion_ring+0x196/0x330 [hci_bcm4377]
>     • Nov 14 01:29:28 RudyUbuMbp kernel: ? 
> rcu_gp_kthread_wake+0x57/0x90
>     • Nov 14 01:29:28 RudyUbuMbp kernel: bcm4377_irq+0x77/0x140 
> [hci_bcm4377]
>     • Nov 14 01:29:28 RudyUbuMbp kernel: 
> __handle_irq_event_percpu+0x4c/0x1b0
>     • Nov 14 01:29:28 RudyUbuMbp kernel: handle_irq_event+0x39/0x80
>     • Nov 14 01:29:28 RudyUbuMbp kernel: handle_edge_irq+0x8c/0x250
>     • Nov 14 01:29:28 RudyUbuMbp kernel: __common_interrupt+0x4f/0x110
>     • Nov 14 01:29:28 RudyUbuMbp kernel: common_interrupt+0x45/0xb0
>     • Nov 14 01:29:28 RudyUbuMbp kernel: asm_common_interrupt+0x27/0x40
>     • Nov 14 01:29:28 RudyUbuMbp kernel: RIP: 0033:0x7f17b5fd8bca

It seems that the BCM4377 chip stopped working on my MacBookAir9,1 (and 
possibly other T2 devices with the BCM4377) after the logic in the 
Bluetooth core was changed in this commit: 
https://github.com/torvalds/linux/commit/6945795bc81ab7be22750ecfb365056688f2fada

Due to the HCI_QUIRK_USE_BDADDR_PROPERTY being always set in 
drivers/bluetooth/hci_bcm4377.c, the chip would be left unconfigured, as 
per the commit mentioned prior.  On the M1 Macs, it seems that the 
device would be configured in the devicetree.  However, that is not the 
case on T2 Macs.  In order to circumvent this issue, a flag can be added 
to prevent the bit from being set on the BCM4377, while setting it on 
the other devices.  I have not submitted a patch yet, but you can view 
and use the patch with the latest kernel source here: 
https://github.com/MrMan314/linux-t2-patches/blob/main/9004-bcm4377-fix-bdaddr-property.patch

I would also like to thank kekrby (https://github.com/kekrby) for 
helping me with the patch.

