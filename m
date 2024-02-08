Return-Path: <linux-kernel+bounces-57564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D880384DAC6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CC31C20A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B87D69D0D;
	Thu,  8 Feb 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7WBWboF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451866930E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707377974; cv=none; b=IT8AGz9qJqCZyP9478slH+Qy2g5eIb/LC0MZN0A/zyDbUh6afVUb+T2c37NJJCB0eeIQizuNJOsaMSZ/0RSvwcmbtdqlD8wc+12yBa9g6NR2yq+g6FEX8z4aE1pRRrKnDC3WncK0rRpBXRFGHQjo9pQ7N9/uCSDNrGkPeDcSzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707377974; c=relaxed/simple;
	bh=0dlhmOrAsjot9hqzrREwQEhMHkM8Iw4JOs3yaHEvtPI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SBNA6Kzt4sSHkvfwzkM6geTPkzG6+cPTj/4EKh8KqHmzR1Iqidy76B9WzuP+iYfSTO2zAdoAjXAZvcUz7lkpdjw3thDTkSYUROpFM0wFOu6KdkM6reMSExUAvdULZmdCb09w2O9EAOzWcB/XwFVRJIfL5+4j6ZexlyHydXv4WZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7WBWboF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707377973; x=1738913973;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0dlhmOrAsjot9hqzrREwQEhMHkM8Iw4JOs3yaHEvtPI=;
  b=A7WBWboFpC54ksmQehMLMKRggHau8spUJvBiAGlYo7JHDDHK4Al/TxnB
   CdBvmghi7PBwQMrgp3wTAb7hr+CISvygm7Udb9fqBF1SuykD2GV4dt3bL
   uSMj6eMKzOe1N3aSM9X+gsgny4PQ35bMwZgkXUbC3/lWE1M7W/kZ2QMSo
   hjfbTLMUkt57PX/XXt1/zEy36Yqx8NUasgr3YUvQnWxqN8IaUypKQySvf
   tysdsIsLrjqkezB5qloBRky2kb9pplBraYw4jzjklcSbG3o/M8ItRyeLx
   icEwDAgekemenLHQye5+lgNsbwylDA2HARoKFCN0GDkkrE5FeBwedKns7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="23643111"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="23643111"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:39:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="6237225"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Feb 2024 23:39:31 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXz0L-0003Ua-0Z;
	Thu, 08 Feb 2024 07:39:29 +0000
Date: Thu, 8 Feb 2024 15:39:21 +0800
From: kernel test robot <lkp@intel.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function
 kallsyms_sym_address: .text+0x10): relocation R_RISCV_PCREL_HI20 out of
 range: -524416 is not in [-524288, 524287]; references
 kallsyms_relative_base
Message-ID: <202402081521.N9jn64eP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Zhen,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   547ab8fc4cb04a1a6b34377dd8fad34cd2c8a8e3
commit: 30f3bb09778de64ef9f23fb4bb5f868c4728a071 kallsyms: Add self-test facility
date:   1 year, 3 months ago
config: riscv-randconfig-r064-20240120 (https://download.01.org/0day-ci/archive/20240208/202402081521.N9jn64eP-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240208/202402081521.N9jn64eP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402081521.N9jn64eP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_sym_address: .text+0x10): relocation R_RISCV_PCREL_HI20 out of range: -524416 is not in [-524288, 524287]; references kallsyms_relative_base
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_sym_address: .text+0x20): relocation R_RISCV_PCREL_HI20 out of range: -524416 is not in [-524288, 524287]; references kallsyms_offsets
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

