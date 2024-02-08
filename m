Return-Path: <linux-kernel+bounces-57458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DDA84D952
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60379285566
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962592C1A6;
	Thu,  8 Feb 2024 04:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axh+lK2g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CB12C6AA;
	Thu,  8 Feb 2024 04:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707365313; cv=none; b=eOYuLy3ii4R/2BOjeXHNx6hEgP6QxVFZvxmQM1xxUPUl6BI6LPxWSWWuBbj6ELXrhdXk+cZtQmmwE5FfkLpm4np92BH+baycEJjP0HokpYwWQDafqRWG3jy+LSl9bF4IsAS5RqisVGV/c5qKFjeBT2qRASPyjwIoFAYx53BLRjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707365313; c=relaxed/simple;
	bh=NkAI6H35ROaFu13zo+RHURA61NgMQ5XNqRAfgGx1xd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwqqC1yYCP0sEezxPJxsarXMmtN9kg9LfR6XzxvK1hP9dT0RbPX5zyxwdCrsFYoUentIA8TD44FrnIlqnX2K6UL7vfhWTo63ed7L5EnsJVx+6Hb+keZoRvLat50oLR6F0QPvN8AXeo6aoq6T9e7V4TYQkqbv11HmbDo+orSoux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axh+lK2g; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707365312; x=1738901312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NkAI6H35ROaFu13zo+RHURA61NgMQ5XNqRAfgGx1xd4=;
  b=axh+lK2gYBDAsq+wPvxKmI6vcTNDpNQ2CXsNRUYWWnJ8prK0J8STDJlz
   gOEwc5i1bTNFyU8Xxl4N5uepNnziBGeBmWH0U1XrphFDoFrUIwcGHbIeR
   VkHMqp0dHxL0qfi/uyzo/JsR//d+frJYYrMxy16PZ8t1P6wfD2jIvWg+i
   71VWLOwqOLt3L0Cqc9M65pQ/auGNI2xWEtjfmduZCgZVd3Is/pr5PZ7XI
   BagwzCJdD9nxtvD9zR3PbRNJixvXQp7w5PpoBOr1PBRh6Aqha+oWyRtVh
   0QqBlrypJ8QILkv+7AiN6/b8IOqz0bjSJb1vIYtRIYNftyTIW73k/HQMc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11775903"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="11775903"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 20:08:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1531966"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 Feb 2024 20:08:24 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXvi3-0003LK-2f;
	Thu, 08 Feb 2024 04:08:23 +0000
Date: Thu, 8 Feb 2024 12:07:40 +0800
From: kernel test robot <lkp@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Prashant Malani <pmalani@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Emilie Roberts <hadrosaur@google.com>,
	"Nyman, Mathias" <mathias.nyman@intel.com>,
	"Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
	"Radjacoumar, Shyam Sundar" <ssradjacoumar@google.com>,
	Samuel Jacob <samjaco@google.com>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	Uday Bhat <uday.m.bhat@intel.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Make sure the USB
 role switch has PLD
Message-ID: <202402081136.sve0cViZ-lkp@intel.com>
References: <20240207145851.1603237-3-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207145851.1603237-3-heikki.krogerus@linux.intel.com>

Hi Heikki,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus chrome-platform/for-next chrome-platform/for-firmware-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.8-rc3 next-20240207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heikki-Krogerus/usb-roles-Link-the-switch-to-its-connector/20240207-230017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240207145851.1603237-3-heikki.krogerus%40linux.intel.com
patch subject: [PATCH 2/2] platform/chrome: cros_ec_typec: Make sure the USB role switch has PLD
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240208/202402081136.sve0cViZ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240208/202402081136.sve0cViZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402081136.sve0cViZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/platform/chrome/cros_ec_typec.c: In function 'cros_typec_parse_port_props':
>> drivers/platform/chrome/cros_ec_typec.c:75:34: error: invalid use of undefined type 'struct acpi_device'
      75 |                 if (adev && !adev->pld_crc)
         |                                  ^~
   drivers/platform/chrome/cros_ec_typec.c:76:29: error: invalid use of undefined type 'struct acpi_device'
      76 |                         adev->pld_crc = to_acpi_device_node(fwnode)->pld_crc;
         |                             ^~
   drivers/platform/chrome/cros_ec_typec.c:76:68: error: invalid use of undefined type 'struct acpi_device'
      76 |                         adev->pld_crc = to_acpi_device_node(fwnode)->pld_crc;
         |                                                                    ^~


vim +75 drivers/platform/chrome/cros_ec_typec.c

    23	
    24	#define DP_PORT_VDO	(DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D)) | \
    25					DP_CAP_DFP_D | DP_CAP_RECEPTACLE)
    26	
    27	static int cros_typec_parse_port_props(struct typec_capability *cap,
    28					       struct fwnode_handle *fwnode,
    29					       struct device *dev)
    30	{
    31		struct fwnode_handle *sw_fwnode;
    32		const char *buf;
    33		int ret;
    34	
    35		memset(cap, 0, sizeof(*cap));
    36		ret = fwnode_property_read_string(fwnode, "power-role", &buf);
    37		if (ret) {
    38			dev_err(dev, "power-role not found: %d\n", ret);
    39			return ret;
    40		}
    41	
    42		ret = typec_find_port_power_role(buf);
    43		if (ret < 0)
    44			return ret;
    45		cap->type = ret;
    46	
    47		ret = fwnode_property_read_string(fwnode, "data-role", &buf);
    48		if (ret) {
    49			dev_err(dev, "data-role not found: %d\n", ret);
    50			return ret;
    51		}
    52	
    53		ret = typec_find_port_data_role(buf);
    54		if (ret < 0)
    55			return ret;
    56		cap->data = ret;
    57	
    58		/* Try-power-role is optional. */
    59		ret = fwnode_property_read_string(fwnode, "try-power-role", &buf);
    60		if (ret) {
    61			dev_warn(dev, "try-power-role not found: %d\n", ret);
    62			cap->prefer_role = TYPEC_NO_PREFERRED_ROLE;
    63		} else {
    64			ret = typec_find_power_role(buf);
    65			if (ret < 0)
    66				return ret;
    67			cap->prefer_role = ret;
    68		}
    69	
    70		/* Assing the USB role switch the correct pld_crc if it's missing. */
    71		sw_fwnode = fwnode_find_reference(fwnode, "usb-role-switch", 0);
    72		if (!IS_ERR_OR_NULL(sw_fwnode)) {
    73			struct acpi_device *adev = to_acpi_device_node(sw_fwnode);
    74	
  > 75			if (adev && !adev->pld_crc)
    76				adev->pld_crc = to_acpi_device_node(fwnode)->pld_crc;
    77			fwnode_handle_put(sw_fwnode);
    78		}
    79	
    80		cap->fwnode = fwnode;
    81	
    82		return 0;
    83	}
    84	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

