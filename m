Return-Path: <linux-kernel+bounces-41060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9355E83EAF5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB8C2855C3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4267312E41;
	Sat, 27 Jan 2024 04:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgwlBOwG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4EC125A4
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 04:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706329109; cv=none; b=eOX+eXASpwitXqLCgxhgEnEJq8mfmf0i7Y3jg35x4owUGT3+QPaGqUKFE0yrwWZEEBQfMMOD7BafZ3uJtFjvpLEUuvySW+1POca2EbpAglIc8S4Bam4M61+lggtFjnLp+cL/2EHPtPsqxxGpcGn8LNCmgLea1HnbCqxQ34bRo+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706329109; c=relaxed/simple;
	bh=tBIsmy5hJ3eN9hrKJBBo7iz2CzbuYxcIm+/zu1iNYIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UtV3IZot9eOWoHGouTYlnrAFgsawqhHtKQ4kS3cM8IQqvG6WkmYhREoMdoDfhPYDR5voaVqnr3L7y9nvAYdTIjrHjlCptvVMl7it3S88f6l1lDB522k9Al2d+ld8PlcFYy/lco56gkFv4f3BBNNIT7/TUs+sgjMafwqVLw8Beww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgwlBOwG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706329108; x=1737865108;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tBIsmy5hJ3eN9hrKJBBo7iz2CzbuYxcIm+/zu1iNYIc=;
  b=SgwlBOwGRBDkjdlhDw4DUFzu6Fv0hijS0caRXmrbQyny7bzgffID3rit
   EDU4pl3fzAE95/uHgZduZ1t+4LiB/xCWsv2LrMm8ODPRIv6lrj1/+V5sk
   K9f9bvGeg45DVIXhKlu0pwoUGvxjGlvsSH80NS/hWhZc1mOLTCD/+Z4+K
   sDfO/uohlo6uqSffpQ7WpAc/NGhYyW7FyIoVKkWDxr0Z16TJiL+cxZHYL
   zxwPW6MLX7oYxQ7ZUsZLyoP4TXiUyUXVdveDegeN4BizWATXCxsVUmP58
   klkt8DjlvyuwBsSeRVQVq5hBvWe7bzTc6JfL7d0rCEQ2lqwrrizf8kU6Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="16168036"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="16168036"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 20:18:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="910539092"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="910539092"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2024 20:18:23 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTa97-0001di-1t;
	Sat, 27 Jan 2024 04:18:21 +0000
Date: Sat, 27 Jan 2024 12:17:27 +0800
From: kernel test robot <lkp@intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: <instantiation>:18:15: error: invalid operand for instruction
Message-ID: <202401271242.9fQxbKH3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a5879d495b226d0404098e3564462d5f1daa33b
commit: afc6386815a88d067d9f567dcc6266800286f626 powerpc: merge 32-bit and 64-bit _switch implementation
date:   8 months ago
config: powerpc64-randconfig-001-20240126 (https://download.01.org/0day-ci/archive/20240127/202401271242.9fQxbKH3-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project a31a60074717fc40887cfe132b77eec93bedd307)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240127/202401271242.9fQxbKH3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401271242.9fQxbKH3-lkp@intel.com/

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

