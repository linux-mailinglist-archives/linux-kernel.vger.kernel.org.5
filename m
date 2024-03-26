Return-Path: <linux-kernel+bounces-119299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2B588C6CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638E71F669D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37BA13C833;
	Tue, 26 Mar 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YH6BBhTu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEFF757FD;
	Tue, 26 Mar 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466696; cv=none; b=GSY3KRlKIr3WQbcOQ89NdMccMDHxP4mtiKeyhwyULdEAwL4Uhot3DORTGx6NonZEpBemgqciwRsN+Qcj45BW9/zTH88x5om74ooEV0P9T7utYsESecQamV/btM9R+QMLMyRavtNzE08RjFNMSXE41Owp2hWeStEP/Kqj12SVzCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466696; c=relaxed/simple;
	bh=JbVGiQctH8YUzKhNcuqujXYFY6AMJBDKBDS3AVIYNOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAZuaXWhAmzLmw2ENLyrdnO6B/lP/YRknZZBKuSq91BQ3ZZUURh/9K8EH52vUqVHILEcUphdXEcYGKEQuO+S79vP9GRHt56gJUiZu+2WHY1lneYhD2TstT+QGF0du3Om09uCGHxSmzsPDtAlVhpXNlBYjp9LRv8XI+3xJTAWVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YH6BBhTu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711466694; x=1743002694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JbVGiQctH8YUzKhNcuqujXYFY6AMJBDKBDS3AVIYNOc=;
  b=YH6BBhTuTAFoQFxVc39vDBav/Qc9VC9xBCbSue4gjq2TPd27WDfExunk
   H4P0UNVxmZIW/k3kNo/BhK2kTxuAPC5TimiSa1FORROcBxSx96vnDjyIb
   Lbzizxw9Z9xZnJSflTd/3i5nF6e5myE6rdmvKLuQvZAI8zmPnDDeoaX9i
   dMFs2S4erce9NZwRDWscVHf7tsRf2dga3i/2qKtQpYJQlBV87+jWtc8F1
   iVRWfJe2tuXWVF3EVH+IGnqeX6CsK1HyfkWhH3YbgRjSSUi48M+k/l5tk
   IhA2OsKQc+pQNUmKz018qB12SAYuR/wWa3uHTf5hGZBcpIMtKay2riSeb
   g==;
X-CSE-ConnectionGUID: KfmmXiHNTVWSnnjourmuNw==
X-CSE-MsgGUID: u5xw7PIdRdKmG5zsdnOnhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6640575"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6640575"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20694107"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 26 Mar 2024 08:24:50 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rp8fP-00008y-1X;
	Tue, 26 Mar 2024 15:24:47 +0000
Date: Tue, 26 Mar 2024 23:24:28 +0800
From: kernel test robot <lkp@intel.com>
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	thomas.lendacky@amd.com, dan.j.williams@intel.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, graf@amazon.de, dwmw@amazon.co.uk,
	bchalios@amazon.es, xmarcalx@amazon.co.uk
Subject: Re: [PATCH v3 4/4] virt: vmgenid: add support for devicetree bindings
Message-ID: <202403262327.ZwiqykRF-lkp@intel.com>
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
config: x86_64-randconfig-161-20240326 (https://download.01.org/0day-ci/archive/20240326/202403262327.ZwiqykRF-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240326/202403262327.ZwiqykRF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403262327.ZwiqykRF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/virt/vmgenid.c:154:8: error: use of undeclared identifier 'dev'
     154 |         (void)dev;
         |               ^
   1 error generated.


vim +/dev +154 drivers/virt/vmgenid.c

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

