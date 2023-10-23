Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203167D300C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjJWKfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjJWKfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:35:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2693FD6E;
        Mon, 23 Oct 2023 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698057349; x=1729593349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hcyNvUgQiaQ72XY6XCfmfDq1LmiwOA/3EPhPZPeidk8=;
  b=n3yviCV/S6HkEzA1a5rmMju0LQTx3gIXviXzqDa1I+fP8SI8yU+eKIUw
   4Bpwdqy5p+baM+0TJSsRr8/3bCTW74E/aDM/3lssDU/dBCApa0uj84CgK
   povR6+319XZJtUCX9TK6TgfeggvA9aTxSTPAbfMJdCVQGcS87XFjjxsN0
   Jzs6FwQswzrXFEc9RoDPLn3wYS3T4UbB/VAZzIhEPKitXyqJKjjrnQ33y
   e+wjEfGQoqxnnV0iUpdiaVb5wY70yc//h9HWg+gkcBj7AaW80LDWMd1dc
   SoSDrmuSfw6d7qba/FOgzM5NNDE/kawML231HDMUn9kHGrHalAps+/mOs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="453280620"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="453280620"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 03:35:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="793083978"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="793083978"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Oct 2023 03:35:47 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qusHg-0006or-2Y;
        Mon, 23 Oct 2023 10:35:44 +0000
Date:   Mon, 23 Oct 2023 18:35:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Hilliard <james.hilliard1@gmail.com>,
        linux-input@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        James Hilliard <james.hilliard1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: cyttsp5 - improve error handling and remove regmap
Message-ID: <202310231838.JHHtGKmB-lkp@intel.com>
References: <20231023085234.105572-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023085234.105572-1-james.hilliard1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus hid/for-next linus/master v6.6-rc7 next-20231023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Hilliard/Input-cyttsp5-improve-error-handling-and-remove-regmap/20231023-165327
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20231023085234.105572-1-james.hilliard1%40gmail.com
patch subject: [PATCH] Input: cyttsp5 - improve error handling and remove regmap
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231023/202310231838.JHHtGKmB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231023/202310231838.JHHtGKmB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310231838.JHHtGKmB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/input/touchscreen/cyttsp5.c: In function 'cyttsp5_get_hid_descriptor':
>> drivers/input/touchscreen/cyttsp5.c:684:22: warning: unused variable 'reg' [-Wunused-variable]
     684 |         unsigned int reg = HID_DESC_REG;
         |                      ^~~


vim +/reg +684 drivers/input/touchscreen/cyttsp5.c

   677	
   678	static int cyttsp5_get_hid_descriptor(struct cyttsp5 *ts,
   679					      struct cyttsp5_hid_desc *desc)
   680	{
   681		struct device *dev = ts->dev;
   682		u8 cmd[2] = { 0 };
   683		int rc;
 > 684		unsigned int reg = HID_DESC_REG;
   685	
   686		put_unaligned_le16(HID_DESC_REG, cmd);
   687	
   688		rc = cyttsp5_write(ts, HID_DESC_REG, cmd, 2);
   689		if (rc) {
   690			dev_err(dev, "Failed to get HID descriptor, rc=%d\n", rc);
   691			return rc;
   692		}
   693	
   694		rc = wait_for_completion_interruptible_timeout(&ts->cmd_done,
   695				msecs_to_jiffies(CY_HID_GET_HID_DESCRIPTOR_TIMEOUT_MS));
   696		if (rc <= 0) {
   697			dev_err(ts->dev, "HID get descriptor timed out\n");
   698			rc = -ETIMEDOUT;
   699			return rc;
   700		}
   701	
   702		memcpy(desc, ts->response_buf, sizeof(*desc));
   703	
   704		/* Check HID descriptor length and version */
   705		if (le16_to_cpu(desc->hid_desc_len) != sizeof(*desc) ||
   706		    le16_to_cpu(desc->bcd_version) != HID_VERSION) {
   707			dev_err(dev, "Unsupported HID version\n");
   708			return -ENODEV;
   709		}
   710	
   711		return 0;
   712	}
   713	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
