Return-Path: <linux-kernel+bounces-33005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ABC83631F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7E11C22C17
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B453CF42;
	Mon, 22 Jan 2024 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKWZG3ay"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E53E473
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926057; cv=none; b=awgbD+ozS0JYx8Pt4FZg7HTtOrSXUNRyTmzQcneMEFXEjd/fFnoe21GH2jeNt73rrtBpDG0Mh1BchdMRtjfEryZHJxe/Ra/sSNNlkkFFx6KrzukuNuo0e7Hokpf0tXFHE3WdhBsQ2iSQkBPC38AYlYYYmA+aRuiggEe8TzYQdS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926057; c=relaxed/simple;
	bh=xC7n5NC9SALvj1NmFHUYUAbKPwq4iRoDMR2D5nFzGzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LvSIAm74S8pd6oabxWPuCVf+F2YkqXFLGZBwzURaViZoSm2RMTo+EcngWuQmdXqK+K/ooabon2KyLoAocO2JhFIt63SMpuk0h3cKqjgFyBy+jdV/1K6RuxdGSvnutSway4T4DOgLVZ7xu7ugPqYyu1bK+sDh7f6RcXkLIVsqxz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKWZG3ay; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705926055; x=1737462055;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xC7n5NC9SALvj1NmFHUYUAbKPwq4iRoDMR2D5nFzGzM=;
  b=eKWZG3ayFb38u/yGUNFcQU3QHSwDUrxj7X0C926s9xbRiJjRywKnAsKD
   3rDsXN+SISgYSDS3VyGxGZYE3eIRHv0oiqi1QVurpOOh5pfJa2tRQLTlX
   fj4lQ7/bWopHMx8sSSdanocXCxSFvi8HCcETXocXax1h+1T0rrEW3JOne
   r18yDrVSRIKM04pf28idMpGKhpCJKCNuDUTo/xfpNS/Ekf1kysh9Su6mQ
   jnxNKW3lhInOuWVLDDcWUebi96NgjmCn7yEaif2alJ0C4OhDZNw6Suf/f
   xAsTHQShteZjbsQLvsfFeZTZGly+YK1loXeTIr/tsTCBbWKzcsCkPGYIc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="8582558"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="8582558"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:20:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="27339380"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 22 Jan 2024 04:20:53 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rRtII-0006bO-20;
	Mon, 22 Jan 2024 12:20:50 +0000
Date: Mon, 22 Jan 2024 20:20:25 +0800
From: kernel test robot <lkp@intel.com>
To: Helge Deller <deller@gmx.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/parisc/kernel/drivers.c:745:19-20: Unneeded semicolon
Message-ID: <202401222059.Wli6OGT0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6613476e225e090cc9aad49be7fa504e290dd33d
commit: ac9fb7d2b71d8353603534a5e5cc92f54fd7e219 parisc: drivers: Fix kdoc warnings
date:   7 months ago
config: parisc-randconfig-r062-20240122 (https://download.01.org/0day-ci/archive/20240122/202401222059.Wli6OGT0-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401222059.Wli6OGT0-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> arch/parisc/kernel/drivers.c:745:19-20: Unneeded semicolon

vim +745 arch/parisc/kernel/drivers.c

   720	
   721	/**
   722	 * parse_tree_node - returns a device entry in the iotree
   723	 * @parent: the parent node in the tree
   724	 * @index: the current BC index
   725	 * @modpath: the hardware_path struct to match a device against
   726	 * @return: The corresponding device if found, NULL otherwise.
   727	 *
   728	 * Checks all the children of @parent for a matching @id.  If none
   729	 * found, it returns NULL.
   730	 */
   731	static struct device *
   732	parse_tree_node(struct device *parent, int index, struct hardware_path *modpath)
   733	{
   734		struct parse_tree_data d = {
   735			.index          = index,
   736			.modpath        = modpath,
   737		};
   738	
   739		struct recurse_struct recurse_data = {
   740			.obj	= &d,
   741			.fn	= check_parent,
   742		};
   743	
   744		if (device_for_each_child(parent, &recurse_data, descend_children))
 > 745			{ /* nothing */ };
   746	
   747		return d.dev;
   748	}
   749	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

