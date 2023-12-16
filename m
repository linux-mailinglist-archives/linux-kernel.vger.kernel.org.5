Return-Path: <linux-kernel+bounces-2343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7073C815B51
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8232286541
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E58321B2;
	Sat, 16 Dec 2023 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6GL4pel"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E631A8E;
	Sat, 16 Dec 2023 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702754994; x=1734290994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lv3QWQrUmLYLwZ4qvXCie7B7tfjyaTDxGvtcOhoJsN8=;
  b=M6GL4pelvf5KlwJ/I852BZi3lZLnWJ9Gjl93AxduX7Fu/h7Q2W6rPptR
   fksUnvgAeI12feAz83x0M/U/039ycA653W8N3a6HmWk9Ve18hthlYArPC
   iRYTKpiu1mm6faJ/jzyKLP+9W8WUWmjiiDdK93AaD4EHsQ4qGPTCVAUS9
   skid9r59k2wDGXlsf1gMXGW4nmNQ6vrs5D6i+krC90WCIP3vCr8h3XU2w
   c5a/uyjh6ZFA76KfjaCQXy82e/dg8oMg2QkuzkniMm5tKuEKJGThBTM5o
   cbxj6cT4wo29/QHeEf1pCjab/NGGTkZrVfLgBj9iEpddeTrjlvmo7idax
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="2562076"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="2562076"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 11:29:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="751307209"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="751307209"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2023 11:29:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEaM2-00027G-2B;
	Sat, 16 Dec 2023 19:29:42 +0000
Date: Sun, 17 Dec 2023 03:28:46 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Hao Luo <haoluo@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Juergen Gross <jgross@suse.com>, KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net-next 16/24] net: netkit, veth, tun, virt*: Use
 nested-BH locking for XDP redirect.
Message-ID: <202312170350.n7ssgNDP-lkp@intel.com>
References: <20231215171020.687342-17-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215171020.687342-17-bigeasy@linutronix.de>

Hi Sebastian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/locking-local_lock-Introduce-guard-definition-for-local_lock/20231216-011911
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231215171020.687342-17-bigeasy%40linutronix.de
patch subject: [PATCH net-next 16/24] net: netkit, veth, tun, virt*: Use nested-BH locking for XDP redirect.
config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20231217/202312170350.n7ssgNDP-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312170350.n7ssgNDP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312170350.n7ssgNDP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/hyperv/netvsc_bpf.c:53:3: error: cannot jump from this goto statement to its label
                   goto out;
                   ^
   drivers/net/hyperv/netvsc_bpf.c:61:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
           guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
           ^
   include/linux/cleanup.h:142:15: note: expanded from macro 'guard'
           CLASS(_name, __UNIQUE_ID(guard))
                        ^
   include/linux/compiler.h:180:29: note: expanded from macro '__UNIQUE_ID'
   #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                               ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
   #define __PASTE(a,b) ___PASTE(a,b)
                        ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
   #define ___PASTE(a,b) a##b
                         ^
   <scratch space>:81:1: note: expanded from here
   __UNIQUE_ID_guard635
   ^
   drivers/net/hyperv/netvsc_bpf.c:46:3: error: cannot jump from this goto statement to its label
                   goto out;
                   ^
   drivers/net/hyperv/netvsc_bpf.c:61:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
           guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
           ^
   include/linux/cleanup.h:142:15: note: expanded from macro 'guard'
           CLASS(_name, __UNIQUE_ID(guard))
                        ^
   include/linux/compiler.h:180:29: note: expanded from macro '__UNIQUE_ID'
   #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                               ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
   #define __PASTE(a,b) ___PASTE(a,b)
                        ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
   #define ___PASTE(a,b) a##b
                         ^
   <scratch space>:81:1: note: expanded from here
   __UNIQUE_ID_guard635
   ^
   drivers/net/hyperv/netvsc_bpf.c:41:3: error: cannot jump from this goto statement to its label
                   goto out;
                   ^
   drivers/net/hyperv/netvsc_bpf.c:61:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
           guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
           ^
   include/linux/cleanup.h:142:15: note: expanded from macro 'guard'
           CLASS(_name, __UNIQUE_ID(guard))
                        ^
   include/linux/compiler.h:180:29: note: expanded from macro '__UNIQUE_ID'
   #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                               ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
   #define __PASTE(a,b) ___PASTE(a,b)
                        ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
   #define ___PASTE(a,b) a##b
                         ^
   <scratch space>:81:1: note: expanded from here
   __UNIQUE_ID_guard635
   ^
   3 errors generated.


vim +53 drivers/net/hyperv/netvsc_bpf.c

351e1581395fcc Haiyang Zhang             2020-01-23   23  
351e1581395fcc Haiyang Zhang             2020-01-23   24  u32 netvsc_run_xdp(struct net_device *ndev, struct netvsc_channel *nvchan,
351e1581395fcc Haiyang Zhang             2020-01-23   25  		   struct xdp_buff *xdp)
351e1581395fcc Haiyang Zhang             2020-01-23   26  {
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   27  	struct netvsc_stats_rx *rx_stats = &nvchan->rx_stats;
351e1581395fcc Haiyang Zhang             2020-01-23   28  	void *data = nvchan->rsc.data[0];
351e1581395fcc Haiyang Zhang             2020-01-23   29  	u32 len = nvchan->rsc.len[0];
351e1581395fcc Haiyang Zhang             2020-01-23   30  	struct page *page = NULL;
351e1581395fcc Haiyang Zhang             2020-01-23   31  	struct bpf_prog *prog;
351e1581395fcc Haiyang Zhang             2020-01-23   32  	u32 act = XDP_PASS;
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   33  	bool drop = true;
351e1581395fcc Haiyang Zhang             2020-01-23   34  
351e1581395fcc Haiyang Zhang             2020-01-23   35  	xdp->data_hard_start = NULL;
351e1581395fcc Haiyang Zhang             2020-01-23   36  
351e1581395fcc Haiyang Zhang             2020-01-23   37  	rcu_read_lock();
351e1581395fcc Haiyang Zhang             2020-01-23   38  	prog = rcu_dereference(nvchan->bpf_prog);
351e1581395fcc Haiyang Zhang             2020-01-23   39  
351e1581395fcc Haiyang Zhang             2020-01-23   40  	if (!prog)
351e1581395fcc Haiyang Zhang             2020-01-23   41  		goto out;
351e1581395fcc Haiyang Zhang             2020-01-23   42  
505e3f00c3f364 Andrea Parri (Microsoft   2021-01-14   43) 	/* Ensure that the below memcpy() won't overflow the page buffer. */
505e3f00c3f364 Andrea Parri (Microsoft   2021-01-14   44) 	if (len > ndev->mtu + ETH_HLEN) {
505e3f00c3f364 Andrea Parri (Microsoft   2021-01-14   45) 		act = XDP_DROP;
505e3f00c3f364 Andrea Parri (Microsoft   2021-01-14   46) 		goto out;
505e3f00c3f364 Andrea Parri (Microsoft   2021-01-14   47) 	}
505e3f00c3f364 Andrea Parri (Microsoft   2021-01-14   48) 
351e1581395fcc Haiyang Zhang             2020-01-23   49  	/* allocate page buffer for data */
351e1581395fcc Haiyang Zhang             2020-01-23   50  	page = alloc_page(GFP_ATOMIC);
351e1581395fcc Haiyang Zhang             2020-01-23   51  	if (!page) {
351e1581395fcc Haiyang Zhang             2020-01-23   52  		act = XDP_DROP;
351e1581395fcc Haiyang Zhang             2020-01-23  @53  		goto out;
351e1581395fcc Haiyang Zhang             2020-01-23   54  	}
351e1581395fcc Haiyang Zhang             2020-01-23   55  
43b5169d8355cc Lorenzo Bianconi          2020-12-22   56  	xdp_init_buff(xdp, PAGE_SIZE, &nvchan->xdp_rxq);
be9df4aff65f18 Lorenzo Bianconi          2020-12-22   57  	xdp_prepare_buff(xdp, page_address(page), NETVSC_XDP_HDRM, len, false);
351e1581395fcc Haiyang Zhang             2020-01-23   58  
351e1581395fcc Haiyang Zhang             2020-01-23   59  	memcpy(xdp->data, data, len);
351e1581395fcc Haiyang Zhang             2020-01-23   60  
31dbfc0f055c7d Sebastian Andrzej Siewior 2023-12-15   61  	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
351e1581395fcc Haiyang Zhang             2020-01-23   62  	act = bpf_prog_run_xdp(prog, xdp);
351e1581395fcc Haiyang Zhang             2020-01-23   63  
351e1581395fcc Haiyang Zhang             2020-01-23   64  	switch (act) {
351e1581395fcc Haiyang Zhang             2020-01-23   65  	case XDP_PASS:
351e1581395fcc Haiyang Zhang             2020-01-23   66  	case XDP_TX:
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   67  		drop = false;
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   68  		break;
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   69  
351e1581395fcc Haiyang Zhang             2020-01-23   70  	case XDP_DROP:
351e1581395fcc Haiyang Zhang             2020-01-23   71  		break;
351e1581395fcc Haiyang Zhang             2020-01-23   72  
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   73  	case XDP_REDIRECT:
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   74  		if (!xdp_do_redirect(ndev, xdp, prog)) {
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   75  			nvchan->xdp_flush = true;
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   76  			drop = false;
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   77  
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   78  			u64_stats_update_begin(&rx_stats->syncp);
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   79  
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   80  			rx_stats->xdp_redirect++;
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   81  			rx_stats->packets++;
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   82  			rx_stats->bytes += nvchan->rsc.pktlen;
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   83  
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   84  			u64_stats_update_end(&rx_stats->syncp);
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   85  
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   86  			break;
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   87  		} else {
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   88  			u64_stats_update_begin(&rx_stats->syncp);
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   89  			rx_stats->xdp_drop++;
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   90  			u64_stats_update_end(&rx_stats->syncp);
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   91  		}
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   92  
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   93  		fallthrough;
1cb9d3b6185b2a Haiyang Zhang             2022-04-07   94  
351e1581395fcc Haiyang Zhang             2020-01-23   95  	case XDP_ABORTED:
351e1581395fcc Haiyang Zhang             2020-01-23   96  		trace_xdp_exception(ndev, prog, act);
351e1581395fcc Haiyang Zhang             2020-01-23   97  		break;
351e1581395fcc Haiyang Zhang             2020-01-23   98  
351e1581395fcc Haiyang Zhang             2020-01-23   99  	default:
c8064e5b4adac5 Paolo Abeni               2021-11-30  100  		bpf_warn_invalid_xdp_action(ndev, prog, act);
351e1581395fcc Haiyang Zhang             2020-01-23  101  	}
351e1581395fcc Haiyang Zhang             2020-01-23  102  
351e1581395fcc Haiyang Zhang             2020-01-23  103  out:
351e1581395fcc Haiyang Zhang             2020-01-23  104  	rcu_read_unlock();
351e1581395fcc Haiyang Zhang             2020-01-23  105  
1cb9d3b6185b2a Haiyang Zhang             2022-04-07  106  	if (page && drop) {
351e1581395fcc Haiyang Zhang             2020-01-23  107  		__free_page(page);
351e1581395fcc Haiyang Zhang             2020-01-23  108  		xdp->data_hard_start = NULL;
351e1581395fcc Haiyang Zhang             2020-01-23  109  	}
351e1581395fcc Haiyang Zhang             2020-01-23  110  
351e1581395fcc Haiyang Zhang             2020-01-23  111  	return act;
351e1581395fcc Haiyang Zhang             2020-01-23  112  }
351e1581395fcc Haiyang Zhang             2020-01-23  113  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

