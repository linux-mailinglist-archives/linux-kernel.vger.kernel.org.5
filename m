Return-Path: <linux-kernel+bounces-54628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5D284B1BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311A51F24B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCF312D777;
	Tue,  6 Feb 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExekihOX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426C12D76A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213543; cv=none; b=HoFikEeWalR/zNJD+Jhnbpc1vjdKEDYWLLVVu8vwRKWM83OLdag203Ee6KcblAKBUf54T66PXdyqystHSiBJY3LYzlJCjsxBwT6ci0Hj0wvUlbQ5XUmt8FwWDhm+1KRT4/Oj4dtGfYO+ycEzq2uUaFmO7VN6X4Mp2jMabNiKSVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213543; c=relaxed/simple;
	bh=3NDFAJucASIsh5QzYnkIWuo5iU/VftF+EdgQ++/3YWU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fAfk4n1k5wvYlxrH999mG1X76fJq4uVVlyuKQ7wBiALZLgoHJSBNqA5ruyxhI9/zt2MjTqddkg+xqFhWCLxUjLIWtmunqK846LPuWKt+V9hnZgc7aRrbbgwiS4HaJKB5zleQpADzT/OD8XkUuoYqMNifqRErrAiuu7bbHCjDZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExekihOX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707213538; x=1738749538;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3NDFAJucASIsh5QzYnkIWuo5iU/VftF+EdgQ++/3YWU=;
  b=ExekihOXC+dsmrxIhMvCxGXqFWtWykvJuUHQ5yGcV9wqjq0vXXhB+zHm
   VSFOMdqCafToqRgU2zsd4e+K8mjTnNxGH111G4NnnqYKJA06NZunlKB0P
   /VFhnvqb50iUB06fbrRt7EWB8AcZuDF3Ktdejl4ihaZbinV/OmEAzoLgb
   zGY3z/tXrBXs+8hL7Jqu4+L3BR/d0951lH3ANcC3dT0pWszeJXqqbrNcd
   Sz4sYSj53yPXnxUY8CDIkcaAaLx8+nupJatqgkVdBQrObaT1kX8xeW+si
   wepZtqCwzIW+oZfakVBhutSs3rO9TZLKJE9ik8gEHEoRA2umSLaCObNfa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="600398"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="600398"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 01:58:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="32043640"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 06 Feb 2024 01:58:57 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXIEB-0001Fs-2U;
	Tue, 06 Feb 2024 09:58:55 +0000
Date: Tue, 6 Feb 2024 17:58:15 +0800
From: kernel test robot <lkp@intel.com>
To: Balsam CHIHI <bchihi@baylibre.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: drivers/thermal/mediatek/lvts_thermal.c:520:2-3: Unneeded semicolon
Message-ID: <202402061757.2OeFfaWP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
commit: f5f633b18234cecb0e6ee6e5fbb358807dda15c3 thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver
date:   12 months ago
config: sparc64-randconfig-r064-20240206 (https://download.01.org/0day-ci/archive/20240206/202402061757.2OeFfaWP-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402061757.2OeFfaWP-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/thermal/mediatek/lvts_thermal.c:520:2-3: Unneeded semicolon

vim +520 drivers/thermal/mediatek/lvts_thermal.c

   464	
   465	static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
   466						const struct lvts_ctrl_data *lvts_ctrl_data)
   467	{
   468		struct lvts_sensor *lvts_sensor = lvts_ctrl->sensors;
   469		void __iomem *msr_regs[] = {
   470			LVTS_MSR0(lvts_ctrl->base),
   471			LVTS_MSR1(lvts_ctrl->base),
   472			LVTS_MSR2(lvts_ctrl->base),
   473			LVTS_MSR3(lvts_ctrl->base)
   474		};
   475	
   476		void __iomem *imm_regs[] = {
   477			LVTS_IMMD0(lvts_ctrl->base),
   478			LVTS_IMMD1(lvts_ctrl->base),
   479			LVTS_IMMD2(lvts_ctrl->base),
   480			LVTS_IMMD3(lvts_ctrl->base)
   481		};
   482	
   483		int i;
   484	
   485		for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++) {
   486	
   487			int dt_id = lvts_ctrl_data->lvts_sensor[i].dt_id;
   488	
   489			/*
   490			 * At this point, we don't know which id matches which
   491			 * sensor. Let's set arbitrally the id from the index.
   492			 */
   493			lvts_sensor[i].id = i;
   494	
   495			/*
   496			 * The thermal zone registration will set the trip
   497			 * point interrupt in the thermal controller
   498			 * register. But this one will be reset in the
   499			 * initialization after. So we need to post pone the
   500			 * thermal zone creation after the controller is
   501			 * setup. For this reason, we store the device tree
   502			 * node id from the data in the sensor structure
   503			 */
   504			lvts_sensor[i].dt_id = dt_id;
   505	
   506			/*
   507			 * We assign the base address of the thermal
   508			 * controller as a back pointer. So it will be
   509			 * accessible from the different thermal framework ops
   510			 * as we pass the lvts_sensor pointer as thermal zone
   511			 * private data.
   512			 */
   513			lvts_sensor[i].base = lvts_ctrl->base;
   514	
   515			/*
   516			 * Each sensor has its own register address to read from.
   517			 */
   518			lvts_sensor[i].msr = lvts_ctrl_data->mode == LVTS_MSR_IMMEDIATE_MODE ?
   519				imm_regs[i] : msr_regs[i];
 > 520		};
   521	
   522		lvts_ctrl->num_lvts_sensor = lvts_ctrl_data->num_lvts_sensor;
   523	
   524		return 0;
   525	}
   526	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

