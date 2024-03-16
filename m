Return-Path: <linux-kernel+bounces-105148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EEF87D9BA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754DF1C20E10
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE3017727;
	Sat, 16 Mar 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qb7zZnMk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F6E574
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710584089; cv=none; b=kh3lqEy6sl1VTnMs13pbQNUyl6Kmj6aynwEylMEF4sTltwDFgjAsFnWOB5hotLExl2c19KhXooAGGAm+XNotc21Ormn66xfve7KxWZXUoWZfiNsrVmFJzdg7N+BL2nxbObBxq4FdRXpd9C25Ualrc9rUkO93UvfW20HkAYTjuS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710584089; c=relaxed/simple;
	bh=Kr9XyN1BcJNx8ud6k8+lAqKYYVwHrFUQFkqpwFyswy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOtAGD6z1UDawWm1I7aYaEyVSWbGiZwziUgBfXSqO8rrsF5VODKdd7I4Ktk2Q898jEl8fvr5eaF/OSG+bQw5dgYGUr9i5rXCG0L7X3RFxshsdPElj5PNV9cw5lL4YrIDt5oK3NUfWsyNhyLo4jn0qBSiAAv9gOfyC6tUzPpGf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qb7zZnMk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710584087; x=1742120087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kr9XyN1BcJNx8ud6k8+lAqKYYVwHrFUQFkqpwFyswy8=;
  b=Qb7zZnMkttoaoH8n13ztU1573avUl8Ns0+YRQ4S7IGtcL0Ws/KycLcns
   jHFjOU8iqpZM8nw62uUYhi8IeRqyap8pg58A60BZyb4DHnVfBvKjK5vA+
   WTcTNs/kzZbd7MkF/V4TvwHYX5xQ1KFxeLyEyagV0geXM1+sLD8rUpphi
   rf07coZbZsJ2+4kY3msDU09nt5npDYydRonkPvCG5hp2EEzpk1IEPVq5L
   Cing0G/cSbR21L6blJTJc/qeafXeBE0OFoHqrnMorT1WWqbmwpvO6JuQI
   MP1Lgo3DJBBhSAS9T1zpMKUYuKbr58v7JSAan2uFRp/y9m5D0jyjA5DH4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="16600464"
X-IronPort-AV: E=Sophos;i="6.07,130,1708416000"; 
   d="scan'208";a="16600464"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 03:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,130,1708416000"; 
   d="scan'208";a="13014277"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Mar 2024 03:14:42 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlR3o-000FJl-1o;
	Sat, 16 Mar 2024 10:14:40 +0000
Date: Sat, 16 Mar 2024 18:14:26 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH 6/6] drm: zynqmp_dp: Add debugfs interface for compliance
 testing
Message-ID: <202403161704.ACHJdSJG-lkp@intel.com>
References: <20240315230916.1759060-7-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315230916.1759060-7-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.8]
[cannot apply to drm-misc/drm-misc-next linus/master next-20240315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/drm-zynqmp_dp-Downgrade-log-level-for-aux-retries-message/20240316-071208
base:   v6.8
patch link:    https://lore.kernel.org/r/20240315230916.1759060-7-sean.anderson%40linux.dev
patch subject: [PATCH 6/6] drm: zynqmp_dp: Add debugfs interface for compliance testing
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20240316/202403161704.ACHJdSJG-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403161704.ACHJdSJG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403161704.ACHJdSJG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/xlnx/zynqmp_dp.c: In function 'zynqmp_dp_bridge_debugfs_init':
>> drivers/gpu/drm/xlnx/zynqmp_dp.c:2168:31: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
    2168 |                 sprintf(name, fmt, i);
         |                               ^~~
   drivers/gpu/drm/xlnx/zynqmp_dp.c:2168:17: note: 'sprintf' output between 18 and 20 bytes into a destination of size 19
    2168 |                 sprintf(name, fmt, i);
         |                 ^~~~~~~~~~~~~~~~~~~~~


vim +/sprintf +2168 drivers/gpu/drm/xlnx/zynqmp_dp.c

  2136	
  2137	DEFINE_DEBUGFS_ATTRIBUTE(fops_zynqmp_dp_rate, zynqmp_dp_rate_get,
  2138				 zynqmp_dp_rate_set, "%llu\n");
  2139	
  2140	static void zynqmp_dp_bridge_debugfs_init(struct drm_bridge *bridge,
  2141						  struct dentry *root)
  2142	{
  2143		struct zynqmp_dp *dp = bridge_to_dp(bridge);
  2144		struct dentry *test;
  2145		int i;
  2146	
  2147		dp->test.bw_code = DP_LINK_BW_5_4;
  2148		dp->test.link_cnt = dp->num_lanes;
  2149	
  2150		test = debugfs_create_dir("test", root);
  2151	#define CREATE_FILE(name) \
  2152		debugfs_create_file(#name, 0600, test, dp, &fops_zynqmp_dp_##name)
  2153		CREATE_FILE(pattern);
  2154		CREATE_FILE(enhanced);
  2155		CREATE_FILE(downspread);
  2156		CREATE_FILE(active);
  2157		CREATE_FILE(custom);
  2158		CREATE_FILE(rate);
  2159		CREATE_FILE(lanes);
  2160	
  2161		for (i = 0; i < dp->num_lanes; i++) {
  2162			static const char fmt[] = "lane%d_preemphasis";
  2163			char name[sizeof(fmt)];
  2164	
  2165			dp->debugfs_train_set[i].dp = dp;
  2166			dp->debugfs_train_set[i].lane = i;
  2167	
> 2168			sprintf(name, fmt, i);
  2169			debugfs_create_file(name, 0600, test,
  2170					    &dp->debugfs_train_set[i],
  2171					    &fops_zynqmp_dp_preemphasis);
  2172	
  2173			sprintf(name, "lane%d_swing", i);
  2174			debugfs_create_file(name, 0600, test,
  2175					    &dp->debugfs_train_set[i],
  2176					    &fops_zynqmp_dp_swing);
  2177		}
  2178	}
  2179	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

