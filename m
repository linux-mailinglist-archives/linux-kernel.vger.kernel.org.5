Return-Path: <linux-kernel+bounces-97482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1788876AE4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EA01F222A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995CC364A8;
	Fri,  8 Mar 2024 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/zRRvIX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0A26AC5;
	Fri,  8 Mar 2024 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923503; cv=none; b=Xy+8A7UOwiWMs9nr0YeroqfRPyWy4plldZxYaGxsBNSxd0WlsT5nBlSxu5Dv37oPHRse6+RZWN02mSgeGH0vx8TbxhppSMxvoaHWZVzFYq6vxpmrJswTFYKIjI8wTJXB2akdu04cj8dYNgjFPUxZQ5UNu1P15PqjiNUUFxCyj/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923503; c=relaxed/simple;
	bh=vzgD06Xgx7tkwYg7uImpMWE/Mimggluy8X3vVv0bFcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca4qLqOIyQz/Lxinaed+BCFTAOP75e1HJs76eZXXCXvR78MngwBq8cISpE51kj12rmoGJWaZxfJn37RalrSBc0N9tm3d6F34Vey/pIvNGtrkRLuqJxLdW5ES3u8YgzR8nE0m6O2zw9mSoHle3X+npO+/XhOGgnAbetqmkdoeiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/zRRvIX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709923502; x=1741459502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vzgD06Xgx7tkwYg7uImpMWE/Mimggluy8X3vVv0bFcA=;
  b=i/zRRvIXljlrKoy03X3uY4bgg5esD9VlDpz+NDUAkPl0Fvtq8e5+vEFF
   yQFSXBrmSNAzrGwge7ciRLO53/T4XgBNtTF20B509dS71Yysnfm2lNAHu
   cnGUvWhgW1STjR1Y5Rq3hJr+A1r5GDugnfa9VPi5VGaK19ZvU0H6KY2UY
   vtTFrduHSjsL8hLFQTQv8aEMi6SEW0q0ix7P7Em1Nb5vm/kaxQfXNk5jj
   GT0ETHhLPc7R9VNar99HJ8Ou5kLMSDeIY0gAhuCnFy9pzYHYG++YnNl/8
   v85otOr4dZgS1rht5xzfUJYkDb+mJ49yet2Tsm12rJSrsV6WxFxFNTPsD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="27129884"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="27129884"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 10:45:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="10637531"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Mar 2024 10:44:59 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rifDE-0006cJ-2t;
	Fri, 08 Mar 2024 18:44:56 +0000
Date: Sat, 9 Mar 2024 02:44:20 +0800
From: kernel test robot <lkp@intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: Re: [PATCH 1/5] media: imx335: Support 2 or 4 lane operation modes
Message-ID: <202403090232.FqnIE4cy-lkp@intel.com>
References: <20240306081038.212412-2-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306081038.212412-2-umang.jain@ideasonboard.com>

Hi Umang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linuxtv-media-stage/master]
[cannot apply to media-tree/master sailus-media-tree/streams linus/master v6.8-rc7 next-20240308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Umang-Jain/media-imx335-Support-2-or-4-lane-operation-modes/20240306-161903
base:   https://git.linuxtv.org/media_stage.git master
patch link:    https://lore.kernel.org/r/20240306081038.212412-2-umang.jain%40ideasonboard.com
patch subject: [PATCH 1/5] media: imx335: Support 2 or 4 lane operation modes
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20240309/202403090232.FqnIE4cy-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240309/202403090232.FqnIE4cy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403090232.FqnIE4cy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/imx335.c:181: warning: Function parameter or struct member 'lane_mode' not described in 'imx335'


vim +181 drivers/media/i2c/imx335.c

45d19b5fb9aeab Martina Krasteva 2021-05-27  133  
45d19b5fb9aeab Martina Krasteva 2021-05-27  134  /**
45d19b5fb9aeab Martina Krasteva 2021-05-27  135   * struct imx335 - imx335 sensor device structure
45d19b5fb9aeab Martina Krasteva 2021-05-27  136   * @dev: Pointer to generic device
45d19b5fb9aeab Martina Krasteva 2021-05-27  137   * @client: Pointer to i2c client
45d19b5fb9aeab Martina Krasteva 2021-05-27  138   * @sd: V4L2 sub-device
45d19b5fb9aeab Martina Krasteva 2021-05-27  139   * @pad: Media pad. Only one pad supported
45d19b5fb9aeab Martina Krasteva 2021-05-27  140   * @reset_gpio: Sensor reset gpio
fea91ee73b7cd1 Kieran Bingham   2023-12-11  141   * @supplies: Regulator supplies to handle power control
45d19b5fb9aeab Martina Krasteva 2021-05-27  142   * @inclk: Sensor input clock
45d19b5fb9aeab Martina Krasteva 2021-05-27  143   * @ctrl_handler: V4L2 control handler
45d19b5fb9aeab Martina Krasteva 2021-05-27  144   * @link_freq_ctrl: Pointer to link frequency control
45d19b5fb9aeab Martina Krasteva 2021-05-27  145   * @pclk_ctrl: Pointer to pixel clock control
45d19b5fb9aeab Martina Krasteva 2021-05-27  146   * @hblank_ctrl: Pointer to horizontal blanking control
45d19b5fb9aeab Martina Krasteva 2021-05-27  147   * @vblank_ctrl: Pointer to vertical blanking control
45d19b5fb9aeab Martina Krasteva 2021-05-27  148   * @exp_ctrl: Pointer to exposure control
45d19b5fb9aeab Martina Krasteva 2021-05-27  149   * @again_ctrl: Pointer to analog gain control
45d19b5fb9aeab Martina Krasteva 2021-05-27  150   * @vblank: Vertical blanking in lines
8c48b2175e7d73 Kieran Bingham   2024-03-06  151   * @lane_mode Mode for number of connected data lanes
45d19b5fb9aeab Martina Krasteva 2021-05-27  152   * @cur_mode: Pointer to current selected sensor mode
45d19b5fb9aeab Martina Krasteva 2021-05-27  153   * @mutex: Mutex for serializing sensor controls
0862582b5239a6 Umang Jain       2024-02-20  154   * @link_freq_bitmap: Menu bitmap for link_freq_ctrl
cfa49ff0558a32 Umang Jain       2023-12-11  155   * @cur_mbus_code: Currently selected media bus format code
45d19b5fb9aeab Martina Krasteva 2021-05-27  156   */
45d19b5fb9aeab Martina Krasteva 2021-05-27  157  struct imx335 {
45d19b5fb9aeab Martina Krasteva 2021-05-27  158  	struct device *dev;
45d19b5fb9aeab Martina Krasteva 2021-05-27  159  	struct i2c_client *client;
45d19b5fb9aeab Martina Krasteva 2021-05-27  160  	struct v4l2_subdev sd;
45d19b5fb9aeab Martina Krasteva 2021-05-27  161  	struct media_pad pad;
45d19b5fb9aeab Martina Krasteva 2021-05-27  162  	struct gpio_desc *reset_gpio;
fea91ee73b7cd1 Kieran Bingham   2023-12-11  163  	struct regulator_bulk_data supplies[ARRAY_SIZE(imx335_supply_name)];
fea91ee73b7cd1 Kieran Bingham   2023-12-11  164  
45d19b5fb9aeab Martina Krasteva 2021-05-27  165  	struct clk *inclk;
45d19b5fb9aeab Martina Krasteva 2021-05-27  166  	struct v4l2_ctrl_handler ctrl_handler;
45d19b5fb9aeab Martina Krasteva 2021-05-27  167  	struct v4l2_ctrl *link_freq_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  168  	struct v4l2_ctrl *pclk_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  169  	struct v4l2_ctrl *hblank_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  170  	struct v4l2_ctrl *vblank_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  171  	struct {
45d19b5fb9aeab Martina Krasteva 2021-05-27  172  		struct v4l2_ctrl *exp_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  173  		struct v4l2_ctrl *again_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  174  	};
45d19b5fb9aeab Martina Krasteva 2021-05-27  175  	u32 vblank;
8c48b2175e7d73 Kieran Bingham   2024-03-06  176  	u32 lane_mode;
45d19b5fb9aeab Martina Krasteva 2021-05-27  177  	const struct imx335_mode *cur_mode;
45d19b5fb9aeab Martina Krasteva 2021-05-27  178  	struct mutex mutex;
0862582b5239a6 Umang Jain       2024-02-20  179  	unsigned long link_freq_bitmap;
cfa49ff0558a32 Umang Jain       2023-12-11  180  	u32 cur_mbus_code;
45d19b5fb9aeab Martina Krasteva 2021-05-27 @181  };
45d19b5fb9aeab Martina Krasteva 2021-05-27  182  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

