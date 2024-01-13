Return-Path: <linux-kernel+bounces-25206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832EE82CA4C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 07:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50151F23811
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 06:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82B3134DD;
	Sat, 13 Jan 2024 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mguT7U0a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9769E33C8
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705128881; x=1736664881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LiiSjn7Y67rp8tXQVxzuXlHYh29syWnvmy/Ql7KjgxY=;
  b=mguT7U0amJg7tLHVFj+cRTstyEWP/z7gYFr4AAF1w1LwiMBu1HSzM0+Z
   uiEkZcehgS36FfHzw9UD/XLdC2OmfrmTXj1myHVDc6xB6oADy/iN1DDx+
   kOfsU50OH0H+juEOiqFd5JWpZ5fzyEgkalK2DkcWvsdTM6vguh6zRr6gC
   5TaEGuSgRuldpZWxjl0V4zbkiVopkvz1yeoBy2tUEpZggLKU6A7VppsXd
   FSTID5uloJQugorjMXJb6f12LvkaFQiDlXqKPBRxHGmfW4DB0a9ZoT18X
   bUY90+WezCPisTc41bPPMf+R3QhkUttgUpZ5TmvPcg5+VHHUApNDdNSr/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="20832579"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="20832579"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 22:54:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="853485116"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="853485116"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jan 2024 22:54:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOXub-000AC6-2C;
	Sat, 13 Jan 2024 06:54:33 +0000
Date: Sat, 13 Jan 2024 14:54:17 +0800
From: kernel test robot <lkp@intel.com>
To: Leonardo Bras <leobras@redhat.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 1/5] riscv/cmpxchg: Deduplicate xchg() asm functions
Message-ID: <202401131438.f8SELM0W-lkp@intel.com>
References: <20240103163203.72768-3-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103163203.72768-3-leobras@redhat.com>

Hi Leonardo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 610a9b8f49fbcf1100716370d3b5f6f884a2835a]

url:    https://github.com/intel-lab-lkp/linux/commits/Leonardo-Bras/riscv-cmpxchg-Deduplicate-xchg-asm-functions/20240104-003501
base:   610a9b8f49fbcf1100716370d3b5f6f884a2835a
patch link:    https://lore.kernel.org/r/20240103163203.72768-3-leobras%40redhat.com
patch subject: [PATCH v1 1/5] riscv/cmpxchg: Deduplicate xchg() asm functions
config: riscv-randconfig-r111-20240112 (https://download.01.org/0day-ci/archive/20240113/202401131438.f8SELM0W-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)
reproduce: (https://download.01.org/0day-ci/archive/20240113/202401131438.f8SELM0W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401131438.f8SELM0W-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/ipv4/tcp_cong.c:300:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct tcp_congestion_ops const [noderef] __rcu *__new @@     got struct tcp_congestion_ops *[assigned] ca @@
   net/ipv4/tcp_cong.c:300:24: sparse:     expected struct tcp_congestion_ops const [noderef] __rcu *__new
   net/ipv4/tcp_cong.c:300:24: sparse:     got struct tcp_congestion_ops *[assigned] ca
   net/ipv4/tcp_cong.c:300:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct tcp_congestion_ops const *prev @@     got struct tcp_congestion_ops const [noderef] __rcu * @@
   net/ipv4/tcp_cong.c:300:22: sparse:     expected struct tcp_congestion_ops const *prev
   net/ipv4/tcp_cong.c:300:22: sparse:     got struct tcp_congestion_ops const [noderef] __rcu *
   net/ipv4/tcp_cong.c: note: in included file (through include/linux/module.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +300 net/ipv4/tcp_cong.c

317a76f9a44b43 Stephen Hemminger 2005-06-23  281  
317a76f9a44b43 Stephen Hemminger 2005-06-23  282  /* Used by sysctl to change default congestion control */
6670e152447732 Stephen Hemminger 2017-11-14  283  int tcp_set_default_congestion_control(struct net *net, const char *name)
317a76f9a44b43 Stephen Hemminger 2005-06-23  284  {
317a76f9a44b43 Stephen Hemminger 2005-06-23  285  	struct tcp_congestion_ops *ca;
6670e152447732 Stephen Hemminger 2017-11-14  286  	const struct tcp_congestion_ops *prev;
6670e152447732 Stephen Hemminger 2017-11-14  287  	int ret;
317a76f9a44b43 Stephen Hemminger 2005-06-23  288  
6670e152447732 Stephen Hemminger 2017-11-14  289  	rcu_read_lock();
6670e152447732 Stephen Hemminger 2017-11-14  290  	ca = tcp_ca_find_autoload(net, name);
6670e152447732 Stephen Hemminger 2017-11-14  291  	if (!ca) {
6670e152447732 Stephen Hemminger 2017-11-14  292  		ret = -ENOENT;
0baf26b0fcd74b Martin KaFai Lau  2020-01-08  293  	} else if (!bpf_try_module_get(ca, ca->owner)) {
6670e152447732 Stephen Hemminger 2017-11-14  294  		ret = -EBUSY;
8d432592f30fcc Jonathon Reinhart 2021-05-01  295  	} else if (!net_eq(net, &init_net) &&
8d432592f30fcc Jonathon Reinhart 2021-05-01  296  			!(ca->flags & TCP_CONG_NON_RESTRICTED)) {
8d432592f30fcc Jonathon Reinhart 2021-05-01  297  		/* Only init netns can set default to a restricted algorithm */
8d432592f30fcc Jonathon Reinhart 2021-05-01  298  		ret = -EPERM;
6670e152447732 Stephen Hemminger 2017-11-14  299  	} else {
6670e152447732 Stephen Hemminger 2017-11-14 @300  		prev = xchg(&net->ipv4.tcp_congestion_control, ca);
6670e152447732 Stephen Hemminger 2017-11-14  301  		if (prev)
0baf26b0fcd74b Martin KaFai Lau  2020-01-08  302  			bpf_module_put(prev, prev->owner);
317a76f9a44b43 Stephen Hemminger 2005-06-23  303  
6670e152447732 Stephen Hemminger 2017-11-14  304  		ca->flags |= TCP_CONG_NON_RESTRICTED;
317a76f9a44b43 Stephen Hemminger 2005-06-23  305  		ret = 0;
317a76f9a44b43 Stephen Hemminger 2005-06-23  306  	}
6670e152447732 Stephen Hemminger 2017-11-14  307  	rcu_read_unlock();
317a76f9a44b43 Stephen Hemminger 2005-06-23  308  
317a76f9a44b43 Stephen Hemminger 2005-06-23  309  	return ret;
317a76f9a44b43 Stephen Hemminger 2005-06-23  310  }
317a76f9a44b43 Stephen Hemminger 2005-06-23  311  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

