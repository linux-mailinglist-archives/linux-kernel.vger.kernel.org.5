Return-Path: <linux-kernel+bounces-93005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BDA87295E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A8EAB2E02D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F4012AAE3;
	Tue,  5 Mar 2024 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMbgnhVq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3318129A99
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673609; cv=none; b=YSNVY2T7SNXL0dDOyAj5wZVpf+53ChE/kotTKws9fe7gZhBo5+qD231HD2BR8GpyWknVcGwjORdecFbxjQyMRIkTZyfDr+PT/3c03VRaqXpItq91oUIL1iZxcBnvIl7HbV0+5jf/hXlqQaUH3NwSO5QVI2K7MSI5gXIfzYGIVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673609; c=relaxed/simple;
	bh=ULGf+5AHTPnGrBYjsBQoF+C0AVVg1hscbqY2syiZDXs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eTWFxdP8tRccTbirA5J1Gqw7sa1Nroa3lY/24ueY/w1kDFz/8fn9HWC/oX0tk/rWliE9g6J4NQjQ4jueT01QndocK7LFXxwM/0JVfn26nS6o5rgI4OwSgmPycgSZIO8N2LcZ+0Hz57FEEETIN0pEEmlp61EEBUMmzbsO4Xr15Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMbgnhVq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709673604; x=1741209604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ULGf+5AHTPnGrBYjsBQoF+C0AVVg1hscbqY2syiZDXs=;
  b=FMbgnhVqiVsOvqp8fVGSYqUxpNpqeMjYqsEmG/9/jv1Ak2+Vwj48Hce0
   DLcSS7t0JKxMxVQFKeBuB61P0ilELp/4OqVd2rBEz7Y+EAQSbD2ezyoR/
   ky8N8A4zK8xWcSTxwAuJgV3bOyuvgLwmX3EmyUV2DF9PbxQvaMm4tNqiO
   UVNamP8r/du1wLVjZelV1JyvusvrvMX+cRw8AOXk2E708bK9f9G22GJ9G
   5i5sGYXY2DmGbLqEMBSUHdvJnbG1x0f2lvcZkqxETypqsnxyw8EI8HDIO
   /NKQbJ1hY9Zy3cbmS+e8z4nir3NhW1WAXY9jVONp0pOwHwONaq9ho7wxZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14834895"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="14834895"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:20:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9935527"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Mar 2024 13:20:00 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rhcCc-0003ez-0i;
	Tue, 05 Mar 2024 21:19:58 +0000
Date: Wed, 6 Mar 2024 05:19:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240305 1/1]
 net/ipv4/ipmr.c:1803:34: error: initialization of 'struct ip_options *' from
 incompatible pointer type 'struct ip_options_hdr *'
Message-ID: <202403060507.nccQBhHT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240305
head:   3a02035a7f980ddbf41dd11815bb4e5f29e104d5
commit: 3a02035a7f980ddbf41dd11815bb4e5f29e104d5 [1/1] treewide: Address -Wflex-array-member-not-at-end warnings
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240306/202403060507.nccQBhHT-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240306/202403060507.nccQBhHT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403060507.nccQBhHT-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from net/ipv4/ipmr.c:50:
   include/net/icmp.h: In function 'icmp_send':
   include/net/icmp.h:43:47: error: passing argument 5 of '__icmp_send' from incompatible pointer type [-Werror=incompatible-pointer-types]
      43 |         __icmp_send(skb_in, type, code, info, &IPCB(skb_in)->opt);
         |                                               ^~~~~~~~~~~~~~~~~~
         |                                               |
         |                                               struct ip_options_hdr *
   include/net/icmp.h:40:43: note: expected 'const struct ip_options *' but argument is of type 'struct ip_options_hdr *'
      40 |                  const struct ip_options *opt);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   net/ipv4/ipmr.c: In function 'ipmr_forward_finish':
>> net/ipv4/ipmr.c:1803:34: error: initialization of 'struct ip_options *' from incompatible pointer type 'struct ip_options_hdr *' [-Werror=incompatible-pointer-types]
    1803 |         struct ip_options *opt = &(IPCB(skb)->opt);
         |                                  ^
   cc1: some warnings being treated as errors
--
   In file included from include/net/tcp.h:47,
                    from net/ipv4/syncookies.c:14:
   include/linux/bpf-cgroup.h: In function 'cgroup_bpf_sock_enabled':
   include/linux/bpf-cgroup.h:191:22: warning: comparison of distinct pointer types lacks a cast
     191 |         return array != &bpf_empty_prog_array.hdr;
         |                      ^~
   include/net/tcp.h: In function 'tcp_v4_save_options':
   include/net/tcp.h:2450:40: error: initialization of 'const struct ip_options *' from incompatible pointer type 'struct ip_options_hdr *' [-Werror=incompatible-pointer-types]
    2450 |         const struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
         |                                        ^
   net/ipv4/syncookies.c: In function 'cookie_v4_check':
>> net/ipv4/syncookies.c:400:34: error: initialization of 'struct ip_options *' from incompatible pointer type 'struct ip_options_hdr *' [-Werror=incompatible-pointer-types]
     400 |         struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
         |                                  ^
   cc1: some warnings being treated as errors
--
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:27: note: in expansion of macro 'container_of'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:27: note: in expansion of macro 'container_of'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/container_of.h:18:42: error: passing argument 1 of '__init_work' from incompatible pointer type [-Werror=incompatible-pointer-types]
      18 | #define container_of(ptr, type, member) ({                              \
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:260:52: note: expected 'struct work_struct *' but argument is of type 'struct cm_work *'
     260 | static inline void __init_work(struct work_struct *work, int onstack) { }
         |                                ~~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:27: note: in expansion of macro 'container_of'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:27: note: in expansion of macro 'container_of'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:27: note: in expansion of macro 'container_of'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/workqueue.h:286:24: error: 'struct cm_work' has no member named 'data'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                        ^~
   include/linux/workqueue.h:296:17: note: in expansion of macro '__INIT_WORK_KEY'
     296 |                 __INIT_WORK_KEY(_work, _func, _onstack, &__key);        \
         |                 ^~~~~~~~~~~~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:27: note: in expansion of macro 'container_of'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:27: note: in expansion of macro 'container_of'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:27: note: in expansion of macro 'container_of'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/workqueue.h:287:40: error: 'struct cm_work' has no member named 'entry'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                        ^~
   include/linux/workqueue.h:296:17: note: in expansion of macro '__INIT_WORK_KEY'
     296 |                 __INIT_WORK_KEY(_work, _func, _onstack, &__key);        \
         |                 ^~~~~~~~~~~~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:27: note: in expansion of macro 'container_of'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:27: note: in expansion of macro 'container_of'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:27: note: in expansion of macro 'container_of'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/workqueue.h:288:24: error: 'struct cm_work' has no member named 'func'
     288 |                 (_work)->func = (_func);                                \
         |                        ^~
   include/linux/workqueue.h:296:17: note: in expansion of macro '__INIT_WORK_KEY'
     296 |                 __INIT_WORK_KEY(_work, _func, _onstack, &__key);        \
         |                 ^~~~~~~~~~~~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   In file included from include/linux/workqueue.h:9:
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/timer.h:105:25: note: in definition of macro '__init_timer'
     105 |         init_timer_key((_timer), (_fn), (_flags), NULL, NULL)
         |                         ^~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:27: note: in expansion of macro 'container_of'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
>> include/linux/workqueue.h:311:38: error: 'struct cm_work' has no member named 'timer'
     311 |                 __init_timer(&(_work)->timer,                           \
         |                                      ^~
   include/linux/timer.h:105:25: note: in definition of macro '__init_timer'
     105 |         init_timer_key((_timer), (_fn), (_flags), NULL, NULL)
         |                         ^~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:969:9: note: in expansion of macro 'INIT_DELAYED_WORK'
     969 |         INIT_DELAYED_WORK(container_of(&timewait_info->work.work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/swait.h:5,
                    from include/linux/completion.h:12,
                    from drivers/infiniband/core/cm.c:10:
   drivers/infiniband/core/cm.c: In function 'cm_enter_timewait':
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:1004:36: note: in expansion of macro 'container_of'
    1004 |                                    container_of(&cm_id_priv->timewait_info->work.work, struct cm_work, hdr),
         |                                    ^~~~~~~~~~~~
>> include/linux/container_of.h:18:42: error: passing argument 2 of 'queue_delayed_work' from incompatible pointer type [-Werror=incompatible-pointer-types]
      18 | #define container_of(ptr, type, member) ({                              \
         |                                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          struct cm_work *
      19 |         void *__mptr = (void *)(ptr);                                   \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      21 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:1004:36: note: in expansion of macro 'container_of'
    1004 |                                    container_of(&cm_id_priv->timewait_info->work.work, struct cm_work, hdr),
         |                                    ^~~~~~~~~~~~
   include/linux/workqueue.h:617:60: note: expected 'struct delayed_work *' but argument is of type 'struct cm_work *'
     617 |                                       struct delayed_work *dwork,
         |                                       ~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/infiniband/core/cm.c: In function 'cm_establish':
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:27: note: in expansion of macro 'container_of'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:27: note: in expansion of macro 'container_of'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:27: note: in expansion of macro 'container_of'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/container_of.h:18:42: error: passing argument 1 of '__init_work' from incompatible pointer type [-Werror=incompatible-pointer-types]
      18 | #define container_of(ptr, type, member) ({                              \
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:260:52: note: expected 'struct work_struct *' but argument is of type 'struct cm_work *'
     260 | static inline void __init_work(struct work_struct *work, int onstack) { }
         |                                ~~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:27: note: in expansion of macro 'container_of'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:27: note: in expansion of macro 'container_of'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:27: note: in expansion of macro 'container_of'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/workqueue.h:286:24: error: 'struct cm_work' has no member named 'data'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                        ^~
   include/linux/workqueue.h:296:17: note: in expansion of macro '__INIT_WORK_KEY'
     296 |                 __INIT_WORK_KEY(_work, _func, _onstack, &__key);        \
         |                 ^~~~~~~~~~~~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:27: note: in expansion of macro 'container_of'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:27: note: in expansion of macro 'container_of'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:27: note: in expansion of macro 'container_of'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/workqueue.h:287:40: error: 'struct cm_work' has no member named 'entry'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                        ^~
   include/linux/workqueue.h:296:17: note: in expansion of macro '__INIT_WORK_KEY'
     296 |                 __INIT_WORK_KEY(_work, _func, _onstack, &__key);        \
         |                 ^~~~~~~~~~~~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:27: note: in expansion of macro 'container_of'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:27: note: in expansion of macro 'container_of'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:27: note: in expansion of macro 'container_of'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/workqueue.h:288:24: error: 'struct cm_work' has no member named 'func'
     288 |                 (_work)->func = (_func);                                \
         |                        ^~
   include/linux/workqueue.h:296:17: note: in expansion of macro '__INIT_WORK_KEY'
     296 |                 __INIT_WORK_KEY(_work, _func, _onstack, &__key);        \
         |                 ^~~~~~~~~~~~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/timer.h:105:25: note: in definition of macro '__init_timer'
     105 |         init_timer_key((_timer), (_fn), (_flags), NULL, NULL)
         |                         ^~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:27: note: in expansion of macro 'container_of'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
>> include/linux/workqueue.h:311:38: error: 'struct cm_work' has no member named 'timer'
     311 |                 __init_timer(&(_work)->timer,                           \
         |                                      ^~
   include/linux/timer.h:105:25: note: in definition of macro '__init_timer'
     105 |         init_timer_key((_timer), (_fn), (_flags), NULL, NULL)
         |                         ^~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3941:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    3941 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3952:36: note: in expansion of macro 'container_of'
    3952 |                                    container_of(&work->work, struct cm_work, hdr),
         |                                    ^~~~~~~~~~~~
>> include/linux/container_of.h:18:42: error: passing argument 2 of 'queue_delayed_work' from incompatible pointer type [-Werror=incompatible-pointer-types]
      18 | #define container_of(ptr, type, member) ({                              \
         |                                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          struct cm_work *
      19 |         void *__mptr = (void *)(ptr);                                   \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      21 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:3952:36: note: in expansion of macro 'container_of'
    3952 |                                    container_of(&work->work, struct cm_work, hdr),
         |                                    ^~~~~~~~~~~~
   include/linux/workqueue.h:617:60: note: expected 'struct delayed_work *' but argument is of type 'struct cm_work *'
     617 |                                       struct delayed_work *dwork,
         |                                       ~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/infiniband/core/cm.c: In function 'cm_recv_handler':
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:27: note: in expansion of macro 'container_of'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:27: note: in expansion of macro 'container_of'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:27: note: in expansion of macro 'container_of'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/container_of.h:18:42: error: passing argument 1 of '__init_work' from incompatible pointer type [-Werror=incompatible-pointer-types]
      18 | #define container_of(ptr, type, member) ({                              \
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:260:52: note: expected 'struct work_struct *' but argument is of type 'struct cm_work *'
     260 | static inline void __init_work(struct work_struct *work, int onstack) { }
         |                                ~~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:27: note: in expansion of macro 'container_of'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:27: note: in expansion of macro 'container_of'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:27: note: in expansion of macro 'container_of'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/workqueue.h:286:24: error: 'struct cm_work' has no member named 'data'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                        ^~
   include/linux/workqueue.h:296:17: note: in expansion of macro '__INIT_WORK_KEY'
     296 |                 __INIT_WORK_KEY(_work, _func, _onstack, &__key);        \
         |                 ^~~~~~~~~~~~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:27: note: in expansion of macro 'container_of'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:27: note: in expansion of macro 'container_of'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:27: note: in expansion of macro 'container_of'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/workqueue.h:287:40: error: 'struct cm_work' has no member named 'entry'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                        ^~
   include/linux/workqueue.h:296:17: note: in expansion of macro '__INIT_WORK_KEY'
     296 |                 __INIT_WORK_KEY(_work, _func, _onstack, &__key);        \
         |                 ^~~~~~~~~~~~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:27: note: in expansion of macro 'container_of'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:27: note: in expansion of macro 'container_of'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:27: note: in expansion of macro 'container_of'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/workqueue.h:310:27: note: in expansion of macro 'container_of'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^~~~~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/workqueue.h:288:24: error: 'struct cm_work' has no member named 'func'
     288 |                 (_work)->func = (_func);                                \
         |                        ^~
   include/linux/workqueue.h:296:17: note: in expansion of macro '__INIT_WORK_KEY'
     296 |                 __INIT_WORK_KEY(_work, _func, _onstack, &__key);        \
         |                 ^~~~~~~~~~~~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:310:17: note: in expansion of macro 'INIT_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/timer.h:105:25: note: in definition of macro '__init_timer'
     105 |         init_timer_key((_timer), (_fn), (_flags), NULL, NULL)
         |                         ^~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:27: note: in expansion of macro 'container_of'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |                           ^~~~~~~~~~~~
>> include/linux/workqueue.h:311:38: error: 'struct cm_work' has no member named 'timer'
     311 |                 __init_timer(&(_work)->timer,                           \
         |                                      ^~
   include/linux/timer.h:105:25: note: in definition of macro '__init_timer'
     105 |         init_timer_key((_timer), (_fn), (_flags), NULL, NULL)
         |                         ^~~~~~
   include/linux/workqueue.h:325:9: note: in expansion of macro '__INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4066:9: note: in expansion of macro 'INIT_DELAYED_WORK'
    4066 |         INIT_DELAYED_WORK(container_of(&work->work, struct cm_work, hdr),
         |         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4076:36: note: in expansion of macro 'container_of'
    4076 |                                    container_of(&work->work, struct cm_work, hdr),
         |                                    ^~~~~~~~~~~~
>> include/linux/container_of.h:18:42: error: passing argument 2 of 'queue_delayed_work' from incompatible pointer type [-Werror=incompatible-pointer-types]
      18 | #define container_of(ptr, type, member) ({                              \
         |                                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          struct cm_work *
      19 |         void *__mptr = (void *)(ptr);                                   \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      21 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4076:36: note: in expansion of macro 'container_of'
    4076 |                                    container_of(&work->work, struct cm_work, hdr),
         |                                    ^~~~~~~~~~~~
   include/linux/workqueue.h:617:60: note: expected 'struct delayed_work *' but argument is of type 'struct cm_work *'
     617 |                                       struct delayed_work *dwork,
         |                                       ~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/infiniband/core/cm.c: In function 'ib_cm_cleanup':
   include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4533:37: note: in expansion of macro 'container_of'
    4533 |                 cancel_delayed_work(container_of(&timewait_info->work.work, struct cm_work, hdr));
         |                                     ^~~~~~~~~~~~
>> include/linux/container_of.h:18:42: error: passing argument 1 of 'cancel_delayed_work' from incompatible pointer type [-Werror=incompatible-pointer-types]
      18 | #define container_of(ptr, type, member) ({                              \
         |                                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          struct cm_work *
      19 |         void *__mptr = (void *)(ptr);                                   \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      21 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/core/cm.c:4533:37: note: in expansion of macro 'container_of'
    4533 |                 cancel_delayed_work(container_of(&timewait_info->work.work, struct cm_work, hdr));
         |                                     ^~~~~~~~~~~~
   include/linux/workqueue.h:559:54: note: expected 'struct delayed_work *' but argument is of type 'struct cm_work *'
     559 | extern bool cancel_delayed_work(struct delayed_work *dwork);
         |                                 ~~~~~~~~~~~~~~~~~~~~~^~~~~
   cc1: some warnings being treated as errors
.


vim +1803 net/ipv4/ipmr.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  1799  
0c4b51f0054ce8 Eric W. Biederman 2015-09-15  1800  static inline int ipmr_forward_finish(struct net *net, struct sock *sk,
0c4b51f0054ce8 Eric W. Biederman 2015-09-15  1801  				      struct sk_buff *skb)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1802  {
^1da177e4c3f41 Linus Torvalds    2005-04-16 @1803  	struct ip_options *opt = &(IPCB(skb)->opt);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1804  
73186df8d7fa57 David S. Miller   2015-11-03  1805  	IP_INC_STATS(net, IPSTATS_MIB_OUTFORWDATAGRAMS);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1806  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1807  	if (unlikely(opt->optlen))
^1da177e4c3f41 Linus Torvalds    2005-04-16  1808  		ip_forward_options(skb);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1809  
13206b6bff3b15 Eric W. Biederman 2015-10-07  1810  	return dst_output(net, sk, skb);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1811  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  1812  

:::::: The code at line 1803 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

