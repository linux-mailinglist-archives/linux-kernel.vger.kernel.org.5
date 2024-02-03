Return-Path: <linux-kernel+bounces-51090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DEE84865F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E841F2B491
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 12:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2260F4F5EB;
	Sat,  3 Feb 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTpQaZTs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532305D72F;
	Sat,  3 Feb 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706964916; cv=none; b=fCSwaR3vwLff6cQOtmp2lhEXDeeA95l3DjnuriMebJRzRrKFP4uhgU45AsYw/8P/CAEteAe4Mvfmm97irYe2eqs5F0nJIjpjpIAnJTJ4v5vC3OEj0pPYcrLbcXYBkOs8zljk6y5rEy5A17Ip6VQrnZTQR3YiokFYm99brHDwUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706964916; c=relaxed/simple;
	bh=vyJ5hhjOpFvVIqOq5lbkWG6pTutqv/soxCjv32aKKZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNIjnx6f9mJ3xkzPqHcgVYLvkFiAVMC5J2pG0GFmKe2UACJ4kGkbl1MpCGu3kjEpYpJcjvGFrG8CxYrgRq2DHgdlsETPB43M5/6Vd0YGjybkX/Of9hlQleTcpaNRY29EvBJv8Y6ePKBTIvBRecmVtKkZsFECjjQSxV1PpB4p88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BTpQaZTs; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706964914; x=1738500914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vyJ5hhjOpFvVIqOq5lbkWG6pTutqv/soxCjv32aKKZ0=;
  b=BTpQaZTsnHtuRpzZMxmgrc8/HjAyJKiryUzP8WdYbWmqPghgyS9cPaFx
   Ff7XqsEk2y2gxIW+K2PQ4bm17RI4nDX3wZmmannYxrm1RGSVGOFsPVtX5
   6SyZjD1mZfwYMOMV7EzCARhRqBMXwlP6zu/WJMQidrCUBYoIGU+sSmPID
   VH+Ki/HGeG/+4zTYXG0izwO7wRPSh0mbYpYusNXVbTYJTnnuU0hANJeft
   gVBnLOo4fcsUqmObRBeaBVbBBHoDvzw+D4mkhYryhnOMj832lDI7UB7L9
   HwucUhhUOnGjuoMMd/o2yERAa3F1PNXs84aO5zdgGEvj66S7VtNQH2ZD0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="479363"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="479363"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 04:55:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="932741882"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="932741882"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2024 04:55:10 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWFXe-00053o-0x;
	Sat, 03 Feb 2024 12:54:50 +0000
Date: Sat, 3 Feb 2024 20:53:33 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	Melissa Wen <mwen@igalia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 3/5] drm/amd: Fetch the EDID from _DDC if available
 for eDP
Message-ID: <202402032030.IBEf5Cme-lkp@intel.com>
References: <20240201221119.42564-4-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201221119.42564-4-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on drm-intel/for-linux-next-fixes drm-xe/drm-xe-next linus/master v6.8-rc2 next-20240202]
[cannot apply to drm-misc/drm-misc-next drm-intel/for-linux-next rafael-pm/acpi-bus rafael-pm/devprop]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-video-Handle-fetching-EDID-that-is-longer-than-256-bytes/20240202-061301
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240201221119.42564-4-mario.limonciello%40amd.com
patch subject: [PATCH v3 3/5] drm/amd: Fetch the EDID from _DDC if available for eDP
config: i386-randconfig-004-20240203 (https://download.01.org/0day-ci/archive/20240203/202402032030.IBEf5Cme-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402032030.IBEf5Cme-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402032030.IBEf5Cme-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'create_eml_sink':
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6599:5: warning: 'edid' is used uninitialized in this function [-Wuninitialized]
    6599 |  if (!edid)
         |     ^


vim +/edid +6599 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

  6582	
  6583	static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
  6584	{
  6585		struct drm_connector *connector = &aconnector->base;
  6586		struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(&aconnector->base);
  6587		struct dc_sink_init_data init_params = {
  6588				.link = aconnector->dc_link,
  6589				.sink_signal = SIGNAL_TYPE_VIRTUAL
  6590		};
  6591		struct edid *edid;
  6592	
  6593		/*
  6594		 * Note: drm_get_edid gets edid in the following order:
  6595		 * 1) override EDID if set via edid_override debugfs,
  6596		 * 2) firmware EDID if set via edid_firmware module parameter
  6597		 * 3) regular DDC read.
  6598		 */
> 6599		if (!edid)
  6600			edid = drm_get_edid(connector, &amdgpu_connector->ddc_bus->aux.ddc);
  6601	
  6602		if (!edid) {
  6603			DRM_ERROR("No EDID found on connector: %s.\n", connector->name);
  6604			return;
  6605		}
  6606	
  6607		if (drm_detect_hdmi_monitor(edid))
  6608			init_params.sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
  6609	
  6610		aconnector->edid = edid;
  6611	
  6612		aconnector->dc_em_sink = dc_link_add_remote_sink(
  6613			aconnector->dc_link,
  6614			(uint8_t *)edid,
  6615			(edid->extensions + 1) * EDID_LENGTH,
  6616			&init_params);
  6617	
  6618		if (aconnector->base.force == DRM_FORCE_ON) {
  6619			aconnector->dc_sink = aconnector->dc_link->local_sink ?
  6620			aconnector->dc_link->local_sink :
  6621			aconnector->dc_em_sink;
  6622			dc_sink_retain(aconnector->dc_sink);
  6623		}
  6624	}
  6625	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

