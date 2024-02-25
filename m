Return-Path: <linux-kernel+bounces-80054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F68862A36
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E82B2100B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046412E5D;
	Sun, 25 Feb 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9JfgegD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D8212B95
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708862842; cv=none; b=Doq1vMxXKcfrfV0EeqyDna/p17kUD98KT/mkJLUUIgY1x/keMEnNXOIemF01pClEbZiAcxy4wNPWkur/5sy+EenGWhkyEqq1vLCY2CrHvyyR43ltqpXf0ofYO0vNfdMOGTex9vdggcWhB1qNrTQP/bEGde9sAiDpQEgW8Duv98Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708862842; c=relaxed/simple;
	bh=Lsnp5Weg1Haxb9ZmDlzKnaA6TKEMU+sL7UaxIGxxqp4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XLwR3wY/n1hIrcZ2AZ/BRI7B6/CHNpTfO47pCb3tbeBKM3GGufz0qMT2OpNdvwkzUrEQKYTet8bCtvskVcEGVxX81taOHuqV4ON1O/ogaTIUVbaw8aW5kKOi4NExNH5roQxQOBM36u6xocziT2hv/Ga1TKBmK5J4brll7NW6WpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9JfgegD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708862840; x=1740398840;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Lsnp5Weg1Haxb9ZmDlzKnaA6TKEMU+sL7UaxIGxxqp4=;
  b=B9JfgegDvMAEw1fTNvEKIDxAiVYuDOFgwvmhjWeio4+oQWPzUGVLRQWs
   VTP2+FjjOjxoslCjnFkWJ4kfLCq9SgAOi7smK1FpRgMOQcCwUIDQ5Q2vc
   wQ0jc0WawiqO7PETKxvN1UZJ5CCXkbSOaGdnq9T1YO52ruu2EkZgTZwaL
   Is6VMb8yjaWF8mVpCSJHBAq/TKwqakNOZNp1CzAAjDSKGK17EPeKp5gi6
   33cvNsmLxpTOyY6TaXgg3cuslNYlQnYNRi1Ea8TtOtGNmIsAnUSnVaAYm
   V4Oog3fbNnECqVXxfnYiWCzqAJiy+34sKxoTtumsbzCuHq/S5ncbszN5j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10994"; a="3030805"
X-IronPort-AV: E=Sophos;i="6.06,183,1705392000"; 
   d="scan'208";a="3030805"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 04:07:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,183,1705392000"; 
   d="scan'208";a="11076823"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 25 Feb 2024 04:07:18 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reDHo-0009Vk-1O;
	Sun, 25 Feb 2024 12:07:16 +0000
Date: Sun, 25 Feb 2024 20:06:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240223 1/1]
 drivers/rpmsg/qcom_glink_native.c:832:7: error: static assertion failed due
 to requirement '__builtin_types_compatible_p(struct glink_msg, struct
 glink_msg_hdr) || __builtin_types_compatible_p(struct glink_msg, void)':
 pointer type mismatch in container_o...
Message-ID: <202402252045.eiZZhW0P-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240223
head:   b23fc9e6ff31f4ef9e8de5580963cf53579ef0d4
commit: b23fc9e6ff31f4ef9e8de5580963cf53579ef0d4 [1/1] treewide: Address -Wflexible-array-member-not-at-end warnings
config: arm-randconfig-003-20240225 (https://download.01.org/0day-ci/archive/20240225/202402252045.eiZZhW0P-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project edd4aee4dd9b5b98b2576a6f783e4086173d902a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240225/202402252045.eiZZhW0P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402252045.eiZZhW0P-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/rpmsg/qcom_glink_native.c:832:7: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct glink_msg, struct glink_msg_hdr) || __builtin_types_compatible_p(struct glink_msg, void)': pointer type mismatch in container_of()
     832 |                            container_of(&dcmd->msg, struct glink_msg, hdr), 0,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:20:16: note: expanded from macro 'container_of'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      21 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:390:27: note: expanded from macro '__same_type'
     390 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   drivers/rpmsg/qcom_glink_native.c:1692:9: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct glink_msg, struct glink_msg_hdr) || __builtin_types_compatible_p(struct glink_msg, void)': pointer type mismatch in container_of()
    1692 |                 msg = container_of(&dcmd->msg, struct glink_msg, hdr);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:20:16: note: expanded from macro 'container_of'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      21 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:390:27: note: expanded from macro '__same_type'
     390 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   2 errors generated.


vim +832 drivers/rpmsg/qcom_glink_native.c

   813	
   814	static int qcom_glink_rx_defer(struct qcom_glink *glink, size_t extra)
   815	{
   816		struct glink_defer_cmd *dcmd;
   817	
   818		extra = ALIGN(extra, 8);
   819	
   820		if (qcom_glink_rx_avail(glink) < sizeof(struct glink_msg) + extra) {
   821			dev_dbg(glink->dev, "Insufficient data in rx fifo");
   822			return -ENXIO;
   823		}
   824	
   825		dcmd = kzalloc(struct_size(dcmd, data, extra), GFP_ATOMIC);
   826		if (!dcmd)
   827			return -ENOMEM;
   828	
   829		INIT_LIST_HEAD(&dcmd->node);
   830	
   831		qcom_glink_rx_peek(glink,
 > 832				   container_of(&dcmd->msg, struct glink_msg, hdr), 0,
   833				   sizeof(dcmd->msg) + extra);
   834	
   835		spin_lock(&glink->rx_lock);
   836		list_add_tail(&dcmd->node, &glink->rx_queue);
   837		spin_unlock(&glink->rx_lock);
   838	
   839		schedule_work(&glink->rx_work);
   840		qcom_glink_rx_advance(glink, sizeof(dcmd->msg) + extra);
   841	
   842		return 0;
   843	}
   844	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

