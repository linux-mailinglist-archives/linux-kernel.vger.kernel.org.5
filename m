Return-Path: <linux-kernel+bounces-80305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF896862D22
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF86B20F31
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92351B951;
	Sun, 25 Feb 2024 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zq5XArrv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705EF1B948
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708896353; cv=none; b=CfsDut/UmMhAPScSfbKLBAdk9IXnBnrij2A17Xfi+1ewY8uA7EA96pv0XxkLF2GtMA/qrwGMSYeGOnfq/EiZs5l16FAe9s4ySZIO6YZtqcAisjIPG8ITyeyFNt72ChdYnotI7FEvpGg3lrCwbknoKS3h0b00xQanFbFQGfCmv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708896353; c=relaxed/simple;
	bh=0NhjJB89qwc9JEgWWlZvaFoTsa6L2AfOSvzSLCNvD6U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WuDE7uKNgZ4rHaiUWDmgw3GU2dBxThk7VGa96LFraR5AoQ2AHSmFLj06OvecH3ak33DGR3LdfKG5AXPI5/Hsg1xE1SCwVqANaYJkJZJlzAbRSwpqljqxjqXPlETiU0jD5LIzVvH7qq+dFuBUS8WV1Q+SvfkxtRqyy34h2eCR2L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zq5XArrv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708896352; x=1740432352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0NhjJB89qwc9JEgWWlZvaFoTsa6L2AfOSvzSLCNvD6U=;
  b=Zq5XArrvxyMp95rqwzUwd7P5FAYk4ZaH5rE0g8IvEimTJkMY0JwjNpMU
   +m+hXrglg9tVitbFYucTr0KHpTpCQgxlc2mdwBkF/QJtld19KxPPUOAFD
   tB10VY+z2Iqjk0dlNFXI6Vn1l4eVZgfrje4w83/vthcucUvUdy8Zl7Bk9
   Q79lbhyz0qtEwqhko5laRyf8gNNKP6rxB4YmOOPKP9NlWNmTuq8uadcyh
   y4YFHrKU08y/ytwa5p8baMTxbUfZjkSmgzrkvRW5Z0K4Thb5kIMQXdYlf
   p7HiFwjGVX2qhQPaiVa1r9Qm8z+OEaVAJuMjCUmtA/NiqfVN7ILfEGyQE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3015460"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3015460"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 13:25:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11110898"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 25 Feb 2024 13:25:50 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reM0J-0009nR-1r;
	Sun, 25 Feb 2024 21:25:47 +0000
Date: Mon, 26 Feb 2024 05:25:25 +0800
From: kernel test robot <lkp@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/overlayfs/copy_up.o: warning: objtool: ovl_copy_up_tmpfile()
 falls through to next function ovl_create_index.cold()
Message-ID: <202402260556.0rujs05e-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   70ff1fe626a166dcaadb5a81bfe75e22c91f5dbf
commit: 5b02bfc1e7e3811c5bf7f0fa626a0694d0dbbd77 ovl: do not encode lower fh with upper sb_writers held
date:   4 months ago
config: x86_64-buildonly-randconfig-r001-20230616 (https://download.01.org/0day-ci/archive/20240226/202402260556.0rujs05e-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240226/202402260556.0rujs05e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402260556.0rujs05e-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/overlayfs/copy_up.o: warning: objtool: ovl_copy_up_tmpfile() falls through to next function ovl_create_index.cold()

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

