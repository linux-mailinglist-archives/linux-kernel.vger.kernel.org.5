Return-Path: <linux-kernel+bounces-2075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F5381578D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871191C248C7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D410A33;
	Sat, 16 Dec 2023 04:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIBtbvGL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283821095F;
	Sat, 16 Dec 2023 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702701846; x=1734237846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+wm8O2jpkMg+U4sXAGtL5iG9r74+fI4ciPTlI6TYHbc=;
  b=LIBtbvGLIFcl8+PUN4aYcWdVABYKoDTc5VDhiMYQYtd3yY4JL2M/Dw3z
   DS2/ir4qR8AKCkEymt3kz+n9UNRCNwjRPmfTzrsthsLgzRWZXO2eZn76E
   s5cErn0xbKA1kKmNnHFjuqoXJVIyhV2xTaOonTUN1SCUkQWSIMF2J6n3a
   nbAiYVjhgNpaif+mMBRjeA/A+HS3U7cvOl/x9OAw0T2DT/JP7u/24TFLV
   oel2/9q+0z8m/YZiHvm/Q1U/4+jGuEoanwzNuYhneXQtFVBEsc1yXutpH
   sDDBwXkS1ToH/igcymEeFjr3GXkZSrUFRi9HPMonKKCah8KbaiMqtZAOH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2534284"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="2534284"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 20:44:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="898354499"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="898354499"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Dec 2023 20:44:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEMWt-0001AI-0L;
	Sat, 16 Dec 2023 04:43:59 +0000
Date: Sat, 16 Dec 2023 12:43:23 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH net-next 04/24] net: Use nested-BH locking for
 napi_alloc_cache.
Message-ID: <202312161210.q8xdLxsl-lkp@intel.com>
References: <20231215171020.687342-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215171020.687342-5-bigeasy@linutronix.de>

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/locking-local_lock-Introduce-guard-definition-for-local_lock/20231216-011911
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231215171020.687342-5-bigeasy%40linutronix.de
patch subject: [PATCH net-next 04/24] net: Use nested-BH locking for napi_alloc_cache.
config: x86_64-randconfig-121-20231216 (https://download.01.org/0day-ci/archive/20231216/202312161210.q8xdLxsl-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161210.q8xdLxsl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161210.q8xdLxsl-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/core/skbuff.c:302:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct local_lock_t [usertype] *l @@     got struct local_lock_t [noderef] __percpu * @@
   net/core/skbuff.c:302:38: sparse:     expected struct local_lock_t [usertype] *l
   net/core/skbuff.c:302:38: sparse:     got struct local_lock_t [noderef] __percpu *
   net/core/skbuff.c:331:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct local_lock_t [usertype] *l @@     got struct local_lock_t [noderef] __percpu * @@
   net/core/skbuff.c:331:38: sparse:     expected struct local_lock_t [usertype] *l
   net/core/skbuff.c:331:38: sparse:     got struct local_lock_t [noderef] __percpu *
   net/core/skbuff.c:734:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct local_lock_t [usertype] *l @@     got struct local_lock_t [noderef] __percpu * @@
   net/core/skbuff.c:734:17: sparse:     expected struct local_lock_t [usertype] *l
   net/core/skbuff.c:734:17: sparse:     got struct local_lock_t [noderef] __percpu *
   net/core/skbuff.c:806:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct local_lock_t [usertype] *l @@     got struct local_lock_t [noderef] __percpu * @@
   net/core/skbuff.c:806:9: sparse:     expected struct local_lock_t [usertype] *l
   net/core/skbuff.c:806:9: sparse:     got struct local_lock_t [noderef] __percpu *
   net/core/skbuff.c:1317:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct local_lock_t [usertype] *l @@     got struct local_lock_t [noderef] __percpu * @@
   net/core/skbuff.c:1317:38: sparse:     expected struct local_lock_t [usertype] *l
   net/core/skbuff.c:1317:38: sparse:     got struct local_lock_t [noderef] __percpu *
   net/core/skbuff.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   net/core/skbuff.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
>> include/linux/local_lock.h:71:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct local_lock_t [usertype] * @@
   include/linux/local_lock.h:71:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   include/linux/local_lock.h:71:1: sparse:     got struct local_lock_t [usertype] *
>> include/linux/local_lock.h:71:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct local_lock_t [usertype] * @@
   include/linux/local_lock.h:71:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   include/linux/local_lock.h:71:1: sparse:     got struct local_lock_t [usertype] *
>> include/linux/local_lock.h:71:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct local_lock_t [usertype] * @@
   include/linux/local_lock.h:71:1: sparse:     expected void const [noderef] __percpu *__vpp_verify
   include/linux/local_lock.h:71:1: sparse:     got struct local_lock_t [usertype] *
   net/core/skbuff.c: note: in included file (through include/net/net_namespace.h, include/linux/inet.h):
   include/linux/skbuff.h:2715:28: sparse: sparse: self-comparison always evaluates to false
   net/core/skbuff.c: note: in included file (through include/linux/skbuff.h, include/net/net_namespace.h, include/linux/inet.h):
   include/net/checksum.h:33:39: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:33:39: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:33:39: sparse:     got unsigned int

vim +302 net/core/skbuff.c

   296	
   297	void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
   298	{
   299		struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
   300	
   301		fragsz = SKB_DATA_ALIGN(fragsz);
 > 302		guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
   303	
   304		return page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask);
   305	}
   306	EXPORT_SYMBOL(__napi_alloc_frag_align);
   307	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

