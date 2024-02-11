Return-Path: <linux-kernel+bounces-60717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705D88508D9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D81B22816
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7EC5A783;
	Sun, 11 Feb 2024 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIrvIQOF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F305A4E9
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707650821; cv=none; b=jylJQhlMCMZsUb7zD8kPdE39i0h5bZ2XVzLrzh3bJHirwTZ7BpxPbNy9sb25Sx+cMTMbjiwIRnt1HxKkIY6vxxeqGw9xJhW3ZvZBhWDoZlpRRANYYcveFQfbc6uN8F2k3mggm0ljypD1kCNrGpvnREVU+z4blejtRJpFLEFYj14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707650821; c=relaxed/simple;
	bh=Xa7DicIBQgWfNBg/mewkVAjHuzg7xZ8Uso9Lm4M+6gY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G4vgnVvB2p2fqQz7HB4Vf8gcbrNlgU5JophyXt649nkq9flZ9zl7aUD1iEpjHK7hCh9NhmJdUvcoqG3/Gg1kEk0/eeOQRoUEHRJoe3gfldCJ3N91RDEtf5z4FJzYFHkNJBK3tL4J+Fr1JU3AYrnGL7DoLJ0/gnuOdRBCq4rsj4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIrvIQOF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707650818; x=1739186818;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xa7DicIBQgWfNBg/mewkVAjHuzg7xZ8Uso9Lm4M+6gY=;
  b=hIrvIQOF38bKf0Nl9Wsyrfe6qhAnRXZnJw6puCBZCXqIIh+I85kJyhUU
   3adADfF2kbH39XdSt1jRVEwfmUxXS9Sjp/E1l8MdX4b9YLhxdyE1IJLQx
   lINVkK/wFVZ2Yr33caPsKNm5zDfMXWPf21HRx6MqT6WzWevQS694ZL1PI
   iLPstbrCOLwrhj/IDnAjtI4bJ5VHEKFXaKwatsaXo3/Y9VI+cN9YYWrxX
   xfmJ38q+zjWPQ9aJ1wDyjXRFhvb0EQqv4mS0cxOaxovn8CRS776Db9BAT
   Nw3Qw8YyVQYglxkM32J+TFy6V5tzIhIbiinhvA5WqI+v6eqFUOUCfCUei
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="1503485"
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="1503485"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 03:26:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="33419878"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2024 03:26:56 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZ7z3-0006X3-2v;
	Sun, 11 Feb 2024 11:26:53 +0000
Date: Sun, 11 Feb 2024 19:26:43 +0800
From: kernel test robot <lkp@intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: <instantiation>:18:15: error: invalid operand for instruction
Message-ID: <202402111924.EpGyikCn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicholas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7521f258ea303c827434c101884b62a2b137a942
commit: afc6386815a88d067d9f567dcc6266800286f626 powerpc: merge 32-bit and 64-bit _switch implementation
date:   8 months ago
config: powerpc64-randconfig-001-20240211 (https://download.01.org/0day-ci/archive/20240211/202402111924.EpGyikCn-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project c08b90c50bcac9f3f563c79491c8dbcbe7c3b574)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240211/202402111924.EpGyikCn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402111924.EpGyikCn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> <instantiation>:18:15: error: invalid operand for instruction
    addi %r7,%r7,(1 << (15 + 1))-432
                 ^
   arch/powerpc/kernel/switch.S:249:2: note: while in macro instantiation
    do_switch_64
    ^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

