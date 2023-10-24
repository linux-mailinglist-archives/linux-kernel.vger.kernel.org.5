Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1987D4F96
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjJXMQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjJXMBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:01:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4510B111
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698148913; x=1729684913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MSFPHxmeW5WSuXly2eTbwDelfWxIjNRRHxOhXiFLHDA=;
  b=m0V+zz2x/pcZTxoYqYg6jLlhoLDe2z7UlHFntyERBI/iT9MNuscvZ/MT
   dnTMldLG3a4cUl/3niPATFeUH6mwqCGqgZG6o37baiPYSPj1xnqjoK628
   Ww/4aO3KAyxX5mPLtI4BFT1l2VOr6+edgT/4VjjLZQj66xr6BVu4Fhcrm
   Gt1QQX1pX0xIjJO0NOdnkOvX6AQptxmHkbx5n1SUZZiPNSGUkNEvv+6JZ
   +MMJx8vdolJAwyrfMMGQa7gadKIIXfxHTvXvqMjUYk6DtuwGumPK6X0kq
   BO8XExXaq60IWEFTbF0Y5mUfTTnWoRsNiYUjz7HoqJsesDsybSmt290s6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384239642"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="384239642"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:01:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1005635660"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="1005635660"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2023 05:00:57 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvG5f-0007qd-1i;
        Tue, 24 Oct 2023 12:00:55 +0000
Date:   Tue, 24 Oct 2023 20:00:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manas Ghandat <ghandatmanas@gmail.com>, dave.kleikamp@oracle.com,
        shaggy@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+9924e2a08d9ba0fd4ce2@syzkaller.appspotmail.com
Subject: Re: [PATCH] jfs: fix slab-out-of-bounds Read in dtSearch
Message-ID: <202310241933.iekefgtT-lkp@intel.com>
References: <20231016171130.15952-1-ghandatmanas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016171130.15952-1-ghandatmanas@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kleikamp-shaggy/jfs-next]
[also build test WARNING on linus/master v6.6-rc7 next-20231023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manas-Ghandat/jfs-fix-slab-out-of-bounds-Read-in-dtSearch/20231017-152500
base:   https://github.com/kleikamp/linux-shaggy jfs-next
patch link:    https://lore.kernel.org/r/20231016171130.15952-1-ghandatmanas%40gmail.com
patch subject: [PATCH] jfs: fix slab-out-of-bounds Read in dtSearch
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20231024/202310241933.iekefgtT-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310241933.iekefgtT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310241933.iekefgtT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/jfs/jfs_dtree.c:636:20: warning: result of comparison of constant 128 with expression of type 's8' (aka 'signed char') is always false [-Wtautological-constant-out-of-range-compare]
                           if (stbl[index] > 128 || stbl[index] < 0)
                               ~~~~~~~~~~~ ^ ~~~
   1 warning generated.


vim +636 fs/jfs/jfs_dtree.c

   555	
   556	/*
   557	 *	dtSearch()
   558	 *
   559	 * function:
   560	 *	Search for the entry with specified key
   561	 *
   562	 * parameter:
   563	 *
   564	 * return: 0 - search result on stack, leaf page pinned;
   565	 *	   errno - I/O error
   566	 */
   567	int dtSearch(struct inode *ip, struct component_name * key, ino_t * data,
   568		     struct btstack * btstack, int flag)
   569	{
   570		int rc = 0;
   571		int cmp = 1;		/* init for empty page */
   572		s64 bn;
   573		struct metapage *mp;
   574		dtpage_t *p;
   575		s8 *stbl;
   576		int base, index, lim;
   577		struct btframe *btsp;
   578		pxd_t *pxd;
   579		int psize = 288;	/* initial in-line directory */
   580		ino_t inumber;
   581		struct component_name ciKey;
   582		struct super_block *sb = ip->i_sb;
   583	
   584		ciKey.name = kmalloc_array(JFS_NAME_MAX + 1, sizeof(wchar_t),
   585					   GFP_NOFS);
   586		if (!ciKey.name) {
   587			rc = -ENOMEM;
   588			goto dtSearch_Exit2;
   589		}
   590	
   591	
   592		/* uppercase search key for c-i directory */
   593		UniStrcpy(ciKey.name, key->name);
   594		ciKey.namlen = key->namlen;
   595	
   596		/* only uppercase if case-insensitive support is on */
   597		if ((JFS_SBI(sb)->mntflag & JFS_OS2) == JFS_OS2) {
   598			ciToUpper(&ciKey);
   599		}
   600		BT_CLR(btstack);	/* reset stack */
   601	
   602		/* init level count for max pages to split */
   603		btstack->nsplit = 1;
   604	
   605		/*
   606		 *	search down tree from root:
   607		 *
   608		 * between two consecutive entries of <Ki, Pi> and <Kj, Pj> of
   609		 * internal page, child page Pi contains entry with k, Ki <= K < Kj.
   610		 *
   611		 * if entry with search key K is not found
   612		 * internal page search find the entry with largest key Ki
   613		 * less than K which point to the child page to search;
   614		 * leaf page search find the entry with smallest key Kj
   615		 * greater than K so that the returned index is the position of
   616		 * the entry to be shifted right for insertion of new entry.
   617		 * for empty tree, search key is greater than any key of the tree.
   618		 *
   619		 * by convention, root bn = 0.
   620		 */
   621		for (bn = 0;;) {
   622			/* get/pin the page to search */
   623			DT_GETPAGE(ip, bn, mp, psize, p, rc);
   624			if (rc)
   625				goto dtSearch_Exit1;
   626	
   627			/* get sorted entry table of the page */
   628			stbl = DT_GETSTBL(p);
   629	
   630			/*
   631			 * binary search with search key K on the current page.
   632			 */
   633			for (base = 0, lim = p->header.nextindex; lim; lim >>= 1) {
   634				index = base + (lim >> 1);
   635	
 > 636				if (stbl[index] > 128 || stbl[index] < 0)
   637					goto out;
   638	
   639				if (p->header.flag & BT_LEAF) {
   640					/* uppercase leaf name to compare */
   641					cmp =
   642					    ciCompare(&ciKey, p, stbl[index],
   643						      JFS_SBI(sb)->mntflag);
   644				} else {
   645					/* router key is in uppercase */
   646	
   647					cmp = dtCompare(&ciKey, p, stbl[index]);
   648	
   649	
   650				}
   651				if (cmp == 0) {
   652					/*
   653					 *	search hit
   654					 */
   655					/* search hit - leaf page:
   656					 * return the entry found
   657					 */
   658					if (p->header.flag & BT_LEAF) {
   659						inumber = le32_to_cpu(
   660				((struct ldtentry *) & p->slot[stbl[index]])->inumber);
   661	
   662						/*
   663						 * search for JFS_LOOKUP
   664						 */
   665						if (flag == JFS_LOOKUP) {
   666							*data = inumber;
   667							rc = 0;
   668							goto out;
   669						}
   670	
   671						/*
   672						 * search for JFS_CREATE
   673						 */
   674						if (flag == JFS_CREATE) {
   675							*data = inumber;
   676							rc = -EEXIST;
   677							goto out;
   678						}
   679	
   680						/*
   681						 * search for JFS_REMOVE or JFS_RENAME
   682						 */
   683						if ((flag == JFS_REMOVE ||
   684						     flag == JFS_RENAME) &&
   685						    *data != inumber) {
   686							rc = -ESTALE;
   687							goto out;
   688						}
   689	
   690						/*
   691						 * JFS_REMOVE|JFS_FINDDIR|JFS_RENAME
   692						 */
   693						/* save search result */
   694						*data = inumber;
   695						btsp = btstack->top;
   696						btsp->bn = bn;
   697						btsp->index = index;
   698						btsp->mp = mp;
   699	
   700						rc = 0;
   701						goto dtSearch_Exit1;
   702					}
   703	
   704					/* search hit - internal page:
   705					 * descend/search its child page
   706					 */
   707					goto getChild;
   708				}
   709	
   710				if (cmp > 0) {
   711					base = index + 1;
   712					--lim;
   713				}
   714			}
   715	
   716			/*
   717			 *	search miss
   718			 *
   719			 * base is the smallest index with key (Kj) greater than
   720			 * search key (K) and may be zero or (maxindex + 1) index.
   721			 */
   722			/*
   723			 * search miss - leaf page
   724			 *
   725			 * return location of entry (base) where new entry with
   726			 * search key K is to be inserted.
   727			 */
   728			if (p->header.flag & BT_LEAF) {
   729				/*
   730				 * search for JFS_LOOKUP, JFS_REMOVE, or JFS_RENAME
   731				 */
   732				if (flag == JFS_LOOKUP || flag == JFS_REMOVE ||
   733				    flag == JFS_RENAME) {
   734					rc = -ENOENT;
   735					goto out;
   736				}
   737	
   738				/*
   739				 * search for JFS_CREATE|JFS_FINDDIR:
   740				 *
   741				 * save search result
   742				 */
   743				*data = 0;
   744				btsp = btstack->top;
   745				btsp->bn = bn;
   746				btsp->index = base;
   747				btsp->mp = mp;
   748	
   749				rc = 0;
   750				goto dtSearch_Exit1;
   751			}
   752	
   753			/*
   754			 * search miss - internal page
   755			 *
   756			 * if base is non-zero, decrement base by one to get the parent
   757			 * entry of the child page to search.
   758			 */
   759			index = base ? base - 1 : base;
   760	
   761			/*
   762			 * go down to child page
   763			 */
   764		      getChild:
   765			/* update max. number of pages to split */
   766			if (BT_STACK_FULL(btstack)) {
   767				/* Something's corrupted, mark filesystem dirty so
   768				 * chkdsk will fix it.
   769				 */
   770				jfs_error(sb, "stack overrun!\n");
   771				BT_STACK_DUMP(btstack);
   772				rc = -EIO;
   773				goto out;
   774			}
   775			btstack->nsplit++;
   776	
   777			/* push (bn, index) of the parent page/entry */
   778			BT_PUSH(btstack, bn, index);
   779	
   780			/* get the child page block number */
   781			pxd = (pxd_t *) & p->slot[stbl[index]];
   782			bn = addressPXD(pxd);
   783			psize = lengthPXD(pxd) << JFS_SBI(ip->i_sb)->l2bsize;
   784	
   785			/* unpin the parent page */
   786			DT_PUTPAGE(mp);
   787		}
   788	
   789	      out:
   790		DT_PUTPAGE(mp);
   791	
   792	      dtSearch_Exit1:
   793	
   794		kfree(ciKey.name);
   795	
   796	      dtSearch_Exit2:
   797	
   798		return rc;
   799	}
   800	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
