Return-Path: <linux-kernel+bounces-37937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3FB83B881
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E822286A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB7F7489;
	Thu, 25 Jan 2024 03:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/Nfc4i6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F127460
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706154806; cv=none; b=KCWYdKfZlORxbMTqZ2ekU8d2zo/4v71uMxFkDCxgth3ikFnZUEsjkC8PomC2JmrYVs4KKyFLSWY8GnfacReFbuCyM6aK0E2WoIO1P01NCXmsEqzWS7qU2SkaS+VsGOa4RiXHl2HYBNllEgT7meMiDF274aNTQfEN/p6BEtX4TpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706154806; c=relaxed/simple;
	bh=I9ja1IXAiRS6A2rpBSIyKS80ljGj7wfMl4Jaq5XLijc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PtawQO1lpvrjqSmh9iCxSL9lHTKWxNPrW2MFN428wtnOrxU16aiqjQnMcFV0VcRlJmLJVwzOKm/XNwoUfPjoHfNohnSDU6PS6WpBrhnV+rDZEV8679DzR9dRzAL8bwhd6775cQQW7LORuNqSa1uBsUqIfyYzsmJVgmqwIO8AeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/Nfc4i6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706154805; x=1737690805;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I9ja1IXAiRS6A2rpBSIyKS80ljGj7wfMl4Jaq5XLijc=;
  b=U/Nfc4i64OpCt8c90tyITqlXL6Y8djXN/JS1/82elvGo+ZXuIPfo4hTQ
   dsw27UTukKlZ5MjEp1GIZBFbeb8WN712OirGf+YWhHgDHGzLkSJtFpyjj
   nfI0dFj0OnLPcERLL+88YGcu03ku2HTMagxSMqpb4tIVmwosziZEq8+G5
   bqG8Mu4qAOo88ICr5QqOO28BgVYpadrLYBp3QLwBZ69mYebiP+hv9r6sG
   rmwrqdacyYISlKvt3xxLC2tp/d+RderoJCbOLCNowzSqyKGuicpRPwrZd
   oz1rt++x3EsmT188vYH9Dwi1yjuvk/ZdqULewYVFrKv31r1MTTY+OBe6A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9163015"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9163015"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 19:53:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="959731348"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="959731348"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2024 19:53:22 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSqno-0008dd-1S;
	Thu, 25 Jan 2024 03:53:20 +0000
Date: Thu, 25 Jan 2024 11:52:41 +0800
From: kernel test robot <lkp@intel.com>
To: Eddie James <eajames@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: drivers/hwmon/pmbus/ibm-cffps.c:184:60: warning: '%04X' directive
 output may be truncated writing between 4 and 8 bytes into a region of size
 5
Message-ID: <202401251132.8DpJ7Stv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Eddie,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6098d87eaf31f48153c984e2adadf14762520a87
commit: 2f8a855efe8a6faf962c53af406e5ea4791b3877 pmbus: (ibm-cffps) Add support for version 2 of the PSU
date:   4 years, 5 months ago
config: x86_64-randconfig-006-20240105 (https://download.01.org/0day-ci/archive/20240125/202401251132.8DpJ7Stv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240125/202401251132.8DpJ7Stv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401251132.8DpJ7Stv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwmon/pmbus/ibm-cffps.c: In function 'ibm_cffps_debugfs_op':
   drivers/hwmon/pmbus/ibm-cffps.c:171:60: warning: '%02X' directive output may be truncated writing between 2 and 8 bytes into a region of size 3 [-Wformat-truncation=]
     171 |                                 snprintf(&data[i * 2], 3, "%02X", rc);
         |                                                            ^~~~
   drivers/hwmon/pmbus/ibm-cffps.c:171:59: note: directive argument in the range [0, 2147483647]
     171 |                                 snprintf(&data[i * 2], 3, "%02X", rc);
         |                                                           ^~~~~~
   drivers/hwmon/pmbus/ibm-cffps.c:171:33: note: 'snprintf' output between 3 and 9 bytes into a destination of size 3
     171 |                                 snprintf(&data[i * 2], 3, "%02X", rc);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hwmon/pmbus/ibm-cffps.c:184:60: warning: '%04X' directive output may be truncated writing between 4 and 8 bytes into a region of size 5 [-Wformat-truncation=]
     184 |                                 snprintf(&data[i * 4], 5, "%04X", rc);
         |                                                            ^~~~
   drivers/hwmon/pmbus/ibm-cffps.c:184:59: note: directive argument in the range [0, 2147483647]
     184 |                                 snprintf(&data[i * 4], 5, "%04X", rc);
         |                                                           ^~~~~~
   drivers/hwmon/pmbus/ibm-cffps.c:184:33: note: 'snprintf' output between 5 and 9 bytes into a destination of size 5
     184 |                                 snprintf(&data[i * 4], 5, "%04X", rc);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +184 drivers/hwmon/pmbus/ibm-cffps.c

   129	
   130	static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
   131					    size_t count, loff_t *ppos)
   132	{
   133		u8 cmd;
   134		int i, rc;
   135		int *idxp = file->private_data;
   136		int idx = *idxp;
   137		struct ibm_cffps *psu = to_psu(idxp, idx);
   138		char data[I2C_SMBUS_BLOCK_MAX] = { 0 };
   139	
   140		pmbus_set_page(psu->client, 0);
   141	
   142		switch (idx) {
   143		case CFFPS_DEBUGFS_INPUT_HISTORY:
   144			return ibm_cffps_read_input_history(psu, buf, count, ppos);
   145		case CFFPS_DEBUGFS_FRU:
   146			cmd = CFFPS_FRU_CMD;
   147			break;
   148		case CFFPS_DEBUGFS_PN:
   149			cmd = CFFPS_PN_CMD;
   150			break;
   151		case CFFPS_DEBUGFS_SN:
   152			cmd = CFFPS_SN_CMD;
   153			break;
   154		case CFFPS_DEBUGFS_CCIN:
   155			rc = i2c_smbus_read_word_swapped(psu->client, CFFPS_CCIN_CMD);
   156			if (rc < 0)
   157				return rc;
   158	
   159			rc = snprintf(data, 5, "%04X", rc);
   160			goto done;
   161		case CFFPS_DEBUGFS_FW:
   162			switch (psu->version) {
   163			case cffps1:
   164				for (i = 0; i < CFFPS1_FW_NUM_BYTES; ++i) {
   165					rc = i2c_smbus_read_byte_data(psu->client,
   166								      CFFPS_FW_CMD +
   167									i);
   168					if (rc < 0)
   169						return rc;
   170	
   171					snprintf(&data[i * 2], 3, "%02X", rc);
   172				}
   173	
   174				rc = i * 2;
   175				break;
   176			case cffps2:
   177				for (i = 0; i < CFFPS2_FW_NUM_WORDS; ++i) {
   178					rc = i2c_smbus_read_word_data(psu->client,
   179								      CFFPS_FW_CMD +
   180									i);
   181					if (rc < 0)
   182						return rc;
   183	
 > 184					snprintf(&data[i * 4], 5, "%04X", rc);
   185				}
   186	
   187				rc = i * 4;
   188				break;
   189			default:
   190				return -EOPNOTSUPP;
   191			}
   192			goto done;
   193		default:
   194			return -EINVAL;
   195		}
   196	
   197		rc = i2c_smbus_read_block_data(psu->client, cmd, data);
   198		if (rc < 0)
   199			return rc;
   200	
   201	done:
   202		data[rc] = '\n';
   203		rc += 2;
   204	
   205		return simple_read_from_buffer(buf, count, ppos, data, rc);
   206	}
   207	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

