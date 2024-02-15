Return-Path: <linux-kernel+bounces-67313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB0385699B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5512927F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10485135419;
	Thu, 15 Feb 2024 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="labn/+XR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C43134743
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014686; cv=none; b=eQdDzLuUeIwUob71caQYMyuJaSsxL0uA+hrneE4lsq7gaNx8Tweeac9YY987dzEkbKmwCBekL9tOYK1Eq1J7olD1wILE+flkiEDcEu0aAXMql8fXjX4jzOxZFQorRnADVMjCNsA3ZH3vg+TEfKO06CNwsYgO11i7PJmGlXMAWEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014686; c=relaxed/simple;
	bh=noOgBvZR7qeQQFGTupjWTHAu2G8dM4lHizJLkWAvvb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NnANUgHqljB8/n1Tpw+ZU5ws9k+MeKhdJ/a9xTaWqeYlW8I+iiFFEOhqcPyYIUFOn+BpxzIM5ncSIXC7e/wvjZgqzAv3v/6+vGuiXiIPPk6/+SyaTsf0np9on992Hn/gI9F8siopKxpVKeqTQ5mo5XcwTSe2QDx9/qI+ar1wnfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=labn/+XR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708014685; x=1739550685;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=noOgBvZR7qeQQFGTupjWTHAu2G8dM4lHizJLkWAvvb4=;
  b=labn/+XRXDs8LTeFdRO1epMBSPmLYjdLnRMdXnZwubbWviP1Go8cn2UZ
   8Mq+eLjCZtYmGjZz5vIT/lLf+j+yCUxMLz4Ljq4lrqw+7+0PcKLl4eEH6
   aVD8pStPs3sruviKdZlY1y9BSV66UP8lsjAIqrX2V9ZXBbx2Bzjaa7vDy
   qCzhe16+xgZsnGkHuLOWEVXYcirIVPfiJd8SZkbg1TKM1NzU9sfYCCBYe
   rcn8KV7+As9DuIHMrayLPXJ8hJ2TIcOxY7SdLZy5Uba5PsYET7WCjpOHs
   3pg2yPwSms0XahRQWMfqYAgsaZqXD4jZ5qVq6WwiQ7TDge4owriNsfxS2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="24575960"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="24575960"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:31:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="34620382"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 15 Feb 2024 08:31:19 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1raedU-0000dU-2l;
	Thu, 15 Feb 2024 16:31:03 +0000
Date: Fri, 16 Feb 2024 00:29:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240215 1/1]
 include/linux/bpf-cgroup.h:191:15: warning: comparison of distinct pointer
 types ('struct bpf_prog_array *' and 'struct bpf_prog_array_tag *')
Message-ID: <202402160049.31LWdQ1F-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240215
head:   34a5c90f36e0238bfc95cda9e2eccf7e610bff1a
commit: 34a5c90f36e0238bfc95cda9e2eccf7e610bff1a [1/1] treewide: Address -Wflexible-array-member-not-at-end warnings
config: arm-randconfig-001-20240215 (https://download.01.org/0day-ci/archive/20240216/202402160049.31LWdQ1F-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240216/202402160049.31LWdQ1F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402160049.31LWdQ1F-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from security/device_cgroup.c:8:
>> include/linux/bpf-cgroup.h:191:15: warning: comparison of distinct pointer types ('struct bpf_prog_array *' and 'struct bpf_prog_array_tag *') [-Wcompare-distinct-pointer-types]
           return array != &bpf_empty_prog_array.hdr;
                  ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +191 include/linux/bpf-cgroup.h

de9cbbaadba5ad Roman Gushchin 2018-08-02  178  
b741f1630346de Roman Gushchin 2018-09-28  179  int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
b741f1630346de Roman Gushchin 2018-09-28  180  int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
b741f1630346de Roman Gushchin 2018-09-28  181  				     void *value, u64 flags);
b741f1630346de Roman Gushchin 2018-09-28  182  
46531a30364bd4 Pavel Begunkov 2022-01-27  183  /* Opportunistic check to see whether we have any BPF program attached*/
46531a30364bd4 Pavel Begunkov 2022-01-27  184  static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
46531a30364bd4 Pavel Begunkov 2022-01-27  185  					   enum cgroup_bpf_attach_type type)
46531a30364bd4 Pavel Begunkov 2022-01-27  186  {
46531a30364bd4 Pavel Begunkov 2022-01-27  187  	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
46531a30364bd4 Pavel Begunkov 2022-01-27  188  	struct bpf_prog_array *array;
46531a30364bd4 Pavel Begunkov 2022-01-27  189  
46531a30364bd4 Pavel Begunkov 2022-01-27  190  	array = rcu_access_pointer(cgrp->bpf.effective[type]);
46531a30364bd4 Pavel Begunkov 2022-01-27 @191  	return array != &bpf_empty_prog_array.hdr;
46531a30364bd4 Pavel Begunkov 2022-01-27  192  }
46531a30364bd4 Pavel Begunkov 2022-01-27  193  

:::::: The code at line 191 was first introduced by commit
:::::: 46531a30364bd483bfa1b041c15d42a196e77e93 cgroup/bpf: fast path skb BPF filtering

:::::: TO: Pavel Begunkov <asml.silence@gmail.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

