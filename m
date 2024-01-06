Return-Path: <linux-kernel+bounces-18582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC2D825FB8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A6F1F224AC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE997494;
	Sat,  6 Jan 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEy9fWwt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7397460
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704549424; x=1736085424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iEJTJz2Jddibopjfs8jx4G+D3yybQkJE2N06E9WrvVQ=;
  b=VEy9fWwtalopt6pPZve840cZA6m6SorzhXFd4VZccVpkXmD9YWHcLluf
   gCqtbpO0oXXHBkcg8ZPfwCCN7R4zXWN0MXmDq6O1t0VEVpTPZ2yfTaCVr
   n/AIcRzdVl3ycXPcUHMSb7qLXlrutXiwmC7XT/I3H3YSB9Ajeuq+It9LU
   5nJZ1e3Cf256JHXoM9l6evoxcociBJKbskOoWlK3tz8JVIpKLl5JlqanV
   iuAhu3xxLCBG6diByktU/M3/tlv/7tqTxK03bYiwOAEZTn1XTm6aJKEd7
   Z1xKJ9ZdlSk8POIXqg6oxvUvzBDZlDfi0oEFL3TwlIJTd8FCq3bPKLrAI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="11012491"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="11012491"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 05:56:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="846810525"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="846810525"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jan 2024 05:56:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM7AR-0002Xk-1L;
	Sat, 06 Jan 2024 13:56:51 +0000
Date: Sat, 6 Jan 2024 21:56:45 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksandr Tyshchenko <olekstysh@gmail.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] xen/gntdev: Fix the abuse of underlying struct page in
 DMA-buf import
Message-ID: <202401062122.it6zvLG0-lkp@intel.com>
References: <20240104185327.177376-1-olekstysh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104185327.177376-1-olekstysh@gmail.com>

Hi Oleksandr,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xen-tip/linux-next]
[also build test WARNING on linus/master v6.7-rc8 next-20240105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksandr-Tyshchenko/xen-gntdev-Fix-the-abuse-of-underlying-struct-page-in-DMA-buf-import/20240105-025516
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git linux-next
patch link:    https://lore.kernel.org/r/20240104185327.177376-1-olekstysh%40gmail.com
patch subject: [PATCH] xen/gntdev: Fix the abuse of underlying struct page in DMA-buf import
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20240106/202401062122.it6zvLG0-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401062122.it6zvLG0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401062122.it6zvLG0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/xen/gntdev-dmabuf.c:623:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     623 |         if (!gfns)
         |             ^~~~~
   drivers/xen/gntdev-dmabuf.c:660:9: note: uninitialized use occurs here
     660 |         return ret;
         |                ^~~
   drivers/xen/gntdev-dmabuf.c:623:2: note: remove the 'if' if its condition is always false
     623 |         if (!gfns)
         |         ^~~~~~~~~~
     624 |                 goto fail_unmap;
         |                 ~~~~~~~~~~~~~~~
   drivers/xen/gntdev-dmabuf.c:569:43: note: initialize the variable 'ret' to silence this warning
     569 |         struct gntdev_dmabuf *gntdev_dmabuf, *ret;
         |                                                  ^
         |                                                   = NULL
   1 warning generated.


vim +623 drivers/xen/gntdev-dmabuf.c

   564	
   565	static struct gntdev_dmabuf *
   566	dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
   567			   int fd, int count, int domid)
   568	{
   569		struct gntdev_dmabuf *gntdev_dmabuf, *ret;
   570		struct dma_buf *dma_buf;
   571		struct dma_buf_attachment *attach;
   572		struct sg_table *sgt;
   573		struct sg_dma_page_iter sg_iter;
   574		unsigned long *gfns;
   575		int i;
   576	
   577		dma_buf = dma_buf_get(fd);
   578		if (IS_ERR(dma_buf))
   579			return ERR_CAST(dma_buf);
   580	
   581		gntdev_dmabuf = dmabuf_imp_alloc_storage(count);
   582		if (IS_ERR(gntdev_dmabuf)) {
   583			ret = gntdev_dmabuf;
   584			goto fail_put;
   585		}
   586	
   587		gntdev_dmabuf->priv = priv;
   588		gntdev_dmabuf->fd = fd;
   589	
   590		attach = dma_buf_attach(dma_buf, dev);
   591		if (IS_ERR(attach)) {
   592			ret = ERR_CAST(attach);
   593			goto fail_free_obj;
   594		}
   595	
   596		gntdev_dmabuf->u.imp.attach = attach;
   597	
   598		sgt = dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
   599		if (IS_ERR(sgt)) {
   600			ret = ERR_CAST(sgt);
   601			goto fail_detach;
   602		}
   603	
   604		/* Check that we have zero offset. */
   605		if (sgt->sgl->offset) {
   606			ret = ERR_PTR(-EINVAL);
   607			pr_debug("DMA buffer has %d bytes offset, user-space expects 0\n",
   608				 sgt->sgl->offset);
   609			goto fail_unmap;
   610		}
   611	
   612		/* Check number of pages that imported buffer has. */
   613		if (attach->dmabuf->size != gntdev_dmabuf->nr_pages << PAGE_SHIFT) {
   614			ret = ERR_PTR(-EINVAL);
   615			pr_debug("DMA buffer has %zu pages, user-space expects %d\n",
   616				 attach->dmabuf->size, gntdev_dmabuf->nr_pages);
   617			goto fail_unmap;
   618		}
   619	
   620		gntdev_dmabuf->u.imp.sgt = sgt;
   621	
   622		gfns = kcalloc(count, sizeof(*gfns), GFP_KERNEL);
 > 623		if (!gfns)
   624			goto fail_unmap;
   625	
   626		/* Now convert sgt to array of gfns without accessing underlying pages. */
   627		i = 0;
   628		for_each_sgtable_dma_page(sgt, &sg_iter, 0) {
   629			dma_addr_t addr = sg_page_iter_dma_address(&sg_iter);
   630			unsigned long pfn = bfn_to_pfn(XEN_PFN_DOWN(dma_to_phys(dev, addr)));
   631	
   632			gfns[i++] = pfn_to_gfn(pfn);
   633		}
   634	
   635		ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gfns,
   636							      gntdev_dmabuf->u.imp.refs,
   637							      count, domid));
   638		kfree(gfns);
   639		if (IS_ERR(ret))
   640			goto fail_end_access;
   641	
   642		pr_debug("Imported DMA buffer with fd %d\n", fd);
   643	
   644		mutex_lock(&priv->lock);
   645		list_add(&gntdev_dmabuf->next, &priv->imp_list);
   646		mutex_unlock(&priv->lock);
   647	
   648		return gntdev_dmabuf;
   649	
   650	fail_end_access:
   651		dmabuf_imp_end_foreign_access(gntdev_dmabuf->u.imp.refs, count);
   652	fail_unmap:
   653		dma_buf_unmap_attachment_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
   654	fail_detach:
   655		dma_buf_detach(dma_buf, attach);
   656	fail_free_obj:
   657		dmabuf_imp_free_storage(gntdev_dmabuf);
   658	fail_put:
   659		dma_buf_put(dma_buf);
   660		return ret;
   661	}
   662	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

