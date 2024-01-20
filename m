Return-Path: <linux-kernel+bounces-31767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B628333B8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1932836CC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222FADDCA;
	Sat, 20 Jan 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXBBKmqp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC08D304;
	Sat, 20 Jan 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705748383; cv=none; b=XYXfDhRpsC9O5o/wmKJuNlxG2foRlIAKsyHEPQZmsZa3jn/Cy1wcY/QEdJBOLi5PnTd9qIa9x/IZpqbpxRDH/8ewORapv8uYEsKOmBT5nvx++1qx1RXIjkWZ/IM/wMUvoQTFA6EBzx2mz4SjYWTyv44K+z9tJb1uxC8OoelU38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705748383; c=relaxed/simple;
	bh=Ilz1xWtpSY/qvW9bs/VOcsKSKWgmpOf2n2Djbw5kftI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epWKp+ual42zyZJJrGiqzK8WXVI5ToaOR5v8Gq5i3OnNbqdflO8KperQyLme2+Btla0kFGfyIJoM9nqaO3rgS6pFa31ATnCXBKl0nonYV+kvBf7WLEECq7kLEcxzUktMh9J+3HX5vjC1xuUB7QkpQ9wEaFnWkABzMlBL5ChuKPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXBBKmqp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705748382; x=1737284382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ilz1xWtpSY/qvW9bs/VOcsKSKWgmpOf2n2Djbw5kftI=;
  b=PXBBKmqpeCaYVZt2FyP8ghem0pJt5T2YB7Y7lCQokplZvK4dHxKWsILj
   h4Y0NcFMwhPuwANf5xTqyyJX15CmkHcwL/S/tFQ2ea/NwC7kkKA6jAuIZ
   aHGyOTio8q3J1VYzETbhMCjxyeD4ybavBApC9EO5wNs9Lqfl2m+WVLGEp
   jEbpu2V5B1vkab2cMqqJZPfehme+CSy5sgR3ehsDaTsHbS2aRirs9YXIf
   kZttgqRKsJmnx6YGEL/7qeHyvwM76GY5GRned35zky9sjkcChLVqIbPHK
   NYUJXXZBmUcIVY/ebY8PJiD5OQ6XYxb9MwYlpObr7qnv4opE6PSm25zeX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="14281719"
X-IronPort-AV: E=Sophos;i="6.05,207,1701158400"; 
   d="scan'208";a="14281719"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 02:59:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904388816"
X-IronPort-AV: E=Sophos;i="6.05,207,1701158400"; 
   d="scan'208";a="904388816"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2024 02:59:36 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rR94Y-00051W-1d;
	Sat, 20 Jan 2024 10:59:34 +0000
Date: Sat, 20 Jan 2024 18:58:50 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	heikki.krogerus@linux.intel.com, matthias.bgg@gmail.com,
	dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
	andersson@kernel.org, nathan@kernel.org, luca.weiss@fairphone.com,
	tianping.fang@mediatek.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/2] usb: typec: mux: Add ITE IT5205 Alternate Mode
 Passive MUX driver
Message-ID: <202401201835.bmry790M-lkp@intel.com>
References: <20240119125812.239197-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119125812.239197-3-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus robh/for-next westeri-thunderbolt/next linus/master v6.7 next-20240119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-usb-Introduce-ITE-IT5205-Alt-Mode-Passive-MUX/20240119-210119
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240119125812.239197-3-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v2 2/2] usb: typec: mux: Add ITE IT5205 Alternate Mode Passive MUX driver
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240120/202401201835.bmry790M-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401201835.bmry790M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401201835.bmry790M-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/acpi.h:14,
                    from include/linux/i2c.h:13,
                    from drivers/usb/typec/mux/it5205.c:12:
>> drivers/usb/typec/mux/it5205.c:278:25: error: 'it5205_match_table' undeclared here (not in a function); did you mean 'it5205_of_table'?
     278 | MODULE_DEVICE_TABLE(of, it5205_match_table);
         |                         ^~~~~~~~~~~~~~~~~~
   include/linux/module.h:244:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |               ^~~~
>> include/linux/module.h:244:21: error: '__mod_of__it5205_match_table_device_table' aliased to undefined symbol 'it5205_match_table'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |                     ^~~~~~
   drivers/usb/typec/mux/it5205.c:278:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     278 | MODULE_DEVICE_TABLE(of, it5205_match_table);
         | ^~~~~~~~~~~~~~~~~~~


vim +278 drivers/usb/typec/mux/it5205.c

   273	
   274	static const struct of_device_id it5205_of_table[] = {
   275		{ .compatible = "ite,it5205" },
   276		{ /* sentinel */ }
   277	};
 > 278	MODULE_DEVICE_TABLE(of, it5205_match_table);
   279	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

