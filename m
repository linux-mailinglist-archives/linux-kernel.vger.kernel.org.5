Return-Path: <linux-kernel+bounces-50736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E111D847D6A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA63B22CEE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB7F7F4;
	Fri,  2 Feb 2024 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TydYEL6O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966412C7FB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918382; cv=none; b=oLRZAwidgkmQYLvSb9sTSmddvvGtLM0aW+e5uWbEEU+7jl64OtRvwyxlM+tzTDETU4PIrYWOkmVOeSpTVLzOv0ZVYpKGJfOUSiJP6e1u/SCdjoKQ4tUZEBC6ppsGubngKBAOaxwyh3KAg9AxqXq5dWM+1lCeYEeCrEL3ruxuvYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918382; c=relaxed/simple;
	bh=5A9skUtFCK+UAqL2ThTfQPRkaTonC3kKQjH3wbP/VV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft7wkZLJ8Tdx76KCSHKw+81k4J6DXJCBfwKzcDcaUEtVV9+r7cmZkJQtUqv7Cb9yMGnJwXNFSzirwMzpkOelsJYRNXJ9m/wNBMBtLwGkbkS0W9GTS0p1JeheZwlOz0pPHTZ6F/01Gqs3gieQclazmzrV8ekD31FVbIWTR+EGzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TydYEL6O; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706918381; x=1738454381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5A9skUtFCK+UAqL2ThTfQPRkaTonC3kKQjH3wbP/VV0=;
  b=TydYEL6OQCaQ6ubDJj6kV6Sxvf609bTz8CUcp+C18hHdvSCcw/Na+nO5
   VFSTpXOBzC/6FQr3m2O1FqvHeWjWG8tShrM93EIyRP2/kHfwnnRPnPKXo
   MjJDBvAVlhKvFDYrPQHs/WKRvl9L9CI1h/1qyfsD11oMQF1Tn/zis+obl
   HrXpoytJ416pz46XQx4Sn7LsFO2uc18waH/Voy7ey2Q8TZfQSoFEDrZmd
   4NmQg82S68wdb4hPDobwtOtZkIeUDxzJGT0bMiMZ4NMn59RbI1chMZCj6
   61l3UCd7d8jc9VKp8s6TSHDNSFrDBkszbMlVvEpvm80ByP4/XTJuznon+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="173039"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="173039"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 15:59:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="494957"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 02 Feb 2024 15:59:38 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rW3RX-0004QK-3A;
	Fri, 02 Feb 2024 23:59:35 +0000
Date: Sat, 3 Feb 2024 07:58:42 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH 02/28] include: remove unnecessary #include directives
Message-ID: <202402030722.nMzDpW9K-lkp@intel.com>
References: <20240131145008.1345531-3-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131145008.1345531-3-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240131]
[cannot apply to mkp-scsi/for-next jejb-scsi/for-next axboe-block/for-next linus/master v6.8-rc2 v6.8-rc1 v6.7 v6.8-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/include-add-missing-includes/20240131-231042
base:   next-20240131
patch link:    https://lore.kernel.org/r/20240131145008.1345531-3-max.kellermann%40ionos.com
patch subject: [PATCH 02/28] include: remove unnecessary #include directives
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240203/202402030722.nMzDpW9K-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402030722.nMzDpW9K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402030722.nMzDpW9K-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/kunit/string-stream-test.c: In function 'string_stream_variable_length_line_test':
   lib/kunit/string-stream-test.c:230:26: error: storage size of 'rnd' isn't known
     230 |         struct rnd_state rnd;
         |                          ^~~
   lib/kunit/string-stream-test.c:243:9: error: implicit declaration of function 'prandom_seed_state' [-Werror=implicit-function-declaration]
     243 |         prandom_seed_state(&rnd, 3141592653589793238ULL);
         |         ^~~~~~~~~~~~~~~~~~
   lib/kunit/string-stream-test.c:246:26: error: implicit declaration of function 'prandom_u32_state' [-Werror=implicit-function-declaration]
     246 |                 offset = prandom_u32_state(&rnd) % (sizeof(line) - 1);
         |                          ^~~~~~~~~~~~~~~~~
>> lib/kunit/string-stream-test.c:230:26: warning: unused variable 'rnd' [-Wunused-variable]
     230 |         struct rnd_state rnd;
         |                          ^~~
   cc1: some warnings being treated as errors


vim +/rnd +230 lib/kunit/string-stream-test.c

4551caca6ab67f Richard Fitzgerald 2023-08-28  222  
4551caca6ab67f Richard Fitzgerald 2023-08-28  223  /* Add a series of lines of variable length to a string_stream. */
4551caca6ab67f Richard Fitzgerald 2023-08-28  224  static void string_stream_variable_length_line_test(struct kunit *test)
4551caca6ab67f Richard Fitzgerald 2023-08-28  225  {
4551caca6ab67f Richard Fitzgerald 2023-08-28  226  	static const char line[] =
4551caca6ab67f Richard Fitzgerald 2023-08-28  227  		"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
4551caca6ab67f Richard Fitzgerald 2023-08-28  228  		" 0123456789!$%^&*()_-+={}[]:;@'~#<>,.?/|";
4551caca6ab67f Richard Fitzgerald 2023-08-28  229  	struct string_stream *stream;
4551caca6ab67f Richard Fitzgerald 2023-08-28 @230  	struct rnd_state rnd;
4551caca6ab67f Richard Fitzgerald 2023-08-28  231  	char *concat_string, *pos, *string_end;
4551caca6ab67f Richard Fitzgerald 2023-08-28  232  	size_t offset, total_len;
4551caca6ab67f Richard Fitzgerald 2023-08-28  233  	int num_lines, i;
4551caca6ab67f Richard Fitzgerald 2023-08-28  234  
20631e154c78f4 Richard Fitzgerald 2023-08-28  235  	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
4551caca6ab67f Richard Fitzgerald 2023-08-28  236  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
4551caca6ab67f Richard Fitzgerald 2023-08-28  237  
4551caca6ab67f Richard Fitzgerald 2023-08-28  238  	/*
4551caca6ab67f Richard Fitzgerald 2023-08-28  239  	 * Log many lines of varying lengths until we have created
4551caca6ab67f Richard Fitzgerald 2023-08-28  240  	 * many fragments.
4551caca6ab67f Richard Fitzgerald 2023-08-28  241  	 * The "randomness" must be repeatable.
4551caca6ab67f Richard Fitzgerald 2023-08-28  242  	 */
4551caca6ab67f Richard Fitzgerald 2023-08-28  243  	prandom_seed_state(&rnd, 3141592653589793238ULL);
4551caca6ab67f Richard Fitzgerald 2023-08-28  244  	total_len = 0;
4551caca6ab67f Richard Fitzgerald 2023-08-28  245  	for (i = 0; i < 100; ++i) {
4551caca6ab67f Richard Fitzgerald 2023-08-28  246  		offset = prandom_u32_state(&rnd) % (sizeof(line) - 1);
4551caca6ab67f Richard Fitzgerald 2023-08-28  247  		string_stream_add(stream, "%s\n", &line[offset]);
4551caca6ab67f Richard Fitzgerald 2023-08-28  248  		total_len += sizeof(line) - offset;
4551caca6ab67f Richard Fitzgerald 2023-08-28  249  	}
4551caca6ab67f Richard Fitzgerald 2023-08-28  250  	num_lines = i;
4551caca6ab67f Richard Fitzgerald 2023-08-28  251  
4551caca6ab67f Richard Fitzgerald 2023-08-28  252  	concat_string = get_concatenated_string(test, stream);
4551caca6ab67f Richard Fitzgerald 2023-08-28  253  	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
4551caca6ab67f Richard Fitzgerald 2023-08-28  254  	KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
4551caca6ab67f Richard Fitzgerald 2023-08-28  255  
4551caca6ab67f Richard Fitzgerald 2023-08-28  256  	/*
4551caca6ab67f Richard Fitzgerald 2023-08-28  257  	 * Split the concatenated string at the newlines and check that
4551caca6ab67f Richard Fitzgerald 2023-08-28  258  	 * all the original added strings are present.
4551caca6ab67f Richard Fitzgerald 2023-08-28  259  	 */
4551caca6ab67f Richard Fitzgerald 2023-08-28  260  	prandom_seed_state(&rnd, 3141592653589793238ULL);
4551caca6ab67f Richard Fitzgerald 2023-08-28  261  	pos = concat_string;
4551caca6ab67f Richard Fitzgerald 2023-08-28  262  	for (i = 0; i < num_lines; ++i) {
4551caca6ab67f Richard Fitzgerald 2023-08-28  263  		string_end = strchr(pos, '\n');
4551caca6ab67f Richard Fitzgerald 2023-08-28  264  		KUNIT_EXPECT_NOT_NULL(test, string_end);
4551caca6ab67f Richard Fitzgerald 2023-08-28  265  
4551caca6ab67f Richard Fitzgerald 2023-08-28  266  		/* Convert to NULL-terminated string */
4551caca6ab67f Richard Fitzgerald 2023-08-28  267  		*string_end = '\0';
4551caca6ab67f Richard Fitzgerald 2023-08-28  268  
4551caca6ab67f Richard Fitzgerald 2023-08-28  269  		offset = prandom_u32_state(&rnd) % (sizeof(line) - 1);
4551caca6ab67f Richard Fitzgerald 2023-08-28  270  		KUNIT_EXPECT_STREQ(test, pos, &line[offset]);
4551caca6ab67f Richard Fitzgerald 2023-08-28  271  
4551caca6ab67f Richard Fitzgerald 2023-08-28  272  		pos = string_end + 1;
4551caca6ab67f Richard Fitzgerald 2023-08-28  273  	}
4551caca6ab67f Richard Fitzgerald 2023-08-28  274  
4551caca6ab67f Richard Fitzgerald 2023-08-28  275  	/* There shouldn't be any more data after this */
4551caca6ab67f Richard Fitzgerald 2023-08-28  276  	KUNIT_EXPECT_EQ(test, strlen(pos), 0);
4551caca6ab67f Richard Fitzgerald 2023-08-28  277  }
4551caca6ab67f Richard Fitzgerald 2023-08-28  278  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

