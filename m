Return-Path: <linux-kernel+bounces-39471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F8783D1AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41FC6B22597
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ED315B7;
	Fri, 26 Jan 2024 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3qDekIx"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF5464C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230172; cv=none; b=SRXxvwmYf1TA9Pj3o66/NeV5KUKi1sB9mSFbgEpH5QfA5ucc8CodObKORotE7ehSHutE0OnT8H9272fEm+ilKEJhIWdEt0QSv5QqkWRs2v8yJrO8Sr3KOjCL/BXvyFfYYhk+wJmsseBDGljDyHepDwiWI5pEcjQZ1InunW52a2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230172; c=relaxed/simple;
	bh=w2kdtJZ783fLiPG5vvC94hf/FSswyEok6jaDZlu5C8U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SKdpDgYgq9jeCtneFUiQfK1uH9VEekMEnCenh6ODUdffUXNhZByMGPv4BiUVwwxEgaGnUqvkcRi1S7Ir03+tYCUkKc4wzVFBv7bpxgY8bnrMut65D1QtIH0QRuA87izOrHdPSwKyZWofo/vWbSsGuShu4DPVBlZz+RbttNF6tjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3qDekIx; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706230170; x=1737766170;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w2kdtJZ783fLiPG5vvC94hf/FSswyEok6jaDZlu5C8U=;
  b=d3qDekIxUhwf7aeQ37w3eF6dk8fE0vV1XlWAtazHlkQU9dCmR+hvHL2O
   8I2m52D7iYXnYTUryc1b1xqZ230ATE7KkvsJRkK+lUN3NmGkTqb/kbB16
   1qtw8Yy0FfSBzmCNYwHX9Nllc5uMssYv0QXx0jW/PVKcq3TQy9cRfS5Oe
   IjNEBQft0dT0xnOMJvidMApoP1xmDZxB9N4oFdDHUWt9yHH0FPWtaYf6f
   /c8DsGsv6LlHxNpiSLZi8U+yRN4hM2NbRQjRKW5UNFRA22dMPct1OZxWd
   5vYkxiTTr9oFHYXe69d69ZVcUtUUMI9ujT6wPpxLC+U/CE/cFcVgVheh5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="433503446"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="433503446"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 16:49:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2523691"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jan 2024 16:49:26 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTAPL-0000X6-32;
	Fri, 26 Jan 2024 00:49:23 +0000
Date: Fri, 26 Jan 2024 08:48:43 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Axtens <dja@axtens.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Francis Laniel <laniel_francis@privacyrequired.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:154:19: warning:
 '%s' directive output may be truncated writing up to 19 bytes into a region
 of size between 13 and 24
Message-ID: <202401260858.jZN6vD1k-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
commit: 6a39e62abbafd1d58d1722f40c7d26ef379c6a2f lib: string.h: detect intra-object overflow in fortified string functions
date:   3 years, 1 month ago
config: x86_64-randconfig-012-20240106 (https://download.01.org/0day-ci/archive/20240126/202401260858.jZN6vD1k-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401260858.jZN6vD1k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401260858.jZN6vD1k-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c: In function 'bnx2x_fill_fw_str':
>> drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:154:19: warning: '%s' directive output may be truncated writing up to 19 bytes into a region of size between 13 and 24 [-Wformat-truncation=]
     154 |     "bc %d.%d.%d%s%s",
         |                   ^~
   ......
     158 |     ((phy_fw_ver[0] != '\0') ? " phy " : ""), phy_fw_ver);
         |                                               ~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:153:3: note: 'snprintf' output between 9 and 39 bytes into a destination of size 32
     153 |   snprintf(buf + strlen(bp->fw_ver), 32 - strlen(bp->fw_ver),
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     154 |     "bc %d.%d.%d%s%s",
         |     ~~~~~~~~~~~~~~~~~~
     155 |     (bp->common.bc_ver & 0xff0000) >> 16,
         |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     156 |     (bp->common.bc_ver & 0xff00) >> 8,
         |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     157 |     (bp->common.bc_ver & 0xff),
         |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~
     158 |     ((phy_fw_ver[0] != '\0') ? " phy " : ""), phy_fw_ver);
         |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +154 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c

b3b83c3f3c640b drivers/net/bnx2x/bnx2x_cmn.c                   Dmitry Kravkov 2011-05-04  135  
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  136  /**
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  137   * bnx2x_fill_fw_str - Fill buffer with FW version string.
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  138   *
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  139   * @bp:        driver handle
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  140   * @buf:       character buffer to fill with the fw name
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  141   * @buf_len:   length of the above buffer
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  142   *
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  143   */
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  144  void bnx2x_fill_fw_str(struct bnx2x *bp, char *buf, size_t buf_len)
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  145  {
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  146  	if (IS_PF(bp)) {
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  147  		u8 phy_fw_ver[PHY_FW_VER_LEN];
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  148  
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  149  		phy_fw_ver[0] = '\0';
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  150  		bnx2x_get_ext_phy_fw_version(&bp->link_params,
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  151  					     phy_fw_ver, PHY_FW_VER_LEN);
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  152  		strlcpy(buf, bp->fw_ver, buf_len);
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  153  		snprintf(buf + strlen(bp->fw_ver), 32 - strlen(bp->fw_ver),
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01 @154  			 "bc %d.%d.%d%s%s",
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  155  			 (bp->common.bc_ver & 0xff0000) >> 16,
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  156  			 (bp->common.bc_ver & 0xff00) >> 8,
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  157  			 (bp->common.bc_ver & 0xff),
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  158  			 ((phy_fw_ver[0] != '\0') ? " phy " : ""), phy_fw_ver);
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  159  	} else {
6411280ac94db9 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-07  160  		bnx2x_vf_fill_fw_str(bp, buf, buf_len);
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  161  	}
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  162  }
8ca5e17e58c953 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c Ariel Elior    2013-01-01  163  

:::::: The code at line 154 was first introduced by commit
:::::: 8ca5e17e58c953b9a9dbd4974c554b25c6d70b1a bnx2x: Support of PF driver of a VF acquire request

:::::: TO: Ariel Elior <ariele@broadcom.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

