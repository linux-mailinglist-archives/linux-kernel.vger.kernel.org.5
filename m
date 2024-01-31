Return-Path: <linux-kernel+bounces-47268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48789844B29
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A001F2B6DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D53A8ED;
	Wed, 31 Jan 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPIp5Ubf"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159933A1CB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740724; cv=none; b=h9IwbZxi0qaDOPxmmoybloxNFTWaPjM81Xy7EppJVuEYKOhBLL2kAFVCIjMFyEyA33uAEUOML4anYy/vthynMFRyOijcLJZYcEtkgylPm3Yi0qYn9Mm8MLRlXDDBOnoIuqN3IUD5Q77JDNZwzr93ZACcZQgwJj60WgeegaWi07M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740724; c=relaxed/simple;
	bh=0ownxDdR6itc76czu9AnVA9VuquUBxUT1Bl8SDFwWqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCMoL0llvhB4rB4CA6sywsr6m0f8zt+ceKyn+ivVPIKEtqZr3hZ37qT3tcfI5fHylypzr43PXOXTu5GgIGEVJZmS9Y3t4oLq0Sz127a6edCm7Kk5HK6X5oaFi0gCnZOLQBpvQ/4kiGS33Gm2PkSc7ERfFSoXYwiibKyP8rl7etM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPIp5Ubf; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706740723; x=1738276723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ownxDdR6itc76czu9AnVA9VuquUBxUT1Bl8SDFwWqg=;
  b=fPIp5UbfGeItuikkyXxw4qpw72OF2LsbpNT+NesniMB184Ze+GNp00NJ
   J10mPmO0yjViEpFLDdR4bjuCPK5yyjTFwza/ToFRB1DpJtHTvtiBoLPaR
   m7ps38Q4o2Z8gEJQUK1QizeHKeLUQD5AOMXQCtofvdKi2SjeGNu1OdMuj
   sSNhHv3ALN733CzuZ8JHMjfuBt6u+7aiWRMwHOGlZmU3xXNxCt7fBe5e0
   0DO0LVL1oI/4ySxOnEq6bg+HNy7eHpKr47YMr2/WwxJaMPBeF+S2cLhtm
   zWds+fcQcdDxzIfiv0d1dtvIiARx9TlaXGNcyD4SNJJvaK8TEOo4MbVvo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407462368"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="407462368"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 14:38:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4229963"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 31 Jan 2024 14:38:32 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVJDy-00026U-0W;
	Wed, 31 Jan 2024 22:38:30 +0000
Date: Thu, 1 Feb 2024 06:37:49 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm: ptdump: Have ptdump_check_wx() return bool
Message-ID: <202402010618.9izDkpGF-lkp@intel.com>
References: <7943149fe955458cb7b57cd483bf41a3aad94684.1706610398.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7943149fe955458cb7b57cd483bf41a3aad94684.1706610398.git.christophe.leroy@csgroup.eu>

Hi Christophe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/arm-ptdump-Rename-CONFIG_DEBUG_WX-to-CONFIG_ARM_DEBUG_WX/20240130-183913
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/7943149fe955458cb7b57cd483bf41a3aad94684.1706610398.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH v2 4/5] mm: ptdump: Have ptdump_check_wx() return bool
config: i386-randconfig-141-20240131 (https://download.01.org/0day-ci/archive/20240201/202402010618.9izDkpGF-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240201/202402010618.9izDkpGF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402010618.9izDkpGF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/mm/dump_pagetables.c:365:6: error: cannot combine with previous 'type-name' declaration specifier
     365 | bool void ptdump_walk_pgd_level_core(struct seq_file *m,
         |      ^
>> arch/x86/mm/dump_pagetables.c:365:11: warning: no previous prototype for function 'ptdump_walk_pgd_level_core' [-Wmissing-prototypes]
     365 | bool void ptdump_walk_pgd_level_core(struct seq_file *m,
         |           ^
   arch/x86/mm/dump_pagetables.c:365:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     365 | bool void ptdump_walk_pgd_level_core(struct seq_file *m,
         | ^
         | static 
   1 warning and 1 error generated.


vim +/ptdump_walk_pgd_level_core +365 arch/x86/mm/dump_pagetables.c

   364	
 > 365	bool void ptdump_walk_pgd_level_core(struct seq_file *m,
   366					       struct mm_struct *mm, pgd_t *pgd,
   367					       bool checkwx, bool dmesg)
   368	{
   369		const struct ptdump_range ptdump_ranges[] = {
   370	#ifdef CONFIG_X86_64
   371		{0, PTRS_PER_PGD * PGD_LEVEL_MULT / 2},
   372		{GUARD_HOLE_END_ADDR, ~0UL},
   373	#else
   374		{0, ~0UL},
   375	#endif
   376		{0, 0}
   377	};
   378	
   379		struct pg_state st = {
   380			.ptdump = {
   381				.note_page	= note_page,
   382				.effective_prot = effective_prot,
   383				.range		= ptdump_ranges
   384			},
   385			.level = -1,
   386			.to_dmesg	= dmesg,
   387			.check_wx	= checkwx,
   388			.seq		= m
   389		};
   390	
   391		ptdump_walk_pgd(&st.ptdump, mm, pgd);
   392	
   393		if (!checkwx)
   394			return true;
   395		if (st.wx_pages) {
   396			pr_info("x86/mm: Checked W+X mappings: FAILED, %lu W+X pages found.\n",
   397				st.wx_pages);
   398	
   399			return false;
   400		} else {
   401			pr_info("x86/mm: Checked W+X mappings: passed, no W+X pages found.\n");
   402	
   403			return true;
   404		}
   405	}
   406	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

