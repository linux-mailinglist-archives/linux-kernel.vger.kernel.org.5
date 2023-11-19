Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AE77F0928
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 22:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjKSVey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 16:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjKSVew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 16:34:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D51103
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 13:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700429689; x=1731965689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0FQuRX+DSACk6JIpCUgripNiB3hRlwHE7sRwkTVn4tg=;
  b=hsev4PwABcnFmnQX/SxOND3O/Jpd8oam+Fo7wS50ra9BRJepJwjbdWth
   Q+0jG+PMbJPJZVMEHxsUyWg2U7ve/lcdIrNMPiRNNC+4iOgStJL99ealB
   6D/J4EVPYfCiRXtQun7PGecsJquz2taJpnyvT+8u9CWgcQ1gU4CT/BbRX
   YkhLRvCYgwzH8PNl2FxRCKGmhbQ9yKtt5mQwYp2PkCJGsD80ebObLW93h
   iaurpXpuz7KFTeEPalSIzPmZzJuqIQcO8VLt0v37U9jU3wKtY7xtvURd6
   BqlI624+goUj11lrwWiHW7NvFXzh2nDZR8b4/nLHEMQ7ahgSUi2uUM1jQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="371702060"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="371702060"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 13:34:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="909920498"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="909920498"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2023 13:34:45 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4pRD-0005Zh-2B;
        Sun, 19 Nov 2023 21:34:43 +0000
Date:   Mon, 20 Nov 2023 05:34:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v2 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Message-ID: <202311200506.qHEeLcQq-lkp@intel.com>
References: <20231119092450.164996-6-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119092450.164996-6-saeed@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saeed,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on rdma/for-next linus/master v6.7-rc1 next-20231117]
[cannot apply to char-misc/char-misc-next char-misc/char-misc-linus soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saeed-Mahameed/misc-mlx5ctl-Add-mlx5ctl-misc-driver/20231119-215311
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20231119092450.164996-6-saeed%40kernel.org
patch subject: [PATCH v2 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20231120/202311200506.qHEeLcQq-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311200506.qHEeLcQq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311200506.qHEeLcQq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/misc/mlx5ctl/umem.c:79:21: error: call to undeclared function 'pages_to_mb'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      79 |         if (npages == 0 || pages_to_mb(npages) > MLX5CTL_UMEM_MAX_MB)
         |                            ^
   1 error generated.


vim +/pages_to_mb +79 drivers/misc/mlx5ctl/umem.c

    60	
    61	static struct mlx5ctl_umem *mlx5ctl_umem_pin(struct mlx5ctl_umem_db *umem_db,
    62						     unsigned long addr, size_t size)
    63	{
    64		size_t npages = umem_num_pages(addr, size);
    65		struct mlx5_core_dev *mdev = umem_db->mdev;
    66		unsigned long endaddr = addr + size;
    67		struct mlx5ctl_umem *umem;
    68		struct page **page_list;
    69		int err = -EINVAL;
    70		int pinned = 0;
    71	
    72		dev_dbg(mdev->device, "%s: addr %p size %zu npages %zu\n",
    73			__func__, (void __user *)addr, size, npages);
    74	
    75		/* Avoid integer overflow */
    76		if (endaddr < addr || PAGE_ALIGN(endaddr) < endaddr)
    77			return ERR_PTR(-EINVAL);
    78	
  > 79		if (npages == 0 || pages_to_mb(npages) > MLX5CTL_UMEM_MAX_MB)
    80			return ERR_PTR(-EINVAL);
    81	
    82		page_list = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
    83		if (!page_list)
    84			return ERR_PTR(-ENOMEM);
    85	
    86		umem = kzalloc(sizeof(*umem), GFP_KERNEL_ACCOUNT);
    87		if (!umem) {
    88			kvfree(page_list);
    89			return ERR_PTR(-ENOMEM);
    90		}
    91	
    92		umem->addr = addr;
    93		umem->size = size;
    94		umem->offset = addr & ~PAGE_MASK;
    95		umem->npages = npages;
    96	
    97		umem->page_list = page_list;
    98		umem->source_mm = current->mm;
    99		umem->source_task = current->group_leader;
   100		get_task_struct(current->group_leader);
   101		umem->source_user = get_uid(current_user());
   102	
   103		/* mm and RLIMIT_MEMLOCK user task accounting similar to what is
   104		 * being done in iopt_alloc_pages() and do_update_pinned()
   105		 * for IOPT_PAGES_ACCOUNT_USER @drivers/iommu/iommufd/pages.c
   106		 */
   107		mmgrab(umem->source_mm);
   108	
   109		pinned = pin_user_pages_fast(addr, npages, FOLL_WRITE, page_list);
   110		if (pinned != npages) {
   111			dev_dbg(mdev->device, "pin_user_pages_fast failed %d\n", pinned);
   112			err = pinned < 0 ? pinned : -ENOMEM;
   113			goto pin_failed;
   114		}
   115	
   116		err = inc_user_locked_vm(umem, npages);
   117		if (err)
   118			goto pin_failed;
   119	
   120		atomic64_add(npages, &umem->source_mm->pinned_vm);
   121	
   122		err = sg_alloc_table_from_pages(&umem->sgt, page_list, npages, 0,
   123						npages << PAGE_SHIFT, GFP_KERNEL_ACCOUNT);
   124		if (err) {
   125			dev_dbg(mdev->device, "sg_alloc_table failed: %d\n", err);
   126			goto sgt_failed;
   127		}
   128	
   129		dev_dbg(mdev->device, "\tsgt: size %zu npages %zu sgt.nents (%d)\n",
   130			size, npages, umem->sgt.nents);
   131	
   132		err = dma_map_sgtable(mdev->device, &umem->sgt, DMA_BIDIRECTIONAL, 0);
   133		if (err) {
   134			dev_dbg(mdev->device, "dma_map_sgtable failed: %d\n", err);
   135			goto dma_failed;
   136		}
   137	
   138		dev_dbg(mdev->device, "\tsgt: dma_nents %d\n", umem->sgt.nents);
   139		return umem;
   140	
   141	dma_failed:
   142	sgt_failed:
   143		sg_free_table(&umem->sgt);
   144		atomic64_sub(npages, &umem->source_mm->pinned_vm);
   145		dec_user_locked_vm(umem, npages);
   146	pin_failed:
   147		if (pinned > 0)
   148			unpin_user_pages(page_list, pinned);
   149		mmdrop(umem->source_mm);
   150		free_uid(umem->source_user);
   151		put_task_struct(umem->source_task);
   152	
   153		kfree(umem);
   154		kvfree(page_list);
   155		return ERR_PTR(err);
   156	}
   157	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
