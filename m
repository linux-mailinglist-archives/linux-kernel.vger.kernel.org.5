Return-Path: <linux-kernel+bounces-72608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 937F585B60D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11D5B21F52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F53627F1;
	Tue, 20 Feb 2024 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhiDHmTV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35FF627ED
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419148; cv=none; b=mEjhX9WEr8AGFSmM2/oNwxDM0RKpmUufAJAZUHyesO4ShGBe8IEM8ukLbzmr70VXVUfRYLabFfB2ZAHawFWFTR0Mdt1T2Zr8QGZlnAilCaGK3JW5JRBAz2nQoF+dWE2SplU1SrtghFZ1azNOzQzjt50Rv+CfB2kz9ECzUmCRQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419148; c=relaxed/simple;
	bh=84/50ogRKq4NqCABO2SkIOswTxcj5oGBiY4sDJh1WIM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WaKExeOIyQZm92YJ1GARvqpllrxHjngw5kvrxjhXtFhXi8j/QSnMZ9ySOu0oEBaegntxrmDWRbQoMmnDGuGc1JAWZO8c2de489Jo0jfdx+al3hiBeC9Bbh6eDGm33LBM5uI38qdXlLHaz6J5mJly9CU9Wx6d3uiVz+dXiJA+Sl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhiDHmTV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708419147; x=1739955147;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=84/50ogRKq4NqCABO2SkIOswTxcj5oGBiY4sDJh1WIM=;
  b=jhiDHmTVlHcUmbqhtlqKsVEV+zffsH2COdOsLK1nBfQEnZb6ILtQeFyw
   8U0Fb983KAEQjG8jzRuXGmcEDwtLqS8BY6KMvpRi8yB6ok8S1Uz8qZWRP
   yiwXwncVJxXOABR8rN081BdWXB08xj9XX+Z6ZhMEGb8JDNHs/Pj4BqB64
   DtqBgf65o03jOP8rKiXru/9Rgok+JKhgWOYQFlkzNxIV/C0B/LnksGe3i
   KXPm04xWzA8534JnZhiTETRE9Wn/klcAIpk/VuzuwD/fQtqSOqQsNXcmj
   aNG1TYifeTnfld+92J+cJaLigKPMXDn2zVOnoHnVKyOxtQ5EqHXuEb007
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="24970480"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="24970480"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 00:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="27878609"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 20 Feb 2024 00:52:24 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcLr4-0004Mi-0N;
	Tue, 20 Feb 2024 08:52:08 +0000
Date: Tue, 20 Feb 2024 16:51:26 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:smp/core 3/4] kernel/cpu.c:3110:9: error: expected identifier
 or '(' before '=' token
Message-ID: <202402201650.PKfPkpwx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
head:   b57b4126dd3bb69db876ae7b271307ab7e0458b9
commit: da92df490eeab7a97a3390ff32e0ae091e0dc2eb [3/4] cpu: Mark cpu_possible_mask as __ro_after_init
config: parisc-allnoconfig (https://download.01.org/0day-ci/archive/20240220/202402201650.PKfPkpwx-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240220/202402201650.PKfPkpwx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402201650.PKfPkpwx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/cpu.c:3110:9: error: expected identifier or '(' before '=' token
    3110 |         = {CPU_BITS_ALL};
         |         ^


vim +3110 kernel/cpu.c

b3199c025d1646 Rusty Russell    2008-12-30  3107  
b3199c025d1646 Rusty Russell    2008-12-30  3108  #ifdef CONFIG_INIT_ALL_POSSIBLE
da92df490eeab7 Alexey Dobriyan  2024-02-05  3109  struct cpumask __cpu_possible_mask __ro_after_init;
c4c54dd1caf139 Rasmus Villemoes 2016-01-20 @3110  	= {CPU_BITS_ALL};
b3199c025d1646 Rusty Russell    2008-12-30  3111  #else
da92df490eeab7 Alexey Dobriyan  2024-02-05  3112  struct cpumask __cpu_possible_mask __ro_after_init;
b3199c025d1646 Rusty Russell    2008-12-30  3113  #endif
4b804c85dc37db Rasmus Villemoes 2016-01-20  3114  EXPORT_SYMBOL(__cpu_possible_mask);
b3199c025d1646 Rusty Russell    2008-12-30  3115  

:::::: The code at line 3110 was first introduced by commit
:::::: c4c54dd1caf1393c529e7ea1f18b4342c796a49c kernel/cpu.c: change type of cpu_possible_bits and friends

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

