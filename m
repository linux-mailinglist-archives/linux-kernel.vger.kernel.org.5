Return-Path: <linux-kernel+bounces-31173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEE1832A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A1EB22B95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984F94EB2D;
	Fri, 19 Jan 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H//34y5P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F433CE9;
	Fri, 19 Jan 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669869; cv=none; b=iPm6IR0Ap5OAKgGPB05UYIV0+EoUGNb/yRqicNhs+Vqhs9XapEz+ZYm0//xa73DMM0fRGBWgxaqscW/47RvUtvKxys4HzikmV5bRDc58KJEIMTutuL/qHMlgLRCzsgTt2CZYuawkCL5oaVwL1d+BRbj1MglP16k7Q6AhpOuE9s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669869; c=relaxed/simple;
	bh=J/z83Xg047XGvf3ennA+Sk+uHgqEASMgOJ1cSPBD8MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FujAyaH/+fqV5aLho+I/esJTjDgADfBqz6HAKacDO84skOGHNuF2+4h5aXtgSEBUMfF8VxSWOO3aviOtM2zQaB1Z5ANwXTQlPW1ZfbL0zQLGybm3BNENleA4ljxpdjIU7MlV1GJp66V4D9crLZ7Uy10a+BuG9cD9JZ8iSdN6SCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H//34y5P; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705669867; x=1737205867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J/z83Xg047XGvf3ennA+Sk+uHgqEASMgOJ1cSPBD8MU=;
  b=H//34y5PgWC1Vla0/wUmWRlQtBE7+jNgXIgoda0QbONjMUK8PixK5MbQ
   juWwMtjL4g+Fn177LQclu66PAyoWDSskd6LWy3ehUJAv3EO9bFgbdK5km
   FdYmfpuv/RC026xYl7NfOfby/2Upk0VUJGLlTFjZiqtXb57p7xAykvgjF
   o31XXVJLnuzV8XcNN6zThQT3cvTPYZrxx6KGFid2No4LZ1dkFdIt04eNE
   DiXx25jMcRVWG1+HbcN0qJwdShSlK4eHTHeUcMpMrMgFq7KQgRyB+m0AI
   Qn1X5uV7v/5wPZda3hLhmjqzIwTfU1aKajRW52f558mwZN/LBIgAMp0Tv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7443367"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="7443367"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 05:11:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="785069304"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="785069304"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2024 05:11:01 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQoeA-00044W-37;
	Fri, 19 Jan 2024 13:10:58 +0000
Date: Fri, 19 Jan 2024 21:10:06 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Cercueil <paul@crapouillou.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, Paul Cercueil <paul@crapouillou.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-doc@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH v4 3/4] usb: gadget: functionfs: Add DMABUF import
 interface
Message-ID: <202401192043.6DTnLlKn-lkp@intel.com>
References: <20240117122646.41616-4-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117122646.41616-4-paul@crapouillou.net>

Hi Paul,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus lwn/docs-next linus/master v6.7 next-20240119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/usb-gadget-Support-already-mapped-DMA-SGs/20240117-203111
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240117122646.41616-4-paul%40crapouillou.net
patch subject: [PATCH v4 3/4] usb: gadget: functionfs: Add DMABUF import interface
config: arm-randconfig-r112-20240119 (https://download.01.org/0day-ci/archive/20240119/202401192043.6DTnLlKn-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce: (https://download.01.org/0day-ci/archive/20240119/202401192043.6DTnLlKn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401192043.6DTnLlKn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: dma_buf_get
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: dma_buf_detach
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
   >>> referenced 2 more times
--
>> ld.lld: error: undefined symbol: dma_fence_init
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: dma_resv_add_fence
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: dma_fence_signal
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_dmabuf_io_complete) in archive vmlinux.a
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_dmabuf_signal_done) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: dma_fence_release
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(dma_fence_put) in archive vmlinux.a
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_dmabuf_unmap_work) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: dma_buf_put
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
   >>> referenced 2 more times
--
>> ld.lld: error: undefined symbol: dma_buf_attach
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: dma_fence_context_alloc
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: dma_resv_test_signaled
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: dma_buf_map_attachment
   >>> referenced by f_fs.c
   >>>               drivers/usb/gadget/function/f_fs.o:(ffs_epfile_ioctl) in archive vmlinux.a
.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

