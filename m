Return-Path: <linux-kernel+bounces-55629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DFB84BF3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442A01F21C68
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255B71B95B;
	Tue,  6 Feb 2024 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjmoUKCA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A751BF3F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255084; cv=none; b=Es1sRdKes27QhKKMR6aAWYBi+oQTtKJpTUBs8eKifySchAS9kqECamWMH5KGkU9I0FvSSwaRNWLRkGu57e5NvGwJn6LqozpmFONX+FukvMibf+M/3J3MOdFactOiPIgkM615tvMg1wa93nhJqjDOxvVfJiFhxOkpMqRVRtqDlrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255084; c=relaxed/simple;
	bh=PpKAGtqryckhp/Boq0/xT/G7npMb9DQcnLpOfQRlj7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WFExowJvwmeaTyPtGqQz9+uK2VkurCMB/AVx/yl6w2cC6bLsjk1hNeWGTAmHc8JMTom4e6C44rRDJcRpsqaBscQAXfSniNOQJbvy5kqI0Z7RUT47NaIRC9iIiDy5x67gHk+W3PLub9clp9SLmdMs/g+yE8GRRG8Hj6Zzbb4uuOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjmoUKCA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707255082; x=1738791082;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PpKAGtqryckhp/Boq0/xT/G7npMb9DQcnLpOfQRlj7c=;
  b=NjmoUKCAUnZ1LPbod3kMYzMXDIr4o8UXcLLRVrMV4m08p/yeputdEdBx
   ba6W66nYEMbMKm7nTEqCfsZq58d62ToGFNze5b2BemsFCdUKcc0n727SJ
   PNtPbq8FkhZwlUhFsbLoqcc13O98ynUsAo0JBYI871Tt12fmqf6Dy0+hs
   OUCsAzUDh4dw7Km0nGJ9yNw6BPg1oj2bugbR0WAY8UHBe5V1OKf10IwWk
   OG1ctqONIrvxkXTsuMbuM4BKt77pLmb1jtwsfy+vqPIaW7Cw9WemOtMFC
   rjLhXTMV2HpKQ6Jv8H3cVj42yG0JPckrkWDewf0i5bFj/Gue9f80PCuQQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="11433734"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="11433734"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 13:31:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="5767977"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Feb 2024 13:31:21 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXT2E-0001o2-0R;
	Tue, 06 Feb 2024 21:31:18 +0000
Date: Wed, 7 Feb 2024 05:30:59 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 __apply_fineibt+0x542 (section: .text) -> poison_endbr (section: .init.text)
Message-ID: <202402070548.J4Nmc91H-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99bd3cb0d12e85d5114425353552121ec8f93adc
commit: 04505bbbbb15da950ea0239e328a76a3ad2376e0 x86/fineibt: Poison ENDBR at +0
date:   7 months ago
config: x86_64-buildonly-randconfig-003-20240112 (https://download.01.org/0day-ci/archive/20240207/202402070548.J4Nmc91H-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402070548.J4Nmc91H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402070548.J4Nmc91H-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x12f (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x1d5 (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x2ec (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x3aa (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x40b (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x42b (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x4e5 (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x50c (section: .text) -> text_poke_early (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x542 (section: .text) -> poison_endbr (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

