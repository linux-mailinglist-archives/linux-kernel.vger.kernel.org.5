Return-Path: <linux-kernel+bounces-87898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09B86DAD6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326191C2100C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C70C50255;
	Fri,  1 Mar 2024 04:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyzR/aYS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01B4CB38
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709268353; cv=none; b=r8v7TsybMuyvvsQ7tEdJCUFT+leBNsboKkPsz4Jb84X0/KJwp/72rc3rxMSZJZ9nccItIAmSLUjnCDappb5Hi3GwT2537bGHiMuN20YMJJXXx52NrHn1HKNQJL6f2vrvkzxFLxGamFjcbZ3xSmE89PViYL1R7GlC7AQkHwXYoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709268353; c=relaxed/simple;
	bh=OPG2aQStA33eIEQ79Mi7D/VRphyP4XpwM0zOZBhw+RE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mFBR2FYw+4Sj2TTeKhpfUxHutWMPQ95bbLNEohJkrI85GuZoP8YPLgcoyDMdFzV4C9psenSOEQVwNyJgF6ms2ZkEdwaI3774NPDEVhsnqO4Dclay/RGiFx3t2NbkGuLd1w3icH6RKq1ExSltQ+U2WDVC3swUTIBFViOS3d0m1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyzR/aYS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709268351; x=1740804351;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OPG2aQStA33eIEQ79Mi7D/VRphyP4XpwM0zOZBhw+RE=;
  b=ZyzR/aYSr3PDR0SJPibHea7l3weDGRVola8VBKsFeohQEY1SOg+W7oUI
   tUpsxMp4SDnB/7eZPnR+Xg4exKOFTfkJAfC4yBUyXELLbEq817OHjEXOK
   wp/EGT1ros/B9cgarH9DPRl0tRhTmFQN7CsmJuthst+CN9u+VhQfEjze8
   YJeG240Nxmqcw+oKL5RFypdH9X/HMCvZ3AXZltHcrSVb1DDRjb58X2DEC
   JxQxiDZVgVR963OmIvH8skKWzWiOJJeipJ1dD50VlMJBdz+LfGFCn9FNb
   VLy4V69Dx5FI4ihJaJI2oMU+EarPmlQ5yMThKGzrmEH2bAJ7BXpFelWZa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="29215287"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="29215287"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 20:45:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8000253"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 29 Feb 2024 20:45:44 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfumD-000DXB-2Z;
	Fri, 01 Mar 2024 04:45:41 +0000
Date: Fri, 1 Mar 2024 12:45:40 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Hay <joshua.a.hay@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Alan Brady <alan.brady@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Phani Burra <phani.r.burra@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: drivers/net/ethernet/intel/idpf/idpf_txrx.c:2613:49: warning:
 bitwise operation between different enumeration types ('enum
 idpf_tx_desc_dtype_value' and 'enum idpf_tx_flex_ctx_desc_cmd_bits')
Message-ID: <202403011238.7xvDaw0y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   87adedeba51a822533649b143232418b9e26d08b
commit: a251eee62133774cf35ff829041377e721ef9c8c idpf: add SRIOV support and other ndo_ops
date:   6 months ago
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240301/202403011238.7xvDaw0y-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project edd4aee4dd9b5b98b2576a6f783e4086173d902a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240301/202403011238.7xvDaw0y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403011238.7xvDaw0y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/idpf/idpf.h:12:
   In file included from include/net/pkt_sched.h:7:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/powerpc/include/asm/cacheflush.h:7:
   In file included from include/linux/mm.h:2168:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/intel/idpf/idpf_txrx.c:4:
   In file included from drivers/net/ethernet/intel/idpf/idpf.h:24:
   In file included from drivers/net/ethernet/intel/idpf/idpf_txrx.h:8:
   In file included from include/net/tcp.h:35:
   In file included from include/net/sock_reuseport.h:5:
   In file included from include/linux/filter.h:9:
   include/linux/bpf.h:720:48: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     720 |         ARG_PTR_TO_MAP_VALUE_OR_NULL    = PTR_MAYBE_NULL | ARG_PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:721:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     721 |         ARG_PTR_TO_MEM_OR_NULL          = PTR_MAYBE_NULL | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:722:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     722 |         ARG_PTR_TO_CTX_OR_NULL          = PTR_MAYBE_NULL | ARG_PTR_TO_CTX,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:723:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     723 |         ARG_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:724:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     724 |         ARG_PTR_TO_STACK_OR_NULL        = PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~
   include/linux/bpf.h:725:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     725 |         ARG_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:729:38: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     729 |         ARG_PTR_TO_UNINIT_MEM           = MEM_UNINIT | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:731:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     731 |         ARG_PTR_TO_FIXED_SIZE_MEM       = MEM_FIXED_SIZE | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:754:48: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     754 |         RET_PTR_TO_MAP_VALUE_OR_NULL    = PTR_MAYBE_NULL | RET_PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:755:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     755 |         RET_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:756:47: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     756 |         RET_PTR_TO_TCP_SOCK_OR_NULL     = PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:757:50: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     757 |         RET_PTR_TO_SOCK_COMMON_OR_NULL  = PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:759:49: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     759 |         RET_PTR_TO_DYNPTR_MEM_OR_NULL   = PTR_MAYBE_NULL | RET_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:760:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     760 |         RET_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:761:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     761 |         RET_PTR_TO_BTF_ID_TRUSTED       = PTR_TRUSTED    | RET_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~    ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:872:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     872 |         PTR_TO_MAP_VALUE_OR_NULL        = PTR_MAYBE_NULL | PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~
   include/linux/bpf.h:873:42: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     873 |         PTR_TO_SOCKET_OR_NULL           = PTR_MAYBE_NULL | PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   include/linux/bpf.h:874:46: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     874 |         PTR_TO_SOCK_COMMON_OR_NULL      = PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:875:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     875 |         PTR_TO_TCP_SOCK_OR_NULL         = PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~
   include/linux/bpf.h:876:42: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     876 |         PTR_TO_BTF_ID_OR_NULL           = PTR_MAYBE_NULL | PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:2613:49: warning: bitwise operation between different enumeration types ('enum idpf_tx_desc_dtype_value' and 'enum idpf_tx_flex_ctx_desc_cmd_bits') [-Wenum-enum-conversion]
    2613 |                                 cpu_to_le16(IDPF_TX_DESC_DTYPE_FLEX_TSO_CTX |
         |                                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
    2614 |                                             IDPF_TX_FLEX_CTX_DESC_CMD_TSO);
         |                                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/byteorder/generic.h:90:21: note: expanded from macro 'cpu_to_le16'
      90 | #define cpu_to_le16 __cpu_to_le16
         |                     ^
   include/uapi/linux/byteorder/big_endian.h:36:53: note: expanded from macro '__cpu_to_le16'
      36 | #define __cpu_to_le16(x) ((__force __le16)__swab16((x)))
         |                                                     ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   26 warnings generated.


vim +2613 drivers/net/ethernet/intel/idpf/idpf_txrx.c

6818c4d5b3c2e9 Joshua Hay 2023-08-07  2575  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2576  /**
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2577   * idpf_tx_splitq_frame - Sends buffer on Tx ring using flex descriptors
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2578   * @skb: send buffer
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2579   * @tx_q: queue to send buffer on
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2580   *
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2581   * Returns NETDEV_TX_OK if sent, else an error code
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2582   */
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2583  static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2584  					struct idpf_queue *tx_q)
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2585  {
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2586  	struct idpf_tx_splitq_params tx_params = { };
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2587  	struct idpf_tx_buf *first;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2588  	unsigned int count;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2589  	int tso;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2590  
a5ab9ee0df0be8 Joshua Hay 2023-08-07  2591  	count = idpf_tx_desc_count_required(tx_q, skb);
a5ab9ee0df0be8 Joshua Hay 2023-08-07  2592  	if (unlikely(!count))
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2593  		return idpf_tx_drop_skb(tx_q, skb);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2594  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2595  	tso = idpf_tso(skb, &tx_params.offload);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2596  	if (unlikely(tso < 0))
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2597  		return idpf_tx_drop_skb(tx_q, skb);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2598  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2599  	/* Check for splitq specific TX resources */
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2600  	count += (IDPF_TX_DESCS_PER_CACHE_LINE + tso);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2601  	if (idpf_tx_maybe_stop_splitq(tx_q, count)) {
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2602  		idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2603  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2604  		return NETDEV_TX_BUSY;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2605  	}
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2606  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2607  	if (tso) {
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2608  		/* If tso is needed, set up context desc */
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2609  		struct idpf_flex_tx_ctx_desc *ctx_desc =
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2610  			idpf_tx_splitq_get_ctx_desc(tx_q);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2611  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2612  		ctx_desc->tso.qw1.cmd_dtype =
6818c4d5b3c2e9 Joshua Hay 2023-08-07 @2613  				cpu_to_le16(IDPF_TX_DESC_DTYPE_FLEX_TSO_CTX |
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2614  					    IDPF_TX_FLEX_CTX_DESC_CMD_TSO);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2615  		ctx_desc->tso.qw0.flex_tlen =
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2616  				cpu_to_le32(tx_params.offload.tso_len &
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2617  					    IDPF_TXD_FLEX_CTX_TLEN_M);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2618  		ctx_desc->tso.qw0.mss_rt =
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2619  				cpu_to_le16(tx_params.offload.mss &
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2620  					    IDPF_TXD_FLEX_CTX_MSS_RT_M);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2621  		ctx_desc->tso.qw0.hdr_len = tx_params.offload.tso_hdr_len;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2622  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2623  		u64_stats_update_begin(&tx_q->stats_sync);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2624  		u64_stats_inc(&tx_q->q_stats.tx.lso_pkts);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2625  		u64_stats_update_end(&tx_q->stats_sync);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2626  	}
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2627  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2628  	/* record the location of the first descriptor for this packet */
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2629  	first = &tx_q->tx_buf[tx_q->next_to_use];
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2630  	first->skb = skb;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2631  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2632  	if (tso) {
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2633  		first->gso_segs = tx_params.offload.tso_segs;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2634  		first->bytecount = skb->len +
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2635  			((first->gso_segs - 1) * tx_params.offload.tso_hdr_len);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2636  	} else {
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2637  		first->gso_segs = 1;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2638  		first->bytecount = max_t(unsigned int, skb->len, ETH_ZLEN);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2639  	}
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2640  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2641  	if (test_bit(__IDPF_Q_FLOW_SCH_EN, tx_q->flags)) {
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2642  		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2643  		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2644  		/* Set the RE bit to catch any packets that may have not been
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2645  		 * stashed during RS completion cleaning. MIN_GAP is set to
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2646  		 * MIN_RING size to ensure it will be set at least once each
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2647  		 * time around the ring.
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2648  		 */
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2649  		if (!(tx_q->next_to_use % IDPF_TX_SPLITQ_RE_MIN_GAP)) {
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2650  			tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2651  			tx_q->txq_grp->num_completions_pending++;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2652  		}
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2653  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2654  		if (skb->ip_summed == CHECKSUM_PARTIAL)
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2655  			tx_params.offload.td_cmd |= IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2656  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2657  	} else {
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2658  		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_L2TAG1_L2TAG2;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2659  		tx_params.eop_cmd = IDPF_TXD_LAST_DESC_CMD;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2660  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2661  		if (skb->ip_summed == CHECKSUM_PARTIAL)
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2662  			tx_params.offload.td_cmd |= IDPF_TX_FLEX_DESC_CMD_CS_EN;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2663  	}
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2664  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2665  	idpf_tx_splitq_map(tx_q, &tx_params, first);
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2666  
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2667  	return NETDEV_TX_OK;
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2668  }
6818c4d5b3c2e9 Joshua Hay 2023-08-07  2669  

:::::: The code at line 2613 was first introduced by commit
:::::: 6818c4d5b3c2e9dd5d7316792f88d371d07d0ebf idpf: add splitq start_xmit

:::::: TO: Joshua Hay <joshua.a.hay@intel.com>
:::::: CC: Tony Nguyen <anthony.l.nguyen@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

