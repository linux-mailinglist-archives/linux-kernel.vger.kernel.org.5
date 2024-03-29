Return-Path: <linux-kernel+bounces-125547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EC1892802
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 01:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD0A284065
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8037AD22;
	Sat, 30 Mar 2024 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMYpdqnL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161D1C0DD1;
	Sat, 30 Mar 2024 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756817; cv=none; b=nZHN/ca8DFP4/9Tw2zeaX7eZIbJbIkNtIRRjzIm6EpdRagxtuQf+YdyPYTiNK21CsOWvA/SbgL6L/pHd0WpnVRXHAc/EbmXUFFQw/vlEcUE1odWhJN2QbivkhUXq7kDOeIg6KXerf0kmo3tbQ43XkFfSLgVd1VPKeBzjBtTWyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756817; c=relaxed/simple;
	bh=iGZ/eEQlOXZ6oU4a4b0LlMVeGr0pZcm6ir9fO0S8ymU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQyPGSoObieLxHW6vn9RazpFD9TIT2Kg3CD3NyBoUYVTdHYgxgxsaAFLKpdRxTgiyLpym62D4Cya2D0M5Y4uxo0WMAUsQ5epou/zK+vcL/ks5iSyf695pSgNLztSCmng+8EuLD8HxzDgzvUOwiB3RmGGi2akwvbkb9tta62Gj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMYpdqnL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711756815; x=1743292815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iGZ/eEQlOXZ6oU4a4b0LlMVeGr0pZcm6ir9fO0S8ymU=;
  b=cMYpdqnLogKcPUXa5WrpkTBS1namR7jhfmwbxVgxr1VWyQ9eIpejkSyE
   aZGH6qgY23r1TgX++jBoxc72C2cQ4+WUDy5txf2vQyXMxwjNwDT8PdFLS
   kN0h9QUR9LA20lk64GovvyUKMDwmGQSbfNNiktfh72+rHK5FADz248Sza
   a8KQx8/mq/EBobRMzRQRBj1BRxnBJexO0duj7ree7EixRqjjVlp1h5p9q
   HcVpUfR5Z95Gp3/IYPggIDNvG1E/Z0R309GLnWDLlnSQsbWe9bgKUKrPa
   QNts5ix3ChOMoqE+EES2wAsWmO7EcVq7S7OBg8avwGktrpyx+wR80pthE
   Q==;
X-CSE-ConnectionGUID: R+1kBV+5SJmMWloNtSaOow==
X-CSE-MsgGUID: 07BFEF0tTMOv280ZtucRnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="18395246"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="18395246"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 17:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="48082034"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Mar 2024 17:00:11 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqM8n-0003l8-0O;
	Sat, 30 Mar 2024 00:00:09 +0000
Date: Sat, 30 Mar 2024 07:59:17 +0800
From: kernel test robot <lkp@intel.com>
To: John Bauer via B4 Relay <devnull+johnebgood.securitylive.com@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linh.tp.vu@gmail.com, ribalda@chromium.org, soyer@irl.hu,
	John Bauer <johnebgood@securitylive.com>
Subject: Re: [PATCH 1/2] media: uvcvideo: UVC minimum relative pan/tilt/zoom
 speed fix
Message-ID: <202403300745.omqy1CdY-lkp@intel.com>
References: <20240328-uvc-fix-relative-ptz-speed-v1-1-17373eb8b2be@securitylive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-uvc-fix-relative-ptz-speed-v1-1-17373eb8b2be@securitylive.com>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 23956900041d968f9ad0f30db6dede4daccd7aa9]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Bauer-via-B4-Relay/media-uvcvideo-UVC-minimum-relative-pan-tilt-zoom-speed-fix/20240329-071938
base:   23956900041d968f9ad0f30db6dede4daccd7aa9
patch link:    https://lore.kernel.org/r/20240328-uvc-fix-relative-ptz-speed-v1-1-17373eb8b2be%40securitylive.com
patch subject: [PATCH 1/2] media: uvcvideo: UVC minimum relative pan/tilt/zoom speed fix
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240330/202403300745.omqy1CdY-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240330/202403300745.omqy1CdY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403300745.omqy1CdY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/usb/uvc/uvc_ctrl.c:1944:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                   default:
                   ^
   drivers/media/usb/uvc/uvc_ctrl.c:1944:3: note: insert 'break;' to avoid fall-through
                   default:
                   ^
                   break; 
   1 warning generated.


vim +1944 drivers/media/usb/uvc/uvc_ctrl.c

  1898	
  1899	int uvc_ctrl_set(struct uvc_fh *handle,
  1900		struct v4l2_ext_control *xctrl)
  1901	{
  1902		struct uvc_video_chain *chain = handle->chain;
  1903		struct uvc_control *ctrl;
  1904		struct uvc_control_mapping *mapping;
  1905		s32 value;
  1906		u32 step;
  1907		s32 min;
  1908		s32 max;
  1909		int ret;
  1910	
  1911		if (__uvc_query_v4l2_class(chain, xctrl->id, 0) >= 0)
  1912			return -EACCES;
  1913	
  1914		ctrl = uvc_find_control(chain, xctrl->id, &mapping);
  1915		if (ctrl == NULL)
  1916			return -EINVAL;
  1917		if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
  1918			return -EACCES;
  1919	
  1920		/* Clamp out of range values. */
  1921		switch (mapping->v4l2_type) {
  1922		case V4L2_CTRL_TYPE_INTEGER:
  1923			if (!ctrl->cached) {
  1924				ret = uvc_ctrl_populate_cache(chain, ctrl);
  1925				if (ret < 0)
  1926					return ret;
  1927			}
  1928	
  1929			min = mapping->get(mapping, UVC_GET_MIN,
  1930					   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
  1931			max = mapping->get(mapping, UVC_GET_MAX,
  1932					   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
  1933	
  1934			/*
  1935			 * For the relative speed implementation the minimum
  1936			 * value cannot be probed so it becomes the additive
  1937			 * inverse of maximum.
  1938			 */
  1939			switch (xctrl->id) {
  1940			case V4L2_CID_ZOOM_CONTINUOUS:
  1941			case V4L2_CID_PAN_SPEED:
  1942			case V4L2_CID_TILT_SPEED:
  1943				min = max * -1;
> 1944			default:
  1945				break;
  1946			}
  1947	
  1948			step = mapping->get(mapping, UVC_GET_RES,
  1949					    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
  1950			if (step == 0)
  1951				step = 1;
  1952	
  1953			xctrl->value = min + DIV_ROUND_CLOSEST((u32)(xctrl->value - min),
  1954								step) * step;
  1955			if (mapping->data_type == UVC_CTRL_DATA_TYPE_SIGNED)
  1956				xctrl->value = clamp(xctrl->value, min, max);
  1957			else
  1958				xctrl->value = clamp_t(u32, xctrl->value, min, max);
  1959			value = xctrl->value;
  1960			break;
  1961	
  1962		case V4L2_CTRL_TYPE_BITMASK:
  1963			if (!ctrl->cached) {
  1964				ret = uvc_ctrl_populate_cache(chain, ctrl);
  1965				if (ret < 0)
  1966					return ret;
  1967			}
  1968	
  1969			xctrl->value &= uvc_get_ctrl_bitmap(ctrl, mapping);
  1970			value = xctrl->value;
  1971			break;
  1972	
  1973		case V4L2_CTRL_TYPE_BOOLEAN:
  1974			xctrl->value = clamp(xctrl->value, 0, 1);
  1975			value = xctrl->value;
  1976			break;
  1977	
  1978		case V4L2_CTRL_TYPE_MENU:
  1979			if (xctrl->value < (ffs(mapping->menu_mask) - 1) ||
  1980			    xctrl->value > (fls(mapping->menu_mask) - 1))
  1981				return -ERANGE;
  1982	
  1983			if (!test_bit(xctrl->value, &mapping->menu_mask))
  1984				return -EINVAL;
  1985	
  1986			value = uvc_mapping_get_menu_value(mapping, xctrl->value);
  1987	
  1988			/*
  1989			 * Valid menu indices are reported by the GET_RES request for
  1990			 * UVC controls that support it.
  1991			 */
  1992			if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK) {
  1993				if (!ctrl->cached) {
  1994					ret = uvc_ctrl_populate_cache(chain, ctrl);
  1995					if (ret < 0)
  1996						return ret;
  1997				}
  1998	
  1999				if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & value))
  2000					return -EINVAL;
  2001			}
  2002	
  2003			break;
  2004	
  2005		default:
  2006			value = xctrl->value;
  2007			break;
  2008		}
  2009	
  2010		/*
  2011		 * If the mapping doesn't span the whole UVC control, the current value
  2012		 * needs to be loaded from the device to perform the read-modify-write
  2013		 * operation.
  2014		 */
  2015		if ((ctrl->info.size * 8) != mapping->size) {
  2016			ret = __uvc_ctrl_load_cur(chain, ctrl);
  2017			if (ret < 0)
  2018				return ret;
  2019		}
  2020	
  2021		/* Backup the current value in case we need to rollback later. */
  2022		if (!ctrl->dirty) {
  2023			memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_BACKUP),
  2024			       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
  2025			       ctrl->info.size);
  2026		}
  2027	
  2028		mapping->set(mapping, value,
  2029			uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
  2030	
  2031		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
  2032			ctrl->handle = handle;
  2033	
  2034		ctrl->dirty = 1;
  2035		ctrl->modified = 1;
  2036		return 0;
  2037	}
  2038	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

