Return-Path: <linux-kernel+bounces-11329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6438681E4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 03:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A331C21BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5DA18EBF;
	Tue, 26 Dec 2023 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cq4p8Xff"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6902F4EB;
	Tue, 26 Dec 2023 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703559479; x=1735095479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kPxH4mlVpKO8ProfOWoMD/kdu7a2S1nyI4WvfcycFWc=;
  b=Cq4p8XffqJz3i8aterm2Q5vGykRKmXX68UtCWImLJMqxJDzLhG/82ibC
   FfBFxtOb/KbR3Gt2uU5tW9TniABnf2FIQ1XXwSnVZZ5dRTnVjVPf6GVlP
   8w8PbxeE1rlqzp0UUYRmirhJt3MtPqFg4wdTV3wlHxpX8e8Sr10FDo1EU
   P5OWFAMww4ePi3AjJeHD0PJMALEkXiilF9PiUw9QfYw35mzKmDQIMpJ3C
   QyKJesWpvMWk5AKdfoSAhhlDd+y0LmHrfjMwH4ty5ggHjci0xU0T0Ruml
   7v62eYmH35niNcOpKLwPxxVf06rbEjZRo32/lVnw4OtFH9MP2FAtSf/UZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3398841"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="3398841"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:57:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="848321521"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="848321521"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 25 Dec 2023 18:57:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHxdg-000Dw3-1L;
	Tue, 26 Dec 2023 02:57:52 +0000
Date: Tue, 26 Dec 2023 10:57:24 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, virtualization@lists.linux.dev,
	linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Gonglei <arei.gonglei@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH] crypto: virtio - Less function calls in
 __virtio_crypto_akcipher_do_req() after error detection
Message-ID: <202312261008.7ahERlAx-lkp@intel.com>
References: <2413f22f-f0c3-45e0-9f6b-a551bdf0f54c@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2413f22f-f0c3-45e0-9f6b-a551bdf0f54c@web.de>

Hi Markus,

kernel test robot noticed the following build errors:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on herbert-crypto-2.6/master linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/crypto-virtio-Less-function-calls-in-__virtio_crypto_akcipher_do_req-after-error-detection/20231225-154431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/2413f22f-f0c3-45e0-9f6b-a551bdf0f54c%40web.de
patch subject: [PATCH] crypto: virtio - Less function calls in __virtio_crypto_akcipher_do_req() after error detection
config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20231226/202312261008.7ahERlAx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312261008.7ahERlAx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312261008.7ahERlAx-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c: In function '__virtio_crypto_akcipher_do_req':
>> drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:281:1: error: 'free_src' undeclared (first use in this function)
     281 | free_src;
         | ^~~~~~~~
   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:281:1: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:257:25: error: label 'free_src' used but not defined
     257 |                         goto free_src;
         |                         ^~~~


vim +/free_src +281 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c

   218	
   219	static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request *vc_akcipher_req,
   220			struct akcipher_request *req, struct data_queue *data_vq)
   221	{
   222		struct virtio_crypto_akcipher_ctx *ctx = vc_akcipher_req->akcipher_ctx;
   223		struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
   224		struct virtio_crypto *vcrypto = ctx->vcrypto;
   225		struct virtio_crypto_op_data_req *req_data = vc_req->req_data;
   226		struct scatterlist *sgs[4], outhdr_sg, inhdr_sg, srcdata_sg, dstdata_sg;
   227		void *src_buf, *dst_buf = NULL;
   228		unsigned int num_out = 0, num_in = 0;
   229		int node = dev_to_node(&vcrypto->vdev->dev);
   230		unsigned long flags;
   231		int ret;
   232		bool verify = vc_akcipher_req->opcode == VIRTIO_CRYPTO_AKCIPHER_VERIFY;
   233		unsigned int src_len = verify ? req->src_len + req->dst_len : req->src_len;
   234	
   235		/* out header */
   236		sg_init_one(&outhdr_sg, req_data, sizeof(*req_data));
   237		sgs[num_out++] = &outhdr_sg;
   238	
   239		/* src data */
   240		src_buf = kcalloc_node(src_len, 1, GFP_KERNEL, node);
   241		if (!src_buf)
   242			return -ENOMEM;
   243	
   244		if (verify) {
   245			/* for verify operation, both src and dst data work as OUT direction */
   246			sg_copy_to_buffer(req->src, sg_nents(req->src), src_buf, src_len);
   247			sg_init_one(&srcdata_sg, src_buf, src_len);
   248			sgs[num_out++] = &srcdata_sg;
   249		} else {
   250			sg_copy_to_buffer(req->src, sg_nents(req->src), src_buf, src_len);
   251			sg_init_one(&srcdata_sg, src_buf, src_len);
   252			sgs[num_out++] = &srcdata_sg;
   253	
   254			/* dst data */
   255			dst_buf = kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
   256			if (!dst_buf)
 > 257				goto free_src;
   258	
   259			sg_init_one(&dstdata_sg, dst_buf, req->dst_len);
   260			sgs[num_out + num_in++] = &dstdata_sg;
   261		}
   262	
   263		vc_akcipher_req->src_buf = src_buf;
   264		vc_akcipher_req->dst_buf = dst_buf;
   265	
   266		/* in header */
   267		sg_init_one(&inhdr_sg, &vc_req->status, sizeof(vc_req->status));
   268		sgs[num_out + num_in++] = &inhdr_sg;
   269	
   270		spin_lock_irqsave(&data_vq->lock, flags);
   271		ret = virtqueue_add_sgs(data_vq->vq, sgs, num_out, num_in, vc_req, GFP_ATOMIC);
   272		virtqueue_kick(data_vq->vq);
   273		spin_unlock_irqrestore(&data_vq->lock, flags);
   274		if (ret)
   275			goto err;
   276	
   277		return 0;
   278	
   279	err:
   280		kfree(dst_buf);
 > 281	free_src;
   282		kfree(src_buf);
   283		return -ENOMEM;
   284	}
   285	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

