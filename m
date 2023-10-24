Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA47D49D1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjJXIRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJXIRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:17:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98D48F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698135471; x=1729671471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bYTCDhXw6YyC1xr7oYdPRrsPB2GJaOEbojy+Ca8+ZB0=;
  b=Eq0jCqJ2daOFn7CaLjdBXGYzuR5Ui8ptaYbE34nzwr/Mdf9WjTyvjg87
   q5U/H3ZkYc1fazwXqammvDEzJ6Zz0yLOad6uJTAhPUB+kY3CWOefcXP/G
   qGneSzDtFxuxqRQ0MAkdBFLGrS1bqrl54P5pg+8S/w1auPW7BqJM123B0
   obJtRAZ24GU0A0/6eOUK/mqMw4YajCWpz758f6ff9F1wVhWqVLh5qa9U1
   mkxYb0qCJnzoDDx70hgmiWhgiZhIjhVCjBy2nV+iB69nEwXTr9vyE5EJ7
   p9H7/8nbnGx2iO7YAjb+KVep1jZsf+2AZxr/dkw+Fnzz988buLFBw1wen
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="389856658"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="389856658"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 01:17:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="828741639"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="828741639"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Oct 2023 01:17:45 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvCbf-0007hJ-1w;
        Tue, 24 Oct 2023 08:17:43 +0000
Date:   Tue, 24 Oct 2023 16:17:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        domenico cerasuolo <mimmocerasuolo@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmamil.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mempolicy: alloc_pages_mpol() for NUMA policy without
 vma: fix
Message-ID: <202310241551.uY40myKo-lkp@intel.com>
References: <00dc4f56-e623-7c85-29ea-4211e93063f6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00dc4f56-e623-7c85-29ea-4211e93063f6@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

kernel test robot noticed the following build warnings:



url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20231024-144517/Hugh-Dickins/hugetlbfs-drop-shared-NUMA-mempolicy-pretence/20231003-173301
base:   the 10th patch of https://lore.kernel.org/r/74e34633-6060-f5e3-aee-7040d43f2e93%40google.com
patch link:    https://lore.kernel.org/r/00dc4f56-e623-7c85-29ea-4211e93063f6%40google.com
patch subject: [PATCH] mempolicy: alloc_pages_mpol() for NUMA policy without vma: fix
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231024/202310241551.uY40myKo-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310241551.uY40myKo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310241551.uY40myKo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/zswap.c:41:
   mm/internal.h: In function 'shrinker_debugfs_name_alloc':
   mm/internal.h:1232:9: warning: function 'shrinker_debugfs_name_alloc' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1232 |         shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
         |         ^~~~~~~~
   mm/zswap.c: In function 'zswap_writeback_entry':
   mm/zswap.c:1322:16: error: implicit declaration of function 'get_task_policy'; did you mean 'get_vma_policy'? [-Werror=implicit-function-declaration]
    1322 |         mpol = get_task_policy(current);
         |                ^~~~~~~~~~~~~~~
         |                get_vma_policy
>> mm/zswap.c:1322:14: warning: assignment to 'struct mempolicy *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1322 |         mpol = get_task_policy(current);
         |              ^
   cc1: some warnings being treated as errors


vim +1322 mm/zswap.c

  1282	
  1283	/*********************************
  1284	* writeback code
  1285	**********************************/
  1286	/*
  1287	 * Attempts to free an entry by adding a page to the swap cache,
  1288	 * decompressing the entry data into the page, and issuing a
  1289	 * bio write to write the page back to the swap device.
  1290	 *
  1291	 * This can be thought of as a "resumed writeback" of the page
  1292	 * to the swap device.  We are basically resuming the same swap
  1293	 * writeback path that was intercepted with the zswap_store()
  1294	 * in the first place.  After the page has been decompressed into
  1295	 * the swap cache, the compressed version stored by zswap can be
  1296	 * freed.
  1297	 */
  1298	static int zswap_writeback_entry(struct zswap_entry *entry,
  1299					 struct zswap_tree *tree)
  1300	{
  1301		swp_entry_t swpentry = entry->swpentry;
  1302		struct page *page;
  1303		struct mempolicy *mpol;
  1304		struct scatterlist input, output;
  1305		struct crypto_acomp_ctx *acomp_ctx;
  1306		struct zpool *pool = zswap_find_zpool(entry);
  1307		bool page_was_allocated;
  1308		u8 *src, *tmp = NULL;
  1309		unsigned int dlen;
  1310		int ret;
  1311		struct writeback_control wbc = {
  1312			.sync_mode = WB_SYNC_NONE,
  1313		};
  1314	
  1315		if (!zpool_can_sleep_mapped(pool)) {
  1316			tmp = kmalloc(PAGE_SIZE, GFP_KERNEL);
  1317			if (!tmp)
  1318				return -ENOMEM;
  1319		}
  1320	
  1321		/* try to allocate swap cache page */
> 1322		mpol = get_task_policy(current);
  1323		page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
  1324					NO_INTERLEAVE_INDEX, &page_was_allocated);
  1325		if (!page) {
  1326			ret = -ENOMEM;
  1327			goto fail;
  1328		}
  1329	
  1330		/* Found an existing page, we raced with load/swapin */
  1331		if (!page_was_allocated) {
  1332			put_page(page);
  1333			ret = -EEXIST;
  1334			goto fail;
  1335		}
  1336	
  1337		/*
  1338		 * Page is locked, and the swapcache is now secured against
  1339		 * concurrent swapping to and from the slot. Verify that the
  1340		 * swap entry hasn't been invalidated and recycled behind our
  1341		 * backs (our zswap_entry reference doesn't prevent that), to
  1342		 * avoid overwriting a new swap page with old compressed data.
  1343		 */
  1344		spin_lock(&tree->lock);
  1345		if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
  1346			spin_unlock(&tree->lock);
  1347			delete_from_swap_cache(page_folio(page));
  1348			ret = -ENOMEM;
  1349			goto fail;
  1350		}
  1351		spin_unlock(&tree->lock);
  1352	
  1353		/* decompress */
  1354		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
  1355		dlen = PAGE_SIZE;
  1356	
  1357		src = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
  1358		if (!zpool_can_sleep_mapped(pool)) {
  1359			memcpy(tmp, src, entry->length);
  1360			src = tmp;
  1361			zpool_unmap_handle(pool, entry->handle);
  1362		}
  1363	
  1364		mutex_lock(acomp_ctx->mutex);
  1365		sg_init_one(&input, src, entry->length);
  1366		sg_init_table(&output, 1);
  1367		sg_set_page(&output, page, PAGE_SIZE, 0);
  1368		acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
  1369		ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
  1370		dlen = acomp_ctx->req->dlen;
  1371		mutex_unlock(acomp_ctx->mutex);
  1372	
  1373		if (!zpool_can_sleep_mapped(pool))
  1374			kfree(tmp);
  1375		else
  1376			zpool_unmap_handle(pool, entry->handle);
  1377	
  1378		BUG_ON(ret);
  1379		BUG_ON(dlen != PAGE_SIZE);
  1380	
  1381		/* page is up to date */
  1382		SetPageUptodate(page);
  1383	
  1384		/* move it to the tail of the inactive list after end_writeback */
  1385		SetPageReclaim(page);
  1386	
  1387		/* start writeback */
  1388		__swap_writepage(page, &wbc);
  1389		put_page(page);
  1390		zswap_written_back_pages++;
  1391	
  1392		return ret;
  1393	
  1394	fail:
  1395		if (!zpool_can_sleep_mapped(pool))
  1396			kfree(tmp);
  1397	
  1398		/*
  1399		 * If we get here because the page is already in swapcache, a
  1400		 * load may be happening concurrently. It is safe and okay to
  1401		 * not free the entry. It is also okay to return !0.
  1402		 */
  1403		return ret;
  1404	}
  1405	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
