Return-Path: <linux-kernel+bounces-41572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111CD83F4BC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20AC2847B5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828271DFC6;
	Sun, 28 Jan 2024 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdnAYuK7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163BDDD2;
	Sun, 28 Jan 2024 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706432788; cv=none; b=nsU/9yLNXKmbr3OR0A1IAxwutraNo6XfhR30QZx7sQGUHZv+NSGti0aWoZdMaDA984Kle636hrLHaX2uAtD2L7TwYbAyx6BgCTm0qD0aWYSyjiLYZFCjcdxE8qIfglcL9j1p9L21LmROcs3LPW7y1qIwVPdrQTYi+AuMSRH3qmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706432788; c=relaxed/simple;
	bh=fECoJNI36xhLs+WlNCdEmmGpaXzg+LhNnyvIYrjamVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMUkOfdI8mNF2oX0xhkFy+Ej3iQ3FsAzZMQwS3AVSLrcYE0X3BCkrCQv6+DtTaypoStnhZqnYGmnAuenSi0Ht4K7OeDC/jj8OK4bm36R38Q/ThYym/OONScj+APgjWyD1tdS5j/7tYOQ3hSfD5YltM4Ze5N+4mHs/VBV2wWv/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdnAYuK7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706432787; x=1737968787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fECoJNI36xhLs+WlNCdEmmGpaXzg+LhNnyvIYrjamVI=;
  b=gdnAYuK7U2ZW3Gckk/LJR4k+ICIVTDIYYBH57NuLF8+k5zE2+jCRLGcS
   hOXl9uKd2EP7U7CHsLrSxOCMV3MNe+v90RCzeGvSTaoAf95cg1jNLAjxw
   u0w/ZJPpyNuirXJ/HKU0E1RcQ+43k5NJui3/P13zRpiav6fjOdodLOBan
   QBCSqX4hjo+J5MaAC70Liozw5AxjgDiF8WVVdwcbwRvk4FtWnp0i3u1BH
   MJuMYMbEtD+vtftGlMF9viob0IxQUE1EojSVs5J84byehkbtzUCC4k3uy
   dvJjId2EAm7dZYKSMCrfdezFpkMywb/9FH+QPeubRHbbDREA8iAzVDXAT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="9868501"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9868501"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 01:06:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="787533230"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="787533230"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2024 01:06:21 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU17L-0003GQ-1N;
	Sun, 28 Jan 2024 09:06:19 +0000
Date: Sun, 28 Jan 2024 17:05:26 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v2 3/8] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
Message-ID: <202401281628.Z3E5872D-lkp@intel.com>
References: <20240124122204.730370-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124122204.730370-4-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on broonie-regulator/for-next rafael-pm/thermal linus/master v6.8-rc1 next-20240125]
[cannot apply to sre-power-supply/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/power-Extend-power_on_reason-h-for-upcoming-PSCRR-framework/20240124-202833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240124122204.730370-4-o.rempel%40pengutronix.de
patch subject: [PATCH v2 3/8] power: reset: Introduce PSCR Recording Framework for Non-Volatile Storage
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240128/202401281628.Z3E5872D-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401281628.Z3E5872D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281628.Z3E5872D-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/power/reset/pscrr.c:132:2: warning: label at end of compound statement is a C2x extension [-Wc2x-extensions]
     132 |         }
         |         ^
   1 warning generated.


vim +132 drivers/power/reset/pscrr.c

   119	
   120	static const char *pscr_to_por_string(enum pscr pscr)
   121	{
   122		switch (pscr) {
   123		case PSCR_UNDER_VOLTAGE:
   124			return POWER_ON_REASON_BROWN_OUT;
   125		case PSCR_OVER_CURRENT:
   126			return POWER_ON_REASON_OVER_CURRENT;
   127		case PSCR_REGULATOR_FAILURE:
   128			return POWER_ON_REASON_REGULATOR_FAILURE;
   129		case PSCR_OVERTEMPERATURE:
   130			return POWER_ON_REASON_OVERTEMPERATURE;
   131		default:
 > 132		}
   133	
   134		return POWER_ON_REASON_UNKNOWN;
   135	}
   136	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

