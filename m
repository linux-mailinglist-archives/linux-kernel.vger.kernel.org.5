Return-Path: <linux-kernel+bounces-20627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE4982829C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B683B23C26
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68DA2C865;
	Tue,  9 Jan 2024 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLA9GTgM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0053622065;
	Tue,  9 Jan 2024 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704790914; x=1736326914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mtkt44KfSio1gTAnIIeK6TiR7xfZKYIsWZxbKLXjB7A=;
  b=lLA9GTgM9zEiU6TgSqp7J27P7NJSJPnnN7LrJUMZVBE/bRQusUPy75CL
   GCxjJ+Fo+ZNdLW2oJ3X6Xubogeb2tFt04g6kHwCtrSWaG3opgS38jdXqa
   Kcu7gZdKXhKS06F4POmZ78m3AIyIe8QL4NJrC2CvIRs+kCGmAtQZrTGYX
   QhjkJ3ZRgNe9TF5VXoe4RtXSgGVWwm4OudZ+vKg9A+ptl4q3ueTMLN0eb
   YsIxaqFvEBN6ivyVFwFlWSeUoYuyoxtNczOLr+jcxOSvl8SeeSvkrfGBS
   Z2O0RiQiJ1+8mIAT9EG6Z+Z4fgRwdfavT4XM0rnpa2lViO5DQew44g/wn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5491134"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="5491134"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 01:01:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="925182517"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="925182517"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jan 2024 01:01:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rN7zY-0005du-0I;
	Tue, 09 Jan 2024 09:01:48 +0000
Date: Tue, 9 Jan 2024 17:01:26 +0800
From: kernel test robot <lkp@intel.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@openvz.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH] neighbour: purge nf_bridged skb from foreign device neigh
Message-ID: <202401091607.P1JJMaxg-lkp@intel.com>
References: <20240108085232.95437-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108085232.95437-1-ptikhomirov@virtuozzo.com>

Hi Pavel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master horms-ipvs/master v6.7 next-20240109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Tikhomirov/neighbour-purge-nf_bridged-skb-from-foreign-device-neigh/20240108-165551
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240108085232.95437-1-ptikhomirov%40virtuozzo.com
patch subject: [PATCH] neighbour: purge nf_bridged skb from foreign device neigh
config: i386-defconfig (https://download.01.org/0day-ci/archive/20240109/202401091607.P1JJMaxg-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401091607.P1JJMaxg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401091607.P1JJMaxg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/neighbour.c: In function 'neigh_purge_nf_bridge_dev':
   net/core/neighbour.c:392:15: error: implicit declaration of function 'nf_bridge_info_get'; did you mean 'nf_bridge_in_prerouting'? [-Werror=implicit-function-declaration]
      nf_bridge = nf_bridge_info_get(skb);
                  ^~~~~~~~~~~~~~~~~~
                  nf_bridge_in_prerouting
>> net/core/neighbour.c:392:13: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      nf_bridge = nf_bridge_info_get(skb);
                ^
   net/core/neighbour.c:395:29: error: dereferencing pointer to incomplete type 'struct nf_bridge_info'
      if (nf_bridge && nf_bridge->physindev == dev) {
                                ^~
   cc1: some warnings being treated as errors


vim +392 net/core/neighbour.c

   382	
   383	static void neigh_purge_nf_bridge_dev(struct neighbour *neigh, struct net_device *dev)
   384	{
   385		struct sk_buff_head *list = &neigh->arp_queue;
   386		struct nf_bridge_info *nf_bridge;
   387		struct sk_buff *skb, *next;
   388	
   389		write_lock(&neigh->lock);
   390		skb = skb_peek(list);
   391		while (skb) {
 > 392			nf_bridge = nf_bridge_info_get(skb);
   393	
   394			next = skb_peek_next(skb, list);
   395			if (nf_bridge && nf_bridge->physindev == dev) {
   396				__skb_unlink(skb, list);
   397				neigh->arp_queue_len_bytes -= skb->truesize;
   398				kfree_skb(skb);
   399			}
   400			skb = next;
   401		}
   402		write_unlock(&neigh->lock);
   403	}
   404	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

