Return-Path: <linux-kernel+bounces-119007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E9788C28F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BC91C6061A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34596D1AB;
	Tue, 26 Mar 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKGIHkal"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747816CDA1;
	Tue, 26 Mar 2024 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457333; cv=none; b=Oxzn42t1ey3HipQC2zPxC1nJmGRP2AA3wF8p1nOzc+95Chz9EJ2PV6/hsq/kDGoqxJmvQssA9XBOEfb6K0fmUhW6NVwoVkl+um04of5fTENhNKJBgKZ/NP/KyFVJ0nSDavN3tosqJ/g8l2c4jQaU1D/bbdkZCHhFmwg31n9WO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457333; c=relaxed/simple;
	bh=UcNHx2WpgXj9N9ccfcFVrmItxhEccigipIMojc/QEfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRETYHN6aW1rVxHgnwTnSXm8zb3Vh3F57imYmQDfWLSAjP/KujNKwN2gm3QdkQuPkomyre96EzvnwdASzOSer5wtxlT2KysQBQK4MnZSIajmuy3QtgnoYTZ6+b2dKcggriHoaoMBF5Fy2zBc8gO0V4iNBbsPBQBUdJfCAqZejGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKGIHkal; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711457332; x=1742993332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UcNHx2WpgXj9N9ccfcFVrmItxhEccigipIMojc/QEfk=;
  b=cKGIHkalbfV/IDJrIesJY4nkl8BFOl3FoLzMUUlvOk6+m4ebwLuB2oC0
   vop99iiy4ENkovEyYix+cf7wsoLJWQSDARdXyj4AxatTu90ka7omfJqHq
   /TcyB9E6T/vuteQu52FTkPkNKRkZMuzWNIbUR8UoCRmC0cM83KD/MGJgz
   fSA8Fio7CQignold6v5D6z5C6GR3oDpA3CcJJ1VIKXALYlHZeeaPZy9Ya
   zOtYctGwR+aXWZlHG/QItLZhNJq1nFmm33H45lo8iBbUvc3R6CeVJE68R
   Dk80O8S0YN1oK4sDgKpetl4rFCWUn11vpV+ihsTzfuDGIEPhUXKpKuGUm
   Q==;
X-CSE-ConnectionGUID: maOtwHYjTm6pzKcWwbzJ5A==
X-CSE-MsgGUID: QMgyXjsRQXeNwYQTqbbxoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6693744"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6693744"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 05:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20651460"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 26 Mar 2024 05:48:47 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rp6EO-000030-1J;
	Tue, 26 Mar 2024 12:48:44 +0000
Date: Tue, 26 Mar 2024 20:48:04 +0800
From: kernel test robot <lkp@intel.com>
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	thomas.lendacky@amd.com, dan.j.williams@intel.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, graf@amazon.de, dwmw@amazon.co.uk,
	bchalios@amazon.es, xmarcalx@amazon.co.uk
Subject: Re: [PATCH v3 4/4] virt: vmgenid: add support for devicetree bindings
Message-ID: <202403262047.aZVjmDY5-lkp@intel.com>
References: <20240325195306.13133-5-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325195306.13133-5-sudanl@amazon.com>

Hi Sudan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8e938e39866920ddc266898e6ae1fffc5c8f51aa]

url:    https://github.com/intel-lab-lkp/linux/commits/Sudan-Landge/virt-vmgenid-rearrange-code-to-make-review-easier/20240326-035657
base:   8e938e39866920ddc266898e6ae1fffc5c8f51aa
patch link:    https://lore.kernel.org/r/20240325195306.13133-5-sudanl%40amazon.com
patch subject: [PATCH v3 4/4] virt: vmgenid: add support for devicetree bindings
config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20240326/202403262047.aZVjmDY5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240326/202403262047.aZVjmDY5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403262047.aZVjmDY5-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/virt/vmgenid.c: In function 'vmgenid_add_of':
>> drivers/virt/vmgenid.c:154:15: error: 'dev' undeclared (first use in this function); did you mean 'pdev'?
     154 |         (void)dev;
         |               ^~~
         |               pdev
   drivers/virt/vmgenid.c:154:15: note: each undeclared identifier is reported only once for each function it appears in


vim +154 drivers/virt/vmgenid.c

   121	
   122	static int vmgenid_add_of(struct platform_device *pdev, struct vmgenid_state *state)
   123	{
   124	#if IS_ENABLED(CONFIG_OF)
   125		void __iomem *remapped_ptr;
   126		int ret = 0;
   127	
   128		remapped_ptr = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
   129		if (IS_ERR(remapped_ptr)) {
   130			ret = PTR_ERR(remapped_ptr);
   131			goto out;
   132		}
   133	
   134		ret = setup_vmgenid_state(state, remapped_ptr);
   135		if (ret)
   136			goto out;
   137	
   138		state->irq = platform_get_irq(pdev, 0);
   139		if (state->irq < 0) {
   140			ret = state->irq;
   141			goto out;
   142		}
   143		pdev->dev.driver_data = state;
   144	
   145		ret =  devm_request_irq(&pdev->dev, state->irq,
   146					vmgenid_of_irq_handler,
   147					IRQF_SHARED, "vmgenid", &pdev->dev);
   148		if (ret)
   149			pdev->dev.driver_data = NULL;
   150	
   151	out:
   152		return ret;
   153	#else
 > 154		(void)dev;
   155		(void)state;
   156		return -EINVAL;
   157	#endif
   158	}
   159	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

