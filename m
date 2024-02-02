Return-Path: <linux-kernel+bounces-50595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EAE847B60
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9CCFB2AC0E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D680631;
	Fri,  2 Feb 2024 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMXPHaZw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADDE8061F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706908156; cv=none; b=RhPqACKKxrPL7fEW9If5Qa9Dvq3zAs1wTna56VQ4R0d2XM8wj1hYggzmXh95/4W0d0+6ayS57tkVyb9dISjslHWNAdiRpMcNuv2eO4smUdywXdJUem9MBRbrS/by1eldAgaJtprU0HuJadezm6PMNZCTejbSvfD9fCI9EFbSArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706908156; c=relaxed/simple;
	bh=hxd5d2XNTGe78cj97Hq4bIzwkO2DBjwVeHtJXRjHd3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXjsHv/WpV7dw1Oz7vRsbZwzZ6lTrNQPbfGsnmFmWexxwX1UOXBCWIe/UpSMsakQEwUDPvCzsM4qaoadJ33iLQxlE0Gy8Cj1/gRYvlmGnqlgx6d6/rwt1uIGxkN1KaYKs+9jLGw9V7UgYHvIyuyvNb4aw6VajAcvclbHR+2gvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMXPHaZw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706908153; x=1738444153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hxd5d2XNTGe78cj97Hq4bIzwkO2DBjwVeHtJXRjHd3E=;
  b=CMXPHaZwsrRMeqW1/l0S54Si3etmdD6213zGGezUK1C4XSjmKY6G6m/f
   F4xBC7PFqshxEqUCNMfbbk7/lnSaKoLhsStV260dajy8AVpN1/YrEjS3c
   qR8GUgBjU0UtO0Dbpn5gDq3R8MUY41xQYdXqaJPp/lZg5sZb1e7G37pTN
   5V7xE90ai3h4dKgteZUWO8cxfKUpeEjwrfeGRtyyN7x13xsb0pP7lxDNB
   fBcQj2z51kN7S7zj6WxcgoBveLPnBgUdzmMx+P2YftoJuI6F4c8nKS/wb
   oDYOESk7QCFAmYsIp5E16Avm7e2rvfz53TFPfrO1igxOXDEsAqvLBqw8E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="420271"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="420271"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 13:09:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4771764"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 02 Feb 2024 13:09:05 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rW0mV-0004GY-0W;
	Fri, 02 Feb 2024 21:09:03 +0000
Date: Sat, 3 Feb 2024 05:08:39 +0800
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
	Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm: ptdump: Have ptdump_check_wx() return bool
Message-ID: <202402030403.WAFc9HZO-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/arm-ptdump-Rename-CONFIG_DEBUG_WX-to-CONFIG_ARM_DEBUG_WX/20240130-183913
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/7943149fe955458cb7b57cd483bf41a3aad94684.1706610398.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH v2 4/5] mm: ptdump: Have ptdump_check_wx() return bool
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240203/202402030403.WAFc9HZO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402030403.WAFc9HZO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402030403.WAFc9HZO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/mm/dump_pagetables.c:365:6: error: two or more data types in declaration specifiers
     365 | bool void ptdump_walk_pgd_level_core(struct seq_file *m,
         |      ^~~~
   arch/x86/mm/dump_pagetables.c:365:11: warning: no previous prototype for 'ptdump_walk_pgd_level_core' [-Wmissing-prototypes]
     365 | bool void ptdump_walk_pgd_level_core(struct seq_file *m,
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +365 arch/x86/mm/dump_pagetables.c

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

