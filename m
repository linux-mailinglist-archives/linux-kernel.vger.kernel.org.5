Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7626578489D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjHVRny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHVRnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:43:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72968E4A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692726229; x=1724262229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wJtLwBBVNTYvFRL2hNbECv9mDay3Kw7ksqvfKpneZMI=;
  b=ASY1nZQxFSGrUEGEAMEH56B3AwzJLX99XgyL5w/iMzBOT8g7jg360WOK
   wwQSp4nzXl8qFOEByX2tzajVKaXHLPtmGKFa4edET1EPrNn3Pyq+sT7tw
   PRlfJbyYnHfS07Zje3FUnvB++1ojhTs+zxxPUQIjAHgwA8c1FY/K8lj8s
   4/3S7zmwuoVONK1kQI4OhJ1h7qkRpH7FzZrCbrNcL0aqO0z8LCZ5Omuwf
   zZIAtruMQLZjxXMYR87NM3x6wzn8jPst7nu66qMzH460NsWzNu+/uPEHa
   XLWQpU4Glqn0uHLhN9N8hLmdQEHMWR0mcmqmwdZrBgpL7HCrnPSsLQZXd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376687933"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="376687933"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 10:43:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="860014073"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="860014073"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2023 10:43:46 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYVPt-0000No-1j;
        Tue, 22 Aug 2023 17:43:45 +0000
Date:   Wed, 23 Aug 2023 01:43:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Valentine Sinitsyn <valesini@yandex-team.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI: Implement custom llseek for sysfs resource
 entries
Message-ID: <202308230126.O8xXYkdt-lkp@intel.com>
References: <20230822115455.310222-2-valesini@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822115455.310222-2-valesini@yandex-team.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentine,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f7757129e3dea336c407551c98f50057c22bb266]

url:    https://github.com/intel-lab-lkp/linux/commits/Valentine-Sinitsyn/PCI-Implement-custom-llseek-for-sysfs-resource-entries/20230822-205513
base:   f7757129e3dea336c407551c98f50057c22bb266
patch link:    https://lore.kernel.org/r/20230822115455.310222-2-valesini%40yandex-team.ru
patch subject: [PATCH v4 2/2] PCI: Implement custom llseek for sysfs resource entries
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20230823/202308230126.O8xXYkdt-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308230126.O8xXYkdt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308230126.O8xXYkdt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pci-sysfs.c:840:15: warning: 'pci_llseek_resource' used but never defined
     840 | static loff_t pci_llseek_resource(struct file *filep,
         |               ^~~~~~~~~~~~~~~~~~~


vim +/pci_llseek_resource +840 drivers/pci/pci-sysfs.c

   839	
 > 840	static loff_t pci_llseek_resource(struct file *filep,
   841					  struct kobject *kobj,
   842					  struct bin_attribute *attr,
   843					  loff_t offset, int whence);
   844	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
