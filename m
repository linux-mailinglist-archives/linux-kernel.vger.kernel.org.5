Return-Path: <linux-kernel+bounces-20408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48327827E60
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E51F7B236E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39F33FFF;
	Tue,  9 Jan 2024 05:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWnyV9Ht"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAEFEB8;
	Tue,  9 Jan 2024 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704778701; x=1736314701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CgJq6F0MGiPa6WJ6Qx/8sBe+HFCDqHLZLfSIpRgNR8U=;
  b=eWnyV9HtTQFUQwNEaJIqRANKAgnIUG3ltKhr0sZq2kUcHoyxPMYGRBOt
   blYCkqaumyC8ttQ2Pbh6nwslEWXWpOZHY+3Rrt0wTbXKrf6SvTXOSfQxX
   mXhMMvJ1m72OVjNhYBXuZy9/uxOcv9kWdiUcTnBih/DS202JweLrTf2xt
   7UtjUfHpZIRODoq3ajDHr8+tj8o+sTl6hephdVg4KKRHXUxORRXxCLQQx
   8TMRr+xi+ZTv+qDb6YeLew0CbSaF3ba+QUoKPTiFOMavL/MMZOdAaZ1EU
   3RC2lhyCU4BbNim+wukW3oeLzNmdvaWRCEZDqzeEBFh/r51X7NHMoFehL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="484267133"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="484267133"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 21:38:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="757867910"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="757867910"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Jan 2024 21:38:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rN4oY-0005VO-2x;
	Tue, 09 Jan 2024 05:38:14 +0000
Date: Tue, 9 Jan 2024 13:38:00 +0800
From: kernel test robot <lkp@intel.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@openvz.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH] neighbour: purge nf_bridged skb from foreign device neigh
Message-ID: <202401091351.CqYRoau7-lkp@intel.com>
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
[also build test WARNING on net/main linus/master horms-ipvs/master v6.7 next-20240108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Tikhomirov/neighbour-purge-nf_bridged-skb-from-foreign-device-neigh/20240108-165551
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240108085232.95437-1-ptikhomirov%40virtuozzo.com
patch subject: [PATCH] neighbour: purge nf_bridged skb from foreign device neigh
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240109/202401091351.CqYRoau7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401091351.CqYRoau7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401091351.CqYRoau7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/neighbour.c: In function 'neigh_purge_nf_bridge_dev':
   net/core/neighbour.c:392:29: error: implicit declaration of function 'nf_bridge_info_get' [-Werror=implicit-function-declaration]
     392 |                 nf_bridge = nf_bridge_info_get(skb);
         |                             ^~~~~~~~~~~~~~~~~~
>> net/core/neighbour.c:392:27: warning: assignment to 'struct nf_bridge_info *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     392 |                 nf_bridge = nf_bridge_info_get(skb);
         |                           ^
   net/core/neighbour.c:395:43: error: invalid use of undefined type 'struct nf_bridge_info'
     395 |                 if (nf_bridge && nf_bridge->physindev == dev) {
         |                                           ^~
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

