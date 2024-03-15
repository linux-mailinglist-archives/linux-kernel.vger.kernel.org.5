Return-Path: <linux-kernel+bounces-104431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0937687CDAA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6871C2210E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CAC2511E;
	Fri, 15 Mar 2024 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0/oQA38"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1B25565;
	Fri, 15 Mar 2024 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507808; cv=none; b=Lsp6D8Whkgi46WsIGyJAI6TVTu7YsXXNkztJplVMLS7baF/iTmMI++Pv1SI3KynPdSicLnpTe7yJLegbyeSCGlhzXAjzmJ+XrSU9/Gxh0JhvFBLr/FlUvkNWVqcwV3Wns9BASWNtEBuuI9asTu+ZI+EfKnRwBHE8FH5/abD5yPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507808; c=relaxed/simple;
	bh=ara5mPb1l4pRKoFUqGzmnoTbO47MBQwiFpYzhwnLMXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib7bs4Nizcojn/KSYGcAlkKr//NdaJQrC2r9WVeuFKEv5GN5KVhSadV9ZRUMrKUL9ohYMLRCGgd9HwzKAFRkDvN2B3ok5iGlUuTIFkBLOVIgo1ZM+Y4Wa308WPvQhVxCMUqBaBiYwdcMibNLAXT5sCBTMv9XQkTdZZWR+Q3G6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0/oQA38; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710507806; x=1742043806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ara5mPb1l4pRKoFUqGzmnoTbO47MBQwiFpYzhwnLMXo=;
  b=N0/oQA38/LMxjttXDnpRC/k5DDnnqibTRrtz2QeD1OMxHca0DAT4QbA6
   /48kaPQ7bT9IoCNgpINAtojoDTKSDXyfniG4LhocOIJy4X41/T+c6wzbo
   u2FghV3/0O+FHpiOSgZTO5ALXIGw2GzhHBIb/D9eyrQatS5AMFh+Gouok
   B6zHyoHrhzsvNIaw1jI/KQbL2MjW5Bv9x+Pf4Xoi/OiFJQOJzERZF3meA
   PE2ip4WNL8LGsTVvJq1T2UArhc/Tdb/LJF4OHOU8XbRDGkfBnlJ1DJgs9
   CwBPr5EOYX16zARgmiuBuSxk7P0CsubFPInzBuqtvsG4B4RoJGJRnPyMV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5240218"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5240218"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 06:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="35791084"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Mar 2024 06:00:08 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rl7AM-000ERh-0w;
	Fri, 15 Mar 2024 13:00:06 +0000
Date: Fri, 15 Mar 2024 20:59:16 +0800
From: kernel test robot <lkp@intel.com>
To: Vignesh Balasubramanian <vigbalas@amd.com>,
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, ebiederm@xmission.com,
	keescook@chromium.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, bpetkov@amd.com,
	jinisusan.george@amd.com, matz@suse.de, binutils@sourceware.org,
	jhb@freebsd.org, felix.willgerodt@intel.com,
	Vignesh Balasubramanian <vigbalas@amd.com>
Subject: Re: [PATCH 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
Message-ID: <202403152037.J6Fn7uiP-lkp@intel.com>
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
config: x86_64-randconfig-122-20240315 (https://download.01.org/0day-ci/archive/20240315/202403152037.J6Fn7uiP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240315/202403152037.J6Fn7uiP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403152037.J6Fn7uiP-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kernel/fpu/xstate.c: In function 'dump_xsave_layout_desc':
>> arch/x86/kernel/fpu/xstate.c:1858:22: error: implicit declaration of function 'dump_emit'; did you mean 'dir_emit'? [-Werror=implicit-function-declaration]
    1858 |                 if (!dump_emit(cprm, &xc, sizeof(struct xfeat_component)))
         |                      ^~~~~~~~~
         |                      dir_emit
   arch/x86/kernel/fpu/xstate.c: In function 'elf_coredump_extra_notes_write':
>> arch/x86/kernel/fpu/xstate.c:1903:14: error: implicit declaration of function 'dump_align'; did you mean 'dump_mapping'? [-Werror=implicit-function-declaration]
    1903 |         if (!dump_align(cprm, 4))
         |              ^~~~~~~~~~
         |              dump_mapping
   cc1: some warnings being treated as errors


vim +1858 arch/x86/kernel/fpu/xstate.c

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

