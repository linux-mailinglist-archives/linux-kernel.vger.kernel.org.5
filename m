Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247737B971B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjJDWDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjJDWDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:03:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33A6C9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696457015; x=1727993015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sv/X7H2szwBnxMz6Tve4Pf4JohOTSLGbgZlNjApgW6M=;
  b=bM7fiv3OVLk/iHtqeJbdwwvbDXBtB4OiutV9NwYLIG5XuAurNm/1yzp3
   aU/lm4qcnk7N49oEaCw01mxmqSFTSrWcw0szWLX+76herX8J+YGdTr4Al
   +ZZ1mY+3VDVfBGi0MzH5yKM65QgJYaFbGnXwjI4dB3NcprbBBEQ8o5KDm
   ZI9DBE39EgGpWaxeO8iMb3pvJDxMq6jwbxz3SCNk0j4GIxVGclLdNyOu6
   Dwf6TlKVo2VssmlaazxjvxIEhCZIdd0U1Sd8HYnbnxeOIcBsh97ydE8rl
   aH9LNqiXa8y7WOsFFCx3hflpeiIcRSTNq2kUb0678P1F4Jn2dhmkDzLJJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="368380939"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="368380939"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 15:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="817302109"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="817302109"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 04 Oct 2023 15:03:33 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qo9xr-000Keu-1Y;
        Wed, 04 Oct 2023 22:03:31 +0000
Date:   Thu, 5 Oct 2023 06:02:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>, mcgrof@kernel.org,
        russell.h.weight@intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH v2] firmware_loader: Abort new fw load request once
 firmware core knows about reboot
Message-ID: <202310050525.CcwD9rYd-lkp@intel.com>
References: <1696431327-7369-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696431327-7369-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mukesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.6-rc4 next-20231004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-Ojha/firmware_loader-Abort-new-fw-load-request-once-firmware-core-knows-about-reboot/20231004-225910
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/1696431327-7369-1-git-send-email-quic_mojha%40quicinc.com
patch subject: [PATCH v2] firmware_loader: Abort new fw load request once firmware core knows about reboot
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231005/202310050525.CcwD9rYd-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310050525.CcwD9rYd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310050525.CcwD9rYd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/base/firmware_loader/fallback.h:9,
                    from drivers/base/firmware_loader/fallback.c:11:
   drivers/base/firmware_loader/sysfs.h:87:20: error: 'fw_load_abort' redeclared as different kind of symbol
      87 | static inline void fw_load_abort(struct fw_sysfs *fw_sysfs)
         |                    ^~~~~~~~~~~~~
   In file included from drivers/base/firmware_loader/fallback.h:8:
   drivers/base/firmware_loader/firmware.h:89:13: note: previous declaration of 'fw_load_abort' with type 'bool' {aka '_Bool'}
      89 | extern bool fw_load_abort;
         |             ^~~~~~~~~~~~~
   drivers/base/firmware_loader/fallback.c: In function 'kill_pending_fw_fallback_reqs':
   drivers/base/firmware_loader/fallback.c:62:31: error: lvalue required as left operand of assignment
      62 |                 fw_load_abort = true;
         |                               ^
   drivers/base/firmware_loader/fallback.c: In function 'fw_load_sysfs_fallback':
>> drivers/base/firmware_loader/fallback.c:93:13: warning: the address of 'fw_load_abort' will always evaluate as 'true' [-Waddress]
      93 |         if (fw_load_abort || fw_state_is_aborted(fw_priv)) {
         |             ^~~~~~~~~~~~~


vim +93 drivers/base/firmware_loader/fallback.c

    66	
    67	/**
    68	 * fw_load_sysfs_fallback() - load a firmware via the sysfs fallback mechanism
    69	 * @fw_sysfs: firmware sysfs information for the firmware to load
    70	 * @timeout: timeout to wait for the load
    71	 *
    72	 * In charge of constructing a sysfs fallback interface for firmware loading.
    73	 **/
    74	static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
    75	{
    76		int retval = 0;
    77		struct device *f_dev = &fw_sysfs->dev;
    78		struct fw_priv *fw_priv = fw_sysfs->fw_priv;
    79	
    80		/* fall back on userspace loading */
    81		if (!fw_priv->data)
    82			fw_priv->is_paged_buf = true;
    83	
    84		dev_set_uevent_suppress(f_dev, true);
    85	
    86		retval = device_add(f_dev);
    87		if (retval) {
    88			dev_err(f_dev, "%s: device_register failed\n", __func__);
    89			goto err_put_dev;
    90		}
    91	
    92		mutex_lock(&fw_lock);
  > 93		if (fw_load_abort || fw_state_is_aborted(fw_priv)) {
    94			mutex_unlock(&fw_lock);
    95			retval = -EINTR;
    96			goto out;
    97		}
    98		list_add(&fw_priv->pending_list, &pending_fw_head);
    99		mutex_unlock(&fw_lock);
   100	
   101		if (fw_priv->opt_flags & FW_OPT_UEVENT) {
   102			fw_priv->need_uevent = true;
   103			dev_set_uevent_suppress(f_dev, false);
   104			dev_dbg(f_dev, "firmware: requesting %s\n", fw_priv->fw_name);
   105			kobject_uevent(&fw_sysfs->dev.kobj, KOBJ_ADD);
   106		} else {
   107			timeout = MAX_JIFFY_OFFSET;
   108		}
   109	
   110		retval = fw_sysfs_wait_timeout(fw_priv, timeout);
   111		if (retval < 0 && retval != -ENOENT) {
   112			mutex_lock(&fw_lock);
   113			fw_load_abort(fw_sysfs);
   114			mutex_unlock(&fw_lock);
   115		}
   116	
   117		if (fw_state_is_aborted(fw_priv)) {
   118			if (retval == -ERESTARTSYS)
   119				retval = -EINTR;
   120		} else if (fw_priv->is_paged_buf && !fw_priv->data)
   121			retval = -ENOMEM;
   122	
   123	out:
   124		device_del(f_dev);
   125	err_put_dev:
   126		put_device(f_dev);
   127		return retval;
   128	}
   129	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
