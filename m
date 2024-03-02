Return-Path: <linux-kernel+bounces-89614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C499B86F315
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 00:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385CBB22A4E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7727537FF;
	Sat,  2 Mar 2024 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i84v561M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E3742AAA
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709420827; cv=none; b=OnC5h9liW1spe5HmMUpx6xU7F6astN6UH5FO3hbYjsF89b2aboQ9OQGIJQyTFHxkDtRKOjtzDClkGi+UnGSFGYUDZIpQFxsmevnc0FBMGmreFYs7vhWvZJiG2TZvpt+36hN1ieNJSTdVLIV6p53lgHyxnCj+8XiDeb/XLORADLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709420827; c=relaxed/simple;
	bh=TWqGFGIQh4CaKG/pDmbZgvDsne3caRK+p6T5cRiz1ec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k0unsm7uOiV0p2P14U3zCMdHIpzLvF66HJGKQbTjXfJB5IfjX/f+4IU/brccvfrPSZjXVX/ymw5xblEuyARG9kMrJfY9Tu77h5yqAJXh4T/ecleQKPtYKjTcK/s99TSNqTGVS+G1STJe21mOfeYZAML13Ke0kwSpT2gaJWOLgvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i84v561M; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709420825; x=1740956825;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TWqGFGIQh4CaKG/pDmbZgvDsne3caRK+p6T5cRiz1ec=;
  b=i84v561MzLsh05mYgHUqlsJ5D6SYFF03N3R06Bdl68OvXZQa81cWZtA5
   G6IDUkTw/smSyOzlchCQgKnNfXTPvHTmoz4XID/21SHSUO0/5q5DR/zCo
   EQyYVUcnyKPnGbqx8l5+pCJVevvmfPwS0zMbjGxVNSVwPYikCYMBuJIPm
   AIs1h4rt4QZSWR4xAkV3p28OB+VijEqEWq9Ll9WiS/8cU4/qZM9mRG0kx
   vLNtI1/3rmyIDqzDg3kH44sMI0dTpGxNjLZBUtwsG9qOG2xwqPorcpn+F
   4u5Zg9B6hc4GTtUSzTr2vXW6Jocm38Ew1BviVL6RN+C2+c9ozQ/cc9fXA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11001"; a="26407837"
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="26407837"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 15:07:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="9018283"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Mar 2024 15:07:02 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgYRY-0000Lo-0d;
	Sat, 02 Mar 2024 23:07:00 +0000
Date: Sun, 3 Mar 2024 07:06:29 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Subject: vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to
 !ENDBR: arch_arm_kprobe+0x53
Message-ID: <202403030647.nbsj0FqZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4640e2be3920168f6b26512466562accb783423a
commit: fee86a4ed536f4e521f3a4530242e152dd2a466b ftrace: selftest: remove broken trace_direct_tramp
date:   12 months ago
config: x86_64-randconfig-121-20240302 (https://download.01.org/0day-ci/archive/20240303/202403030647.nbsj0FqZ-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240303/202403030647.nbsj0FqZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403030647.nbsj0FqZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to !ENDBR: arch_arm_kprobe+0x53


objdump-func vmlinux.o set_ftrace_ops_ro:
0000 00000000000492c0 <set_ftrace_ops_ro>:
0000    492c0:	f3 0f 1e fa          	endbr64
0004    492c4:	41 57                	push   %r15
0006    492c6:	41 56                	push   %r14
0008    492c8:	41 54                	push   %r12
000a    492ca:	53                   	push   %rbx
000b    492cb:	48 8b 1d 00 00 00 00 	mov    0x0(%rip),%rbx        # 492d2 <set_ftrace_ops_ro+0x12>	492ce: R_X86_64_PC32	ftrace_ops_list-0x4
0012    492d2:	e8 00 00 00 00       	call   492d7 <set_ftrace_ops_ro+0x17>	492d3: R_X86_64_PLT32	debug_lockdep_rcu_enabled-0x4
0017    492d7:	49 c7 c6 00 00 00 00 	mov    $0x0,%r14	492da: R_X86_64_32S	ftrace_list_end
001e    492de:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax	492e1: R_X86_64_32S	ftrace_regs_caller
0025    492e5:	48 f7 d8             	neg    %rax
0028    492e8:	4c 8d 3c 05 00 00 00 00 	lea    0x0(,%rax,1),%r15	492ec: R_X86_64_32S	ftrace_regs_caller_end+0x1008
0030    492f0:	49 c1 ef 0c          	shr    $0xc,%r15
0034    492f4:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax	492f7: R_X86_64_32S	ftrace_caller
003b    492fb:	48 f7 d8             	neg    %rax
003e    492fe:	4c 8d 24 05 00 00 00 00 	lea    0x0(,%rax,1),%r12	49302: R_X86_64_32S	ftrace_caller_end+0x1008
0046    49306:	49 c1 ec 0c          	shr    $0xc,%r12
004a    4930a:	48 8b 43 10          	mov    0x10(%rbx),%rax
004e    4930e:	a9 00 08 00 00       	test   $0x800,%eax
0053    49313:	74 15                	je     4932a <set_ftrace_ops_ro+0x6a>
0055    49315:	a8 04                	test   $0x4,%al
0057    49317:	48 8b bb 90 01 00 00 	mov    0x190(%rbx),%rdi
005e    4931e:	44 89 fe             	mov    %r15d,%esi
0061    49321:	41 0f 44 f4          	cmove  %r12d,%esi
0065    49325:	e8 00 00 00 00       	call   4932a <set_ftrace_ops_ro+0x6a>	49326: R_X86_64_PLT32	set_memory_ro-0x4
006a    4932a:	48 8b 5b 08          	mov    0x8(%rbx),%rbx
006e    4932e:	e8 00 00 00 00       	call   49333 <set_ftrace_ops_ro+0x73>	4932f: R_X86_64_PLT32	debug_lockdep_rcu_enabled-0x4
0073    49333:	48 85 db             	test   %rbx,%rbx
0076    49336:	74 05                	je     4933d <set_ftrace_ops_ro+0x7d>
0078    49338:	4c 39 f3             	cmp    %r14,%rbx
007b    4933b:	75 cd                	jne    4930a <set_ftrace_ops_ro+0x4a>
007d    4933d:	5b                   	pop    %rbx
007e    4933e:	41 5c                	pop    %r12
0080    49340:	41 5e                	pop    %r14
0082    49342:	41 5f                	pop    %r15
0084    49344:	c3                   	ret
0085    49345:	66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
0094    49354:	66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
00a3    49363:	66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
00b2    49372:	66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

