Return-Path: <linux-kernel+bounces-69807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 042DD858ECE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD567281C9B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD854F5E6;
	Sat, 17 Feb 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCfLW60F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD64EB4B;
	Sat, 17 Feb 2024 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708166682; cv=none; b=eceiAY5rnw6eTQC3Q4BsWYbxvHBU5R9EzZ0oM+fv8LOMXir6wlQd0urnnSxd5O42Lv31iuo2JdRw+XynrxR5n1PAOzpYpOsd+2iZTwermPYbKRA6fuqHKyh7U/jKvyqTdzSJNzSo/EI6dryHc/HBu4GJp5/kuoYRy+fixyuFcYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708166682; c=relaxed/simple;
	bh=2ifbzFAXWssrFO5luB1vG3zFui4ZRF6yEfmf37hguT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWVUcc/+6kWeMuR4QIF55Qu+s7MuiW6546sR3C9gGjK0gwLOKwTMbFd0FLIxtd2xj4fwF1Ttv6n9W9IEUH9B9Z6rvIEbr2iEGSNYD54kBoAv7uRMJFqiYrSZehizPt8Bnt0MJZsm0wQ+mSfinyeao9ETLdUJbl/SHPB+0ZFHeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCfLW60F; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708166680; x=1739702680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ifbzFAXWssrFO5luB1vG3zFui4ZRF6yEfmf37hguT4=;
  b=gCfLW60F2swbzHP3G6scQ7KchgYEbxYHpO+vY6DDVsAQFffn6+VxX/o7
   1lyPsIi9833q2XyDqvZglmf4fquxb5smCqQI4xliH6CM3GU6kVeSrDlMK
   cjy7Is7KQ0uSTCbkevPLyWEMUuCI3whWvrmQJdt5QUMq8uLuP5dP7Ysre
   Y5UqC8IlE/4XR8j74V95AQhMvyCiYD9ahPPlCVfk7EUMUn9ITHGUfVRem
   iEjQ6Zw0IB4PmD9xmAsfamBEUtVMNxth5ZPr/TjfnfSmMjj+pN+T0mMyS
   LormpwkJd2WM880Y4/i/Ci6HIXr0vnfn2QnAiOzvOBuPu5NeLIstLGD/N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2170737"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="2170737"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 02:44:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="935983314"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="935983314"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2024 02:44:36 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbIBK-00023C-2e;
	Sat, 17 Feb 2024 10:44:32 +0000
Date: Sat, 17 Feb 2024 18:43:36 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	Justin Chen <justin.chen@broadcom.com>
Subject: Re: [PATCH net-next 1/3] net: mdio: mdio-bcm-unimac: Manage clock
 around I/O accesses
Message-ID: <202402171801.J560K7Fo-lkp@intel.com>
References: <20240216184237.259954-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216184237.259954-2-florian.fainelli@broadcom.com>

Hi Florian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Fainelli/net-mdio-mdio-bcm-unimac-Manage-clock-around-I-O-accesses/20240217-024738
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240216184237.259954-2-florian.fainelli%40broadcom.com
patch subject: [PATCH net-next 1/3] net: mdio: mdio-bcm-unimac: Manage clock around I/O accesses
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240217/202402171801.J560K7Fo-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240217/202402171801.J560K7Fo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402171801.J560K7Fo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/mdio/mdio-bcm-unimac.c:286:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (IS_ERR(priv->clk))
               ^~~~~~~~~~~~~~~~~
   drivers/net/mdio/mdio-bcm-unimac.c:313:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/net/mdio/mdio-bcm-unimac.c:286:2: note: remove the 'if' if its condition is always false
           if (IS_ERR(priv->clk))
           ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/mdio/mdio-bcm-unimac.c:243:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +286 drivers/net/mdio/mdio-bcm-unimac.c

   235	
   236	static int unimac_mdio_probe(struct platform_device *pdev)
   237	{
   238		struct unimac_mdio_pdata *pdata = pdev->dev.platform_data;
   239		struct unimac_mdio_priv *priv;
   240		struct device_node *np;
   241		struct mii_bus *bus;
   242		struct resource *r;
   243		int ret;
   244	
   245		np = pdev->dev.of_node;
   246	
   247		priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
   248		if (!priv)
   249			return -ENOMEM;
   250	
   251		r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   252		if (!r)
   253			return -EINVAL;
   254	
   255		/* Just ioremap, as this MDIO block is usually integrated into an
   256		 * Ethernet MAC controller register range
   257		 */
   258		priv->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
   259		if (!priv->base) {
   260			dev_err(&pdev->dev, "failed to remap register\n");
   261			return -ENOMEM;
   262		}
   263	
   264		if (of_property_read_u32(np, "clock-frequency", &priv->clk_freq))
   265			priv->clk_freq = 0;
   266	
   267		priv->mii_bus = mdiobus_alloc();
   268		if (!priv->mii_bus)
   269			return -ENOMEM;
   270	
   271		bus = priv->mii_bus;
   272		bus->priv = priv;
   273		if (pdata) {
   274			bus->name = pdata->bus_name;
   275			priv->wait_func = pdata->wait_func;
   276			priv->wait_func_data = pdata->wait_func_data;
   277			bus->phy_mask = ~pdata->phy_mask;
   278			priv->clk = pdata->clk;
   279		} else {
   280			bus->name = "unimac MII bus";
   281			priv->wait_func_data = priv;
   282			priv->wait_func = unimac_mdio_poll;
   283			priv->clk = devm_clk_get_optional(&pdev->dev, NULL);
   284		}
   285	
 > 286		if (IS_ERR(priv->clk))
   287			goto out_mdio_free;
   288	
   289		bus->parent = &pdev->dev;
   290		bus->read = unimac_mdio_read;
   291		bus->write = unimac_mdio_write;
   292		bus->reset = unimac_mdio_reset;
   293		snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", pdev->name, pdev->id);
   294	
   295		ret = unimac_mdio_clk_set(priv);
   296		if (ret)
   297			goto out_mdio_free;
   298	
   299		ret = of_mdiobus_register(bus, np);
   300		if (ret) {
   301			dev_err(&pdev->dev, "MDIO bus registration failed\n");
   302			goto out_mdio_free;
   303		}
   304	
   305		platform_set_drvdata(pdev, priv);
   306	
   307		dev_info(&pdev->dev, "Broadcom UniMAC MDIO bus\n");
   308	
   309		return 0;
   310	
   311	out_mdio_free:
   312		mdiobus_free(bus);
   313		return ret;
   314	}
   315	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

