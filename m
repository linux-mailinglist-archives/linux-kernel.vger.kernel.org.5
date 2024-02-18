Return-Path: <linux-kernel+bounces-70194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C47859495
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112DC1F227B6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5301C4C8B;
	Sun, 18 Feb 2024 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnPF0YzL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B94C61
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 04:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708230226; cv=none; b=rykCdymMnwBAiAQvX4pC4ugab+yVjNLkq7Qt8TiPyKyzu5hv90G1OSjTsFNBq/xR+LF1oOfoovwwmmIci5nwztd4JbuIHCxOxTAKnvriv/FFgx4M8R4baKfEVYffTcViJXA9nFOx7BSt7yESt7GGnbilby10u8PlV44txHN4gXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708230226; c=relaxed/simple;
	bh=lQPZJwW30ZDrcQaquNqEtjfWR7PGTN0XHt32p75COKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MTgRJC9iqhTSlvYj8u9JU/4FVP7twSYYiTZ1bxgigpyq22WGq9CCu1FMvZf6kNq/qzv2LOopudd0kSFhW1O4VNPDWfvdZdPwTjZCIHeGIpwGG3aVtCAtrTHk2vifUuNjnurpgNlJ7jd350rFdol/+MgF8dhFDwGYiN2WMH4GgF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnPF0YzL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708230224; x=1739766224;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lQPZJwW30ZDrcQaquNqEtjfWR7PGTN0XHt32p75COKk=;
  b=TnPF0YzL8HrqHRp83aCbWPQ/jzo7UiVnoLi7bSy7uFESfwfy6SIGJlL3
   5hmFJK9z18DlJLvCU65055RUOksfJ19/32HIIUpfKDu3baRFfpcNFko97
   hIu4gfel2p+TrQQtPyRuMJXfQzH3QsZahT0mxCVn1iytl36h1M3TcruSO
   WcXJC8tw3k6GbyN3KkE2fsKDLwzqEtXhJvB13ZJBj0RLwMDh6V6meSibn
   PnbnTUBPupBgj7WvnXfMUWfLZyOBgp+54GHccxc4Y7/63XgIs20vperBD
   unIwe4N7bfzORPGAVCblmWzyM2I6O3ECYXPZ+RNgJpLMIr5C8S2MD/vKF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="13037931"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="13037931"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 20:23:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="4556238"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 17 Feb 2024 20:23:42 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbYi5-0002lW-27;
	Sun, 18 Feb 2024 04:23:31 +0000
Date: Sun, 18 Feb 2024 12:22:27 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>
Subject: powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data42'
 from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data42'
Message-ID: <202402181204.TyOAQpzb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c02197fc9076e7d991c8f6adc11759c5ba52ddc6
commit: 5431fdd2c181dd2eac218e45b44deb2925fa48f0 ptrace: Convert ptrace_attach() to use lock guards
date:   3 months ago
config: powerpc64-randconfig-r002-20220227 (https://download.01.org/0day-ci/archive/20240218/202402181204.TyOAQpzb-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240218/202402181204.TyOAQpzb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402181204.TyOAQpzb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data42' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data42'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data75' from `kernel/sched/core.o' being placed in section `.bss..Lubsan_data75'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data36' from `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data36'
>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data42' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data42'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data75' from `kernel/sched/core.o' being placed in section `.bss..Lubsan_data75'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data36' from `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data36'
>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data42' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data42'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data75' from `kernel/sched/core.o' being placed in section `.bss..Lubsan_data75'
   powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data36' from `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data36'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

