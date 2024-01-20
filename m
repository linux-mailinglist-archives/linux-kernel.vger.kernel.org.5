Return-Path: <linux-kernel+bounces-31896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC5283360E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCF21C20BA1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A6812E74;
	Sat, 20 Jan 2024 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJEmstC8"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDE2125CB;
	Sat, 20 Jan 2024 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705782059; cv=none; b=Oe+GCzSXeMcEajl6AGw2/YIFZdG8HiqTpEB824Pbydzd+GJdCPnb+DzL2SjfIiaGEHBKbAt96vI9DZygEw4HBOHlppgoubJHqZMc7k8wAIoq1AWn6DHbC4K8FoQEPrcOSlXFs+D34dLf9FC2Jg7uZ1MlPvo145YMFKE/eezfur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705782059; c=relaxed/simple;
	bh=U78daOtSkrFdUaUQZUr/tYdCEiTmvCOAjx1R2N9s7GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsvuTGC8sZCu+XQcZ3wrcD189dWhE6Ey8JOopPlP/oymBy/r4Fz/AwSk0EABjRElpJq8IaJ94C88OZjtesb7laeJdEZZMM3vHRV4aO7FBqdowDZeWU8goNbsrb/0SjBhV63NKr+WP6L10Vw2+H3pWztbx8cE31W3m1AoT3vdp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJEmstC8; arc=none smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705782058; x=1737318058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U78daOtSkrFdUaUQZUr/tYdCEiTmvCOAjx1R2N9s7GE=;
  b=eJEmstC8MlnS0zC2fq/9QyJI1/ySJPZGQOyiFaYiStuuqtfWGB7f9sgi
   KuE13LMYr7l4dlxZDE0acrHd2L5jUL4oYyH4BDoED2pSrUOOYkUN+yVh1
   sJ029VooUpGsddhBku0EjsBEFxnUWgFyd9gz9LNMBusFNMLpVeDONKapV
   sZRI+l2o8Wlx/ApKdjXED01Jj8wzTMJ7ihprGQrbjtc7j2I0MoSSEWc4F
   MX08uRN5X1BgPDpIyTnx7OschAHzMwInonGOxXjulfeX0f9S6C34jrs0F
   NtApy50SNzVToGAwKXnHqHqyFMgVJ5rCVGSPMUpKXNstrpybwL0hacLvN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="487111252"
X-IronPort-AV: E=Sophos;i="6.05,208,1701158400"; 
   d="scan'208";a="487111252"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 12:20:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,208,1701158400"; 
   d="scan'208";a="941461"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Jan 2024 12:20:53 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rRHpi-0005Pv-0Y;
	Sat, 20 Jan 2024 20:20:50 +0000
Date: Sun, 21 Jan 2024 04:20:40 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Cercueil <paul@crapouillou.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Paul Cercueil <paul@crapouillou.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dma-buf: Add dma_buf_{begin,end}_access()
Message-ID: <202401210406.YYgVcAC1-lkp@intel.com>
References: <20240119141402.44262-2-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119141402.44262-2-paul@crapouillou.net>

Hi Paul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus drm-misc/drm-misc-next lwn/docs-next linus/master v6.7 next-20240119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/dma-buf-Add-dma_buf_-begin-end-_access/20240119-221604
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240119141402.44262-2-paul%40crapouillou.net
patch subject: [PATCH v5 1/6] dma-buf: Add dma_buf_{begin,end}_access()
config: arm-randconfig-001-20240120 (https://download.01.org/0day-ci/archive/20240121/202401210406.YYgVcAC1-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project d92ce344bf641e6bb025b41b3f1a77dd25e2b3e9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240121/202401210406.YYgVcAC1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401210406.YYgVcAC1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma-buf/dma-buf.c:1608: warning: Cannot understand  * @dma_buf_begin_access - Call before any hardware access from/to the DMABUF
    on line 1608 - I thought it was a doc line
>> drivers/dma-buf/dma-buf.c:1640: warning: Cannot understand  * @dma_buf_end_access - Call after any hardware access from/to the DMABUF
    on line 1640 - I thought it was a doc line


vim +1608 drivers/dma-buf/dma-buf.c

  1606	
  1607	/**
> 1608	 * @dma_buf_begin_access - Call before any hardware access from/to the DMABUF
  1609	 * @attach:	[in]	attachment used for hardware access
  1610	 * @sg_table:	[in]	scatterlist used for the DMA transfer
  1611	 * @direction:  [in]    direction of DMA transfer
  1612	 */
  1613	int dma_buf_begin_access(struct dma_buf_attachment *attach,
  1614				 struct sg_table *sgt, enum dma_data_direction dir)
  1615	{
  1616		struct dma_buf *dmabuf;
  1617		bool cookie;
  1618		int ret;
  1619	
  1620		if (WARN_ON(!attach))
  1621			return -EINVAL;
  1622	
  1623		dmabuf = attach->dmabuf;
  1624	
  1625		if (!dmabuf->ops->begin_access)
  1626			return 0;
  1627	
  1628		cookie = dma_fence_begin_signalling();
  1629		ret = dmabuf->ops->begin_access(attach, sgt, dir);
  1630		dma_fence_end_signalling(cookie);
  1631	
  1632		if (WARN_ON_ONCE(ret))
  1633			return ret;
  1634	
  1635		return 0;
  1636	}
  1637	EXPORT_SYMBOL_NS_GPL(dma_buf_begin_access, DMA_BUF);
  1638	
  1639	/**
> 1640	 * @dma_buf_end_access - Call after any hardware access from/to the DMABUF
  1641	 * @attach:	[in]	attachment used for hardware access
  1642	 * @sg_table:	[in]	scatterlist used for the DMA transfer
  1643	 * @direction:  [in]    direction of DMA transfer
  1644	 */
  1645	int dma_buf_end_access(struct dma_buf_attachment *attach,
  1646			       struct sg_table *sgt, enum dma_data_direction dir)
  1647	{
  1648		struct dma_buf *dmabuf;
  1649		bool cookie;
  1650		int ret;
  1651	
  1652		if (WARN_ON(!attach))
  1653			return -EINVAL;
  1654	
  1655		dmabuf = attach->dmabuf;
  1656	
  1657		if (!dmabuf->ops->end_access)
  1658			return 0;
  1659	
  1660		cookie = dma_fence_begin_signalling();
  1661		ret = dmabuf->ops->end_access(attach, sgt, dir);
  1662		dma_fence_end_signalling(cookie);
  1663	
  1664		if (WARN_ON_ONCE(ret))
  1665			return ret;
  1666	
  1667		return 0;
  1668	}
  1669	EXPORT_SYMBOL_NS_GPL(dma_buf_end_access, DMA_BUF);
  1670	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

