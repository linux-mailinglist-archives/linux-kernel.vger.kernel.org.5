Return-Path: <linux-kernel+bounces-160153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1998B39E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A749B221A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29BE15218E;
	Fri, 26 Apr 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkytswIb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B214883D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141557; cv=none; b=d+Pv5NHbM7fxM4hdO+b0PJeFXj4ABMg3Hhf5jcgp3kKBDz/wqiyaZQK287ErBfrXxWyqoCwkf3rf/iZAawBM9ZAjWSb5Oymq42EiPcAjwvUNhIVw/iTY1J+aGFY8KgMe8ovIqZo1r7B/04dj36vHqFiXl0sIjcIDoFJSEsLrLJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141557; c=relaxed/simple;
	bh=FOxXbY04/XnrCXMqvWb1uftEXqf7Fy5BxGfZ+arTFXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EmQvJGJWvscsRkdxpq3NRSvYbDhwmZ44rKk4GLAL8JSxptRhLTdnK5p3MGFbDBpO+Fq6ZxaMaSzgnzpb8SdB9S2JEAtUL06OHUrMu0elb/lOSKAHwJ2TiWEHH5f2sxrcfJNAMy4hb0zJJiTuuFP+5+dwSmsYAppfkbwsre0PjFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YkytswIb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714141555; x=1745677555;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FOxXbY04/XnrCXMqvWb1uftEXqf7Fy5BxGfZ+arTFXk=;
  b=YkytswIbFsIgP+ka1gOYDtbE9g9e2QO4cEfYWxm1uS2oYF9fmcm5Nm6M
   ou9luQl5S1R4QO5rECmnAxQhg6M1hMbb56zhfXVFBfHjaM0ZQhACB0fpJ
   9Zk6voWpcx7jIKwtAKmWTonjjMNc6bdwd9OEUIlv05rUVYX97rhN9vbUI
   W63xagtNPzutrQKUW6wrlGF520WcfD+erPri+uLmQ6Wl0Ff/+6Xd7VMXx
   3SMmYK1hYXeVUXatz49Er6S8qi37HIuPOxwUoIDpCVwydOzqRdvhQzKpC
   D/e7icDaLSrDrFyBIY/GFhUZo2/L7SmnVRNzlMkwc3qqW3APMbIpXAfHu
   g==;
X-CSE-ConnectionGUID: JINWK1LgTpeFZ8hY3GFgcw==
X-CSE-MsgGUID: waHEHlFVTxyk/34VRveDHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="27333073"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="27333073"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:25:54 -0700
X-CSE-ConnectionGUID: KaZEcMiAQRK2yurP5QfyJw==
X-CSE-MsgGUID: WdR0UyhOQay6S4gFyvWuuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25313701"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 26 Apr 2024 07:25:52 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0MWL-0003o8-1h;
	Fri, 26 Apr 2024 14:25:49 +0000
Date: Fri, 26 Apr 2024 22:24:52 +0800
From: kernel test robot <lkp@intel.com>
To: Liam Howlett <liam.howlett@oracle.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: lib/maple_tree.c:336:20: error: unused function 'mte_has_null'
Message-ID: <202404262254.lEmMOMMd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c942a0cd3603e34dd2d7237e064d9318cb7f9654
commit: 6e7ba8b5e2380f941dda8a1025d70c5ce5b38982 maple_tree: mte_set_full() and mte_clear_full() clang-analyzer clean up
date:   1 year, 5 months ago
config: x86_64-sof-customedconfig-amd-defconfig (https://download.01.org/0day-ci/archive/20240426/202404262254.lEmMOMMd-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404262254.lEmMOMMd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404262254.lEmMOMMd-lkp@intel.com/

All errors (new ones prefixed by >>):

   lib/maple_tree.c:326:21: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
     326 | static inline void *mte_set_full(const struct maple_enode *node)
         |                     ^~~~~~~~~~~~
   lib/maple_tree.c:331:21: error: unused function 'mte_clear_full' [-Werror,-Wunused-function]
     331 | static inline void *mte_clear_full(const struct maple_enode *node)
         |                     ^~~~~~~~~~~~~~
>> lib/maple_tree.c:336:20: error: unused function 'mte_has_null' [-Werror,-Wunused-function]
     336 | static inline bool mte_has_null(const struct maple_enode *node)
         |                    ^~~~~~~~~~~~
   3 errors generated.


vim +/mte_has_null +336 lib/maple_tree.c

   335	
 > 336	static inline bool mte_has_null(const struct maple_enode *node)
   337	{
   338		return (unsigned long)node & MAPLE_ENODE_NULL;
   339	}
   340	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

