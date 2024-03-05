Return-Path: <linux-kernel+bounces-92994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E507872926
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0281C22DAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E2686AC3;
	Tue,  5 Mar 2024 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSTMO+iW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E4128817
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673005; cv=none; b=Oa4faHjWC4RrOI0LtD5QVaznjV7sAB5x21U5Mt6HNpp2Pea8y3vqfAfXm3kyKKkwoQyl9CRqkV09rfIRdcI4eYf+k0pF6Sh2BdIHgFrIOa+87QXvqCrzp9lq9YQsRIJwskzWL+iMXSH7IOKdb/sFJs1sNgvpQwSkAjOIQwIB0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673005; c=relaxed/simple;
	bh=TwyYg8b2ShOaemT3ZkS//uqR2Mc25XdUdWLpxcHBp8A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nhMDUyx9IDaIYi9Uen89ztXrlJvgnKxH5bT4eDHkZyGUO16Xtu/Ymmk/elBNkc4/xUSkcVnK+LggNoFYUOxlPtcj89dOTLmwUMD1/MU2PQEvJZ992m1/dmpM5FdNK1vz+PoD24BDk+GG8b4SdTT+fG2jqC+uGriOoo2I+WadwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSTMO+iW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709673003; x=1741209003;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TwyYg8b2ShOaemT3ZkS//uqR2Mc25XdUdWLpxcHBp8A=;
  b=FSTMO+iWeKfWzzY0rLM7QeLHvj+EjVn8eWSCTPDOJalCTdWKNtVnU0vj
   Kbs/nykoBxGDDEVUOJG6Z+Y+FCOCOJiXiE6ph69HhGIgq7SVBRcZg/Hfb
   kQ9lQCrXrxPOb35CJvt24aP9ZsXKxV+RSH5xP55vjeAdqC5xX0vQHufIv
   w35GLLxISNi6f+67H+beOAjnHBCcNQKi3dxg7PkDvi8HThGXVnj9krA8m
   K1boHfHhalGubKjwCUmC18IyHIf1UcHKM3TXqWPx40v3s3hdD3OukRxV5
   ATuzy6q/4K8rMqJrR6Z6EcJrUA/z6qqd04+nqsonDbeC4j8MVDr0T89L8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15397403"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="15397403"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:10:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="10090849"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 Mar 2024 13:10:00 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rhc2v-0003eH-1g;
	Tue, 05 Mar 2024 21:09:57 +0000
Date: Wed, 6 Mar 2024 05:08:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240305 1/1]
 include/linux/container_of.h:20:54: error: invalid use of undefined type
 'struct cm_work'
Message-ID: <202403060458.cPoZxP91-lkp@intel.com>
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
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20240306/202403060458.cPoZxP91-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240306/202403060458.cPoZxP91-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403060458.cPoZxP91-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/arc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:299,
                    from include/linux/array_size.h:5,
                    from include/linux/string.h:6,
                    from fs/open.c:8:
>> include/linux/tty_buffer.h:14:24: warning: empty declaration
      14 |                 struct llist_node free;
         |                        ^~~~~~~~~~
   include/uapi/linux/stddef.h:28:26: note: in definition of macro '__struct_group'
      28 |                 struct { MEMBERS } ATTRS; \
         |                          ^~~~~~~
   include/linux/tty_buffer.h:11:9: note: in expansion of macro 'struct_group_tagged'
      11 |         struct_group_tagged(tty_buffer_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/uapi/linux/stddef.h:28:34: warning: no semicolon at end of struct or union
      28 |                 struct { MEMBERS } ATTRS; \
         |                                  ^
   include/linux/stddef.h:81:9: note: in expansion of macro '__struct_group'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^~~~~~~~~~~~~~
   include/linux/tty_buffer.h:11:9: note: in expansion of macro 'struct_group_tagged'
      11 |         struct_group_tagged(tty_buffer_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/tty_buffer.h:14:24: warning: empty declaration
      14 |                 struct llist_node free;
         |                        ^~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   include/linux/tty_buffer.h:11:9: note: in expansion of macro 'struct_group_tagged'
      11 |         struct_group_tagged(tty_buffer_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:38: warning: no semicolon at end of struct or union
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                      ^
   include/linux/stddef.h:81:9: note: in expansion of macro '__struct_group'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^~~~~~~~~~~~~~
   include/linux/tty_buffer.h:11:9: note: in expansion of macro 'struct_group_tagged'
      11 |         struct_group_tagged(tty_buffer_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/mm_types.h:19,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:15,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/uapi/linux/aio_abi.h:31,
                    from fs/aio.c:18:
   fs/aio.c: In function 'free_ioctx_reqs':
>> include/linux/container_of.h:20:54: error: invalid use of undefined type 'struct cm_work'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:337:9: note: in expansion of macro 'INIT_WORK'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |         ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:337:19: note: in expansion of macro 'container_of'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |                   ^~~~~~~~~~~~
   fs/aio.c:640:9: note: in expansion of macro 'INIT_RCU_WORK'
     640 |         INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
         |         ^~~~~~~~~~~~~
   include/linux/compiler_types.h:390:27: error: expression in static assertion is not an integer
     390 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:337:9: note: in expansion of macro 'INIT_WORK'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |         ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:337:19: note: in expansion of macro 'container_of'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |                   ^~~~~~~~~~~~
   fs/aio.c:640:9: note: in expansion of macro 'INIT_RCU_WORK'
     640 |         INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
         |         ^~~~~~~~~~~~~
>> include/linux/stddef.h:16:33: error: invalid use of undefined type 'struct cm_work'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:285:30: note: in definition of macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:337:9: note: in expansion of macro 'INIT_WORK'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |         ^~~~~~~~~
   include/linux/container_of.h:23:28: note: in expansion of macro 'offsetof'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   include/linux/workqueue.h:337:19: note: in expansion of macro 'container_of'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |                   ^~~~~~~~~~~~
   fs/aio.c:640:9: note: in expansion of macro 'INIT_RCU_WORK'
     640 |         INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
         |         ^~~~~~~~~~~~~
>> include/linux/container_of.h:20:54: error: invalid use of undefined type 'struct cm_work'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:337:9: note: in expansion of macro 'INIT_WORK'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |         ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:337:19: note: in expansion of macro 'container_of'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |                   ^~~~~~~~~~~~
   fs/aio.c:640:9: note: in expansion of macro 'INIT_RCU_WORK'
     640 |         INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
         |         ^~~~~~~~~~~~~
   include/linux/compiler_types.h:390:27: error: expression in static assertion is not an integer
     390 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:337:9: note: in expansion of macro 'INIT_WORK'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |         ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:337:19: note: in expansion of macro 'container_of'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |                   ^~~~~~~~~~~~
   fs/aio.c:640:9: note: in expansion of macro 'INIT_RCU_WORK'
     640 |         INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
         |         ^~~~~~~~~~~~~
>> include/linux/stddef.h:16:33: error: invalid use of undefined type 'struct cm_work'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:286:18: note: in definition of macro '__INIT_WORK_KEY'
     286 |                 (_work)->data = (atomic_long_t) WORK_DATA_INIT();       \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:337:9: note: in expansion of macro 'INIT_WORK'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |         ^~~~~~~~~
   include/linux/container_of.h:23:28: note: in expansion of macro 'offsetof'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   include/linux/workqueue.h:337:19: note: in expansion of macro 'container_of'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |                   ^~~~~~~~~~~~
   fs/aio.c:640:9: note: in expansion of macro 'INIT_RCU_WORK'
     640 |         INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
         |         ^~~~~~~~~~~~~
>> include/linux/container_of.h:20:54: error: invalid use of undefined type 'struct cm_work'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:337:9: note: in expansion of macro 'INIT_WORK'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |         ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:337:19: note: in expansion of macro 'container_of'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |                   ^~~~~~~~~~~~
   fs/aio.c:640:9: note: in expansion of macro 'INIT_RCU_WORK'
     640 |         INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
         |         ^~~~~~~~~~~~~
   include/linux/compiler_types.h:390:27: error: expression in static assertion is not an integer
     390 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:337:9: note: in expansion of macro 'INIT_WORK'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |         ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:337:19: note: in expansion of macro 'container_of'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |                   ^~~~~~~~~~~~
   fs/aio.c:640:9: note: in expansion of macro 'INIT_RCU_WORK'
     640 |         INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
         |         ^~~~~~~~~~~~~
>> include/linux/stddef.h:16:33: error: invalid use of undefined type 'struct cm_work'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:287:34: note: in definition of macro '__INIT_WORK_KEY'
     287 |                 INIT_LIST_HEAD(&(_work)->entry);                        \
         |                                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:337:9: note: in expansion of macro 'INIT_WORK'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |         ^~~~~~~~~
   include/linux/container_of.h:23:28: note: in expansion of macro 'offsetof'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   include/linux/workqueue.h:337:19: note: in expansion of macro 'container_of'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |                   ^~~~~~~~~~~~
   fs/aio.c:640:9: note: in expansion of macro 'INIT_RCU_WORK'
     640 |         INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
         |         ^~~~~~~~~~~~~
>> include/linux/container_of.h:20:54: error: invalid use of undefined type 'struct cm_work'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:337:9: note: in expansion of macro 'INIT_WORK'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |         ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:337:19: note: in expansion of macro 'container_of'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |                   ^~~~~~~~~~~~
   fs/aio.c:640:9: note: in expansion of macro 'INIT_RCU_WORK'
     640 |         INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
         |         ^~~~~~~~~~~~~
   include/linux/compiler_types.h:390:27: error: expression in static assertion is not an integer
     390 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:337:9: note: in expansion of macro 'INIT_WORK'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |         ^~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/workqueue.h:337:19: note: in expansion of macro 'container_of'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |                   ^~~~~~~~~~~~
   fs/aio.c:640:9: note: in expansion of macro 'INIT_RCU_WORK'
     640 |         INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
         |         ^~~~~~~~~~~~~
>> include/linux/stddef.h:16:33: error: invalid use of undefined type 'struct cm_work'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:288:18: note: in definition of macro '__INIT_WORK_KEY'
     288 |                 (_work)->func = (_func);                                \
         |                  ^~~~~
   include/linux/workqueue.h:300:9: note: in expansion of macro '__INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   include/linux/workqueue.h:337:9: note: in expansion of macro 'INIT_WORK'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |         ^~~~~~~~~
   include/linux/container_of.h:23:28: note: in expansion of macro 'offsetof'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   include/linux/workqueue.h:337:19: note: in expansion of macro 'container_of'
     337 |         INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func))
         |                   ^~~~~~~~~~~~
   fs/aio.c:640:9: note: in expansion of macro 'INIT_RCU_WORK'
     640 |         INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
         |         ^~~~~~~~~~~~~


vim +20 include/linux/container_of.h

d2a8ebbf8192b8 Andy Shevchenko  2021-11-08   9  
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  10  /**
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  11   * container_of - cast a member of a structure out to the containing structure
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  12   * @ptr:	the pointer to the member.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  13   * @type:	the type of the container struct this is embedded in.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  14   * @member:	the name of the member within the struct.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  15   *
7376e561fd2e01 Sakari Ailus     2022-10-24  16   * WARNING: any const qualifier of @ptr is lost.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  17   */
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  18  #define container_of(ptr, type, member) ({				\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  19  	void *__mptr = (void *)(ptr);					\
e1edc277e6f6df Rasmus Villemoes 2021-11-08 @20  	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
e1edc277e6f6df Rasmus Villemoes 2021-11-08  21  		      __same_type(*(ptr), void),			\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  22  		      "pointer type mismatch in container_of()");	\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  23  	((type *)(__mptr - offsetof(type, member))); })
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  24  

:::::: The code at line 20 was first introduced by commit
:::::: e1edc277e6f6dfb372216522dfc57f9381c39e35 linux/container_of.h: switch to static_assert

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

