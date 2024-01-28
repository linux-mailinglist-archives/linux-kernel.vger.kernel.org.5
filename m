Return-Path: <linux-kernel+bounces-41552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6746883F461
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 07:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC77284774
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B72DDD1;
	Sun, 28 Jan 2024 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aiuyh86g"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655E6FB8;
	Sun, 28 Jan 2024 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706423965; cv=none; b=Bnl4BM7DCLKaXY2MhRA1IePmEMdWq8IPrbemQbUEAXRiDUzVGQh72D10nylfDln07wVK+zkt5Xiv+XRX1qi+MLvu+W7U5w1qkAyImEcTz9xLK9AN+ZrVJSDbUi7Umw5EuNrhOdys0iXUHDq5H2vp9plLSIF1Ex9t+4VxDNPdRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706423965; c=relaxed/simple;
	bh=H1uD8Tfwa5qhv4YaJZekukVZDfIZ6McIsLHA44r7WaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVIbpjnZvuu9lW0amaLp+rov1SrHJnNzdlqTHF+kQ6Z6DcExRc0G5RrPS7hKJ9Luw2chgkefk2IriSV/EjdTuFbSBg6EeROyl1bYhU8pI0bwEsc50Pq4vYLDIo7Gz61udjS29r2K0rz+M6PQajBYqO4xzxKiSVnf/kte0w63LR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aiuyh86g; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706423964; x=1737959964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H1uD8Tfwa5qhv4YaJZekukVZDfIZ6McIsLHA44r7WaQ=;
  b=Aiuyh86gI+c00BwP2DW+AlQ0ZsyJTz6eYRsU/aqtTHHCHQi8UDFmB5LL
   2lTiQItxohTAMzXgHS/8EShffG1bxVHSsz8OyELxHZtwNDkqiBrqn7yyU
   N1ARcmy6vB8ToZdzhWQ87pObKchj1uXFykaQVs+6/ePktNguTJ5AZswTi
   v8Y7tYPUf7Mq5ZjxD8ruMp/UBH6RiREe/w1zjM7juVNXQhkU2vj6qy3Ib
   qd9burMCfLdEDArgUX7CVpa9S4v78ZHqDJVTKH9xEQrNpnXDWZ9t4W+Nw
   X8u52HAlYV9uwAA4nc0os+S2PdSzoZMeirfSPGRepmWfHh29bVperVvO+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="402391089"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="402391089"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:39:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="910733518"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="910733518"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2024 22:39:16 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTyp0-0003AU-1Z;
	Sun, 28 Jan 2024 06:39:14 +0000
Date: Sun, 28 Jan 2024 14:38:23 +0800
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
Subject: Re: [PATCH v2 6/8] power: reset: add PSCR NVMEM Driver for Recording
 Power State Change Reasons
Message-ID: <202401281442.zKlRfljS-lkp@intel.com>
References: <20240124122204.730370-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124122204.730370-7-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on broonie-regulator/for-next rafael-pm/thermal linus/master v6.8-rc1 next-20240125]
[cannot apply to sre-power-supply/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/power-Extend-power_on_reason-h-for-upcoming-PSCRR-framework/20240124-202833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240124122204.730370-7-o.rempel%40pengutronix.de
patch subject: [PATCH v2 6/8] power: reset: add PSCR NVMEM Driver for Recording Power State Change Reasons
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240128/202401281442.zKlRfljS-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401281442.zKlRfljS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281442.zKlRfljS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/power/reset/pscrr-nvmem.c:53:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      53 |         kfree(buf);
         |         ^
   1 error generated.


vim +/kfree +53 drivers/power/reset/pscrr-nvmem.c

    39	
    40	static int pscrr_nvmem_read(struct pscrr_device *pscrr_dev, u32 *magic)
    41	{
    42		struct pscrr_nvmem *priv = container_of(pscrr_dev, struct pscrr_nvmem,
    43							pscrr_dev);
    44		size_t len;
    45		void *buf;
    46	
    47		buf = nvmem_cell_read(priv->cell, &len);
    48		if (IS_ERR(buf))
    49			return PTR_ERR(buf);
    50	
    51		*magic = 0;
    52		memcpy(magic, buf, min(len, sizeof(*magic)));
  > 53		kfree(buf);
    54	
    55		return 0;
    56	}
    57	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

