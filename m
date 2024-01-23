Return-Path: <linux-kernel+bounces-34821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B03E68387EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A36C286BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F1E524D3;
	Tue, 23 Jan 2024 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMVKSCJv"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E45257;
	Tue, 23 Jan 2024 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705994734; cv=none; b=X9Z99ql662Y8H64bprY6fcwd6AgMzxTa1LsT828hTSnSZNqMoEJIxhDt7/zyKrGodotREnUJN9XpADaQcKFQIb7t5TuhtAV37DZ5AFhiETYX3eyI1Sa9EHEjakNj8v133P9IZpX/zRlF1cX/MrFv6Dz1WaZ3yES9Mq/TbFLBe6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705994734; c=relaxed/simple;
	bh=bONvD8Ha14F6R8BU5+1e4oFxuXsdFHJK7r5bFwQINyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoIIoqvsGJ6Y2kbxKkobyS0jI+ZU8J0q88SUqK9XR/p3DkR6YLHyxqtZ9zWZbFABF4ruo4MFPNv8UPdeWXAhpqXvURWSZFkMOpDvvcpXoqe4qEGbHH0l1ZZWjNkxTQT33l3BJM0C77pqom7abYEe3A99gY5ksXzxjEwkdw8ixWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMVKSCJv; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705994733; x=1737530733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bONvD8Ha14F6R8BU5+1e4oFxuXsdFHJK7r5bFwQINyE=;
  b=YMVKSCJvxUI7KkqNeeRkwJ/PB6gwXfBkAbBipkrj5DvxnilW4j7uCLus
   hkDE4u71FCsjIPf8DSYf1D2w8ceneRf4+VKo5dTq0fLfUswPv3ShJEJYP
   5xFrqoRKGWexrGljwXDftQypBApbeynzLbOqqUZXdE42VwS5loLO6KTau
   wMdZNVUHDssn2fYYTs6hOIoX/Jmd8f2wgpFgDnVL2OUDKo03CG/zC9FXY
   3LISS9TEmRzSG2F5f+DK8Nt0YvLInzVtHEKvd8dTbO7BVNLVOzJvhFrmO
   1AnLiAA2s5pzJF3GeuDODz7N9XVM/+93KdRPazEysuMFTntHwg+oNf65I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="398589853"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="398589853"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 23:23:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1497994"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2024 23:23:24 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSB7y-0007FT-0w;
	Tue, 23 Jan 2024 07:23:22 +0000
Date: Tue, 23 Jan 2024 15:22:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/3] mailbox: imx: get RR/TR registers num from Parameter
 register
Message-ID: <202401231557.HLHet6y7-lkp@intel.com>
References: <20240122-imx-mailbox-v1-2-81413f655210@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-imx-mailbox-v1-2-81413f655210@nxp.com>

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on ad5c60d66016e544c51ed98635a74073f761f45d]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/dt-bindings-mailbox-fsl-mu-add-i-MX95-Generic-ELE-V2X-MU-compatible/20240122-100424
base:   ad5c60d66016e544c51ed98635a74073f761f45d
patch link:    https://lore.kernel.org/r/20240122-imx-mailbox-v1-2-81413f655210%40nxp.com
patch subject: [PATCH 2/3] mailbox: imx: get RR/TR registers num from Parameter register
config: i386-buildonly-randconfig-003-20240123 (https://download.01.org/0day-ci/archive/20240123/202401231557.HLHet6y7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240123/202401231557.HLHet6y7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401231557.HLHet6y7-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mailbox/imx-mailbox.c: In function 'imx_mu_get_tr_rr':
>> drivers/mailbox/imx-mailbox.c:749:32: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     749 |                 priv->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
         |                                ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_GET +749 drivers/mailbox/imx-mailbox.c

   742	
   743	static void imx_mu_get_tr_rr(struct imx_mu_priv *priv)
   744	{
   745		u32 val;
   746	
   747		if (priv->dcfg->type & IMX_MU_V2) {
   748			val = imx_mu_read(priv, IMX_MU_V2_PAR_OFF);
 > 749			priv->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
   750			priv->num_rr = FIELD_GET(IMX_MU_V2_RR_MASK, val);
   751		} else {
   752			priv->num_tr = 4;
   753			priv->num_rr = 4;
   754		}
   755	}
   756	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

