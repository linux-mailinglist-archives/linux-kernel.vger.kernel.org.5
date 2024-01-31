Return-Path: <linux-kernel+bounces-46146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D7843B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E45F1F2B526
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF786994E;
	Wed, 31 Jan 2024 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQG0XsPB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B7567E7D;
	Wed, 31 Jan 2024 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693849; cv=none; b=gUQnuDKTRqBbVCP7pkQUIbaYiv5KJ8XYehET/AlLPiZo39DtQPOCQrwuJG69hq4qyBR5E89Q6elbVS32B1FtClgD0+c2RSV4KH/DP/9uOnTt5JeOdrC0xzWSBRU6fsujogDBp6wcOBI9y6M3i+sEWsCaidH3O0yH+s/DpA/H744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693849; c=relaxed/simple;
	bh=NoQuHti6IiS7+y8Ci1LusmcVVUnkd5kTdFqj+tyu7T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcHgJXwMe/vO30uxnH8oFvcSKr5RPwiDF0RJMJDKf8BowSFWB2oiOurX0eSQk8lTbPPz6qx3fcDAKKjbGiZZLMbl/EaQcTsFgsGgOoLVoBpFPrkh2lj5CG4K9TBK6KbvHBqiq5Z3ZtaR6z89PTyRnqATWPyyMeGPogBmfsmA5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQG0XsPB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706693845; x=1738229845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NoQuHti6IiS7+y8Ci1LusmcVVUnkd5kTdFqj+tyu7T0=;
  b=UQG0XsPBffKIfahohbarDYkA2tZMEOeBbATXWnzsXBzHxE4cAfscRsVl
   8UwbK+KrxnxYuTaX2bjRowjSXFp6esu/9vKKZ8UUJSJAHeObhYuZve3Az
   4Wfz/FoL1O4OFn87vdSVXfuekR+X9hziczrovcI9paRGNg/yApu9+g8t7
   Fc0Gfwdv3h5TEYr6svLC0ofgMGc7U6a2mHqICkhOAV7gmT2Pe4Sc1J5XZ
   KKtszaFqlyYwHKnHGfF8Olgy6qSxMmdyOvRgrKf9KwfUqBfkOOMGlXc0+
   GQ2OdeWQz28yrdKRQ2CfOti6C0f+Y7fzvlQPEf6Y9hr5teJNYARIKXYHK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2488841"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2488841"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 01:37:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="36805531"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 31 Jan 2024 01:37:22 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rV71w-0001Ov-2b;
	Wed, 31 Jan 2024 09:37:17 +0000
Date: Wed, 31 Jan 2024 17:34:49 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	Melissa Wen <mwen@igalia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 2/4] drm: Add drm_get_acpi_edid() helper
Message-ID: <202401311759.htfj4nbl-lkp@intel.com>
References: <20240130192608.11666-3-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130192608.11666-3-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/acpi-bus linus/master v6.8-rc2 next-20240131]
[cannot apply to drm-misc/drm-misc-next rafael-pm/devprop]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-video-Handle-fetching-EDID-that-is-longer-than-256-bytes/20240131-032909
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240130192608.11666-3-mario.limonciello%40amd.com
patch subject: [PATCH v2 2/4] drm: Add drm_get_acpi_edid() helper
config: i386-buildonly-randconfig-001-20240131 (https://download.01.org/0day-ci/archive/20240131/202401311759.htfj4nbl-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401311759.htfj4nbl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401311759.htfj4nbl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/acpi_video.c:642:44: warning: format specifies type 'long' but the argument has type 'ssize_t' (aka 'int') [-Wformat]
     642 |                                  "Invalid _DDC data for length %ld\n", length);
         |                                                                ~~~     ^~~~~~
         |                                                                %zd
   include/linux/acpi.h:1219:30: note: expanded from macro 'acpi_handle_debug'
    1219 |                            handle, pr_fmt(fmt), ##__VA_ARGS__)
         |                                           ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ACPI_WMI
   Depends on [n]: X86_PLATFORM_DEVICES [=n] && ACPI [=y]
   Selected by [y]:
   - DRM [=y] && HAS_IOMEM [=y] && (AGP [=n] || AGP [=n]=n) && !EMULATED_CMPXCHG && HAS_DMA [=y] && X86 [=y]


vim +642 drivers/acpi/acpi_video.c

^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  612  
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  613  static int
4be44fcd3bf648 drivers/acpi/video.c      Len Brown         2005-08-05  614  acpi_video_device_EDID(struct acpi_video_device *device,
4be44fcd3bf648 drivers/acpi/video.c      Len Brown         2005-08-05  615  		       union acpi_object **edid, ssize_t length)
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  616  {
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  617  	int status;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  618  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  619  	union acpi_object *obj;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  620  	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  621  	struct acpi_object_list args = { 1, &arg0 };
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  622  
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  623  
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  624  	*edid = NULL;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  625  
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  626  	if (!device)
d550d98d331737 drivers/acpi/video.c      Patrick Mochel    2006-06-27  627  		return -ENODEV;
25f97b27045655 drivers/acpi/acpi_video.c Mario Limonciello 2024-01-30  628  	if (!length || (length % 128))
d550d98d331737 drivers/acpi/video.c      Patrick Mochel    2006-06-27  629  		return -EINVAL;
25f97b27045655 drivers/acpi/acpi_video.c Mario Limonciello 2024-01-30  630  	arg0.integer.value = length / 128;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  631  
901302688cb85b drivers/acpi/video.c      Patrick Mochel    2006-05-19  632  	status = acpi_evaluate_object(device->dev->handle, "_DDC", &args, &buffer);
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  633  	if (ACPI_FAILURE(status))
d550d98d331737 drivers/acpi/video.c      Patrick Mochel    2006-06-27  634  		return -ENODEV;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  635  
50dd096973f1d9 drivers/acpi/video.c      Jan Engelhardt    2006-10-01  636  	obj = buffer.pointer;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  637  
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  638  	if (obj && obj->type == ACPI_TYPE_BUFFER)
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  639  		*edid = obj;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  640  	else {
25f97b27045655 drivers/acpi/acpi_video.c Mario Limonciello 2024-01-30  641  		acpi_handle_debug(device->dev->handle,
25f97b27045655 drivers/acpi/acpi_video.c Mario Limonciello 2024-01-30 @642  				 "Invalid _DDC data for length %ld\n", length);
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  643  		status = -EFAULT;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  644  		kfree(obj);
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  645  	}
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  646  
d550d98d331737 drivers/acpi/video.c      Patrick Mochel    2006-06-27  647  	return status;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  648  }
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds    2005-04-16  649  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

