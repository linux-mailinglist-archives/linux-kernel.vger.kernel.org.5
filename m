Return-Path: <linux-kernel+bounces-57274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A632484D60B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B19289245
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC90A1EB2B;
	Wed,  7 Feb 2024 22:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bx4B6DK9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314A0200D8;
	Wed,  7 Feb 2024 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346404; cv=none; b=PeObR9UAGj2nJGwHdbLV4GFEKXf7TuWuQPrGkEV3Nos7B/GLC/zyIKuVAfePeftZayATHJq9dbF86Fjj5vr8U1rF2CXy7QY1YG8J9nKCr9UcN/y9wa71UthrF3K76h+bq/n4IiIqIcIHl3zRPJq+B5WZ1S5xRWE8Vn/szC6I12o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346404; c=relaxed/simple;
	bh=nmb2k3C9v+KzAmt2g3cPPXFlei6g+FVLekXJpHiBpLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NS/JFQWxsk2zCAxt6XubWZepqLaZht/c6YuBXEJp6nbzfedrPLvhovpemA6pmB2WtgX1QJPok2g6TYkmjck/bVJdPiKM+CtXb5Vonqorb40Q0xjfCRb0uE/kAbOR5FSV4afj8n76bRmEjrPdptCdiIvpkj8j2EWlNe3JOREaZvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bx4B6DK9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707346402; x=1738882402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nmb2k3C9v+KzAmt2g3cPPXFlei6g+FVLekXJpHiBpLI=;
  b=bx4B6DK9cAZW4NeoF+ZNq8KkKYJ3r2FMD0aBkRwCc2B1aWPSVjA+ZvKd
   s3QrytosAXeEXwP2ZGQv343c2wAx+rgMqjo9C26yIUtfba+FtLwi0YIOv
   aOg6mpKde7VbQph7Xsq/1YZURkXMOVd5muoCEn2LaPbinsFIamFGadqkg
   lS42kimccj4seghVoD9kT7k/3aAsliinV2m1TjKOkbxe0Y5F9B7l4gr/+
   3GMO3QFSwEjozigOcpw6k+lMLefVF4apNqF938XPDtWYC8x8VJcBUQiZR
   3Kizc/Yr9VaEmPxobF9/Ly7rSmHInMW0dQno7FTUclPc+Xb3NhZNHiWXq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12467562"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12467562"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 14:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1494186"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Feb 2024 14:53:17 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXqn3-000376-2u;
	Wed, 07 Feb 2024 22:53:13 +0000
Date: Thu, 8 Feb 2024 06:52:42 +0800
From: kernel test robot <lkp@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Prashant Malani <pmalani@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Benson Leung <bleung@chromium.org>,
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
Message-ID: <202402080600.zOq5UvYq-lkp@intel.com>
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240208/202402080600.zOq5UvYq-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240208/202402080600.zOq5UvYq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402080600.zOq5UvYq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/chrome/cros_ec_typec.c:75:20: error: incomplete definition of type 'struct acpi_device'
                   if (adev && !adev->pld_crc)
                                ~~~~^
   include/linux/acpi.h:795:8: note: forward declaration of 'struct acpi_device'
   struct acpi_device;
          ^
   drivers/platform/chrome/cros_ec_typec.c:76:8: error: incomplete definition of type 'struct acpi_device'
                           adev->pld_crc = to_acpi_device_node(fwnode)->pld_crc;
                           ~~~~^
   include/linux/acpi.h:795:8: note: forward declaration of 'struct acpi_device'
   struct acpi_device;
          ^
   drivers/platform/chrome/cros_ec_typec.c:76:47: error: incomplete definition of type 'struct acpi_device'
                           adev->pld_crc = to_acpi_device_node(fwnode)->pld_crc;
                                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
   include/linux/acpi.h:795:8: note: forward declaration of 'struct acpi_device'
   struct acpi_device;
          ^
   3 errors generated.


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

