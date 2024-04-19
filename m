Return-Path: <linux-kernel+bounces-151912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F288AB5AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1ED2851FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7631292DC;
	Fri, 19 Apr 2024 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibsWb4E6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3562A23
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713555748; cv=none; b=Q01aUj+0s8Duv2L+lO/HLqCtgM8XNy8/nwKEHL0yjB5N0rknZkkkOy9rBwbsEpFlX2/9/SZFfuHV4YMLDuqEPjnu2Hk+JO+HilJhmqYs64lanSkYlTtbVeyBteZAG9qo/QGtO30SGDB6dMUYmnebCLW93FMRAJN5HYmm6du1xhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713555748; c=relaxed/simple;
	bh=5uaexajk4wmXLDp2avdcSKylsbH+iQSlgi9gmaOEJys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDLuTrSQXZWHSqtBEwV7FcSMU5wJ/TNNrzSL4BALCU4QRGmB5hRglL2M904fRwu3nDFdi1OB/Xw+n5a7CirceP0mY/BSrIiG/Vy4xJFQFubpJ2Y+iW+0dlHv6S5hmJ7/IZIJOLJlC5L3H43l9YQBkDpyv8X84u2ve2Z18Cuvs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibsWb4E6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713555747; x=1745091747;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5uaexajk4wmXLDp2avdcSKylsbH+iQSlgi9gmaOEJys=;
  b=ibsWb4E6lq/oFOH3OdUJksni3wyS2PBrsAkkfD1YAqV+IwpU/9SvbI5v
   7sj1B/OgH5t10u/iIqF1VnyXfSUsjHHYa9TTYHirSO5MKwXhMAo6Wx5n2
   t4G/fcuZOgrYP7uAieNQjOIIZ0MHhNXaztkAqbcde2K68uDnXzny+F9IY
   QaFQxx25FNuOSBj5TRtE1T8tMX7pgqgprptdcQHL+XzmGKfG2lqFjIDT4
   t1wmgrcX7b1hHXJ7AJ/blBjGOoo6R/6BfPvcOr0PfCZpDv53ykjW+5m/5
   apYtu4dZVp/Ybhbyzb8WjuOvrMtXSk/JapovHKlssNitlHOtLkwG+h5GS
   w==;
X-CSE-ConnectionGUID: lhmS2NIDTDOH5c9MJcWF4A==
X-CSE-MsgGUID: 3MMotMnBSwqCJwpMvRElfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="19783177"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="19783177"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 12:42:26 -0700
X-CSE-ConnectionGUID: Caxu0hSVQkCJLWcvZL+1+Q==
X-CSE-MsgGUID: dN0JdCq+RUmaoD+gYGixEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="23491120"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.33])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 12:42:24 -0700
Message-ID: <b6ae1121-a900-499c-85e9-07ce0d6739c4@intel.com>
Date: Fri, 19 Apr 2024 22:42:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data23'
 from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data23'
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <202404190642.z54cLsGE-lkp@intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <202404190642.z54cLsGE-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/04/24 01:22, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2668e3ae2ef36d5e7c52f818ad7d90822c037de4
> commit: 5284984a4fbacb0883bfebe905902cdda2891a07 bug: Fix no-return-statement warning with !CONFIG_BUG
> date:   8 days ago
> config: powerpc-randconfig-r033-20211126 (https://download.01.org/0day-ci/archive/20240419/202404190642.z54cLsGE-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240419/202404190642.z54cLsGE-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404190642.z54cLsGE-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data23' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data23'
>    powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data18' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data18'
>>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data23' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data23'
>    powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data18' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data18'
>>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data23' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data23'
>    powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data18' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data18'
> 

The same warnings are visible in v6.8 that does not
contain commit 5284984a4fbacb0883bfebe905902cdda2891a07
so this is not due to that commit.


