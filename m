Return-Path: <linux-kernel+bounces-39538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4208B83D281
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E37D1C2468A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EFFAD21;
	Fri, 26 Jan 2024 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLb1KxXB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC48F44;
	Fri, 26 Jan 2024 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235753; cv=none; b=jPsP80WK2Z+PqxvBv1SZqJWTPsA9FABz4u7ptYGp1xIE2NhwCLYoJAHkky8inUdJ28l/p1Bu20UTu9bNuoWR37EVWzSpXA8FBO4PaKQzXzQG542gFlBPueFWmtal5nTaB0Ybub38kiB+ik9Ir5h4FFRzdqy84rZ43X5T8t0TqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235753; c=relaxed/simple;
	bh=2MTXUGWkSU7bPTzmjrQqIqpDoQjBk+IySgrbW3tQLzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8Ztfb/2fmgnh+J0VHWuVQSmkqpYloTsNwDevKG+zbScCR4PdxOvgoqRYFPGPfkwkiR4Ayi6lkXNjZW9o89XbAy35y9uVl+dgyCNsSdMv2dZKlvVWYnD7BP9YB3rqWjQhvYKg8sW/KBT6eTS63v/m9W4M3/IKSiK6OHoQQgKvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLb1KxXB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706235751; x=1737771751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2MTXUGWkSU7bPTzmjrQqIqpDoQjBk+IySgrbW3tQLzw=;
  b=OLb1KxXBggrZ/0F2w2bvjvhhoOJ1bTcecXimAyk2gqd9VYoRwvb9VOKR
   UU1EY2EIRWRbe4hol2RexOLdluZfo8O93zP8hEKXWd6HDjwAk8XpGA78F
   aH2tW9CP9ETPvrjTWxPf4zvSAyvv0TKo7SCvufZW3BsBWIjMKOhfaWzR5
   2isdIv+XTs4PdV7XcmaA7WJja6a24KFHeYOZikRFU5VZHdf+6NHGz6L8y
   XJb/zG32CvD4JuRelK/cY3wEovrF9lK1fapAuze4Lu+I5D151Dyq7j11S
   q/noZndyBfcsS0mKAKRlImsuYgM+VAQPay4oSuo6obmj4fvuF2uljpY/O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="23823712"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="23823712"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 18:22:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28988191"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Jan 2024 18:22:28 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTBrO-0000bC-1z;
	Fri, 26 Jan 2024 02:22:26 +0000
Date: Fri, 26 Jan 2024 10:21:48 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v12 3/6] tracing: Add snapshot refcount
Message-ID: <202401261026.Cc8uBwxf-lkp@intel.com>
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
config: i386-randconfig-012-20240126 (https://download.01.org/0day-ci/archive/20240126/202401261026.Cc8uBwxf-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401261026.Cc8uBwxf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401261026.Cc8uBwxf-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'tracing_set_tracer':
>> kernel/trace/trace.c:6645:9: error: 'struct tracer' has no member named 'use_max_tr'
    6645 |    if (t->use_max_tr)
         |         ^~
>> kernel/trace/trace.c:6646:5: error: implicit declaration of function 'tracing_disarm_snapshot_locked'; did you mean 'tracing_disarm_snapshot'? [-Werror=implicit-function-declaration]
    6646 |     tracing_disarm_snapshot_locked(tr);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |     tracing_disarm_snapshot
   cc1: some warnings being treated as errors


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

