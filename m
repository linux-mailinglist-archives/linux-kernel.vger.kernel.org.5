Return-Path: <linux-kernel+bounces-93098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3974872B09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B7928C52C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908CD12DD88;
	Tue,  5 Mar 2024 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7tUP/v7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32312DD93
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681289; cv=none; b=LHhn9jh6ucnlBOAweq/3gDlkBMFMT2jvv+6H+5w6lkZWgpUII8juxN8QWJD/MpbUTIsM0AEVLgMI+TQJF8vHjyta1rVd24WChROsae5LY/dh3uPZECb9LdvoVn4YN315MjNC9zwoEc1sjdZMCU+peRIphzy/3lAwOvbT+eP0OWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681289; c=relaxed/simple;
	bh=l+GpLrX8jXy5ARpVu7GDS5gYwHPbaQFyya1zTGS42eI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KRJW8yPtB6GkJ7D2wQxHanG2NzoUj7Io8kHJcD/9ugJPuiA4vvoWcfFfYbDyGrnbdOHy50yRxi+Nw7b2HqKo5/NUbEIRnnQXFGQUjeKlgw4v5IURq+7nOlVy+W+RwpeX1w3VTYSnwPU0sAe9OXIjUJgYOq5C4ENb6ZTNxkYxYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7tUP/v7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709681286; x=1741217286;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l+GpLrX8jXy5ARpVu7GDS5gYwHPbaQFyya1zTGS42eI=;
  b=g7tUP/v7Zi5vw2Orus8r0JQCa7SVITcs4OxQD+daM/ugJ9FyWafr/Hi1
   V35lRDhkVJPgu+DLg2NXVhHS1V2pxgLcGK3KEkj54iD1wuNPOnsNwy7lt
   t2uXO/xYJOAlNUn0C7vmkRom8qHU4QG4xr7OLb61CrMoMmL3hP/Ag8VzZ
   AWquOqdd/dl1MlKAoaIrypX1esx29mTvy5Xjvcukg4ODyQnM9fO7bmNrk
   1Dd9nPLuHhoP76lwO8dqSpnzbNfVnPwgFzujoTOFhSOh7VyF1SsVYgZBv
   2BAUt7+5IWYJ/oc9FIMBt3l3LdUhCWFFAPneNIQYL1Lt+JIThOPg6jnDe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14915851"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="14915851"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 15:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="14033880"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Mar 2024 15:28:03 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rheCW-0003jx-2n;
	Tue, 05 Mar 2024 23:28:00 +0000
Date: Wed, 6 Mar 2024 07:27:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240305 1/1]
 include/linux/bpf-cgroup.h:191:15: warning: comparison of distinct pointer
 types ('struct bpf_prog_array *' and 'struct bpf_prog_array_hdr *')
Message-ID: <202403060704.3XRbwOZ1-lkp@intel.com>
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
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240306/202403060704.3XRbwOZ1-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 325f51237252e6dab8e4e1ea1fa7acbb4faee1cd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240306/202403060704.3XRbwOZ1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403060704.3XRbwOZ1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from security/apparmor/lsm.c:11:
   In file included from include/linux/lsm_hooks.h:29:
   In file included from include/linux/security.h:33:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from security/apparmor/lsm.c:11:
   In file included from include/linux/lsm_hooks.h:29:
   In file included from include/linux/security.h:35:
   include/linux/bpf.h:736:48: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     736 |         ARG_PTR_TO_MAP_VALUE_OR_NULL    = PTR_MAYBE_NULL | ARG_PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:737:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     737 |         ARG_PTR_TO_MEM_OR_NULL          = PTR_MAYBE_NULL | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:738:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     738 |         ARG_PTR_TO_CTX_OR_NULL          = PTR_MAYBE_NULL | ARG_PTR_TO_CTX,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:739:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     739 |         ARG_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:740:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     740 |         ARG_PTR_TO_STACK_OR_NULL        = PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~
   include/linux/bpf.h:741:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     741 |         ARG_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:745:38: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     745 |         ARG_PTR_TO_UNINIT_MEM           = MEM_UNINIT | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:747:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     747 |         ARG_PTR_TO_FIXED_SIZE_MEM       = MEM_FIXED_SIZE | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:770:48: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     770 |         RET_PTR_TO_MAP_VALUE_OR_NULL    = PTR_MAYBE_NULL | RET_PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:771:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     771 |         RET_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:772:47: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     772 |         RET_PTR_TO_TCP_SOCK_OR_NULL     = PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:773:50: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     773 |         RET_PTR_TO_SOCK_COMMON_OR_NULL  = PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:775:49: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     775 |         RET_PTR_TO_DYNPTR_MEM_OR_NULL   = PTR_MAYBE_NULL | RET_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:776:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     776 |         RET_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:777:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     777 |         RET_PTR_TO_BTF_ID_TRUSTED       = PTR_TRUSTED    | RET_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~    ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:888:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     888 |         PTR_TO_MAP_VALUE_OR_NULL        = PTR_MAYBE_NULL | PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~
   include/linux/bpf.h:889:42: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     889 |         PTR_TO_SOCKET_OR_NULL           = PTR_MAYBE_NULL | PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   include/linux/bpf.h:890:46: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     890 |         PTR_TO_SOCK_COMMON_OR_NULL      = PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:891:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     891 |         PTR_TO_TCP_SOCK_OR_NULL         = PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~
   include/linux/bpf.h:892:42: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     892 |         PTR_TO_BTF_ID_OR_NULL           = PTR_MAYBE_NULL | PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   In file included from security/apparmor/lsm.c:23:
   In file included from include/linux/netfilter_ipv6.h:11:
   In file included from include/net/tcp.h:47:
>> include/linux/bpf-cgroup.h:191:15: warning: comparison of distinct pointer types ('struct bpf_prog_array *' and 'struct bpf_prog_array_hdr *') [-Wcompare-distinct-pointer-types]
     191 |         return array != &bpf_empty_prog_array.hdr;
         |                ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from security/apparmor/lsm.c:23:
   In file included from include/linux/netfilter_ipv6.h:11:
   include/net/tcp.h:2450:27: error: incompatible pointer types initializing 'const struct ip_options *' with an expression of type 'struct ip_options_hdr *' [-Werror,-Wincompatible-pointer-types]
    2450 |         const struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
         |                                  ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   22 warnings and 1 error generated.
--
   In file included from net/core/filter.c:21:
   In file included from include/linux/bpf_verifier.h:7:
   In file included from include/linux/bpf.h:21:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from net/core/filter.c:21:
   In file included from include/linux/bpf_verifier.h:7:
   include/linux/bpf.h:736:48: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     736 |         ARG_PTR_TO_MAP_VALUE_OR_NULL    = PTR_MAYBE_NULL | ARG_PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:737:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     737 |         ARG_PTR_TO_MEM_OR_NULL          = PTR_MAYBE_NULL | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:738:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     738 |         ARG_PTR_TO_CTX_OR_NULL          = PTR_MAYBE_NULL | ARG_PTR_TO_CTX,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:739:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     739 |         ARG_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:740:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     740 |         ARG_PTR_TO_STACK_OR_NULL        = PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~
   include/linux/bpf.h:741:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     741 |         ARG_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:745:38: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     745 |         ARG_PTR_TO_UNINIT_MEM           = MEM_UNINIT | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:747:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     747 |         ARG_PTR_TO_FIXED_SIZE_MEM       = MEM_FIXED_SIZE | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:770:48: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     770 |         RET_PTR_TO_MAP_VALUE_OR_NULL    = PTR_MAYBE_NULL | RET_PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:771:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     771 |         RET_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:772:47: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     772 |         RET_PTR_TO_TCP_SOCK_OR_NULL     = PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:773:50: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     773 |         RET_PTR_TO_SOCK_COMMON_OR_NULL  = PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:775:49: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     775 |         RET_PTR_TO_DYNPTR_MEM_OR_NULL   = PTR_MAYBE_NULL | RET_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:776:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     776 |         RET_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:777:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     777 |         RET_PTR_TO_BTF_ID_TRUSTED       = PTR_TRUSTED    | RET_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~    ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:888:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     888 |         PTR_TO_MAP_VALUE_OR_NULL        = PTR_MAYBE_NULL | PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~
   include/linux/bpf.h:889:42: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     889 |         PTR_TO_SOCKET_OR_NULL           = PTR_MAYBE_NULL | PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   include/linux/bpf.h:890:46: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     890 |         PTR_TO_SOCK_COMMON_OR_NULL      = PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:891:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     891 |         PTR_TO_TCP_SOCK_OR_NULL         = PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~
   include/linux/bpf.h:892:42: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     892 |         PTR_TO_BTF_ID_OR_NULL           = PTR_MAYBE_NULL | PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   In file included from net/core/filter.c:39:
   In file included from include/linux/skmsg.h:13:
   In file included from include/net/tcp.h:47:
>> include/linux/bpf-cgroup.h:191:15: warning: comparison of distinct pointer types ('struct bpf_prog_array *' and 'struct bpf_prog_array_hdr *') [-Wcompare-distinct-pointer-types]
     191 |         return array != &bpf_empty_prog_array.hdr;
         |                ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from net/core/filter.c:39:
   In file included from include/linux/skmsg.h:13:
   include/net/tcp.h:2450:27: error: incompatible pointer types initializing 'const struct ip_options *' with an expression of type 'struct ip_options_hdr *' [-Werror,-Wincompatible-pointer-types]
    2450 |         const struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
         |                                  ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:1726:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1726 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:2042:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    2042 |         .arg1_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   net/core/filter.c:2044:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    2044 |         .arg3_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   net/core/filter.c:2583:35: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    2583 |         .arg2_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   net/core/filter.c:4600:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4600 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:4614:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4614 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:4814:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4814 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:4840:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4840 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5012:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5012 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5026:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5026 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5075:45: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5075 |         .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON | PTR_MAYBE_NULL,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   net/core/filter.c:5483:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5483 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5517:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5517 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5551:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5551 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5585:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5585 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5760:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5760 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6397:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6397 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6407:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6407 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6785:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6785 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6804:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6804 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6823:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6823 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6847:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6847 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6871:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6871 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6895:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6895 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6912:45: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6912 |         .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON | OBJ_RELEASE,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   net/core/filter.c:6933:35: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6933 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6957:35: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6957 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6981:35: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6981 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7001:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7001 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7020:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7020 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:7039:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7039 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
--
   In file included from net/core/skmsg.c:4:
   In file included from include/linux/skmsg.h:7:
   In file included from include/linux/bpf.h:21:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from net/core/skmsg.c:4:
   In file included from include/linux/skmsg.h:7:
   include/linux/bpf.h:736:48: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     736 |         ARG_PTR_TO_MAP_VALUE_OR_NULL    = PTR_MAYBE_NULL | ARG_PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:737:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     737 |         ARG_PTR_TO_MEM_OR_NULL          = PTR_MAYBE_NULL | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:738:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     738 |         ARG_PTR_TO_CTX_OR_NULL          = PTR_MAYBE_NULL | ARG_PTR_TO_CTX,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:739:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     739 |         ARG_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:740:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     740 |         ARG_PTR_TO_STACK_OR_NULL        = PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~
   include/linux/bpf.h:741:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     741 |         ARG_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:745:38: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     745 |         ARG_PTR_TO_UNINIT_MEM           = MEM_UNINIT | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:747:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     747 |         ARG_PTR_TO_FIXED_SIZE_MEM       = MEM_FIXED_SIZE | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:770:48: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     770 |         RET_PTR_TO_MAP_VALUE_OR_NULL    = PTR_MAYBE_NULL | RET_PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:771:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     771 |         RET_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:772:47: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     772 |         RET_PTR_TO_TCP_SOCK_OR_NULL     = PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:773:50: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     773 |         RET_PTR_TO_SOCK_COMMON_OR_NULL  = PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:775:49: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     775 |         RET_PTR_TO_DYNPTR_MEM_OR_NULL   = PTR_MAYBE_NULL | RET_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:776:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     776 |         RET_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:777:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     777 |         RET_PTR_TO_BTF_ID_TRUSTED       = PTR_TRUSTED    | RET_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~    ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:888:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     888 |         PTR_TO_MAP_VALUE_OR_NULL        = PTR_MAYBE_NULL | PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~
   include/linux/bpf.h:889:42: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     889 |         PTR_TO_SOCKET_OR_NULL           = PTR_MAYBE_NULL | PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   include/linux/bpf.h:890:46: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     890 |         PTR_TO_SOCK_COMMON_OR_NULL      = PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:891:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     891 |         PTR_TO_TCP_SOCK_OR_NULL         = PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~
   include/linux/bpf.h:892:42: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     892 |         PTR_TO_BTF_ID_OR_NULL           = PTR_MAYBE_NULL | PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   In file included from net/core/skmsg.c:4:
   In file included from include/linux/skmsg.h:13:
   In file included from include/net/tcp.h:47:
>> include/linux/bpf-cgroup.h:191:15: warning: comparison of distinct pointer types ('struct bpf_prog_array *' and 'struct bpf_prog_array_hdr *') [-Wcompare-distinct-pointer-types]
     191 |         return array != &bpf_empty_prog_array.hdr;
         |                ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from net/core/skmsg.c:4:
   In file included from include/linux/skmsg.h:13:
   include/net/tcp.h:2450:27: error: incompatible pointer types initializing 'const struct ip_options *' with an expression of type 'struct ip_options_hdr *' [-Werror,-Wincompatible-pointer-types]
    2450 |         const struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
         |                                  ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/skmsg.c:735:2: error: incomplete definition of type 'struct cm_work'
     735 |         INIT_DELAYED_WORK(&psock->work, sk_psock_backlog);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:325:2: note: expanded from macro 'INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:310:13: note: expanded from macro '__INIT_DELAYED_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:20:47: note: expanded from macro 'container_of'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/workqueue.h:300:15: note: expanded from macro 'INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:296:19: note: expanded from macro '__INIT_WORK'
     296 |                 __INIT_WORK_KEY(_work, _func, _onstack, &__key);        \
         |                 ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:285:16: note: expanded from macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   net/core/skmsg.c:735:2: note: forward declaration of 'struct cm_work'
   include/linux/workqueue.h:325:2: note: expanded from macro 'INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^
   include/linux/workqueue.h:310:49: note: expanded from macro '__INIT_DELAYED_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                                                               ^
   net/core/skmsg.c:735:2: error: offsetof of incomplete type 'struct cm_work'
     735 |         INIT_DELAYED_WORK(&psock->work, sk_psock_backlog);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:325:2: note: expanded from macro 'INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:310:13: note: expanded from macro '__INIT_DELAYED_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                           ^                            ~~~~~~
   include/linux/container_of.h:23:21: note: expanded from macro 'container_of'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^        ~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/workqueue.h:300:15: note: expanded from macro 'INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |                      ^~~~~
   include/linux/workqueue.h:296:19: note: expanded from macro '__INIT_WORK'
     296 |                 __INIT_WORK_KEY(_work, _func, _onstack, &__key);        \
         |                                 ^~~~~
   include/linux/workqueue.h:285:16: note: expanded from macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                              ^~~~~
   net/core/skmsg.c:735:2: note: forward declaration of 'struct cm_work'
   include/linux/workqueue.h:325:2: note: expanded from macro 'INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^
   include/linux/workqueue.h:310:49: note: expanded from macro '__INIT_DELAYED_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                                                               ^
   net/core/skmsg.c:735:2: error: passing 'void' to parameter of incompatible type 'struct work_struct *'
     735 |         INIT_DELAYED_WORK(&psock->work, sk_psock_backlog);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:325:2: note: expanded from macro 'INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:310:3: note: expanded from macro '__INIT_DELAYED_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:300:2: note: expanded from macro 'INIT_WORK'
     300 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:296:3: note: expanded from macro '__INIT_WORK'
     296 |                 __INIT_WORK_KEY(_work, _func, _onstack, &__key);        \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:285:15: note: expanded from macro '__INIT_WORK_KEY'
     285 |                 __init_work((_work), _onstack);                         \
         |                             ^~~~~~~
   include/linux/workqueue.h:260:52: note: passing argument to parameter 'work' here
     260 | static inline void __init_work(struct work_struct *work, int onstack) { }
         |                                                    ^
   net/core/skmsg.c:735:2: error: incomplete definition of type 'struct cm_work'
     735 |         INIT_DELAYED_WORK(&psock->work, sk_psock_backlog);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:325:2: note: expanded from macro 'INIT_DELAYED_WORK'
     325 |         __INIT_DELAYED_WORK(_work, _func, 0)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:310:13: note: expanded from macro '__INIT_DELAYED_WORK'
     310 |                 INIT_WORK(container_of(&(_work)->work, struct cm_work, hdr), (_func));                  \
         |                 ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:20:47: note: expanded from macro 'container_of'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/workqueue.h:300:15: note: expanded from macro 'INIT_WORK'
.


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

