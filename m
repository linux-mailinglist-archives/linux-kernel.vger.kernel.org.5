Return-Path: <linux-kernel+bounces-64663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B349F854139
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F63928FE81
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EFAAD4C;
	Wed, 14 Feb 2024 01:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpNh082X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B5B642;
	Wed, 14 Feb 2024 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873873; cv=none; b=SqIjnb5gBnt57ZNFozEZvS+C3PExNjhWMXTkd/GYgSKGCQ8A7wOvw6svheXVN8Z9ihkbteaVEExt5IOcCK/4emjugmZZjxuzTFrzmC/DgI64KbHqXNYmPiJqZYYxUu8YJc5ZIcJbl6/qtK0JrSQuoJX/RD7/++i8CfAy4b1dgqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873873; c=relaxed/simple;
	bh=QkESgp3DrTzELhwU4ILUNGYPVZAxyh05U2iP4iqk3oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQXuV0djsKW++loQ8uT6kNBuz7gEC3bJHDPw8ckJHLKvckjdV58GRXhwtZszRGEHe5aR48ASjOaNp9HKPkYr1y0S8xMNEAYaou9PXgR4Y9RJZofC3e8Dys7DuAZ3iAFkPBV97idBavcxtQz7pZxO8K4wbzUmdEMLLoEG17yNKdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpNh082X; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707873870; x=1739409870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QkESgp3DrTzELhwU4ILUNGYPVZAxyh05U2iP4iqk3oQ=;
  b=YpNh082XP3TUyZycQ/r4DJNpIAL7xPBeXtuyVmSIrqMrGhZYz0dP04Dq
   6hJHGp+TTYyT8NxyCKPTZKZzwkNhLW2U2NXEBmIOslHYdTFGuhKpqmYnt
   A+dnRTlb10M7xw9HmyEwi5Ky5JC2Se9DnU6BtgPWzDfC7dZUwSm1hhpnT
   z93mz+8o+2MYoVEDe+G5/0SFZRcaxf438on+vxNMKb51IAVwGk6aWAodQ
   RUugiaOmiY+z9X/qZT+/vfSz+shWf77jZTBkliXQXPcqAXNFJLtj/ToiR
   8LhbrrXyswKNNhcKYjftPyly+3nCowliscWuaSqeHVdXbwhzpgEA5xjO3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27354168"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="27354168"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 17:24:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="7801722"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Feb 2024 17:24:27 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ra40e-0008CY-0Y;
	Wed, 14 Feb 2024 01:24:24 +0000
Date: Wed, 14 Feb 2024 09:23:30 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v17 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <202402140910.TFs9k0YR-lkp@intel.com>
References: <20240213114945.3528801-3-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213114945.3528801-3-vdonnefort@google.com>

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on ca185770db914869ff9fe773bac5e0e5e4165b83]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Donnefort/ring-buffer-Zero-ring-buffer-sub-buffers/20240213-195302
base:   ca185770db914869ff9fe773bac5e0e5e4165b83
patch link:    https://lore.kernel.org/r/20240213114945.3528801-3-vdonnefort%40google.com
patch subject: [PATCH v17 2/6] ring-buffer: Introducing ring-buffer mapping functions
config: i386-buildonly-randconfig-001-20240214 (https://download.01.org/0day-ci/archive/20240214/202402140910.TFs9k0YR-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240214/202402140910.TFs9k0YR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402140910.TFs9k0YR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/ring_buffer.c:6185:2: error: member reference type 'struct mutex' is not a pointer; did you mean to use '.'?
    6185 |         lockdep_assert_held(cpu_buffer->mapping_lock);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:267:17: note: expanded from macro 'lockdep_assert_held'
     267 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:234:52: note: expanded from macro 'lockdep_is_held'
     234 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^
   include/linux/lockdep.h:261:32: note: expanded from macro 'lockdep_assert'
     261 |         do { WARN_ON(debug_locks && !(cond)); } while (0)
         |              ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   include/asm-generic/bug.h:123:25: note: expanded from macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
>> kernel/trace/ring_buffer.c:6185:2: error: cannot take the address of an rvalue of type 'struct lockdep_map'
    6185 |         lockdep_assert_held(cpu_buffer->mapping_lock);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:267:17: note: expanded from macro 'lockdep_assert_held'
     267 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:234:45: note: expanded from macro 'lockdep_is_held'
     234 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                      ^
   include/linux/lockdep.h:261:32: note: expanded from macro 'lockdep_assert'
     261 |         do { WARN_ON(debug_locks && !(cond)); } while (0)
         |              ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   include/asm-generic/bug.h:123:25: note: expanded from macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   2 errors generated.


vim +6185 kernel/trace/ring_buffer.c

  6174	
  6175	/*
  6176	 * Fast-path for rb_buffer_(un)map(). Called whenever the meta-page doesn't need
  6177	 * to be set-up or torn-down.
  6178	 */
  6179	static int __rb_inc_dec_mapped(struct trace_buffer *buffer,
  6180				       struct ring_buffer_per_cpu *cpu_buffer,
  6181				       bool inc)
  6182	{
  6183		unsigned long flags;
  6184	
> 6185		lockdep_assert_held(cpu_buffer->mapping_lock);
  6186	
  6187		if (inc && cpu_buffer->mapped == UINT_MAX)
  6188			return -EBUSY;
  6189	
  6190		if (WARN_ON(!inc && cpu_buffer->mapped == 0))
  6191			return -EINVAL;
  6192	
  6193		mutex_lock(&buffer->mutex);
  6194		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
  6195	
  6196		if (inc)
  6197			cpu_buffer->mapped++;
  6198		else
  6199			cpu_buffer->mapped--;
  6200	
  6201		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
  6202		mutex_unlock(&buffer->mutex);
  6203	
  6204		return 0;
  6205	}
  6206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

