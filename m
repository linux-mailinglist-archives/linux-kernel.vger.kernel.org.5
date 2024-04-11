Return-Path: <linux-kernel+bounces-139746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9278A072D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376DA289D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFF9433D5;
	Thu, 11 Apr 2024 04:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7yUSt9f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B92A1DC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712810170; cv=none; b=FzK7U4N48XQSCgwLg2bQGalC0HUCxdjsHWabfKBCYmKMoE7m4GURswGZQmdcG9oMXwza0iUtOmq+P2cyYEbu7yVo6WXdywo3vkiOoa6ZAwqIL+H/aIP4Eufp3WFLSRa8inrvAMsB1zEnHCQua1zldUNtMESzk6uHFw0xOqBQNM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712810170; c=relaxed/simple;
	bh=o/+uwXlHAOmhl3WAKzDaiuVdwVeGNqrRyUVMQyyK9YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJN0osCiIpoaSY8jwW3OCE93ggDdLrBIJKYckm6zNnHLzrCqyrpgeofcdva0P2jgWxy9rLHUrvrU8rHiahdIHA45TJc/an0MTBkkbTyFLO7X0YHEBgiMEYetZI+gwY/LILmg6tmVnMGNcxC4WhRJZp8hKoLhUkBVjVFwvZkY3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7yUSt9f; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712810169; x=1744346169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o/+uwXlHAOmhl3WAKzDaiuVdwVeGNqrRyUVMQyyK9YU=;
  b=G7yUSt9fH7BXAzyi28P5WVtN0WwDLqSFSf0d2E81aOM38Cy+MvUBcmUe
   CaQB03CwaYQhLCgL15BXeQNbq4pONMCJKG/vDrhIHfx5Ylm0EK8dnUrwH
   KuYCLZtjoMckDcGQAjbVc079IlZHr1xOpE13e8Ad07r85m296QR5rKq2I
   Ul1bmWccUfDburgYyTqQvw9v3Z7YhHM0zqG4dIILpUIaYrwn9Q/CwuZbm
   F9iOJQ7u+VZFq/BpSLUmbYCOLlzyc0rXpnbCSdmdkZstb7ZLgbC2CcTQ5
   RcuKTcLTxAqhxf3GrDMMe3Xy6QbjL1ZFAb55NdqmwzGA83CM6Xq9K2c3D
   A==;
X-CSE-ConnectionGUID: cBh4rBAoRzub6DdftVlF+g==
X-CSE-MsgGUID: B0LhOO89Q5qG6hRvKsJnhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18913202"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="18913202"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 21:36:09 -0700
X-CSE-ConnectionGUID: sDkHX2rWTVew/QfTWLUgGQ==
X-CSE-MsgGUID: Pce/SbP3T3C4/uW44S2Mtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20783082"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Apr 2024 21:36:06 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rumAN-0008Do-2N;
	Thu, 11 Apr 2024 04:36:03 +0000
Date: Thu, 11 Apr 2024 12:36:03 +0800
From: kernel test robot <lkp@intel.com>
To: Jinglin Wen <jinglin.wen@shingroup.cn>, palmer@dabbelt.com
Cc: oe-kbuild-all@lists.linux.dev, paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu, gregkh@linuxfoundation.org,
	atishp@rivosinc.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jinglin Wen <jinglin.wen@shingroup.cn>
Subject: Re: [PATCH 1/3] riscv: Support for early console.
Message-ID: <202404111237.OOIpC9KS-lkp@intel.com>
References: <20240410063432.23058-2-jinglin.wen@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410063432.23058-2-jinglin.wen@shingroup.cn>

Hi Jinglin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus linus/master v6.9-rc3 next-20240410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinglin-Wen/riscv-Support-for-early-console/20240410-143840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240410063432.23058-2-jinglin.wen%40shingroup.cn
patch subject: [PATCH 1/3] riscv: Support for early console.
config: riscv-randconfig-r112-20240411 (https://download.01.org/0day-ci/archive/20240411/202404111237.OOIpC9KS-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8b3b4a92adee40483c27f26c478a384cd69c6f05)
reproduce: (https://download.01.org/0day-ci/archive/20240411/202404111237.OOIpC9KS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404111237.OOIpC9KS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/early_console.c:13:6: sparse: sparse: symbol 'riscv_early_console_putc' was not declared. Should it be static?

vim +/riscv_early_console_putc +13 arch/riscv/kernel/early_console.c

    11	
    12	/* interface for early console output characters */
  > 13	void (*riscv_early_console_putc)(char c);
    14	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

