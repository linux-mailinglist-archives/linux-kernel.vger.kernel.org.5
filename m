Return-Path: <linux-kernel+bounces-97656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7890876D31
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB452819E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0803F36AF6;
	Fri,  8 Mar 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ke8rkAi0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634F1DA52;
	Fri,  8 Mar 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937428; cv=none; b=X1Be5WJnL9WwojtyRw2kzydKuBPeSy+ZlR82/HY7mIx0TC9DAhWy3tLqiCEB/n0sZt8iV0AOxlC2W1fXJheNGR6C2zlRXXrkONVz7AUNwEYmlY4m6yp5VVvmXkvh4BM5itWlZ84a9uH6gGN0D5s/GgF/4w/AbqEUkzQ+NwUBhyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937428; c=relaxed/simple;
	bh=kAujv+mSg6pk0dDrfNeMRZarJKfwCx1NNukVNU+N4Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGzdol4ZpY9Yt5Of8oiyCuXIJuuKhBWckL1Ko9b7Zzu7jA18nI1x59lKdWp/5/OVfKZuIfLjWM2HDW9tv5Zm71PQkvs0Bjzt4UqqFMiT2zYLALOFki6w6uVAOzPusE8bRQ268O1UX+mtQ2HWWL7NwVzsQvKl6jkvS60EJqzAGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ke8rkAi0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709937427; x=1741473427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kAujv+mSg6pk0dDrfNeMRZarJKfwCx1NNukVNU+N4Js=;
  b=ke8rkAi0iuCeOm7h+5SQiGzZsq/63y3kN4Xo9iaatgTsXBFMf8NuhlAw
   9mONvDeTT50ILg+xgJntEoKracAQNIHH1pDLTGIWxA5bZux7r7aLOfmZY
   kXW1RinR0nvXPxf4BRUYb+BZG3AIebG714q/8UsK05MMhq2yiihiqrNH5
   UQzQ7yJvcTMnqcBfD8OxqxYXYQ/XqrRf3O/Sky9DMKYhAnll+VixvzjVr
   JNCTFvIq3U2sIOeHQLUVTUM8fWM8VeXCNepvCDCeW2rsMqAXpsdL7bOZs
   cdvnv0nV3dpbh8SiM0E6NafP0bS3mYD2mMpvdRJdYTTu0PdnX+HN8k2Wa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4542811"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4542811"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 14:37:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="10685765"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Mar 2024 14:37:03 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riipp-0006lV-1c;
	Fri, 08 Mar 2024 22:37:01 +0000
Date: Sat, 9 Mar 2024 06:36:51 +0800
From: kernel test robot <lkp@intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: Re: [PATCH 3/5] media: imx335: Use V4L2 CCI for accessing sensor
 registers
Message-ID: <202403090619.8LsTJtMf-lkp@intel.com>
References: <20240306081038.212412-4-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306081038.212412-4-umang.jain@ideasonboard.com>

Hi Umang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linuxtv-media-stage/master]
[cannot apply to media-tree/master sailus-media-tree/streams linus/master v6.8-rc7 next-20240308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Umang-Jain/media-imx335-Support-2-or-4-lane-operation-modes/20240306-161903
base:   https://git.linuxtv.org/media_stage.git master
patch link:    https://lore.kernel.org/r/20240306081038.212412-4-umang.jain%40ideasonboard.com
patch subject: [PATCH 3/5] media: imx335: Use V4L2 CCI for accessing sensor registers
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20240309/202403090619.8LsTJtMf-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240309/202403090619.8LsTJtMf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403090619.8LsTJtMf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/imx335.c:214: warning: Function parameter or struct member 'cci' not described in 'imx335'
   drivers/media/i2c/imx335.c:214: warning: Function parameter or struct member 'lane_mode' not described in 'imx335'


vim +214 drivers/media/i2c/imx335.c

45d19b5fb9aeab Martina Krasteva 2021-05-27  165  
45d19b5fb9aeab Martina Krasteva 2021-05-27  166  /**
45d19b5fb9aeab Martina Krasteva 2021-05-27  167   * struct imx335 - imx335 sensor device structure
45d19b5fb9aeab Martina Krasteva 2021-05-27  168   * @dev: Pointer to generic device
45d19b5fb9aeab Martina Krasteva 2021-05-27  169   * @client: Pointer to i2c client
45d19b5fb9aeab Martina Krasteva 2021-05-27  170   * @sd: V4L2 sub-device
45d19b5fb9aeab Martina Krasteva 2021-05-27  171   * @pad: Media pad. Only one pad supported
45d19b5fb9aeab Martina Krasteva 2021-05-27  172   * @reset_gpio: Sensor reset gpio
fea91ee73b7cd1 Kieran Bingham   2023-12-11  173   * @supplies: Regulator supplies to handle power control
45d19b5fb9aeab Martina Krasteva 2021-05-27  174   * @inclk: Sensor input clock
45d19b5fb9aeab Martina Krasteva 2021-05-27  175   * @ctrl_handler: V4L2 control handler
45d19b5fb9aeab Martina Krasteva 2021-05-27  176   * @link_freq_ctrl: Pointer to link frequency control
45d19b5fb9aeab Martina Krasteva 2021-05-27  177   * @pclk_ctrl: Pointer to pixel clock control
45d19b5fb9aeab Martina Krasteva 2021-05-27  178   * @hblank_ctrl: Pointer to horizontal blanking control
45d19b5fb9aeab Martina Krasteva 2021-05-27  179   * @vblank_ctrl: Pointer to vertical blanking control
45d19b5fb9aeab Martina Krasteva 2021-05-27  180   * @exp_ctrl: Pointer to exposure control
45d19b5fb9aeab Martina Krasteva 2021-05-27  181   * @again_ctrl: Pointer to analog gain control
45d19b5fb9aeab Martina Krasteva 2021-05-27  182   * @vblank: Vertical blanking in lines
8c48b2175e7d73 Kieran Bingham   2024-03-06  183   * @lane_mode Mode for number of connected data lanes
45d19b5fb9aeab Martina Krasteva 2021-05-27  184   * @cur_mode: Pointer to current selected sensor mode
45d19b5fb9aeab Martina Krasteva 2021-05-27  185   * @mutex: Mutex for serializing sensor controls
0862582b5239a6 Umang Jain       2024-02-20  186   * @link_freq_bitmap: Menu bitmap for link_freq_ctrl
cfa49ff0558a32 Umang Jain       2023-12-11  187   * @cur_mbus_code: Currently selected media bus format code
45d19b5fb9aeab Martina Krasteva 2021-05-27  188   */
45d19b5fb9aeab Martina Krasteva 2021-05-27  189  struct imx335 {
45d19b5fb9aeab Martina Krasteva 2021-05-27  190  	struct device *dev;
45d19b5fb9aeab Martina Krasteva 2021-05-27  191  	struct i2c_client *client;
45d19b5fb9aeab Martina Krasteva 2021-05-27  192  	struct v4l2_subdev sd;
45d19b5fb9aeab Martina Krasteva 2021-05-27  193  	struct media_pad pad;
45d19b5fb9aeab Martina Krasteva 2021-05-27  194  	struct gpio_desc *reset_gpio;
fea91ee73b7cd1 Kieran Bingham   2023-12-11  195  	struct regulator_bulk_data supplies[ARRAY_SIZE(imx335_supply_name)];
fa7ceacf9c0af6 Umang Jain       2024-03-06  196  	struct regmap *cci;
fea91ee73b7cd1 Kieran Bingham   2023-12-11  197  
45d19b5fb9aeab Martina Krasteva 2021-05-27  198  	struct clk *inclk;
45d19b5fb9aeab Martina Krasteva 2021-05-27  199  	struct v4l2_ctrl_handler ctrl_handler;
45d19b5fb9aeab Martina Krasteva 2021-05-27  200  	struct v4l2_ctrl *link_freq_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  201  	struct v4l2_ctrl *pclk_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  202  	struct v4l2_ctrl *hblank_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  203  	struct v4l2_ctrl *vblank_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  204  	struct {
45d19b5fb9aeab Martina Krasteva 2021-05-27  205  		struct v4l2_ctrl *exp_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  206  		struct v4l2_ctrl *again_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  207  	};
45d19b5fb9aeab Martina Krasteva 2021-05-27  208  	u32 vblank;
8c48b2175e7d73 Kieran Bingham   2024-03-06  209  	u32 lane_mode;
45d19b5fb9aeab Martina Krasteva 2021-05-27  210  	const struct imx335_mode *cur_mode;
45d19b5fb9aeab Martina Krasteva 2021-05-27  211  	struct mutex mutex;
0862582b5239a6 Umang Jain       2024-02-20  212  	unsigned long link_freq_bitmap;
cfa49ff0558a32 Umang Jain       2023-12-11  213  	u32 cur_mbus_code;
45d19b5fb9aeab Martina Krasteva 2021-05-27 @214  };
45d19b5fb9aeab Martina Krasteva 2021-05-27  215  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

