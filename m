Return-Path: <linux-kernel+bounces-60636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF168507D0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 06:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF15FB2324F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 05:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3396D12E52;
	Sun, 11 Feb 2024 05:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EmHOJcb9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3AFBF0
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707627657; cv=none; b=lhy1DhZfrloOa0ykY1+SJFs+ZaRANXNbJRnW9jFccAMHysTsXq7LNDEyvCRuFjStzv2Sfz5+nAOVvVzOC/+u5b8p9CQ/SyUoT4qUcnXfLWtIav0FPXniRyOyU8Jo8F9xatTxhYMxjCXL+zWNE4cinouGRE1aSCIZOMba466xInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707627657; c=relaxed/simple;
	bh=ZTIAtomDXb7PIR36T0XDaZ3uyTViAuhuijNuyt/OhHU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ggn7Z7+wBRajY2oIn8dGmYAiIGAA451UGH79JcLRfwr1QU2p7YWZyPHcIHUqp/LfTk6FjKGdFgr5lI0xYb4bQZjKrx1wtCDfnxW4VrgebQAERQlgq/fO5I8Dg+7vd2HYW7vBno1+5kmNjt/Ui5zxZ1UldV+kxwlYQ0uAaY73UsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EmHOJcb9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707627651; x=1739163651;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZTIAtomDXb7PIR36T0XDaZ3uyTViAuhuijNuyt/OhHU=;
  b=EmHOJcb9Swb6i1aFA6R7FxqsyxW1ip6XwwymoZBW5g9SvZiCC2cBV7VV
   Sj6IIWUZ3S0jq6OfJ1YLCTD6NfBMuU3EM0c1nlo3TC99lHgD22evjsrbQ
   8tsclwCp0ewJVOIDrUfm/PTgbzbNwtaYPblRuXG8v+zfvlLyf/9Japb35
   h1g847/sECXo7Ah0dBKlF7oORZ503t3lT3k29K58hfvIO1XTqvj3BeKmR
   t8w2yg29/Fd807MQY4Jz1uwxyk5tswF9H5NvkpZBNfz7WbOqE5Xmyubui
   4X/bpQGb/S8neLPg2ZFMxUbRKFg+KnLlItcCzuiwNiUGLJJQ0Y52cAYeX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="1490012"
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="1490012"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 21:00:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="2640682"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Feb 2024 21:00:47 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZ1xM-0006Kc-2d;
	Sun, 11 Feb 2024 05:00:44 +0000
Date: Sun, 11 Feb 2024 13:00:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/fork.c:1601:13: sparse: sparse: dereference of noderef
 expression
Message-ID: <202402111222.APeeNYXD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a5b6244cf87c50358f5562b8f07f7ac35fc7f6b0
commit: 41a2901e7d220875752a8c870e0b53288a578c20 rcu: Remove SPARSE_RCU_POINTER Kconfig option
date:   7 years ago
config: openrisc-randconfig-s041-20230115 (https://download.01.org/0day-ci/archive/20240211/202402111222.APeeNYXD-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240211/202402111222.APeeNYXD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402111222.APeeNYXD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/fork.c:1144:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> *clear_child_tid @@
   kernel/fork.c:1144:25: sparse:     expected int *__pu_addr
   kernel/fork.c:1144:25: sparse:     got int [noderef] <asn:1> *clear_child_tid
   kernel/fork.c:1326:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/fork.c:1326:9: sparse:    struct sighand_struct [noderef] <asn:4> *
   kernel/fork.c:1326:9: sparse:    struct sighand_struct *
   kernel/fork.c:1831:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] <asn:4> *real_parent @@     got struct task_struct *task @@
   kernel/fork.c:1831:32: sparse:     expected struct task_struct [noderef] <asn:4> *real_parent
   kernel/fork.c:1831:32: sparse:     got struct task_struct *task
   kernel/fork.c:1885:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] <asn:4> * @@
   kernel/fork.c:1885:54: sparse:     expected struct list_head *head
   kernel/fork.c:1885:54: sparse:     got struct list_head [noderef] <asn:4> *
   kernel/fork.c:2045:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> *parent_tidptr @@
   kernel/fork.c:2045:25: sparse:     expected int *__pu_addr
   kernel/fork.c:2045:25: sparse:     got int [noderef] <asn:1> *parent_tidptr
   kernel/fork.c:2166:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/fork.c:2166:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2166:24: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
>> kernel/fork.c:1601:13: sparse: sparse: dereference of noderef expression
>> kernel/fork.c:1601:13: sparse: sparse: dereference of noderef expression
>> kernel/fork.c:1601:13: sparse: sparse: dereference of noderef expression
>> kernel/fork.c:1601:13: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1603:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/linux/ftrace.h, include/linux/perf_event.h, include/linux/trace_events.h, ...):
   include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] <asn:4> *parent @@
   include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] <asn:4> *parent
   include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] <asn:4> *ptracer_cred @@
   include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] <asn:4> *ptracer_cred
   kernel/fork.c:1883:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1884:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1960:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1960:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c:145:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     145 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:163:13: warning: no previous prototype for 'arch_release_thread_stack' [-Wmissing-prototypes]
     163 | void __weak arch_release_thread_stack(unsigned long *stack)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:430:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     430 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:460:13: warning: no previous prototype for 'fork_init' [-Wmissing-prototypes]
     460 | void __init fork_init(void)
         |             ^~~~~~~~~
   kernel/fork.c:495:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     495 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c: In function 'dup_task_struct':
   kernel/fork.c:514:27: warning: variable 'stack_vm_area' set but not used [-Wunused-but-set-variable]
     514 |         struct vm_struct *stack_vm_area;
         |                           ^~~~~~~~~~~~~
   In file included from kernel/fork.c:51:
   kernel/fork.c: At top level:
   include/linux/syscalls.h:196:25: warning: 'sys_set_tid_address' alias between functions of incompatible types 'long int(int *)' and 'long int(long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       64-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:183:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     183 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/fork.c:1452:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    1452 | SYSCALL_DEFINE1(set_tid_address, int __user *, tidptr)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       76-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:183:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     183 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/fork.c:1452:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    1452 | SYSCALL_DEFINE1(set_tid_address, int __user *, tidptr)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:196:25: warning: 'sys_unshare' alias between functions of incompatible types 'long int(long unsigned int)' and 'long int(long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       88-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:183:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     183 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/fork.c:2299:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    2299 | SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       100-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:183:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     183 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/fork.c:2299:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    2299 | SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:196:25: warning: 'sys_clone' alias between functions of incompatible types 'long int(long unsigned int,  long unsigned int,  int *, int *, long unsigned int)' and 'long int(long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       112-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:187:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     187 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/fork.c:2132:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    2132 | SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       124-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:187:36: note: in expansion of macro 'SYSCALL_DEFINEx'
--
   kernel/exit.c:98:19: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/exit.c:98:19: sparse:    struct sighand_struct [noderef] <asn:4> *
   kernel/exit.c:98:19: sparse:    struct sighand_struct *
   kernel/exit.c:245:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/exit.c:245:16: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/exit.c:245:16: sparse:    struct task_struct *
   kernel/exit.c:315:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/exit.c:315:16: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/exit.c:315:16: sparse:    struct task_struct *
   kernel/exit.c:350:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/exit.c:350:37: sparse:     expected struct task_struct *tsk
   kernel/exit.c:350:37: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:353:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/exit.c:353:32: sparse:     expected struct task_struct *task
   kernel/exit.c:353:32: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:354:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/exit.c:354:35: sparse:     expected struct task_struct *task
   kernel/exit.c:354:35: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:399:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/exit.c:399:24: sparse:     expected struct task_struct *parent
   kernel/exit.c:399:24: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:626:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/exit.c:626:29: sparse:     expected struct task_struct *reaper
   kernel/exit.c:626:29: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:628:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/exit.c:628:29: sparse:     expected struct task_struct *reaper
   kernel/exit.c:628:29: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:690:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] <asn:4> *real_parent @@     got struct task_struct *[assigned] reaper @@
   kernel/exit.c:690:40: sparse:     expected struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:690:40: sparse:     got struct task_struct *[assigned] reaper
   kernel/exit.c:691:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/exit.c:691:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/exit.c:691:25: sparse:    struct task_struct *
   kernel/exit.c:1063:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1063:34: sparse:     expected int *__pu_addr
   kernel/exit.c:1063:34: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1065:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1065:34: sparse:     expected int *__pu_addr
   kernel/exit.c:1065:34: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1067:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1067:34: sparse:     expected int *__pu_addr
   kernel/exit.c:1067:34: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1069:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1069:34: sparse:     expected int *__pu_addr
   kernel/exit.c:1069:34: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1071:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] <asn:1> * @@
   kernel/exit.c:1071:34: sparse:     expected unsigned int *__pu_addr
   kernel/exit.c:1071:34: sparse:     got unsigned int [noderef] <asn:1> *
   kernel/exit.c:1073:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1073:34: sparse:     expected int *__pu_addr
   kernel/exit.c:1073:34: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1189:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> *wo_stat @@
   kernel/exit.c:1189:26: sparse:     expected int *__pu_addr
   kernel/exit.c:1189:26: sparse:     got int [noderef] <asn:1> *wo_stat
   kernel/exit.c:1193:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1193:26: sparse:     expected int *__pu_addr
   kernel/exit.c:1193:26: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1195:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1195:26: sparse:     expected int *__pu_addr
   kernel/exit.c:1195:26: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1206:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1206:26: sparse:     expected int *__pu_addr
   kernel/exit.c:1206:26: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1208:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1208:34: sparse:     expected int *__pu_addr
   kernel/exit.c:1208:34: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1211:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1211:26: sparse:     expected int *__pu_addr
   kernel/exit.c:1211:26: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1213:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] <asn:1> * @@
   kernel/exit.c:1213:26: sparse:     expected unsigned int *__pu_addr
   kernel/exit.c:1213:26: sparse:     got unsigned int [noderef] <asn:1> *
   kernel/exit.c:1321:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> *wo_stat @@
   kernel/exit.c:1321:26: sparse:     expected int *__pu_addr
   kernel/exit.c:1321:26: sparse:     got int [noderef] <asn:1> *wo_stat
   kernel/exit.c:1325:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1325:26: sparse:     expected int *__pu_addr
   kernel/exit.c:1325:26: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1327:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1327:26: sparse:     expected int *__pu_addr
   kernel/exit.c:1327:26: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1329:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1329:26: sparse:     expected int *__pu_addr
   kernel/exit.c:1329:26: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1331:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1331:26: sparse:     expected int *__pu_addr
   kernel/exit.c:1331:26: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1333:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1333:26: sparse:     expected int *__pu_addr
   kernel/exit.c:1333:26: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1335:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] <asn:1> * @@
   kernel/exit.c:1335:26: sparse:     expected unsigned int *__pu_addr
   kernel/exit.c:1335:26: sparse:     got unsigned int [noderef] <asn:1> *
   kernel/exit.c:1383:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> *wo_stat @@
   kernel/exit.c:1383:34: sparse:     expected int *__pu_addr
   kernel/exit.c:1383:34: sparse:     got int [noderef] <asn:1> *wo_stat
>> kernel/exit.c:1554:59: sparse: sparse: incompatible types in comparison expression (different base types):
   kernel/exit.c:1554:59: sparse:    void *
   kernel/exit.c:1554:59: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:91:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   include/linux/ptrace.h:91:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:91:40: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   include/linux/ptrace.h:91:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] <asn:4> *parent @@
   include/linux/ptrace.h:91:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:91:60: sparse:     got struct task_struct [noderef] <asn:4> *parent
   include/linux/ptrace.h:91:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   include/linux/ptrace.h:91:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:91:40: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   include/linux/ptrace.h:91:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] <asn:4> *parent @@
   include/linux/ptrace.h:91:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:91:60: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/exit.c:1097:17: sparse: sparse: context imbalance in 'wait_task_zombie' - unexpected unlock
   kernel/exit.c:1309:9: sparse: sparse: context imbalance in 'wait_task_stopped' - unexpected unlock
   kernel/exit.c: note: in included file (through include/linux/ipc.h, include/uapi/linux/sem.h, include/linux/sem.h, ...):
   include/linux/uidgid.h:167:9: sparse: sparse: context imbalance in 'wait_task_continued' - unexpected unlock
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:91:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   include/linux/ptrace.h:91:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:91:40: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   include/linux/ptrace.h:91:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] <asn:4> *parent @@
   include/linux/ptrace.h:91:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:91:60: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/exit.c:1615:9: sparse: sparse: context imbalance in 'do_wait' - different lock contexts for basic block
   kernel/exit.c:1672:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1672:31: sparse:     expected int *__pu_addr
   kernel/exit.c:1672:31: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1674:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1674:31: sparse:     expected int *__pu_addr
   kernel/exit.c:1674:31: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1676:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1676:31: sparse:     expected int *__pu_addr
   kernel/exit.c:1676:31: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1678:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1678:31: sparse:     expected int *__pu_addr
   kernel/exit.c:1678:31: sparse:     got int [noderef] <asn:1> *
   kernel/exit.c:1680:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] <asn:1> * @@
   kernel/exit.c:1680:31: sparse:     expected unsigned int *__pu_addr
   kernel/exit.c:1680:31: sparse:     got unsigned int [noderef] <asn:1> *
   kernel/exit.c:1682:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> * @@
   kernel/exit.c:1682:31: sparse:     expected int *__pu_addr
   kernel/exit.c:1682:31: sparse:     got int [noderef] <asn:1> *
   In file included from kernel/exit.c:41:
   include/linux/syscalls.h:196:25: warning: 'sys_wait4' alias between functions of incompatible types 'long int(pid_t,  int *, int,  struct rusage *)' {aka 'long int(int,  int *, int,  struct rusage *)'} and 'long int(long int,  long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       146-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:186:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     186 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/exit.c:1689:1: note: in expansion of macro 'SYSCALL_DEFINE4'
    1689 | SYSCALL_DEFINE4(wait4, pid_t, upid, int __user *, stat_addr,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       158-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:186:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     186 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/exit.c:1689:1: note: in expansion of macro 'SYSCALL_DEFINE4'
    1689 | SYSCALL_DEFINE4(wait4, pid_t, upid, int __user *, stat_addr,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:196:25: warning: 'sys_waitid' alias between functions of incompatible types 'long int(int,  pid_t,  struct siginfo *, int,  struct rusage *)' {aka 'long int(int,  int,  struct siginfo *, int,  struct rusage *)'} and 'long int(long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       170-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:187:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     187 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/exit.c:1620:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1620 | SYSCALL_DEFINE5(waitid, int, which, pid_t, upid, struct siginfo __user *,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       182-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:187:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     187 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/exit.c:1620:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1620 | SYSCALL_DEFINE5(waitid, int, which, pid_t, upid, struct siginfo __user *,
         | ^~~~~~~~~~~~~~~
--
>> kernel/ptrace.c:49:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:49:22: sparse:    struct task_struct *
   kernel/ptrace.c:49:22: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/ptrace.c:68:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] <asn:4> *parent @@     got struct task_struct *new_parent @@
   kernel/ptrace.c:68:23: sparse:     expected struct task_struct [noderef] <asn:4> *parent
   kernel/ptrace.c:68:23: sparse:     got struct task_struct *new_parent
   kernel/ptrace.c:69:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] <asn:4> *ptracer_cred @@     got struct cred const * @@
   kernel/ptrace.c:69:29: sparse:     expected struct cred const [noderef] <asn:4> *ptracer_cred
   kernel/ptrace.c:69:29: sparse:     got struct cred const *
   kernel/ptrace.c:122:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] <asn:4> *ptracer_cred @@
   kernel/ptrace.c:122:18: sparse:     expected struct cred const *old_cred
   kernel/ptrace.c:122:18: sparse:     got struct cred const [noderef] <asn:4> *ptracer_cred
   kernel/ptrace.c:191:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:191:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/ptrace.c:191:9: sparse:    struct task_struct *
   kernel/ptrace.c:236:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:236:44: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/ptrace.c:236:44: sparse:    struct task_struct *
   kernel/ptrace.c:460:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] <asn:4> *parent @@
   kernel/ptrace.c:460:54: sparse:     expected struct task_struct *parent
   kernel/ptrace.c:460:54: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/ptrace.c:468:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/ptrace.c:468:53: sparse:     expected struct task_struct *new_parent
   kernel/ptrace.c:468:53: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/ptrace.c:516:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/ptrace.c:516:41: sparse:     expected struct task_struct *p1
   kernel/ptrace.c:516:41: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/ptrace.c:910:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__pu_addr @@     got unsigned long [noderef] <asn:1> *datalp @@
   kernel/ptrace.c:910:23: sparse:     expected unsigned long *__pu_addr
   kernel/ptrace.c:910:23: sparse:     got unsigned long [noderef] <asn:1> *datalp
   kernel/ptrace.c:1177:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__pu_addr @@     got unsigned long [noderef] <asn:1> * @@
   kernel/ptrace.c:1177:16: sparse:     expected unsigned long *__pu_addr
   kernel/ptrace.c:1177:16: sparse:     got unsigned long [noderef] <asn:1> *
>> kernel/ptrace.c:466:38: sparse: sparse: dereference of noderef expression
   kernel/ptrace.c: note: in included file (through include/linux/highmem.h):
   include/linux/uaccess.h:128:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] <asn:1> *to @@
   include/linux/uaccess.h:128:38: sparse:     expected void *to
   include/linux/uaccess.h:128:38: sparse:     got void [noderef] <asn:1> *to
   include/linux/uaccess.h:128:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *from @@
   include/linux/uaccess.h:128:42: sparse:     expected void const [noderef] <asn:1> *from
   include/linux/uaccess.h:128:42: sparse:     got void const *from
   kernel/ptrace.c: note: in included file (through include/linux/uaccess.h, include/linux/highmem.h):
   arch/openrisc/include/asm/uaccess.h:247:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] <asn:1> *from @@
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     got void const [noderef] <asn:1> *from
   kernel/ptrace.c:667:9: sparse: sparse: context imbalance in 'ptrace_getsiginfo' - different lock contexts for basic block
   kernel/ptrace.c:683:9: sparse: sparse: context imbalance in 'ptrace_setsiginfo' - different lock contexts for basic block
   kernel/ptrace.c:835:9: sparse: sparse: context imbalance in 'ptrace_resume' - different lock contexts for basic block
   kernel/ptrace.c: note: in included file (through include/linux/highmem.h):
   include/linux/uaccess.h:128:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] <asn:1> *to @@
   include/linux/uaccess.h:128:38: sparse:     expected void *to
   include/linux/uaccess.h:128:38: sparse:     got void [noderef] <asn:1> *to
   include/linux/uaccess.h:128:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *from @@
   include/linux/uaccess.h:128:42: sparse:     expected void const [noderef] <asn:1> *from
   include/linux/uaccess.h:128:42: sparse:     got void const *from
   kernel/ptrace.c: note: in included file (through include/linux/uaccess.h, include/linux/highmem.h):
   arch/openrisc/include/asm/uaccess.h:247:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] <asn:1> *from @@
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     got void const [noderef] <asn:1> *from
   kernel/ptrace.c:1101:9: sparse: sparse: context imbalance in 'ptrace_request' - different lock contexts for basic block
   In file included from kernel/ptrace.c:26:
   include/linux/syscalls.h:196:25: warning: 'sys_ptrace' alias between functions of incompatible types 'long int(long int,  long int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       64-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:186:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     186 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/ptrace.c:1123:1: note: in expansion of macro 'SYSCALL_DEFINE4'
    1123 | SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       76-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:186:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     186 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/ptrace.c:1123:1: note: in expansion of macro 'SYSCALL_DEFINE4'
    1123 | SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
         | ^~~~~~~~~~~~~~~
--
   kernel/signal.c:1232:27: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/signal.c:1232:27: sparse:    struct sighand_struct [noderef] <asn:4> *
   kernel/signal.c:1232:27: sparse:    struct sighand_struct *
   kernel/signal.c:1622:65: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] <asn:4> *parent @@
   kernel/signal.c:1622:65: sparse:     expected struct task_struct *tsk
   kernel/signal.c:1622:65: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:1623:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *p @@     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> * @@
   kernel/signal.c:1623:40: sparse:     expected void const volatile *p
   kernel/signal.c:1623:40: sparse:     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
   kernel/signal.c:1623:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *p @@     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> * @@
   kernel/signal.c:1623:40: sparse:     expected void const volatile *p
   kernel/signal.c:1623:40: sparse:     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
   kernel/signal.c:1666:54: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] <asn:4> *parent @@
   kernel/signal.c:1666:54: sparse:     expected struct task_struct *p
   kernel/signal.c:1666:54: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:1667:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] <asn:4> *parent @@
   kernel/signal.c:1667:34: sparse:     expected struct task_struct *parent
   kernel/signal.c:1667:34: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:1696:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] <asn:4> *parent @@
   kernel/signal.c:1696:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:1696:24: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:1699:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/signal.c:1699:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:1699:24: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/signal.c:2126:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] <asn:4> *parent @@
   kernel/signal.c:2126:52: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2126:52: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:2128:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *p @@     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> * @@
   kernel/signal.c:2128:49: sparse:     expected void const volatile *p
   kernel/signal.c:2128:49: sparse:     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
   kernel/signal.c:2128:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *p @@     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> * @@
   kernel/signal.c:2128:49: sparse:     expected void const volatile *p
   kernel/signal.c:2128:49: sparse:     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
   kernel/signal.c:1156:9: sparse: sparse: context imbalance in 'do_send_sig_info' - different lock contexts for basic block
   kernel/signal.c:1259:9: sparse: sparse: context imbalance in '__lock_task_sighand' - different lock contexts for basic block
   kernel/signal.c:1573:9: sparse: sparse: context imbalance in 'send_sigqueue' - different lock contexts for basic block
>> kernel/signal.c:1604:47: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1623:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1623:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1623:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1623:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1641:19: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1761:13: sparse: sparse: dereference of noderef expression
   kernel/signal.c: note: in included file (through include/linux/ftrace.h, include/linux/perf_event.h, include/linux/trace_events.h, ...):
   include/linux/ptrace.h:91:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   include/linux/ptrace.h:91:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:91:40: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   include/linux/ptrace.h:91:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] <asn:4> *parent @@
   include/linux/ptrace.h:91:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:91:60: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:1957:13: sparse: sparse: context imbalance in 'do_signal_stop' - different lock contexts for basic block
   kernel/signal.c:2128:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2128:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2128:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2128:49: sparse: sparse: dereference of noderef expression
   include/linux/ptrace.h:91:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   include/linux/ptrace.h:91:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:91:40: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   include/linux/ptrace.h:91:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] <asn:4> *parent @@
   include/linux/ptrace.h:91:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:91:60: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:2206:25: sparse: sparse: context imbalance in 'get_signal' - unexpected unlock
   kernel/signal.c: note: in included file (through include/asm-generic/termios.h, arch/openrisc/include/generated/asm/termios.h, include/uapi/linux/termios.h, ...):
   include/linux/uaccess.h:128:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] <asn:1> *to @@
   include/linux/uaccess.h:128:38: sparse:     expected void *to
   include/linux/uaccess.h:128:38: sparse:     got void [noderef] <asn:1> *to
   include/linux/uaccess.h:128:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *from @@
   include/linux/uaccess.h:128:42: sparse:     expected void const [noderef] <asn:1> *from
   include/linux/uaccess.h:128:42: sparse:     got void const *from
   kernel/signal.c: note: in included file (through include/linux/uaccess.h, include/asm-generic/termios.h, arch/openrisc/include/generated/asm/termios.h, ...):
   arch/openrisc/include/asm/uaccess.h:247:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] <asn:1> *from @@
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     got void const [noderef] <asn:1> *from
   kernel/signal.c: note: in included file (through include/asm-generic/termios.h, arch/openrisc/include/generated/asm/termios.h, include/uapi/linux/termios.h, ...):
   include/linux/uaccess.h:128:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] <asn:1> *to @@
   include/linux/uaccess.h:128:38: sparse:     expected void *to
   include/linux/uaccess.h:128:38: sparse:     got void [noderef] <asn:1> *to
   include/linux/uaccess.h:128:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *from @@
   include/linux/uaccess.h:128:42: sparse:     expected void const [noderef] <asn:1> *from
   include/linux/uaccess.h:128:42: sparse:     got void const *from
   kernel/signal.c: note: in included file (through include/linux/uaccess.h, include/asm-generic/termios.h, arch/openrisc/include/generated/asm/termios.h, ...):
   arch/openrisc/include/asm/uaccess.h:247:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] <asn:1> *from @@
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     got void const [noderef] <asn:1> *from
   kernel/signal.c: note: in included file (through include/asm-generic/termios.h, arch/openrisc/include/generated/asm/termios.h, include/uapi/linux/termios.h, ...):
   include/linux/uaccess.h:104:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] <asn:1> *to @@
   include/linux/uaccess.h:104:33: sparse:     expected void *to
   include/linux/uaccess.h:104:33: sparse:     got void [noderef] <asn:1> *to
   include/linux/uaccess.h:104:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *from @@
   include/linux/uaccess.h:104:37: sparse:     expected void const [noderef] <asn:1> *from
   include/linux/uaccess.h:104:37: sparse:     got void const *from
   kernel/signal.c: note: in included file (through include/linux/uaccess.h, include/asm-generic/termios.h, arch/openrisc/include/generated/asm/termios.h, ...):
   arch/openrisc/include/asm/uaccess.h:247:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] <asn:1> *from @@
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     got void const [noderef] <asn:1> *from
   kernel/signal.c: note: in included file (through include/asm-generic/termios.h, arch/openrisc/include/generated/asm/termios.h, include/uapi/linux/termios.h, ...):
   include/linux/uaccess.h:128:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] <asn:1> *to @@
   include/linux/uaccess.h:128:38: sparse:     expected void *to
   include/linux/uaccess.h:128:38: sparse:     got void [noderef] <asn:1> *to
   include/linux/uaccess.h:128:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *from @@
   include/linux/uaccess.h:128:42: sparse:     expected void const [noderef] <asn:1> *from
   include/linux/uaccess.h:128:42: sparse:     got void const *from
   kernel/signal.c: note: in included file (through include/linux/uaccess.h, include/asm-generic/termios.h, arch/openrisc/include/generated/asm/termios.h, ...):
   arch/openrisc/include/asm/uaccess.h:247:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] <asn:1> *from @@
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     got void const [noderef] <asn:1> *from
   kernel/signal.c:3065:13: warning: no previous prototype for 'sigaction_compat_abi' [-Wmissing-prototypes]
    3065 | void __weak sigaction_compat_abi(struct k_sigaction *act,
         |             ^~~~~~~~~~~~~~~~~~~~
   In file included from kernel/signal.c:27:
   include/linux/syscalls.h:196:25: warning: 'sys_rt_sigprocmask' alias between functions of incompatible types 'long int(int,  sigset_t *, sigset_t *, size_t)' {aka 'long int(int,  sigset_t *, sigset_t *, unsigned int)'} and 'long int(long int,  long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       114-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:186:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     186 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/signal.c:2553:1: note: in expansion of macro 'SYSCALL_DEFINE4'
    2553 | SYSCALL_DEFINE4(rt_sigprocmask, int, how, sigset_t __user *, nset,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       126-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:186:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     186 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/signal.c:2553:1: note: in expansion of macro 'SYSCALL_DEFINE4'
    2553 | SYSCALL_DEFINE4(rt_sigprocmask, int, how, sigset_t __user *, nset,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:196:25: warning: 'sys_rt_sigsuspend' alias between functions of incompatible types 'long int(sigset_t *, size_t)' {aka 'long int(sigset_t *, unsigned int)'} and 'long int(long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       138-      |                         ^~~
--
>> kernel/pid.c:471:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/pid.c:471:23: sparse:    struct pid [noderef] <asn:4> *
   kernel/pid.c:471:23: sparse:    struct pid *
   kernel/pid.c:532:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/pid.c:532:32: sparse:    struct pid [noderef] <asn:4> *
   kernel/pid.c:532:32: sparse:    struct pid *
--
   kernel/notifier.c:27:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:27:20: sparse:     expected struct notifier_block **nl
   kernel/notifier.c:27:20: sparse:     got struct notifier_block [noderef] <asn:4> **
   kernel/notifier.c:29:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block [noderef] <asn:4> *next @@     got struct notifier_block * @@
   kernel/notifier.c:29:17: sparse:     expected struct notifier_block [noderef] <asn:4> *next
   kernel/notifier.c:29:17: sparse:     got struct notifier_block *
>> kernel/notifier.c:30:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/notifier.c:30:9: sparse:    struct notifier_block [noderef] <asn:4> *
   kernel/notifier.c:30:9: sparse:    struct notifier_block *
   kernel/notifier.c:42:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:42:20: sparse:     expected struct notifier_block **nl
   kernel/notifier.c:42:20: sparse:     got struct notifier_block [noderef] <asn:4> **
   kernel/notifier.c:44:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block [noderef] <asn:4> *next @@     got struct notifier_block * @@
   kernel/notifier.c:44:17: sparse:     expected struct notifier_block [noderef] <asn:4> *next
   kernel/notifier.c:44:17: sparse:     got struct notifier_block *
   kernel/notifier.c:45:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/notifier.c:45:9: sparse:    struct notifier_block [noderef] <asn:4> *
   kernel/notifier.c:45:9: sparse:    struct notifier_block *
   kernel/notifier.c:54:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/notifier.c:54:25: sparse:    struct notifier_block [noderef] <asn:4> *
   kernel/notifier.c:54:25: sparse:    struct notifier_block *
   kernel/notifier.c:128:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:150:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:183:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:224:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:227:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:250:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:277:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:280:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:317:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:350:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:367:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:394:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:432:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:435:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:462:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:465:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:498:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
   kernel/notifier.c:77: warning: Excess function parameter 'returns' description in 'notifier_call_chain'
--
   kernel/cred.c:118:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct key *key @@     got struct key [noderef] <asn:4> *session_keyring @@
   kernel/cred.c:118:21: sparse:     expected struct key *key
   kernel/cred.c:118:21: sparse:     got struct key [noderef] <asn:4> *session_keyring
>> kernel/cred.c:147:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/cred.c:147:9: sparse:    struct cred *
   kernel/cred.c:147:9: sparse:    struct cred const [noderef] <asn:4> *
   kernel/cred.c:148:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/cred.c:148:9: sparse:    struct cred *
   kernel/cred.c:148:9: sparse:    struct cred const [noderef] <asn:4> *
   kernel/cred.c:161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *p @@     got int const [noderef] <asn:4> * @@
   kernel/cred.c:161:9: sparse:     expected void const volatile *p
   kernel/cred.c:161:9: sparse:     got int const [noderef] <asn:4> *
   kernel/cred.c:161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *p @@     got int const [noderef] <asn:4> * @@
   kernel/cred.c:161:9: sparse:     expected void const volatile *p
   kernel/cred.c:161:9: sparse:     got int const [noderef] <asn:4> *
   kernel/cred.c:161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:161:9: sparse:     expected struct cred const *cred
   kernel/cred.c:161:9: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:165:17: sparse: sparse: cast removes address space '<asn:4>' of expression
   kernel/cred.c:171:17: sparse: sparse: cast removes address space '<asn:4>' of expression
   kernel/cred.c:258:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:258:13: sparse:     expected struct cred const *old
   kernel/cred.c:258:13: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:268:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct key *key @@     got struct key [noderef] <asn:4> *session_keyring @@
   kernel/cred.c:268:20: sparse:     expected struct key *key
   kernel/cred.c:268:20: sparse:     got struct key [noderef] <asn:4> *session_keyring
   kernel/cred.c:334:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:334:42: sparse:     expected struct cred const *cred
   kernel/cred.c:334:42: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:334:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] <asn:4> *real_cred @@     got struct cred const * @@
   kernel/cred.c:334:30: sparse:     expected struct cred const [noderef] <asn:4> *real_cred
   kernel/cred.c:334:30: sparse:     got struct cred const *
   kernel/cred.c:335:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:335:27: sparse:     expected struct cred const *cred
   kernel/cred.c:335:27: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:336:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *_cred @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:336:41: sparse:     expected struct cred const *_cred
   kernel/cred.c:336:41: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:337:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *p @@     got int const [noderef] <asn:4> * @@
   kernel/cred.c:337:17: sparse:     expected void const volatile *p
   kernel/cred.c:337:17: sparse:     got int const [noderef] <asn:4> *
   kernel/cred.c:337:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *p @@     got int const [noderef] <asn:4> * @@
   kernel/cred.c:337:17: sparse:     expected void const volatile *p
   kernel/cred.c:337:17: sparse:     got int const [noderef] <asn:4> *
   kernel/cred.c:337:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:337:17: sparse:     expected struct cred const *cred
   kernel/cred.c:337:17: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:374:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] <asn:4> *real_cred @@     got struct cred const * @@
   kernel/cred.c:374:32: sparse:     expected struct cred const [noderef] <asn:4> *real_cred
   kernel/cred.c:374:32: sparse:     got struct cred const *
   kernel/cred.c:426:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] <asn:4> *real_cred @@
   kernel/cred.c:426:38: sparse:     expected struct cred const *old
   kernel/cred.c:426:38: sparse:     got struct cred const [noderef] <asn:4> *real_cred
   kernel/cred.c:432:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/cred.c:432:9: sparse:    struct cred const [noderef] <asn:4> *
   kernel/cred.c:432:9: sparse:    struct cred const *
   kernel/cred.c:523:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:523:41: sparse:     expected struct cred const *old
   kernel/cred.c:523:41: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:552:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *override @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:552:46: sparse:     expected struct cred const *override
   kernel/cred.c:552:46: sparse:     got struct cred const [noderef] <asn:4> *cred
>> kernel/cred.c:330:19: sparse: sparse: dereference of noderef expression
   kernel/cred.c:340:30: sparse: sparse: dereference of noderef expression
   kernel/cred.c:340:30: sparse: sparse: dereference of noderef expression
--
>> fs/fcntl.c:803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:803:9: sparse:    struct fasync_struct [noderef] <asn:4> *
   fs/fcntl.c:803:9: sparse:    struct fasync_struct *
   fs/fcntl.c:878:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:878:22: sparse:    struct fasync_struct [noderef] <asn:4> *
   fs/fcntl.c:878:22: sparse:    struct fasync_struct *
   fs/fcntl.c:889:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:889:33: sparse:    struct fasync_struct [noderef] <asn:4> *
   fs/fcntl.c:889:33: sparse:    struct fasync_struct *
   fs/fcntl.c: note: in included file (through include/linux/poll.h, include/linux/ring_buffer.h, include/linux/trace_events.h, ...):
   include/linux/uaccess.h:128:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] <asn:1> *to @@
   include/linux/uaccess.h:128:38: sparse:     expected void *to
   include/linux/uaccess.h:128:38: sparse:     got void [noderef] <asn:1> *to
   include/linux/uaccess.h:128:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *from @@
   include/linux/uaccess.h:128:42: sparse:     expected void const [noderef] <asn:1> *from
   include/linux/uaccess.h:128:42: sparse:     got void const *from
   fs/fcntl.c: note: in included file (through include/linux/uaccess.h, include/linux/poll.h, include/linux/ring_buffer.h, ...):
   arch/openrisc/include/asm/uaccess.h:247:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] <asn:1> *from @@
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     got void const [noderef] <asn:1> *from
   In file included from fs/fcntl.c:7:
   include/linux/syscalls.h:196:25: warning: 'sys_fcntl' alias between functions of incompatible types 'long int(unsigned int,  unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       24-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:185:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     185 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/fcntl.c:359:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     359 | SYSCALL_DEFINE3(fcntl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       36-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:185:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     185 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/fcntl.c:359:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     359 | SYSCALL_DEFINE3(fcntl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:196:25: warning: 'sys_fcntl64' alias between functions of incompatible types 'long int(unsigned int,  unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       48-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:185:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     185 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/fcntl.c:383:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     383 | SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       60-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:185:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     185 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/fcntl.c:383:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     383 | SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
         | ^~~~~~~~~~~~~~~
   fs/fcntl.c: In function 'send_sigio_to_task':
   fs/fcntl.c:641:28: warning: this statement may fall through [-Wimplicit-fallthrough=]
     641 |                         if (!do_send_sig_info(signum, &si, p, group))
         |                            ^
   fs/fcntl.c:644:17: note: here
     644 |                 case 0:
         |                 ^~~~
--
   fs/dcache.c:538:28: sparse: sparse: context imbalance in '__dentry_kill' - unexpected unlock
   fs/dcache.c:563:22: sparse: sparse: context imbalance in 'dentry_kill' - wrong count at exit
   fs/dcache.c:791:9: sparse: sparse: context imbalance in 'dput' - unexpected unlock
   fs/dcache.c:920:18: sparse: sparse: context imbalance in 'd_prune_aliases' - different lock contexts for basic block
   fs/dcache.c:963:44: sparse: sparse: context imbalance in 'shrink_dentry_list' - unexpected unlock
   fs/dcache.c:1100:24: sparse: sparse: context imbalance in 'dentry_lru_isolate_shrink' - different lock contexts for basic block
   fs/dcache.c:1167:13: sparse: sparse: context imbalance in 'd_walk' - different lock contexts for basic block
   fs/dcache.c: note: in included file (through include/linux/dcache.h, include/linux/fs.h, include/linux/seq_file.h, ...):
>> include/linux/rculist_bl.h:23:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:23:33: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:23:33: sparse:    struct hlist_bl_node *
>> include/linux/rculist_bl.h:23:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:23:33: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:23:33: sparse:    struct hlist_bl_node *
   include/linux/rculist_bl.h:16:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:16:9: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:16:9: sparse:    struct hlist_bl_node *
   include/linux/rculist_bl.h:16:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:16:9: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:16:9: sparse:    struct hlist_bl_node *
   In file included from fs/dcache.c:17:
   include/linux/syscalls.h:196:25: warning: 'sys_getcwd' alias between functions of incompatible types 'long int(char *, long unsigned int)' and 'long int(long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       24-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:184:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     184 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/dcache.c:3413:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    3413 | SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       36-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:184:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     184 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/dcache.c:3413:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    3413 | SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
         | ^~~~~~~~~~~~~~~
   fs/dcache.c:442: warning: expecting prototype for d_drop(). Prototype was for __d_drop() instead
   fs/dcache.c:866: warning: expecting prototype for d_find_alias(). Prototype was for __d_find_alias() instead
--
   fs/file.c:353:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **old_fds @@     got struct file [noderef] <asn:4> **fd @@
   fs/file.c:353:17: sparse:     expected struct file **old_fds
   fs/file.c:353:17: sparse:     got struct file [noderef] <asn:4> **fd
   fs/file.c:354:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **new_fds @@     got struct file [noderef] <asn:4> **fd @@
   fs/file.c:354:17: sparse:     expected struct file **new_fds
   fs/file.c:354:17: sparse:     got struct file [noderef] <asn:4> **fd
>> fs/file.c:369:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/file.c:369:17: sparse:    struct file [noderef] <asn:4> *
   fs/file.c:369:17: sparse:    struct file *
   fs/file.c:404:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file *file @@     got struct file [noderef] <asn:4> * @@
   fs/file.c:404:54: sparse:     expected struct file *file
   fs/file.c:404:54: sparse:     got struct file [noderef] <asn:4> *
   fs/file.c:469:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fdtable [noderef] <asn:4> *fdt @@     got struct fdtable * @@
   fs/file.c:469:28: sparse:     expected struct fdtable [noderef] <asn:4> *fdt
   fs/file.c:469:28: sparse:     got struct fdtable *
   fs/file.c:644:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] <asn:4> * @@
   fs/file.c:644:14: sparse:     expected struct file *file
   fs/file.c:644:14: sparse:     got struct file [noderef] <asn:4> *
   fs/file.c:679:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] <asn:4> * @@
   fs/file.c:679:30: sparse:     expected struct file *file
   fs/file.c:679:30: sparse:     got struct file [noderef] <asn:4> *
   fs/file.c:845:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *tofree @@     got struct file [noderef] <asn:4> * @@
   fs/file.c:845:16: sparse:     expected struct file *tofree
   fs/file.c:845:16: sparse:     got struct file [noderef] <asn:4> *
   In file included from fs/file.c:9:
   include/linux/syscalls.h:196:25: warning: 'sys_dup3' alias between functions of incompatible types 'long int(unsigned int,  unsigned int,  int)' and 'long int(long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       31-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:185:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     185 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/file.c:889:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     889 | SYSCALL_DEFINE3(dup3, unsigned int, oldfd, unsigned int, newfd, int, flags)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       43-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:185:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     185 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/file.c:889:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     889 | SYSCALL_DEFINE3(dup3, unsigned int, oldfd, unsigned int, newfd, int, flags)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:196:25: warning: 'sys_dup' alias between functions of incompatible types 'long int(unsigned int)' and 'long int(long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       55-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:183:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     183 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/file.c:938:1: note: in expansion of macro 'SYSCALL_DEFINE1'
     938 | SYSCALL_DEFINE1(dup, unsigned int, fildes)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       67-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:183:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     183 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/file.c:938:1: note: in expansion of macro 'SYSCALL_DEFINE1'
     938 | SYSCALL_DEFINE1(dup, unsigned int, fildes)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:196:25: warning: 'sys_dup2' alias between functions of incompatible types 'long int(unsigned int,  unsigned int)' and 'long int(long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       79-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:184:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     184 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/file.c:923:1: note: in expansion of macro 'SYSCALL_DEFINE2'
     923 | SYSCALL_DEFINE2(dup2, unsigned int, oldfd, unsigned int, newfd)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       91-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:184:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     184 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/file.c:923:1: note: in expansion of macro 'SYSCALL_DEFINE2'
     923 | SYSCALL_DEFINE2(dup2, unsigned int, oldfd, unsigned int, newfd)
         | ^~~~~~~~~~~~~~~
--
>> fs/seq_file.c:980:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:980:24: sparse:    struct hlist_node [noderef] <asn:4> *
   fs/seq_file.c:980:24: sparse:    struct hlist_node *
   fs/seq_file.c:982:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:982:24: sparse:    struct hlist_node [noderef] <asn:4> *
   fs/seq_file.c:982:24: sparse:    struct hlist_node *
   fs/seq_file.c: note: in included file:
   include/linux/uaccess.h:128:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] <asn:1> *to @@
   include/linux/uaccess.h:128:38: sparse:     expected void *to
   include/linux/uaccess.h:128:38: sparse:     got void [noderef] <asn:1> *to
   include/linux/uaccess.h:128:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *from @@
   include/linux/uaccess.h:128:42: sparse:     expected void const [noderef] <asn:1> *from
   include/linux/uaccess.h:128:42: sparse:     got void const *from
   fs/seq_file.c: note: in included file (through include/linux/uaccess.h):
   arch/openrisc/include/asm/uaccess.h:247:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] <asn:1> *from @@
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     got void const [noderef] <asn:1> *from
   fs/seq_file.c: note: in included file:
   include/linux/uaccess.h:128:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] <asn:1> *to @@
   include/linux/uaccess.h:128:38: sparse:     expected void *to
   include/linux/uaccess.h:128:38: sparse:     got void [noderef] <asn:1> *to
   include/linux/uaccess.h:128:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *from @@
   include/linux/uaccess.h:128:42: sparse:     expected void const [noderef] <asn:1> *from
   include/linux/uaccess.h:128:42: sparse:     got void const *from
   fs/seq_file.c: note: in included file (through include/linux/uaccess.h):
   arch/openrisc/include/asm/uaccess.h:247:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] <asn:1> *from @@
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:247:55: sparse:     got void const [noderef] <asn:1> *from
   fs/seq_file.c: In function 'seq_lseek':
   fs/seq_file.c:324:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
     324 |                 offset += file->f_pos;
         |                 ~~~~~~~^~~~~~~~~~~~~~
   fs/seq_file.c:325:9: note: here
     325 |         case SEEK_SET:
         |         ^~~~
   fs/seq_file.c:996: warning: expecting prototype for seq_hlist_start_precpu(). Prototype was for seq_hlist_start_percpu() instead
--
>> fs/posix_acl.c:44:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/posix_acl.c:44:23: sparse:    struct posix_acl [noderef] <asn:4> *
   fs/posix_acl.c:44:23: sparse:    struct posix_acl *
   fs/posix_acl.c:58:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/posix_acl.c:58:16: sparse:    struct posix_acl [noderef] <asn:4> *
   fs/posix_acl.c:58:16: sparse:    struct posix_acl *
   fs/posix_acl.c:155:13: sparse: sparse: self-comparison always evaluates to false
   fs/posix_acl.c: In function 'get_acl':
   fs/posix_acl.c:126:36: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     126 |                 /* fall through */ ;
         |                                    ^
   fs/posix_acl.c:645: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:645: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:645: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
--
   lib/rbtree.c: note: in included file:
>> include/linux/rbtree_augmented.h:141:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree_augmented.h:141:25: sparse:    struct rb_node [noderef] <asn:4> *
   include/linux/rbtree_augmented.h:141:25: sparse:    struct rb_node *
   include/linux/rbtree_augmented.h:143:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree_augmented.h:143:25: sparse:    struct rb_node [noderef] <asn:4> *
   include/linux/rbtree_augmented.h:143:25: sparse:    struct rb_node *
   include/linux/rbtree_augmented.h:145:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree_augmented.h:145:17: sparse:    struct rb_node [noderef] <asn:4> *
   include/linux/rbtree_augmented.h:145:17: sparse:    struct rb_node *
--
   net/802/mrp.c:868:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile *p @@     got struct mrp_applicant [noderef] <asn:4> *[noderef] <asn:4> * @@
   net/802/mrp.c:868:9: sparse:     expected void volatile *p
   net/802/mrp.c:868:9: sparse:     got struct mrp_applicant [noderef] <asn:4> *[noderef] <asn:4> *
   net/802/mrp.c:868:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile *p @@     got struct mrp_applicant [noderef] <asn:4> *[noderef] <asn:4> * @@
   net/802/mrp.c:868:9: sparse:     expected void volatile *p
   net/802/mrp.c:868:9: sparse:     got struct mrp_applicant [noderef] <asn:4> *[noderef] <asn:4> *
>> net/802/mrp.c:868:9: sparse: sparse: dereference of noderef expression
>> net/802/mrp.c:868:9: sparse: sparse: dereference of noderef expression
--
>> net/llc/llc_input.c:194:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/llc/llc_input.c:194:15: sparse:    int ( [noderef] <asn:4> * )( ... )
   net/llc/llc_input.c:194:15: sparse:    int ( * )( ... )
   net/llc/llc_input.c:156: warning: Function parameter or member 'orig_dev' not described in 'llc_rcv'
--
   fs/gfs2/quota.c: note: in included file (through include/linux/dcache.h, include/linux/fs.h, include/linux/buffer_head.h):
>> include/linux/rculist_bl.h:23:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:23:33: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:23:33: sparse:    struct hlist_bl_node *
   include/linux/rculist_bl.h:16:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:16:9: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:16:9: sparse:    struct hlist_bl_node *
   include/linux/rculist_bl.h:16:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:16:9: sparse:    struct hlist_bl_node [noderef] <asn:4> *
   include/linux/rculist_bl.h:16:9: sparse:    struct hlist_bl_node *
   In file included from fs/gfs2/quota.c:60:
   include/linux/jhash.h: In function 'jhash':
   include/linux/jhash.h:90:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
      90 |         case 12: c += (u32)k[11]<<24;
         |                  ~~^~~~~~~~~~~~~~~~~
   include/linux/jhash.h:91:9: note: here
      91 |         case 11: c += (u32)k[10]<<16;
         |         ^~~~
   include/linux/jhash.h:91:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
      91 |         case 11: c += (u32)k[10]<<16;
         |                  ~~^~~~~~~~~~~~~~~~~
   include/linux/jhash.h:92:9: note: here
      92 |         case 10: c += (u32)k[9]<<8;
         |         ^~~~
   include/linux/jhash.h:92:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
      92 |         case 10: c += (u32)k[9]<<8;
         |                  ~~^~~~~~~~~~~~~~~
   include/linux/jhash.h:93:9: note: here
      93 |         case 9:  c += k[8];
         |         ^~~~
   include/linux/jhash.h:93:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
      93 |         case 9:  c += k[8];
         |                  ~~^~~~~~~
   include/linux/jhash.h:94:9: note: here
      94 |         case 8:  b += (u32)k[7]<<24;
         |         ^~~~
   include/linux/jhash.h:94:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
      94 |         case 8:  b += (u32)k[7]<<24;
         |                  ~~^~~~~~~~~~~~~~~~
   include/linux/jhash.h:95:9: note: here
      95 |         case 7:  b += (u32)k[6]<<16;
         |         ^~~~
   include/linux/jhash.h:95:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
      95 |         case 7:  b += (u32)k[6]<<16;
         |                  ~~^~~~~~~~~~~~~~~~
   include/linux/jhash.h:96:9: note: here
      96 |         case 6:  b += (u32)k[5]<<8;
         |         ^~~~
   include/linux/jhash.h:96:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
      96 |         case 6:  b += (u32)k[5]<<8;
         |                  ~~^~~~~~~~~~~~~~~
   include/linux/jhash.h:97:9: note: here
      97 |         case 5:  b += k[4];
         |         ^~~~
   include/linux/jhash.h:97:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
      97 |         case 5:  b += k[4];
         |                  ~~^~~~~~~
   include/linux/jhash.h:98:9: note: here
      98 |         case 4:  a += (u32)k[3]<<24;
         |         ^~~~
   include/linux/jhash.h:98:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
      98 |         case 4:  a += (u32)k[3]<<24;
         |                  ~~^~~~~~~~~~~~~~~~
   include/linux/jhash.h:99:9: note: here
      99 |         case 3:  a += (u32)k[2]<<16;
         |         ^~~~
   include/linux/jhash.h:99:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
      99 |         case 3:  a += (u32)k[2]<<16;
         |                  ~~^~~~~~~~~~~~~~~~
   include/linux/jhash.h:100:9: note: here
     100 |         case 2:  a += (u32)k[1]<<8;
         |         ^~~~
   include/linux/jhash.h:100:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
     100 |         case 2:  a += (u32)k[1]<<8;
         |                  ~~^~~~~~~~~~~~~~~
   include/linux/jhash.h:101:9: note: here
     101 |         case 1:  a += k[0];
         |         ^~~~
   fs/gfs2/quota.c:1529: warning: Function parameter or member 'data' not described in 'gfs2_quotad'
   fs/gfs2/quota.c:1529: warning: Excess function parameter 'sdp' description in 'gfs2_quotad'
--
   net/rxrpc/conn_service.c:61:9: sparse: sparse: context imbalance in 'rxrpc_find_service_conn_rcu' - different lock contexts for basic block
   net/rxrpc/conn_service.c: note: in included file (through include/linux/vmalloc.h, include/asm-generic/io.h, arch/openrisc/include/asm/io.h, ...):
>> include/linux/rbtree.h:97:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree.h:97:9: sparse:    struct rb_node [noderef] <asn:4> *
   include/linux/rbtree.h:97:9: sparse:    struct rb_node *
--
   net/xfrm/xfrm_policy.c:621:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head *odst @@     got struct hlist_head [noderef] <asn:4> *table @@
   net/xfrm/xfrm_policy.c:621:22: sparse:     expected struct hlist_head *odst
   net/xfrm/xfrm_policy.c:621:22: sparse:     got struct hlist_head [noderef] <asn:4> *table
>> net/xfrm/xfrm_policy.c:2874:43: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_policy.c:2874:43: sparse:    struct xfrm_policy_afinfo const [noderef] <asn:4> *
   net/xfrm/xfrm_policy.c:2874:43: sparse:    struct xfrm_policy_afinfo const *
   net/xfrm/xfrm_policy.c:2945:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] <asn:4> *table @@     got struct hlist_head * @@
   net/xfrm/xfrm_policy.c:2945:29: sparse:     expected struct hlist_head [noderef] <asn:4> *table
   net/xfrm/xfrm_policy.c:2945:29: sparse:     got struct hlist_head *
   net/xfrm/xfrm_policy.c:2973:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] <asn:4> *table @@
   net/xfrm/xfrm_policy.c:2973:36: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_policy.c:2973:36: sparse:     got struct hlist_head [noderef] <asn:4> *table
   net/xfrm/xfrm_policy.c:3000:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] <asn:4> *table @@
   net/xfrm/xfrm_policy.c:3000:17: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_policy.c:3000:17: sparse:     got struct hlist_head [noderef] <asn:4> *table
   net/xfrm/xfrm_policy.c:3001:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] <asn:4> *table @@
   net/xfrm/xfrm_policy.c:3001:36: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_policy.c:3001:36: sparse:     got struct hlist_head [noderef] <asn:4> *table
   net/xfrm/xfrm_policy.c:116:9: sparse: sparse: context imbalance in 'xfrm_policy_get_afinfo' - different lock contexts for basic block
   net/xfrm/xfrm_policy.c:131:9: sparse: sparse: context imbalance in '__xfrm_dst_lookup' - unexpected unlock
   net/xfrm/xfrm_policy.c:987:25: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_policy.c:1436:9: sparse: sparse: context imbalance in 'xfrm_get_saddr' - unexpected unlock
   net/xfrm/xfrm_policy.c:1545:22: sparse: sparse: context imbalance in 'xfrm_get_tos' - unexpected unlock
   net/xfrm/xfrm_policy.c: note: in included file (through include/linux/srcu.h, include/linux/notifier.h, include/linux/memory_hotplug.h, ...):
   include/linux/rcupdate.h:664:9: sparse: sparse: context imbalance in 'xfrm_bundle_create' - unexpected unlock
   include/linux/rcupdate.h:664:9: sparse: sparse: context imbalance in 'xfrm_create_dummy_bundle' - unexpected unlock
   net/xfrm/xfrm_policy.c:2167:17: sparse: sparse: context imbalance in 'make_blackhole' - unexpected unlock
   net/xfrm/xfrm_policy.c:2417:9: sparse: sparse: context imbalance in '__xfrm_decode_session' - unexpected unlock
   In file included from include/net/inet_sock.h:23,
                    from include/net/ip.h:30,
                    from include/net/xfrm.h:19,
                    from net/xfrm/xfrm_policy.c:30:
   include/linux/jhash.h: In function 'jhash2':
   include/linux/jhash.h:136:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
     136 |         case 3: c += k[2];
         |                 ~~^~~~~~~
   include/linux/jhash.h:137:9: note: here
     137 |         case 2: b += k[1];
         |         ^~~~
   include/linux/jhash.h:137:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
     137 |         case 2: b += k[1];
         |                 ~~^~~~~~~
   include/linux/jhash.h:138:9: note: here
     138 |         case 1: a += k[0];
         |         ^~~~
   In file included from include/linux/if_ether.h:23,
                    from include/uapi/linux/ethtool.h:18,
                    from include/linux/ethtool.h:17,
                    from include/linux/netdevice.h:42,
                    from net/xfrm/xfrm_policy.c:23:
   In function '__skb_queue_splice',
       inlined from 'skb_queue_splice_init' at include/linux/skbuff.h:1657:3,
       inlined from 'xfrm_policy_requeue' at net/xfrm/xfrm_policy.c:734:2:
   include/linux/skbuff.h:1626:20: warning: array subscript 'struct sk_buff[0]' is partly outside array bounds of 'struct sk_buff_head[1]' [-Warray-bounds]
    1626 |         prev->next = first;
         |         ~~~~~~~~~~~^~~~~~~
   net/xfrm/xfrm_policy.c: In function 'xfrm_policy_requeue':
   net/xfrm/xfrm_policy.c:726:29: note: object 'list' of size 28
     726 |         struct sk_buff_head list;
         |                             ^~~~
   In function '__skb_queue_splice',
       inlined from 'skb_queue_splice_init' at include/linux/skbuff.h:1657:3,
       inlined from 'xfrm_policy_queue_process' at net/xfrm/xfrm_policy.c:1923:2:
   include/linux/skbuff.h:1626:20: warning: array subscript 'struct sk_buff[0]' is partly outside array bounds of 'struct sk_buff_head[1]' [-Warray-bounds]
    1626 |         prev->next = first;
         |         ~~~~~~~~~~~^~~~~~~
   net/xfrm/xfrm_policy.c: In function 'xfrm_policy_queue_process':
   net/xfrm/xfrm_policy.c:1887:29: note: object 'list' of size 28
    1887 |         struct sk_buff_head list;
         |                             ^~~~
--
   net/xfrm/xfrm_state.c:944:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:944:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:944:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:944:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:944:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:944:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:944:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:944:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:944:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:944:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:944:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:960:9: sparse: sparse: cast removes address space '<asn:4>' of expression
   net/xfrm/xfrm_state.c:1016:77: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] <asn:4> * @@
   net/xfrm/xfrm_state.c:1016:77: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1016:77: sparse:     got struct hlist_head [noderef] <asn:4> *
   net/xfrm/xfrm_state.c:1018:77: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] <asn:4> * @@
   net/xfrm/xfrm_state.c:1018:77: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1018:77: sparse:     got struct hlist_head [noderef] <asn:4> *
   net/xfrm/xfrm_state.c:1021:85: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] <asn:4> * @@
   net/xfrm/xfrm_state.c:1021:85: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1021:85: sparse:     got struct hlist_head [noderef] <asn:4> *
   net/xfrm/xfrm_state.c:1037:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct xfrm_state [noderef] <asn:4> *x @@     got struct xfrm_state *[assigned] x @@
   net/xfrm/xfrm_state.c:1037:42: sparse:     expected struct xfrm_state [noderef] <asn:4> *x
   net/xfrm/xfrm_state.c:1037:42: sparse:     got struct xfrm_state *[assigned] x
   net/xfrm/xfrm_state.c:1123:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] <asn:4> * @@
   net/xfrm/xfrm_state.c:1123:61: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1123:61: sparse:     got struct hlist_head [noderef] <asn:4> *
   net/xfrm/xfrm_state.c:1126:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] <asn:4> * @@
   net/xfrm/xfrm_state.c:1126:61: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1126:61: sparse:     got struct hlist_head [noderef] <asn:4> *
   net/xfrm/xfrm_state.c:1132:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] <asn:4> * @@
   net/xfrm/xfrm_state.c:1132:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1132:69: sparse:     got struct hlist_head [noderef] <asn:4> *
   net/xfrm/xfrm_state.c:1241:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] <asn:4> * @@
   net/xfrm/xfrm_state.c:1241:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1241:69: sparse:     got struct hlist_head [noderef] <asn:4> *
   net/xfrm/xfrm_state.c:1243:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] <asn:4> * @@
   net/xfrm/xfrm_state.c:1243:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1243:69: sparse:     got struct hlist_head [noderef] <asn:4> *
   net/xfrm/xfrm_state.c:1761:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] <asn:4> * @@
   net/xfrm/xfrm_state.c:1761:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1761:69: sparse:     got struct hlist_head [noderef] <asn:4> *
   net/xfrm/xfrm_state.c:2268:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] <asn:4> *state_bydst @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:2268:31: sparse:     expected struct hlist_head [noderef] <asn:4> *state_bydst
   net/xfrm/xfrm_state.c:2268:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:2271:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] <asn:4> *state_bysrc @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:2271:31: sparse:     expected struct hlist_head [noderef] <asn:4> *state_bysrc
   net/xfrm/xfrm_state.c:2271:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:2274:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] <asn:4> *state_byspi @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:2274:31: sparse:     expected struct hlist_head [noderef] <asn:4> *state_byspi
   net/xfrm/xfrm_state.c:2274:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:2285:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] <asn:4> *state_bysrc @@
   net/xfrm/xfrm_state.c:2285:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2285:33: sparse:     got struct hlist_head [noderef] <asn:4> *state_bysrc
   net/xfrm/xfrm_state.c:2287:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] <asn:4> *state_bydst @@
   net/xfrm/xfrm_state.c:2287:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2287:33: sparse:     got struct hlist_head [noderef] <asn:4> *state_bydst
   net/xfrm/xfrm_state.c:2303:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] <asn:4> *state_byspi @@
   net/xfrm/xfrm_state.c:2303:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:2303:9: sparse:     got struct hlist_head [noderef] <asn:4> *state_byspi
   net/xfrm/xfrm_state.c:2304:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] <asn:4> *state_byspi @@
   net/xfrm/xfrm_state.c:2304:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2304:33: sparse:     got struct hlist_head [noderef] <asn:4> *state_byspi
   net/xfrm/xfrm_state.c:2305:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] <asn:4> *state_bysrc @@
   net/xfrm/xfrm_state.c:2305:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:2305:9: sparse:     got struct hlist_head [noderef] <asn:4> *state_bysrc
   net/xfrm/xfrm_state.c:2306:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] <asn:4> *state_bysrc @@
   net/xfrm/xfrm_state.c:2306:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2306:33: sparse:     got struct hlist_head [noderef] <asn:4> *state_bysrc
   net/xfrm/xfrm_state.c:2307:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] <asn:4> *state_bydst @@
   net/xfrm/xfrm_state.c:2307:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:2307:9: sparse:     got struct hlist_head [noderef] <asn:4> *state_bydst
   net/xfrm/xfrm_state.c:2308:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] <asn:4> *state_bydst @@
   net/xfrm/xfrm_state.c:2308:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2308:33: sparse:     got struct hlist_head [noderef] <asn:4> *state_bydst
   net/xfrm/xfrm_state.c:194:23: sparse: sparse: context imbalance in 'xfrm_register_type' - unexpected unlock
   net/xfrm/xfrm_state.c:215:23: sparse: sparse: context imbalance in 'xfrm_unregister_type' - unexpected unlock
   net/xfrm/xfrm_state.c:235:13: sparse: sparse: context imbalance in 'xfrm_get_type' - unexpected unlock
   net/xfrm/xfrm_state.c:271:23: sparse: sparse: context imbalance in 'xfrm_register_type_offload' - unexpected unlock
   net/xfrm/xfrm_state.c:293:23: sparse: sparse: context imbalance in 'xfrm_unregister_type_offload' - unexpected unlock
   net/xfrm/xfrm_state.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/kmemcheck.h, ...):
   include/linux/rcupdate.h:664:9: sparse: sparse: context imbalance in 'xfrm_get_type_offload' - unexpected unlock
   net/xfrm/xfrm_state.c:352:23: sparse: sparse: context imbalance in 'xfrm_register_mode' - unexpected unlock
   net/xfrm/xfrm_state.c:380:23: sparse: sparse: context imbalance in 'xfrm_unregister_mode' - unexpected unlock
   net/xfrm/xfrm_state.c:401:13: sparse: sparse: context imbalance in 'xfrm_get_mode' - unexpected unlock
>> net/xfrm/xfrm_state.c:709:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:750:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:51:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *v @@     got struct atomic_t [noderef] <asn:4> * @@
   net/xfrm/xfrm_state.c:51:16: sparse:     expected struct atomic_t [usertype] *v
   net/xfrm/xfrm_state.c:51:16: sparse:     got struct atomic_t [noderef] <asn:4> *
   net/xfrm/xfrm_state.c:51:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *v @@     got struct atomic_t [noderef] <asn:4> * @@
   net/xfrm/xfrm_state.c:51:16: sparse:     expected struct atomic_t [usertype] *v
   net/xfrm/xfrm_state.c:51:16: sparse:     got struct atomic_t [noderef] <asn:4> *
   net/xfrm/xfrm_state.c:51:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *v @@     got struct atomic_t [noderef] <asn:4> * @@
   net/xfrm/xfrm_state.c:51:16: sparse:     expected struct atomic_t [usertype] *v
   net/xfrm/xfrm_state.c:51:16: sparse:     got struct atomic_t [noderef] <asn:4> *
   net/xfrm/xfrm_state.c:1069:9: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:1155:9: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:1189:9: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:1623:23: sparse: sparse: context imbalance in 'xfrm_tmpl_sort' - unexpected unlock
   net/xfrm/xfrm_state.c:1643:23: sparse: sparse: context imbalance in 'xfrm_state_sort' - unexpected unlock
   net/xfrm/xfrm_state.c:1659:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c: note: in included file:
>> include/net/xfrm.h:1741:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1741:16: sparse:    struct sock [noderef] <asn:4> *
   include/net/xfrm.h:1741:16: sparse:    struct sock *
--
>> net/xfrm/xfrm_input.c:50:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_input.c:50:21: sparse:    struct xfrm_input_afinfo const [noderef] <asn:4> *
   net/xfrm/xfrm_input.c:50:21: sparse:    struct xfrm_input_afinfo const *
   net/xfrm/xfrm_input.c:72:9: sparse: sparse: context imbalance in 'xfrm_input_get_afinfo' - different lock contexts for basic block
   net/xfrm/xfrm_input.c:84:9: sparse: sparse: context imbalance in 'xfrm_rcv_cb' - unexpected unlock
--
   net/xfrm/xfrm_replay.c: note: in included file:
>> include/net/xfrm.h:1741:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1741:16: sparse:    struct sock [noderef] <asn:4> *
   include/net/xfrm.h:1741:16: sparse:    struct sock *
>> include/net/xfrm.h:1741:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1741:16: sparse:    struct sock [noderef] <asn:4> *
   include/net/xfrm.h:1741:16: sparse:    struct sock *
>> include/net/xfrm.h:1741:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1741:16: sparse:    struct sock [noderef] <asn:4> *
   include/net/xfrm.h:1741:16: sparse:    struct sock *
>> include/net/xfrm.h:1741:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1741:16: sparse:    struct sock [noderef] <asn:4> *
   include/net/xfrm.h:1741:16: sparse:    struct sock *
>> include/net/xfrm.h:1741:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1741:16: sparse:    struct sock [noderef] <asn:4> *
   include/net/xfrm.h:1741:16: sparse:    struct sock *
>> include/net/xfrm.h:1741:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1741:16: sparse:    struct sock [noderef] <asn:4> *
   include/net/xfrm.h:1741:16: sparse:    struct sock *
>> include/net/xfrm.h:1741:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1741:16: sparse:    struct sock [noderef] <asn:4> *
   include/net/xfrm.h:1741:16: sparse:    struct sock *
>> include/net/xfrm.h:1741:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1741:16: sparse:    struct sock [noderef] <asn:4> *
   include/net/xfrm.h:1741:16: sparse:    struct sock *
>> include/net/xfrm.h:1741:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1741:16: sparse:    struct sock [noderef] <asn:4> *
   include/net/xfrm.h:1741:16: sparse:    struct sock *
--
>> net/xfrm/xfrm_user.c:3165:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_user.c:3165:9: sparse:    struct sock [noderef] <asn:4> *
   net/xfrm/xfrm_user.c:3165:9: sparse:    struct sock *
   net/xfrm/xfrm_user.c:3173:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_user.c:3173:17: sparse:    struct sock [noderef] <asn:4> *
   net/xfrm/xfrm_user.c:3173:17: sparse:    struct sock *
   net/xfrm/xfrm_user.c:1018:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock [noderef] <asn:4> *
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock *
   net/xfrm/xfrm_user.c:1018:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock [noderef] <asn:4> *
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock *
   net/xfrm/xfrm_user.c:1018:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock [noderef] <asn:4> *
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock *
   net/xfrm/xfrm_user.c:1018:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock [noderef] <asn:4> *
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock *
   net/xfrm/xfrm_user.c:1018:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock [noderef] <asn:4> *
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock *
   net/xfrm/xfrm_user.c:1018:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock [noderef] <asn:4> *
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock *
   net/xfrm/xfrm_user.c:1018:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock [noderef] <asn:4> *
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock *
   net/xfrm/xfrm_user.c:1018:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock [noderef] <asn:4> *
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock *
   net/xfrm/xfrm_user.c:1018:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock [noderef] <asn:4> *
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock *
   net/xfrm/xfrm_user.c:1018:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock [noderef] <asn:4> *
   net/xfrm/xfrm_user.c:1018:29: sparse:    struct sock *
   net/xfrm/xfrm_user.c: note: in included file:
   include/net/xfrm.h:1754:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1754:16: sparse:    struct sock [noderef] <asn:4> *
   include/net/xfrm.h:1754:16: sparse:    struct sock *
   In file included from net/xfrm/xfrm_user.c:14:
   include/linux/module.h:131:13: warning: 'init_module' specifies less restrictive attribute than its target 'xfrm_user_init': 'cold' [-Wmissing-attributes]
     131 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   net/xfrm/xfrm_user.c:3205:1: note: in expansion of macro 'module_init'
    3205 | module_init(xfrm_user_init);
         | ^~~~~~~~~~~
   net/xfrm/xfrm_user.c:3184:19: note: 'init_module' target declared here
    3184 | static int __init xfrm_user_init(void)
         |                   ^~~~~~~~~~~~~~
   include/linux/module.h:137:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'xfrm_user_exit': 'cold' [-Wmissing-attributes]
     137 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   net/xfrm/xfrm_user.c:3206:1: note: in expansion of macro 'module_exit'
    3206 | module_exit(xfrm_user_exit);
         | ^~~~~~~~~~~
   net/xfrm/xfrm_user.c:3199:20: note: 'cleanup_module' target declared here
    3199 | static void __exit xfrm_user_exit(void)
         |                    ^~~~~~~~~~~~~~
--
>> fs/notify/fsnotify.c:293:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/notify/fsnotify.c:293:38: sparse:    struct hlist_node [noderef] <asn:4> *
   fs/notify/fsnotify.c:293:38: sparse:    struct hlist_node *
   fs/notify/fsnotify.c:302:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/notify/fsnotify.c:302:38: sparse:    struct hlist_node [noderef] <asn:4> *
   fs/notify/fsnotify.c:302:38: sparse:    struct hlist_node *
   fs/notify/fsnotify.c:307:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/notify/fsnotify.c:307:41: sparse:    struct hlist_node [noderef] <asn:4> *
   fs/notify/fsnotify.c:307:41: sparse:    struct hlist_node *
   fs/notify/fsnotify.c:324:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/notify/fsnotify.c:324:38: sparse:    struct hlist_node [noderef] <asn:4> *
   fs/notify/fsnotify.c:324:38: sparse:    struct hlist_node *
   fs/notify/fsnotify.c:330:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/notify/fsnotify.c:330:41: sparse:    struct hlist_node [noderef] <asn:4> *
   fs/notify/fsnotify.c:330:41: sparse:    struct hlist_node *
   fs/notify/fsnotify.c:358:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/notify/fsnotify.c:358:38: sparse:    struct hlist_node [noderef] <asn:4> *
   fs/notify/fsnotify.c:358:38: sparse:    struct hlist_node *
   fs/notify/fsnotify.c:361:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/notify/fsnotify.c:361:41: sparse:    struct hlist_node [noderef] <asn:4> *
   fs/notify/fsnotify.c:361:41: sparse:    struct hlist_node *
--
>> fs/proc/inode.c:49:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/proc/inode.c:49:17: sparse:    struct ctl_table_header [noderef] <asn:4> *
   fs/proc/inode.c:49:17: sparse:    struct ctl_table_header *
--
   fs/proc/array.c:470:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   fs/proc/array.c:470:44: sparse:     expected struct task_struct *tsk
   fs/proc/array.c:470:44: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
>> fs/proc/array.c:633:47: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/proc/array.c:633:47: sparse:    struct task_struct [noderef] <asn:4> *
   fs/proc/array.c:633:47: sparse:    struct task_struct *
   fs/proc/array.c:725:5: sparse: sparse: symbol 'children_seq_release' was not declared. Should it be static?
   fs/proc/array.c:300:9: sparse: sparse: context imbalance in 'proc_pid_status' - different lock contexts for basic block
   fs/proc/array.c:476:9: sparse: sparse: context imbalance in 'do_task_stat' - different lock contexts for basic block
   fs/proc/array.c:725:5: warning: no previous prototype for 'children_seq_release' [-Wmissing-prototypes]
     725 | int children_seq_release(struct inode *inode, struct file *file)
         |     ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/sched/signal.h:5,
                    from include/linux/sched/cputime.h:4,
                    from fs/proc/array.c:66:
   include/linux/signal.h: In function 'sigemptyset':
   include/linux/signal.h:166:29: warning: this statement may fall through [-Wimplicit-fallthrough=]
     166 |         case 2: set->sig[1] = 0;
         |                 ~~~~~~~~~~~~^~~
   include/linux/signal.h:167:9: note: here
     167 |         case 1: set->sig[0] = 0;
         |         ^~~~
--
>> fs/proc/proc_sysctl.c:889:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/proc/proc_sysctl.c:889:16: sparse:    struct ctl_table_header [noderef] <asn:4> *
   fs/proc/proc_sysctl.c:889:16: sparse:    struct ctl_table_header *
   fs/proc/proc_sysctl.c:294:32: sparse: sparse: context imbalance in 'start_unregistering' - unexpected unlock
   fs/proc/proc_sysctl.c:1523: warning: expecting prototype for register_sysctl_table_path(). Prototype was for register_sysctl_paths() instead

vim +1601 kernel/fork.c

6bfbaa51ed4777 Ingo Molnar         2017-02-03  1507  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1508  /*
^1da177e4c3f41 Linus Torvalds      2005-04-16  1509   * This creates a new process as a copy of the old one,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1510   * but does not actually start it yet.
^1da177e4c3f41 Linus Torvalds      2005-04-16  1511   *
^1da177e4c3f41 Linus Torvalds      2005-04-16  1512   * It copies the registers, and all the appropriate
^1da177e4c3f41 Linus Torvalds      2005-04-16  1513   * parts of the process environment (as per the clone
^1da177e4c3f41 Linus Torvalds      2005-04-16  1514   * flags). The actual kick-off is left to the caller.
^1da177e4c3f41 Linus Torvalds      2005-04-16  1515   */
0766f788eb727e Emese Revfy         2016-06-20  1516  static __latent_entropy struct task_struct *copy_process(
0766f788eb727e Emese Revfy         2016-06-20  1517  					unsigned long clone_flags,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1518  					unsigned long stack_start,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1519  					unsigned long stack_size,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1520  					int __user *child_tidptr,
09a05394fe2448 Roland McGrath      2008-07-25  1521  					struct pid *pid,
3033f14ab78c32 Josh Triplett       2015-06-25  1522  					int trace,
725fc629ff2545 Andi Kleen          2016-05-23  1523  					unsigned long tls,
725fc629ff2545 Andi Kleen          2016-05-23  1524  					int node)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1525  {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1526  	int retval;
a24efe62dd165b Mariusz Kozlowski   2007-10-18  1527  	struct task_struct *p;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1528  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1529  	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
^1da177e4c3f41 Linus Torvalds      2005-04-16  1530  		return ERR_PTR(-EINVAL);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1531  
e66eded8309ebf Eric W. Biederman   2013-03-13  1532  	if ((clone_flags & (CLONE_NEWUSER|CLONE_FS)) == (CLONE_NEWUSER|CLONE_FS))
e66eded8309ebf Eric W. Biederman   2013-03-13  1533  		return ERR_PTR(-EINVAL);
e66eded8309ebf Eric W. Biederman   2013-03-13  1534  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1535  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  1536  	 * Thread groups must share signals as well, and detached threads
^1da177e4c3f41 Linus Torvalds      2005-04-16  1537  	 * can only be started up within the thread group.
^1da177e4c3f41 Linus Torvalds      2005-04-16  1538  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  1539  	if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND))
^1da177e4c3f41 Linus Torvalds      2005-04-16  1540  		return ERR_PTR(-EINVAL);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1541  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1542  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  1543  	 * Shared signal handlers imply shared VM. By way of the above,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1544  	 * thread groups also imply shared VM. Blocking this case allows
^1da177e4c3f41 Linus Torvalds      2005-04-16  1545  	 * for various simplifications in other code.
^1da177e4c3f41 Linus Torvalds      2005-04-16  1546  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  1547  	if ((clone_flags & CLONE_SIGHAND) && !(clone_flags & CLONE_VM))
^1da177e4c3f41 Linus Torvalds      2005-04-16  1548  		return ERR_PTR(-EINVAL);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1549  
123be07b0b3996 Sukadev Bhattiprolu 2009-09-23  1550  	/*
123be07b0b3996 Sukadev Bhattiprolu 2009-09-23  1551  	 * Siblings of global init remain as zombies on exit since they are
123be07b0b3996 Sukadev Bhattiprolu 2009-09-23  1552  	 * not reaped by their parent (swapper). To solve this and to avoid
123be07b0b3996 Sukadev Bhattiprolu 2009-09-23  1553  	 * multi-rooted process trees, prevent global and container-inits
123be07b0b3996 Sukadev Bhattiprolu 2009-09-23  1554  	 * from creating siblings.
123be07b0b3996 Sukadev Bhattiprolu 2009-09-23  1555  	 */
123be07b0b3996 Sukadev Bhattiprolu 2009-09-23  1556  	if ((clone_flags & CLONE_PARENT) &&
123be07b0b3996 Sukadev Bhattiprolu 2009-09-23  1557  				current->signal->flags & SIGNAL_UNKILLABLE)
123be07b0b3996 Sukadev Bhattiprolu 2009-09-23  1558  		return ERR_PTR(-EINVAL);
123be07b0b3996 Sukadev Bhattiprolu 2009-09-23  1559  
8382fcac1b813a Eric W. Biederman   2012-12-20  1560  	/*
40a0d32d1eaffe Oleg Nesterov       2013-09-11  1561  	 * If the new process will be in a different pid or user namespace
faf00da544045f Eric W. Biederman   2015-08-10  1562  	 * do not allow it to share a thread group with the forking task.
8382fcac1b813a Eric W. Biederman   2012-12-20  1563  	 */
faf00da544045f Eric W. Biederman   2015-08-10  1564  	if (clone_flags & CLONE_THREAD) {
40a0d32d1eaffe Oleg Nesterov       2013-09-11  1565  		if ((clone_flags & (CLONE_NEWUSER | CLONE_NEWPID)) ||
40a0d32d1eaffe Oleg Nesterov       2013-09-11  1566  		    (task_active_pid_ns(current) !=
c2b1df2eb42978 Andy Lutomirski     2013-08-22  1567  				current->nsproxy->pid_ns_for_children))
8382fcac1b813a Eric W. Biederman   2012-12-20  1568  			return ERR_PTR(-EINVAL);
40a0d32d1eaffe Oleg Nesterov       2013-09-11  1569  	}
8382fcac1b813a Eric W. Biederman   2012-12-20  1570  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1571  	retval = security_task_create(clone_flags);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1572  	if (retval)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1573  		goto fork_out;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1574  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1575  	retval = -ENOMEM;
725fc629ff2545 Andi Kleen          2016-05-23  1576  	p = dup_task_struct(current, node);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1577  	if (!p)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1578  		goto fork_out;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1579  
4d6501dce079c1 Vegard Nossum       2017-05-09  1580  	/*
4d6501dce079c1 Vegard Nossum       2017-05-09  1581  	 * This _must_ happen before we call free_task(), i.e. before we jump
4d6501dce079c1 Vegard Nossum       2017-05-09  1582  	 * to any of the bad_fork_* labels. This is to avoid freeing
4d6501dce079c1 Vegard Nossum       2017-05-09  1583  	 * p->set_child_tid which is (ab)used as a kthread's data pointer for
4d6501dce079c1 Vegard Nossum       2017-05-09  1584  	 * kernel threads (PF_KTHREAD).
4d6501dce079c1 Vegard Nossum       2017-05-09  1585  	 */
4d6501dce079c1 Vegard Nossum       2017-05-09  1586  	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? child_tidptr : NULL;
4d6501dce079c1 Vegard Nossum       2017-05-09  1587  	/*
4d6501dce079c1 Vegard Nossum       2017-05-09  1588  	 * Clear TID on mm_release()?
4d6501dce079c1 Vegard Nossum       2017-05-09  1589  	 */
4d6501dce079c1 Vegard Nossum       2017-05-09  1590  	p->clear_child_tid = (clone_flags & CLONE_CHILD_CLEARTID) ? child_tidptr : NULL;
4d6501dce079c1 Vegard Nossum       2017-05-09  1591  
f7e8b616ed1cc6 Steven Rostedt      2009-06-02  1592  	ftrace_graph_init_task(p);
f7e8b616ed1cc6 Steven Rostedt      2009-06-02  1593  
bea493a031fe33 Peter Zijlstra      2006-10-17  1594  	rt_mutex_init_task(p);
bea493a031fe33 Peter Zijlstra      2006-10-17  1595  
d12c1a37925a8e Ingo Molnar         2008-07-14  1596  #ifdef CONFIG_PROVE_LOCKING
de30a2b355ea85 Ingo Molnar         2006-07-03  1597  	DEBUG_LOCKS_WARN_ON(!p->hardirqs_enabled);
de30a2b355ea85 Ingo Molnar         2006-07-03  1598  	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
de30a2b355ea85 Ingo Molnar         2006-07-03  1599  #endif
^1da177e4c3f41 Linus Torvalds      2005-04-16  1600  	retval = -EAGAIN;
3b11a1decef07c David Howells       2008-11-14 @1601  	if (atomic_read(&p->real_cred->user->processes) >=
78d7d407b62a02 Jiri Slaby          2010-03-05  1602  			task_rlimit(p, RLIMIT_NPROC)) {
b57922b6c76c3e Eric Paris          2013-07-03  1603  		if (p->real_cred->user != INIT_USER &&
b57922b6c76c3e Eric Paris          2013-07-03  1604  		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
^1da177e4c3f41 Linus Torvalds      2005-04-16  1605  			goto bad_fork_free;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1606  	}
72fa59970f8698 Vasiliy Kulikov     2011-08-08  1607  	current->flags &= ~PF_NPROC_EXCEEDED;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1608  
f1752eec6145c9 David Howells       2008-11-14  1609  	retval = copy_creds(p, clone_flags);
f1752eec6145c9 David Howells       2008-11-14  1610  	if (retval < 0)
f1752eec6145c9 David Howells       2008-11-14  1611  		goto bad_fork_free;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1612  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1613  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  1614  	 * If multiple threads are within copy_process(), then this check
^1da177e4c3f41 Linus Torvalds      2005-04-16  1615  	 * triggers too late. This doesn't hurt, the check is only there
^1da177e4c3f41 Linus Torvalds      2005-04-16  1616  	 * to stop root fork bombs.
^1da177e4c3f41 Linus Torvalds      2005-04-16  1617  	 */
04ec93fe9bc98e Li Zefan            2009-02-06  1618  	retval = -EAGAIN;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1619  	if (nr_threads >= max_threads)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1620  		goto bad_fork_cleanup_count;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1621  
ca74e92b469827 Shailabh Nagar      2006-07-14  1622  	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
c1de45ca831ace Peter Zijlstra      2016-11-28  1623  	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
514ddb446c5c5a David Rientjes      2014-04-07  1624  	p->flags |= PF_FORKNOEXEC;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1625  	INIT_LIST_HEAD(&p->children);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1626  	INIT_LIST_HEAD(&p->sibling);
f41d911f8c49a5 Paul E. McKenney    2009-08-22  1627  	rcu_copy_process(p);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1628  	p->vfork_done = NULL;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1629  	spin_lock_init(&p->alloc_lock);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1630  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1631  	init_sigpending(&p->pending);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1632  
648616343cdbe9 Martin Schwidefsky  2011-12-15  1633  	p->utime = p->stime = p->gtime = 0;
40565b5aedd6d0 Stanislaw Gruszka   2016-11-15  1634  #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
648616343cdbe9 Martin Schwidefsky  2011-12-15  1635  	p->utimescaled = p->stimescaled = 0;
40565b5aedd6d0 Stanislaw Gruszka   2016-11-15  1636  #endif
9d7fb04276481c Peter Zijlstra      2015-06-30  1637  	prev_cputime_init(&p->prev_cputime);
9d7fb04276481c Peter Zijlstra      2015-06-30  1638  

:::::: The code at line 1601 was first introduced by commit
:::::: 3b11a1decef07c19443d24ae926982bc8ec9f4c0 CRED: Differentiate objective and effective subjective credentials on a task

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: James Morris <jmorris@namei.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

