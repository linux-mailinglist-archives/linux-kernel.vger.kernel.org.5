Return-Path: <linux-kernel+bounces-54714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9E084B2CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B0B1C22810
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9286E58131;
	Tue,  6 Feb 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcT+27MJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15E4EB46;
	Tue,  6 Feb 2024 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216784; cv=none; b=mLqhjMSIVjtzO8D+cT0jdQkUD9cPN9Eqq7PFp+6/rhsEuqhzQK7IgU7thFDSRsIp7XuPHoYHSKHVMknqJfC3PNpfbg1ds45YfvbE1LTY1M3f/rSCI7ErTTmYBFWG93X+Ml3rqw/Sovwe19qlNZ5pCxjVVQzoYiR0SSzO1OHwQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216784; c=relaxed/simple;
	bh=9uQDvmNZjkwnGeIFN5mlmGI1UDGBBxNEzfYtOgWxsmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKHMi7E1KZERRKvKF30LYHGLWUPXomqv2YrZ20GtvoqzPunAB5DadTMqYyrJBcfrzyYcpVA6qWQGtJrP8z29O2+faiUxS0cGLq24OyNc0XnU5RKns3mGA7gU1O+sgtZ332utOux3uFWQQD3+twaBxAJe7ngu70TzINg2pL4JrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcT+27MJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707216782; x=1738752782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9uQDvmNZjkwnGeIFN5mlmGI1UDGBBxNEzfYtOgWxsmM=;
  b=BcT+27MJsnwSiVbfwzsT9ugDRD8J0k7ocl07M8w0iro6OWJQkH4d/yyD
   xGRg38enTHGOxpYey2DR9A0LkpRV0VvJiktrG8TaB3P72NDakcgm618am
   YOaX4hykr7W0J1pEwNPqtoWZ7F4DlDc5WKoDIHHSf3aXHYycN+eqFxBFn
   08mZglcxXk+XsziV6gFwax7vLpyiLbi7xl8lkOjfEv2LOQRKRSTl2UT81
   B33ZlXBPCDYuVTTREXUKpnA0DTQCofU+p3aFhQfFN35OXBAg9kWZaaz6n
   XOckbAciZmG4Z6QDnELYnmxFK4o5RKMDML/5AnCQc8c8LWhbdbCXGQxlu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="631470"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="631470"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 02:53:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="38410556"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 06 Feb 2024 02:53:01 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXJ4T-0001II-1W;
	Tue, 06 Feb 2024 10:52:57 +0000
Date: Tue, 6 Feb 2024 18:52:51 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v14 4/6] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <202402061809.T2cv9J8W-lkp@intel.com>
References: <20240205163410.2296552-5-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205163410.2296552-5-vdonnefort@google.com>

Hi Vincent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e2412e51fdea837b50ce31fea8e5dfc885237f3a]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Donnefort/ring-buffer-Zero-ring-buffer-sub-buffers/20240206-004413
base:   e2412e51fdea837b50ce31fea8e5dfc885237f3a
patch link:    https://lore.kernel.org/r/20240205163410.2296552-5-vdonnefort%40google.com
patch subject: [PATCH v14 4/6] tracing: Allow user-space mapping of the ring-buffer
config: arc-defconfig (https://download.01.org/0day-ci/archive/20240206/202402061809.T2cv9J8W-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240206/202402061809.T2cv9J8W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402061809.T2cv9J8W-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'tracing_buffers_mmap_close':
>> kernel/trace/trace.c:8722:29: warning: unused variable 'tr' [-Wunused-variable]
    8722 |         struct trace_array *tr = iter->tr;
         |                             ^~
   kernel/trace/trace.c: In function 'tracing_buffers_mmap':
   kernel/trace/trace.c:8752:29: warning: unused variable 'tr' [-Wunused-variable]
    8752 |         struct trace_array *tr = iter->tr;
         |                             ^~


vim +/tr +8722 kernel/trace/trace.c

  8717	
  8718	static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
  8719	{
  8720		struct ftrace_buffer_info *info = vma->vm_file->private_data;
  8721		struct trace_iterator *iter = &info->iter;
> 8722		struct trace_array *tr = iter->tr;
  8723	
  8724		ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file);
  8725	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

