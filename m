Return-Path: <linux-kernel+bounces-26023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D18282DA0D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207CA1C218FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE916171B4;
	Mon, 15 Jan 2024 13:27:40 +0000 (UTC)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11388168D8;
	Mon, 15 Jan 2024 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id B9D945201E4;
	Mon, 15 Jan 2024 14:27:27 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Jan
 2024 14:27:27 +0100
Date: Mon, 15 Jan 2024 14:27:20 +0100
From: Hardik Gajjar <hgajjar@de.adit-jv.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Hardik Gajjar <hgajjar@de.adit-jv.com>, Ferry Toth <ftoth@exalondelft.nl>,
	<gregkh@linuxfoundation.org>, <s.hauer@pengutronix.de>,
	<jonathanh@nvidia.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <quic_linyyuan@quicinc.com>,
	<paul@crapouillou.net>, <quic_eserrao@quicinc.com>, <erosca@de.adit-jv.com>
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
Message-ID: <20240115132720.GA98840@vmlxhi-118.adit-jv.com>
References: <20231006153808.9758-1-hgajjar@de.adit-jv.com>
 <20231006155646.12938-1-hgajjar@de.adit-jv.com>
 <ZaQS5x-XK08Jre6I@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZaQS5x-XK08Jre6I@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

On Sun, Jan 14, 2024 at 06:59:19PM +0200, Andy Shevchenko wrote:
> +Cc: Ferry.
> 
> On Fri, Oct 06, 2023 at 05:56:46PM +0200, Hardik Gajjar wrote:
> > This patch replaces the usage of netif_stop_queue with netif_device_detach
> > in the u_ether driver. The netif_device_detach function not only stops all
> > tx queues by calling netif_tx_stop_all_queues but also marks the device as
> > removed by clearing the __LINK_STATE_PRESENT bit.
> > 
> > This change helps notify user space about the disconnection of the device
> > more effectively, compared to netif_stop_queue, which only stops a single
> > transmit queue.
> 
> This change effectively broke my USB ether setup.
> 
> git bisect start
> # status: waiting for both good and bad commits
> # good: [1f24458a1071f006e3f7449c08ae0f12af493923] Merge tag 'tty-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> git bisect good 1f24458a1071f006e3f7449c08ae0f12af493923
> # status: waiting for bad commit, 1 good commit known
> # bad: [2c40c1c6adab90ee4660caf03722b3a3ec67767b] Merge tag 'usb-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> git bisect bad 2c40c1c6adab90ee4660caf03722b3a3ec67767b
> # bad: [17d6b82d2d6d467149874b883cdba844844b996d] usb/usbip: fix wrong data added to platform device
> git bisect bad 17d6b82d2d6d467149874b883cdba844844b996d
> # good: [ba6b83a910b6d8a9379bda55cbf06cb945473a96] usb: xhci-mtk: add a bandwidth budget table
> git bisect good ba6b83a910b6d8a9379bda55cbf06cb945473a96
> # good: [dddc00f255415b826190cfbaa5d6dbc87cd9ded1] Revert "usb: gadget: uvc: cleanup request when not in correct state"
> git bisect good dddc00f255415b826190cfbaa5d6dbc87cd9ded1
> # bad: [8f999ce60ea3d47886b042ef1f22bb184b6e9c59] USB: typec: tps6598x: Refactor tps6598x port registration
> git bisect bad 8f999ce60ea3d47886b042ef1f22bb184b6e9c59
> # bad: [f49449fbc21e7e9550a5203902d69c8ae7dfd918] usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach
> git bisect bad f49449fbc21e7e9550a5203902d69c8ae7dfd918
> # good: [97475763484245916735a1aa9a3310a01d46b008] USB: usbip: fix stub_dev hub disconnect
> git bisect good 97475763484245916735a1aa9a3310a01d46b008
> # good: [0f5aa1b01263b8b621bc4f031a1f2983ef8517b7] usb: usbtest: fix a type promotion bug
> git bisect good 0f5aa1b01263b8b621bc4f031a1f2983ef8517b7
> # first bad commit: [f49449fbc21e7e9550a5203902d69c8ae7dfd918] usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach
> 
> Note, revert indeed helps. Should I send a revert?
> 
> I use configfs to setup USB EEM function and it worked till this commit.
> If needed, I can share my scripts, but I believe it's not needed as here
> we see a clear regression.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Without this patch, there may be a potential crash in a race condition, as __LINK_STATE_PRESENT is monitored at many places in the Network stack to determine the status of the link.

Could you please provide details on how this patch affects your functionality? Are you experiencing connection problems or data transfer interruptions?
Instead of reverting this patch, consider trying the upcoming patch (soon to be available in the mainline) to see if it resolves your issue.

https://lore.kernel.org/lkml/2023122900-commence-agenda-db2c@gregkh/T/#m36a812d3f1e5d744ee32381f6ae4185940b376de

Thanks,
Hardik

