Return-Path: <linux-kernel+bounces-126163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DBB8932FF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9D9283BA4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C74146D6E;
	Sun, 31 Mar 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEItG4nl"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA214C598
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902428; cv=fail; b=swtMHXLF+P3mg0b4p4GSUHXWunLTJvlHMvIzdXrQQfUBFKyWT51o8Td7Fd1oDsV3cSeILPpLtKgs5O7lD+HwJpZVWDvUo7dqNAlDPShLMP5Lkhpm52T/IeqSZlTMkEerm3PMrCzI1VkLrUf8KOA1EeaVE/iak7zM5Fo6YRLtpA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902428; c=relaxed/simple;
	bh=rZCjSb/aqvGXzcCl3egT0ZAGXC2c6CWNxUC7glICW5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p03sJjRgyjlQqy8C+lexrIqIQemfWWG1MOylI3UQqNPVFbyHYiR9ZaBO3zWzPJ1Mwaf9pfsUPb6PaOYhq/FOQsxte1vi0ctxXLQE9ZDGK3IVXVyNcwZOh2EKcSrKNtNawGtfl2IX7vSmcWyk4qMQUO3ZWXHzCDgAjGfIMwr33NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEItG4nl; arc=none smtp.client-ip=198.175.65.19; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C9920208A2;
	Sun, 31 Mar 2024 18:27:05 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HSCaAv2i8j5n; Sun, 31 Mar 2024 18:27:05 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E3F4B20851;
	Sun, 31 Mar 2024 18:27:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E3F4B20851
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id D6CD8800051;
	Sun, 31 Mar 2024 18:27:04 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:27:04 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:52 +0000
X-sender: <linux-kernel+bounces-125889-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAJKNAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAiAAAAo4oAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 16546
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125889-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9807E2053D
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833066; cv=none; b=P5Ge58vDGLPzQt+LmQWdqUQS8SV1fIgE5BlXjnkm0GmhfD5fKwvvasYnD2p4Iqr5QswBtFY83QCF5MZzgM1bdijVJT2fnZHCg2ikPixPA3a4lCePkse/wS3D+FMSj5ywVUJskdoxiLzP669yIBO3+gpZq8gw0Rlkc4qeyt99PWw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833066; c=relaxed/simple;
	bh=rZCjSb/aqvGXzcCl3egT0ZAGXC2c6CWNxUC7glICW5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b15kFg973B6B0AT6JdyQqjZifV029vxRRXiQuS2JxXHzC9gVvVWBZRRRF1NuyvTMfP12ZkRC4UQM3ofKFFqxIJYcuhK/186hvHdZkMhIuCvx8YvLgSoqzk7dbXVmbGHs76SNjs1OxfeV0E5qZ7WM8v+umhb0QeQ86KT53iLy39M=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEItG4nl; arc=none smtp.client-ip=198.175.65.19
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
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,168,1708416000"; 
   d="scan'208";a="21806939"
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240329235812.18917-3-frederic@kernel.org>
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

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


