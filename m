Return-Path: <linux-kernel+bounces-111229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA35886969
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB231F219F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1A320DC5;
	Fri, 22 Mar 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ve5bcYW/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F420B27
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100364; cv=none; b=saKLpUrMS3sZnDDmUeo6LPZ+bpjJvBgap4SzRW0jSjikR9LKe3q6fQBpTzR3b1E5men6hdZowVobPtFkAczgHW3h/0J6XheqLyPONH3o/k7W38KgA5MBXO2YKDU1iUlURUGhbXa0eZgtdstZ69z6/sSRlQQKvA0k8a655m60oGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100364; c=relaxed/simple;
	bh=V8aM6OCgOcvm5zmKYZ0GdgRjywxe/nP0WYMbHQYGD0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ApCX1Ykkni4jlj8JxgOvqaOcdXXcuzjP/FXfGIETgb1FCqvNwK9gzQiCggKOiOQ9cUHo6Ko4w2WNX8lqApHy+JDhjBbG8SnoswFaK9EKL2dg0mECXPujV/ex0An9Ov1mRlZyTZdrUZLo+OdaIClomb13fY0yEIbyB1AZsYKkxA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ve5bcYW/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711100361; x=1742636361;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V8aM6OCgOcvm5zmKYZ0GdgRjywxe/nP0WYMbHQYGD0Q=;
  b=Ve5bcYW/yb7jPdw7GFG++bBnpv0C7GncCQCbIbiOeTQPlxXTINSQ3XMn
   CK8GfDC2wbiz0ugiy3O/+Xm94pdZEyiGSgD5on72Bb8wRnjnXixFri58j
   tOBsdeGBTVX2RfeXwiuk10Ls3BJE5qIyEFvS3sRxTb8CfnTzSzC3xpXUl
   6D7TOOI40tJxK9Sy0D18D9yuzmapN1G9QKt1S5ltR/pC8dcQchP3Un1DW
   KikNdZmOYf7Cxld4S/q/5AUtAxWMg7kepi1vijiqhnae4cEWE7kO+O0rz
   GBUNNLFceLuuDWQ2FNeiGjVO3N9I9vhL/n0UMISQ5rWyawHn/6oAYn6Ag
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6255465"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6255465"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 02:39:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="19549801"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 22 Mar 2024 02:39:19 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnbMq-000KCs-0W;
	Fri, 22 Mar 2024 09:39:16 +0000
Date: Fri, 22 Mar 2024 17:38:23 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>
Subject: powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data325'
 from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data325'
Message-ID: <202403221741.UKuCKo72-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8e938e39866920ddc266898e6ae1fffc5c8f51aa
commit: 5431fdd2c181dd2eac218e45b44deb2925fa48f0 ptrace: Convert ptrace_attach() to use lock guards
date:   4 months ago
config: powerpc-randconfig-r013-20211210 (https://download.01.org/0day-ci/archive/20240322/202403221741.UKuCKo72-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240322/202403221741.UKuCKo72-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403221741.UKuCKo72-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data325' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data325'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data325' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data325'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data325' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data325'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

