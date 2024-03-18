Return-Path: <linux-kernel+bounces-106273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABAC87EBB7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6C21C2152F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AAE4F5F2;
	Mon, 18 Mar 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QBaKobQO"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809624EB46
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774580; cv=none; b=Ma4vzAn2eC1xrPWi7Buw0W6yY+V8vH/Vfc44mnZ1wt1oY83AEy7FqmePESN/pbbRwXagvMNRSw/Sgr5d2DMssrBD3VtGByQLL7Ot/PsoPv0a9ZaYsH7D915R+YBgkOKR+K36WBWQ4k/GN9VzGZ/ZxW1NOzHrOZ/B36G7HxSA9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774580; c=relaxed/simple;
	bh=H7IGWMeRnaWxip9sjSRYjAeZUfDmhc3HZDLokWYk0Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9l5uiOsuM/WiEpis7Nta1cLroyi3bMZiYvD5VM+dNLsci0JuK1l4yO8/ny1H0R9yrd6JYROdKagj4rN++6HvasOYHinp26iovYE9Hlk14odihzUJxd9zIL5hC5IvyhK7XP5cIUSH9g3+kOcieF3YIeYSCAeQIaU7nkPKB6vLlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QBaKobQO; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0774c0a7-8ef7-47cb-8c1c-695c67e10182@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710774575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgBmXSoNNR4Olx/VcT0P5tBKTjoGvpwZV2EEX4qJmuU=;
	b=QBaKobQOGhE/aRia0yChrm9MJwbvcW4bh3X6p+7CXYuktwFUSFpgGcmzSuffJXN0Sg94b9
	0S7pplov2RTetNOzZ9UPiw2N5mjTTYpVuXhSxHmavXC4RCJwoA+ycyqvpRdXcz1Yrk4yf0
	zGf88ltQKdotcxNHvKNBlVjq1UJUfwk=
Date: Mon, 18 Mar 2024 11:09:33 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/6] drm: zynqmp_dp: Add locking
Content-Language: en-US
To: kernel test robot <lkp@intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
 linux-arm-kernel@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>
References: <20240315230916.1759060-4-sean.anderson@linux.dev>
 <202403161747.TRmfawhM-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <202403161747.TRmfawhM-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/16/24 05:52, kernel test robot wrote:
> Hi Sean,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on v6.8]
> [also build test WARNING on linus/master next-20240315]
> [cannot apply to drm-misc/drm-misc-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/drm-zynqmp_dp-Downgrade-log-level-for-aux-retries-message/20240316-071208
> base:   v6.8
> patch link:    https://lore.kernel.org/r/20240315230916.1759060-4-sean.anderson%40linux.dev
> patch subject: [PATCH 3/6] drm: zynqmp_dp: Add locking
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240316/202403161747.TRmfawhM-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403161747.TRmfawhM-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403161747.TRmfawhM-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/gpu/drm/xlnx/zynqmp_dp.c:321: warning: Function parameter or struct member 'hpd_irq_work' not described in 'zynqmp_dp'

Will document.

--Sean

> 
> vim +321 drivers/gpu/drm/xlnx/zynqmp_dp.c
> 
> d76271d22694e8 Hyun Kwon        2018-07-07  275  
> d76271d22694e8 Hyun Kwon        2018-07-07  276  /**
> d76271d22694e8 Hyun Kwon        2018-07-07  277   * struct zynqmp_dp - Xilinx DisplayPort core
> d76271d22694e8 Hyun Kwon        2018-07-07  278   * @dev: device structure
> d76271d22694e8 Hyun Kwon        2018-07-07  279   * @dpsub: Display subsystem
> d76271d22694e8 Hyun Kwon        2018-07-07  280   * @iomem: device I/O memory for register access
> d76271d22694e8 Hyun Kwon        2018-07-07  281   * @reset: reset controller
> 8ce380e6568015 Sean Anderson    2024-03-15  282   * @lock: Mutex protecting this struct and register access (but not AUX)
> d76271d22694e8 Hyun Kwon        2018-07-07  283   * @irq: irq
> 47e801bd0749f0 Laurent Pinchart 2021-08-04  284   * @bridge: DRM bridge for the DP encoder
> bd68b9b3cb2e0d Laurent Pinchart 2021-08-04  285   * @next_bridge: The downstream bridge
> d76271d22694e8 Hyun Kwon        2018-07-07  286   * @config: IP core configuration from DTS
> d76271d22694e8 Hyun Kwon        2018-07-07  287   * @aux: aux channel
> d76271d22694e8 Hyun Kwon        2018-07-07  288   * @phy: PHY handles for DP lanes
> d76271d22694e8 Hyun Kwon        2018-07-07  289   * @num_lanes: number of enabled phy lanes
> d76271d22694e8 Hyun Kwon        2018-07-07  290   * @hpd_work: hot plug detection worker
> d76271d22694e8 Hyun Kwon        2018-07-07  291   * @status: connection status
> d76271d22694e8 Hyun Kwon        2018-07-07  292   * @enabled: flag to indicate if the device is enabled
> d76271d22694e8 Hyun Kwon        2018-07-07  293   * @dpcd: DP configuration data from currently connected sink device
> d76271d22694e8 Hyun Kwon        2018-07-07  294   * @link_config: common link configuration between IP core and sink device
> d76271d22694e8 Hyun Kwon        2018-07-07  295   * @mode: current mode between IP core and sink device
> d76271d22694e8 Hyun Kwon        2018-07-07  296   * @train_set: set of training data
> d76271d22694e8 Hyun Kwon        2018-07-07  297   */
> d76271d22694e8 Hyun Kwon        2018-07-07  298  struct zynqmp_dp {
> d76271d22694e8 Hyun Kwon        2018-07-07  299  	struct device *dev;
> d76271d22694e8 Hyun Kwon        2018-07-07  300  	struct zynqmp_dpsub *dpsub;
> d76271d22694e8 Hyun Kwon        2018-07-07  301  	void __iomem *iomem;
> d76271d22694e8 Hyun Kwon        2018-07-07  302  	struct reset_control *reset;
> 8ce380e6568015 Sean Anderson    2024-03-15  303  	struct mutex lock;
> d76271d22694e8 Hyun Kwon        2018-07-07  304  	int irq;
> d76271d22694e8 Hyun Kwon        2018-07-07  305  
> 47e801bd0749f0 Laurent Pinchart 2021-08-04  306  	struct drm_bridge bridge;
> bd68b9b3cb2e0d Laurent Pinchart 2021-08-04  307  	struct drm_bridge *next_bridge;
> 47e801bd0749f0 Laurent Pinchart 2021-08-04  308  
> d76271d22694e8 Hyun Kwon        2018-07-07  309  	struct zynqmp_dp_config config;
> d76271d22694e8 Hyun Kwon        2018-07-07  310  	struct drm_dp_aux aux;
> d76271d22694e8 Hyun Kwon        2018-07-07  311  	struct phy *phy[ZYNQMP_DP_MAX_LANES];
> d76271d22694e8 Hyun Kwon        2018-07-07  312  	u8 num_lanes;
> 8ce380e6568015 Sean Anderson    2024-03-15  313  	struct delayed_work hpd_work, hpd_irq_work;
> d76271d22694e8 Hyun Kwon        2018-07-07  314  	enum drm_connector_status status;
> d76271d22694e8 Hyun Kwon        2018-07-07  315  	bool enabled;
> d76271d22694e8 Hyun Kwon        2018-07-07  316  
> d76271d22694e8 Hyun Kwon        2018-07-07  317  	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> d76271d22694e8 Hyun Kwon        2018-07-07  318  	struct zynqmp_dp_link_config link_config;
> d76271d22694e8 Hyun Kwon        2018-07-07  319  	struct zynqmp_dp_mode mode;
> d76271d22694e8 Hyun Kwon        2018-07-07  320  	u8 train_set[ZYNQMP_DP_MAX_LANES];
> d76271d22694e8 Hyun Kwon        2018-07-07 @321  };
> d76271d22694e8 Hyun Kwon        2018-07-07  322  
> 


