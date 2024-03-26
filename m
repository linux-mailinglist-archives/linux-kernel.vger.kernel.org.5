Return-Path: <linux-kernel+bounces-119038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B725F88C301
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE5D1C2AB46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5B26FE1A;
	Tue, 26 Mar 2024 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIQZkAEu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF8E7175F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458530; cv=none; b=WhDBPENwdO6esij/gY8ifuJluSO/1FlqN9iJ2AQI71AFAux0bfSoVjeKFhBrGOQLmowz/PG8L0Ddt78n8uSLTsW4jH/MD7tE7MBHX33O5wjADAjDMSPgL6R7cDw6vYPAteX67/yAM0hQ5Z3+YgFRzmpKgGTcct5OWdZ69cnxtpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458530; c=relaxed/simple;
	bh=gt8vaX2b0FKGuEetK4iVG5ZZhrZs610OS2U/uLnwp68=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hy48QueGd8jHVREp2B/QERdTkF2uqIKs+d2gUvTOBefw/dICd3C9cjGgTIWIryP5Ze5YI8XzYfSzbZuOdU6c1rRfkSl5iow6dnI+KRYEeeBeWT9fnPgaYSrt3iUAAxcx2CBJjQL1mE53q0wkw6EBmANklmI9uWelJburXTRsd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIQZkAEu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711458529; x=1742994529;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gt8vaX2b0FKGuEetK4iVG5ZZhrZs610OS2U/uLnwp68=;
  b=SIQZkAEu6XPBOXDzo97JhgQ1TCYVr+yZi0BkB6DiZVjWRmoYDpwES6v6
   Mf3AjWXvLY0AIodnfebZt41N9ukzpPE+31JDa4ldnSz0XHeId6gnCcvPs
   cDR90PbO8Ly6W4wuvQCV8x3qASlj2HuQB/gH2ndJSYk6Eee+r9bfLc3bc
   ciytQe0hZ1Fs2Hw9Ybuy+bbr09szMMd3enFOMzeqmx/RM1LL2j6WRh6p9
   yqtpnBwiIKUxzneMD5y5xz4lW/I5IEa8Jz32MC4Ip/XSBkSfkMSI6EgaK
   LMNq+hxIudHdnxRwlTGDYCKItG5uyd1FQUQOWZysPWDyZTsrbg64ohTyf
   w==;
X-CSE-ConnectionGUID: Ig2TGD3sTEewY+O2v0o0Xg==
X-CSE-MsgGUID: raLN9tR/S3WgNf+y5LB9Ug==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17051039"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17051039"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 06:08:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="53426069"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Mar 2024 06:08:47 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rp6Xk-00003c-2N;
	Tue, 26 Mar 2024 13:08:44 +0000
Date: Tue, 26 Mar 2024 21:08:39 +0800
From: kernel test robot <lkp@intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data253'
 from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data253'
Message-ID: <202403262146.GvXAshxv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   928a87efa42302a23bb9554be081a28058495f22
commit: c1f5204efcbcced83f67f12fa8f1a7f5f244fb87 cpumask: add cpumask_weight_andnot()
date:   8 weeks ago
config: powerpc64-randconfig-r009-20220608 (https://download.01.org/0day-ci/archive/20240326/202403262146.GvXAshxv-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240326/202403262146.GvXAshxv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403262146.GvXAshxv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data253' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data253'
>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data260' from `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data260'
>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data253' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data253'
>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data260' from `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data260'
>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data253' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data253'
>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data260' from `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data260'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

