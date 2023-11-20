Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CA37F1801
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjKTP7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjKTP7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:59:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9396E7;
        Mon, 20 Nov 2023 07:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700495981; x=1732031981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c37jWWF3YmwNSdX2aaWvfipjGhewd5sxL8oMjg89X1s=;
  b=ZYi81cPslsFQBJeWSR30dxOG4u3D0h904i6lHOBn1NB3GSqH2LcUTJp/
   EAhpvkQHeiFNi2KupGh/mQZMKU7o8s9NphRw6iDEnsEbaekdz9QlnyC6o
   4tLb/sDjGpnBF8hlCzBm8wPKbWDaja8BaPAtNp4TuzwKuMyimaQZqibYV
   Gusj2Tw9j1RXHtj7PjiQUwbV5C7TyC6vKEecx79LGq7cVsX3OYGAlg6P3
   GShnFE+tdLgjarlXdiNYIC34X5IwWrdQf9OrRELk1yazXYjWCP4kl+Loc
   k4dRJFWQPi6PazRs4bHXsDu8kynTbMYeXgOAltZ2D5KTYp6I9wYg80Qjl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="455972517"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="455972517"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 07:59:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="759816709"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="759816709"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Nov 2023 07:59:16 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r56g5-0006cK-32;
        Mon, 20 Nov 2023 15:59:13 +0000
Date:   Mon, 20 Nov 2023 23:58:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Raag Jadav <raag.jadav@intel.com>, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com, ardb@kernel.org,
        will@kernel.org, mark.rutland@arm.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1 3/6] ACPI: bus: update acpi_dev_hid_uid_match() to
 support multiple types
Message-ID: <202311202353.O38sik0Y-lkp@intel.com>
References: <20231120120837.3002-4-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120120837.3002-4-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raag,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5bd262f4820f2d5645d8ff1f251ef8e96715ef84]

url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/compiler-h-Introduce-helpers-for-identifying-array-and-pointer-types/20231120-201140
base:   5bd262f4820f2d5645d8ff1f251ef8e96715ef84
patch link:    https://lore.kernel.org/r/20231120120837.3002-4-raag.jadav%40intel.com
patch subject: [PATCH v1 3/6] ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20231120/202311202353.O38sik0Y-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311202353.O38sik0Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311202353.O38sik0Y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/acpi.h:45,
                    from drivers/iommu/amd/iommu.c:13:
   drivers/iommu/amd/iommu.c: In function 'get_acpihid_device_id':
>> drivers/iommu/amd/iommu.c:103:63: warning: pointer/integer type mismatch in conditional expression
     103 |                                            p->uid[0] ? p->uid : NULL)) {
         |                                                               ^
   include/acpi/acpi_bus.h:915:46: note: in definition of macro 'acpi_dev_hid_uid_match'
     915 |         (acpi_dev_hid_match(adev, hid2) && (!uid2 || acpi_dev_uid_match(adev, uid2)))
         |                                              ^~~~


vim +103 drivers/iommu/amd/iommu.c

81cd07b9c92ad4 drivers/iommu/amd_iommu.c   Joerg Roedel    2016-07-07   85  
15898bbcb48fc8 arch/x86/kernel/amd_iommu.c Joerg Roedel    2009-11-24   86  /****************************************************************************
15898bbcb48fc8 arch/x86/kernel/amd_iommu.c Joerg Roedel    2009-11-24   87   *
15898bbcb48fc8 arch/x86/kernel/amd_iommu.c Joerg Roedel    2009-11-24   88   * Helper functions
15898bbcb48fc8 arch/x86/kernel/amd_iommu.c Joerg Roedel    2009-11-24   89   *
15898bbcb48fc8 arch/x86/kernel/amd_iommu.c Joerg Roedel    2009-11-24   90   ****************************************************************************/
15898bbcb48fc8 arch/x86/kernel/amd_iommu.c Joerg Roedel    2009-11-24   91  
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01   92  static inline int get_acpihid_device_id(struct device *dev,
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01   93  					struct acpihid_map_entry **entry)
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01   94  {
ae5e6c6439c3d0 drivers/iommu/amd_iommu.c   Andy Shevchenko 2019-10-01   95  	struct acpi_device *adev = ACPI_COMPANION(dev);
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01   96  	struct acpihid_map_entry *p;
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01   97  
ae5e6c6439c3d0 drivers/iommu/amd_iommu.c   Andy Shevchenko 2019-10-01   98  	if (!adev)
ae5e6c6439c3d0 drivers/iommu/amd_iommu.c   Andy Shevchenko 2019-10-01   99  		return -ENODEV;
ae5e6c6439c3d0 drivers/iommu/amd_iommu.c   Andy Shevchenko 2019-10-01  100  
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01  101  	list_for_each_entry(p, &acpihid_map, list) {
ea90228c7b2ae6 drivers/iommu/amd_iommu.c   Raul E Rangel   2020-05-11  102  		if (acpi_dev_hid_uid_match(adev, p->hid,
ea90228c7b2ae6 drivers/iommu/amd_iommu.c   Raul E Rangel   2020-05-11 @103  					   p->uid[0] ? p->uid : NULL)) {
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01  104  			if (entry)
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01  105  				*entry = p;
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01  106  			return p->devid;
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01  107  		}
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01  108  	}
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01  109  	return -EINVAL;
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01  110  }
2bf9a0a12749b2 drivers/iommu/amd_iommu.c   Wan Zongshun    2016-04-01  111  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
