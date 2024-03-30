Return-Path: <linux-kernel+bounces-125889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D22892D74
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A181F217BE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D224D9E9;
	Sat, 30 Mar 2024 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEItG4nl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25033BBC7
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833066; cv=none; b=P5Ge58vDGLPzQt+LmQWdqUQS8SV1fIgE5BlXjnkm0GmhfD5fKwvvasYnD2p4Iqr5QswBtFY83QCF5MZzgM1bdijVJT2fnZHCg2ikPixPA3a4lCePkse/wS3D+FMSj5ywVUJskdoxiLzP669yIBO3+gpZq8gw0Rlkc4qeyt99PWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833066; c=relaxed/simple;
	bh=rZCjSb/aqvGXzcCl3egT0ZAGXC2c6CWNxUC7glICW5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b15kFg973B6B0AT6JdyQqjZifV029vxRRXiQuS2JxXHzC9gVvVWBZRRRF1NuyvTMfP12ZkRC4UQM3ofKFFqxIJYcuhK/186hvHdZkMhIuCvx8YvLgSoqzk7dbXVmbGHs76SNjs1OxfeV0E5qZ7WM8v+umhb0QeQ86KT53iLy39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEItG4nl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711833065; x=1743369065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rZCjSb/aqvGXzcCl3egT0ZAGXC2c6CWNxUC7glICW5o=;
  b=CEItG4nlwWAkUUSi3ytzNGID0V72pmv9/erv9xEx0BusA0L2ge9s1Uh2
   dFtU6ee6Ginc2K8zyZynKhXP0lDRJ11OHndVuwYgwE+W65F2X9f0QB/ik
   A3ZYZLtEmi76ToGVcxuGz0YM3aNjItwdIqE8lqwOvgZYJ/JOTMVh9F+AE
   EwwA3G4uAL6d2p+LVMDsaGB4qCdI/uayD/naUxjmb5KhIviErswSidvjL
   CKKfK983KNxB2ezS1dOdcj1Gq3AgSrAHhhhmcScLcOZoXkgVbN28tm18u
   oiWNkxDRW2cVYigWgI5zRvhM3JlG1uxG5nObh7CkxFFO90vEHRA63jAYE
   g==;
X-CSE-ConnectionGUID: ZffOf7pMRVeynlBO9o3wiQ==
X-CSE-MsgGUID: Zif/ZVJHQqG3vtOebAoFRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="6840529"
X-IronPort-AV: E=Sophos;i="6.07,168,1708416000"; 
   d="scan'208";a="6840529"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 14:11:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,168,1708416000"; 
   d="scan'208";a="21806939"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 30 Mar 2024 14:11:00 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqfyc-0000Pi-0y;
	Sat, 30 Mar 2024 21:10:58 +0000
Date: Sun, 31 Mar 2024 05:10:20 +0800
From: kernel test robot <lkp@intel.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/4] task_work: Introduce task_work_cancel() again
Message-ID: <202403310406.TPrIela8-lkp@intel.com>
References: <20240329235812.18917-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329235812.18917-3-frederic@kernel.org>

Hi Frederic,

kernel test robot noticed the following build warnings:

[auto build test WARNING on perf-tools-next/perf-tools-next]
[also build test WARNING on tip/perf/core perf-tools/perf-tools linus/master acme/perf/core v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frederic-Weisbecker/task_work-s-task_work_cancel-task_work_cancel_func/20240330-080207
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20240329235812.18917-3-frederic%40kernel.org
patch subject: [PATCH 2/4] task_work: Introduce task_work_cancel() again
config: nios2-randconfig-r071-20240330 (https://download.01.org/0day-ci/archive/20240331/202403310406.TPrIela8-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240331/202403310406.TPrIela8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403310406.TPrIela8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/task_work.c:155: warning: Function parameter or struct member 'cb' not described in 'task_work_cancel'
>> kernel/task_work.c:155: warning: Excess function parameter 'func' description in 'task_work_cancel'


vim +155 kernel/task_work.c

   143	
   144	/**
   145	 * task_work_cancel - cancel a pending work added by task_work_add()
   146	 * @task: the task which should execute the work
   147	 * @func: the work to remove if queued
   148	 *
   149	 * Remove a callback from a task's queue if queued.
   150	 *
   151	 * RETURNS:
   152	 * True if the callback was queued and got cancelled, false otherwise.
   153	 */
   154	bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
 > 155	{
   156		struct callback_head *ret;
   157	
   158		ret = task_work_cancel_match(task, task_work_match, cb);
   159	
   160		return ret == cb;
   161	}
   162	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

