Return-Path: <linux-kernel+bounces-44261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121A1841F90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D1D1C250E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848FF5D8F7;
	Tue, 30 Jan 2024 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyC4SSIM"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC0C58229;
	Tue, 30 Jan 2024 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607186; cv=none; b=JXrCCm78VG2DF/bcsiNyzthRS1hO4SIrAt5Xj8AYks8qQ2GYDaCs9AfuVG/ku+8zEQmNSkt8WD3IvaqfjJcc8Hr+pg+845mFw0pMdjbJsUNvUVlAaFt1L+JGfNbZ+SWEFcqumcItW30wwOgE4MQdl8L9t438Pxgz/SAlV3Lsr4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607186; c=relaxed/simple;
	bh=qDeRMvQdUfJcgUph7GolKPnOADCEdCP7zPIUislJRg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFndcoh/ViVv24OsyqT6HgJlCWyrn7Cb/8C47hVsmvfe+q+q5BMHp2YEPJdBjCsMRq5ZTs5PLlHQAO0oe3KX2Nfiqjhdp3QgYOL4aRe7MD9Ch76b8i9M4+vsv04CbRoOTGtpFa0Y4+qYNeGTzwou/UBwFcG9L4uSh/a2tu1HMrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dyC4SSIM; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706607185; x=1738143185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qDeRMvQdUfJcgUph7GolKPnOADCEdCP7zPIUislJRg4=;
  b=dyC4SSIMls/DXTj8jka0QL8Sntjw3mQ1G8VqU9wm1C664ygN9gMS/Gof
   ldGPAOV6c3u5pAmw7kNa4DAR5xybWS+V9TTimSqMqPPN8PwtRU0Y47EtP
   DgQmqylMX5flZ/lHZ+oqkiYtDCT5FSPux3+R3SN8V7Mag+5i0RvPVvXrd
   KoMgFGejxRIfd42ApByRchS18cRfs7Bfhr4UL7EfMdUIg3EJOtiTw/N79
   QCJmEa9Bz/sBfG2HDloFsTmqZ1iXq4fHmlgKT+RRpao5OBuCTPuooaq/m
   P7MZcJ/04h1livQQA7wQjXoZyNLttKbPhhkdBeyIBDUus+lJbwEP65hpA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="402092267"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="402092267"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:33:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3680243"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 30 Jan 2024 01:33:02 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUkT7-00009y-0s;
	Tue, 30 Jan 2024 09:32:07 +0000
Date: Tue, 30 Jan 2024 17:30:38 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v13 3/6] tracing: Add snapshot refcount
Message-ID: <202401301740.qzZlpcYV-lkp@intel.com>
References: <20240129142802.2145305-4-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129142802.2145305-4-vdonnefort@google.com>

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on 29142dc92c37d3259a33aef15b03e6ee25b0d188]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Donnefort/ring-buffer-Zero-ring-buffer-sub-buffers/20240129-223025
base:   29142dc92c37d3259a33aef15b03e6ee25b0d188
patch link:    https://lore.kernel.org/r/20240129142802.2145305-4-vdonnefort%40google.com
patch subject: [PATCH v13 3/6] tracing: Add snapshot refcount
config: arc-randconfig-002-20240130 (https://download.01.org/0day-ci/archive/20240130/202401301740.qzZlpcYV-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240130/202401301740.qzZlpcYV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401301740.qzZlpcYV-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'tracing_set_tracer':
   kernel/trace/trace.c:6644:17: error: implicit declaration of function 'tracing_disarm_snapshot_locked'; did you mean 'tracing_disarm_snapshot'? [-Werror=implicit-function-declaration]
    6644 |                 tracing_disarm_snapshot_locked(tr);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 tracing_disarm_snapshot
>> kernel/trace/trace.c:6648:23: error: implicit declaration of function 'tracing_arm_snapshot_locked'; did you mean 'tracing_arm_snapshot'? [-Werror=implicit-function-declaration]
    6648 |                 ret = tracing_arm_snapshot_locked(tr);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                       tracing_arm_snapshot
   cc1: some warnings being treated as errors


vim +6648 kernel/trace/trace.c

  6560	
  6561	int tracing_set_tracer(struct trace_array *tr, const char *buf)
  6562	{
  6563		struct tracer *t;
  6564	#ifdef CONFIG_TRACER_MAX_TRACE
  6565		bool had_max_tr;
  6566	#endif
  6567		int ret = 0;
  6568	
  6569		mutex_lock(&trace_types_lock);
  6570	
  6571		if (!tr->ring_buffer_expanded) {
  6572			ret = __tracing_resize_ring_buffer(tr, trace_buf_size,
  6573							RING_BUFFER_ALL_CPUS);
  6574			if (ret < 0)
  6575				goto out;
  6576			ret = 0;
  6577		}
  6578	
  6579		for (t = trace_types; t; t = t->next) {
  6580			if (strcmp(t->name, buf) == 0)
  6581				break;
  6582		}
  6583		if (!t) {
  6584			ret = -EINVAL;
  6585			goto out;
  6586		}
  6587		if (t == tr->current_trace)
  6588			goto out;
  6589	
  6590	#ifdef CONFIG_TRACER_SNAPSHOT
  6591		if (t->use_max_tr) {
  6592			local_irq_disable();
  6593			arch_spin_lock(&tr->max_lock);
  6594			if (tr->cond_snapshot)
  6595				ret = -EBUSY;
  6596			arch_spin_unlock(&tr->max_lock);
  6597			local_irq_enable();
  6598			if (ret)
  6599				goto out;
  6600		}
  6601	#endif
  6602		/* Some tracers won't work on kernel command line */
  6603		if (system_state < SYSTEM_RUNNING && t->noboot) {
  6604			pr_warn("Tracer '%s' is not allowed on command line, ignored\n",
  6605				t->name);
  6606			goto out;
  6607		}
  6608	
  6609		/* Some tracers are only allowed for the top level buffer */
  6610		if (!trace_ok_for_array(t, tr)) {
  6611			ret = -EINVAL;
  6612			goto out;
  6613		}
  6614	
  6615		/* If trace pipe files are being read, we can't change the tracer */
  6616		if (tr->trace_ref) {
  6617			ret = -EBUSY;
  6618			goto out;
  6619		}
  6620	
  6621		trace_branch_disable();
  6622	
  6623		tr->current_trace->enabled--;
  6624	
  6625		if (tr->current_trace->reset)
  6626			tr->current_trace->reset(tr);
  6627	
  6628	#ifdef CONFIG_TRACER_MAX_TRACE
  6629		had_max_tr = tr->current_trace->use_max_tr;
  6630	
  6631		/* Current trace needs to be nop_trace before synchronize_rcu */
  6632		tr->current_trace = &nop_trace;
  6633	
  6634		if (had_max_tr && !t->use_max_tr) {
  6635			/*
  6636			 * We need to make sure that the update_max_tr sees that
  6637			 * current_trace changed to nop_trace to keep it from
  6638			 * swapping the buffers after we resize it.
  6639			 * The update_max_tr is called from interrupts disabled
  6640			 * so a synchronized_sched() is sufficient.
  6641			 */
  6642			synchronize_rcu();
  6643			free_snapshot(tr);
  6644			tracing_disarm_snapshot_locked(tr);
  6645		}
  6646	
  6647		if (t->use_max_tr) {
> 6648			ret = tracing_arm_snapshot_locked(tr);
  6649			if (ret)
  6650				goto out;
  6651		}
  6652	#else
  6653		tr->current_trace = &nop_trace;
  6654	#endif
  6655	
  6656		if (t->init) {
  6657			ret = tracer_init(t, tr);
  6658			if (ret) {
  6659	#ifdef CONFIG_TRACER_MAX_TRACE
  6660				if (t->use_max_tr)
  6661					tracing_disarm_snapshot_locked(tr);
  6662	#endif
  6663				goto out;
  6664			}
  6665		}
  6666	
  6667		tr->current_trace = t;
  6668		tr->current_trace->enabled++;
  6669		trace_branch_enable(tr);
  6670	 out:
  6671		mutex_unlock(&trace_types_lock);
  6672	
  6673		return ret;
  6674	}
  6675	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

