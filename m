Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F5A7B99D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244442AbjJEByq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243717AbjJEByp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:54:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EF4F0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696470881; x=1728006881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LsWZoE9GZIZHN47RtnN7750QQphkpmCgZgeeZiPTjbw=;
  b=W+0hp0XW6YD4dcHB0rXX05x6IdLBkKjhtYzdtH8So7zs9QLVj8PqFCcl
   aMo8bPfMFkTfwiPMy75IyMR4mwDYij55jU+w5QzIjwDOvkP+mkJVnOkD3
   ss087eZuG939V/i9SoaBGUTavvxl3fW3zgJZnS1oKGl9GWWYZtBgbBjvJ
   Ye5JZ8zJWnKRJJA1UAtMcUoAcNBM7sKaEX1EM+gjzyZV1cdqktnTsYeKA
   67PQlrmmhxjtelWxyczN8V78w40nj/tLBM13y49KHpIu/kguU6DXer84R
   QS9AebnfuJoGhK4p1OfsDHM/5B6xXRrpE6LBMOoiSPtFu2PGfmlENLkhp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="4933798"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="4933798"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 18:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="781046521"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="781046521"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 04 Oct 2023 18:54:37 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoDZS-000KrU-2e;
        Thu, 05 Oct 2023 01:54:34 +0000
Date:   Thu, 5 Oct 2023 09:53:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>, mcgrof@kernel.org,
        russell.h.weight@intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH v2] firmware_loader: Abort new fw load request once
 firmware core knows about reboot
Message-ID: <202310050911.UHh53hem-lkp@intel.com>
References: <1696431327-7369-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696431327-7369-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mukesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.6-rc4 next-20231004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-Ojha/firmware_loader-Abort-new-fw-load-request-once-firmware-core-knows-about-reboot/20231004-225910
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/1696431327-7369-1-git-send-email-quic_mojha%40quicinc.com
patch subject: [PATCH v2] firmware_loader: Abort new fw load request once firmware core knows about reboot
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231005/202310050911.UHh53hem-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310050911.UHh53hem-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310050911.UHh53hem-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/base/firmware_loader/fallback.c:11:
   In file included from drivers/base/firmware_loader/fallback.h:9:
   drivers/base/firmware_loader/sysfs.h:87:20: error: redefinition of 'fw_load_abort' as different kind of symbol
   static inline void fw_load_abort(struct fw_sysfs *fw_sysfs)
                      ^
   drivers/base/firmware_loader/firmware.h:89:13: note: previous definition is here
   extern bool fw_load_abort;
               ^
>> drivers/base/firmware_loader/fallback.c:113:16: error: called object type 'bool' (aka '_Bool') is not a function or function pointer
                   fw_load_abort(fw_sysfs);
                   ~~~~~~~~~~~~~^
   2 errors generated.
--
   In file included from drivers/base/firmware_loader/sysfs.c:9:
   drivers/base/firmware_loader/sysfs.h:87:20: error: redefinition of 'fw_load_abort' as different kind of symbol
   static inline void fw_load_abort(struct fw_sysfs *fw_sysfs)
                      ^
   drivers/base/firmware_loader/firmware.h:89:13: note: previous definition is here
   extern bool fw_load_abort;
               ^
>> drivers/base/firmware_loader/sysfs.c:218:16: error: called object type 'bool' (aka '_Bool') is not a function or function pointer
                   fw_load_abort(fw_sysfs);
                   ~~~~~~~~~~~~~^
   drivers/base/firmware_loader/sysfs.c:302:16: error: called object type 'bool' (aka '_Bool') is not a function or function pointer
                   fw_load_abort(fw_sysfs);
                   ~~~~~~~~~~~~~^
   3 errors generated.


vim +113 drivers/base/firmware_loader/fallback.c

d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   66  
60fa74263cbeae1 drivers/base/firmware_loader/fallback.c Luis R. Rodriguez  2018-03-10   67  /**
c35f9cbb1df8f17 drivers/base/firmware_loader/fallback.c Andres Rodriguez   2018-05-10   68   * fw_load_sysfs_fallback() - load a firmware via the sysfs fallback mechanism
b93815d0f37e7c4 drivers/base/firmware_loader/fallback.c Andres Rodriguez   2018-04-25   69   * @fw_sysfs: firmware sysfs information for the firmware to load
60fa74263cbeae1 drivers/base/firmware_loader/fallback.c Luis R. Rodriguez  2018-03-10   70   * @timeout: timeout to wait for the load
60fa74263cbeae1 drivers/base/firmware_loader/fallback.c Luis R. Rodriguez  2018-03-10   71   *
60fa74263cbeae1 drivers/base/firmware_loader/fallback.c Luis R. Rodriguez  2018-03-10   72   * In charge of constructing a sysfs fallback interface for firmware loading.
60fa74263cbeae1 drivers/base/firmware_loader/fallback.c Luis R. Rodriguez  2018-03-10   73   **/
89287c169f8ff79 drivers/base/firmware_loader/fallback.c Kees Cook          2020-10-02   74  static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   75  {
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   76  	int retval = 0;
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   77  	struct device *f_dev = &fw_sysfs->dev;
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   78  	struct fw_priv *fw_priv = fw_sysfs->fw_priv;
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   79  
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   80  	/* fall back on userspace loading */
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   81  	if (!fw_priv->data)
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   82  		fw_priv->is_paged_buf = true;
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   83  
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   84  	dev_set_uevent_suppress(f_dev, true);
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   85  
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   86  	retval = device_add(f_dev);
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   87  	if (retval) {
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   88  		dev_err(f_dev, "%s: device_register failed\n", __func__);
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   89  		goto err_put_dev;
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   90  	}
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   91  
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   92  	mutex_lock(&fw_lock);
b30557dae4a363d drivers/base/firmware_loader/fallback.c Mukesh Ojha        2023-10-04   93  	if (fw_load_abort || fw_state_is_aborted(fw_priv)) {
75d95e2e39b27f7 drivers/base/firmware_loader/fallback.c Anirudh Rayabharam 2021-07-28   94  		mutex_unlock(&fw_lock);
75d95e2e39b27f7 drivers/base/firmware_loader/fallback.c Anirudh Rayabharam 2021-07-28   95  		retval = -EINTR;
75d95e2e39b27f7 drivers/base/firmware_loader/fallback.c Anirudh Rayabharam 2021-07-28   96  		goto out;
75d95e2e39b27f7 drivers/base/firmware_loader/fallback.c Anirudh Rayabharam 2021-07-28   97  	}
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   98  	list_add(&fw_priv->pending_list, &pending_fw_head);
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10   99  	mutex_unlock(&fw_lock);
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  100  
89287c169f8ff79 drivers/base/firmware_loader/fallback.c Kees Cook          2020-10-02  101  	if (fw_priv->opt_flags & FW_OPT_UEVENT) {
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  102  		fw_priv->need_uevent = true;
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  103  		dev_set_uevent_suppress(f_dev, false);
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  104  		dev_dbg(f_dev, "firmware: requesting %s\n", fw_priv->fw_name);
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  105  		kobject_uevent(&fw_sysfs->dev.kobj, KOBJ_ADD);
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  106  	} else {
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  107  		timeout = MAX_JIFFY_OFFSET;
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  108  	}
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  109  
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  110  	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
bcfbd3523f3c6ee drivers/base/firmware_loader/fallback.c Junyong Sun        2020-03-03  111  	if (retval < 0 && retval != -ENOENT) {
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  112  		mutex_lock(&fw_lock);
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10 @113  		fw_load_abort(fw_sysfs);
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  114  		mutex_unlock(&fw_lock);
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  115  	}
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  116  
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  117  	if (fw_state_is_aborted(fw_priv)) {
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  118  		if (retval == -ERESTARTSYS)
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  119  			retval = -EINTR;
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  120  	} else if (fw_priv->is_paged_buf && !fw_priv->data)
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  121  		retval = -ENOMEM;
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  122  
75d95e2e39b27f7 drivers/base/firmware_loader/fallback.c Anirudh Rayabharam 2021-07-28  123  out:
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  124  	device_del(f_dev);
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  125  err_put_dev:
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  126  	put_device(f_dev);
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  127  	return retval;
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  128  }
d73f821c7aea16a drivers/base/firmware_fallback.c        Luis R. Rodriguez  2018-03-10  129  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
