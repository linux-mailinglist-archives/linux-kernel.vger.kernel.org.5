Return-Path: <linux-kernel+bounces-67560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E797C856D78
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A011F23D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B19B139563;
	Thu, 15 Feb 2024 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P81HOJ48"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465A1386AE;
	Thu, 15 Feb 2024 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024555; cv=none; b=GWVgRDbybBE3kToo9JiyccV5pLxHcMQ0LJFWTDuGgXYqPCBFLtTr/Ae/cXqlYZjtB+cR13mLADUfGhIzCZjQxyLR0AYBf1/71VTFY5md4gEA5LTKGv3VfTekwW8VbjExHHhnOevyMFYXAO+n8leuFRkhn9Bj65qnTqmCus+eo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024555; c=relaxed/simple;
	bh=KxKSSdW354cOvf8mK+8TWJRT0uDhJmiIeexOvN+MHkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDrxpxGiZvt4UJUW54T6U2If0mVZItvHHKHOWKWWEUFvBY3YsAjvkFv1SA+/m5WFckmOyADF+gKLDPKavIFrMRBbDBtlr01zz9ctGhhEiUintnBxtdpAuXe+xj1QxE2cESA01vWWsRQKyWpdzgtcy4yJ7H2jQRyjIgOIHYfI8ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P81HOJ48; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708024553; x=1739560553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KxKSSdW354cOvf8mK+8TWJRT0uDhJmiIeexOvN+MHkk=;
  b=P81HOJ48si7BLQA+GN6QXZKKqG0W+5CRuRYOb6k5nOMOB4NthNoEQZ96
   a+1eZgBwh376V6K2rtFgEuLJcW5m0dMGWViUgtHzjxDmRCPVFT6DBRbHk
   59V4RglkJAuouscZpradL5s04nXhXSN1EBrHJ9JLJq7RRi6xEZTTpYNbT
   RT64rDxKxyCzELijUgDGIrOxkG763nHQ5lFx5y5kA3XzzFlrNawW2Ukfn
   mkRMRPPxWKqUGfBGFebNWT97Frj40KUENtdDfKyM0OjLRZUVTvzrgIzAA
   IyHkhOrrOv68vAPOwUKk7xqCqE98L9t6Pnir9pPHmdzQu8KWoTOoKD14K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="12853156"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="12853156"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:15:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="3590430"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 15 Feb 2024 11:15:45 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rahCg-0000iO-2m;
	Thu, 15 Feb 2024 19:15:42 +0000
Date: Fri, 16 Feb 2024 03:14:44 +0800
From: kernel test robot <lkp@intel.com>
To: Petr Tesarik <petrtesarik@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>,
	David Kaplan <david.kaplan@amd.com>,
	Larry Dewey <larry.dewey@amd.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Marc =?iso-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Mike Christie <michael.christie@oracle.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Maninder Singh <maninder1.s@samsung.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 4/5] sbm: SandBox Mode KUnit test suite
Message-ID: <202402160357.4hi1ecdG-lkp@intel.com>
References: <20240214113035.2117-5-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214113035.2117-5-petrtesarik@huaweicloud.com>

Hi Petr,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.8-rc4 next-20240215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Petr-Tesarik/sbm-SandBox-Mode-core-data-types-and-functions/20240214-193528
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240214113035.2117-5-petrtesarik%40huaweicloud.com
patch subject: [PATCH v1 4/5] sbm: SandBox Mode KUnit test suite
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240216/202402160357.4hi1ecdG-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 1c10821022f1799452065fb57474e894e2562b7f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240216/202402160357.4hi1ecdG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402160357.4hi1ecdG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sbm_test.c:648:25: error: use of undeclared identifier 'current_stack_pointer'
     648 |         unsigned long old_sp = current_stack_pointer;
         |                                ^
   kernel/sbm_test.c:651:2: error: use of undeclared identifier 'current_stack_pointer'
     651 |         current_stack_pointer = (unsigned long)end_of_stack(current);
         |         ^
   kernel/sbm_test.c:654:2: error: use of undeclared identifier 'current_stack_pointer'
     654 |         current_stack_pointer = old_sp;
         |         ^
   3 errors generated.


vim +/current_stack_pointer +648 kernel/sbm_test.c

   645	
   646	static SBM_DEFINE_FUNC(stack_overflow)
   647	{
 > 648		unsigned long old_sp = current_stack_pointer;
   649		int err;
   650	
   651		current_stack_pointer = (unsigned long)end_of_stack(current);
   652		barrier();
   653		err = kaboom();
   654		current_stack_pointer = old_sp;
   655		return err;
   656	}
   657	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

