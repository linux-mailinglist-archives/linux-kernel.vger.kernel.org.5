Return-Path: <linux-kernel+bounces-123647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8392F890C33
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FA72A4EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFF113A886;
	Thu, 28 Mar 2024 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5HFRot5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C26D13AA54
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660046; cv=none; b=pDWDccneBKljrT355zz8yYnPumM1mKjVmsiphmGc0vJZWQ6ULDhDJeWz2tvkgr3kMQpuNUD9xUyd7V7iAyC5QiLgxnb10z/hArnyevTK0zmIUglOegbFRcP2vcTh2lTYGU0WJlDnVonpMebw51nq6ZxD+LNtXwTPvD1lJf97daE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660046; c=relaxed/simple;
	bh=WakwZuSdLqzld89orUC502TIto80jRQf9jd2N0l/Uig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IeC1QIJppJmJ9FimqrvznupDOOcBieDR4mBE9yByI6Oa9Mwr5fpD+eAzb/dV6E5vSPzT91uSMRnZa7f3XASloAyPTxM31AE+c48nfR7TMtFKro3ijKTHTyTKLjHaiyWuFq+hqUjD4CNgCFYWBhV8h691gm1IIkV6bRcKUbuyymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5HFRot5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711660044; x=1743196044;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WakwZuSdLqzld89orUC502TIto80jRQf9jd2N0l/Uig=;
  b=R5HFRot5wrHpSxyvCiWXHMrtCI6v+10sBi0fa4F1zPN1y78+0RFtf+mk
   btslJZctw7yhE0vT7cVMNJgdryDhrwj2XXNjA3MgxTeDxZqpRpKbDMPB2
   O3F/MkxHiaqtJLuBT/fKPpdeMOoGl7pd5m5oYX+LuxAD7Q+QssGnJ4tWZ
   KogGK9iP5Uc5GmYaPgjfgscRNR5NGrjem1IuoNP544f/WPEavplMzg5YB
   du71X0H7tvmQv4Plamdw5IlTKClGgOY2Ux+v1f2IiT9lvxmSPO5HLcWm8
   /tqL6fvmhppnvE+KGyYJNU9calyGjzr81lsMVjPTu07It3Ygg3aEOE9xv
   w==;
X-CSE-ConnectionGUID: 2Y+JqVrcR12gvYJ67J2F3w==
X-CSE-MsgGUID: Y3EuuazLRf2kJplFLrIKog==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17566370"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17566370"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 14:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16647031"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 28 Mar 2024 14:07:22 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpwxz-0002WY-2y;
	Thu, 28 Mar 2024 21:07:19 +0000
Date: Fri, 29 Mar 2024 05:06:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Dave Chinner <dchinner@redhat.com>
Subject: fs/xfs/./scrub/trace.h:748:3: warning: 'strncpy' specified bound 256
 equals destination size
Message-ID: <202403290419.HPcyvqZu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8d025e2092e29bfd13e56c78e22af25fac83c8ec
commit: 3934e8ebb7cc6e5f1ade35d586ed3eb79b88eb95 xfs: create a big array data structure
date:   8 months ago
config: x86_64-buildonly-randconfig-005-20240328 (https://download.01.org/0day-ci/archive/20240329/202403290419.HPcyvqZu-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403290419.HPcyvqZu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403290419.HPcyvqZu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:103,
                    from fs/xfs/scrub/trace.h:1119,
                    from fs/xfs/scrub/trace.c:42:
   fs/xfs/./scrub/trace.h: In function 'perf_trace_xfile_create':
>> fs/xfs/./scrub/trace.h:748:3: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
      strncpy(__entry->pathname, path, sizeof(__entry->pathname));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/perf.h:51:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:44:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   fs/xfs/./scrub/trace.h:731:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(xfile_create,
    ^~~~~~~~~~~
   fs/xfs/./scrub/trace.h:739:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:102,
                    from fs/xfs/scrub/trace.h:1119,
                    from fs/xfs/scrub/trace.c:42:
   fs/xfs/./scrub/trace.h: In function 'trace_event_raw_event_xfile_create':
>> fs/xfs/./scrub/trace.h:748:3: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
      strncpy(__entry->pathname, path, sizeof(__entry->pathname));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:402:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:44:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   fs/xfs/./scrub/trace.h:731:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(xfile_create,
    ^~~~~~~~~~~
   fs/xfs/./scrub/trace.h:739:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~


vim +/strncpy +748 fs/xfs/./scrub/trace.h

   730	
   731	TRACE_EVENT(xfile_create,
   732		TP_PROTO(struct xfile *xf),
   733		TP_ARGS(xf),
   734		TP_STRUCT__entry(
   735			__field(dev_t, dev)
   736			__field(unsigned long, ino)
   737			__array(char, pathname, 256)
   738		),
   739		TP_fast_assign(
   740			char		pathname[257];
   741			char		*path;
   742	
   743			__entry->ino = file_inode(xf->file)->i_ino;
   744			memset(pathname, 0, sizeof(pathname));
   745			path = file_path(xf->file, pathname, sizeof(pathname) - 1);
   746			if (IS_ERR(path))
   747				path = "(unknown)";
 > 748			strncpy(__entry->pathname, path, sizeof(__entry->pathname));
   749		),
   750		TP_printk("xfino 0x%lx path '%s'",
   751			  __entry->ino,
   752			  __entry->pathname)
   753	);
   754	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

