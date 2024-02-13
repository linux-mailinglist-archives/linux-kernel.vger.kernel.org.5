Return-Path: <linux-kernel+bounces-62855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F518526E2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6AC1F2295C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559D54416;
	Tue, 13 Feb 2024 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPVOI1ef"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE97E1;
	Tue, 13 Feb 2024 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786854; cv=none; b=OOlJ3sKemu7dc/mM7Z/KWjFKDQ6IkHp/jYnP+IZEA3FqIT9iiDA/rpWZhGZDILKDHSRpn0WyBfx41bJ+MwTo/a3fy2ZyDPvKBlTosPQhui9AQDpD2XaRiIlbq4N93gS8kq6L2AsbpeM+nIZjWraA1VlayriZtVm5xKnH/VRpCKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786854; c=relaxed/simple;
	bh=rdCSghG/HzbYPNukcgME/dtz2hjSD517GZeuam0NzRI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SOQ3NPhDl/H7F80edmqZvFf2LjuUMowvHDZOLPHI9Kh+FWt+ezdJseJZdTg+MfVLXjkqZhlkCVYuVL8vCDLXJPpxVzrMgd35XxhTDG737BWxa4n5U4b8T4vmxQXh7GsEgAVXN5DKghH4ru/oSwxxmQ3rPM+btBOWvf8KX/J9xvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPVOI1ef; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707786852; x=1739322852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rdCSghG/HzbYPNukcgME/dtz2hjSD517GZeuam0NzRI=;
  b=TPVOI1efEPQJ492CuXpaM/gEV/ed2Ysee4Tb0Lz04AgyhH2P+9CNpz05
   SAa0rjPEOl2oONnqLVAqE+W26pvvU243AJpKZnISp76CxsoiFVMbZMYeW
   5IG5/CEqQxNV9eOg2P5a2cidtyGEh0esBXU3NOs9sDn70u+ye93iQFdXc
   WjzgaeGEzD7sWqOfsRcUkZkWzgJdsoEDJQ1VqtwvaLuDCw0ulM1AHAFr3
   yn4+yWS2kRhC258koyQcpYGCOERvsmB2Cp1AjvOPAMPUazQ0R5fwWgH7l
   8Y8FPDmbeQ71082SZJVyANrOQ33S8S4npDCjMZt8xGd+ckiEPy8H21SFz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27230187"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="27230187"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 17:14:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="825971966"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="825971966"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2024 17:14:08 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZhN8-0007R8-0X;
	Tue, 13 Feb 2024 01:14:06 +0000
Date: Tue, 13 Feb 2024 09:13:43 +0800
From: kernel test robot <lkp@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/media/platform/marvell/cafe-driver.c:543: undefined
 reference to `v4l2_async_nf_init'
Message-ID: <202402130955.f6uxzdCA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c664e16bb1ba1c8cf1d7ecf3df5fd83bbb8ac15a
commit: 7d3c7d2a2914e10bec3b9cdacdadb8e1f65f715a media: i2c: Add a camera sensor top level menu
date:   6 months ago
config: i386-randconfig-r011-20211227 (https://download.01.org/0day-ci/archive/20240213/202402130955.f6uxzdCA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240213/202402130955.f6uxzdCA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402130955.f6uxzdCA-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/media/i2c/ov7670.o: in function `ov7670_remove':
   drivers/media/i2c/ov7670.c:2011: undefined reference to `v4l2_async_unregister_subdev'
   ld: drivers/media/i2c/ov7670.o: in function `ov7670_parse_dt':
   drivers/media/i2c/ov7670.c:1836: undefined reference to `v4l2_fwnode_endpoint_parse'
   ld: drivers/media/i2c/ov7670.o: in function `ov7670_probe':
   drivers/media/i2c/ov7670.c:1990: undefined reference to `v4l2_async_register_subdev'
   ld: drivers/media/platform/marvell/cafe-driver.o: in function `cafe_pci_probe':
>> drivers/media/platform/marvell/cafe-driver.c:543: undefined reference to `v4l2_async_nf_init'
>> ld: drivers/media/platform/marvell/cafe-driver.c:545: undefined reference to `__v4l2_async_nf_add_i2c'
   ld: drivers/media/platform/marvell/mcam-core.o: in function `mccic_shutdown':
>> drivers/media/platform/marvell/mcam-core.c:1931: undefined reference to `v4l2_async_nf_unregister'
>> ld: drivers/media/platform/marvell/mcam-core.c:1932: undefined reference to `v4l2_async_nf_cleanup'
   ld: drivers/media/platform/marvell/mcam-core.o: in function `mccic_register':
   drivers/media/platform/marvell/mcam-core.c:1910: undefined reference to `v4l2_async_nf_unregister'
   ld: drivers/media/platform/marvell/mcam-core.c:1911: undefined reference to `v4l2_async_nf_cleanup'
>> ld: drivers/media/platform/marvell/mcam-core.c:1873: undefined reference to `v4l2_async_nf_register'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for VIDEO_OV7670
   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_CAMERA_SENSOR [=n] && I2C [=y] && VIDEO_DEV [=y]
   Selected by [y]:
   - VIDEO_CAFE_CCIC [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && PCI [=y] && I2C [=y] && VIDEO_DEV [=y] && COMMON_CLK [=y]


vim +543 drivers/media/platform/marvell/cafe-driver.c

abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  469  
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  470  /* -------------------------------------------------------------------------- */
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  471  /*
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  472   * PCI interface stuff.
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  473   */
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  474  
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  475  static int cafe_pci_probe(struct pci_dev *pdev,
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  476  		const struct pci_device_id *id)
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  477  {
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  478  	int ret;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  479  	struct cafe_camera *cam;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  480  	struct mcam_camera *mcam;
adb2dcd5f2d49d drivers/media/platform/marvell/cafe-driver.c      Sakari Ailus    2023-02-16  481  	struct v4l2_async_connection *asd;
2b889a4afcacef drivers/media/platform/marvell-ccic/cafe-driver.c Evgeny Novikov  2021-05-26  482  	struct i2c_client *i2c_dev;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  483  
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  484  	/*
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  485  	 * Start putting together one of our big camera structures.
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  486  	 */
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  487  	ret = -ENOMEM;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  488  	cam = kzalloc(sizeof(struct cafe_camera), GFP_KERNEL);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  489  	if (cam == NULL)
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  490  		goto out;
953e41153a1662 drivers/media/platform/marvell-ccic/cafe-driver.c Lubomir Rintel  2020-08-18  491  	pci_set_drvdata(pdev, cam);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  492  	cam->pdev = pdev;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  493  	mcam = &cam->mcam;
7486af1ae3ee34 drivers/media/platform/marvell-ccic/cafe-driver.c Hans Verkuil    2013-05-29  494  	mcam->chip_id = MCAM_CAFE;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  495  	spin_lock_init(&mcam->dev_lock);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  496  	init_waitqueue_head(&cam->smbus_wait);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  497  	mcam->plat_power_up = cafe_ctlr_power_up;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  498  	mcam->plat_power_down = cafe_ctlr_power_down;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  499  	mcam->dev = &pdev->dev;
a9b36e850782db drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-20  500  	/*
a9b36e850782db drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-20  501  	 * Vmalloc mode for buffers is traditional with this driver.
a9b36e850782db drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-20  502  	 * We *might* be able to run DMA_contig, especially on a system
a9b36e850782db drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-20  503  	 * with CMA in it.
a9b36e850782db drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-20  504  	 */
a9b36e850782db drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-20  505  	mcam->buffer_mode = B_vmalloc;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  506  	/*
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  507  	 * Get set up on the PCI bus.
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  508  	 */
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  509  	ret = pci_enable_device(pdev);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  510  	if (ret)
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  511  		goto out_free;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  512  	pci_set_master(pdev);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  513  
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  514  	ret = -EIO;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  515  	mcam->regs = pci_iomap(pdev, 0, 0);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  516  	if (!mcam->regs) {
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  517  		printk(KERN_ERR "Unable to ioremap cafe-ccic regs\n");
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  518  		goto out_disable;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  519  	}
4e032f3f58800a drivers/media/platform/marvell-ccic/cafe-driver.c Hans Verkuil    2013-05-29  520  	mcam->regs_size = pci_resource_len(pdev, 0);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  521  	ret = request_irq(pdev->irq, cafe_irq, IRQF_SHARED, "cafe-ccic", cam);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  522  	if (ret)
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  523  		goto out_iounmap;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  524  
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  525  	/*
81a409bfd5517d drivers/media/platform/marvell-ccic/cafe-driver.c Lubomir Rintel  2019-05-28  526  	 * Initialize the controller.
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  527  	 */
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  528  	cafe_ctlr_init(mcam);
81a409bfd5517d drivers/media/platform/marvell-ccic/cafe-driver.c Lubomir Rintel  2019-05-28  529  
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  530  	/*
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  531  	 * Set up I2C/SMBUS communications.  We have to drop the mutex here
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  532  	 * because the sensor could attach in this call chain, leading to
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  533  	 * unsightly deadlocks.
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  534  	 */
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  535  	ret = cafe_smbus_setup(cam);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  536  	if (ret)
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  537  		goto out_pdown;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  538  
4af65141e38ea5 drivers/media/platform/marvell/cafe-driver.c      Sakari Ailus    2023-03-29  539  	ret = v4l2_device_register(mcam->dev, &mcam->v4l2_dev);
4af65141e38ea5 drivers/media/platform/marvell/cafe-driver.c      Sakari Ailus    2023-03-29  540  	if (ret)
4af65141e38ea5 drivers/media/platform/marvell/cafe-driver.c      Sakari Ailus    2023-03-29  541  		goto out_smbus_shutdown;
4af65141e38ea5 drivers/media/platform/marvell/cafe-driver.c      Sakari Ailus    2023-03-29  542  
b8ec754ae4c563 drivers/media/platform/marvell/cafe-driver.c      Sakari Ailus    2023-02-23 @543  	v4l2_async_nf_init(&mcam->notifier, &mcam->v4l2_dev);
50fe0de0fedbc2 drivers/media/platform/marvell-ccic/cafe-driver.c Ezequiel Garcia 2021-01-18  544  
3c8c153914812a drivers/media/platform/marvell-ccic/cafe-driver.c Sakari Ailus    2021-03-05 @545  	asd = v4l2_async_nf_add_i2c(&mcam->notifier,
50fe0de0fedbc2 drivers/media/platform/marvell-ccic/cafe-driver.c Ezequiel Garcia 2021-01-18  546  				    i2c_adapter_id(cam->i2c_adapter),
adb2dcd5f2d49d drivers/media/platform/marvell/cafe-driver.c      Sakari Ailus    2023-02-16  547  				    ov7670_info.addr,
adb2dcd5f2d49d drivers/media/platform/marvell/cafe-driver.c      Sakari Ailus    2023-02-16  548  				    struct v4l2_async_connection);
50fe0de0fedbc2 drivers/media/platform/marvell-ccic/cafe-driver.c Ezequiel Garcia 2021-01-18  549  	if (IS_ERR(asd)) {
50fe0de0fedbc2 drivers/media/platform/marvell-ccic/cafe-driver.c Ezequiel Garcia 2021-01-18  550  		ret = PTR_ERR(asd);
4af65141e38ea5 drivers/media/platform/marvell/cafe-driver.c      Sakari Ailus    2023-03-29  551  		goto out_v4l2_device_unregister;
50fe0de0fedbc2 drivers/media/platform/marvell-ccic/cafe-driver.c Ezequiel Garcia 2021-01-18  552  	}
3eefe36cc00c53 drivers/media/platform/marvell-ccic/cafe-driver.c Lubomir Rintel  2019-05-28  553  
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  554  	ret = mccic_register(mcam);
3eefe36cc00c53 drivers/media/platform/marvell-ccic/cafe-driver.c Lubomir Rintel  2019-05-28  555  	if (ret)
4af65141e38ea5 drivers/media/platform/marvell/cafe-driver.c      Sakari Ailus    2023-03-29  556  		goto out_v4l2_device_unregister;
3eefe36cc00c53 drivers/media/platform/marvell-ccic/cafe-driver.c Lubomir Rintel  2019-05-28  557  
81a409bfd5517d drivers/media/platform/marvell-ccic/cafe-driver.c Lubomir Rintel  2019-05-28  558  	clkdev_create(mcam->mclk, "xclk", "%d-%04x",
81a409bfd5517d drivers/media/platform/marvell-ccic/cafe-driver.c Lubomir Rintel  2019-05-28  559  		i2c_adapter_id(cam->i2c_adapter), ov7670_info.addr);
81a409bfd5517d drivers/media/platform/marvell-ccic/cafe-driver.c Lubomir Rintel  2019-05-28  560  
2b889a4afcacef drivers/media/platform/marvell-ccic/cafe-driver.c Evgeny Novikov  2021-05-26  561  	i2c_dev = i2c_new_client_device(cam->i2c_adapter, &ov7670_info);
2b889a4afcacef drivers/media/platform/marvell-ccic/cafe-driver.c Evgeny Novikov  2021-05-26  562  	if (IS_ERR(i2c_dev)) {
2b889a4afcacef drivers/media/platform/marvell-ccic/cafe-driver.c Evgeny Novikov  2021-05-26  563  		ret = PTR_ERR(i2c_dev);
2b889a4afcacef drivers/media/platform/marvell-ccic/cafe-driver.c Evgeny Novikov  2021-05-26  564  		goto out_mccic_shutdown;
2b889a4afcacef drivers/media/platform/marvell-ccic/cafe-driver.c Evgeny Novikov  2021-05-26  565  	}
2b889a4afcacef drivers/media/platform/marvell-ccic/cafe-driver.c Evgeny Novikov  2021-05-26  566  
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  567  	cam->registered = 1;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  568  	return 0;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  569  
2b889a4afcacef drivers/media/platform/marvell-ccic/cafe-driver.c Evgeny Novikov  2021-05-26  570  out_mccic_shutdown:
3eefe36cc00c53 drivers/media/platform/marvell-ccic/cafe-driver.c Lubomir Rintel  2019-05-28  571  	mccic_shutdown(mcam);
4af65141e38ea5 drivers/media/platform/marvell/cafe-driver.c      Sakari Ailus    2023-03-29  572  out_v4l2_device_unregister:
4af65141e38ea5 drivers/media/platform/marvell/cafe-driver.c      Sakari Ailus    2023-03-29  573  	v4l2_device_unregister(&mcam->v4l2_dev);
3eefe36cc00c53 drivers/media/platform/marvell-ccic/cafe-driver.c Lubomir Rintel  2019-05-28  574  out_smbus_shutdown:
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  575  	cafe_smbus_shutdown(cam);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  576  out_pdown:
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  577  	cafe_ctlr_power_down(mcam);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  578  	free_irq(pdev->irq, cam);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  579  out_iounmap:
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  580  	pci_iounmap(pdev, mcam->regs);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  581  out_disable:
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  582  	pci_disable_device(pdev);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  583  out_free:
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  584  	kfree(cam);
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  585  out:
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  586  	return ret;
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  587  }
abfa3df36c01a3 drivers/media/video/marvell-ccic/cafe-driver.c    Jonathan Corbet 2011-06-11  588  

:::::: The code at line 543 was first introduced by commit
:::::: b8ec754ae4c563f6aab8c0cb47aeb2eae67f1da3 media: v4l: async: Set v4l2_device and subdev in async notifier init

:::::: TO: Sakari Ailus <sakari.ailus@linux.intel.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

