Return-Path: <linux-kernel+bounces-118433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4307388BACD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747EB1C319BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299A5129E98;
	Tue, 26 Mar 2024 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBNo5Xrc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5F823BF;
	Tue, 26 Mar 2024 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436036; cv=none; b=BYGi42SnGvHWPJ35ED12KIjJhVy1n25Z6mGLVou3QplKV1x/tH30DECjBmzEHBW2Ibj/eLet5qnipvXAFy+DIZCwC408B77Mydh3mTLRCEtTk99H+lzfJATqzadYMaN27W0YYrjVfg+rTUe4o+XQ9OHvDK+jBuh0SBhrrHZyo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436036; c=relaxed/simple;
	bh=T93oDLJVqmXjMft3p/o0gcTvmzd4o0CYgIVWkB1+goo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFy+qu/vjo9p2POQyimFtGkNIHhx6MV7N/djotpyvy0e8iJ4afNqKnriH2LxvoiT6uM83PJgP9A6IuLuZf6BkreItJCg8igxDsxG8/oWrkfP+1czPcN2lEYzBK9JpMah+LmMZtFYAI7fRQeayV+HVqNFRSk6etRho0GZ8lvj9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBNo5Xrc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711436034; x=1742972034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T93oDLJVqmXjMft3p/o0gcTvmzd4o0CYgIVWkB1+goo=;
  b=BBNo5Xrc8S1GuoUym+incVARZtH+VKRCrWCLi5JekqJohCWSjWbhX0u6
   96V1bYgs9xz/EP38WG58H8Qax2P/kfiF+P/Fucv2itAWkc2qJh6hqYpaw
   DRtkqa7orER+97JY3V19E4fYHcARv7JUgQf7vw3hSx7FwRA5neF3g495P
   NU8SQReuu/1p2wXuJBFHSP8iR098UNJ+g5JBQULEeUcsBe7wjnHgeFA4b
   vFjy9kUZayBUULwp9D2CZ8QUAupQ/YDNpncHl2HuWKX9qtRfeMlutmuGX
   XrMuAPcqs0jPgiV7JWFORdI+x8q6H9RH6Jcxw3WwYOIj3XmVa1w+oj4iX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10264706"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="10264706"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 23:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="46870214"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Mar 2024 23:53:51 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rp0gu-000NBW-0N;
	Tue, 26 Mar 2024 06:53:48 +0000
Date: Tue, 26 Mar 2024 14:53:26 +0800
From: kernel test robot <lkp@intel.com>
To: Sugar Zhang <sugar.zhang@rock-chips.com>, heiko@sntech.de
Cc: oe-kbuild-all@lists.linux.dev, linux-rockchip@lists.infradead.org,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: clock: rockchip: Add support for clk
 input / output switch
Message-ID: <202403261442.9P6rk3Wk-lkp@intel.com>
References: <1711340191-69588-2-git-send-email-sugar.zhang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711340191-69588-2-git-send-email-sugar.zhang@rock-chips.com>

Hi Sugar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on linus/master v6.9-rc1 next-20240325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sugar-Zhang/clk-rockchip-Add-support-for-clk-input-output-switch/20240325-212211
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/1711340191-69588-2-git-send-email-sugar.zhang%40rock-chips.com
patch subject: [PATCH v1 2/2] dt-bindings: clock: rockchip: Add support for clk input / output switch
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240326/202403261442.9P6rk3Wk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403261442.9P6rk3Wk-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/clock/rockchip,clk-out.yaml: title: 'Rockchip Clock Out Control Module Binding' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
   	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
   	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

