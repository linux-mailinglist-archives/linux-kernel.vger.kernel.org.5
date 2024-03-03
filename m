Return-Path: <linux-kernel+bounces-89841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ADD86F659
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DBA281A79
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA10B76408;
	Sun,  3 Mar 2024 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EzZErkQr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB57640A
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709486164; cv=none; b=qmIpC2qOHTOxPCzTlKHcH/u2qt0cQoSV5jGXvurOffjwXBrfMWNblf5soDTX9ZctrXYBrw7rqPATuBjuE0vrSFb7atSQTvoCPibYH7/hIhTH89XKNhz3WCYJ9fTke/IoFkGc6s705FrWVUcJbFomnZj1RjbM82FVRH/kb74Ff00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709486164; c=relaxed/simple;
	bh=qRStcwLXl2/7vDMZpOL69TpjetNulwoJj2qetC831JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQiYaTFb3tkPmD0gfl1gxJOAAoZnOn2nkEuq1y8vkRGmvU+gLRsXPJ5mjuKFHs/SlzbSjm6iDlex0xZXaJ3dv+lQrh4W7iEFZWEaGvSuamfvqLXeCLLT2N2Dv34nsrFODNbbHyFlO4R5Gf8JoXh1EyHy47vkhp7Vj5PMdbmWQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EzZErkQr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709486161; x=1741022161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qRStcwLXl2/7vDMZpOL69TpjetNulwoJj2qetC831JA=;
  b=EzZErkQrgtjMW/seUOIJ9MCRLUhMACcvsBa1FUfg3YQlcsWGJssGs4CU
   NF4tmFzNqtFBR8S/MpZf2whhc4xhPvrSPkGsPatRwVLM1xhWkqku+8YII
   02Y60RCd2XEfUp6vmzkMnimrY2sKChTuWVakAFF+8pxLqFuHzQenET3v/
   4rRoRKho+h1dXcZWLTdb96Vo3C2lIXatYyA8YyHu2vf3rgpwubpL8yr8d
   z1i4F/bmEmqShnRwNREhmv4S6lRiWkd1Ybk2EcZO4M7w+9VXYdsRsh++V
   Jn5CPWiTHKzDm6LDc1VX/f48OVhC+DEbbo5IfVBhUrH+ouUKOC+JtQRnI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7790968"
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="7790968"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 09:16:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="9196876"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 03 Mar 2024 09:15:56 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgpRJ-0001yO-2z;
	Sun, 03 Mar 2024 17:15:53 +0000
Date: Mon, 4 Mar 2024 01:15:17 +0800
From: kernel test robot <lkp@intel.com>
To: Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <monstr@monstr.eu>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Subject: Re: [PATCH 3/4] drm: xlnx: zynqmp_dpsub: Set input live format
Message-ID: <202403040104.mwzqu5gs-lkp@intel.com>
References: <20240226-dp-live-fmt-v1-3-b78c3f69c9d8@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-dp-live-fmt-v1-3-b78c3f69c9d8@amd.com>

Hi Anatoliy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bfa4437fd3938ae2e186e7664b2db65bb8775670]

url:    https://github.com/intel-lab-lkp/linux/commits/Anatoliy-Klymenko/drm-xlnx-zynqmp_dpsub-Set-layer-mode-during-creation/20240227-124631
base:   bfa4437fd3938ae2e186e7664b2db65bb8775670
patch link:    https://lore.kernel.org/r/20240226-dp-live-fmt-v1-3-b78c3f69c9d8%40amd.com
patch subject: [PATCH 3/4] drm: xlnx: zynqmp_dpsub: Set input live format
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20240304/202403040104.mwzqu5gs-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403040104.mwzqu5gs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403040104.mwzqu5gs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/xlnx/zynqmp_disp.c:164: warning: Function parameter or struct member 'blend' not described in 'zynqmp_disp'
   drivers/gpu/drm/xlnx/zynqmp_disp.c:164: warning: Function parameter or struct member 'avbuf' not described in 'zynqmp_disp'
   drivers/gpu/drm/xlnx/zynqmp_disp.c:164: warning: Function parameter or struct member 'audio' not described in 'zynqmp_disp'
>> drivers/gpu/drm/xlnx/zynqmp_disp.c:1019: warning: Function parameter or struct member 'bus_format' not described in 'zynqmp_disp_layer_set_live_format'
>> drivers/gpu/drm/xlnx/zynqmp_disp.c:1019: warning: Excess function parameter 'info' description in 'zynqmp_disp_layer_set_live_format'


vim +1019 drivers/gpu/drm/xlnx/zynqmp_disp.c

  1009	
  1010	/**
  1011	 * zynqmp_disp_layer_set_live_format - Set live layer input format
  1012	 * @layer: The layer
  1013	 * @info: Input media bus format
  1014	 *
  1015	 * Set the live @layer input bus format. The layer must be disabled.
  1016	 */
  1017	void zynqmp_disp_layer_set_live_format(struct zynqmp_disp_layer *layer,
  1018					       u32 bus_format)
> 1019	{
  1020		int i;
  1021		const struct zynqmp_disp_format *fmt;
  1022	
  1023		for (i = 0; i < ARRAY_SIZE(avbuf_live_fmts); ++i) {
  1024			fmt = &avbuf_live_fmts[i];
  1025			if (fmt->bus_fmt == bus_format) {
  1026				layer->disp_fmt = fmt;
  1027				layer->drm_fmt = drm_format_info(fmt->drm_fmt);
  1028				zynqmp_disp_avbuf_set_live_format(layer->disp, layer, fmt);
  1029				return;
  1030			}
  1031		}
  1032	}
  1033	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

