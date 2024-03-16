Return-Path: <linux-kernel+bounces-105115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297DE87D94B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73B71F217B2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41480107A9;
	Sat, 16 Mar 2024 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHExjDpr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775779D3;
	Sat, 16 Mar 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710577128; cv=none; b=G+s3+UudRyI4R487440yahd3oas2ImMn1w0J7m9GsaP7vnbIM1IrxbN8REBxn5jb2P29ob24RzrJCd3iWpqitau2E1VFWPyOrfKgCBCdiSJ4Dpsh8hvkg82+8gXd+KFz6HU9poxaKilP0M0zCJx5UpJB3hhUmToY1oJxU+VhlFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710577128; c=relaxed/simple;
	bh=/hUGS7eGBHwHUjRTTCc9HBhUNnTz3azKk/JJkJ0hSto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J20sCL3z97EfJyM1OoI7vkAz/PD3CECKUwBEbP7BG0P/Q3mD07d8B/4pytGf0IcUBGe/E9KCZ1J1NlU8j641dpbz7h3P13PkhT9ZH1d1grkZpYvJVQIIYnxAWHUZdBGrrg8PN6a0OwO4yGn4R/yasYvvrGkOUMNcx4xMZUX0RGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHExjDpr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710577127; x=1742113127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/hUGS7eGBHwHUjRTTCc9HBhUNnTz3azKk/JJkJ0hSto=;
  b=YHExjDprQekLfeR/+rpHpPU9UbSXlhVLx8aYJHL4TneVXuY1uHz5m9j+
   SavNmEw8FKGZqUHkNklAe8wleZLo2OSaUiIwpoUz5uioPVL5jYtjWQyA4
   /HQTrpEo+xcyLOJNaiozOYB/16X0kZK3mU5ICGbeMnJ8QFNoP6Q3fyD8M
   zBRSHIc5YyC4H60KICuqTlxVRqd/uWbXMaoxW9j233qTr4yvzY8CpBx12
   wHPD1FmiGsB4ZseuOfnmrR7m7wVIzbEkA5qJNFd7ASwc8LbuZ/0nQD0Fw
   76a8SYwNqexA6oX6ddLOwnSFJ/8WnRfYtZCcwE9eMpZStcGRtLR6jgtSJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="16001045"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="16001045"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 01:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="43835211"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Mar 2024 01:18:40 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlPFV-000FDn-1m;
	Sat, 16 Mar 2024 08:18:37 +0000
Date: Sat, 16 Mar 2024 16:18:15 +0800
From: kernel test robot <lkp@intel.com>
To: Ayush Singh <ayushdevel1325@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: Re: [PATCH v3 7/8] mikrobus: Add mikrobus driver
Message-ID: <202403161617.AYNy6qpP-lkp@intel.com>
References: <20240315184908.500352-8-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315184908.500352-8-ayushdevel1325@gmail.com>

Hi Ayush,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 61996c073c9b070922ad3a36c981ca6ddbea19a5]

url:    https://github.com/intel-lab-lkp/linux/commits/Ayush-Singh/dt-bindings-misc-Add-mikrobus-connector/20240316-025407
base:   61996c073c9b070922ad3a36c981ca6ddbea19a5
patch link:    https://lore.kernel.org/r/20240315184908.500352-8-ayushdevel1325%40gmail.com
patch subject: [PATCH v3 7/8] mikrobus: Add mikrobus driver
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240316/202403161617.AYNy6qpP-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403161617.AYNy6qpP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403161617.AYNy6qpP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/misc/mikrobus/mikrobus_manifest.c: In function 'mikrobus_manifest_parse_devices':
>> drivers/misc/mikrobus/mikrobus_manifest.c:422:13: warning: variable 'retval' set but not used [-Wunused-but-set-variable]
     422 |         int retval, devcount = 0;
         |             ^~~~~~


vim +/retval +422 drivers/misc/mikrobus/mikrobus_manifest.c

   417	
   418	static int mikrobus_manifest_parse_devices(struct addon_board_info *board)
   419	{
   420		struct greybus_descriptor_device *desc_device;
   421		struct manifest_desc *desc, *next;
 > 422		int retval, devcount = 0;
   423	
   424		list_for_each_entry_safe(desc, next, &board->manifest_descs, links) {
   425			if (desc->type != GREYBUS_TYPE_DEVICE)
   426				continue;
   427	
   428			desc_device = desc->data;
   429			retval = mikrobus_manifest_attach_device(board, desc_device);
   430			devcount++;
   431		}
   432	
   433		return devcount;
   434	}
   435	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

