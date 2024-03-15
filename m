Return-Path: <linux-kernel+bounces-104234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7437287CB02
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B1CAB21CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EE618036;
	Fri, 15 Mar 2024 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHE/gDLL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411317C7B;
	Fri, 15 Mar 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496812; cv=none; b=H10/X8ydz1FLfYXiLiJnBAoXzOCWBN+x2GCfwYTWxf5Ys53NGuz10fsoJTJK2zwr/nJkqO6b1Wkcbir25gA7Z5Ui56ROIn/O11rfsCI5oTIgZWuAxXM8J9qkUKr0Tf6ylQ48fZLQD8kJfwlcgN5ZDhCj4NRQMTOTi6Sy+We8I7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496812; c=relaxed/simple;
	bh=TgsPBTRp6nSShb4vL2Mx+LcNmJuRLjnumD5YkOFdYI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RotQDMrDeg4pVvB8f5BU1NAzHuTHpDVrJYlRh55+eV9hFnPqOblkoCQ5X+xRo+HpMwtBqLc4meSVWoaJndO5MAJemGwnKo7fCxijGStSvJJFQY4Q8qyolIl79QgNyHejVf4vSt+dTBlgYofwXGnOoZ3lmklc8Bdt7S8GtNwBTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHE/gDLL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710496810; x=1742032810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TgsPBTRp6nSShb4vL2Mx+LcNmJuRLjnumD5YkOFdYI4=;
  b=aHE/gDLLvk6BwdJO4fxRh5EkU8dnCvZ+ijuPFikmmA0muHdhnaxeo7CV
   LL1UhxSfAoH3wzzZ6G+H0LoHzQjipPw48Ju50z1xE2vTMq97NcxAnrRsQ
   PB2ad/bo56jBFuXetAFDNKwN9fpT+oFLPUHSTW3ingSV4SvAvPpuYp0/9
   0nJxhq71g1Rlb98edfVgxu2qGawXuhDXenlSdetQTkhgj0U8F0TaiulXE
   dDafyfQiABOjbLIZmZIuCt7S3FTbdOYm6YWD6+UYyvLeXfOlZZfHJi6LT
   f0hgxlIg2HJy9BwsWkFYHqAfoWFV7L4JhD2eqz50FNn4FKVKy1+O8vpZ+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16081058"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="16081058"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 03:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="35749372"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Mar 2024 03:00:04 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rl4M6-000EJx-0R;
	Fri, 15 Mar 2024 10:00:02 +0000
Date: Fri, 15 Mar 2024 17:59:53 +0800
From: kernel test robot <lkp@intel.com>
To: Vignesh Balasubramanian <vigbalas@amd.com>,
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
	ebiederm@xmission.com, keescook@chromium.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, bpetkov@amd.com,
	jinisusan.george@amd.com, matz@suse.de, binutils@sourceware.org,
	jhb@freebsd.org, felix.willgerodt@intel.com,
	Vignesh Balasubramanian <vigbalas@amd.com>
Subject: Re: [PATCH 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
Message-ID: <202403151742.VEz04MqR-lkp@intel.com>
References: <20240314112359.50713-2-vigbalas@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314112359.50713-2-vigbalas@amd.com>

Hi Vignesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.8 next-20240315]
[cannot apply to kees/for-next/execve tip/x86/core powerpc/next powerpc/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vignesh-Balasubramanian/x86-elf-Add-a-new-note-section-containing-Xfeatures-information-to-x86-core-files/20240314-192650
base:   linus/master
patch link:    https://lore.kernel.org/r/20240314112359.50713-2-vigbalas%40amd.com
patch subject: [PATCH 1/1] x86/elf: Add a new .note section containing Xfeatures information to x86 core files
config: i386-buildonly-randconfig-001-20240315 (https://download.01.org/0day-ci/archive/20240315/202403151742.VEz04MqR-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240315/202403151742.VEz04MqR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403151742.VEz04MqR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/fpu/xstate.c:1858:8: error: call to undeclared function 'dump_emit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1858 |                 if (!dump_emit(cprm, &xc, sizeof(struct xfeat_component)))
         |                      ^
   arch/x86/kernel/fpu/xstate.c:1869:8: error: call to undeclared function 'dump_emit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1869 |                 if (!dump_emit(cprm, &xc, sizeof(struct xfeat_component)))
         |                      ^
   arch/x86/kernel/fpu/xstate.c:1899:7: error: call to undeclared function 'dump_emit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1899 |         if (!dump_emit(cprm, &en, sizeof(en)))
         |              ^
>> arch/x86/kernel/fpu/xstate.c:1903:7: error: call to undeclared function 'dump_align'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1903 |         if (!dump_align(cprm, 4))
         |              ^
   4 errors generated.


vim +/dump_emit +1858 arch/x86/kernel/fpu/xstate.c

  1846	
  1847		struct xfeat_component xc;
  1848		int num_records = 0;
  1849		int i;
  1850	
  1851		/* XFEATURE_FPU and XFEATURE_SSE, both are fixed legacy states. */
  1852		for (i = 0; i < FIRST_EXTENDED_XFEATURE; i++) {
  1853			xc.xfeat_type = i;
  1854			xc.xfeat_sz = xstate_sizes[i];
  1855			xc.xfeat_off = xstate_offsets[i];
  1856			xc.xfeat_flags = xstate_flags[i];
  1857	
> 1858			if (!dump_emit(cprm, &xc, sizeof(struct xfeat_component)))
  1859				return 0;
  1860			num_records++;
  1861		}
  1862	
  1863		for_each_extended_xfeature(i, fpu_user_cfg.max_features) {
  1864			xc.xfeat_type = i;
  1865			xc.xfeat_sz = xstate_sizes[i];
  1866			xc.xfeat_off = xstate_offsets[i];
  1867			xc.xfeat_flags = xstate_flags[i];
  1868	
  1869			if (!dump_emit(cprm, &xc, sizeof(struct xfeat_component)))
  1870				return 0;
  1871			num_records++;
  1872		}
  1873	
  1874		return num_records;
  1875	}
  1876	
  1877	static int get_xsave_desc_size(void)
  1878	{
  1879		/* XFEATURE_FP and XFEATURE_SSE, both are fixed legacy states */
  1880		int xfeatures_count = 2;
  1881		int i;
  1882	
  1883		for_each_extended_xfeature(i, fpu_user_cfg.max_features)
  1884			xfeatures_count++;
  1885	
  1886		return xfeatures_count * (sizeof(struct xfeat_component));
  1887	}
  1888	
  1889	int elf_coredump_extra_notes_write(struct coredump_params *cprm)
  1890	{
  1891		const char *owner_name = "LINUX";
  1892		int num_records = 0;
  1893		struct elf_note en;
  1894	
  1895		en.n_namesz = strlen(owner_name) + 1;
  1896		en.n_descsz = get_xsave_desc_size();
  1897		en.n_type = NT_X86_XSAVE_LAYOUT;
  1898	
  1899		if (!dump_emit(cprm, &en, sizeof(en)))
  1900			return 1;
  1901		if (!dump_emit(cprm, owner_name, en.n_namesz))
  1902			return 1;
> 1903		if (!dump_align(cprm, 4))
  1904			return 1;
  1905	
  1906		num_records = dump_xsave_layout_desc(cprm);
  1907		if (!num_records) {
  1908			pr_warn("Error adding XSTATE layout ELF note. XSTATE buffer in the core file will be unparseable.");
  1909			return 1;
  1910		}
  1911	
  1912		/* Total size should be equal to the number of records */
  1913		if ((sizeof(struct xfeat_component) * num_records) != en.n_descsz) {
  1914			pr_warn("Error adding XSTATE layout ELF note. The size of the .note section does not match with the total size of the records.");
  1915			return 1;
  1916		}
  1917	
  1918		if (!dump_align(cprm, 4))
  1919			return 1;
  1920	
  1921		return 0;
  1922	}
  1923	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

