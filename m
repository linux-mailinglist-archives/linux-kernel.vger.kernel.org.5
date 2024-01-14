Return-Path: <linux-kernel+bounces-25515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D7A82D18E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 18:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14595281F55
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 17:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16855399;
	Sun, 14 Jan 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vgi2LRGB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B8E3C36;
	Sun, 14 Jan 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705251993; x=1736787993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kBypvo3nEuuDndZPzEooAarNiHapFV9jzwSKYnqP4Ss=;
  b=Vgi2LRGB1y72El36q9UJ7MXjaAG1tm7r83zy8MRfiPK9eocmFHKCZ96a
   V+c/vHksOWc9E4e9cC1qlZ98raftTBxahB/sBtzHX81wGj9HucHiGKGmw
   jo12A03ZKOWxifW5929s9A9aWHm2TuspsddowrgKEeE1G7GB6WPGlLayb
   eJbmEiz+u2QYJgYFqHMsfrLu1EfCjeO8MkCcPSIHYJmW7s2tGVvrg29Jy
   Y0PNGg4HqyR4tNGg6b/x3jxIdkYNCPyA6yiI772oToIPL+gw6y4BY6f+p
   0iyU6PrATxS2iKuA14tQvUv7svHGBRIJ5PMQ/qX3xGUtICrnAU7Aw3W0k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="18081194"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="18081194"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 09:06:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="783579560"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="783579560"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 09:06:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rP3pP-0000000Dy2n-46Gw;
	Sun, 14 Jan 2024 18:59:19 +0200
Date: Sun, 14 Jan 2024 18:59:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Ferry Toth <ftoth@exalondelft.nl>
Cc: gregkh@linuxfoundation.org, s.hauer@pengutronix.de,
	jonathanh@nvidia.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_linyyuan@quicinc.com,
	paul@crapouillou.net, quic_eserrao@quicinc.com,
	erosca@de.adit-jv.com
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
Message-ID: <ZaQS5x-XK08Jre6I@smile.fi.intel.com>
References: <20231006153808.9758-1-hgajjar@de.adit-jv.com>
 <20231006155646.12938-1-hgajjar@de.adit-jv.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006155646.12938-1-hgajjar@de.adit-jv.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Ferry.

On Fri, Oct 06, 2023 at 05:56:46PM +0200, Hardik Gajjar wrote:
> This patch replaces the usage of netif_stop_queue with netif_device_detach
> in the u_ether driver. The netif_device_detach function not only stops all
> tx queues by calling netif_tx_stop_all_queues but also marks the device as
> removed by clearing the __LINK_STATE_PRESENT bit.
> 
> This change helps notify user space about the disconnection of the device
> more effectively, compared to netif_stop_queue, which only stops a single
> transmit queue.

This change effectively broke my USB ether setup.

git bisect start
# status: waiting for both good and bad commits
# good: [1f24458a1071f006e3f7449c08ae0f12af493923] Merge tag 'tty-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good 1f24458a1071f006e3f7449c08ae0f12af493923
# status: waiting for bad commit, 1 good commit known
# bad: [2c40c1c6adab90ee4660caf03722b3a3ec67767b] Merge tag 'usb-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect bad 2c40c1c6adab90ee4660caf03722b3a3ec67767b
# bad: [17d6b82d2d6d467149874b883cdba844844b996d] usb/usbip: fix wrong data added to platform device
git bisect bad 17d6b82d2d6d467149874b883cdba844844b996d
# good: [ba6b83a910b6d8a9379bda55cbf06cb945473a96] usb: xhci-mtk: add a bandwidth budget table
git bisect good ba6b83a910b6d8a9379bda55cbf06cb945473a96
# good: [dddc00f255415b826190cfbaa5d6dbc87cd9ded1] Revert "usb: gadget: uvc: cleanup request when not in correct state"
git bisect good dddc00f255415b826190cfbaa5d6dbc87cd9ded1
# bad: [8f999ce60ea3d47886b042ef1f22bb184b6e9c59] USB: typec: tps6598x: Refactor tps6598x port registration
git bisect bad 8f999ce60ea3d47886b042ef1f22bb184b6e9c59
# bad: [f49449fbc21e7e9550a5203902d69c8ae7dfd918] usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach
git bisect bad f49449fbc21e7e9550a5203902d69c8ae7dfd918
# good: [97475763484245916735a1aa9a3310a01d46b008] USB: usbip: fix stub_dev hub disconnect
git bisect good 97475763484245916735a1aa9a3310a01d46b008
# good: [0f5aa1b01263b8b621bc4f031a1f2983ef8517b7] usb: usbtest: fix a type promotion bug
git bisect good 0f5aa1b01263b8b621bc4f031a1f2983ef8517b7
# first bad commit: [f49449fbc21e7e9550a5203902d69c8ae7dfd918] usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach

Note, revert indeed helps. Should I send a revert?

I use configfs to setup USB EEM function and it worked till this commit.
If needed, I can share my scripts, but I believe it's not needed as here
we see a clear regression.

-- 
With Best Regards,
Andy Shevchenko



