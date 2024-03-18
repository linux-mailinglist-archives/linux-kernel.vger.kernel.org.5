Return-Path: <linux-kernel+bounces-106263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C51F87EB9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1B21C203AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0234EB4C;
	Mon, 18 Mar 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aqcmgOtc"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E914EB3D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774410; cv=none; b=nudkoksAB8lPOKZqPxHxvLKRkKtqf9Yj82lGQL761eqGD6OfDFaybh9Hdfd9TMsEZrCUNyZEIwK8IrZqpoRbNPHUVxegjc5Bk4RLRs5MgOIbt/SRg3GMtxA5zSZF9fOCwA1Id8ndvAsW8Tu6WsqFgzy1YgKeUWPoLgi7iz3U5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774410; c=relaxed/simple;
	bh=M5sEvDQyfmg+P2iDJySXqyw0gSuuzNz3bDLZJ/j8Q+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cR7GTzEgTPHc+5+kPeYyzAuaqA/9Nmz9mTnzaTewuL8+CWkYu9/BrdRWQj5L2X1VSTwBtC4qFa4gNwVHiZQMay4Xd4RZcIJ9YOq2xk1esbCgSJgFmTVvr3GY6ooyawqZDUha+7XD8E78+vyFis1QYjiHGAOR0sAi4Mb89HnOrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aqcmgOtc; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce1190ad-27c2-4a16-b36f-442c0c419dcc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710774406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFYG+MKz6ANyiG8TJd96eDulfolyGk7SAyNV6wkBMI8=;
	b=aqcmgOtcga3dPZNJ+pFQjL/wYPJrKLvFM1eNMecpTYbr3CnJ7aK8teeg5grYRAERQAok4r
	YETCfbnGg0E2TrUq+fzAte+uGdX2kl00/hvjzSVktg0r3WCmahqPV75FC0LZITIELNoy1X
	QtGHib4VztypWJxSOtDxcGGc2c9Hmfo=
Date: Mon, 18 Mar 2024 11:06:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6/6] drm: zynqmp_dp: Add debugfs interface for compliance
 testing
Content-Language: en-US
To: kernel test robot <lkp@intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
 linux-arm-kernel@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>
References: <20240315230916.1759060-7-sean.anderson@linux.dev>
 <202403161704.ACHJdSJG-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <202403161704.ACHJdSJG-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/16/24 06:14, kernel test robot wrote:
> Hi Sean,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on v6.8]
> [cannot apply to drm-misc/drm-misc-next linus/master next-20240315]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/drm-zynqmp_dp-Downgrade-log-level-for-aux-retries-message/20240316-071208
> base:   v6.8
> patch link:    https://lore.kernel.org/r/20240315230916.1759060-7-sean.anderson%40linux.dev
> patch subject: [PATCH 6/6] drm: zynqmp_dp: Add debugfs interface for compliance testing
> config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20240316/202403161704.ACHJdSJG-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403161704.ACHJdSJG-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403161704.ACHJdSJG-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/gpu/drm/xlnx/zynqmp_dp.c: In function 'zynqmp_dp_bridge_debugfs_init':
>>> drivers/gpu/drm/xlnx/zynqmp_dp.c:2168:31: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
>     2168 |                 sprintf(name, fmt, i);
>          |                               ^~~
>    drivers/gpu/drm/xlnx/zynqmp_dp.c:2168:17: note: 'sprintf' output between 18 and 20 bytes into a destination of size 19
>     2168 |                 sprintf(name, fmt, i);
>          |                 ^~~~~~~~~~~~~~~~~~~~~

Not a bug, as i will be at most 4, which uses 1 digit.

--Sean

> vim +/sprintf +2168 drivers/gpu/drm/xlnx/zynqmp_dp.c
> 
>   2136	
>   2137	DEFINE_DEBUGFS_ATTRIBUTE(fops_zynqmp_dp_rate, zynqmp_dp_rate_get,
>   2138				 zynqmp_dp_rate_set, "%llu\n");
>   2139	
>   2140	static void zynqmp_dp_bridge_debugfs_init(struct drm_bridge *bridge,
>   2141						  struct dentry *root)
>   2142	{
>   2143		struct zynqmp_dp *dp = bridge_to_dp(bridge);
>   2144		struct dentry *test;
>   2145		int i;
>   2146	
>   2147		dp->test.bw_code = DP_LINK_BW_5_4;
>   2148		dp->test.link_cnt = dp->num_lanes;
>   2149	
>   2150		test = debugfs_create_dir("test", root);
>   2151	#define CREATE_FILE(name) \
>   2152		debugfs_create_file(#name, 0600, test, dp, &fops_zynqmp_dp_##name)
>   2153		CREATE_FILE(pattern);
>   2154		CREATE_FILE(enhanced);
>   2155		CREATE_FILE(downspread);
>   2156		CREATE_FILE(active);
>   2157		CREATE_FILE(custom);
>   2158		CREATE_FILE(rate);
>   2159		CREATE_FILE(lanes);
>   2160	
>   2161		for (i = 0; i < dp->num_lanes; i++) {
>   2162			static const char fmt[] = "lane%d_preemphasis";
>   2163			char name[sizeof(fmt)];
>   2164	
>   2165			dp->debugfs_train_set[i].dp = dp;
>   2166			dp->debugfs_train_set[i].lane = i;
>   2167	
>> 2168			sprintf(name, fmt, i);
>   2169			debugfs_create_file(name, 0600, test,
>   2170					    &dp->debugfs_train_set[i],
>   2171					    &fops_zynqmp_dp_preemphasis);
>   2172	
>   2173			sprintf(name, "lane%d_swing", i);
>   2174			debugfs_create_file(name, 0600, test,
>   2175					    &dp->debugfs_train_set[i],
>   2176					    &fops_zynqmp_dp_swing);
>   2177		}
>   2178	}
>   2179	
> 


