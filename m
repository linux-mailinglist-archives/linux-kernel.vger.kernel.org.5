Return-Path: <linux-kernel+bounces-29770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB3A831331
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2681C2280C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BE9BA45;
	Thu, 18 Jan 2024 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxXESg8B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3021170E;
	Thu, 18 Jan 2024 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563517; cv=none; b=F9r15m2GBbkG60CveWYomlK2FV6/CzWJtHZhKy8BuIO6UgWSyKXC9eZtuTI8YCSyIh31POiZ/lVUIt0I7rYPJ2TPBuXmLuYvDbCSm28EThYdtEHjyoXQj7X78pi+w8xs9JkjaefFaSTWBANsSICRP8PgDcr+6sddHddYiDFnC5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563517; c=relaxed/simple;
	bh=oEgWvrslnSM4xcNArZv/SqPbZt3JAcjMLGKjSG+iUmE=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=EZYMPHClcAG3wkAmArd9SVYzw4lAcqR7QxNaJ1QRkOVfJpcktiH25ZQYcwPI0StA66pJoMATf5WzeURSr/OsD5Gcr7f+iCCNfMUYP6NiSpPQWAK3fEraCfxtxDaiVHBMDA1JB+BYha2euqcrd+9Jw8tPoZE2nS+dwb9QbMYTKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxXESg8B; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705563514; x=1737099514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oEgWvrslnSM4xcNArZv/SqPbZt3JAcjMLGKjSG+iUmE=;
  b=IxXESg8BmHMpx/WhHtu6W4851LTiCNa01HjFqtr7xI9oIsPioPUk5pRU
   FncgXN1HZxliTYp+Amh9rX6iRHvw+hV+TRU4jD0zNFxtFhGtL16POWqBg
   MWZiM3KROZRshD9yI3YeT39NSRUd4OAD3WRMj4PdOwiNXHlV7zauEz0VK
   9qJCv1m68pvcl4fr6gfo6YVvhJkCMh1mk819TOcbRPpes5WN1dQHxKIei
   9caiM6EfsPLxQ9GxtD1qD2zcCLYGgWxhoduMHH69b5tPwQVW+LhhBka8+
   aEc29JN+6kuD6zNkvGc8H+gUUovMyGXJiCwBFrF1Q6zZsyBz54LB/xyWr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7744986"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7744986"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 23:38:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="329433"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Jan 2024 23:38:30 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQMyp-0002lY-0Q;
	Thu, 18 Jan 2024 07:38:27 +0000
Date: Thu, 18 Jan 2024 15:37:55 +0800
From: kernel test robot <lkp@intel.com>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Message-ID: <202401181522.bvg4EMU4-lkp@intel.com>
References: <20240115135249.296822-5-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115135249.296822-5-arnaud.pouliquen@foss.st.com>

Hi Arnaud,

kernel test robot noticed the following build errors:

[auto build test ERROR on remoteproc/rproc-next]
[also build test ERROR on linus/master v6.7 next-20240117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/remoteproc-Add-TEE-support/20240115-215613
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
patch link:    https://lore.kernel.org/r/20240115135249.296822-5-arnaud.pouliquen%40foss.st.com
patch subject: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
config: arm64-randconfig-r081-20240118 (https://download.01.org/0day-ci/archive/20240118/202401181522.bvg4EMU4-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240118/202401181522.bvg4EMU4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401181522.bvg4EMU4-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rproc_load_fw':
>> tee_remoteproc.c:(.text+0x138): undefined reference to `tee_shm_register_kernel_buf'
>> tee_remoteproc.c:(.text+0x138): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `tee_shm_register_kernel_buf'
>> aarch64-linux-ld: tee_remoteproc.c:(.text+0x18c): undefined reference to `tee_client_invoke_func'
>> tee_remoteproc.c:(.text+0x18c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `tee_client_invoke_func'
>> aarch64-linux-ld: tee_remoteproc.c:(.text+0x1ac): undefined reference to `tee_shm_free'
>> tee_remoteproc.c:(.text+0x1ac): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `tee_shm_free'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rproc_start':
>> tee_remoteproc.c:(.text+0x240): undefined reference to `tee_client_invoke_func'
   tee_remoteproc.c:(.text+0x240): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `tee_client_invoke_func'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `rproc_tee_get_rsc_table':
   tee_remoteproc.c:(.text+0x2dc): undefined reference to `tee_client_invoke_func'
   tee_remoteproc.c:(.text+0x2dc): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `tee_client_invoke_func'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rproc_stop':
   tee_remoteproc.c:(.text+0x408): undefined reference to `tee_client_invoke_func'
   tee_remoteproc.c:(.text+0x408): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `tee_client_invoke_func'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rproc_register':
>> tee_remoteproc.c:(.text+0x51c): undefined reference to `tee_client_open_session'
>> tee_remoteproc.c:(.text+0x51c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `tee_client_open_session'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rproc_unregister':
>> tee_remoteproc.c:(.text+0x624): undefined reference to `tee_client_close_session'
>> tee_remoteproc.c:(.text+0x624): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `tee_client_close_session'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rproc_probe':
>> tee_remoteproc.c:(.text+0x6b0): undefined reference to `tee_client_open_context'
>> tee_remoteproc.c:(.text+0x6b0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `tee_client_open_context'
>> aarch64-linux-ld: tee_remoteproc.c:(.text+0x6e0): undefined reference to `tee_client_close_context'
>> tee_remoteproc.c:(.text+0x6e0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `tee_client_close_context'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rproc_remove':
   tee_remoteproc.c:(.text+0x78c): undefined reference to `tee_client_close_session'
   tee_remoteproc.c:(.text+0x78c): additional relocation overflows omitted from the output
   aarch64-linux-ld: tee_remoteproc.c:(.text+0x7dc): undefined reference to `tee_client_close_context'
>> aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o:(.data+0x10): undefined reference to `tee_bus_type'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for TEE_REMOTEPROC
   Depends on [m]: REMOTEPROC [=y] && OPTEE [=m]
   Selected by [y]:
   - STM32_RPROC [=y] && (ARCH_STM32 [=y] || COMPILE_TEST [=y]) && REMOTEPROC [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

