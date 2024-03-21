Return-Path: <linux-kernel+bounces-110616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F92D886153
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45342281D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB42A134CD4;
	Thu, 21 Mar 2024 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAQkvuRD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E5E13442E;
	Thu, 21 Mar 2024 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050786; cv=none; b=euEIkqb8bwXmBY4j5ma2CSqooJH8HELWMgcLo+qCKIchjc+5NjyWlff43hKL9zuJP1jy698d8vuQBGnJwWD5JT3Iq02Q2YZJkz5tCawE8vLZnTiVvRpCw4csMd/DqPcu5UDh4qMGgstQ+otidfuaSEThD1wIsJHT3EYgIht554Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050786; c=relaxed/simple;
	bh=0AZsgEksMv0v7XeGuddRbuorgH0+GV74G/W/bjtGFUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFEq4UyELipmVWSVB3vKyvultijybfVXuljkEe1sexYoBPhIP8HJ+Oy0QCz+qY37TT1sKioemSUqu0rhjVMYDubO2p9r2i7nuGRJ80skYlLv5xk/+RabIlRJ9i3rdURR8eejC5Zu/Q6TMBPfPXcWqXhTdhXVm/i3Pi4hvsiu9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAQkvuRD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711050784; x=1742586784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0AZsgEksMv0v7XeGuddRbuorgH0+GV74G/W/bjtGFUk=;
  b=fAQkvuRDDmdDmsMAIroOiMv6OsnNxMz3hyC8F8AcgZU8XtcWtLIFJKb0
   qA8JbWd+5F6Jew5GtwqNmVuuO29QcoVfVMPyeGojjKVP1cUaaRrJlh3zE
   r8BrT/17fttRgc0u9kJuPvf3yg0R+Vt1Bs+A5O2gOTjsokFYl1bwyiZUe
   wkkHR96qNlCfW1f2RnpTzzOVIRUETzcyAeP+6jb0pa6tr8HabCylCr58L
   riCb3uyagLntFgbtWqA9EXQfUvx6omLdniF0ANzOMBQfCI4EQDqV3kjjJ
   0Dp6VzhGWbjM3rtXM5JpYNqN0Uua5vzi1791aA5BUwzc9cRs8bYZxfMPI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28541701"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="28541701"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 12:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="19285155"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 21 Mar 2024 12:52:59 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnOTA-000Jjz-2l;
	Thu, 21 Mar 2024 19:52:56 +0000
Date: Fri, 22 Mar 2024 03:52:32 +0800
From: kernel test robot <lkp@intel.com>
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	thomas.lendacky@amd.com, dan.j.williams@intel.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, graf@amazon.de, dwmw@amazon.co.uk,
	bchalios@amazon.es, xmarcalx@amazon.co.uk
Subject: Re: [PATCH v2 4/4] virt: vmgenid: add support for devicetree bindings
Message-ID: <202403220322.EGtpD4Jw-lkp@intel.com>
References: <20240321025105.53210-5-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321025105.53210-5-sudanl@amazon.com>

Hi Sudan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a4145ce1e7bc247fd6f2846e8699473448717b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Sudan-Landge/virt-vmgenid-rearrange-code-to-make-review-easier/20240321-105317
base:   a4145ce1e7bc247fd6f2846e8699473448717b37
patch link:    https://lore.kernel.org/r/20240321025105.53210-5-sudanl%40amazon.com
patch subject: [PATCH v2 4/4] virt: vmgenid: add support for devicetree bindings
config: x86_64-randconfig-123-20240321 (https://download.01.org/0day-ci/archive/20240322/202403220322.EGtpD4Jw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240322/202403220322.EGtpD4Jw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403220322.EGtpD4Jw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/virt/vmgenid.c:153:43: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +153 drivers/virt/vmgenid.c

   133	
   134	static int vmgenid_add_of(struct device *dev, struct vmgenid_state *state)
   135	{
   136	#ifdef	CONFIG_OF
   137		struct resource res;
   138		int ret = 0;
   139	
   140		if (of_address_to_resource(dev->of_node, 0, &res)) {
   141			dev_err(dev, "Failed to get resources from device tree");
   142			ret = -EINVAL;
   143			goto out;
   144		}
   145	
   146		if (!__request_mem_region(res.start, resource_size(&res),
   147					  "vmgenid", IORESOURCE_EXCLUSIVE)) {
   148			dev_err(dev, "Failed to request mem region");
   149			ret = -EINVAL;
   150			goto out;
   151		}
   152	
 > 153		ret = setup_vmgenid_state(state, (u8 *)of_iomap(dev->of_node, 0));
   154		if (ret)
   155			goto out;
   156	
   157		state->irq = irq_of_parse_and_map(dev->of_node, 0);
   158		dev->driver_data = state;
   159	
   160		if (request_irq(state->irq, vmgenid_of_irq_handler,
   161				IRQF_SHARED, "vmgenid", dev) < 0) {
   162			dev_err(dev, "request_irq failed");
   163			dev->driver_data = NULL;
   164			ret = -EINVAL;
   165			goto out;
   166		}
   167	
   168	out:
   169		return ret;
   170	#else
   171		(void)dev;
   172		(void)state;
   173		return -EINVAL;
   174	#endif
   175	}
   176	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

