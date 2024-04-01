Return-Path: <linux-kernel+bounces-126648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80091893AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCB7281A09
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B03716F;
	Mon,  1 Apr 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbe5JFy4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F9E28DC0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711974250; cv=none; b=RY3Tt7Ya3nQRLB35Q5YzkPsHfYM1D7CrZ9NMHH6ltzE0iok4ro8+HCUkhRh7GIauJaOVepUGKG0RwEkKNv7MJMKrOU6R2XX6nhDe0X8I6O8leia2tuAPR6Z0Mbt9RqHfIeDZ9jFdYiIthCMVAwUB1RC9VGb6H27bHLCXCwrq/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711974250; c=relaxed/simple;
	bh=spJ9RMVRv0rFwfAZFjfUbN/DezHPiJgk650X8Hq4PQk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kQJLWyS0Pbnu86GHgRespKSRhYwrcB2tKAqv4vkPGBfUnDTtCukUNrCgCCcQjbuhPyMMXr3/NGcLt+9qIYmk8Thm9z5vAWqtZ1h94dGppUEwYGPH8/SwHLo0/3GRilHrHcbbcO03e2U8A0zC/wlf75r9bi3YV1qATVNAwzgVZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbe5JFy4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711974248; x=1743510248;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=spJ9RMVRv0rFwfAZFjfUbN/DezHPiJgk650X8Hq4PQk=;
  b=cbe5JFy4zUwnmchcrBdi0zj4oBeTiUIv062bhXgvulCJFSY9hJRJWxuR
   c7NcBne1jIMLLXx+QdwSB6vqmot8DXEDL/Y6691Wy0u03yxBKwICIZGpZ
   htZ9nO8LbH6S7SibGb8mEn/nu3myBEb31DKCnTlEFgAS+1NrUYH1v45uK
   LhPxY0piN4ID0twbbBMx1RPC1VkXYZFvp7+1byyXkOFcojxtbfh16Hv2P
   6Altdm15ow8GaCSbl2uhJzUIp6mC3az/Wp+lRhtOxcWQTX0hYIGq2+Yju
   0CAgIoDHM601nz2ON5Gsq/ZFWODk58cTyaSCFOTCmfZyBmW40zHM/ooIa
   g==;
X-CSE-ConnectionGUID: Xz1TvRftS9GxfLWeTG+RIQ==
X-CSE-MsgGUID: NdssrXcvQKC3+ShZ7yuUkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="10055454"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="10055454"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 05:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17525456"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 01 Apr 2024 05:24:05 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrGhn-0000IF-1N;
	Mon, 01 Apr 2024 12:24:03 +0000
Date: Mon, 1 Apr 2024 20:23:42 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/loongarch/kernel/signal.c:370:47: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202404012046.TImS0QcF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   39cd87c4eb2b893354f3b850f916353f2658ae6f
commit: 616500232e632dba8b03981eeccadacf2fbf1c30 LoongArch: Add vector extensions support
date:   9 months ago
config: loongarch-randconfig-r034-20230511 (https://download.01.org/0day-ci/archive/20240401/202404012046.TImS0QcF-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240401/202404012046.TImS0QcF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404012046.TImS0QcF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/loongarch/kernel/signal.c:94:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:94:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:94:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:94:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:114:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:114:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:114:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:114:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:132:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:132:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:132:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:132:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:153:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:153:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:153:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:153:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:173:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:173:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:173:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:173:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:198:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:198:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:198:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:198:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:223:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:223:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:223:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:223:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:232:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:232:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:232:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:232:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:241:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:241:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:241:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:241:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:250:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:250:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:250:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:250:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:259:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:259:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:259:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:259:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:268:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:268:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:268:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:268:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:300:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info *addr @@
   arch/loongarch/kernel/signal.c:300:52: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:300:52: sparse:     got struct sctx_info *addr
   arch/loongarch/kernel/signal.c:301:92: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sctx_info *info @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:301:92: sparse:     expected struct sctx_info *info
   arch/loongarch/kernel/signal.c:301:92: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:301:47: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:301:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fpu_context [noderef] __user *fpu_ctx @@     got struct fpu_context * @@
   arch/loongarch/kernel/signal.c:301:47: sparse:     expected struct fpu_context [noderef] __user *fpu_ctx
   arch/loongarch/kernel/signal.c:301:47: sparse:     got struct fpu_context *
   arch/loongarch/kernel/signal.c:302:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:302:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:302:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:302:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:334:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info *addr @@
   arch/loongarch/kernel/signal.c:334:52: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:334:52: sparse:     got struct sctx_info *addr
   arch/loongarch/kernel/signal.c:335:92: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sctx_info *info @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:335:92: sparse:     expected struct sctx_info *info
   arch/loongarch/kernel/signal.c:335:92: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:335:47: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:335:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fpu_context [noderef] __user *fpu_ctx @@     got struct fpu_context * @@
   arch/loongarch/kernel/signal.c:335:47: sparse:     expected struct fpu_context [noderef] __user *fpu_ctx
   arch/loongarch/kernel/signal.c:335:47: sparse:     got struct fpu_context *
   arch/loongarch/kernel/signal.c:336:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:336:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:336:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:336:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:369:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info *addr @@
   arch/loongarch/kernel/signal.c:369:52: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:369:52: sparse:     got struct sctx_info *addr
   arch/loongarch/kernel/signal.c:370:92: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sctx_info *info @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:370:92: sparse:     expected struct sctx_info *info
   arch/loongarch/kernel/signal.c:370:92: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:370:47: sparse: sparse: cast removes address space '__user' of expression
>> arch/loongarch/kernel/signal.c:370:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct lsx_context [noderef] __user *lsx_ctx @@     got struct lsx_context * @@
   arch/loongarch/kernel/signal.c:370:47: sparse:     expected struct lsx_context [noderef] __user *lsx_ctx
   arch/loongarch/kernel/signal.c:370:47: sparse:     got struct lsx_context *
   arch/loongarch/kernel/signal.c:371:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:371:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:371:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:371:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:406:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info *addr @@
   arch/loongarch/kernel/signal.c:406:52: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:406:52: sparse:     got struct sctx_info *addr
   arch/loongarch/kernel/signal.c:407:92: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sctx_info *info @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:407:92: sparse:     expected struct sctx_info *info
   arch/loongarch/kernel/signal.c:407:92: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:407:47: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:407:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct lsx_context [noderef] __user *lsx_ctx @@     got struct lsx_context * @@
   arch/loongarch/kernel/signal.c:407:47: sparse:     expected struct lsx_context [noderef] __user *lsx_ctx
   arch/loongarch/kernel/signal.c:407:47: sparse:     got struct lsx_context *
   arch/loongarch/kernel/signal.c:408:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:408:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:408:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:408:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:444:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info *addr @@
   arch/loongarch/kernel/signal.c:444:53: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:444:53: sparse:     got struct sctx_info *addr
   arch/loongarch/kernel/signal.c:446:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sctx_info *info @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:446:64: sparse:     expected struct sctx_info *info
   arch/loongarch/kernel/signal.c:446:64: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:446:18: sparse: sparse: cast removes address space '__user' of expression
>> arch/loongarch/kernel/signal.c:446:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct lasx_context [noderef] __user *lasx_ctx @@     got struct lasx_context * @@
   arch/loongarch/kernel/signal.c:446:18: sparse:     expected struct lasx_context [noderef] __user *lasx_ctx
   arch/loongarch/kernel/signal.c:446:18: sparse:     got struct lasx_context *
   arch/loongarch/kernel/signal.c:447:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:447:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:447:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:447:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:484:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info *addr @@
   arch/loongarch/kernel/signal.c:484:53: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:484:53: sparse:     got struct sctx_info *addr
   arch/loongarch/kernel/signal.c:486:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sctx_info *info @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:486:64: sparse:     expected struct sctx_info *info
   arch/loongarch/kernel/signal.c:486:64: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:486:18: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:486:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct lasx_context [noderef] __user *lasx_ctx @@     got struct lasx_context * @@
   arch/loongarch/kernel/signal.c:486:18: sparse:     expected struct lasx_context [noderef] __user *lasx_ctx
   arch/loongarch/kernel/signal.c:486:18: sparse:     got struct lasx_context *
   arch/loongarch/kernel/signal.c:487:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:487:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:487:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:487:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:543:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info * @@
   arch/loongarch/kernel/signal.c:543:14: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:543:14: sparse:     got struct sctx_info *
   arch/loongarch/kernel/signal.c:570:42: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sctx_info *addr @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:570:42: sparse:     expected struct sctx_info *addr
   arch/loongarch/kernel/signal.c:570:42: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:577:42: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sctx_info *addr @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:577:42: sparse:     expected struct sctx_info *addr
   arch/loongarch/kernel/signal.c:577:42: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:584:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sctx_info *addr @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:584:43: sparse:     expected struct sctx_info *addr
   arch/loongarch/kernel/signal.c:584:43: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:591:46: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:591:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info * @@
   arch/loongarch/kernel/signal.c:591:22: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:591:22: sparse:     got struct sctx_info *
   arch/loongarch/kernel/signal.c:737:17: sparse: sparse: symbol 'sys_rt_sigreturn' was not declared. Should it be static?
   arch/loongarch/kernel/signal.c: note: in included file:
   arch/loongarch/include/asm/fpu.h:72:17: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_w'
   arch/loongarch/include/asm/fpu.h:72:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:72:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:81:17: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_w'
   arch/loongarch/include/asm/fpu.h:81:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:72:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:81:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:72:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:72:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:81:17: sparse: sparse: cast from unknown type
   arch/loongarch/kernel/signal.c: note: in included file (through arch/loongarch/include/asm/cpu-info.h, arch/loongarch/include/asm/processor.h, ...):
   arch/loongarch/include/asm/loongarch.h:1281:1: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_w'
   arch/loongarch/include/asm/loongarch.h:1281:1: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:1281:1: sparse: sparse: undefined identifier '__builtin_loongarch_csrwr_w'
   arch/loongarch/include/asm/loongarch.h:1281:1: sparse: sparse: cast from unknown type
   arch/loongarch/kernel/signal.c: note: in included file:
   arch/loongarch/include/asm/fpu.h:81:17: sparse: sparse: cast from unknown type
   arch/loongarch/kernel/signal.c: note: in included file (through arch/loongarch/include/asm/cpu-info.h, arch/loongarch/include/asm/processor.h, ...):
   arch/loongarch/include/asm/loongarch.h:1281:1: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:1281:1: sparse: sparse: cast from unknown type

vim +370 arch/loongarch/kernel/signal.c

   330	
   331	static int protected_restore_fpu_context(struct extctx_layout *extctx)
   332	{
   333		int err = 0, sig = 0, tmp __maybe_unused;
   334		struct sctx_info __user *info = extctx->fpu.addr;
   335		struct fpu_context __user *fpu_ctx = (struct fpu_context *)get_ctx_through_ctxinfo(info);
 > 336		uint64_t __user *regs	= (uint64_t *)&fpu_ctx->regs;
   337		uint64_t __user *fcc	= &fpu_ctx->fcc;
   338		uint32_t __user *fcsr	= &fpu_ctx->fcsr;
   339	
   340		err = sig = fcsr_pending(fcsr);
   341		if (err < 0)
   342			return err;
   343	
   344		while (1) {
   345			lock_fpu_owner();
   346			if (is_fpu_owner())
   347				err = restore_hw_fpu_context(fpu_ctx);
   348			else
   349				err = copy_fpu_from_sigcontext(fpu_ctx);
   350			unlock_fpu_owner();
   351	
   352			if (likely(!err))
   353				break;
   354			/* Touch the FPU context and try again */
   355			err = __get_user(tmp, &regs[0]) |
   356				__get_user(tmp, &regs[31]) |
   357				__get_user(tmp, fcc) |
   358				__get_user(tmp, fcsr);
   359			if (err)
   360				break;	/* really bad sigcontext */
   361		}
   362	
   363		return err ?: sig;
   364	}
   365	
   366	static int protected_save_lsx_context(struct extctx_layout *extctx)
   367	{
   368		int err = 0;
   369		struct sctx_info __user *info = extctx->lsx.addr;
 > 370		struct lsx_context __user *lsx_ctx = (struct lsx_context *)get_ctx_through_ctxinfo(info);
   371		uint64_t __user *regs	= (uint64_t *)&lsx_ctx->regs;
   372		uint64_t __user *fcc	= &lsx_ctx->fcc;
   373		uint32_t __user *fcsr	= &lsx_ctx->fcsr;
   374	
   375		while (1) {
   376			lock_fpu_owner();
   377			if (is_lsx_enabled())
   378				err = save_hw_lsx_context(lsx_ctx);
   379			else {
   380				if (is_fpu_owner())
   381					save_fp(current);
   382				err = copy_lsx_to_sigcontext(lsx_ctx);
   383			}
   384			unlock_fpu_owner();
   385	
   386			err |= __put_user(LSX_CTX_MAGIC, &info->magic);
   387			err |= __put_user(extctx->lsx.size, &info->size);
   388	
   389			if (likely(!err))
   390				break;
   391			/* Touch the LSX context and try again */
   392			err = __put_user(0, &regs[0]) |
   393				__put_user(0, &regs[32*2-1]) |
   394				__put_user(0, fcc) |
   395				__put_user(0, fcsr);
   396			if (err)
   397				return err;	/* really bad sigcontext */
   398		}
   399	
   400		return err;
   401	}
   402	
   403	static int protected_restore_lsx_context(struct extctx_layout *extctx)
   404	{
   405		int err = 0, sig = 0, tmp __maybe_unused;
   406		struct sctx_info __user *info = extctx->lsx.addr;
   407		struct lsx_context __user *lsx_ctx = (struct lsx_context *)get_ctx_through_ctxinfo(info);
 > 408		uint64_t __user *regs	= (uint64_t *)&lsx_ctx->regs;
   409		uint64_t __user *fcc	= &lsx_ctx->fcc;
   410		uint32_t __user *fcsr	= &lsx_ctx->fcsr;
   411	
   412		err = sig = fcsr_pending(fcsr);
   413		if (err < 0)
   414			return err;
   415	
   416		while (1) {
   417			lock_fpu_owner();
   418			if (is_lsx_enabled())
   419				err = restore_hw_lsx_context(lsx_ctx);
   420			else {
   421				err = copy_lsx_from_sigcontext(lsx_ctx);
   422				if (is_fpu_owner())
   423					restore_fp(current);
   424			}
   425			unlock_fpu_owner();
   426	
   427			if (likely(!err))
   428				break;
   429			/* Touch the LSX context and try again */
   430			err = __get_user(tmp, &regs[0]) |
   431				__get_user(tmp, &regs[32*2-1]) |
   432				__get_user(tmp, fcc) |
   433				__get_user(tmp, fcsr);
   434			if (err)
   435				break;	/* really bad sigcontext */
   436		}
   437	
   438		return err ?: sig;
   439	}
   440	
   441	static int protected_save_lasx_context(struct extctx_layout *extctx)
   442	{
   443		int err = 0;
   444		struct sctx_info __user *info = extctx->lasx.addr;
   445		struct lasx_context __user *lasx_ctx =
 > 446			(struct lasx_context *)get_ctx_through_ctxinfo(info);
   447		uint64_t __user *regs	= (uint64_t *)&lasx_ctx->regs;
   448		uint64_t __user *fcc	= &lasx_ctx->fcc;
   449		uint32_t __user *fcsr	= &lasx_ctx->fcsr;
   450	
   451		while (1) {
   452			lock_fpu_owner();
   453			if (is_lasx_enabled())
   454				err = save_hw_lasx_context(lasx_ctx);
   455			else {
   456				if (is_lsx_enabled())
   457					save_lsx(current);
   458				else if (is_fpu_owner())
   459					save_fp(current);
   460				err = copy_lasx_to_sigcontext(lasx_ctx);
   461			}
   462			unlock_fpu_owner();
   463	
   464			err |= __put_user(LASX_CTX_MAGIC, &info->magic);
   465			err |= __put_user(extctx->lasx.size, &info->size);
   466	
   467			if (likely(!err))
   468				break;
   469			/* Touch the LASX context and try again */
   470			err = __put_user(0, &regs[0]) |
   471				__put_user(0, &regs[32*4-1]) |
   472				__put_user(0, fcc) |
   473				__put_user(0, fcsr);
   474			if (err)
   475				return err;	/* really bad sigcontext */
   476		}
   477	
   478		return err;
   479	}
   480	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

