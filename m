Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41C27E81D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346025AbjKJSfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345132AbjKJSey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:34:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FF62AD34;
        Fri, 10 Nov 2023 03:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699614014; x=1731150014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MiCyv/x6x7GRWVTPYnX8fRfSIKJ4fUfhhPf+IF7d+s8=;
  b=TPIwepSFIhgEXHpBIg3cx4ULHnxjSBbm8UtE74P6rrJGML0MItcMHtnF
   FXWl4ppL28T1zF2vmSGDv/RebaKOk4j+JhbJAnWPf3e95/5V744whNQFo
   o8oQT8PvIF+hWTXZjwrO8F9aoH4wY/1JmVWMbH5eophugn1wd7ASz2Y3j
   WsCioaHzcFPKpjio8cJ6xb0OmzdGDAZOWPKcKXuI90w7/IqL5ty7F+TsR
   5ljZ2Slyk1MhuPdT3oxt48ojWaCOrCr0eDoNKY5Q8mY5gZfKT4LWDZIrW
   MGdlbc7gut4tbOin2tw5sSARC0ylctkPNUL4UANbolAhEHxt8cvfy7A+T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="389029012"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="389029012"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 03:00:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="854367833"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="854367833"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Nov 2023 03:00:09 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1PF9-0009YM-36;
        Fri, 10 Nov 2023 11:00:07 +0000
Date:   Fri, 10 Nov 2023 18:59:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     ed.tsai@mediatek.com, ming.lei@redhat.com, hch@lst.de,
        Jens Axboe <axboe@kernel.dk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev, wsd_upstream@mediatek.com,
        chun-hung.wu@mediatek.com, casper.li@mediatek.com,
        will.shiu@mediatek.com, light.hsieh@mediatek.com,
        Ed Tsai <ed.tsai@mediatek.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] block: limit the extract size to align queue limit
Message-ID: <202311101853.9N398fyj-lkp@intel.com>
References: <20231110051950.21972-1-ed.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110051950.21972-1-ed.tsai@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on hch-configfs/for-next linus/master v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ed-tsai-mediatek-com/block-limit-the-extract-size-to-align-queue-limit/20231110-142205
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20231110051950.21972-1-ed.tsai%40mediatek.com
patch subject: [PATCH v2] block: limit the extract size to align queue limit
config: arc-randconfig-002-20231110 (https://download.01.org/0day-ci/archive/20231110/202311101853.9N398fyj-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311101853.9N398fyj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311101853.9N398fyj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   block/bio.c: In function '__bio_iov_iter_get_pages':
>> block/bio.c:1261:29: warning: suggest parentheses around '-' in operand of '&' [-Wparentheses]
    1261 |                         max - bio->bi_iter.bi_size & (max - 1) : max;
         |                         ~~~~^~~~~~~~~~~~~~~~~~~~~~


vim +1261 block/bio.c

  1214	
  1215	/**
  1216	 * __bio_iov_iter_get_pages - pin user or kernel pages and add them to a bio
  1217	 * @bio: bio to add pages to
  1218	 * @iter: iov iterator describing the region to be mapped
  1219	 *
  1220	 * Extracts pages from *iter and appends them to @bio's bvec array.  The pages
  1221	 * will have to be cleaned up in the way indicated by the BIO_PAGE_PINNED flag.
  1222	 * For a multi-segment *iter, this function only adds pages from the next
  1223	 * non-empty segment of the iov iterator.
  1224	 */
  1225	static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
  1226	{
  1227		iov_iter_extraction_t extraction_flags = 0;
  1228		unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
  1229		unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
  1230		struct block_device *bdev = bio->bi_bdev;
  1231		struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
  1232		struct page **pages = (struct page **)bv;
  1233		ssize_t max_extract = UINT_MAX - bio->bi_iter.bi_size;
  1234		ssize_t size, left;
  1235		unsigned len, i = 0;
  1236		size_t offset;
  1237		int ret = 0;
  1238	
  1239		/*
  1240		 * Move page array up in the allocated memory for the bio vecs as far as
  1241		 * possible so that we can start filling biovecs from the beginning
  1242		 * without overwriting the temporary page array.
  1243		 */
  1244		BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
  1245		pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
  1246	
  1247		if (bdev && blk_queue_pci_p2pdma(bdev->bd_disk->queue))
  1248			extraction_flags |= ITER_ALLOW_P2PDMA;
  1249	
  1250		/*
  1251		 * Each segment in the iov is required to be a block size multiple.
  1252		 * However, we may not be able to get the entire segment if it spans
  1253		 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
  1254		 * result to ensure the bio's total size is correct. The remainder of
  1255		 * the iov data will be picked up in the next bio iteration.
  1256		 */
  1257		if (bdev && bio_op(bio) != REQ_OP_ZONE_APPEND) {
  1258			unsigned int max = queue_max_bytes(bdev_get_queue(bdev));
  1259	
  1260			max_extract = bio->bi_iter.bi_size ?
> 1261				max - bio->bi_iter.bi_size & (max - 1) : max;
  1262		}
  1263		size = iov_iter_extract_pages(iter, &pages, max_extract,
  1264					      nr_pages, extraction_flags, &offset);
  1265		if (unlikely(size <= 0))
  1266			return size ? size : -EFAULT;
  1267	
  1268		nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
  1269	
  1270		if (bdev) {
  1271			size_t trim = size & (bdev_logical_block_size(bdev) - 1);
  1272			iov_iter_revert(iter, trim);
  1273			size -= trim;
  1274		}
  1275	
  1276		if (unlikely(!size)) {
  1277			ret = -EFAULT;
  1278			goto out;
  1279		}
  1280	
  1281		for (left = size, i = 0; left > 0; left -= len, i++) {
  1282			struct page *page = pages[i];
  1283	
  1284			len = min_t(size_t, PAGE_SIZE - offset, left);
  1285			if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
  1286				ret = bio_iov_add_zone_append_page(bio, page, len,
  1287						offset);
  1288				if (ret)
  1289					break;
  1290			} else
  1291				bio_iov_add_page(bio, page, len, offset);
  1292	
  1293			offset = 0;
  1294		}
  1295	
  1296		iov_iter_revert(iter, left);
  1297	out:
  1298		while (i < nr_pages)
  1299			bio_release_page(bio, pages[i++]);
  1300	
  1301		return ret;
  1302	}
  1303	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
