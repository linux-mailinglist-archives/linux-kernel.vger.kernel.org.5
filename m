Return-Path: <linux-kernel+bounces-39454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC3C83D164
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A6F1F254CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9777E2;
	Fri, 26 Jan 2024 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jd9N1OAH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB619D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706228189; cv=none; b=mBOdNc/Zj4AKfVkOHXLw0qJWv69VjPcLZKeqOr1RA8eVZW2hwQmzjxHQtcuNXFyJCH5heQvjo5D2wEX/x++YOL1NiWRBQ/BCxHUKpV70dEsEqKSAocDunNqo4QOkJ1r9AiqSckakULoqD88R3/fwuZPLZQY3ip0GG75qMiChE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706228189; c=relaxed/simple;
	bh=QenIm/O/0t1RHkGK8L/kzIvF3qZtbD1RKxpivllizPs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qxOwtJ+5xwEMQ1yFfkqjMhLjstMiSBzfMw6RbkEutdKpBYWXhXx8OeSMuyypj7m896AW92DnlMgozavpIs3ozOzzWCO8aEht48U+TxNGzMJpuqlHKwZmzujSp1D6Zk1tl99yCBTE2TTH1p9BKI+CkvAbRBVg7yb3zcV/S8og/y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jd9N1OAH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706228187; x=1737764187;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QenIm/O/0t1RHkGK8L/kzIvF3qZtbD1RKxpivllizPs=;
  b=jd9N1OAHgTQiTVkMsKv3j4lKXzY0rAjzxHNPgiCyaCkbpWtYQsXWvPxT
   A5uKHeJTdTfLxuN3yzEFhC4/tiEOe6XQkWfL5sCPIFKHTEZduM0KNjPPo
   4CdPrnIu1OrRMGmj+myrpkSpAEThncfpr9H9XtktrJuKV+eIB+PEM0KJh
   HXCpQ7bbP+MBstv/wHwn7jom/vQJJkfAtou8NXbM8E8NOZNSdaUSW3o0L
   9Gx2+SZjcUG+ARqWRmE0hjUBCZA16k4C8ODl5/zIEeWPy5WB9GliPADo0
   gnDcSJDslgwjFWiWQCfmDgSBkwVbPSCCdrFqc0F8QeTJ0j2sz7aT6oTMp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="8994332"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8994332"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 16:16:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2448537"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Jan 2024 16:16:25 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rT9tO-0000W4-2q;
	Fri, 26 Jan 2024 00:16:22 +0000
Date: Fri, 26 Jan 2024 08:16:07 +0800
From: kernel test robot <lkp@intel.com>
To: Nagarjuna Kristam <nkristam@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>
Subject: drivers/usb/gadget/udc/tegra-xudc.c:3417:60: warning: '%d' directive
 output may be truncated writing between 1 and 10 bytes into a region of size
 2
Message-ID: <202401260821.tiWXcPF2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
commit: b4e19931c98a088fbd80b5c3f892261c9a0e6c23 usb: gadget: tegra-xudc: Support multiple device modes
date:   3 years, 10 months ago
config: arm64-randconfig-002-20240106 (https://download.01.org/0day-ci/archive/20240126/202401260821.tiWXcPF2-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401260821.tiWXcPF2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401260821.tiWXcPF2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/gadget/udc/tegra-xudc.c: In function 'tegra_xudc_phy_get':
>> drivers/usb/gadget/udc/tegra-xudc.c:3417:60: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
    3417 |                 snprintf(phy_name, sizeof(phy_name), "usb3-%d", usb3);
         |                                                            ^~
   drivers/usb/gadget/udc/tegra-xudc.c:3417:54: note: directive argument in the range [0, 2147483647]
    3417 |                 snprintf(phy_name, sizeof(phy_name), "usb3-%d", usb3);
         |                                                      ^~~~~~~~~
   drivers/usb/gadget/udc/tegra-xudc.c:3417:17: note: 'snprintf' output between 7 and 16 bytes into a destination of size 7
    3417 |                 snprintf(phy_name, sizeof(phy_name), "usb3-%d", usb3);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +3417 drivers/usb/gadget/udc/tegra-xudc.c

  3360	
  3361	static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
  3362	{
  3363		int err = 0, usb3;
  3364		unsigned int i;
  3365	
  3366		xudc->utmi_phy = devm_kcalloc(xudc->dev, xudc->soc->num_phys,
  3367						   sizeof(*xudc->utmi_phy), GFP_KERNEL);
  3368		if (!xudc->utmi_phy)
  3369			return -ENOMEM;
  3370	
  3371		xudc->usb3_phy = devm_kcalloc(xudc->dev, xudc->soc->num_phys,
  3372						   sizeof(*xudc->usb3_phy), GFP_KERNEL);
  3373		if (!xudc->usb3_phy)
  3374			return -ENOMEM;
  3375	
  3376		xudc->usbphy = devm_kcalloc(xudc->dev, xudc->soc->num_phys,
  3377						   sizeof(*xudc->usbphy), GFP_KERNEL);
  3378		if (!xudc->usbphy)
  3379			return -ENOMEM;
  3380	
  3381		xudc->vbus_nb.notifier_call = tegra_xudc_vbus_notify;
  3382	
  3383		for (i = 0; i < xudc->soc->num_phys; i++) {
  3384			char phy_name[] = "usb.-.";
  3385	
  3386			/* Get USB2 phy */
  3387			snprintf(phy_name, sizeof(phy_name), "usb2-%d", i);
  3388			xudc->utmi_phy[i] = devm_phy_optional_get(xudc->dev, phy_name);
  3389			if (IS_ERR(xudc->utmi_phy[i])) {
  3390				err = PTR_ERR(xudc->utmi_phy[i]);
  3391				if (err != -EPROBE_DEFER)
  3392					dev_err(xudc->dev, "failed to get usb2-%d phy: %d\n",
  3393						i, err);
  3394	
  3395				goto clean_up;
  3396			} else if (xudc->utmi_phy[i]) {
  3397				/* Get usb-phy, if utmi phy is available */
  3398				xudc->usbphy[i] = devm_usb_get_phy_by_node(xudc->dev,
  3399							xudc->utmi_phy[i]->dev.of_node,
  3400							&xudc->vbus_nb);
  3401				if (IS_ERR(xudc->usbphy[i])) {
  3402					err = PTR_ERR(xudc->usbphy[i]);
  3403					dev_err(xudc->dev, "failed to get usbphy-%d: %d\n",
  3404						i, err);
  3405					goto clean_up;
  3406				}
  3407			} else if (!xudc->utmi_phy[i]) {
  3408				/* if utmi phy is not available, ignore USB3 phy get */
  3409				continue;
  3410			}
  3411	
  3412			/* Get USB3 phy */
  3413			usb3 = tegra_xusb_padctl_get_usb3_companion(xudc->padctl, i);
  3414			if (usb3 < 0)
  3415				continue;
  3416	
> 3417			snprintf(phy_name, sizeof(phy_name), "usb3-%d", usb3);
  3418			xudc->usb3_phy[i] = devm_phy_optional_get(xudc->dev, phy_name);
  3419			if (IS_ERR(xudc->usb3_phy[i])) {
  3420				err = PTR_ERR(xudc->usb3_phy[i]);
  3421				if (err != -EPROBE_DEFER)
  3422					dev_err(xudc->dev, "failed to get usb3-%d phy: %d\n",
  3423						usb3, err);
  3424	
  3425				goto clean_up;
  3426			} else if (xudc->usb3_phy[i])
  3427				dev_dbg(xudc->dev, "usb3_phy-%d registered", usb3);
  3428		}
  3429	
  3430		return err;
  3431	
  3432	clean_up:
  3433		for (i = 0; i < xudc->soc->num_phys; i++) {
  3434			xudc->usb3_phy[i] = NULL;
  3435			xudc->utmi_phy[i] = NULL;
  3436			xudc->usbphy[i] = NULL;
  3437		}
  3438	
  3439		return err;
  3440	}
  3441	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

