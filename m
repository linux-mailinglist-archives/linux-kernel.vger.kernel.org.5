Return-Path: <linux-kernel+bounces-72452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D0185B3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812881F23C51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A475A109;
	Tue, 20 Feb 2024 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wo3wzRZB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10805A0EC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412860; cv=none; b=WXFWOwjq5xrVoo2oskul4XvzS9/vvOIFmI3wEP3opmACGxkzDwNnXmh1BMGm++e40UxlAYnUbDbgj/c9wMh/+cEwapqlDdjcQnZbAr2YNzNRjSYunYlU60aDCRAEJRQ3GBN1Z6NnkbTs9fyAwJREYFqN/iItfmGb0nAvMV1buWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412860; c=relaxed/simple;
	bh=eFwrMZYBaKC0PtuKqGOOAfW+iaAOQo8Z2d/tXJG/FRo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UlPGgsOZonrHGGDRWAndyJfPdRfNj9jgqFdCtBiLlrVRrbUb1gyt/JsU9GSjAsYEmAioG7IJbG1MuOeqWbHte4ZV/v0OAG4UKptnVZMWDJ0s2LtuoKee4CaeZpS2m3R/6tZkP7dUnRkVuEa6OA/pYr93Rj0d40D0OpzmAmCID4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wo3wzRZB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708412858; x=1739948858;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eFwrMZYBaKC0PtuKqGOOAfW+iaAOQo8Z2d/tXJG/FRo=;
  b=Wo3wzRZBsWB6OedgLQDlfXVWVteERHThyZnfBewO1Oy6hCrUcijmym++
   UmxeZ8FwB44m2riB48XETbUOIiEqzhNLJsp7EoQtDPk5xDpAoi9gT+UNx
   bjm15n5rjXiaPmT6k5qPRxba/upl5GOVfw/kQgQEJoDZDez1kzpLF3WWk
   CuLs7V63OMqEH0ONOCYL+HwMMzgBTEWJpjxTn704Hqwz6JVPQDFllsO94
   ejG7kmyNqHJbhh9TS+ky/xvWAzO7pzjhIxkBhdhm/BRlCvJfDBtiAaHzN
   H8lyIm+jx9OzXyRoLQVuoxnhmdHXAZgjwaNugRF62HTHk3ZNSWmhaKkMB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13913872"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13913872"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 23:07:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="827116919"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="827116919"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2024 23:07:36 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcKE1-0004Ig-1E;
	Tue, 20 Feb 2024 07:07:33 +0000
Date: Tue, 20 Feb 2024 15:07:23 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 tracing_gen_ctx+0x64 (section: .text.unlikely) -> initcall_level_names
 (section: .init.data)
Message-ID: <202402201428.BGNv6253-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b401b621758e46812da61fa58a67c3fd8d91de0d
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   7 months ago
config: xtensa-buildonly-randconfig-r002-20230515 (https://download.01.org/0day-ci/archive/20240220/202402201428.BGNv6253-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240220/202402201428.BGNv6253-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402201428.BGNv6253-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x78 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: tracing_gen_ctx+0x64 (section: .text.unlikely) -> initcall_level_names (section: .init.data)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

