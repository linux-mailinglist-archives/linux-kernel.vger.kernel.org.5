Return-Path: <linux-kernel+bounces-126037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC12893140
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B36CB21739
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A318143C75;
	Sun, 31 Mar 2024 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGZTt3X8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57961D6A8;
	Sun, 31 Mar 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711881869; cv=none; b=QTWmeGyQfP5ALhJbxv795LdBHW48AqBml1sh4l8TC3dJWFWPicbS8kI9JZQg9GoTjeO++v9dW+D3VAVTJNQOnqH4Cj7K6a1UvK+5CpyNtI25MsVr6/pCde6fOx8bXW1ekkOWU2TNtZGzk8j0jrtrUlMlwZtx7DcekOH5DQSSCJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711881869; c=relaxed/simple;
	bh=4wY766296ZfpAwSeZfZ9r1LSDhx2fJTZd42YdXCZ5AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owziHRd+QwycJqoy6Xy7QRgtv45BgBerr6GBMUqvVsZHzMxHtzc7wLp1JYz1KERX3NgouLKwOZeckkeAuAKKZruDIy3VWgeHfNCCYEDNKrWuQTIgX4BWlyyIV+fd6+YA7lpRyjtFj3OOMTppuOz1e/ngyf3eWZ2r4CDd05iaO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGZTt3X8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711881868; x=1743417868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4wY766296ZfpAwSeZfZ9r1LSDhx2fJTZd42YdXCZ5AY=;
  b=OGZTt3X8tS97AaUkADmyuj3kstMC4d9DVVrcwaRp5kgXcGG0Ivy/o4FF
   W94moUGGEQQnOGfEtPm13rn51UTrMFy0zE754iTkxGLtya9Gsh+t+hoY6
   yrkYl98/dktkgzQrNlWXJyjZzxxcCDrjyTdZAFb7t4FXl3G/qDEWIST3e
   7NJIyRvoKQXMhk2QOQvnCHu9vIDJg4+hAZpdd4Kukb2xfZ6F9vLL1lQaq
   URbNethUH3/A9T5opFgHz6IEX5qFMU4fw/gAAQjUeH7ra/pJm5Dl6W/J2
   kC6pdbR+ulPlCioaUVmjAflwiefauioF63QWssoqJcOcKF1WPkGBuB0D+
   A==;
X-CSE-ConnectionGUID: n8Wi9xH+TuaQUi/fLVc6ow==
X-CSE-MsgGUID: oR5Z1w6mRN+rJ4V5+GGckQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="9975512"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="9975512"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 03:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="48403245"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 Mar 2024 03:44:24 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqsfl-00012Y-1y;
	Sun, 31 Mar 2024 10:44:21 +0000
Date: Sun, 31 Mar 2024 18:43:44 +0800
From: kernel test robot <lkp@intel.com>
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, broonie@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com, Witold Sadowski <wsadowski@marvell.com>
Subject: Re: [PATCH 1/5] spi: cadence: Add new bindings documentation for
 Cadence XSPI
Message-ID: <202403311827.DCvAFLcu-lkp@intel.com>
References: <20240329194849.25554-2-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329194849.25554-2-wsadowski@marvell.com>

Hi Witold,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Witold-Sadowski/spi-cadence-Add-new-bindings-documentation-for-Cadence-XSPI/20240330-035124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240329194849.25554-2-wsadowski%40marvell.com
patch subject: [PATCH 1/5] spi: cadence: Add new bindings documentation for Cadence XSPI
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240331/202403311827.DCvAFLcu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403311827.DCvAFLcu-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/spi/cdns,xspi.yaml: properties:compatible: [{'const': 'cdns,xspi-nor'}, {'const': 'mrvl,xspi-nor'}] is not of type 'object', 'boolean'
   	from schema $id: http://json-schema.org/draft-07/schema#
>> Documentation/devicetree/bindings/spi/cdns,xspi.yaml: properties:compatible: [{'const': 'cdns,xspi-nor'}, {'const': 'mrvl,xspi-nor'}] is not of type 'object', 'boolean'
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
--
>> Documentation/devicetree/bindings/spi/cdns,xspi.yaml: ignoring, error in schema: properties: compatible
   Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

