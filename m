Return-Path: <linux-kernel+bounces-39525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2658783D255
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604A3B288BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7D467C66;
	Fri, 26 Jan 2024 02:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="madE+Ek9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39F91C11;
	Fri, 26 Jan 2024 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706234553; cv=none; b=B4yLy2KutjL161E83577NhtE38COxxB2i/79LcO9fRwVJ8edZj1LYw2+0/QYCJCFGyhGHuLfrRzRR/fDi/2Mu8WxmPexJpcNYjM0D5f2UcaZaNHB5yg6rGS2J4cAdoE9niufv4AE39IZOl9teEcErKFkrLXnDpfP5EIRfliStmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706234553; c=relaxed/simple;
	bh=+Zdo0Izf+my/Kvw5W3qSfaE7Aob5TU032RmJ02/Ryes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVAaahhA+3dJr4bhp0K7azffV7YHtueeyOtVbR6rn+Wup7H9ZymM2BVN918VjHH/NgtBl5QwNWI2v3nuLlrhE5hVHlAJPxo21VTwG+HrnVhcZvq3bUETQcyfKtznRACNy5Np9yjIMTKbDenJ4q4WlmrDd34Unqzd40DmptQL7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=madE+Ek9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706234552; x=1737770552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Zdo0Izf+my/Kvw5W3qSfaE7Aob5TU032RmJ02/Ryes=;
  b=madE+Ek95cTzGWVF9izO7GIGi7H3snlWWHYLi2GnCw1+yacYCS+ibBC5
   P20URFL+OXVRwyXnncEAjcH1tbcPtiW7J+0NaTiHtRoN9TZOBDK4q9mRj
   uxZx4UzgWAl0SQ4QrxePgp/x7Mr4PUOxhnZBzvywIc6pjJBJbi2BHi05o
   lvJdWPXuBU7ZRdvubKB+YT9mvGccDP6ShVaIIxC0getk5p+dZL3/0LGgR
   qj63FxugoVaboEDsRfiE90oeCwcx5pgdWv4UtR+9vShg8vqUgLcX9mlbg
   AGgdNJ3COwmbgz2tTn0zTTMRv2MF2Z2sRo6Z9n4G5nsO/e8bTFV4AEcVP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2204530"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2204530"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 18:02:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="960078317"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="960078317"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Jan 2024 18:02:28 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTBY1-0000aS-2j;
	Fri, 26 Jan 2024 02:02:25 +0000
Date: Fri, 26 Jan 2024 10:01:31 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v12 3/6] tracing: Add snapshot refcount
Message-ID: <202401260918.sn23MDek-lkp@intel.com>
References: <20240123110757.3657908-4-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123110757.3657908-4-vdonnefort@google.com>

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4f1991a92cfe89096b2d1f5583a2e093bdd55c37]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Donnefort/ring-buffer-Zero-ring-buffer-sub-buffers/20240123-191131
base:   4f1991a92cfe89096b2d1f5583a2e093bdd55c37
patch link:    https://lore.kernel.org/r/20240123110757.3657908-4-vdonnefort%40google.com
patch subject: [PATCH v12 3/6] tracing: Add snapshot refcount
config: i386-buildonly-randconfig-005-20240126 (https://download.01.org/0day-ci/archive/20240126/202401260918.sn23MDek-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401260918.sn23MDek-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401260918.sn23MDek-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace.c:6645:11: error: no member named 'use_max_tr' in 'struct tracer'
    6645 |                         if (t->use_max_tr)
         |                             ~  ^
>> kernel/trace/trace.c:6646:5: error: call to undeclared function 'tracing_disarm_snapshot_locked'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    6646 |                                 tracing_disarm_snapshot_locked(tr);
         |                                 ^
   kernel/trace/trace.c:6646:5: note: did you mean 'tracing_disarm_snapshot'?
   kernel/trace/trace.h:1986:20: note: 'tracing_disarm_snapshot' declared here
    1986 | static inline void tracing_disarm_snapshot(struct trace_array *tr) { }
         |                    ^
   2 errors generated.


vim +6645 kernel/trace/trace.c

  6641	
  6642		if (t->init) {
  6643			ret = tracer_init(t, tr);
  6644			if (ret) {
> 6645				if (t->use_max_tr)
> 6646					tracing_disarm_snapshot_locked(tr);
  6647				goto out;
  6648			}
  6649		}
  6650	
  6651		tr->current_trace = t;
  6652		tr->current_trace->enabled++;
  6653		trace_branch_enable(tr);
  6654	 out:
  6655		mutex_unlock(&trace_types_lock);
  6656	
  6657		return ret;
  6658	}
  6659	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

