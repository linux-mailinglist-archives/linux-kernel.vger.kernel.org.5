Return-Path: <linux-kernel+bounces-97481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AA8876AE3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09B5BB217C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F39D2D03C;
	Fri,  8 Mar 2024 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RodrbBUd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5F3C32
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923503; cv=none; b=fLUtzacJDV2evSR+VCTE331OPwZWjI9So7//Sfuw/ZBGuIdNUc2fpr/hU+p1dQFhZOZROH24NdJ0Rw7p2T4iltK0WY24Pl8lYeQmSJ2gT1WO4xf8ZR+IBnR7ZrS2tjAZ6EUn+xJwaZrl25/sSmfEJsEKl4DxZWRVi9IWHH1Ukr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923503; c=relaxed/simple;
	bh=kDwpVGBXWSnnkjA49v05Og62PYPjs9Ci/Aj5fU4Q/KE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WCG8HurlAKNczlBapyNS4e1OTAp13/O+YXUtPhFRMt3+SYUU60cC+SSnIf2XwLb0kQUQHOmfYt1rH+dj25VSSArUScC2Wtgw6KA88CI6Oq4CyIXycTyEsoAraqp0aksq8fBmwTk0ixeXjTDzJPS6vq+KDDiirT0bo7PvulY/M0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RodrbBUd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709923501; x=1741459501;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kDwpVGBXWSnnkjA49v05Og62PYPjs9Ci/Aj5fU4Q/KE=;
  b=RodrbBUdcaIGzFwtckWXAwmBsPiZofR/oFioJn+FsGM9pgdC4YBgpGGW
   HjlZCcB6dJ1yZJwSkyaeFXDakwlgXVNZ5YQKLats0b3ykYywkBifNfupr
   zLzeHUtYw09n3nG1rul6g+VWx72C8Y3zCeBBo0cxqQQ2wNyY9dM5LEdjr
   aYT9KOFLUIA/KtKwDIXe6SUyNNK1dO1JUf/uTKtp/hFA2Gw0rHzIiUy67
   tCKqMgg1tktuqbN+LW42YEWJMOD2cOLNBW1hrsBHgSCfHxUIVSsP9zFHn
   O/TDZOuvLKBUfgLMZtXR6IKU4jnhFIvlZd8G/iDN9hxgv7Da8BN133Gw/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4579832"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4579832"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 10:45:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="15252739"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Mar 2024 10:44:59 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rifDE-0006cF-2l;
	Fri, 08 Mar 2024 18:44:56 +0000
Date: Sat, 9 Mar 2024 02:44:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240305 1/1]
 include/linux/bpf-cgroup.h:191:22: sparse: sparse: incompatible types in
 comparison expression (different base types):
Message-ID: <202403090203.mM0o7gTP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240305
head:   3a02035a7f980ddbf41dd11815bb4e5f29e104d5
commit: 3a02035a7f980ddbf41dd11815bb4e5f29e104d5 [1/1] treewide: Address -Wflex-array-member-not-at-end warnings
config: x86_64-randconfig-122-20240308 (https://download.01.org/0day-ci/archive/20240309/202403090203.mM0o7gTP-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240309/202403090203.mM0o7gTP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403090203.mM0o7gTP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/socket.c: note: in included file:
>> include/linux/bpf-cgroup.h:191:22: sparse: sparse: incompatible types in comparison expression (different base types):
   include/linux/bpf-cgroup.h:191:22: sparse:    struct bpf_prog_array *
   include/linux/bpf-cgroup.h:191:22: sparse:    struct bpf_prog_array_hdr *
>> include/linux/bpf-cgroup.h:191:22: sparse: sparse: incompatible types in comparison expression (different base types):
   include/linux/bpf-cgroup.h:191:22: sparse:    struct bpf_prog_array *
   include/linux/bpf-cgroup.h:191:22: sparse:    struct bpf_prog_array_hdr *

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

