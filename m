Return-Path: <linux-kernel+bounces-27649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CFB82F3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57501C2387C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7C71CD28;
	Tue, 16 Jan 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXZnaAwB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380D1CD06;
	Tue, 16 Jan 2024 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428390; cv=none; b=QddI5T6vg/bja+kMceuDqRgKM63HP2Sid+hj1dTsizl/2YbGM6vdU+houYK/edQSIPJ7Yii1hsWwnSLPG+ZfusKG2F6wFCCuMhGtmD0YB8g+oF62SWYBDY3qMh3lwayQyAMVKyRi61OH4KvYvmvuI2OFo6XHMT4OuBZUjLriZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428390; c=relaxed/simple;
	bh=UX3kq6YtyE1PdEHxyUdmIdodg5pGEfTgztIGkSGO21A=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=pDX7CIWMXDZ9IGEeMEj05VS4tl2bJbKUP1694WY/sI7UOH07VZA3E9mJfaVNVzbKyOUiVjGsQfSKuaXHjPQAw2zKTl1GWY7y7MFedw11sVLnFzM1Zwk/J1fF9wKhlP8QqIdMAxv+Y0M6/A9y5WYxPIKUzhyHdnjR1sQv/gfMjO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXZnaAwB; arc=none smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705428388; x=1736964388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UX3kq6YtyE1PdEHxyUdmIdodg5pGEfTgztIGkSGO21A=;
  b=jXZnaAwBHadPGV65xNBZ/H8bwkiXw1xXcvHPPUpxVoID3vaaApwv3Eq2
   pc9eyluZ/hTR4JqZ2y5Pe7MTDWu/VeOqj0X++ZnGInMzeF/y20OwJmd+N
   ob3N9H7sjhgSU6qbvy8e/lqgR/dKKepqM2ZLbBmgWSprKykP2ZbJMyV38
   9raZsIp1mM+jKLqzpqO1JZen647YE7fgbJ0MImtix6c8OLUZg+YRAZcaa
   yvmwymF0s8UnHzyGrFOQCZQYx08qZRUnOzVyhMqPaTB55RyHm/LCbioCc
   HqLdOc1b4YvC22FYyLb+pFNMqzdHhcqTs4Pszn4scvPfawDfF1RtmdzwT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6650931"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="6650931"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 10:06:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="18552426"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jan 2024 10:06:23 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPnpM-00012m-2R;
	Tue, 16 Jan 2024 18:06:20 +0000
Date: Wed, 17 Jan 2024 02:05:40 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, kernel@pengutronix.de,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH 2/3] usb: gadget: legacy: add 9pfs multi gadget
Message-ID: <202401170130.QaAJQe4j-lkp@intel.com>
References: <20240116-ml-topic-u9p-v1-2-ad8c306f9a4e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-ml-topic-u9p-v1-2-ad8c306f9a4e@pengutronix.de>

Hi Michael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 052d534373b7ed33712a63d5e17b2b6cdbce84fd]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Grzeschik/usb-gadget-function-9pfs/20240116-095914
base:   052d534373b7ed33712a63d5e17b2b6cdbce84fd
patch link:    https://lore.kernel.org/r/20240116-ml-topic-u9p-v1-2-ad8c306f9a4e%40pengutronix.de
patch subject: [PATCH 2/3] usb: gadget: legacy: add 9pfs multi gadget
config: alpha-kismet-CONFIG_NET_9P-CONFIG_USB_9PFS-0-0 (https://download.01.org/0day-ci/archive/20240117/202401170130.QaAJQe4j-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240117/202401170130.QaAJQe4j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401170130.QaAJQe4j-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for NET_9P when selected by USB_9PFS
   
   WARNING: unmet direct dependencies detected for NET_9P
     Depends on [n]: NET [=n]
     Selected by [y]:
     - USB_F_9PFS [=y] && USB_SUPPORT [=y] && USB_GADGET [=y]
     - USB_9PFS [=y] && USB_SUPPORT [=y] && USB_GADGET [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

