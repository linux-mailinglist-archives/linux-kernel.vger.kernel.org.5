Return-Path: <linux-kernel+bounces-97554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B20876BDE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642811C21894
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D555E071;
	Fri,  8 Mar 2024 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtRHIJfP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323423610A;
	Fri,  8 Mar 2024 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929926; cv=none; b=Zr4w4DC4bamRffbknaHE/GPe03FnXmSOv5t36gA2sw/LSajSi/UOwvGyF7JJ3Pp5CGXFTzzugJC8grPmvn2i4++Qix7kEVlgEAAHiYPHymXM0KWW9cW8sxx84oiY1Y+zvKIa60U6v2Gv5bbfHUKlUHFX41O+PhfRLxxIC29S7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929926; c=relaxed/simple;
	bh=SuGLD/ItYBvvW6ON69TwJnG0wH12j7uSmEc/7cNf2sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OejpKHiRJ0NrH5Nf8/6oYuemByFnLb16hPPb1ApcEC0dCkAuI44ZNW1Wn7fjZxMO61o9OvRb9rJaPqvERUud6ym82R2FUsi4KSabRtOOkzuOi2DUMl/a59uR2hGHOBAT3QVIQwG6hIz4DfwgIgAvGXueOV4QTmMhGqggFhTstzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtRHIJfP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709929924; x=1741465924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SuGLD/ItYBvvW6ON69TwJnG0wH12j7uSmEc/7cNf2sE=;
  b=WtRHIJfPY69sZrXTXn8TQuSjBoCzNaCvdh4S+AxyttcNQhlrA1vHa1wz
   Cj0yT4ohaIRd9JvI059E9VHDjnsvUuS9N3r3bBp/Iq7fEUGK0irqVRqtI
   D02Jf3k1/LAqWeo1xDX6/mbW7dZwBqm0Stc8Km+s5W6wKO7wgTgMbRNnc
   gQqLodnKUU1fxHPIwrgv1PRUbWGN5VPg89ON7cIlG7Y203AWDtntETsQn
   DGnRNuMJ8u0IBa2eiOiqwmxe8Sb72kFLkKeNSY2aXzR/++CapFp5vgsgJ
   YpoIVDAjf/ZQpI5DiP64I7AZX+C574mrk2m2fn+HGJCbhMccfgXl6csCK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="30107725"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="30107725"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 12:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="10664435"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Mar 2024 12:32:01 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rigso-0006gP-3D;
	Fri, 08 Mar 2024 20:31:58 +0000
Date: Sat, 9 Mar 2024 04:31:28 +0800
From: kernel test robot <lkp@intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: Re: [PATCH 1/5] media: imx335: Support 2 or 4 lane operation modes
Message-ID: <202403090439.t4lCQSzv-lkp@intel.com>
References: <20240306081038.212412-2-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306081038.212412-2-umang.jain@ideasonboard.com>

Hi Umang,

kernel test robot noticed the following build errors:

[auto build test ERROR on linuxtv-media-stage/master]
[cannot apply to media-tree/master sailus-media-tree/streams linus/master v6.8-rc7 next-20240308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Umang-Jain/media-imx335-Support-2-or-4-lane-operation-modes/20240306-161903
base:   https://git.linuxtv.org/media_stage.git master
patch link:    https://lore.kernel.org/r/20240306081038.212412-2-umang.jain%40ideasonboard.com
patch subject: [PATCH 1/5] media: imx335: Support 2 or 4 lane operation modes
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240309/202403090439.t4lCQSzv-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240309/202403090439.t4lCQSzv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403090439.t4lCQSzv-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/media/i2c/imx335.o: in function `imx335_init_controls.constprop.0':
>> imx335.c:(.text+0x33c): undefined reference to `__divdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

