Return-Path: <linux-kernel+bounces-73755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9348085CA87
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9C12838CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FF3152E08;
	Tue, 20 Feb 2024 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBPMQtVg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C746152DE5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467283; cv=none; b=RaoAr/p6TReZeibknmoSTHCce+wk8BWxQS1oFw2WuHyFtpRi5RNwPx5GcRrNlR3SKVN/ssVYKxPmaaWceAO9MjFxmX8aclTgEQSgi+SNswckItWxRxJrt5o7PwB4wIAniQbAXeIEnPNqytlO7ZbY79YE4tZWW19i4y8RUVPxJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467283; c=relaxed/simple;
	bh=ZcAgG6kvQhsC9m6bmx9Pcc97f+FHLjIL0PygQJBSyNo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sNYEb4xqNFT5GtLZUwDxNGFLYpy58lqe3Dmm5/IQ9Rtya+gxhN8SjudkGtXWnl9j5/xUixDXuah4L7s5jE4GcvgP18pfJfn+nGZ/dCfpnDPsvfsPg1EGjLoRbf12hk6O2ZT0pOE7gHGLtRcgi63Y9MnVLiAtl12JLeE5GAMM/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBPMQtVg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708467281; x=1740003281;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZcAgG6kvQhsC9m6bmx9Pcc97f+FHLjIL0PygQJBSyNo=;
  b=YBPMQtVglOqeSJypY4+D3baMddRFSJTZp8/lu9YxgBRrlTXZEinbxloE
   Ec7IxW15J72td6TcbQUYFBMy9QE9mtgtLIRADE83z+mvNlif4JfLWASB7
   HlEhTASnHbPLD5AtopOowmQvy3QD/Gh1ZbZlfXCSlvU5e/5vk9jmK61vp
   O8WwP+YwzbRL0WzYHjcU6A8fkh2nrjlzMAgjWpBiwaikWfQdjZqY1U2qx
   5WjAnLPItJkrRtjt8xPgE2eTdYD6ZnSblFVv2/JEJfABwBPKH1a6dovma
   hBXt+vAv49Q9AFHy10oIoXWsATIKLEmzA82D/H3zG/+4I6pRULaBU24Yv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13224144"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="13224144"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 14:14:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5076417"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 20 Feb 2024 14:14:39 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcYNp-0004qe-1S;
	Tue, 20 Feb 2024 22:14:37 +0000
Date: Wed, 21 Feb 2024 06:14:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240215 1/1]
 kernel/bpf/core.c:2440:29: sparse: sparse: incompatible types in comparison
 expression (different base types):
Message-ID: <202402210653.mABjvUDs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240215
head:   3fedbc527c5726b876207557fb133a5e558c1898
commit: 89595f31005e412f450050f66a1b11c54cec99f8 [1/1] treewide: Address -Wflexible-array-member-not-at-end warnings
config: x86_64-randconfig-121-20240220 (https://download.01.org/0day-ci/archive/20240221/202402210653.mABjvUDs-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240221/202402210653.mABjvUDs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402210653.mABjvUDs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/bpf/core.c:236:49: sparse: sparse: arithmetics on pointers to functions
   kernel/bpf/core.c:1986:43: sparse: sparse: arithmetics on pointers to functions
   kernel/bpf/core.c:1991:48: sparse: sparse: arithmetics on pointers to functions
>> kernel/bpf/core.c:2440:29: sparse: sparse: incompatible types in comparison expression (different base types):
   kernel/bpf/core.c:2440:29: sparse:    struct bpf_prog_array *
   kernel/bpf/core.c:2440:29: sparse:    struct bpf_prog_array_tag *
   kernel/bpf/core.c:2461:29: sparse: sparse: incompatible types in comparison expression (different base types):
   kernel/bpf/core.c:2461:29: sparse:    struct bpf_prog_array *
   kernel/bpf/core.c:2461:29: sparse:    struct bpf_prog_array_tag *
   kernel/bpf/core.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/xdp.h, ...):
   include/trace/events/xdp.h:321:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/xdp.h:348:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/xdp.h:382:1: sparse: sparse: Using plain integer as NULL pointer

vim +2440 kernel/bpf/core.c

324bda9e6c5add Alexei Starovoitov 2017-10-02  2437  
54e9c9d4b506b6 Stanislav Fomichev 2019-05-28  2438  void bpf_prog_array_free(struct bpf_prog_array *progs)
324bda9e6c5add Alexei Starovoitov 2017-10-02  2439  {
46531a30364bd4 Pavel Begunkov     2022-01-27 @2440  	if (!progs || progs == &bpf_empty_prog_array.hdr)
324bda9e6c5add Alexei Starovoitov 2017-10-02  2441  		return;
324bda9e6c5add Alexei Starovoitov 2017-10-02  2442  	kfree_rcu(progs, rcu);
324bda9e6c5add Alexei Starovoitov 2017-10-02  2443  }
324bda9e6c5add Alexei Starovoitov 2017-10-02  2444  

:::::: The code at line 2440 was first introduced by commit
:::::: 46531a30364bd483bfa1b041c15d42a196e77e93 cgroup/bpf: fast path skb BPF filtering

:::::: TO: Pavel Begunkov <asml.silence@gmail.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

