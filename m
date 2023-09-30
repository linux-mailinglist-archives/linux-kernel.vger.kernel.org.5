Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22F37B3E61
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 07:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjI3FJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 01:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjI3FJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:09:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24951B2;
        Fri, 29 Sep 2023 22:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696050584; x=1727586584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qswovL8KxKdf3oMfZOvKErO4KUB0d6/EYbBFUBi2r2Q=;
  b=GMj/nOVca4nVT38iRXkVb3HoyKO2+pZ7Q+Y1X/uix5yrJVwSunZNclFu
   EMlDBHCzenhEFQ1BPrR9Aq788vJZjJoaktJRxWiJFU2HgciwijCN1tepF
   nGd82BxO5Q4bVza1gMdkgRfgQUCgeGyDLjfTePexMZZpe1Diohb1PkOxS
   2zBYV0RdfBMflCLgqY6ASAKUZPQdDWmzQ2B5cI/sORzCREW2gglaRiZFK
   hpc14fEK60Riiy/mteZY9T8AbyFeRKsl0TnLKfaY/iTRhTtGTOjGKb8Sd
   cFzZA93ynjIFGVGtyxXZfN5oaHbcvaQadIcYUOIYgc+M8Q4cua3VR+syE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="386291874"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="386291874"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 22:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="1057982"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 29 Sep 2023 22:09:40 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmSES-0003jB-2R;
        Sat, 30 Sep 2023 05:09:36 +0000
Date:   Sat, 30 Sep 2023 13:09:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v8 50/53] media: core: Free range of buffers
Message-ID: <202309301247.Y0hH4pjx-lkp@intel.com>
References: <20230927153558.159278-51-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927153558.159278-51-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on sunxi/sunxi/for-next dtor-input/next linus/master v6.6-rc3]
[cannot apply to dtor-input/for-linus next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-videobuf2-Rework-offset-cookie-encoding-pattern/20230928-003247
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230927153558.159278-51-benjamin.gaignard%40collabora.com
patch subject: [PATCH v8 50/53] media: core: Free range of buffers
config: powerpc64-randconfig-001-20230930 (https://download.01.org/0day-ci/archive/20230930/202309301247.Y0hH4pjx-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309301247.Y0hH4pjx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309301247.Y0hH4pjx-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/media/common/videobuf2/videobuf2-core.c:39:2: error: #error Expected PAGE_SHIFT to be 12
      39 | #error Expected PAGE_SHIFT to be 12
         |  ^~~~~
   drivers/media/common/videobuf2/videobuf2-core.c: In function '__vb2_queue_free':
>> drivers/media/common/videobuf2/videobuf2-core.c:596:14: error: 'buffer' undeclared (first use in this function)
     596 |         for (buffer = 0; buffer < q->max_num_buffers; buffer++) {
         |              ^~~~~~
   drivers/media/common/videobuf2/videobuf2-core.c:596:14: note: each undeclared identifier is reported only once for each function it appears in


vim +/buffer +596 drivers/media/common/videobuf2/videobuf2-core.c

e23ccc0ad92586 drivers/media/video/videobuf2-core.c            Pawel Osciak          2010-10-11  540  
2a87af6ba1b9df drivers/media/v4l2-core/videobuf2-core.c        Mauro Carvalho Chehab 2017-11-27  541  /*
de4be4166a32b9 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  542   * __vb2_queue_free() - free count buffers from start index of the queue - video memory and
2d86401c2cbfce drivers/media/video/videobuf2-core.c            Guennadi Liakhovetski 2011-09-28  543   * related information, if no buffers are left return the queue to an
2d86401c2cbfce drivers/media/video/videobuf2-core.c            Guennadi Liakhovetski 2011-09-28  544   * uninitialized state. Might be called even if the queue has already been freed.
e23ccc0ad92586 drivers/media/video/videobuf2-core.c            Pawel Osciak          2010-10-11  545   */
de4be4166a32b9 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  546  static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned int count)
e23ccc0ad92586 drivers/media/video/videobuf2-core.c            Pawel Osciak          2010-10-11  547  {
de4be4166a32b9 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  548  	unsigned int i;
e23ccc0ad92586 drivers/media/video/videobuf2-core.c            Pawel Osciak          2010-10-11  549  
01cb370ff6c5ab drivers/media/common/videobuf2/videobuf2-core.c Hans Verkuil          2022-11-30  550  	lockdep_assert_held(&q->mmap_lock);
63faabfd89f4db drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2013-12-13  551  
e23ccc0ad92586 drivers/media/video/videobuf2-core.c            Pawel Osciak          2010-10-11  552  	/* Call driver-provided cleanup function for each buffer, if provided */
de4be4166a32b9 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  553  	for (i = start; i < q->max_num_buffers && i < start + count; i++) {
6e57b95def5189 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  554  		struct vb2_buffer *vb = vb2_get_buffer(q, i);
256f3162c17595 drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  555  
6e57b95def5189 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  556  		if (!vb)
6e57b95def5189 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  557  			continue;
de4be4166a32b9 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  558  		if (vb->planes[0].mem_priv)
a1d36d8c705e10 drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-03-17  559  			call_void_vb_qop(vb, buf_cleanup, vb);
e23ccc0ad92586 drivers/media/video/videobuf2-core.c            Pawel Osciak          2010-10-11  560  	}
e23ccc0ad92586 drivers/media/video/videobuf2-core.c            Pawel Osciak          2010-10-11  561  
e23ccc0ad92586 drivers/media/video/videobuf2-core.c            Pawel Osciak          2010-10-11  562  	/* Release video buffer memory */
de4be4166a32b9 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  563  	__vb2_free_mem(q, start, count);
e23ccc0ad92586 drivers/media/video/videobuf2-core.c            Pawel Osciak          2010-10-11  564  
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  565  #ifdef CONFIG_VIDEO_ADV_DEBUG
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  566  	/*
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  567  	 * Check that all the calls were balanced during the life-time of this
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  568  	 * queue. If not then dump the counters to the kernel log.
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  569  	 */
6e57b95def5189 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  570  	if (vb2_get_num_buffers(q)) {
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  571  		bool unbalanced = q->cnt_start_streaming != q->cnt_stop_streaming ||
a10b2153257403 drivers/media/common/videobuf2/videobuf2-core.c Hans Verkuil          2022-06-22  572  				  q->cnt_prepare_streaming != q->cnt_unprepare_streaming ||
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  573  				  q->cnt_wait_prepare != q->cnt_wait_finish;
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  574  
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  575  		if (unbalanced) {
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  576  			pr_info("unbalanced counters for queue %p:\n", q);
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  577  			if (q->cnt_start_streaming != q->cnt_stop_streaming)
2e33dbb06da407 drivers/media/common/videobuf/videobuf2-core.c  Mauro Carvalho Chehab 2017-12-28  578  				pr_info("     setup: %u start_streaming: %u stop_streaming: %u\n",
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  579  					q->cnt_queue_setup, q->cnt_start_streaming,
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  580  					q->cnt_stop_streaming);
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  581  			if (q->cnt_prepare_streaming != q->cnt_unprepare_streaming)
a10b2153257403 drivers/media/common/videobuf2/videobuf2-core.c Hans Verkuil          2022-06-22  582  				pr_info("     prepare_streaming: %u unprepare_streaming: %u\n",
a10b2153257403 drivers/media/common/videobuf2/videobuf2-core.c Hans Verkuil          2022-06-22  583  					q->cnt_prepare_streaming, q->cnt_unprepare_streaming);
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  584  			if (q->cnt_wait_prepare != q->cnt_wait_finish)
2e33dbb06da407 drivers/media/common/videobuf/videobuf2-core.c  Mauro Carvalho Chehab 2017-12-28  585  				pr_info("     wait_prepare: %u wait_finish: %u\n",
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  586  					q->cnt_wait_prepare, q->cnt_wait_finish);
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  587  		}
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  588  		q->cnt_queue_setup = 0;
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  589  		q->cnt_wait_prepare = 0;
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  590  		q->cnt_wait_finish = 0;
a10b2153257403 drivers/media/common/videobuf2/videobuf2-core.c Hans Verkuil          2022-06-22  591  		q->cnt_prepare_streaming = 0;
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  592  		q->cnt_start_streaming = 0;
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  593  		q->cnt_stop_streaming = 0;
a10b2153257403 drivers/media/common/videobuf2/videobuf2-core.c Hans Verkuil          2022-06-22  594  		q->cnt_unprepare_streaming = 0;
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  595  	}
6e57b95def5189 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27 @596  	for (buffer = 0; buffer < q->max_num_buffers; buffer++) {
145085ced318ad drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  597  		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
145085ced318ad drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  598  		bool unbalanced;
145085ced318ad drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  599  
145085ced318ad drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  600  		if (!vb)
145085ced318ad drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  601  			continue;
145085ced318ad drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  602  
145085ced318ad drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  603  		unbalanced = vb->cnt_mem_alloc != vb->cnt_mem_put ||
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  604  			     vb->cnt_mem_prepare != vb->cnt_mem_finish ||
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  605  			     vb->cnt_mem_get_userptr != vb->cnt_mem_put_userptr ||
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  606  			     vb->cnt_mem_attach_dmabuf != vb->cnt_mem_detach_dmabuf ||
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  607  			     vb->cnt_mem_map_dmabuf != vb->cnt_mem_unmap_dmabuf ||
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  608  			     vb->cnt_buf_queue != vb->cnt_buf_done ||
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  609  			     vb->cnt_buf_prepare != vb->cnt_buf_finish ||
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  610  			     vb->cnt_buf_init != vb->cnt_buf_cleanup;
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  611  
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  612  		if (unbalanced) {
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  613  			pr_info("unbalanced counters for queue %p, buffer %d:\n",
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  614  				q, buffer);
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  615  			if (vb->cnt_buf_init != vb->cnt_buf_cleanup)
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  616  				pr_info("     buf_init: %u buf_cleanup: %u\n",
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  617  					vb->cnt_buf_init, vb->cnt_buf_cleanup);
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  618  			if (vb->cnt_buf_prepare != vb->cnt_buf_finish)
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  619  				pr_info("     buf_prepare: %u buf_finish: %u\n",
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  620  					vb->cnt_buf_prepare, vb->cnt_buf_finish);
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  621  			if (vb->cnt_buf_queue != vb->cnt_buf_done)
28d77c21cbeb2c drivers/media/common/videobuf2/videobuf2-core.c Hans Verkuil          2019-01-16  622  				pr_info("     buf_out_validate: %u buf_queue: %u buf_done: %u buf_request_complete: %u\n",
28d77c21cbeb2c drivers/media/common/videobuf2/videobuf2-core.c Hans Verkuil          2019-01-16  623  					vb->cnt_buf_out_validate, vb->cnt_buf_queue,
28d77c21cbeb2c drivers/media/common/videobuf2/videobuf2-core.c Hans Verkuil          2019-01-16  624  					vb->cnt_buf_done, vb->cnt_buf_request_complete);
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  625  			if (vb->cnt_mem_alloc != vb->cnt_mem_put)
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  626  				pr_info("     alloc: %u put: %u\n",
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  627  					vb->cnt_mem_alloc, vb->cnt_mem_put);
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  628  			if (vb->cnt_mem_prepare != vb->cnt_mem_finish)
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  629  				pr_info("     prepare: %u finish: %u\n",
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  630  					vb->cnt_mem_prepare, vb->cnt_mem_finish);
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  631  			if (vb->cnt_mem_get_userptr != vb->cnt_mem_put_userptr)
2e33dbb06da407 drivers/media/common/videobuf/videobuf2-core.c  Mauro Carvalho Chehab 2017-12-28  632  				pr_info("     get_userptr: %u put_userptr: %u\n",
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  633  					vb->cnt_mem_get_userptr, vb->cnt_mem_put_userptr);
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  634  			if (vb->cnt_mem_attach_dmabuf != vb->cnt_mem_detach_dmabuf)
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  635  				pr_info("     attach_dmabuf: %u detach_dmabuf: %u\n",
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  636  					vb->cnt_mem_attach_dmabuf, vb->cnt_mem_detach_dmabuf);
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  637  			if (vb->cnt_mem_map_dmabuf != vb->cnt_mem_unmap_dmabuf)
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  638  				pr_info("     map_dmabuf: %u unmap_dmabuf: %u\n",
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  639  					vb->cnt_mem_map_dmabuf, vb->cnt_mem_unmap_dmabuf);
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  640  			pr_info("     get_dmabuf: %u num_users: %u\n",
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  641  				vb->cnt_mem_get_dmabuf,
14700b816b3d49 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  642  				vb->cnt_mem_num_users);
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  643  		}
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  644  	}
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  645  #endif
b5b4541eef8eac drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-01-29  646  
3e947c36af524b drivers/media/common/videobuf2/videobuf2-core.c Hans Verkuil          2022-08-10  647  	/* Free vb2 buffers */
de4be4166a32b9 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  648  	for (i = start; i < q->max_num_buffers && i < start + count; i++) {
de4be4166a32b9 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  649  		struct vb2_buffer *vb = vb2_get_buffer(q, i);
145085ced318ad drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  650  
145085ced318ad drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  651  		if (!vb)
145085ced318ad drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  652  			continue;
145085ced318ad drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  653  
145085ced318ad drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  654  		vb2_queue_remove_buffer(vb);
145085ced318ad drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  655  		kfree(vb);
e23ccc0ad92586 drivers/media/video/videobuf2-core.c            Pawel Osciak          2010-10-11  656  	}
e23ccc0ad92586 drivers/media/video/videobuf2-core.c            Pawel Osciak          2010-10-11  657  
6e57b95def5189 drivers/media/common/videobuf2/videobuf2-core.c Benjamin Gaignard     2023-09-27  658  	if (!vb2_get_num_buffers(q)) {
ce4686702f8f56 drivers/media/common/videobuf/videobuf2-core.c  Satendra Singh Thakur 2017-12-28  659  		q->memory = VB2_MEMORY_UNKNOWN;
bd50d999d4d4f3 drivers/media/video/videobuf2-core.c            Marek Szyprowski      2011-10-25  660  		INIT_LIST_HEAD(&q->queued_list);
a7afcaccfab2fb drivers/media/v4l2-core/videobuf2-core.c        Hans Verkuil          2014-02-24  661  	}
e23ccc0ad92586 drivers/media/video/videobuf2-core.c            Pawel Osciak          2010-10-11  662  }
e23ccc0ad92586 drivers/media/video/videobuf2-core.c            Pawel Osciak          2010-10-11  663  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
