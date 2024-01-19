Return-Path: <linux-kernel+bounces-31454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE8D832E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9023B1C23BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EB556450;
	Fri, 19 Jan 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHPVPXhO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2156445;
	Fri, 19 Jan 2024 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687157; cv=none; b=bJk/sEWnAq+oTzt3Vyd6z4p09d0s/J36iF/Z8uX/Kmf9W9X1yjE6sVkRzcaC5gdfYXGCruwi67QffvXol7cvJexQz033Ih3wpLwClHlqe7WNW41diYDvKa6OV0CBQApPAcvnjNe0+uosebRaPMqQc/Ppe3uRWo6RYX3mNSg8wTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687157; c=relaxed/simple;
	bh=dsWHy6JnTZszNamI0/QSn3jdjPlxnYv/iLVIegPI6d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQc/JPFVRnOC5RLstK/i3gED+yBTJp3CvDufG2wvnIXPxWSBkYMg/GlxRItqk2B+iVsOKMvv5OPkdmzeQWpA/n+6s+4oCjT2fecDjRz292558bWCYIo9p8oyCHPxR8UE5/NwW+XOFBnTJIGYwri17/XtSqOZVcJcpdmRoJ31Onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHPVPXhO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705687156; x=1737223156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dsWHy6JnTZszNamI0/QSn3jdjPlxnYv/iLVIegPI6d0=;
  b=BHPVPXhOAZHOugZCqwvDgqRddiUrGvzTP4heCcUKhfF3KEPRvDOQRUnk
   WXYrLwHRvix2ND4dlz8ZM5SbjHdrKDb1DHw8vB53qsCUi6Kuz5fvyjbQ+
   IwUMWgpmSym8nqum3f/sYcXexLpdzDmFX8PEIVy4K5VtO3ykpTzHnzYZD
   GYHySpZLZOMoKA68+U15gc5wQ4n9I+GXMGIIfsaXYb24ZOyWIwmg5fh/W
   ++XC4ykqlyCDDQ/IepX6FCwaxVxdRVPXT5S4qadmqukWoPzn8zTQZIPjs
   wLIZxq/IhDI3Zo7nifPTJuSnfYOlAWQT7vdKikIofYn4qnOz+/G2DMhNv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="7500981"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="7500981"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:59:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="713160"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 19 Jan 2024 09:59:11 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQt93-0004KW-1x;
	Fri, 19 Jan 2024 17:59:09 +0000
Date: Sat, 20 Jan 2024 01:58:51 +0800
From: kernel test robot <lkp@intel.com>
To: Dragan Cvetic <dragan.cvetic@amd.com>, arnd@arndb.de,
	gregkh@linuxfoundation.org, michal.simek@xilinx.com,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH 1/2] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Message-ID: <202401200159.p9T2rwq9-lkp@intel.com>
References: <20240116111135.3059-2-dragan.cvetic@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116111135.3059-2-dragan.cvetic@amd.com>

Hi Dragan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on robh/for-next linus/master v6.7 next-20240119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dragan-Cvetic/dt-bindings-misc-xlnx-sd-fec-convert-bindings-to-yaml/20240116-191349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240116111135.3059-2-dragan.cvetic%40amd.com
patch subject: [PATCH 1/2] dt-bindings: misc: xlnx,sd-fec: convert bindings to yaml
reproduce: (https://download.01.org/0day-ci/archive/20240120/202401200159.p9T2rwq9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401200159.p9T2rwq9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: Documentation/misc-devices/xilinx_sdfec.rst references a file that doesn't exist: linux-xlnx/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

