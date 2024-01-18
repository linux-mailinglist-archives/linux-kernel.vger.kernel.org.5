Return-Path: <linux-kernel+bounces-29718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF5E831257
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951CE1C21B66
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078C8F52;
	Thu, 18 Jan 2024 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/oWadan"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF186FBC;
	Thu, 18 Jan 2024 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705555404; cv=none; b=ZrdRxl504ecIo8RCK6IQfu0ZB0pujLHUty3gUQvullPTh5vuPVlbinfZyR6qh2/sXx4aQRAZolIWNzPyRfUDJm0GDksYHiF44pAmHwimoP5f7I8KdQRBaHRDJupG6mw6mz8ZMIQZsNDLAHA6lkHPhYd80w5dLr8AlwtdTlSiBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705555404; c=relaxed/simple;
	bh=x/6No842LSfCPrLeri6/s3ezEv75k2+9QtC8rEcULB8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n0EeREYgNGN7cpXiCfGbnZKuZmz0DCb0SjlKTV+rmBLPB/7Taxdedj6+ioju48mpgskV6WpL3kWO5R0/dIu7ohAy/ueKLgvlHLAhq5sfGb/DxBeAPFGsk7Cy62NvF6kKUqhXIGC2AuRx+oMi+8CghlqhBYSyav38s6M6Qht2IO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/oWadan; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705555402; x=1737091402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x/6No842LSfCPrLeri6/s3ezEv75k2+9QtC8rEcULB8=;
  b=X/oWadan1tGPzrQwSu4H3DjH5Yp6QU+B7g4JFM+R9T47x0otkONtykku
   JS3vdZ64RUTdcY/crqa/lTOYRJ8G0UPurWYoM+l/+MCmkUthuyTv8/PB4
   WkHz43l5of122zE8JVsUK909LZ03lX91vWrs4kwbTQxwlLIaDJaikjRtH
   B7edSM70GrrfgW/o65wfsaVDdG5VK5+oCUzT3liN5IPYgR7NOi0EmBguZ
   8Kvg+n9nGgAtpOvdGxtDGPRIdATBPrFyr1sywOdIPqG9NLy9NlMpf6se+
   sPGuy+UMvIQEAVvOHMu8KccrW95fpbPEFdGV+fmDsFkEaUMFQZCn2zzE/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="390802140"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="390802140"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 21:23:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="1031539496"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="1031539496"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2024 21:23:14 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQKrw-0002g1-2H;
	Thu, 18 Jan 2024 05:23:12 +0000
Date: Thu, 18 Jan 2024 13:23:03 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 14/17] tracing: Add kho serialization of trace events
Message-ID: <202401181352.qC85XHgx-lkp@intel.com>
References: <20240117144704.602-15-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117144704.602-15-graf@amazon.com>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[cannot apply to tip/x86/core arm64/for-next/core akpm-mm/mm-everything v6.7 next-20240117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Graf/mm-memblock-Add-support-for-scratch-memory/20240117-225136
base:   linus/master
patch link:    https://lore.kernel.org/r/20240117144704.602-15-graf%40amazon.com
patch subject: [PATCH v3 14/17] tracing: Add kho serialization of trace events
config: i386-randconfig-141-20240118 (https://download.01.org/0day-ci/archive/20240118/202401181352.qC85XHgx-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240118/202401181352.qC85XHgx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401181352.qC85XHgx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_output.c:731:12: warning: unsequenced modification and access to 'count' [-Wunsequenced]
     731 |                 map[count++] = (struct trace_event_map) {
         |                          ^
     732 |                         .crc32 = count,
         |                                  ~~~~~
   1 warning generated.


vim +/count +731 kernel/trace/trace_output.c

   710	
   711	static int __maybe_unused _trace_kho_write_events(void *fdt)
   712	{
   713		struct trace_event_call *call;
   714		int count = __TRACE_LAST_TYPE - 1;
   715		struct trace_event_map *map;
   716		int err = 0;
   717		int i;
   718	
   719		down_read(&trace_event_sem);
   720		/* Allocate an array that we can place all maps into */
   721		list_for_each_entry(call, &ftrace_events, list)
   722			count++;
   723	
   724		map = vmalloc(count * sizeof(*map));
   725		if (!map)
   726			return -ENOMEM;
   727	
   728		/* Then fill the array with all crc32 values */
   729		count = 0;
   730		for (i = 1; i < __TRACE_LAST_TYPE; i++)
 > 731			map[count++] = (struct trace_event_map) {
   732				.crc32 = count,
   733				.type = count,
   734			};
   735	
   736		list_for_each_entry(call, &ftrace_events, list) {
   737			struct trace_event *event = &call->event;
   738	
   739			map[count++] = (struct trace_event_map) {
   740				.crc32 = event2fp(event),
   741				.type = event->type,
   742			};
   743		}
   744		up_read(&trace_event_sem);
   745	
   746		/* And finally write it into a DT variable */
   747		err |= fdt_property(fdt, "events", map, count * sizeof(*map));
   748	
   749		vfree(map);
   750		return err;
   751	}
   752	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

